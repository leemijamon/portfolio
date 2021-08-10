<%
   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   PATH_INFO = Request.ServerVariables("PATH_INFO")
   REMOTE_ADDR = Request.ServerVariables("REMOTE_ADDR")

   HTTP_URL = Request.ServerVariables("URL")
   R_QueryString = Request.ServerVariables("QUERY_STRING")

   SERVER_NAME = Request.ServerVariables("SERVER_NAME")
   HTTPS_STATE = Request.ServerVariables("HTTPS")

   URL = Trim(Request("url"))
   If URL = "" OR URL = "/index.asp" Then URL = "index"
   If Right(URL,1) = "/" Then URL = Left(URL,Len(URL)-1)

   If Left(URL,1) = "/" Then
      HTTP_URL = URL
   Else
      HTTP_URL = "/" & URL
   End If

   If R_QueryString <> "" Then
      R_QueryString = Replace(R_QueryString,"url=" & URL & "&","")
      R_QueryString = Replace(R_QueryString,"url=" & URL,"")
      R_QueryString = Replace(R_QueryString,"&","|")
   End If

   If R_QueryString <> "" Then HTTP_URL =  HTTP_URL & "?" & R_QueryString

   Rtn_Page = HTTP_URL
   'response.write Rtn_Page
   'Request.ServerVariables("HTTP_X_ORIGINAL_URL")

   If InStr(Rtn_Page,"member/login") <> 0 Then Rtn_Page = ""

   If IsEmpty(Session("MEM_SEQ")) Or IsNull(Session("MEM_SEQ")) Or Session("MEM_SEQ") = "" Or Session("MEM_IP") <> REMOTE_ADDR Then
      Login_check = "N"
      MEM_SEQ = ""
      MEM_LEVEL = "99"
   Else
      Login_check = "Y"

      MEM_SEQ = Session("MEM_SEQ")
      MEM_NAME = Session("MEM_NAME")
      MEM_ID = Session("MEM_ID")
      MEM_HP = Session("MEM_HP")
      MEM_EMAIL = Session("MEM_EMAIL")
      MEM_LEVEL = Session("MEM_LEVEL")
      MEM_AREA = Session("MEM_AREA")
   End If
%>
