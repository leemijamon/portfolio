<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Session("MEM_SEQ") = ""
   Session("MEM_NAME") = ""
   Session("MEM_REGNO") = ""
   Session("MEM_ID") = ""
   Session("MEM_SEX") = ""
   Session("MEM_HP") = ""
   Session("MEM_EMAIL") = ""
   Session("MEM_LEVEL") = ""
   Session("ARA_CODE") = ""
   Session("MEM_IP") = ""

   Response.Redirect "/"
   Response.End
%>