<%
  Sub goto_directly2(page, Pagecount, blodkcount)
    Dim BlodkEnd
    Dim endNum : endNum = page mod blodkcount

    '현재 자신의 페이지 블럭에서 마지막 페이지 구하기.
    If (page Mod blodkcount) = 0 Then
       BlodkEnd = page
    Else
       BlodkEnd = (Int(page) + blodkcount) - Int(endNum)   '13 + 10 - 3  / 23 + 10 -3
    End If

    If Pagecount <> 0 Then
       'Response.Write "<a class=""arrow pprev"" href=""javascript:goto(1);""></a>" & vbNewLine
       '이전 10개 기능 적용
       If Int(BlodkEnd) > blodkcount Then
          Response.Write "<a class=""arrow prev"" href=""javascript:gotoBoard2(" & BlodkEnd - (blodkcount * 2) + 1 & ");""></a>" & vbNewLine
       Else
          Response.Write "<a class=""arrow prev"" href=""#""></a>" & vbNewLine
       End If

       Dim i, endNumOfLoop
       If Int(pagecount) > Int(BlodkEnd) Then
          endNumOfLoop = BlodkEnd
       else
          endNumOfLoop = Int(pagecount)
       end if

       For i = BlodkEnd - blodkcount + 1 To endNumOfLoop
          if i = int(page) then
             Response.Write "<a href=""#"" class=""active"">" & i & "</a>" & vbNewLine
          else
             Response.Write "<a href=""javascript:gotoBoard2(" & i & ");"">" & i & "</a>" & vbNewLine
          end if
       Next

       '다음 10개 기능 적용
       If Int(pagecount) > Int(BlodkEnd) Then
          Response.Write "<a class=""arrow next"" href=""javascript:gotoBoard2(" & BlodkEnd + 1 & ");""></a>" & vbNewLine
       Else
          Response.Write "<a class=""arrow next"" href=""#""></a>" & vbNewLine
       End If

       'Response.Write "<a class=""arrow nnext"" href=""javascript:goto(" & Pagecount & ");""></a>" & vbNewLine
    End If
  End Sub
%>
