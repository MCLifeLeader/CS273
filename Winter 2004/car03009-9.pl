#!/usr/bin/perl

#  Homework 09
#  Brother Twitchell, CS 273
#  Brother Michael Carey

if ($ENV{'REQUEST_METHOD'} eq "GET")
{
   $formData = $ENV{'QUERY_STRING'};
}
else
{
   read (STDIN, $formData, $ENV{'CONTENT_LENGTH'});
}
@keyValuePairs = split (/&/, $formData);
foreach $keyValue (@keyValuePairs)
{
   ($key, $value) = split (/=/, $keyValue);
   $value =~ tr/+/ /;
   $value =~ s/%([\dA-Fa-f][\dA-Fa-f])/pack ("C", hex ($1))/eg;
   if (defined ($form{$key}))
   {
      $form{$key} = join ("\0", $form{$key}, $value);
   }
   else
   {
      $form{$key} = $value;
   }
}

if( $form{'Button1'} eq "Show Environment Variables" )
{
   &opening2;
   &printENVKeys;
   &ending;
}
elsif( $form{'Button2'} eq "Show Perl Script" )
{
   &opening3;
   &readFile( $ENV{'SCRIPT_FILENAME'} );
   print @fileContents, "\n";
}
else
{
   &opening1;
   print $form{'Button1'}, "\n";
   print $form{'Button2'}, "\n";
   &ending;
}

# this is the opening value for one of the web pages
sub opening1
{
print <<EOT;
Content-type: text/html

<html>
<head>
<title>Show Environment Variables or the Perl Script</title>
</head>
<body>
<h1>Show Environment Variables or the Perl Script</h1>
<form name="myEnvForm" method="post" ID="Form1">
<P>
<INPUT id="Button1" type="submit" value="Show Environment Variables" name="Button1">&nbsp;&nbsp;
<INPUT id="Button2" type="submit" value="Show Perl Script" name="Button2">&nbsp;&nbsp;
</P>
</form>
EOT
}

# this is the opening value for one of the web pages
sub opening2
{
print <<EOT;
Content-type: text/html

<html>
<head>
<title>Environment Variables</title>
</head>
<body>
<h1>Showing Environment Variables</h1>
EOT
}

# this is the opening value for one of the web pages
sub opening3
{
print <<EOT;
Content-type: text/plain

EOT
}

# this is the ending value for the web page every time.
sub ending
{
print <<EOT;
</body>
</html>
EOT
}

# print all of the environment variables and put them into a table.
sub printENVKeys
{
   print "<TABLE id=\"envTable\" cellSpacing=\"1\" cellPadding=\"1\" border=\"1\">";
   print "<tr><td>Environment Variable Name</td><td>Environment Variable Value</td></tr>";
   for my $key (sort keys %ENV )
   {
      print "<tr><td>",$key,"</td><td>",$ENV{$key},"</td></tr>";
   }
   print "</TABLE>";
}

#pass in a string to a file name
sub readFile
{
unless( open ( INPUT, $_[0] ) )   # opens the file
{
   print "Error Opening: ", $_[0], "\n";
   return 0;             # return 0 if fails
}
                         # INPUT is the filehandle
                         # "file.pl" is the name of the file
@fileContents = <INPUT>; # since this is list context,
                         #    the entire file is read into an array
close INPUT;             # closes the file

@fileContents;
}

