<%
   Sub TopMenu()
      Dim CM_SEQ,CM_NAME,CM_DEPTH,CM_SORT,CP_CODE

      SQL = "SELECT M.*, P.CP_TYPE, P.CP_NUM, P.CP_LINK, P.CP_PG_ITEM, P.CP_PG_QUERY, P.CL_CODE " _
          & "FROM CMS_MENU_LST AS M INNER JOIN CMS_PAGE_LST AS P ON M.CP_CODE = P.CP_CODE " _
          & "WHERE CM_DEPTH < 2 ORDER BY M.CM_CODE"

      Set Rs = Conn.Execute(SQL, ,adCmdText)

      i = 0
      mcnt = 0
      If Rs.BOF = false AND Rs.EOF = false Then
         With response
            .write "    <div id=""nav"">" & vbNewLine
            .write "      <ul>" & vbNewLine

            Do until Rs.EOF
               CM_SEQ = Rs("CM_SEQ")
               CM_NAME = Rs("CM_NAME")
               CM_ENG_NAME = Rs("CM_ENG_NAME")
               CM_CODE = Rs("CM_CODE")
               CM_DEPTH = Rs("CM_DEPTH")

               CM_TOPIMG_ON = Rs("CM_TOPIMG_ON")
               CM_TOPIMG_OFF = Rs("CM_TOPIMG_OFF")
               CM_SUBIMG_ON = Rs("CM_SUBIMG_ON")
               CM_SUBIMG_OFF = Rs("CM_SUBIMG_OFF")

               CP_NUM = Rs("CP_NUM")
               CP_LINK = Rs("CP_LINK")
               CP_PG_ITEM = Rs("CP_PG_ITEM")
               CP_PG_QUERY = Rs("CP_PG_QUERY")

               If CP_LINK = "" Then CP_LINK = "/" & CP_TYPE & "/" & CP_CODE & ".asp"

               CP_LINK = CP_LINK & "?pagenum=" & CP_NUM
               If CP_PG_ITEM <> "" Or CP_PG_QUERY <> "" Then CP_LINK = CP_LINK & "&item=" & CP_PG_ITEM & "&" & CP_PG_QUERY

               If IsNULL(CM_TOPIMG_OFF) = False AND CM_TOPIMG_OFF <> "" Then
                  TOPIMG_IMG = "<img src=""/file/menu/" & CM_TOPIMG_OFF & """ alt=""" & CM_NAME & """ title=""" & CM_NAME & """ class=""rollover"" />"
               Else
                  TOPIMG_IMG = CM_NAME
               End If

               If CM_DEPTH = 0 Then
                  If mcnt > 0 Then
                     .write "          </ul>" & vbNewLine
                     .write "        </li>" & vbNewLine
                  End If

                  .write "        <li><a href=""" & CP_LINK & """>" & TOPIMG_IMG & "</a>" & vbNewLine
                  .write "        </ul style=""width:300px;left:0px;"">" & vbNewLine
                  mcnt = mcnt + 1
               Else
                  .write "            <li><a href=""" & CP_LINK & """>" & TOPIMG_IMG & "</a></li>" & vbNewLine
               End If

               i = i + 1
               Rs.MoveNext
            Loop

            .write "          </ul>" & vbNewLine
            .write "        </li>" & vbNewLine
            .write "      </ul>" & vbNewLine
            .write "    </div>" & vbNewLine
         End With
      End If
      Rs.close

   End Sub

   Sub LeftMenu()
      If Request("pagenum") = "010200" Then

      End If
   End Sub
%>
