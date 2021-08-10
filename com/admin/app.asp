<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   '## 컴포넌트 인증
   Dim oApp
   Set oApp = Server.CreateObject("Server.Appinfo")

   oApp.ReSetCertify()
   sCertify = oApp.GetCertifyType()
   spCertify = Split(sCertify,"|")
   CertifyIP = spCertify(0)
   CertifyVersion = spCertify(1)
%>

&nbsp;프로그램 인증정보 : <%=CertifyVersion%>버전 (<%=CertifyIP%>)

