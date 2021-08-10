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
                  .write "<div id='" & P_NAME & "' class=""global_popup"" style='position:absolute;top:" & P_TOP & "px;left:" & P_LEFT & "px;width:" & P_WHDTH & "px;height:" & P_HEIGHT + 27 & "px;z-index:1000;'>" & vbNewLine

                  If P_TYPE = "movelayer" Then .write "<div style='cursor:move;'>" & vbNewLine

                  .write "<table border='0' cellpadding='2' cellspacing='1' bgcolor='#999999'>" & vbNewLine
                  .write "  <tr>" & vbNewLine
                  .write "    <td bgcolor='#FFFFFF'>" & vbNewLine
                  .write "      <table width='" & P_WHDTH & "' border='0' cellpadding='0' cellspacing='0'>" & vbNewLine
                  .write "        <tr>" & vbNewLine
                  .write "          <td height='" & P_HEIGHT & "'>" & P_CONT & "</td>" & vbNewLine
                  .write "        </tr>" & vbNewLine
                  .write "        <tr>" & vbNewLine
                  .write "          <td height='27' bgcolor='#383838' align='right'><a href=""javascript:popupclose('" & P_NAME & "',true);""><img src='/exec/img/popup/today_close.gif' alt='오늘 하루 열지 않기' border='0'></a><img src='/exec/img/popup/popup_line.gif' border='0'><a href=""javascript:popupclose('" & P_NAME & "',false);""><img src='/exec/img/popup/popup_close.gif' alt='닫기' border='0'></a></td>" & vbNewLine
                  .write "        </tr>" & vbNewLine
                   .write "      </table>" & vbNewLine
                  .write "    </td>" & vbNewLine
                  .write "  </tr>" & vbNewLine
                  .write "</table>" & vbNewLine

                  If P_TYPE = "movelayer" Then .write "</div>" & vbNewLine

                  .write "</div>" & vbNewLine

                  If P_TYPE = "movelayer" Then
                     .write "<script src='/exec/js/jquery-ui.min.js'></script>" & vbNewLine
                     .write "<script>" & vbNewLine
                     .write "$(function() {" & vbNewLine
                     .write "  $('#" & P_NAME & "').draggable();" & vbNewLine
                     .write "});" & vbNewLine
                     .write "</script>" & vbNewLine
                  End If

                  If P_CENTER = "1" Then
                     .write "<script language=""javascript"">" & vbNewLine

                     .write "$.fn.center = function() {" & vbNewLine
                     .write "  this.css({" & vbNewLine
                     .write "  'position': 'fixed'," & vbNewLine
                     .write "  'left': '50%'," & vbNewLine
                     .write "  'top': '50%'" & vbNewLine
                     .write "});" & vbNewLine
                     .write "this.css({" & vbNewLine
                     .write "  'margin-left': -this.outerWidth() / 2 + 'px'," & vbNewLine
                     .write "  'margin-top': -this.outerHeight() / 2 + 'px'" & vbNewLine
                     .write "});" & vbNewLine

                     .write "return this;" & vbNewLine
                     .write "}" & vbNewLine

                     .write "$('#" & P_NAME & "').center();" & vbNewLine
                     .write "</script>" & vbNewLine
                  End If

                  'If P_CENTER = "1" Then .write "<script language=""javascript"">poplay('open','" & P_NAME & "','" & P_WHDTH & "','" & P_HEIGHT + 27 & "');</script>" & vbNewLine
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