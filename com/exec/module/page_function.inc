<%
   '//////////////////////////////////////////////////////////////////////////////////
   '// 페이지 이동 관련
   '////////////////////////////////// ///////////////////////////////////////////////

   Sub loadURL(msg,page)
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.loadURL('" & page & "');" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With
   End Sub

   Sub AjaxURL(msg,page)
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.AjaxURL('" & page & "');" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With
   End Sub

   Sub Alert_Msg(msg)
      with response
         .write "<script language='javascript'>" & vbNewLine
         .write "  alert('" & msg & "');" & vbNewLine
         .write "</script>" & vbNewLine
      End with
   End Sub

   Sub Page_Msg_Back(msg)
      with response
         .write "<script language='javascript'>" & vbNewLine
         .write "  alert('" & msg & "');" & vbNewLine
         .write "  history.back();" & vbNewLine
         .write "</script>" & vbNewLine
      End with
   End Sub

   Sub Page_Href(page)
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function page_href(){" & vbNewLine
         .write "     document.location.href='" & page & "';" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:page_href();'>" & vbNewLine
      End With
   End Sub

   Sub Page_Msg_Href(msg,page)
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     document.location.href='" & page & "';" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With
   End Sub

   Sub Page_ParentReload()
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_reload(){" & vbNewLine
         .write "     parent.location.reload();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_reload();'>" & vbNewLine
      End With
   End Sub

   Sub Page_Msg_ParentReload(msg)
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_msg_reload(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.location.reload();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_msg_reload();'>" & vbNewLine
      End With
   End Sub

   Sub Page_Parent_ScriptReload()
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_reload(){" & vbNewLine
         .write "     parent.page_reload();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_reload();'>" & vbNewLine
      End With
   End Sub

   Sub Page_Msg_Parent_ScriptReload(msg)
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_msg_reload(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.page_reload();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_msg_reload();'>" & vbNewLine
      End With
   End Sub

   Sub Page_Parent_Href(page)
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_href(){" & vbNewLine
         .write "     parent.location.href='" & page & "';" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_href();'>" & vbNewLine
      End With
   End Sub

   Sub Page_Msg_Parent_Href(msg,page)
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.location.href='" & page & "';" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_msg_href();'>" & vbNewLine
      End With
   End Sub

   Sub OpenPage_Close()
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function page_close(){" & vbNewLine
         .write "     window.close();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:page_close();'>" & vbNewLine
      End With
   End Sub

   Sub OpenPage_ReloadClose()
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function reloadclose(){" & vbNewLine
         .write "     opener.location.reload();" & vbNewLine
         .write "     window.close();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:reloadclose();'>" & vbNewLine
      End With
   End Sub

   Sub OpenPage_Msg_Close(msg)
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_close(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     window.close();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_close();'>" & vbNewLine
      End With
   End Sub

   Sub OpenPage_Msg_ReloadClose(msg)
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_reloadclose(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     top.opener.location.reload();" & vbNewLine
         .write "     top.close();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_reloadclose();'>" & vbNewLine
      End With
   End Sub
%>
