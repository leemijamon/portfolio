<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Session("MEM_SEQ") = ""
   Session("MEM_LEVEL") = ""
   Session("MEM_NAME") = ""
   Session("MEM_ID") = ""
   Session("MEM_HP") = ""
   Session("MEM_EMAIL") = ""
%>
