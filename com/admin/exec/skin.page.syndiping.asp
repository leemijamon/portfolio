<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc"-->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   If NAVER_TOKEN = "" Then Response.end

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CP_CODE,CP_TYPE,CP_NAME,CP_TITLE,CP_MEM_LEVEL,CP_CONT,CP_NUM,CP_PG_YN,CP_PG_ITEM
   Dim CP_PG_NAME,CP_PG_QUERY,CP_USE_YN

   CS_CODE = Trim(Request("cs_code"))
   CP_CODE = Trim(Request("cp_code"))
   CP_SEQ = Trim(Request("cp_seq"))

   If CP_SEQ <> "" Then
      WHERE = "CS_CODE='" & CS_CODE & "' AND CP_SEQ=" & CP_SEQ
   Else
      WHERE = "CS_CODE='" & CS_CODE & "' AND CP_CODE='" & CP_CODE & "'"
   End If

   SQL = "SELECT * FROM " & CMS_PAGE_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CP_CODE = Rs("CP_CODE")
      CP_PG_YN = Rs("CP_PG_YN")
      CP_USE_YN = Rs("CP_USE_YN")
      CP_SKIN = Rs("CP_SKIN")
      CP_MEM_LEVEL = Rs("CP_MEM_LEVEL")
   End If
   Rs.close

   If CP_PG_YN = "1" OR CP_PG_YN = "" OR CP_USE_YN = "0" OR CP_USE_YN = "" OR CP_SKIN <> "" OR CP_MEM_LEVEL <> "99" Then response.end

   ON ERROR RESUME Next

   Dim targetUrl
   targetUrl = "https://apis.naver.com/crawl/nsyndi/v2"

   Dim requestData
   Dim objXMLHTTP, objResult

   requestData = "http://" & CS_URL & "/exec/syndi/page.syndieco.asp?cs_code=" & cs_code & "&cp_code=" & cp_code
   requestData = "ping_url=" & requestData
   'requestData = "ping_url=" & Server.URLEncode(requestData)

   Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
   objXMLHTTP.open "POST", targetUrl, False
   objXMLHTTP.setRequestHeader "User-Agent","request"
   objXMLHTTP.setRequestHeader "Host","apis.naver.com"
   objXMLHTTP.setRequestHeader "Pragma","no-cache"
   objXMLHTTP.setRequestHeader "Accept","*/*"
   objXMLHTTP.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
   objXMLHTTP.setRequestHeader "Authorization", "Bearer " & NAVER_TOKEN '토큰값 넣으세요.
   objXMLHTTP.send requestData

   objResult = objXMLHTTP.responsebody

   'response.binaryWrite objResult
   'objResult값에서 error code값을 추출하여 000이 아니면 에러처리 하셔도 좋습니다.

   Set objXMLHTTP = nothing

   Dim strReturnString

   IF Err.Number<>0 Then
      strReturnString = "syndi_Error" '내부서버오류
   Else
      strReturnString = "syndi_Ok"
   End If

   'response.write strReturnString
%>