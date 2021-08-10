<%
   PG_SKIN = PAGE_SKIN(PG_SEQ)
   PG_YN = PAGE_PG_YN(PG_SEQ)
   PG_ITEM = PAGE_PG_ITEM(PG_SEQ)

   'response.write PG_SKIN

   PG_METHOD = Trim(Request("method"))
   PG_URL = Replace(URL,"/",".") & ".asp"

   Set fso = CreateObject("Scripting.FileSystemObject")

   file_path = Server.MapPath("/skin") & "\" & SKIN & "\page\" & PG_URL
   file_url = "/skin/" & SKIN & "/page/" & PG_URL

   If fso.FileExists(file_path) Then
      If Session("SKIN_MODE") = "content" AND URL <> "index" Then
         response.write "<div id='contentarea'>" & vbNewLine

         Server.Execute(file_url)

         response.write "</div>" & vbNewLine

         response.write "<link href='/demo/content.css' rel='stylesheet'>" & vbNewLine
         response.write "<link href='/demo/contentbuilder.css' rel='stylesheet'>" & vbNewLine
         response.write "<script src='/demo/contentbuilder.js'></script>" & vbNewLine

         response.write "<script type='text/javascript'>" & vbNewLine
         response.write "  $(function() {" & vbNewLine
         response.write "    $('#contentarea').contentbuilder({" & vbNewLine
         response.write "      zoom: 1," & vbNewLine
         response.write "      snippetFile: '/demo/snippets.html'" & vbNewLine
         response.write "    });" & vbNewLine
         response.write "  });" & vbNewLine

         response.write "    function view() {" & vbNewLine
         response.write "        $('#contentarea').data('contentbuilder').viewHtml();" & vbNewLine
         response.write "    }" & vbNewLine

         response.write "    function save() {" & vbNewLine
         response.write "        var sHTML = $('#contentarea').data('contentbuilder').html();" & vbNewLine
         response.write "    }" & vbNewLine

         response.write "</script>" & vbNewLine
      Else
         Server.Execute(file_url)
      End If

      ContCheck = "Y"
   End If

   If PG_SKIN <> "" Then
      If PG_SKIN = "userskin" Then
         file_path = Server.MapPath("/") & "\skin\" & SKIN & "\userskin\" & PG_URL
         file_url = "/skin/" & SKIN & "/userskin/" & PG_URL
      Else
         file_path = Server.MapPath("/execskin") & "\" & PG_SKIN & "\page\" & PG_URL
         file_url = "/execskin/" & PG_SKIN & "/page/" & PG_URL
      End If

      If fso.FileExists(file_path) Then
         Server.Execute(file_url)
         ContCheck = "Y"
      End If
   End If

   If PG_YN = "1" AND PG_ITEM <> "" Then
      If PG_ITEM = "faq" Then
         response.write "<link href='/skin/default/css/board.css' rel='stylesheet' type='text/css'>" & vbNewLine
         SP_PG_EXEC = "/exec/board/faq.asp"
      End If

      If PG_ITEM = "qna" Then
         response.write "<link href='/skin/default/css/board.css' rel='stylesheet' type='text/css'>" & vbNewLine
         Select Case PG_METHOD
            Case "","list" : SP_PG_EXEC = "/exec/board/qna.list.asp"
            Case "view" : SP_PG_EXEC = "/exec/board/qna.view.asp"
            Case "reg" : SP_PG_EXEC = "/exec/board/qna.reg.asp"
         End Select
      End If

      If PG_ITEM = "board" Then
         response.write "<link href='/skin/default/css/board.css' rel='stylesheet' type='text/css'>" & vbNewLine
         SP_PG_EXEC = "/exec/board/board.asp"
      End If

      If PG_ITEM = "consult" Then SP_PG_EXEC = "/skin/" & SKIN & "/consult/consult.asp"

      Server.Execute(SP_PG_EXEC)
      ContCheck = "Y"
   End If

   If ContCheck <> "Y" Then
      not_file = "/skin/" & SKIN & "/execpage/nocontent.asp"
      Server.Execute(not_file)
   End If
%>