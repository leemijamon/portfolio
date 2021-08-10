<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim CMS_SKIN_LST_Table
   CMS_SKIN_LST_Table = "CMS_SKIN_LST"

   Dim CS_CODE,CS_STATE

   CS_SKIN = Trim(Request("skin"))
   CS_MODE = Trim(Request("mode"))
   CS_URL = Trim(Request("url"))

   If CS_SKIN <> "" Then
      Session("SKIN") = CS_SKIN
      Session("SKIN_MODE") = CS_MODE

      If CS_URL <> "" Then
         Response.Redirect Replace(CS_URL,"|","&")
      Else
         Response.Redirect "/index"
      End If
      Response.End
   Else
      Dim Conn, Rs
      Set Conn = Server.CreateObject("ADODB.Connection")
      Conn.Open Application("connect")

      SQL = "SELECT CS_CODE FROM " & CMS_SKIN_LST_Table & " WHERE CS_STATE='01'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Session("SKIN") = Rs("CS_CODE")
      End If
      Rs.close

      Session("SKIN_MODE") = ""

      Response.Redirect "/index"
      Response.End
   End If
%>