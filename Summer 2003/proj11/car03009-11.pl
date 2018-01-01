#!/usr/bin/perl
#  Homework 11
#  Brother Twitchell, CS 273
#  Mike Carey

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

if( ( $form{'Button1'} eq "Show Transcript" ) && ( scalar $form{'sel_Transcripts'} ) )
{
   &opening1;
   &findFilesandDirs;
   my @fileData;

#   print "<TABLE id=\"envTable\" cellSpacing=\"1\" cellPadding=\"1\" border=\"1\">";
#   print "<tr><td>Form Identifyer</td><td>Form Varible Value</td></tr>";
#   for my $key (sort keys %form )
#   {
#      print "<tr><td>",$key,"</td><td>",$form{$key},"</td></tr>";
#   }
#   print "</TABLE>";

   $form{'sel_Transcripts'} =~ /(\d{4}\.txt)/;

   &readFile( $& );
   @fileData = @fileContents;
   chomp @fileData;

   if( $fileData[ 0 ] eq "invalid" )
   {
      print "Invalid Data was found\n";
      die;
   }
   else
   {
      print "<br><b>",$fileData[ 0 ],"</b><br>";
   }

   print "\n<TABLE id=\"transcriptTable\" cellSpacing=\"1\" cellPadding=\"1\" border=\"1\">\n";
   print "<tr><td>Class Code</td><td>Section</td><td>Class Name";
   print "</td><td>Grade Point</td><td>Grade</td><td>Modifyer</td><td>Status</td></tr>\n";

   for $stuff (@fileData)
   {
      /()/;      # blank out $1
      s/(\w+)\s+\1/$1 \U$1\E $1/g;

      $stuff =~ /(\w+\s+\d+\w?)\s+(\d+\w?)\s+(\w*.+?)\s+(\d+\.\d+)\s+([A-Za-z\+\-]+)\s+(\w*)/;
      $_ = $`.$1;

      if( $1 )
      {
         print "<tr><td>",$_,"</td><td>",$2,"</td><td>",$3,"</td><td>",$4;
#         print "</td><td>",$5,"</td><td>",$6,"</td></tr>\n";
         print "</td><td>",$5,"</td><td>",$6,"</td>";

         if( ( "\U$5" ne "\UW" ) && ( "\U$5" ne "\UF" ) && ( "\U$6" ne "\URpt" ) )
         {
            $creditCount += $4;
         }
         else
         {
            print "<td>Ignored</td>";
         }
         print "</tr>\n";
      }
   }

   print "</TABLE>";

   printf "<br><br><b>Total Credits accumulated : %.1f</b>\n", $creditCount;
   &ending;
}
else
{
   &opening1;
   &findFilesandDirs;
   &ending;
}

# this is the opening value for one of the web pages
sub opening1
{
print <<EOT;
Content-type: text/html

<html>
<head>
<title>Transcript File Addition Program</title>
</head>
<body>
<h1>Transcript File Addition Program</h1>
<form name="myTranscriptForm" method="post" ID="Form1">
<P>

</P>
EOT
}

# this is the ending value for the web page every time.
sub ending
{
print <<EOT;
</form>
</body>
</html>
EOT
}

#/
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

#reads and identifies files and directories in the parent dir
sub findFilesandDirs
{
   chdir "..";
   @fileDirs = glob "*.txt";

#seperate out the lengths of the file or directory names

   for ( sort @fileDirs )
   {
      #only get four digit files no letters
      if( /^(\d{4}\.txt)$/ )
      {
         @fourCharsLong[ $fouritem++ ] = $1;
      }
   }

#if there are no four character long file names do not display anything

   if( scalar @fourCharsLong )
   {
      print "\n<SELECT id=\"sel_Transcripts\" name=\"sel_Transcripts\" style=\"WIDTH: 200px\">\n";
      print "<OPTION></OPTION>\n";
      for $item ( @fourCharsLong )
      {
         if( ( $item ) && ( -f $item ) )
         {
            &readFile( $item );
            chomp @fileContents;
            if( $fileContents[ 0 ] ne "invalid" )
            {
               print "<OPTION>$fileContents[ 0 ] - $item</OPTION>\n";
            }
         }
      }

      print "</SELECT>\n";
      print "<INPUT id=\"Button1\" type=\"submit\" value=\"Show Transcript\" name=\"Button1\">&nbsp;&nbsp\n";
   }
   else
   {
      print "<b>No files with the extention of \'txt\' where found</b><br>\n";
   }
}
