# Script: comment-param
# ---------------------
# This script takes in a list of rtl files and goes through all the files to find module parameters.
# The script then either comment out the module parameters or uncomment the parameters depending on
# the input argument specified.

#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use File::Copy;

# read in the list of files to modify,
# -----------------------------------
# format of the list is expected to be
# the full path of an rtl file per line
my $flist = '';
# specify if the script is to comment out
# module parameters or uncomment them
# 0 = uncomment
# 1 = comment
my $comment = '';
# outdirectory specifies where to put the
# commented/uncommented output files
# If no outdirectory specified then overwrite
# the file being read.
my $outdirectory = '';


GetOptions('flist=s' => \$flist, 'comment=i' => \$comment, 'outdirectory=s' => \$outdirectory);

# open list of files to edit
open (LIST, $flist) or die "Could not open file: $flist, Please enter a filename containing the list of files to edit\n";
foreach my $filename (<LIST>) {
    chomp ($filename);
    my $params = '';
    comment_file($filename, $comment, \$params);
    # print "$params\n";

    # extract parameter names and value pairs
    # for each file. Each parameter name and 
    # value is in the form 'parameter name = value'
    # after separating them using a comma.
    my %param_pair;
    my @param_split = split(/\,/, $params);
    foreach my $cur_param (@param_split) {
	if (index($cur_param, 'parameter') != -1) {
	    my @cur_pair = split(/parameter|\=/, $cur_param);
	    #print "@param_pair\n";
	    #my $pair_sz = @param_pair;
	    my $cur_key = trim($cur_pair[1]);
	    my $cur_value = trim($cur_pair[2]);
	    $param_pair{$cur_key} = $cur_value;
	    #$param_pair{$cur_pair[1]} = $cur_pair[2];
	}
    }
    my @keys = keys %param_pair;
    #print "@keys\n";
    my @values = values %param_pair;
    #print "@values\n";
    
    my @filename_split = split(/\//,$filename);
    my $split_fsz = @filename_split;
    my $new_filename = $outdirectory.'/'.$filename_split[$split_fsz-1];
    if ($outdirectory eq '') {
    	replace_param($filename, $comment, \%param_pair);
    } else {
	replace_param($new_filename, $comment, \%param_pair);
    }
}
close LIST;

sub trim {
    my $s = shift; 
    $s =~ s/^\s+//;
    $s =~ s/\s+$//; 
    return $s 
}

sub replace_param {
    my $filename = shift;
    my $comment = shift;
    my $param_pair_ptr = shift;

    open (FILE, $filename) or die "Could not open file: $filename\n";
    my $temp_filename = 'temp.v';
    open (TEMP, '>', $temp_filename) or die "Could not open temp file\n";

    # $in_comment is 1 when the line is currently inside a /* */ 
    # comment.
    my $in_comment = 0;

    foreach my $line (<FILE>) {
	# Find all the lines with the name of the 
	# parameters and substitute them with the 
	# values.
	# skip any lines that has a #(<PARAMETER>)
	if (index($line, '#') != -1) {
	    #my @split_hash = split(/\#/, $line);
	    ##print $split_hash[1];
	    #my @split_brackets = split(/\(|\)/, $split_hash[1]);
	    ##my $param = $split_brackets[1];
	    #if (index($split_brackets[1], 'parameter') != -1) {
		#print "$param: skip\n";
		print TEMP $line;
		next;
	    #}
	}
	
	if ($in_comment == 1) {
	    print TEMP $line;
	    next;
	}

	my $comment_start = index($line, '/*');
	my $comment_end = index($line, '*/');
	my $comment_index = index($line, '//');

	#if ($comment_start != -1 && $comment_end == -1) {
	#    $in_comment = 1;
	#} elsif ($comment_end != -1 && $comment_start == -1) {
	#    $in_comment = 0;
	#} elsif ($comment_end != -1 && $comment_start != -1) {
	#    if ($comment_end < $comment_start) {
		
	#}

	my %param_pair = %$param_pair_ptr;
	my @param_keys = keys %param_pair;
	#print "@param_keys\n";
	my $new_line = $line;
	foreach my $key (@param_keys) {
	    #$key = trim($key);
	    my @key_split = split(//,$key);
	    my $key_len = @key_split;
	    my $key_pos = index($new_line, $key);
	    #print "$key_pos\n";
	    
	    my $key_count = 1;

	    while ($key_pos != -1) {
		my @line_split = split(//,$new_line);
		my $after_last_char = $line_split[$key_pos+$key_len];
		my $before_first_char = $line_split[$key_pos-1];
		#print "$key_pos: $cur_char to $last_char\n";
		#print "$new_line\n";
		
		if ($comment_index != -1 && $key_pos > $comment_index) {
		    last;
		}

		#if ($comment_start != -1 && $comment_end == -1 && $key_pos > $comment_start) {
		#    $in_comment = 1;
		#    last;
		#}

		if ($after_last_char !~ /\w/ && $before_first_char !~ /\w/ && $before_first_char ne '[') {
		    my $cur_value = $param_pair{$key};
		    #$cur_value = trim($cur_value);
		    my @split_value = split(//,$cur_value);
		    my $value_len = @split_value;
		    if ($comment == 1) {
		    	#my $cur_value = $param_pair{$key};
		    	my $string_for_replace = '/*'.$key.'*/'.$cur_value;
		    	$new_line = replace($new_line, $key, $string_for_replace, $key_count, $comment);
			$key_pos = index($new_line, $key, $key_pos + 4 + $key_len + $value_len);
			$key_count++;
		    } elsif ($comment == 0) {
		    	my $string_to_replace = '\/\*'.$key.'\*\/'.$cur_value;
		    	#print "$string_to_replace\n";
		    	$new_line = replace($new_line, $string_to_replace, $key, $key_count, $comment);
			#print "old key pos = $key_pos\n";
			$key_pos = index($new_line, $key, $key_pos + $key_len - 2);
			#print "new key pos = $key_pos\n";
			$key_count = 1;
			#$key_count++;
		    } else {
			$key_pos = -1;
		    }
		} else {
		    $key_pos = index($new_line, $key, $key_pos + $key_len);
		    $key_count++ if ($comment == 1);
		}
	    }
	}
	#print "$new_line\n";
        print TEMP $new_line;
	
    }
    close TEMP;
    close FILE;

    if ($outdirectory eq '') {
    	move($temp_filename, $filename) or die "Copy Failed!\n";
    	print "Edit file: $filename successful\n";
    } else {
	my @filename_split = split(/\//, $filename);
	my $num_fsplit = @filename_split;
	my $new_filename = $outdirectory.'/'.$filename_split[$num_fsplit-1];
	move($temp_filename, $new_filename) or die "Copy Failed\n";
	print "Edit file: $new_filename successful\n";
    }

    #copy($temp_filename, $filename) or die "Copy Failed!\n";
    #print "Parameter replacement in file: $filename successful\n";
}

sub replace {
    my $line = shift;
    my $to_replace = shift;
    my $replacement = shift;
    my $count = shift;
    my $comment = shift;

    #my $new_line = '';
    my @split_key = split(/$to_replace/, $line);
    print "@split_key\n";
    my $split_ksz = @split_key;
    my $new_line = $split_key[0];
    for (my $i = 1; $i < $count; $i++) {
	if ($comment == 0) {
	    my @cur_list = split(/\\/,$to_replace);
	    my $new_to_replace = join('', @cur_list);
	    $new_line = $new_line.$new_to_replace.$split_key[$i];
	} else{
	    $new_line = $new_line.$to_replace.$split_key[$i];
	}
    }
    $new_line = $new_line.$replacement.$split_key[$count];
    for (my $i = $count+1; $i < $split_ksz; $i++) {
	if ($comment == 0) {
	    my @cur_list = split(/\\/,$to_replace);
	    my $new_to_replace = join('', @cur_list);
	    $new_line = $new_line.$new_to_replace.$split_key[$i];
	} else {
	    $new_line = $new_line.$to_replace.$split_key[$i];
	}
    }
    return $new_line;
}

sub comment_file {
    my $filename = shift;
    my $comment = shift;
    my $params_ptr = shift;

    open (FILE, $filename) or die "Could not open file: $filename\n";
    my $temp_filename = 'temp.v';
    open (TEMP, '>', $temp_filename) or die "Could not open temp file\n";

    foreach my $line (<FILE>) {
	if (index($line, '#') == -1) {
	    print TEMP $line;
	} else {
	    my $hash_index = index($line, '#');
	    my $comment_index = index($line, '//');
	    if ($comment_index != -1 && ($comment_index < $hash_index)) {
		print TEMP $line;
		next;
	    }

	    my $new_line = '';
	    if ($comment == 1) {
		$new_line = comment_param($line, $params_ptr);
		print TEMP $new_line;
	    } elsif ($comment == 0) {
		$new_line = uncomment_param($line, $params_ptr);
		print TEMP $new_line;
	    } else {
		# do nothing if comment is not 1 nor 0
		print TEMP $line;
	    }
	}
    }
    close FILE;
    close TEMP;

    if ($outdirectory eq '') {
    	move($temp_filename, $filename) or die "Copy Failed!\n";
    	print "Edit file: $filename successful\n";
    } else {
	my @filename_split = split(/\//, $filename);
	my $num_fsplit = @filename_split;
	my $new_filename = $outdirectory.'/'.$filename_split[$num_fsplit-1];
	move($temp_filename, $new_filename) or die "Copy Failed\n";
	print "Edit file: $new_filename successful\n";
    }
}

sub comment_param {
    my $line = shift;
    my $params_ptr = shift;
    
    my @split_hash = split(/\#/, $line);
    my $num_hsplit = @split_hash;

    my $line_to_test = '';
    # check if the '#' is followed by a '(<PARAMETER>)' or not
    if ($num_hsplit == 1) {
	# case when #parameter is declared on a different line to the module instantiation
	$line_to_test = $split_hash[0];
    } else {
	$line_to_test = $split_hash[1];
    }

    #print "$line_to_test\n";
    if (index($line_to_test, '(') == -1 || index($line_to_test, ')') == -1) {
	return $line;
	# is not followed '(<PARAMETER>)'
    } else {
	my @split_bracket = split(/\)/, $line_to_test);
        my $num_bsplit = @split_bracket;
	my $new_line = '';
	if ($num_bsplit == 1) {
	    $new_line = $split_bracket[0].')*/';
	} else {
	    my $count = 1;
	    $new_line = $split_bracket[0];
	    my $cur_seg = $split_bracket[0];
	    my $first_bracket = index($cur_seg, '(');
	    $cur_seg = substr($cur_seg, $first_bracket+1);
	    print "$cur_seg\n";
	    while (index($cur_seg, '(') != -1 && $count < $num_bsplit) {
		$new_line = $new_line.')'.$split_bracket[$count];
		$cur_seg = $split_bracket[$count];
		$count++;
	    }

	    if ($count == $num_bsplit) {
		$new_line = $new_line.')*/';
	    } else {
	    	$new_line = $new_line.')*/'.$split_bracket[$count];
	    	for (my $i = $count+1; $i < $num_bsplit; $i++) {
		    $new_line = $new_line.')'.$split_bracket[$i];
	    	}
	    }

	    	#$new_line = $split_bracket[0].')*/'.$split_bracket[1];
	    	#for (my $i = 2; $i < $num_bsplit; $i++) {
	    	#    $new_line = $new_line.')'.$split_bracket[$i];
	    	#}
	}


	if ($num_hsplit == 1) {
	    $new_line = '/*#'.$new_line;
	} else {
	    $new_line = $split_hash[0].'/*#'.$new_line;
	    for (my $i = 2; $i < $num_hsplit; $i++) {
		$new_line = $new_line.'#'.$split_hash[$i];
	    }
	}
	print "$new_line\n";

	# save the parameter name and values in the string
	# $params which is passed in by reference using 
	# $params_ptr
	#my @param_split = split(/\/\*\# | \)\*\//, $new_line);
	#my $split_sz = @param_split;
	#my $cur_seg;
	#$cur_seg = $param_split[1] if ($split_sz != 1);
	#$cur_seg = $param_split[0] if ($split_sz == 1);
	if (index($split_bracket[0], 'parameter') != -1) {
	    #my $first_bracket_index = index($split_bracket[0], '(');
	    #my $cur_seg = substr($split_bracket, $first_bracket_index+1);
	    
	    #$$params_ptr = $$params_ptr.','.$cur_seg;
	    my @param_split = split(/\(/, $split_bracket[0]);
	    my $split_psize = @param_split;
	    my $cur_param = $param_split[1] if ($split_psize != 1);
	    $cur_param = $param_split[0] if ($split_psize == 1);
	    # print "$cur_param\n";
	    $$params_ptr = $$params_ptr.','.$cur_param;
	}
	return $new_line;
    }
}

sub uncomment_param {
    my $line = shift;
    my $params_ptr = shift;

    # test if there is a comment or not
    # ---------------------------------
    # assume that the commented parameter
    # will always start with a '/*#' and 
    # ends with a '*/' right after. If
    # there are any other '/*#', then 
    # ignore those. Assume that the commented
    # parameter always occurs first in
    # the line.
    if (index($line, '/*#') == -1 || index($line, '*/') == -1) {
	return $line;
    } else {
	my @split_hash = split(/\/\*\#/, $line);
	my $num_hsplit = @split_hash;
	
	my $next_line = '';
	if ($num_hsplit == 1) {
	    $next_line = $split_hash[0];
	} else {
	    $next_line = $split_hash[1];
	}
	
	my @split_bracket = split(/\*\//, $next_line);
	my $num_bsplit = @split_bracket;
	my $new_line = '';
	if ($num_bsplit == 1) {
	    $new_line = $split_bracket[0];
	} else {
	    $new_line = $split_bracket[0].$split_bracket[1];
	    for (my $i = 2; $i < $num_bsplit; $i++) {
		$new_line = $new_line.'*/'.$split_bracket[$i];
	    }
	}

	if ($num_hsplit == 1) {
	    $new_line = '#'.$new_line;
	} else {
	    $new_line = $split_hash[0].'#'.$new_line;
	    for (my $i = 2; $i < $num_hsplit; $i++) {
		$new_line = $new_line.'/*#'.$split_hash[$i];
	    }
	}
	print "$new_line\n";

	# save the parameter name and values in the string
	# $params which is passed in by reference using 
	# $params_ptr
	if (index($split_bracket[0], 'parameter') != -1) {
	    my @param_split = split(/\(|\)/, $split_bracket[0]);
	    my $split_psize = @param_split;
	    my $cur_param = $param_split[1] if ($split_psize != 1);
	    $cur_param = $param_split[0] if ($split_psize == 1);
	    # print "$cur_param\n";
	    $$params_ptr = $$params_ptr.','.$cur_param;
	}
	#print "yo : $$params_ptr\n";

	return $new_line;
    }
}

