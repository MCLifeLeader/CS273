<%

   Dim RegEx
   Set regEx = new RegExp
   regEx.Pattern = "[\W\s]*" 
   regEx.Global = True
   regEx.IgnoreCase = True

   Dim myStr
   myStr = "BYU-Idaho Presents:Kathy MatteaFriday, January 30, 2004"
   myStr = regEx.Replace( myStr, "" )
   
   Response.Write( myStr )

%>