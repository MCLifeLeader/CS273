#!/usr/bin/perl
#  Homework 8
#  Brother Twitchell, CS 273
#  Mike Carey

# This is what is happening.
# print ouputs a blank line
# Then it looks to the inner most set of parenthisis
# Sets the array '@a' equal to aaa through zzz which is 26**3 items
# @a returns to rand it's total count
# rand ouputs a value between 0 and 26**3 - 1
# $a[ index ]   index is set by the return value of rand
# print then displays the contents of $a at index.

print"\n",$a[rand(@a=aaa..zzz)];
