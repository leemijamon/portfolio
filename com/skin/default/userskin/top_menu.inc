<%
   OLD_DEPTH = 0
   SUB_TAB_MENU = ""

   For i = 1 to UBound(MENU_CODE)
      If MENU_DEPTH(i) < 3 AND InStr(MENU_LINK(i),"/employ/") = 0 Then
         If OLD_DEPTH = 1 AND MENU_DEPTH(i) = 0 Then response.write UL_CLOSE & "</li>" & vbNewLine

         M_CD = Left(MENU_CODE(i),2)
         M_NUM = CInt(M_CD)

         MENU_MNUM = CInt(Left(MENU_CODE(i),2))
         If MENU_DEPTH(i) = 0 Then
            If Left(PAGE_NUM(PG_SEQ),2) = Left(MENU_CODE(i),2) Then
               DROPDOWN_ON = " on"
            Else
               DROPDOWN_ON = ""
            End If

            If MENU_SCNT(MENU_MNUM) > 0 Then
               response.write "<li class=""dropdown" & DROPDOWN_ON & " dropdown-" & M_NUM & """>" & vbNewLine
               response.write "  <a href=""" & MENU_LINK(i) & """ class=""dropdowna"">" & MENU_NAME(i) & "</a>" & vbNewLine
               response.write "  <ul class=""sub-onemenu"">" & vbNewLine
               UL_CLOSE = "  </ul>" & vbNewLine
            Else
               response.write "  <a href=""" & MENU_LINK(i) & """ class=""dropdowna"">" & MENU_NAME(i) & "</a>" & vbNewLine
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

            MENU_SMNUM = CInt(Mid(MENU_CODE(i),3,2))

            response.write "    <li class=""sub-dropdown"">" & vbNewLine
            response.write "        <a href=""" & MENU_LINK(i) & """ class=""sub-onemenua sub-onemenua" & M_NUM & MENU_SMNUM & """>" & MENU_NAME(i) & "</a>" & vbNewLine
            response.write "    </li>" & vbNewLine

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
