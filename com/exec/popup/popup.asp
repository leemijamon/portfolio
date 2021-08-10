<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim POPUP_LST_Table
   POPUP_LST_Table = "POPUP_LST"

   Dim P_SEQ,P_TITLE,P_CONT,P_WHDTH,P_HEIGHT

   P_SEQ = Trim(Request("p_seq"))

   If IsNumeric(P_SEQ) = false Then Response.End

   SQL = "SELECT P_TITLE,P_CONT,P_WHDTH,P_HEIGHT FROM " & POPUP_LST_Table & " WHERE P_SEQ=" & P_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      P_TITLE = Rs("P_TITLE")
      P_CONT = Rs("P_CONT")
      'P_WHDTH = Rs("P_WHDTH")
      'P_HEIGHT = Rs("P_HEIGHT") + 26
   End If
   Rs.close

   P_NAME = P_SEQ & "pop"

   SQL = "UPDATE " & POPUP_LST_Table & " SET " _
       & "P_READCNT = P_READCNT + 1 " _
       & "WHERE P_SEQ=" & P_SEQ

   Conn.Execute SQL, ,adCmdText

   Conn.Close
   Set Conn = nothing
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>▒ <%=P_TITLE%> ▒</title>
<link href="/exec/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/exec/js/scripts.js"></script>
<style type="text/css">
p {margin: 0;}
</style>
</head>

<body style="margin:0pt;" onload="document.body.focus();">

<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td class="contents"><%=P_CONT%></td>
  </tr>
  <tr>
    <td height='27' bgcolor='#383838' align='right'><a href="javascript:popupclose('<%=P_NAME%>',true);"><img src='/exec/img/popup/today_close.gif' alt='오늘 하루 열지 않기' border='0'></a><img src='/exec/img/popup/popup_line.gif' border='0'><a href="javascript:popupclose('<%=P_NAME%>',false);"><img src='/exec/img/popup/popup_close.gif' alt='닫기' border='0'></a></td>
  </tr>
</table>

</body>
</html>
