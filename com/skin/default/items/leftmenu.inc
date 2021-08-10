<%
   OLD_DEPTH = 0
   mcnt = 0
   scnt = 0

   For i = 1 to UBound(MENU_CODE)
      If Left(PG_NUM,2) = Left(MENU_CODE(i),2) Then
         If MENU_DEPTH(i) = 0 Then
            MENU_HEADER =  MENU_NAME(i)
         End If

         If SUBIMG_OFF(i) <> "" Then
            MENU_IMG = "<img src='/file/menu/" & SUBIMG_OFF(i) & "' alt='" & MENU_NAME(i) & "' title='" & MENU_NAME(i) & "' />"
         Else
            MENU_IMG = MENU_NAME(i)
         End If

         If MENU_DEPTH(i) = 1 Then
            If scnt > 0 Then sideMenu = sideMenu & "      </ul>" & vbNewLine
            If mcnt > 0 Then sideMenu = sideMenu & "    </li>" & vbNewLine

            sideMenu = sideMenu & "    <li class='dep1li'>" & vbNewLine
            sideMenu = sideMenu & "      <a href='" & MENU_LINK(i) & "'>" & MENU_IMG & "</a>" & vbNewLine

            mcnt = mcnt + 1
            scnt = 0
         End If

         If MENU_DEPTH(i) = 2 AND Left(PG_NUM,4) = Left(MENU_CODE(i),4) Then
            If scnt = 0 Then sideMenu = sideMenu & "      <ul class='dep2ul'>" & vbNewLine

            sideMenu = sideMenu & "        <li><a href='" & MENU_LINK(i) & "'>" & MENU_IMG & "</a></li>" & vbNewLine

            scnt = scnt + 1
         End If

         OLD_DEPTH = MENU_DEPTH(i)
      End If
   Next

   If scnt > 0 Then sideMenu = sideMenu & "      </ul>" & vbNewLine
   If mcnt > 0 Then sideMenu = sideMenu & "    </li>" & vbNewLine
%>
<div class="side-nav">
  <ul class="dep1ul">
<%=sideMenu%>
  </ul>
</div>
