<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Response.Expires = 0
   Response.Buffer = True
   Response.Clear

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim filepath, filename, root_path, fso, root_folder, attachfile, objStream, strFile

   filepath = Request.QueryString("filepath")
   filename = Request.QueryString("filename")
   filepath = Replace(filepath,"/","\")

   root_path = server.MapPath("/")
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set root_folder = fso.GetFolder(root_path)

   attachfile = root_path & filepath & "\" & filename

   Response.Clear
   Response.ContentType = "application/unknown"
   Response.AddHeader "Pragma", "no-cache"
   Response.AddHeader "Expires", "0"
   Response.AddHeader "Content-Transfer-Encoding", "binary"
   Response.AddHeader "Content-Disposition","attachment; filename = " & Server.URLPathEncode(filename)

   Set objStream = Server.CreateObject("ADODB.Stream")
   objStream.Open

   objStream.Type = 1
   objStream.LoadFromFile attachfile

   Response.BinaryWrite objStream.Read
   Response.Flush

   objStream.Close : Set objStream = nothing

   Set fso = nothing
%>
