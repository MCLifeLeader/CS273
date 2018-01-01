#!/usr/bin/perl

#  Homework 12
#  Brother Twitchell, CS 273
#  Brother Michael Carey

alarm 10;

#####################################################
# DEBUG Control
#####################################################
# 0 == Turn Debug off.
# 1 == Results from System level commands, globbing, etc (OS level calls)
# 2 == All File Content ( readfile.lib *sub readFile* )
# 3 == Environment Variables
# 4 == car03009.pl
# 5 == initEnv.lib
# 6 == ParseTranscript.lib
# 7 == readFile.lib
# 8 == webPageText.lib
# 9 == createReport.lib
# 10 == parseTranscript.lib
# 11 == parseDataFiles.lib
# 12 == compare.lib ( sub beginCompareProcess )
# 13 == compare.lib ( sub parseDataArray )
# 14 == compare.lib ( sub findOtherClasses )
# 15 == compare.lib ( sub dotheCompare )
#####################################################

$DEBUG = 0;

if( ( $ENV{'QUERY_STRING'} > 0 ) && ( $DEBUG == 0 ) )
{
   $DEBUG = $ENV{'QUERY_STRING'};
}

#####################################################
# REQUIRED Code Modules
#####################################################
require 'debug.lib';
require 'formparse.lib';
require 'initEnv.lib';
require 'createReport.lib';
require 'readFile.lib';
require 'webPageText.lib';
#####################################################

system( "clear" );

&opening1;
&defaultTitle;
&opening2;

&InitOSandPath;      #initialize OS variables
&parse_Form;         #Parse the posted web information

&debugEnv if $DEBUG == 3;

if( ( $form{'Button1'} eq "Show Transcript" ) &&
    ( $form{'sel_Transcripts'} ne "Select an Item" ) )
{
   #
   # Make sure that the Major file has actually been selected
   #
   if( $form{'sel_MajorDataFiles'} ne "Select an Item" )
   {
      $_ = $form{'sel_MajorDataFiles'};
      /([a-zA-Z]{1,}-\d{3}(-\d{2})?(bs|ba))\.txt/;
      $majorFile = $1;

      &getDataFileContents( $form{'sel_Transcripts'}, $form{'sel_MajorDataFiles'}, $form{'sel_MinorDataFiles'} );

      &debugWriteHash( \%form, "car03009.pl", "main", "\%form" ) if $DEBUG == 4;
      my $minorStatus = 0;
      
      for( my $iCount = 0; $iCount < scalar @majorContent; $iCount++ )
      {
         /()/;
         if( @majorContent[ $iCount ] =~  /(\w*Minor\w*)/ )
         {
            $minorStatus = ($1);
            last;
         }
      }
      
      #
      # Check to see if they are required to have a minor selected
      #
      if( "\L$minorStatus" eq "\LMinorRequired" )
      {
         #
         # Check to see if they have selected a minor
         #
         if( $form{'sel_MinorDataFiles'} ne "Select an Item" )
         {
            $_ = $form{'sel_MinorDataFiles'};
            /([a-zA-Z]{1,}-\d{3}m)\.txt/;
            $minorFile = $1;
            
            #
            # Check for major and minor conflicts
            #
            for( my $iCount = 0; $iCount < scalar @mmConflicts; $iCount++ )
            {
               unless( $mmConflicts[$iCount] =~ /:/ )
               {
                  next;
               }
               elsif( $mmConflicts[$iCount] =~ /$majorFile/ )
               {
						@checkMMconflicts = split (/:/, $mmConflicts[$iCount] );

						&debugWriteArray( \@checkMMconflicts, "car03009.pl", "main", "\@checkMMconflicts" ) if $DEBUG == 4;

                  #
                  # Check to see if the conflict is there
                  #
						if( $majorFile eq $checkMMconflicts[0] )
						{
							debugWriteLine( $majorFile, "car03009.pl", "main", "\$majorFile" ) if $DEBUG == 4;

							for( my $iCount2 = 1; $iCount2 < scalar @checkMMconflicts; $iCount2++ )
							{
								if( $minorFile eq $checkMMconflicts[$iCount2] )
								{
									debugWriteLine( $minorFile, "car03009.pl", "main", "\$minorFile" ) if $DEBUG == 4;
									$mmConflict = 1;
									last;
								}
							}
							last if( $mmConflict == 1 );
						}
               }
            }

            #
            # Create the report no issues
            #
            if( $mmConflict == 0 )
            {
               &createProgressReport;
            }
            else
            {
               print "<h2>The Minor conflicts with the Major</h2>\n";
               &createSelectBox;
            }
         }
         else
         {
            print "<h2>Please Select a Minor with this Major</h2>\n";
            &createSelectBox;
         }
      }
      else
      {
         if( $form{'sel_MinorDataFiles'} ne "Select an Item" )
         {
            print "<h2>This Major does not allow a Minor</h2>\n";
            &createSelectBox;
         }
         else
         {
            &createProgressReport;
         }
      }
   }
   else
   {
      print "<h2>Please select a Major</h2>\n";
      &createSelectBox;
   }
}
else
{
   #
   # Check to see if a name has been selected or not.
   #
   if( $form{'Button1'} eq "Show Transcript" )
   {
      print "<h2>Please select a Name</h2>\n";      
   }
   
   &createSelectBox;
}

&ending;
