#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;

srand(23);
my $samples = 1;
my $traceSize = 1482;

my $infile = "registerlog";

for (my $i = 0; $i < $samples; $i++){
  my $filename = "Sig_$i";
  open my $fout, '>', $filename or die $!;
  printf $fout "%01X", rand(0xf);
  }
  print "Finished File $i\n";

}	

