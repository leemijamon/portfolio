<%
   NowDate = Replace(FormatDateTime(now(),2),"-","") & "0000"

   Dim POPUP_LST_Table
   POPUP_LST_Table = "POPUP_LST"

   Dim P_SEQ,P_TITLE,P_TOP,P_LEFT,P_WHDTH,P_HEIGHT

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT * FROM " & POPUP_LST_Table _
       & " WHERE P_DISP='1' AND P_SDATE<='" & NowDate & "' AND P_EDATE>='" & NowDate & "' AND P_STATE < '90'"

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   With response
      If Rs.BOF = false AND Rs.EOF = false Then
         .write "<script src='/exec/js/popup.js'></script>" & vbNewLine

         Do until Rs.EOF
            i = i + 1
            P_SEQ = Rs("P_SEQ")
            P_TYPE = Rs("P_TYPE")
            P_TITLE = Rs("P_TITLE")
            P_CONT = Rs("P_CONT")
            P_TOP = Rs("P_TOP")
            P_LEFT = Rs("P_LEFT")
            P_CENTER = Rs("P_CENTER")
            P_WHDTH = Rs("P_WHDTH")
            P_HEIGHT = Rs("P_HEIGHT")

            P_NAME = P_SEQ & "pop"

            If P_TYPE = "default" Then
               P_HEIGHT = P_HEIGHT + 27

               If Request.Cookies(P_NAME) <> "done" Then
                  If P_CENTER = "1" Then
                     .write "<script language=""javascript"">popupcenter('" & P_NAME & "','/exec/popup/popup.asp?p_seq=" & P_SEQ & "'," & P_WHDTH & "," & P_HEIGHT & ",'no');</script>" & vbNewLine
                  Else
                     .write "<script language=""javascript"">window.open('/exec/popup/popup.asp?p_seq=" & P_SEQ & "','" & P_NAME & "','width=" & P_WHDTH & ",height=" & P_HEIGHT & ",top=" & P_TOP & ",left=" & P_LEFT & ",scrollbars=no,resizable=no');</script>" & vbNewLine
                  End If
               End If
            End If

            If P_TYPE = "layer" Or P_TYPE = "movelayer" Then
               If Request.Cookies(P_NAME) <> "done" Then
                  If P_CENTER = "1" Then
                     .write "<div id='" & P_NAME & "' class=""control_popup"" style='position:fixed;left:50%;margin-left:-" & (P_WHDTH/2) & "px;top:50%;margin-top:-" & (P_HEIGHT/2) & "px;z-index:1001;'>" & vbNewLine
                  Else
                     .write "<div id='" & P_NAME & "' class=""control_popup"" style='position:fixed;top:" & P_TOP & "px;left:" & P_LEFT & "px;z-index:1001;'>" & vbNewLine
                  End If

                  .write "<div class='pop_outter'>" & vbNewLine
                  .write "  <div class='pop_wrap'>" & P_CONT & "</div>" & vbNewLine
                  .write "  <div class='cookie_wrap'><a href=""javascript:popupclose('" & P_NAME & "',true);"" class='bar'>오늘 하루 열지 않기</a><a href=""javascript:popupclose('" & P_NAME & "',false);"">닫기</a></div>" & vbNewLine
                  .write "</div>" & vbNewLine

                  .write "</div>" & vbNewLine

                  .write "<script type=""text/javascript"">" & vbNewLine
                  If P_CENTER = "1" Then .write "  //$('#" & P_NAME & "').center();" & vbNewLine
                  '.write "$('html').css('overflow','hidden')" & vbNewLine
                  If P_TYPE = "movelayer" Then .write "Draggable.create('#" & P_NAME & "', {type:'x,y', edgeResistance:0.65, bounds:'.wrap', throwProps:true});" & vbNewLine
                  .write "</script>" & vbNewLine

               End If
            End If

            Rs.MoveNext
         Loop
      End If
      Rs.close
   End With

   Conn.Close
   Set Conn = nothing
%>