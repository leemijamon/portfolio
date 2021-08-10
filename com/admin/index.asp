<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   'If Session("ADM_SEQ") = "" AND InStr(Request.ServerVariables("Remote_Addr"), "61.40.205.") > 0 Then
   '   Response.Redirect "/admin/link.asp"
   '   Response.end
   'End If

   If Request("action") <> "" Then
      If Action_Check(Request("action")) Then
         EXEC_FILE = "exec/" & Request("action") & ".asp"
      Else
         EXEC_FILE = "/useradmin/exec/" & Request("action") & ".asp"
      End If
   Else
      If IsEmpty(Session("ADM_SEQ")) Or IsNull(Session("ADM_SEQ")) Or Session("ADM_SEQ") = "" Then
         EXEC_FILE = "login.asp"
      Else
         layout_file = Server.MapPath("/useradmin") & "/layout.asp"

         If File_Exists(layout_file) Then
            EXEC_FILE = "/useradmin/layout.asp"
         Else
            EXEC_FILE = "layout.asp"
         End If
      End If
   End If

   Server.Execute(EXEC_FILE)
   Response.End

   Function Action_Check(straction)
      If straction = "conf" Then Action_Check = true : Exit Function
      If InStr(straction,"admin.") > 0 Then Action_Check = true : Exit Function
      If InStr(straction,"board.") > 0 Then Action_Check = true : Exit Function
      If InStr(straction,"conf.") > 0 Then Action_Check = true : Exit Function
      If InStr(straction,"member.") > 0 Then Action_Check = true : Exit Function
      If InStr(straction,"skin.") > 0 Then Action_Check = true : Exit Function
      If InStr(straction,"state.") > 0 Then Action_Check = true : Exit Function

      action_check = false
   End Function

   Function File_Exists(file)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")
      If (fso.FileExists(file)) Then
         File_Exists = True
      Else
         File_Exists = false
      End If
   End Function
%>