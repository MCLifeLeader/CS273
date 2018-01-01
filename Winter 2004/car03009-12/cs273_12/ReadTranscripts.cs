using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Text.RegularExpressions;

namespace cs273_12
{
   /// <summary>
   /// Summary description for ReadTranscripts.
   /// </summary>
   public class ReadTranscripts
   {
//      string [] fileNames      = null;
//      string [] personNames   = null;
      string [] fileContents   = null;

      Hashtable classesTaken   = null;
      Hashtable namesAndFiles = null;

      public ReadTranscripts()
      {

      }

      public ReadTranscripts( string Path, string PhysicalPath )
      {
         FileStream fstFile      = null;
         StreamReader fstReader   = null;
         string [] fileNames;

         try
         {
            // Create a regular expression for removing certain path info.
            string stPathInfo   = @"(([a-zA-Z]\:|\\)\\([^\\]+\\)*)" + Regex.Replace( Path, @"\/", @"\\" ).Substring( 2 );

            // Check the regular expression for a match
            System.Text.RegularExpressions.Match myMatch = Regex.Match( PhysicalPath, stPathInfo );

            // get a list of transcript files.
            fileNames = Directory.GetFiles( myMatch.Result( "$1" ), "*.txt" );

            // process each transcript file for the first name
            foreach( string fileName in fileNames )
            {
               string stInput;
               fstFile = new FileStream( fileName, FileMode.Open, FileAccess.Read, FileShare.Read );
               fstReader  = new StreamReader( fstFile );

               stInput = fstReader.ReadLine( );

               // make sure that each item has a "," in the name
               if( Regex.IsMatch( stInput, @"," ) )
               {
                  namesAndFiles.Add( stInput, fileName );
               }

               fstReader.Close();
               fstFile.Close();
            }

            // Sort and remove invalid records
            SortRecords();
         }
         catch
         {
            Debug.WriteLine( "Error in Reading Transcript files" );
         }
      }

      public Hashtable GetPersonAndFilenames( )
      {
         return( namesAndFiles );
      }

      public Hashtable GetClassesTaken( )
      {
         return( classesTaken );
      }

      public string [] GetFileContents( string fileName )
      {
         FileStream fstFile      = null;
         StreamReader fstReader   = null;

         System.Collections.ArrayList arlFileContents = new System.Collections.ArrayList( );

         try
         {
            fstFile = new FileStream( fileName, FileMode.Open, FileAccess.Read, FileShare.Read );
            fstReader  = new StreamReader( fstFile );
            
            string readLine;
            
            // remove firstline
            fstReader.ReadLine( );

            while( ( readLine = fstReader.ReadLine( ) ) != null )
            {
               arlFileContents.Add( readLine );
            }

            fstReader.Close();
            fstFile.Close();
         }
         catch
         {
            Debug.WriteLine( "Error in Reading Contents of Transcript File " + fileName );
         }

         // prepair to copy the file contents into a string array
         fileContents = new string [ arlFileContents.Count ];

         for( int iCount = 0; iCount<arlFileContents.Count; iCount++ )
            fileContents[ iCount ] = arlFileContents[ iCount ].ToString().Trim();

         arlFileContents.Clear();

         return( fileContents );
      }

      public double GetGPAEarned( string [] transcriptFile )
      {
         double gpaValue = 0.0;

         System.Text.RegularExpressions.Match myMatch;
         classesTaken = new Hashtable( );

         foreach( string line in transcriptFile )
         {
            myMatch = Regex.Match( line, @"^\s*(\w+[\s+\W?\w?]+\d+\w?)\s+(\d+\w?)\s+(\w*.+?)\s+(\d+\.\d+)\s+([A-Za-z\+\-]+)\s*(\w*)\s*$" );

            int myGrp = myMatch.Groups.Count;
                        
            //myMatch.Result( "$0" );  // This would return the base match value

            try
            {
               // only want to get the classes that have been compleated meeting proper requirements.
               if( Regex.IsMatch( myMatch.Groups[ 6 ].Value.ToString(), "Rpt", RegexOptions.IgnoreCase ) == false &&
                  Regex.IsMatch( myMatch.Groups[ 5 ].Value.ToString(), "(F|W)", RegexOptions.IgnoreCase ) == false )
               {
                  gpaValue += Convert.ToDouble( myMatch.Groups[ 4 ].Value.ToString() );
                  classesTaken.Add( Regex.Replace( myMatch.Groups[ 1 ].Value.ToString(), @"\s+", " " ), "1" );
               }
            }
            catch
            {
               Debug.WriteLine( "Bad GPA Value" );
            }
         }

         return( gpaValue );
      }

      public double GetGPATotal( string filePath )
      {
         FileStream fstFile      = null;
         StreamReader fstReader   = null;

         double gpaValue = 0.0;

         try
         {
            fstFile = new FileStream( filePath + "dataFiles\\credits.txt", FileMode.Open, FileAccess.Read, FileShare.Read );
            fstReader  = new StreamReader( fstFile );

            // read GPATotal
            gpaValue = Convert.ToDouble( fstReader.ReadLine( ).Trim() );

            fstReader.Close();
            fstFile.Close();
         }
         catch
         {
            Debug.WriteLine( "Error in Reading Contents of Transcript File " + filePath + "credits.txt" );
         }

         return( gpaValue );
      }

      private void SortRecords()
      {

      }
   }
}
