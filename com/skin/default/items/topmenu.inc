<%
   OLD_DEPTH = 0
   M_CNT = 0

   For i = 1 to UBound(MENU_CODE)
      If MENU_DEPTH(i) < 2 AND InStr(MENU_LINK(i),"/member/") = 0 Then

         If OLD_DEPTH = 1 AND MENU_DEPTH(i) = 0 Then
            depth2Menu = depth2Menu & "        </ul>" & vbNewLine
            depth2Menu = depth2Menu & "      </div>" & vbNewLine
         End If

         M_CD = Left(MENU_CODE(i),2)
         S_CD = Left(MENU_CODE(i),4)
         M_NUM = CInt(M_CD)

         If MENU_DEPTH(i) = 0 Then
            If TOPIMG_OFF(i) <> "" Then
               MENU_IMG = "<img src='/file/menu/" & TOPIMG_OFF(i) & "' alt='" & MENU_NAME(i) & "' title='" & MENU_NAME(i) & "' class='navImg' id='navImg" & M_CD & "' />"
            Else
               MENU_IMG = MENU_NAME(i)
            End If

            depth1Menu = depth1Menu & "        <li><a href='" & MENU_LINK(i) & "'>" & MENU_IMG & "</a></li>" & vbNewLine

            depth2Menu = depth2Menu & "      <div class='depth2Area' id='depth2Area" & M_CD & "'>" & vbNewLine
            depth2Menu = depth2Menu & "        <ul class='depth2Menu'>" & vbNewLine
         End If

         If MENU_DEPTH(i) = 1 Then
            If TOPIMG_OFF(i) <> "" Then
               MENU_IMG = "<img src='/file/menu/" & TOPIMG_OFF(i) & "' alt='" & MENU_NAME(i) & "' title='" & MENU_NAME(i) & "' class='subImg' id='subImg" & S_CD & "' />"
            Else
               MENU_IMG = MENU_NAME(i)
            End If

            depth2Menu = depth2Menu & "          <li class='navLiDepth2' id='navLiDepth2" & S_CD & "'><a href='" & MENU_LINK(i) & "'>" & MENU_IMG & "</a></li>" & vbNewLine
         End If

         OLD_DEPTH = MENU_DEPTH(i)
      End If
   Next

   If OLD_DEPTH = 1 Then
      depth2Menu = depth2Menu & "        </ul>" & vbNewLine
      depth2Menu = depth2Menu & "      </div>" & vbNewLine
   End If
%>
<div id="nav">
  <div id="navArea">
    <div class="navMenuList">
      <ul class='depth1Menu'>
<%=depth1Menu%>
      </ul>
<%=depth2Menu%>
    </div>
  </div>
</div>
