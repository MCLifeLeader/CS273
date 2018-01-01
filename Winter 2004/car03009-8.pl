#!/usr/bin/perl

# Homework 08
# Brother Twitchell, CS 273
# Brother Michael Carey

print <<EOT;
Content-type: text/plain

EOT

# build my list for inserting into my hash
@Vending = qw(A1 35 A2 empty A3 90 A4 50 A5 75 B1 55 B2 10 B3 empty B4 empty B5 20 C1 empty C2 85 C3 40 C4 95 C5 60 D1 15 D2 empty D3 65 D4 5 D5 100 E1 70 E2 45 E3 25 E4 80 E5 30);

# build the key value pairs list
%slots = @Vending;

#grab input from the browser
$inputVal = $ENV{'QUERY_STRING'};

#split the value found in the query string
@items = split(//, $inputVal);

# insert into $_ for regex compair
$_ = $inputVal;

# check to see if double values of same type are entered.
unless( /([a-zA-Z]{2}|[0-9]{2})/ )
{
	if( $items[0] > 0 )
	{
		($items[0], $items[1]) = ($items[1], $items[0]);
		
		$_ = $items[0];
		
		# Convert to upper case
		if( /[a-z]/ )
		{		
			@items[0] = uc( @items[0] );
		}
		if( $items[1] <= 5 && $items[1] >= 1 && $items[0] ge "A" && $items[0] le "E" )
		{		
			print "Input of $items[1]$items[0] is being processed as ", @items, "\n";
		}
	}
	else
	{	
		$_ = $items[0];
		
		# Convert to upper case
		if( /[a-z]/ )
		{		
			@items[0] = uc( @items[0] );
		}
	}

	# Check Range, does it match
	if( $items[1] <= 5 && $items[1] >= 1 && $items[0] ge "A" && $items[0] le "E" )
	{
		$_ = $slots{$items[0].$items[1]};
		
		#check to see if the string from the hash is 'empty'
		unless( /^empty$/i )
		{
			print "Item ", @items, " costs $_ cents.\n";
		
			# do the math
			$amount = $_;
			$amount = 100 - $amount;
			$quarters = int ( $amount / 25 );
			$amount -= ( $quarters * 25 );
			$dimes = int ( $amount / 10 );
			$amount -= ( $dimes * 10 );
			$nickles = int ( $amount / 5 );
			$amount -= ( $nickles * 5 );
			$pennies = $amount;

			print "Change is $quarters quarter\(s\), $dimes dime\(s\), and ";
			print "$nickles nickel\(s\)\n\n";
		}
		else
		{
			print "Invalid Selection: ", @items, " is empty.\n";
		}
	}
	else
	{
		&printError;
	}
}
else
{
	&printError;
}

# print the master error
sub printError
{
	print "Input error: letter range is A-E, number range is 1-5.\n";
}
