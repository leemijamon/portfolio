<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   '### 접근 보안
   ADM_IP = Request.ServerVariables("Remote_Addr")
   ADM_URL = Request.ServerVariables("HTTP_REFERER")

   If InStr(ADM_IP, "58.120.167") > 0 Then ADM_CHECK = "Y"
   If InStr(ADM_URL, "www.helloweb.co.kr") > 0 Then ADM_CHECK = "Y"
   If InStr(ADM_URL, "admin.helloweb.co.kr") > 0 Then ADM_CHECK = "Y"

   If ADM_CHECK <> "Y" Then
      response.write "허용된 접근이 아닙니다."
      response.end
   End If

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT id AS DB_IDX, name AS DB_NAME FROM sysobjects WHERE xtype = 'U' AND status >= 0 ORDER BY name"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF OR Rs.EOF Then
      response.write "DB 세팅이 필요합니다."
      response.end
   End If
   Rs.close

   Dim ADMIN_LST_Table
   ADMIN_LST_Table = "ADMIN_LST"

   Dim ADM_ID,ADM_PWD
   Dim ADM_TYPE,ADM_STATE

   WHERE = "ADM_TYPE='00' AND ADM_STATE<'90'"
   SQL = "SELECT * FROM " & ADMIN_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Session("ADM_SEQ") = Rs("ADM_SEQ")
      Session("ADM_TYPE") = Rs("ADM_TYPE")
      Session("ADM_NAME") = Rs("ADM_NAME")
      Session("ADM_ID") = Rs("ADM_ID")
      Session("ADM_TEL") = Rs("ADM_TEL")
      Session("ADM_HP") = Rs("ADM_HP")
      Session("ADM_EMAIL") = Rs("ADM_EMAIL")
      Session("ADM_PERMIT") = Rs("ADM_PERMIT")
      Session("ADM_IP") = Request.ServerVariables("Remote_Addr")
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing

   '##코드 생성
   Server.Execute "/admin/exec/make.conf.asp"

   Response.Redirect "/admin"
   response.end
%>
