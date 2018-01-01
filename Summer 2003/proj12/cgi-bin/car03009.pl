#!/usr/bin/perl
#  Homework 11
#  Brother Twitchell, CS 273
#  Mike Carey
require 'classDataFiles.lib';
require 'formparse.lib';
require 'parseTranscript.lib';
require 'progressReport.lib';
require 'readFile.lib';
require 'webPageText.lib';

&Parse_Form;

if( ( $form{'Button1'} eq "Show Transcript" ) &&
    ( $form{'sel_Transcripts'} ne "Select an Item" ) &&
    ( ( $form{'sel_MajorDataFiles'} ne "Select an Item" ) ||
    ( $form{'sel_MinorDataFiles'} ne "Select an Item" ) ) )
{
   &opening1;

   &findClassDataFiles;
   &readTotalGradCredits;
   &readDataFiles;
   &findTranScripts;

   $form{'sel_Transcripts'} =~ /(\d{4}\.txt)/;
   print "<TITLE>Graduation Progress Report for $studentID{$&}<\/TITLE>\n";

   print "<\/head>";
   print "<body>";
   print "<h3>Graduation Progress Report<br>for $studentID{$&}</h3>";
   print "<form name=\"myTranscriptForm\" method=\"post\" ID=\"Form1\">";

   &createSelectBox;

   $creditCount = &parseTranscript;

   print "<HR>";
   print "<TABLE id=\"creditsTable\" cellSpacing=\"1\" ";
   print "cellPadding=\"1\" border=\"0\">";
   print "<tr><td>$graduationCredits</td><td>Required number of credits";
   print "</td></tr>";
   printf "<tr><td>%.1f</td><td>Earned credits</td></tr>", $creditCount;

   $creditTot = $graduationCredits - $creditCount;

   if( $creditTot < 0 )
   {
      $creditTot = "0.0";
   }
   printf "<tr><td><b>%1.1f</b></td><td><b>Remaining credits</b></td></tr>",
           $creditTot;

   print "</TABLE>";
   print "<HR>";

   &genProgressReport;
#   &genProgressReportTest;  #Turn on DEBUG CODE

   print "<HR><br>programming by Michael Carey ";
   &ending;
}
else
{
   &opening1;
   &defaultTitle;
   &opening2;
   &findClassDataFiles;
   &findTranScripts;
   &createSelectBox;
   &ending;
}
