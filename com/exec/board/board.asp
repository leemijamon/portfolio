<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<%
   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_READ_MT,BC_WRITE_MT,BC_MEM_SEQ

   BC_SEQ = Trim(Request("bc_seq"))
   BC_METHOD = Trim(Request("method"))

   If IsNumeric(BC_SEQ) = false Then Response.End

   SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      BC_SKIN = Rs("BC_SKIN")
      BC_TYPE = Rs("BC_TYPE")
      BC_LIST = Rs("BC_LIST")
   End If
   Rs.close

   If IsNULL(BC_SKIN) OR BC_SKIN = "" Then BC_SKIN = "default"

   If BC_SKIN = "userskin" Then
      SKIN_PATH = "/skin/" & SKIN & "/board"
   Else
      SKIN_PATH = "/exec/board/" & BC_SKIN
   End If

   Conn.Close
   Set Conn = nothing

   BC_PAGE = "board"
   'If BC_TYPE < "05" Then BC_PAGE = "board"
   'If BC_TYPE = "05" Then BC_PAGE = "schedule"

   Select Case BC_METHOD
      Case "","list" : exec_file = SKIN_PATH & "/" & BC_PAGE & "_list.asp"
      Case "write","edit","reply" : exec_file = SKIN_PATH & "/" & BC_PAGE & "_write.asp"
      Case "view" : exec_file = SKIN_PATH & "/" & BC_PAGE & "_view.asp"
      Case "passlist","passview","passedit","passdel","passcommdel" : exec_file = SKIN_PATH & "/password.asp"
   End Select

'response.write exec_file
   Server.Execute(exec_file)

   If BC_METHOD = "view" AND BC_LIST = "1" Then
      exec_file = SKIN_PATH & "/" & BC_PAGE & "_list.asp"
      Server.Execute(exec_file)
   End If
%>
