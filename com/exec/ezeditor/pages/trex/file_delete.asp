<%@ LANGUAGE="VBSCRIPT" %>
<%
   Response.Expires = -10000
   Server.ScriptTimeOut = 7200

   Session.CodePage = 949
   Response.ChaRset = "euc-kr"

   Dim filepath, filename, root_path, fso, root_folder, attachfile, objStream, strFile

   filepath = Request.QueryString("filepath")
   filename = Request.QueryString("filename")
   filepath = Replace(filepath,"/","\")

   root_path = server.MapPath("/")
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set root_folder = fso.GetFolder(root_path)

   If root_folder.IsRootFolder = True Then
      attachfile = root_path & filepath & "\" & filename
   Else
      attachfile = root_path & "\" & filepath & "\" & filename
   End If

   If (fso.FileExists(attachfile)) Then
      fso.DeleteFile(attachfile)
   End If
   Set fso = nothing

   Response.write "ok"
   Response.end
%>
