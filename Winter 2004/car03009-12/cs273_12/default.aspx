<%@ Page language="c#" Codebehind="default.aspx.cs" AutoEventWireup="false" Inherits="cs273_12._default" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
   <HEAD>
      <title>default</title>
      <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
      <meta content="C#" name="CODE_LANGUAGE">
      <meta content="JavaScript" name="vs_defaultClientScript">
      <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
   </HEAD>
   <body>
      <h3>Graduation Progress Report ( C# Version )</h3>
      <form id="Form1" method="post" runat="server">
         <TABLE id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0">
            <TR>
               <TD>Name</TD>
               <TD>Major</TD>
               <TD>Minor</TD>
            </TR>
            <TR>
               <TD>
                  <asp:DropDownList id="ddl_Name" runat="server" AutoPostBack="True"></asp:DropDownList></TD>
               <TD>
                  <asp:DropDownList id="ddl_Major" runat="server" AutoPostBack="True"></asp:DropDownList></TD>
               <TD>
                  <asp:DropDownList id="ddl_Minor" runat="server" AutoPostBack="True"></asp:DropDownList></TD>
            </TR>
         </TABLE>
         <br />
         <asp:Button id="btn_ShowReport" runat="server"></asp:Button></form>
      <asp:Panel id="p_HideInfo" runat="server" Height="272px" Visible="False">
<HR>

<TABLE id="creditsTable" cellSpacing="1" cellPadding="1" border="0">
            <TR>
               <TD>
                  <asp:Label id="lbl_Required_CR" runat="server"></asp:Label></TD>
               <TD>Required number of credits</TD>
            </TR>
            <TR>
               <TD>
                  <asp:Label id="lbl_Earned_CR" runat="server"></asp:Label></TD>
               <TD>Earned credits</TD>
            </TR>
            <TR>
               <TD><B>
                     <asp:Label id="lbl_Remaining_CR" runat="server"></asp:Label></B></TD>
               <TD><B>Remaining credits</B></TD>
            </TR>
         </TABLE>
<HR>

<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
            <TR>
               <TD>
                  <asp:Label id="lbl_Progress_Rpt" runat="server"></asp:Label></TD>
            </TR>
         </TABLE>
<HR>
programming by Michael Carey </asp:Panel>
   </body>
</HTML>
