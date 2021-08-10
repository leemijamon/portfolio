<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ,MEM_EMAIL

   MEM_SEQ = Session("EDIT_MEM_SEQ")
   MEM_EMAIL = Replace(Trim(Request.Form("mem_email")),"'","''")

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   If MEM_SEQ = "" Then
      SQL = "SELECT MEM_SEQ FROM " & MEM_LST_Table & " WHERE MEM_EMAIL='" & MEM_EMAIL & "' AND MEM_STATE < '90'"
   Else
      SQL = "SELECT MEM_SEQ FROM " & MEM_LST_Table & " WHERE MEM_EMAIL='" & MEM_EMAIL & "' AND MEM_SEQ <> " & MEM_SEQ & " AND MEM_STATE < '90'"
   End If

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
