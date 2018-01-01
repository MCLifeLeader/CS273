#!/usr/bin/perl

if ($ARGV[0] eq "")
{
   die "Usage:  deleteCR.pl filename\n";
}


$file = $ARGV[0];

$oldFile = $file . "\.old";

open (FILE, $file) or die "Could not open file $file\n";
@contents = <FILE>;
close FILE;

`mv $file $oldFile`;

open (FILE, ">$file");

foreach (@contents)
{
   s/\r//;
 
   print FILE $_;
}

