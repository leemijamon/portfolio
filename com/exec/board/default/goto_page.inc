<%
  Sub goto_directly(page, Pagecount, blodkcount)
    Dim BlodkEnd
    Dim endNum : endNum = page mod blodkcount

    '현재 자신의 페이지 블럭에서 마지막 페이지 구하기.
    If (page Mod blodkcount) = 0 Then
       BlodkEnd = page
    Else
       BlodkEnd = (Int(page) + blodkcount) - Int(endNum)   '13 + 10 - 3  / 23 + 10 -3
    End If

    If Pagecount <> 0 Then
       Response.Write "<ul class='pagination'>" & vbNewLine

       '이전 10개 기능 적용
       If Int(BlodkEnd) > blodkcount Then
          Response.Write "<li><a href=""javascript:goto(" & BlodkEnd - (blodkcount * 2) + 1 & ");"">&laquo;</a></li>" & vbNewLine
       Else
          Response.Write "<li><a href='#'>&laquo;</a></li>" & vbNewLine
       End If

       Dim i, endNumOfLoop
       If Int(pagecount) > Int(BlodkEnd) Then
          endNumOfLoop = BlodkEnd
       else
          endNumOfLoop = Int(pagecount)
       end if

       For i = BlodkEnd - blodkcount + 1 To endNumOfLoop
          if i = int(page) then
             Response.Write "<li><a href='#'>" & i & "</a></li>" & vbNewLine
          else
             Response.Write "<li><a href=""javascript:goto(" & i & ");"">" & i & "</a></li>" & vbNewLine
          end if
       Next

       '다음 10개 기능 적용
       If Int(pagecount) > Int(BlodkEnd) Then
          Response.Write "<li><a href=""javascript:goto(" & BlodkEnd + 1 & ");"">&raquo;</a></li>" & vbNewLine
       Else
          Response.Write "<li><a href='#'>&raquo;</a></li>" & vbNewLine
       End If

       Response.Write "</ul>" & vbNewLine
    End If
  End Sub
%>
