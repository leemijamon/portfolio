<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc"-->
<!-- #include virtual = "/exec/module/send_function.inc"-->
<!-- #include virtual = "/exec/module/page_function.inc"-->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   senderPhone = Replace(Replace(Trim(Request("cbnumber")), "-", ""), ".", "")    '#### 발신자 번호 ####
   smsContent = Replace(Trim(Request.form("msg")),"'","''")

   r_key = Trim(Request("r_key"))

   If smsContent = "" Then
      Alert_Msg "전송할 메세지가 없습니다."
      Response.end
   End If

   SmsCount = Sms_Count(SMS_ID,SMS_PWD)

   If r_key = "rnumber" Then
      Send_Count = 1
      If SmsCount < Send_Count Then
         Alert_Msg "SMS 충전량이 부족합니다\n\n충전 후 이용하실수 있습니다."
         Response.end
      End If

      receivePhone = Replace(Replace(Trim(Request("rnumber")), "-", ""), ".", "")

      result = Sms_Send(SMS_ID,SMS_PWD,receivePhone,senderPhone,smsContent)

      If result = "1" Then
         Send_End Send_Count, receivePhone
      Else
         Rtn_Error
      End if
   Else
      Send_Count = Request("rnumbers").count

      If SmsCount < Send_Count Then
         Alert_Msg "SMS 충전량이 부족합니다\n\n충전 후 이용하실수 있습니다."
         Response.end
      End If

      For fn = 1 to Send_Count
         Split_Number = Split(Replace(Replace(Trim(Request("rnumbers")(fn)), "-", ""), ".", ""),"|")
         receivePhone = receivePhone & Split_Number(1)
         If fn <> Send_Count Then receivePhone = receivePhone & ","
      Next

      result = Sms_Send(SMS_ID,SMS_PWD,receivePhone,senderPhone,smsContent)
      Send_End Send_Count, receivePhone
   End If

   Sub Send_End(SS_CNT,SS_RNUM)
      msg = "전송 완료!!"
      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.closesms();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With

      response.end
   End Sub

   Sub Rtn_Error()
      Alert_Msg "네트웍 장애로 인히여 발송이되지 않았습니다.\n\n잠시후 다시 시도해 보세요."
      Response.end
   End Sub
%>

