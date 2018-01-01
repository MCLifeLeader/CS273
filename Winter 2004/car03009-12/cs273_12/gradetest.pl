#!/usr/bin/perl

@array = ("B+", "B", "B-");

#1  B+ is less then or = B+
#3  B+ is less then or = B-
#1  B is less then or = B+
#2  B is less then or = B
#3  B is less then or = B-
#3  B- is less then or = B-
# B-, B+, B
for( @array )
{
   if( ( $_ le "B+" ) && ( $_ =~ /-/ ) )
   {
      print "1  $_ is less then or = B+\n";
   }   
   if( $_ le "B" )
   {
      print "2  $_ is less then or = B\n";
   }
   if( ( $_ le "B-" ) && ( $_ =~ /[a-dA-D]\-?/ ) )
   {
      print "3  $_ is less then or = B-\n";
   }
}