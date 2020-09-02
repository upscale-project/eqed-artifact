#!/usr/bin/env perl

use strict;
use warnings;
use Verilog::Netlist;
use Getopt::Long;
use File::Copy;
use POSIX;

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

# variable to store the number of bits of control signals required
my $nbits = 0;

# variable to store all the control signals hooked up to the
# top module.
my $control_sig = '';
my @sigs;

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
		print "$cur_hier\n";
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
        $control_sig = add_mux('d', \@mod_hier, $nl, \@module_list, $line, $outdirectory, 1, $directory, $list);
    } else {
        $control_sig = add_mux('d', \@mod_hier, $nl, \@module_list, $line, $outdirectory, 0, $directory, $list);
    }

    if ($control_sig ne '') {
    	push(@sigs, $control_sig);
    }

    $nbits++;

    print "\n";
}
close INFO;
print "$nbits\n";

print "THE CONTROL SIGNALS: @sigs\n";

add_decoder($top, $nbits, \@sigs);

sub add_decoder {

    my $top = shift;
    my $nbits = shift;
    my $control_sigs_ptr = shift;
    my @sigs = @$control_sigs_ptr;

    # filename of the file to be edited
    my $top_filename = newfilename($nl, $top, $outdirectory);
    my $tempfilename = 'temp.v';

    # find the number of bits needed for the input
    # to the decoder. For example if the input has
    # 5 bits, then the total number of bits for the
    # control signals must be 2^5 = 32. However, the
    # total number of control bits varies and is kept
    # in the variable nbits.
    my $input_bits = ceil(log($nbits)/log(2));
    my $input_bits_minus1 = $input_bits-1;
    my $extra_bits = 2**$input_bits - $nbits;

    print "number of bits for the input = $input_bits\n";

    # find the top level module
    my @module_list = $nl->modules_sorted_level();
    my $nlist = @module_list;
    my $top_module = $module_list[$nlist-1];
    my @mod_ports = $top_module->ports_ordered();
    my $nports = @mod_ports;
    my $last_port = $mod_ports[$nports-1];
    my $port_lineno = $last_port->lineno();
    print "line number to add port: $port_lineno\n";

    my $line_count = 1;
    my $lineno = $port_lineno;
    open (TEMP, '>', $tempfilename) or die "Could not open file $tempfilename\n";
    open (FILE, '<', $top_filename) or die "Could not open file $top_filename\n";
    foreach my $line (<FILE>) {
	if ($line_count == $lineno) {
	    if ((index($line, ');') != -1) || ((index($line, ')') != -1) && (index($line, ';') != -1))) {
	    	my @line_split = split(/\)/, $line);
	    	my $num_split = @line_split;
	    	my $new_line = '';
		my $sig_to_add = 'input wire ['.$input_bits_minus1.':0] decoder_input, input wire decoder_en';
	    	if ($num_split == 1) {
		    $new_line = ','.$sig_to_add.')'.$line_split[0];
	    	} else {
	    	    for (my $i = 0; $i < $num_split-2; $i++) {
		    	$new_line = $new_line.$line_split[$i].')';
	    	    }
		    $new_line = $new_line.$line_split[$num_split-2].','.$sig_to_add.')'.$line_split[$num_split-1];
	    	}
	    	print TEMP $new_line;
	    	print "Port successfully added\n";
		# add the decoder here!!
		my $extra_bits_line = '';	
		my $decoder_line = 'assign {';
		if ($extra_bits == 1) {
		    $extra_bits_line = 'wire extra_bits;'."\n";
		    print TEMP $extra_bits_line;
		    $decoder_line = $decoder_line.'extra_bits,';
		} elsif ($extra_bits > 1) {
		    $extra_bits--;
		    $extra_bits_line = 'wire ['.$extra_bits.':0] extra_bits'."\n";
		    print TEMP $extra_bits_line;
		    $decoder_line = $decoder_line.'extra_bits,';
		}
		my $sigs_sz = @sigs;
		for (my $i = 0; $i < $sigs_sz-1; $i++) {
		    $decoder_line = $decoder_line.$sigs[$i].',';
		}
		my $total_sig_bits = 2**$input_bits;
		$decoder_line = $decoder_line.$sigs[$sigs_sz-1].'} = (decoder_en)? (1 << decoder_input) : '.$total_sig_bits.'\'d0;'."\n";
		print TEMP $decoder_line;
	    } elsif (($lineno-$port_lineno) < 2) {
	    	$lineno++;
	    	print TEMP $line;
	    } else {
	    	print TEMP $line;
	    	print "Control signal port addition FAIL: Module does not end with a ');'\n Port line number = $port_lineno, current line number to check = $lineno\n";
	    }

	} else {
	    print TEMP $line;
	}
	$line_count++;
    }
    copy($tempfilename, $top_filename) or die "Copy Failed!\n";
    
    close FILE;
    close TEMP;

}

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
    my $directory = shift;
    my $list = shift;
    #my $control_sig_ptr = shift;
    #my @c_sig = @$control_sig_ptr;
    my $c_signame = '';

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
    
    # debugging
    my $lineno = $pin->lineno();

    # in case where pin net is undefined:
    #if (! defined($pin_net)) {
	

