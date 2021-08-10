<%
   '######## 사이즈
   Function f_file_size(size)
      If int(size) < 1024 Then
         f_file_size = size & " Byte"
      ElseIf int(size) < 1024^2 Then
         f_file_size = Round((size/1024),2) & " KB"
      ElseIf int(size) < 1024^3 Then
         f_file_size = Round((size/(1024^2)),2) & " MB"
      Else
         f_file_size = Round((size/(1024^3)),2) & " GB"
      End If
   End Function

   Function f_size(size)
      If int(size) < 1024 Then
         f_size = size & " MB"
      Else
         f_size = Round(size/1024,2) & " GB"
      End If
   End Function

   Function f_byte_size(size)
      f_byte_size = 0
      If InStr(size,"MB") Then f_byte_size = int(Replace(size,"MB","")) * 1024^2
      If InStr(size,"GB") Then f_byte_size = int(Replace(size,"GB","")) * 1024^3
   End Function

   Function f_size_opt(cd_size)
      If InStr(cd_size,",") > 0 Then
         s_code = Split(cd_size,",")

         For fn = 0 to UBound(s_code)
            s_name = f_size(s_code(fn))
            rtn_str = rtn_str & "  <option value=""" & s_code(fn) & """>" & s_name & "</option>" & vbNewLine
         Next
      Else
         s_name = f_size(cd_size)
         rtn_str = rtn_str & "  <option value=""" & cd_size & """>" & s_name & "</option>" & vbNewLine
      End If

      f_size_opt = rtn_str
   End Function

   '######## 날짜 변환
   Function f_chang_time(c_date)
      If Len(c_date) > 11 Then
         f_chang_time = mid(c_date,1,4) & "/" & mid(c_date,5,2) & "/" & mid(c_date,7,2) & " " & mid(c_date,9,2) & ":" & mid(c_date,11,2)
      Else
         f_chang_time = ""
      End If
   End Function

   Function f_chang_date(c_date)
      If Len(c_date) > 7 Then
         f_chang_date = mid(c_date,1,4) & "/" & mid(c_date,5,2) & "/" & mid(c_date,7,2)
      Else
         f_chang_date = ""
      End If
   End Function

   Function f_date(c_date,c_txt)
      If Len(c_date) > 7 Then
         f_date = mid(c_date,1,4) & c_txt & mid(c_date,5,2) & c_txt & mid(c_date,7,2)
      Else
         f_date = ""
      End If
   End Function

   Function f_formatdate(c_date,c_format)
      Select Case c_format
         Case "M"
            f_formatdate = mid(c_date,5,2) & "." & mid(c_date,7,2)
         Case "Y"
            f_formatdate = mid(c_date,3,2) & "." & mid(c_date,5,2) & "." & mid(c_date,7,2)
         Case "T"
            f_formatdate = mid(c_date,1,4) & "." & mid(c_date,5,2) & "." & mid(c_date,7,2) & " " & mid(c_date,9,2) & ":" & mid(c_date,11,2)
         Case Else
            f_formatdate = mid(c_date,1,4) & "." & mid(c_date,5,2) & "." & mid(c_date,7,2)
      End Select
   End Function

   '######## 코드 -> HTML
   Function f_arr_select(input_nm,cd_code,cd_name)
      rtn_str = rtn_str & "<select name=""" & input_nm & """>" & vbNewLine
      rtn_str = rtn_str & "  <option value="""">선택하세요</option>" & vbNewLine
      rtn_str = rtn_str & "  <option value="""">--------------</option>" & vbNewLine

      If InStr(cd_code,",") > 0 Then
         s_code = Split(cd_code,",")
         s_name = Split(cd_name,",")
         For fn = 0 to UBound(s_code)
            rtn_str = rtn_str & "  <option value=""" & s_code(fn) & """>" & s_name(fn) & "</option>" & vbNewLine
         Next
      Else
         rtn_str = rtn_str & "  <option value=""" & cd_code & """>" & cd_name & "</option>" & vbNewLine
      End If

      rtn_str = rtn_str & "</select>" & vbNewLine

      f_arr_select = rtn_str
   End Function

   Function f_arr_opt(cd_code,cd_name)
      If InStr(cd_code,",") > 0 Then
         s_code = Split(cd_code,",")
         s_name = Split(cd_name,",")
         For fn = 0 to UBound(s_code)
            rtn_str = rtn_str & "  <option value=""" & s_code(fn) & """>" & s_name(fn) & "</option>" & vbNewLine
         Next
      Else
         rtn_str = rtn_str & "  <option value=""" & cd_code & """>" & cd_name & "</option>" & vbNewLine
      End If

      f_arr_opt = rtn_str
   End Function

   Function f_arr_opt2(cd_code,cd_name,cd_name2)
      If InStr(cd_code,",") > 0 Then
         s_code = Split(cd_code,",")
         s_name = Split(cd_name,",")
         s_name2 = Split(cd_name2,",")
         For fn = 0 to UBound(s_code)
            rtn_str = rtn_str & "  <option value=""" & s_code(fn) & """>" & s_name(fn) & " - " & s_name2(fn) & "</option>" & vbNewLine
         Next
      Else
         rtn_str = rtn_str & "  <option value=""" & cd_code & """>" & cd_name & " - " & cd_name2 & "</option>" & vbNewLine
      End If

      f_arr_opt2 = rtn_str
   End Function

   Function f_arr_radio(input_nm,cd_code,cd_name)
      If InStr(cd_code,",") > 0 Then
         s_code = Split(cd_code,",")
         s_name = Split(cd_name,",")

         For fn = 0 to UBound(s_code)
            rtn_str = rtn_str & "<input type=""radio"" name=""" & input_nm & """ value=""" & s_code(fn) & """>" & s_name(fn) & " " & vbNewLine
         Next
      Else
         rtn_str = rtn_str & "<input type=""radio"" name=""" & input_nm & """ value=""" & cd_code & """>" & cd_name & " " & vbNewLine
      End If

      f_arr_radio = rtn_str
   End Function

   Function f_arr_checkbox(input_nm,cd_code,cd_name)
      If InStr(cd_code,",") > 0 Then
         s_code = Split(cd_code,",")
         s_name = Split(cd_name,",")

         For fn = 0 to UBound(s_code)
            rtn_str = rtn_str & "<input type=""checkbox"" name=""" & input_nm & """ value=""" & s_code(fn) & """>" & s_name(fn) & " " & vbNewLine
         Next
      Else
         rtn_str = rtn_str & "<input type=""checkbox"" name=""" & input_nm & """ value=""" & cd_code & """>" & cd_name & " " & vbNewLine
      End If

      f_arr_checkbox = rtn_str
   End Function

   '###### 코드값 리턴
   Function f_arr_value(cd_code,cd_name,sel_code)
      f_arr_value = ""

      If InStr(cd_code,",") > 0 Then
         s_code = Split(cd_code,",")
         s_name = Split(cd_name,",")

         For fn = 0 to UBound(s_code)
            If s_code(fn) = sel_code Then
               f_arr_value = s_name(fn)
               Exit For
            End If
         Next
      Else
         If cd_code = sel_code Then f_arr_value = cd_name
      End If

      f_arr_value = Replace(f_arr_value,"|",",")
   End Function

   '###### 코드값 리턴
   Function f_querystring_value(str_querystring,search_key)
      f_querystring_value = ""

      If InStr(str_querystring,"&") > 0 AND InStr(str_querystring,search_key & "=") > 0 Then
         sp_querystring = Split(str_querystring,"&")

         For fn = 0 to UBound(sp_querystring)
            If InStr(sp_querystring(fn),search_key & "=") > 0 Then
               f_querystring_value = Split(sp_querystring(fn),"=")(1)
               Exit For
            End If
         Next
      End If
   End Function

   '###### 제목 HTML 변경
   Function f_html_title(str_cont)
      If IsNULL(str_cont) = false AND str_cont <> "" Then
         str_cont = Replace(str_cont,"<","&lt;")
         str_cont = Replace(str_cont,">","&gt;")
         str_cont = Replace(str_cont, chr(13)&chr(10), chr(13)&chr(10) & "<br>")
      End If

      f_html_title = str_cont
   End Function

   '###### 내용 HTML 변경 / 줄바꿈
   Function f_html_cont(str_cont)
      If IsNULL(str_cont) = false AND str_cont <> "" Then
         str_cont = Replace(str_cont,"<","&lt;")
         str_cont = Replace(str_cont,">","&gt;")
         str_cont = Replace(str_cont, chr(13)&chr(10), chr(13)&chr(10) & "<br>")
      End If

      f_html_cont = str_cont
   End Function

   Function GetHTMLBin(URLaddress)
      Dim Http
      Set Http = CreateObject("Microsoft.XMLHTTP")

      On error resume next
      Http.Open "GET", URLaddress, False
      Http.setRequestHeader "Accept-Language","ko"

      result=Http.Send
      GetHTMLBin = Http.responseText

      Set Http = Nothing
   End Function

   ' ===========================
   '  Function to GetHTMLBinBody
   ' ===========================

   Function GetHTMLBinBody(URLaddress)
      On error resume next
      Dim Http
      Set Http = CreateObject("Microsoft.XMLHTTP")
      Http.Open "GET", URLaddress, False
      Http.Send
      GetHTMLBinBody = BinToText(Http.responseBody,32000)
      Set Http = Nothing
   End Function

   ' ===========================
   '  Function to BinToText
   ' ===========================

   Function BinToText(varBinData, intDataSizeInBytes)
      Const adFldLong = &H00000080
      Const adVarChar = 200

      Set objRS = CreateObject("ADODB.Recordset")
      objRS.Fields.Append "txt", adVarChar, intDataSizeInBytes, adFldLong
      objRS.Open
      objRS.AddNew
      objRS.Fields("txt").AppendChunk varBinData
      BinToText = objRS("txt").Value
      objRS.Close
      Set objRS = Nothing
   End Function

   Function GetMonWeekStartDay(currDate)
      Dim beginDay

      ' 현재 달의 시작일을 구함
      beginDay = CDate(Year(currDate) & "-" & Month(currDate) & "-01")

      ' 시작일이 일요일이 아니면 시작일을 첫번째 일요일로 변경
      if 1 < WeekDay(beginDay, 2) Then beginDay = DateAdd("d", 8 - WeekDay(beginDay, 2), beginDay)

      GetMonWeekStartDay = beginDay
   End Function

   Function GetMonWeek(currDate)
      Dim beginDay, beginWeek, currWeek

      beginDay = GetMonWeekStartDay(currDate)

      ' 시작일의 올해 주 번호 구함
      beginWeek = DatePart("ww", beginDay, 2)

      ' 목표일의 올해 주 번호 구함
      currWeek = DatePart("ww", currDate, 2)

      ' 목표일이 이번 달 몇번째 주 인지 리턴
      GetMonWeek = (currWeek - beginWeek + 1)
   End Function

   Function readUTF_File(FileUrl)
     Set objStream = CreateObject("ADODB.Stream")
     With objStream
        .Charset = "utf-8"
        .Type=2
        .mode=3
        .Open
        .loadfromfile FileUrl
        readUTF_File=.readtext
        .Close
      End With
      Set objStream = Nothing
   End Function

   Dim BlackList, SpBlackList

   BlackList = "alert,append,applet,base,bgsound,binding,blink,charset,confirm,cookie,create,document,embed,eval,expression,frame,frameset,iframe,ilayer,innerHTML,javascript,layer,meta,msgbox,object,ofocusout,onabort,onactivae," _
             & "onactivate,onafterprint,onafterupdate,onbefore,onbeforeactivate,onbeforecopy,onbeforecut,onbeforedeactivate,onbeforeeditfocus,onbeforepaste,onbeforeprint,onbeforeunload,onbeforeupdate,onblur,onbounce,oncellchange,onchange,onclick,oncontextmenu,oncontrolselect,oncopy,oncut,ondataavailable,ondatasetchanged,ondatasetcomplete,ondblclick,ondeactivate,ondrag,ondragend,ondragenter," _
             & "ondragleave,ondragover,ondragstart,ondrop,onerror,onerrorupdate,onfilterchange,onfinish,onfocus,onfocusin,onfocusout,onhelp,onkeydown,onkeypress,onkeyup,onlayoutcomplete,onload,onlosecapture,onmousedown,onmouseenter,onmouseleave,onmousemove,onmouseout,onmouseover,onmouseup,onmousewheel,onmove,onmoveend,onmovestart,onpaste," _
             & "onpropertychange,onreadystatechange,onreset,onresize,onresizeend,onresizestart,onrowenter,onrowexit,onrowsdelete,onrowsinserted,onscroll,onselect,onselectionchange,onselectstart,onstart,onstop,onsubmit,onunload,prompt,refresh,script,string,vbscript,void,xml"

   SpBlackList = Split(BlackList,",")

   Function CheckStringXss(str)
      On Error Resume Next

      Dim lstr

      If ( IsEmpty(str) ) Then
         CheckStringXss = ""
         Exit Function
      ElseIf ( StrComp(str, "") = 0 ) Then
         CheckStringXss = ""
         Exit Function
      End If

     lstr = LCase(str)

     For Each s in SpBlackList
        If ( InStr (lstr, s) <> 0 ) Then
           'response.write s
           CheckStringXss = s
           Exit Function
        End If
     Next

      CheckStringXss = ""
   End Function
%>
