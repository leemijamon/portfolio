<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc"-->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   If NAVER_TOKEN = "" Then Response.end

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_READ_MT,BC_WRITE_MT,BC_MEM_SEQ

   Dim BOARD_LST_Table
   BOARD_LST_Table = "BOARD_LST"

   Dim B_SEQ,B_PTSEQ,B_PSEQ,B_PSORT,B_PDEPTH,B_TITLE,B_CONT,B_FILE_NAME,B_FILE_SIZE,B_READ_CNT
   Dim B_RECO_CNT,B_IP,B_WDATE,B_MDATE,B_STATE,B_MEM_SEQ,B_MEM_NAME

   BC_SEQ = Trim(Request("bc_seq"))
   B_SEQ = Trim(Request("b_seq"))

   If IsNumeric(BC_SEQ) = false Then Response.End
   If IsNumeric(B_SEQ) = false Then Response.End

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      BC_NAME = Rs("BC_NAME")
      BC_READ_MT = Rs("BC_READ_MT")
      BC_SYNDI = Rs("BC_SYNDI")
   End If
   Rs.close

   '신디연동, 비회원읽기
   If BC_SYNDI <> "1" AND BC_READ_MT <> "99" Then Response.End

   SQL = "SELECT *, MEM_NAME = (SELECT MEM_NAME FROM MEM_LST WHERE MEM_LST.MEM_SEQ=BOARD_LST.MEM_SEQ) FROM " & BOARD_LST_Table _
       & " WHERE B_SEQ=" & B_SEQ

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      B_SECRET = Rs("B_SECRET")
   End If
   Rs.close

   '비밀글
   If B_SECRET = "1" Then Response.End

   self_url = Trim(Request("self_url"))

   ON ERROR RESUME Next

   Dim targetUrl
   targetUrl = "https://apis.naver.com/crawl/nsyndi/v2"

   Dim requestData
   Dim objXMLHTTP, objResult

   requestData = "http://" & CS_URL & "/exec/syndi/board.syndieco.asp?bc_seq=" & bc_seq & "&b_seq=" & b_seq & "&self_url=" & self_url
   'response.write requestData
   'response.end
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
   'objXMLHTTP.setRequestHeader "Authorization", NAVER_TOKEN '토큰값 넣으세요.
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
