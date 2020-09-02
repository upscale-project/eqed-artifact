#!/usr/bin/env perl

use strict;
use warnings;
use Verilog::Netlist;
use Getopt::Long;

# read in file with list all flipflops in the design
my $fflist = '';
# read the top module
my $top = '';
my $list = '';
my $directory = '';
my $outdirectory = '';

GetOptions ('fflist=s' => \$fflist, 'top=s' => \$top, 'list=s' => \$list, 'directory=s' => \$directory, 'outdirectory=s' => \$outdirectory);

# Setup options so files can be found (from: Esingh - parse-hierarchy.pl)
use Verilog::Getopt;
my $opt = new Verilog::Getopt;
$opt->parameter( "+incdir+",$directory,
                 "-f",$list,
                 "-y",$directory,
               );

# prepare netlist (from Esingh - parse-hierarchy.pl)
my $nl = new Verilog::Netlist (options => $opt,link_read_nonfatal => 1);

foreach my $file ($top) {
        #print"adding $file\n";
   $nl->read_file (filename=>$file);
}

# read in any sub modules
$nl->link();
$nl->lint();
$nl->exit_if_error();

open (INFO, $fflist) or die "Could not open file '$fflist': $!";
foreach my $line (<INFO>) {
    # The name of the flipflop list indicates the
    # cell name of each module hierarchy in the
    # path to the flipflop. Cell names are thus
    # separated for processing. 
    # -----------------------------------------
    # Here I am assuming this format of flipflop
    # name in the fflist:
    # top_mod_name.next_mod_name.next_name.flipflopname.signal_name[bits]
    my @module_list = split(/\./,$line);
    my $size = @module_list;
    
    # check if top module of the flip flop matches
    # the top module file indicated by user. Assuming
    # the name of the top module is the same. If
    # the top module does not match then throw an 
    # error message and skip the current flip flop
    # (a mux is not added).
    my $ff_top = $module_list[0];
    my @all_mod = $nl->modules_sorted_level();
    my $list_size = @all_mod;
    my $top_mod = $all_mod[$list_size-1]->name();
    if ($top_mod ne $ff_top) {
        print "Cannot find module containing flip flop: $line \n";
        next;
    }

    # create an array of modules from top level to
    # lowest level for each flip flop.
    # While parsing the module hierarchy, if one
    # module is not found, then break the process
    # and throw an error message and skips that
    # flipflop (mux is not added).
    my @mod_hier = ("$ff_top");
    for (my $i = 1; $i < ($size-1); $i++) {
        my $cur_cell = $module_list[$i];
        my $cur_hier = get_mod($cur_cell, $nl);
        if ($cur_hier eq "") {
            $mod_hier[0] = "";
            last;
        }
        push(@mod_hier, $cur_hier);
    }
    if ($mod_hier[0] eq "") {
        print "Cannot find module containing flip flop: $line \n";
        next;
    } 

    # add in a mux to the input signal 'd' of the
    # flip flop. This is assuming that the input of
    # the flip flops are denoted by 'd'. If it is
    # not the function add_mux does not add a mux
    # to that flipflop and throws a warning message.
    # ---------------------------------------------
    # add_mux arguments:
    # One input to the function add_mux is whether
    # it is single bit or not. If it is single bit,
    # then a 1 is used, else a 0 is used.
    # ---------------------------------------------
    # Here I am assuming that multi bit flipflop 
    # names contain square brackets that indicate
    # the bit it is referring to. 
    # e.g. top.next.last.ff.q[0] -> for multi bits
    #      top.next.single.bit.ff.q -> for single bit
    my $mux_pin = $module_list[$size-1];
    my @pin_bits = split(/\[/,$mux_pin);
    my $pin_namesz = @pin_bits;
    if ($pin_namesz == 1) {
        add_mux('d', \@mod_hier, $nl, \@module_list, $line, $outdirectory, 1);
    } else {
        add_mux('d', \@mod_hier, $nl, \@module_list, $line, $outdirectory, 0);
    }

    print "\n";
}
close INFO;


sub add_mux {
    my $mux_pin = shift;
    my $mod_hier_ptr = shift;
    my @mod_hier = @$mod_hier_ptr;
    my $nl = shift;
    my $module_list_ptr = shift;
    my @module_list = @$module_list_ptr;
    my $ffline = shift;
    my $outdirectory = shift;
    my $is_single = shift;

    # takes in list of modules and add in a mux
    # to the lowest level at the pin indicated
    # by $mux_pin. Then hook up the select signal
    # up through the hierarchy using the module
    # list. The code with the added mux and select
    # signals are stored in a copy of the original
    # file.

    my $list_sz = @module_list;
    my $mod_hiersz = @mod_hier;
    my $lowest_mod_name = $mod_hier[$mod_hiersz-2];
    my $lowest_cell_name = $module_list[$list_sz-2];
    my $lowest_mod = $nl->find_module($lowest_mod_name);

    # Error handling step - if no modules found.
    if (!defined($lowest_mod)) {
        print "Cannot find module: $lowest_mod_name in netlist";
        return "";
    }    

    my $cell = $lowest_mod->find_cell($lowest_cell_name);

    # Error handling step - if no cell found.
    if (!defined($cell)) {
        print "Cannot find cell: $lowest_cell_name in module: $lowest_mod_name";
        return "";
    }    

    # case when the pin 'd' is not found
    my $pin = $cell->find_pin($mux_pin);
    if (! defined($pin)) {
        print "Cannot find pin: $mux_pin for flipflop: $ffline";
        return "";
    }

    my $pin_net_name = $pin->netname();
    my $pin_net = $pin->net();
    my $pin_port = $pin->port();
    my $select_sig = $lowest_cell_name.'_sel';

    # obtain the width of each signal into the mux
    # This is done using the data_type variable
    # in the data structure of Verilog::Netlist::Net
    my $net_width = $pin_net->data_type();
    
    # check all the nets contained in this module.
    # If a net that defines the mux for the current
    # flip flop is present, then skip the process
    # to add the mux. This is to prevent adding a 
    # mux to the same flip flop over and over.
    my $mux_exist = 0;
    foreach my $net ($lowest_mod->nets_sorted()) {
        my $net_name = $net->name();
        if ($net_name eq $lowest_cell_name.'_mux') {
            $mux_exist = 1;
        }    
    }

    my $sel_port = $lowest_mod->find_port($select_sig);

    if ($mux_exist == 0) {
        # delete old pin and create a new pin with mux added.
        $pin->delete();
        # add new port to the module 
        # (the select signal of the mux).
        my $nport = $lowest_mod->new_port("name" => $select_sig, "direction" => 'in', "data_type" => $net_width);
        $lowest_mod->new_net("name" => $nport->name(), "port" => $nport, "data_type" => $net_width);
        my $mux = $lowest_mod->new_net("data_type" => $net_width, "name" => $lowest_cell_name.'_mux', "net_type" => 'wire', "decl_type" => 'net');

        
        # create new assign statement for the mux
        # First check if the flipflop has single 
        # bit or multi bit inputs. If there is a
        # single bit input, simply invert the 'd'
        # input signal. Else, we do an xor between
        # the input signal and the control signal.
        # The xor will flip the bit indicated by
        # the control signal only and leave the
        # other bits the same.
        my $mux_assignment = '';
        if ($is_single == 1) {
            $mux_assignment = $nport->name().'? ~'.$pin_net->name().' : '.$pin_net->name();
        } else {
            $mux_assignment = $nport->name().' ^ '.$pin_net->name();
        }
        my $new_assign = $lowest_mod->new_contassign("name" => $nport->name(), "keyword" => 'assign', "lhs" => $mux->name(), "rhs" => $mux_assignment);


        # create new pin to add in mux
        $cell->new_pin("name" => $mux_pin, "portname" => $mux_pin, "port" => $pin_port, "netname" => $mux->name(), "net" => $mux);
        my @module_text = $lowest_mod->verilog_text();
        create_file($nl, \@module_text, $lowest_mod_name, $outdirectory);
        $sel_port = $nport;
    }

    # move up through the module hierarchy and
    # hook up the select signal up to the top module.
    for (my $i = $mod_hiersz-3; $i >= 0; $i--) {
        # check if the module have already been updated with
        # the current select signal. If it has just skip this
        # module and move onto the next module. $sel_exist is
        # 1 when the select signal already exists. 0 otherwise.
        my $cur_mod = $nl->find_module($mod_hier[$i]);
        my $cur_cell_name = $module_list[$i+1];
        my $cur_cell = $cur_mod->find_cell($cur_cell_name);

        my $sel_exist = 0;
        foreach my $cur_port ($cur_mod->ports_sorted()) {
            my $cur_port_name = $cur_port->name();
            if ($cur_port_name eq $cur_cell_name.'_'.$sel_port->name()) {
                $sel_port = $cur_port;
                $sel_exist = 1;
            }
        } 
        
        if ($sel_exist == 1) {
            next;
        }

        my $new_port = $cur_mod->new_port("name" => $cur_cell_name.'_'.$sel_port->name(), "direction" => 'in', "data_type" => $net_width);
        my $new_net = $cur_mod->new_net("name" => $new_port->name(), "data_type" => $net_width, "port" => $new_port);
        
        my $new_pin = $cur_cell->new_pin("name" => $sel_port->name(), "cell" => $cur_cell, "portname" => $sel_port->name(), "port" => $sel_port, "netname" => $new_net->name(), "net" => $new_net);
        my @module_text = $cur_mod->verilog_text();
        create_file($nl, \@module_text, $cur_mod->name(), $outdirectory);
        
        $sel_port = $new_port;
    }
   
}

sub create_file {
    my $nl = shift;
    my $module_text_ptr = shift;
    my @module_text = @$module_text_ptr;
    my $mod_name = shift;
    my $outdirectory = shift;

    my $filename = $outdirectory."/$mod_name\_mux.v";

    
    # Takes in a module text and module name and create
    # a copy of the module. The new file will be saved
    # in the directory specified by $outdirectory.
    open(FILE, ">".$filename) or die "Cannot open file: $filename";
    print FILE @module_text;
    close FILE;
    print "File: $filename created\n";
}

sub get_mod {
    my $cur_cell = shift;
    my $nl = shift;
    # searches all the modules in the netlist to
    # find $cur_cell. Returns the name of $cur_cell's
    # module. If no module found, return "".
    my $result = "";
    my @all_mod = $nl->modules();
    foreach my $mod (@all_mod) {
        foreach my $cell ($mod->cells_sorted()) {
            my $cell_name = $cell->name();
            if ($cell_name eq $cur_cell) {
                $result = $cell->submodname();
                last;
            }
        }
        if ($result ne "") {
            last;
        }
    }
    return $result;
}


