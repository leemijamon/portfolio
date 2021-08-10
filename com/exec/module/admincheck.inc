<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   PATH_INFO = Request.ServerVariables("PATH_INFO")
   REMOTE_ADDR = Request.ServerVariables("REMOTE_ADDR")

   HTTP_URL = Request.ServerVariables("URL")
   R_QueryString = Request.ServerVariables("QUERY_STRING")

   HTTPS_STATE = Request.ServerVariables("HTTPS")

   If IsEmpty(Session("ADM_SEQ")) Or IsNull(Session("ADM_SEQ")) Or Session("ADM_SEQ") = "" Then
      With response
         .write "<script LANGUAGE='JavaScript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  alert('다시 로그인 하십시오.');" & vbNewLine
         .write "  window.top.location.href='/admin';" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine
      End With
      Response.End
   End If

   If Session("ADM_IP") <> Request.ServerVariables("REMOTE_ADDR") Then
      With response
         .write "<script LANGUAGE='JavaScript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  alert('로그인 정보가 일치하지 않습니다.');" & vbNewLine
         .write "  window.top.location.href='/admin';" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine
      End With
      Response.End
   End If

   ADM_SEQ = Session("ADM_SEQ")
   ADM_TYPE = Session("ADM_TYPE")
   ADM_NAME = Session("ADM_NAME")
   ADM_ID = Session("ADM_ID")
   ADM_TEL = Session("ADM_TEL")
   ADM_HP = Session("ADM_HP")
   ADM_EMAIL = Session("ADM_EMAIL")
   ADM_PERMIT = Session("ADM_PERMIT")

   PATH_INFO = Replace(PATH_INFO,"/admin/","")
   PATH_INFO = Replace(PATH_INFO,"/useradmin/","")
   PATH_INFO = Replace(PATH_INFO,"page/","")

   S_PATH = Split(PATH_INFO, ".")
   ADM_PATH = S_PATH(0)

   If ADM_PATH = "conf" Then ADM_PATH = "config"
   If ADM_PATH = "skin" Then ADM_PATH = "design"

   If Session("ADM_TYPE") <> "00" AND InStr(Session("ADM_PERMIT"), ADM_PATH) = 0 AND ADM_PATH <> "index" Then
      Response.Redirect "/admin/permission.asp"
      Response.End
   End If
%>