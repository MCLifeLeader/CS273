#!/usr/bin/perl

#  Homework 10
#  Brother Twitchell, CS 273
#  Brother Michael Carey

&opening1;              #opening html codes
&readFilesandDirs;      #display the *.txt files or dirs
&ending;                #closing html codes

# this is the opening value for one of the web pages
sub opening1
{
# create the html header information for the web page to be displayed
print <<EOT;
Content-type: text/html

<html>
<head>
<title>Directory and File Information</title>
</head>
<body>
<h1>Directory and File Information</h1>
<P>
EOT
}

#reads and identifies files and directories in the parent dir
sub readFilesandDirs
{
   chdir "..";                  #move to parent dir
   @fileDirs = glob "*.txt";    #find all the files/dirs of type *.txt

#seperate out the lengths of the file or directory names

   for $file ( sort @fileDirs )
   {
      if( length ($file) == 7 )
      {
         @threeCharsLong[ $threeitem++ ] = $file;
      }
      elsif( length ($file) == 8 )
      {
         @fourCharsLong[ $fouritem++ ] = $file;
      }
      else
      {
         @restofChars[ $restof++ ] = $file;
      }
   }

#specs
#plain file or directory
#size (in bytes)
#permission (rwx) - if the permission is not set, output a hyphen (-)
#number of days since last modification, to one decimal place

#if there are no three character long file names do not display anything
   if( scalar @threeCharsLong )
   {
      #create the table information headers
      print "<TABLE id=\"threeCharsLongID\" cellSpacing=\"1\" ";
      print "cellPadding=\"1\" border=\"1\">\n";
      print "<tr><td><b>File or Directory name with three ";
      print "Characters Long</b></td>";
      print "<td><b>Type</b></td><td><b>Size Byte\(s\)</b></td><td>";
      print "<b>Permissions</b></td>";
      print "<td><b>Days since last modification</b></td></tr>\n";
      for $item ( @threeCharsLong )
      {
         &buildTableContents( $item );  #build the table contents
      }

      print "</TABLE><br><br>";
   }

#if there are no four character long file names do not display anything
   if( scalar @fourCharsLong )
   {
      #create the table information headers
      print "<TABLE id=\"fourCharsLongID\" cellSpacing=\"1\" ";
      print "cellPadding=\"1\" border=\"1\">\n";
      print "<tr><td><b>File or Directory name with four Characters ";
      print "Long</b></td>";
      print "<td><b>Type</b></td><td><b>Size Byte\(s\)</b></td><td>";
      print "<b>Permissions</b></td>";
      print "<td><b>Days since last modification</b></td></tr>\n";
      for $item ( @fourCharsLong )
      {
         &buildTableContents( $item );  #build the table contents
      }

      print "</TABLE><br><br>";
   }

#if there are no five or more character long file names do not display
   if( scalar @restofChars )
   {
      #create the table information headers
      print "<TABLE id=\"restofCharsLongID\" cellSpacing=\"1\" ";
      print "cellPadding=\"1\" border=\"1\">\n";
      print "<tr><td><b>The rest of the File or Directory names not three ";
      print "of four Characters Long.</b></td>";
      print "<td><b>Type</b></td><td><b>Size Byte\(s\)</b></td><td>";
      print "<b>Permissions</b></td>";
      print "<td><b>Days since last modification</b></td></tr>\n";
      for $item ( @restofChars )
      {
         &buildTableContents( $item );  #build the table contents
      }

      print "</TABLE><br><br>";
   }

   # let the user know if no *.txt files/dirs where found
   if( ( scalar @restofChars == undef ) &&
       ( scalar @fourCharsLong == undef ) &&
       ( scalar @threeCharsLong == undef ) )
   {
      print "<B>There are no files or directories with the extention of ";
      print "\'txt\' found in the parent directory!<b><br>";
   }
}

#used to create the table rows and table data fields and populate the data
sub buildTableContents
{
#print the file or directory name
      print "<tr><td>@_[0]</td><td>";

#identify if a file or directory
      if( -d @_[0] )
      {
         print "Directory";
      }
      else
      {
         print "Plain File";
      }

#display the size of the file or directory
      print "</td><td>", -s @_[0] ,"</td><td>";

#display the permissions of the file or directory for the current user
      if( -r @_[0] )
      {
         print "r";
      }
      else
      {
         print "-";
      }
      if( -w @_[0] )
      {
         print "w";
      }
      else
      {
         print "-";
      }
      if( -x @_[0] )
      {
         print "x";
      }
      else
      {
         print "-";
      }

#display the age of the file relative to the running of this script
      printf "</td><td>%.1f</td></tr>", -M @_[0];
}

# this is the ending value for the web page every time.
sub ending
{
print <<EOT;
</body>
</html>
EOT
}
