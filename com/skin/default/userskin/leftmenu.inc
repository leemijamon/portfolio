<%
   OLD_DEPTH = 0
   SUB_NUM = 0

   For i = 1 to UBound(MENU_CODE)
      If Left(PG_NUM,2) = Left(MENU_CODE(i),2) Then
         If MENU_DEPTH(i) = 0 Then
            'response.write "<li class='nav-header'><h3>" & MENU_NAME(i) & "</h3></li>" & vbNewLine
            response.write "<ul class='side-nav list-group' id='sidebar-nav'>" & vbNewLine
         ElseIf MENU_DEPTH(i) = 1 Then
            If OLD_DEPTH = 1 Then
               response.write "  <li class='list-group-item " & MENU_ACTIVE1 & "'><a href='" & MENU_LINK1 & "'>" & MENU_NAME1 & "</a></li>" & vbNewLine
            End If

            If OLD_DEPTH = 2 Then
               response.write "    </ul>" & vbNewLine
               response.write "  </li>" & vbNewLine
            End If

            MENU_LINK1 = MENU_LINK(i)
            MENU_NAME1 = MENU_NAME(i)

            If Left(PG_NUM,4) = Left(MENU_CODE(i),4) Then
               MENU_ACTIVE1 = " active"
               MENU_IN1 = " in"
            Else
               MENU_ACTIVE1 = ""
               MENU_IN1 = ""
            End if

            SUB_NUM = SUB_NUM + 1
         Else
            If OLD_DEPTH = 1 Then
               response.write "  <li class='list-group-item list-toggle" & MENU_ACTIVE1 & "'>" & vbNewLine
               response.write "    <a class='sidenav-toggle' data-toggle='collapse' data-parent='#sidebar-nav' href='#collapse-" & SUB_NUM & "'>" & MENU_NAME1 & "</a>" & vbNewLine
               response.write "    <ul id='collapse-" & SUB_NUM & "' class='sidenav-menu collapse" & MENU_IN1 & "'>" & vbNewLine
            End If

            If PG_NUM = MENU_CODE(i) Then
               response.write "    <li class='active'><a href='" & MENU_LINK(i) & "'><i class='fa fa-angle-right'></i> " & MENU_NAME(i) & "</a></li>" & vbNewLine
            Else
               response.write "    <li><a href='" & MENU_LINK(i) & "'><i class='fa fa-angle-right'></i> " & MENU_NAME(i) & "</a></li>" & vbNewLine
            End if
         End If

         OLD_DEPTH = MENU_DEPTH(i)
      End If
   Next
   If OLD_DEPTH = 1 Then
      response.write "  <li class='list-group-item " & MENU_ACTIVE1 & "'><a href='" & MENU_LINK1 & "'>" & MENU_NAME1 & "</a></li>" & vbNewLine
      response.write "</ul>" & vbNewLine
   End If

   If OLD_DEPTH = 2 Then
      response.write "    </ul>" & vbNewLine
      response.write "  </li>" & vbNewLine
      response.write "</ul>" & vbNewLine
   End If
%>
