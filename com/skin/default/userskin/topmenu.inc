<%
   OLD_DEPTH = 0

   For i = 1 to UBound(MENU_CODE)
      If MENU_DEPTH(i) < 2 AND InStr(MENU_LINK(i),"/member/") = 0 Then
         If OLD_DEPTH = 1 AND MENU_DEPTH(i) = 0 Then response.write UL_CLOSE & "</li>" & vbNewLine

         MENU_MNUM = CInt(Left(MENU_CODE(i),2))
         If MENU_DEPTH(i) = 0 Then
            If MENU_SCNT(MENU_MNUM) > 0 Then
               If Left(PG_NUM,2) = Left(MENU_CODE(i),2) Then
                  response.write "<li class='active dropdown'>" & vbNewLine
               Else
                  response.write "<li class='dropdown'>" & vbNewLine
               End If

               response.write "  <a href='" & MENU_LINK(i) & "' class='dropdown-toggle' data-toggle='dropdown'>" & MENU_NAME(i) & "</a>" & vbNewLine
               response.write "  <ul class='dropdown-menu'>" & vbNewLine
               UL_CLOSE = "  </ul>" & vbNewLine
            Else
               If Left(PG_NUM,2) = Left(MENU_CODE(i),2) Then
                  response.write "<li class='active'>" & vbNewLine
               Else
                  response.write "<li>" & vbNewLine
               End If

               response.write "  <a href='" & MENU_LINK(i) & "'>" & MENU_NAME(i) & "</a>" & vbNewLine
               UL_CLOSE = ""
            End If

						 If Left(PAGE_NUM(PG_SEQ),2) = Left(MENU_CODE(i),2) Then
						    SUB_HUGE_TITLE = MENU_NAME(i)
						    BIG_TAB_MENU = BIG_TAB_MENU & "    <li><a href=""" & MENU_LINK(i) & """ class=""on"">" & MENU_NAME(i) & "</a></li>" & vbNewLine
						 Else
						    BIG_TAB_MENU = BIG_TAB_MENU & "    <li><a href=""" & MENU_LINK(i) & """>" & MENU_NAME(i) & "</a></li>" & vbNewLine
						 End If

            OLD_DEPTH = MENU_DEPTH(i)
         End If

         If MENU_DEPTH(i) = 1 Then
            If Left(PG_NUM,4) = Left(MENU_CODE(i),4) Then
               response.write "    <li class='active'><a href='" & MENU_LINK(i) & "'>" & MENU_NAME(i) & "</a></li>" & vbNewLine
            Else
               response.write "    <li><a href='" & MENU_LINK(i) & "'>" & MENU_NAME(i) & "</a></li>" & vbNewLine
            End If
            
						If Left(PAGE_NUM(PG_SEQ),2) = Left(MENU_CODE(i),2) Then
               If Left(PAGE_NUM(PG_SEQ),4) = Left(MENU_CODE(i),4) Then
                  SUB_TAB_MENU = SUB_TAB_MENU & "    <li><a href=""" & MENU_LINK(i) & """ class=""on"">" & MENU_NAME(i) & "</a></li>" & vbNewLine
               Else
                  SUB_TAB_MENU = SUB_TAB_MENU & "    <li><a href=""" & MENU_LINK(i) & """>" & MENU_NAME(i) & "</a></li>" & vbNewLine
               End If
            End If

            If Left(PAGE_NUM(PG_SEQ),4) = Left(MENU_CODE(i),4) Then
               SUB_BIG_TITLE = MENU_NAME(i)
            End If

            OLD_DEPTH = MENU_DEPTH(i)
         End If
      End If
   Next

   If OLD_DEPTH = 1 Then response.write UL_CLOSE & "</li>" & vbNewLine
%>