#	print "Net connected to pin: $pin_net_name is undefined\n";
#	return "";
 #   }

    # obtain the width of each signal into the mux
    # This is done using the data_type variable
    # in the data structure of Verilog::Netlist::Net
    my $net_width = 0;
    if (!defined($pin_net)) {
	my @pin_name_split = split(/[^\w\s]/, $pin_net_name);
	my $pin_splitsz = @pin_name_split;
	foreach my $names (@pin_name_split) {
	    $pin_net = $lowest_mod->find_net($names);
	    #print "$names\n";
	    if (defined($pin_net)) {
		$net_width = $pin_net->data_type();
		last;
	    }
	}
	if (!defined($pin_net)) {
	    print "Net connected to pin: $pin_net_name is undefined\n";
	    return "";
	}
    } else {
        $net_width = $pin_net->data_type();
    }
    
    # remove any keywords from data type if it is there,
    # since we only want the bit size
    my $sq_bracket_open = index($net_width, '[');
    my $sq_bracket_close = index($net_width, ']');
    if ($sq_bracket_open == -1 || $sq_bracket_close == -1){
	$net_width = '';
    } else {
	$net_width = substr($net_width, $sq_bracket_open, $sq_bracket_close-$sq_bracket_open+1);
    }

    # check if the net_width contains a parameter
    # or not. If it does then set size_param to 1
    my $size_param = 0;
    my $check_param = $net_width;
    $check_param =~ s/[\W\d]//g;
    if ($check_param ne '') {
	$size_param = 1;
    }
    print "remove non letters in net_width to get: $check_param and size_param = $size_param\n";
    
    print "net width is: $net_width\n";

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

    # ------------------------------------------------
    # MUX ADDITION
    # ------------------------------------------------

    #my $prev_sel_port = $select_sig;
    my $sel_port = $lowest_mod->find_port($select_sig);

    if ($mux_exist == 0) {

        # MUX and SELECT signal added to the output file
        # here. This is done by doing a text-style
        # replacement and does not edit any of the current
        # netlist opened. 

        #my $new_filename = $outdirectory."/$lowest_mod_name\_mux.v";
        #my $cur_filename = $nl->resolve_filename($lowest_mod_name, ['all']); 

	my $cur_filename = get_filename($nl, $lowest_mod_name);
	print "$cur_filename\n";
	if ($cur_filename eq '') {
	    print "Could not find module: $lowest_mod_name in any files\n";
	    return '';
	}
	my $new_filename = newfilename($nl, $cur_filename, $outdirectory);
	print "$new_filename\n";

        my $to_add = '';
        if ($is_single == 1) {
            $to_add = ".d($select_sig? ~$pin_net_name : $pin_net_name)";
        } else {
            $to_add = ".d($select_sig ^ $pin_net_name)";
        }
	print "mux to add: $to_add\n";

        #if (defined($cur_filename)) {
        my @mod_port = $lowest_mod->ports_ordered();
	my $num_ports = @mod_port;
        my $port_lineno = $mod_port[$num_ports-1]->lineno();
	    #print "$port_lineno\n";
	my $first_portname = $mod_port[$num_ports-1]->name();
	    #my $mod_lineno = $lowest_mod->lineno();
	    # print "$mod_lineno\n";
	my $control_sig = '';
	if ($is_single == 0) {
	    $control_sig = $net_width.' '.$select_sig;
	} else {
	    $control_sig  = $select_sig;
	}
	write_mux($cur_filename, $new_filename, $to_add, 1, $pin_net_name, $lineno);
	add_port($port_lineno, $first_portname, $control_sig, $cur_filename, $new_filename, 0, '', '', 0);
       

	# ---------------------------------------------------
        # MUX and SELECT signal added here in the netlist but
        # it will not be updated in the output file. This is
        # done to prevent re-adding the mux every time and to

        # keep track of all the nets, pins and ports in the 
        # current netlist I am working with. 

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
        $cell->new_pin("lineno" => $lineno, "name" => $mux_pin, "portname" => $mux_pin, "port" => $pin_port, "netname" => $mux->name(), "net" => $mux);
        #my @module_text = $lowest_mod->verilog_text();
        #create_file($nl, \@module_text, $lowest_mod_name, $outdirectory);
        $sel_port = $nport;
       
        # ---------------------------------------------------
    }

    # -------------------------------------------------------
    # CONTROL SIGNAL CONNECTION
    # -------------------------------------------------------
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

	# -----------------------------------------------------
	# write control signal to the port of each module in 
	# the hierarchy.
	my $cur_filename = get_filename($nl, $cur_mod->name());
	if ($cur_filename eq '') {
	    print "Could not find module: $lowest_mod_name in any files\n";
	    return '';
	}
	my $new_filename = newfilename($nl, $cur_filename, $outdirectory);
 	
	my @mod_port = $cur_mod->ports_ordered();
	my $num_ports = @mod_port;
        my $port_lineno = $mod_port[$num_ports-1]->lineno();
	my $first_portname = $mod_port[$num_ports-1]->name();
	my $control_sig = '';
	my $control_name = '.'.$sel_port->name().'('.$cur_cell_name.'_'.$sel_port->name().')';

	my $last_pin_lineno = -1;
	foreach my $cell_pin ($cur_cell->pins()) {
	    my $pin_lineno = $cell_pin->lineno();
	    $last_pin_lineno = $pin_lineno if ($pin_lineno > $last_pin_lineno);
	}

	# Check the cell to see if there is a parameter or not
	# If there is a parameter and the parameter is used
	# for the control signal bit size, then update net_width
	# with the parameter value.
	my $cur_cell_lineno = $cur_cell->lineno();
	if ($size_param == 1) {
	    my $param = get_param($cur_filename, $cur_cell_lineno, $check_param);
	    print "$param\n";
	    my $param_net = $cur_mod->find_net($param);
	    if (defined($param_net)) {
		if ($param_net->decl_type() ne 'parameter') {
		    $size_param = 0;
		    my $param_net_value = $param_net->data_type();
		    my $sq_bracket_open = index($param_net_value, '[');
    		    my $sq_bracket_close = index($param_net_value, ']');
    		    if ($sq_bracket_open == -1 || $sq_bracket_close == -1){
		    	$net_width = '';
    		    } else {
		    	$net_width = substr($net_width, $sq_bracket_open, $sq_bracket_close-$sq_bracket_open+1);
    		    }
		} else {
		    $check_param = $param_net->name();
		    $net_width = '['."$check_param-1".':0]';
		}
		#$net_width = '['."".':0]';
	    } else {
		if ($param =~ m/^\d+$/) {
		    $check_param = $param-1;
		    $net_width = '['.$check_param.':0]';
		} else {
		    $check_param = $param;
		    $net_width = '['."$check_param-1".':0]';
		}
	    }
 	}

	if ($is_single == 0) {
	    $control_sig = $net_width.' '.$cur_cell_name.'_'.$sel_port->name();
	} else {
	    $control_sig  = $cur_cell_name.'_'.$sel_port->name();
	}
        my $port_added = 0;

	my $is_top = 0;
	$is_top = 1 if ($i == 0);
	$port_added = add_port($port_lineno, $first_portname, $control_sig, $cur_filename, $new_filename, 1, $control_name, $last_pin_lineno, $is_top);
	
	#print "Port added = $port_added --> for checking\n";

	#my $c_signame = '';
	if ($port_added == 1 && $i == 0) {
	    $c_signame = $cur_cell_name.'_'.$sel_port->name();
	    #print "c_signame = $c_signame\n";
	    #push(@c_sig, $c_signame);
	    #print "c_sig = @c_sig\n";
	}

	# ------------------------------------------------------
	# This part updates the netlist so that the same control
	# signal is not added more than once. This netlist is 
	# not present in the output file however.
	
        my $new_port = $cur_mod->new_port("name" => $cur_cell_name.'_'.$sel_port->name(), "direction" => 'in', "data_type" => $net_width);
        my $new_net = $cur_mod->new_net("name" => $new_port->name(), "data_type" => $net_width, "port" => $new_port);
        
        my $new_pin = $cur_cell->new_pin("lineno" => 0, "name" => $sel_port->name(), "cell" => $cur_cell, "portname" => $sel_port->name(), "port" => $sel_port, "netname" => $new_net->name(), "net" => $new_net);
        #my @module_text = $cur_mod->verilog_text();
        #create_file($nl, \@module_text, $cur_mod->name(), $outdirectory);
        
	my $new_port_name = $new_port->name();
	#print "$new_port_name\n";

        $sel_port = $new_port;
    }
    return $c_signame;
    #return $control_sig_ptr;
}

