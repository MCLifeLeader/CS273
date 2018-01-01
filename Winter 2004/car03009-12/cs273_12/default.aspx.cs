using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace cs273_12
{
   /// <summary>
   /// Summary description for _default.
   /// </summary>
   public class _default : System.Web.UI.Page
   {
      bool bSpecialMajor   = false;
      Hashtable myClasses   = null;
      Hashtable peopleAndFiles   = null;

      protected ReadTranscripts readTranscriptData;
      protected System.Web.UI.WebControls.DropDownList ddl_Name;
      protected System.Web.UI.WebControls.DropDownList ddl_Major;
      protected System.Web.UI.WebControls.Button btn_ShowReport;
      protected System.Web.UI.WebControls.Panel p_HideInfo;
      protected System.Web.UI.WebControls.Label lbl_Required_CR;
      protected System.Web.UI.WebControls.Label lbl_Earned_CR;
      protected System.Web.UI.WebControls.Label lbl_Remaining_CR;
      protected System.Web.UI.WebControls.Label lbl_Progress_Rpt;
      protected System.Web.UI.WebControls.DropDownList ddl_Minor;
   
      private void Page_Load(object sender, System.EventArgs e)
      {
         Response.Redirect( "car03009.pl" );
         p_HideInfo.Visible = false;

         readTranscriptData = new ReadTranscripts( Request.Path, Request.PhysicalPath );
         
         if( !IsPostBack )
         {
            btn_ShowReport.Text = "Show Transcript";

            ddl_Name.Items.Add( "Select Student Name" );
            ddl_Major.Items.Add( "Select Major" );
            ddl_Minor.Items.Add( "Select Minor" );

            // get a list of filenames from the previous directory
            peopleAndFiles = readTranscriptData.GetPersonAndFilenames( );

            // Get some values from the hashtable
            IDictionaryEnumerator enForPeopleandFiles;
            enForPeopleandFiles = peopleAndFiles.GetEnumerator();

            // move through the hashtable record list
            while( enForPeopleandFiles.MoveNext( ) )
            {
               // grab the key values from the hashtable
               ddl_Name.Items.Add( enForPeopleandFiles.Key.ToString() );
            }

            ddl_Major.Items.Add( "Item 1" );
            ddl_Minor.Items.Add( "Item 1" );
         }

         // clear results text area
         lbl_Progress_Rpt.Text = "";

         //readTranscriptData;
      }

      #region Web Form Designer generated code
      override protected void OnInit(EventArgs e)
      {
         //
         // CODEGEN: This call is required by the ASP.NET Web Form Designer.
         //
         InitializeComponent();
         base.OnInit(e);
      }
      
      /// <summary>
      /// Required method for Designer support - do not modify
      /// the contents of this method with the code editor.
      /// </summary>
      private void InitializeComponent()
      {    
         this.ddl_Name.SelectedIndexChanged += new System.EventHandler(this.ddl_Name_SelectedIndexChanged);
         this.ddl_Major.SelectedIndexChanged += new System.EventHandler(this.ddl_Major_SelectedIndexChanged);
         this.ddl_Minor.SelectedIndexChanged += new System.EventHandler(this.ddl_Minor_SelectedIndexChanged);
         this.btn_ShowReport.Click += new System.EventHandler(this.btn_ShowReport_Click);
         this.Load += new System.EventHandler(this.Page_Load);

      }
      #endregion

      private void btn_ShowReport_Click(object sender, System.EventArgs e)
      {
         lbl_Required_CR.Text      = "";
         lbl_Earned_CR.Text      = "";
         lbl_Remaining_CR.Text   = "";
         
         double GPATotal   = 0.0;
         double GPAEarned   = 0.0;
         double GPALeft      = 0.0;

         string [] myFiles      = null;
         string [] myContents   = null;

         if( ( ddl_Name.SelectedIndex - 1 ) >= 0 )
         {
            myContents   = readTranscriptData.GetFileContents( peopleAndFiles[ ddl_Name.SelectedItem.Value.ToString() ].ToString() );
            
            GPATotal      = readTranscriptData.GetGPATotal( Request.PhysicalApplicationPath );
            GPAEarned   = readTranscriptData.GetGPAEarned( myContents );

            myClasses   = readTranscriptData.GetClassesTaken( );
            
            // calculate the total credits left to earn
            GPALeft = GPATotal - GPAEarned;

            if( GPALeft < 0 )
               GPALeft = 0;

            lbl_Required_CR.Text      = GPATotal.ToString();
            lbl_Earned_CR.Text      = GPAEarned.ToString();
            lbl_Remaining_CR.Text   = GPALeft.ToString();
         }

         if( ddl_Name.SelectedIndex != 0 && ddl_Major.SelectedIndex != 0 && ( bSpecialMajor == true || ddl_Minor.SelectedIndex != 0 ) )
         {
            p_HideInfo.Visible = true;

            int iCount = 0;
            string [] myArray = new string [ myClasses.Count ];

            // Get some values from the hashtable
            IDictionaryEnumerator myEn;
            myEn = myClasses.GetEnumerator();

            // move through the hashtable record list
            while( myEn.MoveNext( ) )
            {
               // grab the key values from the hashtable
               myArray[ iCount++ ] = myEn.Key.ToString();
               lbl_Progress_Rpt.Text += myEn.Key + " : " + myEn.Value + "<br />";
            }

            // change the value in the hashtable using the keys aquired.
            foreach( string keyItem in myArray )
            {
               myClasses[ keyItem ] = "2";
            }
         }
      }

      private void ddl_Name_SelectedIndexChanged(object sender, System.EventArgs e)
      {
      
      }

      private void ddl_Major_SelectedIndexChanged(object sender, System.EventArgs e)
      {
      
      }

      private void ddl_Minor_SelectedIndexChanged(object sender, System.EventArgs e)
      {
      
      }
   }
}
