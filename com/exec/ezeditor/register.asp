<%@ LANGUAGE="VBSCRIPT" %>
<link rel="stylesheet" href="/exec/editor/css/contents4view.css" type="text/css">
<link rel="stylesheet" href="/exec/editor/css/highslide.css" type="text/css">
<script src="/exec/editor/js/highslide.js" type="text/javascript"></script>
<%
   Response.Expires = -1
   'Response.ContentType = "text/xml"

   'Session.CodePage = 949
   'Response.ChaRset = "euc-kr"

   With response
      .write "<table width='100%' border='0' cellspacing='1' cellpadding='0' bgcolor='#666666'>" & vbNewLine
      .write "  <tr height='23' align='center' bgcolor='#FFFFFF'>" & vbNewLine
      .write "    <td>º¯¼ö</td>" & vbNewLine
      .write "    <td>°ª</td>" & vbNewLine
      .write "  </tr>" & vbNewLine

      For each item in Request.Form
         For fcnt = 1 to Request.Form(item).Count
            .write "  <tr height='23' align='center' bgcolor='#FFFFFF'>" & vbNewLine
            .write "    <td>" & item & "</td>" & vbNewLine
            .write "    <td>" & Request.form(item)(fcnt) & "</td>" & vbNewLine
            .write "  </tr>" & vbNewLine
         Next
      Next

      .write "</table>" & vbNewLine
   End With
%>
