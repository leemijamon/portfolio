<!-- #include virtual = "/exec/module/md5.asp"-->
<%
   Sub MailRead()
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      file_path = Server.MapPath("/skin") & "\" & SKIN & "\mail\" & M_ITEM & ".html"

      If FileControl.FileExists(file_path) Then
         M_CONT = FileControl.ReadFile(file_path, "UTF-8")
      Else
         file_path = Server.MapPath("/exec") & "\mail\" & M_ITEM & ".html"

         M_CONT = FileControl.ReadFile(file_path, "UTF-8")
      End If

      Set FileControl = Nothing

      SERVER_NAME = Request.ServerVariables("SERVER_NAME")
      TOPLOGO = Replace(TOPLOGO, "/file/logo", "http://" & SERVER_NAME & "/file/logo")

      M_TITLE = Replace(M_TITLE, "{{회사명}}", CS_NAME)
      M_TITLE = Replace(M_TITLE, "{{사이트명}}", CB_NAME)

      M_CONT = Replace(M_CONT, "{{주소}}", CB_ADDR)
      M_CONT = Replace(M_CONT, "{{회사명}}", CS_NAME)
      M_CONT = Replace(M_CONT, "{{대표자}}", CB_CEO)
      M_CONT = Replace(M_CONT, "{{사업자등록번호}}", CB_CORPNUM)
      M_CONT = Replace(M_CONT, "{{통신판매신고}}", CB_MALLNUM)
      M_CONT = Replace(M_CONT, "{{개인정보책임자}}", CM_NAME)
      M_CONT = Replace(M_CONT, "{{전화번호}}", CB_TEL)
      M_CONT = Replace(M_CONT, "{{팩스}}", CB_FAX)
      M_CONT = Replace(M_CONT, "{{이메일}}", CM_EMAIL)
      M_CONT = Replace(M_CONT, "{{사이트명}}", CB_NAME)
      M_CONT = Replace(M_CONT, "{{사이트로고}}", TOPLOGO)

      M_CONT = Replace(M_CONT,"/exec/img", "http://" & SERVER_NAME & "/exec/img")
      M_CONT = Replace(M_CONT,"/skin/", "http://" & SERVER_NAME & "/skin/")
      M_CONT = Replace(M_CONT,"href=""/", "href=""http://" & SERVER_NAME & "/")
      M_CONT = Replace(M_CONT,"{{사이트링크}}", "http://" & SERVER_NAME)
   End Sub

   Sub Send_Mail(mFrom,mTo,mSubject,mbody)
      Set objMessage = Server.CreateObject("CDO.Message")
      Set objConfig = Server.CreateObject("CDO.Configuration")

      Set objFields = objConfig.Fields

      SMTP_SERVER = "smtp.helloweb.co.kr"
      'SMTP_SERVER = "localhost"
      SMTP_SERVERPORT = "9025"

      If AM_SMTP_USE = "1" AND AM_SMTP_DOMAIN <> "" AND IsNumeric(AM_SMTP_PORT) <> "" Then
         SMTP_SERVER = AM_SMTP_DOMAIN
         SMTP_SERVERPORT = AM_SMTP_PORT
         SMTP_SSL = AM_SMTP_SSL
         SMTP_ID = AM_SMTP_ID
         SMTP_PWD = AM_SMTP_PWD
      End If

      With objFields
        .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 ' 1: (SMTP), 2 : (SMTP)
        .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")  = SMTP_SERVER
        .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = SMTP_SERVERPORT
        .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30

        If SMTP_SSL = "1" Then
           .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = 1
        End If
        If SMTP_ID <> "" AND SMTP_PWD <> "" Then
           .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
           .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = SMTP_ID
           .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = SMTP_PWD
        End If
        .Update
      End With

      Set objMessage.Configuration = objConfig

      'On Error Resume Next

      With objMessage
        .From = mFrom
        .To = mTo
        .Subject = mSubject
        .HtmlBody = mbody
        .BodyPart.Charset="UTF-8" '/// 한글을 위해선 꼭 넣어 주어야 합니다.
        .HTMLBodyPart.Charset="UTF-8" '/// 한글을 위해선 꼭 넣어 주어야 합니다.
        .Send
      End With

      Set objFields = Nothing
      Set objConfig = Nothing
      Set objMessage = Nothing
   End Sub

   Function Sms_Count(smsID,smsPwd)
      WebService = "http://webservice.helloweb.co.kr/SMS.v.1/ServiceSMS.asmx"

      'GetSMSCount (아이디,hash_value)
      hash_value = MD5(smsID & smsPwd)

      Data = "<?xml version='1.0' encoding='utf-8'?>"
      Data = Data & "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
      Data = Data & "  <soap:Body>"
      Data = Data & "    <GetSMSCount xmlns='http://webservice.helloweb.co.kr'>"
      Data = Data & "      <SMS_ID>" & smsID & "</SMS_ID>"
      Data = Data & "      <SMS_HashData>" & hash_value & "</SMS_HashData>"
      Data = Data & "    </GetSMSCount>"
      Data = Data & "  </soap:Body>"
      Data = Data & "</soap:Envelope>"

      Dim SoapRequest
      Set SoapRequest = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
      SoapRequest.Open "POST", WebService , False
      SoapRequest.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
      SoapRequest.setRequestHeader "Content-Length", Len(Data)
      SoapRequest.setRequestHeader "SOAPAction", "http://webservice.helloweb.co.kr/GetSMSCount"
      SoapRequest.Send Data

      Set xdDoc = Server.CreateObject("MSXML2.DOMDocument.3.0")
      xdDoc.async=False
      xdDoc.load(SoapRequest.responsebody)
      Sms_Count = xdDoc.selectSingleNode("//GetSMSCountResult").text  ' // 노드 데이터 얻기
      Set SoapRequest = Nothing
      Set xdDoc = Nothing
   End Function

   Function Sms_Send(smsID,smsPwd,rPhone,sPhone,sContent)
      If LMS_ID <> "" AND LMS_PWD <> "" Then
         If chkByte(sContent) > 80 Then
            If Lms_Count(LMS_ID,LMS_PWD) > 0 Then
                LmsResult = Lms_Send(LMS_ID,LMS_PWD,rPhone,sPhone,CS_NAME,sContent)
                Sms_Send = LmsResult
                Exit Function
            End If
         End If
      End If

      rPhone = Replace(rPhone,"-","")
      sPhone = Replace(sPhone,"-","")

      WebService = "http://webservice.helloweb.co.kr/SMS.v.1/ServiceSMS.asmx"

      'SendSMS (아이디,hash_value,받는이 번호,보내는이 번호,전문내용)
      hash_value = MD5(smsID & smsPwd & rPhone)

      Data = "<?xml version='1.0' encoding='utf-8'?>"
      Data = Data & "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
      Data = Data & "  <soap:Body>"
      Data = Data & "    <SendSMS xmlns='http://webservice.helloweb.co.kr'>"
      Data = Data & "      <SMS_ID>" & smsID & "</SMS_ID>"
      Data = Data & "      <SMS_HashData>" & hash_value & "</SMS_HashData>"
      Data = Data & "      <R_PHONE>" & rPhone & "</R_PHONE>"
      Data = Data & "      <S_PHONE>" & sPhone & "</S_PHONE>"
      Data = Data & "      <MSG><![CDATA["& sContent &"]]></MSG>"
      Data = Data & "    </SendSMS>"
      Data = Data & "  </soap:Body>"
      Data = Data & "</soap:Envelope>"

      Dim SoapRequest
      Set SoapRequest = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
      SoapRequest.Open "POST", WebService , False
      SoapRequest.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
      SoapRequest.setRequestHeader "Content-Length", Len(Data)
      SoapRequest.setRequestHeader "SOAPAction", "http://webservice.helloweb.co.kr/SendSMS"
      SoapRequest.Send Data

      Set xdDoc = Server.CreateObject("MSXML2.DOMDocument.3.0")
      xdDoc.async=False
      xdDoc.load(SoapRequest.responsebody)
      Sms_Send = xdDoc.selectSingleNode("//SendSMSResult").text  ' // 노드 데이터 얻기
      Set SoapRequest = Nothing
      Set xdDoc = Nothing
   End Function

   Function Lms_Count(lmsID,lmsPwd)
      WebService = "http://webservice.helloweb.co.kr/LMS.v.1/ServiceLMS.asmx"

      'GetLMSCount (아이디,hash_value)
      hash_value = MD5(lmsID & lmsPwd)

      Data = "<?xml version='1.0' encoding='utf-8'?>"
      Data = Data & "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
      Data = Data & "  <soap:Body>"
      Data = Data & "    <GetLMSCount xmlns='http://webservice.helloweb.co.kr'>"
      Data = Data & "      <LMS_ID>" & lmsID & "</LMS_ID>"
      Data = Data & "      <LMS_HashData>" & hash_value & "</LMS_HashData>"
      Data = Data & "    </GetLMSCount>"
      Data = Data & "  </soap:Body>"
      Data = Data & "</soap:Envelope>"

      Dim SoapRequest
      Set SoapRequest = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
      SoapRequest.Open "POST", WebService , False
      SoapRequest.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
      SoapRequest.setRequestHeader "Content-Length", Len(Data)
      SoapRequest.setRequestHeader "SOAPAction", "http://webservice.helloweb.co.kr/GetLMSCount"
      SoapRequest.Send Data

      Set xdDoc = Server.CreateObject("MSXML2.DOMDocument.3.0")
      xdDoc.async=False
      xdDoc.load(SoapRequest.responsebody)
      Lms_Count = xdDoc.selectSingleNode("//GetLMSCountResult").text  ' // 노드 데이터 얻기
      Set SoapRequest = Nothing
      Set xdDoc = Nothing
   End Function

   Function Lms_Send(lmsID,lmsPwd,rPhone,sPhone,strSubject,strContent)
      rPhone = Replace(rPhone,"-","")
      sPhone = Replace(sPhone,"-","")

      WebService = "http://webservice.helloweb.co.kr/LMS.v.1/ServiceLMS.asmx"

      'SendLMS (아이디,hash_value,받는이 번호,보내는이 번호,전문내용)
      hash_value = MD5(lmsID & lmsPwd & rPhone)

      Data = "<?xml version='1.0' encoding='utf-8'?>"
      Data = Data & "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
      Data = Data & "  <soap:Body>"
      Data = Data & "    <SendLMS xmlns='http://webservice.helloweb.co.kr'>"
      Data = Data & "      <LMS_ID>" & lmsID & "</LMS_ID>"
      Data = Data & "      <LMS_HashData>" & hash_value & "</LMS_HashData>"
      Data = Data & "      <R_PHONE>" & rPhone & "</R_PHONE>"
      Data = Data & "      <S_PHONE>" & sPhone & "</S_PHONE>"
      Data = Data & "      <SUBJECT><![CDATA["& strSubject &"]]></SUBJECT>"
      Data = Data & "      <MSG><![CDATA["& strContent &"]]></MSG>"
      Data = Data & "    </SendLMS>"
      Data = Data & "  </soap:Body>"
      Data = Data & "</soap:Envelope>"

      Dim SoapRequest
      Set SoapRequest = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
      SoapRequest.Open "POST", WebService , False
      SoapRequest.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
      SoapRequest.setRequestHeader "Content-Length", Len(Data)
      SoapRequest.setRequestHeader "SOAPAction", "http://webservice.helloweb.co.kr/SendLMS"
      SoapRequest.Send Data

      Set xdDoc = Server.CreateObject("MSXML2.DOMDocument.3.0")
      xdDoc.async=False
      xdDoc.load(SoapRequest.responsebody)
      Lms_Send = xdDoc.selectSingleNode("//SendLMSResult").text  ' // 노드 데이터 얻기
      Set SoapRequest = Nothing
      Set xdDoc = Nothing
   End Function

   Function chkByte(strString)
      dim intPos, chrTemp, intLength
      '문자열 길이 초기화
      intLength = 0

      intPos = 1

      '문자열 길이만큼 돈다
      while ( intPos <= Len( strString ) )
        '문자열을 한문자씩 비교한다
        chrTemp = ASC(Mid( strString, intPos, 1))

        if chrTemp < 0 then '음수값(-)이 나오면 한글임
           intLength = intLength + 2 '한글일 경우 2바이트를 더한다
        else
           intLength = intLength + 1 '한글이 아닐경우 1바이트를 더한다
        end If

        intPos = intPos + 1
      wend

      chkByte = intLength
   End Function
%>