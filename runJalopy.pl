#!/usr/bin/perl

my @files = <*.*>;

for (@files)
{
	unless( /runJalopy.pl/i )
	{
		$myCommand = "/home/cs246/jalopy \"$_\"";
		$output = `$myCommand`;
	}
}