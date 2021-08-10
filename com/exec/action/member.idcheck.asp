<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_ID

   MEM_ID = Trim(Request.Form("mem_id"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT MEM_SEQ FROM " & MEM_LST_Table & " WHERE MEM_ID='" & MEM_ID & "' AND MEM_STATE < '90'"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      response.write "false"
   Else
      response.write "true"
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing
%>