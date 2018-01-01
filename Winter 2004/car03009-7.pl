#!/usr/bin/perl

#  Homework 07
#  Brother Twitchell, CS 273
#  Brother Michael Carey

print <<EOT;
Content-type: text/plain

EOT

$amount = $ENV{'QUERY_STRING'};
$amount = 100 - $amount;
$quarters = int ( $amount / 25 );
$amount -= ( $quarters * 25 );
$dimes = int ( $amount / 10 );
$amount -= ( $dimes * 10 );
$nickles = int ( $amount / 5 );
$amount -= ( $nickles * 5 );
$pennies = $amount;

$amount = $ENV{'QUERY_STRING'};

print "The item cost $amount cents.\nYour change includes ";
print "$quarters quarter\(s\), $dimes dime\(s\), ";
print "$nickles nickel\(s\), and $pennies penny\(ies\).\n\n";