sub get_param {
    my $cur_filename = shift;
    my $cell_lineno = shift;
    my $param_name = shift;

    my $line_count = 1;
    my $param = $param_name;
    open(FILE, "<", $cur_filename) or die "Could not open file: $cur_filename\n";
    foreach my $line (<FILE>) {
	if ($line_count == $cell_lineno) {
	    my $hash_index = index($line, '#');
	    if ($hash_index == -1) {
		last;
	    } else {
		my @split_line = split(/\/\*\#\(|\)\*\//, $line);
		print "@split_line\n";
		my $split_sz = @split_line;
		return $param_name if ($split_sz == 1);
		my $parameters = $split_line[1];
		my $period_index = index($parameters, '.');
		if ($period_index == -1) {
		    $param = $parameters;
		    last;
		} else {
		    my $param_name_index = index($parameters, $param_name);
		    last if ($param_name_index == -1);
		    $param_name_index = $param_name_index+length($param_name);
		    my $open_index = index($parameters, '(', $param_name_index);
		    my $close_index = index($parameters, ')', $param_name_index);
		    my $cur_param = substr($parameters, $open_index+1, $close_index-$open_index-1);
		    $param = $cur_param;
		    last;
		}
	    }
	}
	$line_count++;
    } 
    close FILE;
    return $param;
}

sub newfilename {
    my $nl = shift;
    my $cur_filename = shift;
    my $outdirectory = shift;

    my @split_fname = split(/\//, $cur_filename);
    my $num_names = @split_fname;
    #print "@split_fname\n";
    #print $split_fname[$num_names-1];
    my @split_basename = split(/\./, $split_fname[$num_names-1]);
    my $basename = $split_basename[0];
    #print "$basename\n";
    my $new_filename = $outdirectory.'/'.$basename.'_mux.v';
    return $new_filename;
}

sub get_filename {
    # return filename that contains a certain module
    # indicated by the input argument

    my $nl = shift;
    my $lowest_mod_name = shift;
    my $cur_filename = $nl->resolve_filename($lowest_mod_name, ['all']);

    if (defined($cur_filename)) {
	return $cur_filename;
    } else {
	# Case when the module cannot be found - meaning the module is in another module's filename.
	foreach my $mod_files ($nl->files_sorted()) {
	    my $mod_fname = $mod_files->name();
	    my $cur_opt = new Verilog::Getopt;
	    $cur_opt->parameter( "+incdir+",$directory,
                 		 "-f",$list,
                 		 "-y",$directory,
                  		);

	    my $cur_nl = new Verilog::Netlist (options => $cur_opt,link_read_nonfatal => 1);
	    $cur_nl->read_file(filename=>$mod_fname);

	    my $find_mod = $cur_nl->find_module($lowest_mod_name);
	    if (defined($find_mod)) {
		return $mod_fname;
	    }
	}
	return '';
    }
}

sub edit_file_port {
    # This function opens the file to read and file to write and
    # edits the file to add in a port at a specific line
    # ($edit_lineno). This function utilizes the fact that modules
    # and cells end with a ');' and adds the port in at the end
    # of the cell or module rigth before the ');'
    my $new_filename = shift;
    my $old_filename = shift;
    my $edit_lineno = shift;
    my $sig_to_add = shift;
    my $is_top = shift;

    open(NEW, '>'.$new_filename) or die "Cannot open file: $new_filename\n";
    open(OLD, '<'.$old_filename) or die "Cannot open file: $old_filename\n";

    my $add_success = 0;

    my $lineno = $edit_lineno;
    my $line_count = 1;
    foreach my $line (<OLD>) {
        if ($line_count == $lineno) {
	# This is the last input/output/inout port of the module
	# Look for a ')' and ';' to see if it is at the end or
	# not. This is assuming that the module declaration ends
	# with a ');' in the same line always.
	    if ((index($line, ');') != -1) || ((index($line, ')') != -1) && (index($line, ';') != -1))) {
	    	my @line_split = split(/\)/, $line);
	    	my $num_split = @line_split;
	    	my $new_line = '';
	    	if ($num_split == 1) {
		    $new_line = ','.$sig_to_add.')'.$line_split[0];
	    	} else {
	    	    for (my $i = 0; $i < $num_split-2; $i++) {
		    	$new_line = $new_line.$line_split[$i].')';
	    	    }
		    $new_line = $new_line.$line_split[$num_split-2].','.$sig_to_add.')'.$line_split[$num_split-1];
	    	}
		if ($is_top == 0) {
	    	    print NEW $new_line;
		} else {
		    print NEW $line;
		}
	    	print "Port successfully added\n";
		$add_success = 1;
	    } elsif (($lineno-$edit_lineno) < 2) {
	    	$lineno++;
	    	print NEW $line;
	    } else {
	    	print NEW $line;
	    	print "Control signal port addition FAIL: Module does not end with a ');'\n Port line number = $edit_lineno, current line number to check = $lineno\n";
	    }
    	} else {
   	    print NEW $line;
    	}
    	$line_count++;
    }
    close OLD;
    close NEW;

    return $add_success;
}

sub add_port {
    # Function to add a control select signal to a module.
    # This function also instantiates the cell port as well
    # if cell_port_add is a 1.
    
    my $port_lineno = shift;
    my $portname = shift;
    my $control_sig = shift;
    my $cur_filename = shift;
    my $new_filename = shift;
    #$is_single = shift;
    my $cell_port_add = shift;
    my $control_name = shift;
    my $pin_lineno = shift;
    my $is_top = shift;

    my $mod_port_sig = 'input wire '.$control_sig;
    my $temp_filename = 'temp_file.v';

    my $port_added = 0;

    if (-e $new_filename) {
	#print "File exists\n";
	#my $temp_filename = 'temp_file.v';
	$port_added = edit_file_port($temp_filename, $new_filename, $port_lineno, $mod_port_sig, $is_top);

	copy($temp_filename, $new_filename) or die "Copy failed!";
	print "Edit file: $new_filename successful\n";
	if ($cell_port_add == 1) {
	    edit_file_port($temp_filename, $new_filename, $pin_lineno, $control_name, 0);
	    copy($temp_filename, $new_filename) or die "Copy failed!";
	}

    } else {
	$port_added = edit_file_port($new_filename, $cur_filename, $port_lineno, $mod_port_sig, $is_top);
	if ($cell_port_add == 1) {
	    edit_file_port($temp_filename, $new_filename, $pin_lineno, $control_name, 0);
	    copy($temp_filename, $new_filename) or die "Copy failed!";
	}
    }

    return $port_added;
}


sub edit_file_mux {

    my $new_filename = shift;
    my $cur_filename = shift;
    my $lineno = shift;
    my $pin_net_name = shift;
    my $to_add = shift;
    my $is_replace = shift;
    my $is_top = shift;

    open(OLD, '<'.$cur_filename) or die "Cannot open file: $cur_filename\n";
    open(NEW, '>'.$new_filename) or die "Cannot open file: $new_filename\n";

    my $line_count = 1;
    foreach my $o_lines (<OLD>) {
        if ($line_count == $lineno) {
            my @line_split = split(/\.d/,$o_lines);
            my $split_sz = @line_split;
            if ($split_sz != 1) {
		my $to_split_open_bracket = $line_split[1];
		my $bracket_location = index($to_split_open_bracket, '(');
		my $line_to_split = substr($line_split[1], $bracket_location+1);
		#my @split_open = split(/\(/, $to_split_open_bracket);
		#my $split_szopen = @split_open;
		#my $line_to_split = $split_open[1];
		#for (my $i = 2; $i < $split_szopen; $i++) {
		#    $line_to_split.'('.$split_open[$i];
		#}

		my @split_bracket = split(/\)/,$line_to_split);
		my $split_sz = @split_bracket;
		my $after_bracket = $split_bracket[0];
		my $count = 1;
		while (index($after_bracket, '(') != -1) {
		    $after_bracket = $split_bracket[$count];
		    $count++;
		}

		$after_bracket = $split_bracket[$count];
                $to_add = $line_split[0].$to_add.$after_bracket;
		for (my $i = $count+1; $i < $split_sz; $i++) {
		    $to_add = $to_add.')'.$split_bracket[$i];
		}
                print NEW $to_add;
		print NEW $o_lines if ($is_replace == 0);
      		print "Mux added to: $new_filename\n";
            } else {
		print "Could not find the input for this flipflop with format .d(<port_name>). Line: $lineno of file: $new_filename\n";
		print NEW $o_lines;
	    }
        } else {
            print NEW $o_lines;
        }
        $line_count++;
    }
    close OLD;
    close NEW;
}

sub write_mux {
    # Function to copy rtl design from old file to new
    # file and then adding a mux to the new file using
    # text edit style editing. This mux addition function
    # assumes that the input to the flipflop is called as
    # .d(<port_name>)
    # If the format of the input signal to flipflop is not
    # as indicated, the script does nothing to the flipflop
    # and leaves it unedited.
    my $cur_filename = shift;
    my $new_filename = shift;
    my $to_add = shift;
    my $is_replace = shift;
    my $pin_net_name = shift;
    my $lineno = shift;

    if (-e $new_filename) {
	#print "File exists\n";
	my $temp_filename = 'temp_file.v';

	edit_file_mux($temp_filename, $new_filename, $lineno, $pin_net_name, $to_add, $is_replace);
	copy($temp_filename, $new_filename) or die "Copy failed!";
	print "Edit file: $new_filename successful\n";
    } else {
	edit_file_mux($new_filename, $cur_filename, $lineno, $pin_net_name, $to_add, $is_replace);
    }
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


