<%
   Function BoardCont(BoardName)
      Dim BOARD_LST_Table
      BOARD_LST_Table = "BOARD_LST"

      Dim BOARD_CONFIG_LST_Table
      BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

      B_HTML = ""

      If InStr(BoardName,"board") > 0 Then
         BC_SEQ = Split(BoardName,"/")(1)

         SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ & " AND BC_STATE < '90'"
         Set Rs = Conn.Execute(SQL, ,adCmdText)

         If Rs.BOF = false AND Rs.EOF = false Then
            BC_TYPE = Rs("BC_TYPE")
            BC_NAME = Rs("BC_NAME")
         End If
         Rs.close

         B_HTML = B_HTML & "      <div class='panel panel-greenLight'>" & vbNewLine
         B_HTML = B_HTML & "        <div class='panel-heading'>" & vbNewLine
         B_HTML = B_HTML & "          <i class='fa fa-comments fa-fw'></i> " & BC_NAME & "" & vbNewLine
         B_HTML = B_HTML & "          <div class='btn-group pull-right'>" & vbNewLine
         B_HTML = B_HTML & "            <button type='button' class='btn btn-default btn-xs' onclick='boardview(1);'>더보기</button>" & vbNewLine
         B_HTML = B_HTML & "          </div>" & vbNewLine
         B_HTML = B_HTML & "        </div>" & vbNewLine
         B_HTML = B_HTML & "        <div class='panel-body no-padding'>" & vbNewLine
         B_HTML = B_HTML & "          <div class='table-responsive'>" & vbNewLine
         B_HTML = B_HTML & "            <table class='table table-striped' style='margin-bottom:0px;'>" & vbNewLine
         B_HTML = B_HTML & "              <thead>" & vbNewLine
         B_HTML = B_HTML & "                <tr>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='*'>제목</th>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='95'>작성일</th>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='95'>작성자</th>" & vbNewLine
         B_HTML = B_HTML & "                </tr>" & vbNewLine
         B_HTML = B_HTML & "              </thead>" & vbNewLine
         B_HTML = B_HTML & "              <tbody>" & vbNewLine

         SQL = "SELECT TOP 5 *, MEM_NAME = (SELECT MEM_NAME FROM MEM_LST WHERE MEM_LST.MEM_SEQ=BOARD_LST.MEM_SEQ)  FROM " & BOARD_LST_Table & " WHERE B_STATE < '90' AND BC_SEQ=" & BC_SEQ & " ORDER BY B_SEQ DESC"
         Set Rs = Conn.Execute(SQL, ,adCmdText)

         B_CNT = 0
         If Rs.BOF = false AND Rs.EOF = false Then
            Do until Rs.EOF
               B_SEQ = Rs("B_SEQ")
               B_TITLE = Rs("B_TITLE")
               B_WDATE = ChangeDate(Rs("B_WDATE"))
               B_MEM_SEQ = Rs("MEM_SEQ")
               B_MEM_NAME = Rs("MEM_NAME")

               If IsNULL(B_MEM_SEQ) Then
                  B_MEM_SEQ = 0
                  B_MEM_NAME = Rs("B_GUEST_NAME")
               End If

               B_HTML = B_HTML & "                <tr>" & vbNewLine
               B_HTML = B_HTML & "                  <td class='left'>&nbsp;<a href='javascript:boardview(" & BC_SEQ & "," & B_SEQ & ");'>" & B_TITLE & "</a></td>" & vbNewLine
               B_HTML = B_HTML & "                  <td>" & B_WDATE & "</td>" & vbNewLine
               B_HTML = B_HTML & "                  <td>" & B_MEM_NAME & "</td>" & vbNewLine
               B_HTML = B_HTML & "                </tr>" & vbNewLine

               B_CNT = B_CNT + 1
               Rs.MoveNext
            Loop
         End If
         Rs.close

         for k = 1 to 5 - B_CNT
            B_HTML = B_HTML & "                <tr>" & vbNewLine
            B_HTML = B_HTML & "                  <td colspan='3'>&nbsp;</td>" & vbNewLine
            B_HTML = B_HTML & "                </tr>" & vbNewLine
         Next

         B_HTML = B_HTML & "              </tbody>" & vbNewLine
         B_HTML = B_HTML & "            </table>" & vbNewLine
         B_HTML = B_HTML & "          </div>" & vbNewLine
         B_HTML = B_HTML & "        </div>" & vbNewLine
         B_HTML = B_HTML & "      </div>" & vbNewLine
      End If

      If BoardName = "qna" Then
         B_HTML = B_HTML & "      <div class='panel panel-blue'>" & vbNewLine
         B_HTML = B_HTML & "        <div class='panel-heading'>" & vbNewLine
         B_HTML = B_HTML & "          <i class='fa fa-comments fa-fw'></i> 1:1문의" & vbNewLine
         B_HTML = B_HTML & "          <div class='btn-group pull-right'>" & vbNewLine
         B_HTML = B_HTML & "            <a href='#board/qna' class='btn btn-default btn-xs'>더보기</a>" & vbNewLine
         B_HTML = B_HTML & "          </div>" & vbNewLine
         B_HTML = B_HTML & "        </div>" & vbNewLine
         B_HTML = B_HTML & "        <div class='panel-body no-padding'>" & vbNewLine
         B_HTML = B_HTML & "          <div class='table-responsive'>" & vbNewLine
         B_HTML = B_HTML & "            <table class='table table-striped' style='margin-bottom:0px;'>" & vbNewLine
         B_HTML = B_HTML & "              <thead>" & vbNewLine
         B_HTML = B_HTML & "                <tr>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='*'>제목</th>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='80'>작성일</th>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='100'>작성자</th>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='80'>답변일</th>" & vbNewLine
         B_HTML = B_HTML & "                </tr>" & vbNewLine
         B_HTML = B_HTML & "              </thead>" & vbNewLine
         B_HTML = B_HTML & "              <tbody>" & vbNewLine

         WHERE = "Q.Q_STATE < '90'"
         FROM = "QNA_LST Q LEFT OUTER JOIN MEM_LST M ON Q.MEM_SEQ = M.MEM_SEQ"
         SQL = "SELECT TOP 5 Q.*, M.MEM_NAME, M.MEM_ID, M.MEM_HP, M.MEM_TEL, M.MEM_EMAIL FROM " & FROM & " WHERE " & WHERE & " ORDER BY Q.Q_SEQ DESC"
         Set Rs = Conn.Execute(SQL, ,adCmdText)

         B_CNT = 0
         If Rs.BOF = false AND Rs.EOF = false Then
            Do until Rs.EOF
               Q_SEQ = Rs("Q_SEQ")
               Q_TYPE = Rs("Q_TYPE")
               Q_TITLE = Rs("Q_TITLE")
               Q_ADATE = Rs("Q_ADATE")
               Q_RTN_MAIL = Rs("Q_RTN_MAIL")
               Q_RTN_SMS = Rs("Q_RTN_SMS")
               Q_READCNT = Rs("Q_READCNT")
               Q_WDATE = ChangeDate(Rs("Q_WDATE"))
               MEM_SEQ = Rs("MEM_SEQ")
               MEM_NAME = Rs("MEM_NAME")

               Q_TYPE = f_arr_value(Q_TYPE_CD,Q_TYPE_NAME,Q_TYPE)

               If IsNULL(Q_ADATE) OR Q_ADATE = "" Then
                  Q_ADATE = "미답변"
               Else
                  Q_ADATE = "<font class='ver81'>" & ChangeDate(Q_ADATE) & "</font>"
               End If

               B_HTML = B_HTML & "                <tr>" & vbNewLine
               B_HTML = B_HTML & "                  <td class='left'>&nbsp;<a href='#board/qna'>[" & Q_TYPE & "]" & Q_TITLE & "</a></td>" & vbNewLine
               B_HTML = B_HTML & "                  <td>" & Q_WDATE & "</td>" & vbNewLine
               B_HTML = B_HTML & "                  <td>" & MEM_NAME & "</td>" & vbNewLine
               B_HTML = B_HTML & "                  <td>" & Q_ADATE & "</td>" & vbNewLine
               B_HTML = B_HTML & "                </tr>" & vbNewLine

               B_CNT = B_CNT + 1
               Rs.MoveNext
            Loop
         End If
         Rs.close

         for k = 1 to 5 - B_CNT
            B_HTML = B_HTML & "                <tr>" & vbNewLine
            B_HTML = B_HTML & "                  <td colspan='4'>&nbsp;</td>" & vbNewLine
            B_HTML = B_HTML & "                </tr>" & vbNewLine
         Next

         B_HTML = B_HTML & "              </tbody>" & vbNewLine
         B_HTML = B_HTML & "            </table>" & vbNewLine
         B_HTML = B_HTML & "          </div>" & vbNewLine
         B_HTML = B_HTML & "        </div>" & vbNewLine
         B_HTML = B_HTML & "      </div>" & vbNewLine
      End If

      If BoardName = "consult" Then
         B_HTML = B_HTML & "      <div class='panel panel-blue'>" & vbNewLine
         B_HTML = B_HTML & "        <div class='panel-heading'>" & vbNewLine
         B_HTML = B_HTML & "          <i class='fa fa-comments fa-fw'></i> 온라인문의" & vbNewLine
         B_HTML = B_HTML & "          <div class='btn-group pull-right'>" & vbNewLine
         B_HTML = B_HTML & "            <a href='#board/consult' class='btn btn-default btn-xs'>더보기</a>" & vbNewLine
         B_HTML = B_HTML & "          </div>" & vbNewLine
         B_HTML = B_HTML & "        </div>" & vbNewLine
         B_HTML = B_HTML & "        <div class='panel-body no-padding'>" & vbNewLine
         B_HTML = B_HTML & "          <div class='table-responsive'>" & vbNewLine
         B_HTML = B_HTML & "            <table class='table table-striped' style='margin-bottom:0px;'>" & vbNewLine
         B_HTML = B_HTML & "              <thead>" & vbNewLine
         B_HTML = B_HTML & "                <tr>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='*'>제목</th>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='80'>작성일</th>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='100'>작성자</th>" & vbNewLine
         B_HTML = B_HTML & "                  <th width='80'>답변일</th>" & vbNewLine
         B_HTML = B_HTML & "                </tr>" & vbNewLine
         B_HTML = B_HTML & "              </thead>" & vbNewLine
         B_HTML = B_HTML & "              <tbody>" & vbNewLine

         SQL = "SELECT TOP 5 * FROM CONSULT_LST WHERE C_STATE < '90' ORDER BY C_SEQ DESC"
         Set Rs = Conn.Execute(SQL, ,adCmdText)

         B_CNT = 0
         If Rs.BOF = false AND Rs.EOF = false Then
            Do until Rs.EOF
               C_SEQ = Rs("C_SEQ")
               C_TYPE = Rs("C_TYPE")
               C_NAME = Rs("C_NAME")
               C_EMAIL = Rs("C_EMAIL")
               C_HP = Rs("C_HP")
               C_TEL = Rs("C_TEL")
               C_TITLE = Rs("C_TITLE")
               C_CONT = Rs("C_CONT")
               C_ANSER = Rs("C_ANSER")
               C_ADATE = Rs("C_ADATE")
               C_IP = Rs("C_IP")
               C_WDATE = ChangeDate(Rs("C_WDATE"))

               C_TYPE = f_arr_value(C_TYPE_CD,C_TYPE_NAME,C_TYPE)

               If IsNULL(C_ADATE) OR C_ADATE = "" Then
                  C_ADATE = "미답변"
               Else
                  C_ADATE = "<font class='ver81'>" & ChangeDate(C_ADATE) & "</font>"
               End If

               B_HTML = B_HTML & "                <tr>" & vbNewLine
               B_HTML = B_HTML & "                  <td class='left'>&nbsp;<a href='#board/consult'>" & C_TITLE & "</a></td>" & vbNewLine
               B_HTML = B_HTML & "                  <td>" & C_WDATE & "</td>" & vbNewLine
               B_HTML = B_HTML & "                  <td>" & C_NAME & "</td>" & vbNewLine
               B_HTML = B_HTML & "                  <td>" & C_ADATE & "</td>" & vbNewLine
               B_HTML = B_HTML & "                </tr>" & vbNewLine

               B_CNT = B_CNT + 1
               Rs.MoveNext
            Loop
         End If
         Rs.close

         for k = 1 to 5 - B_CNT
            B_HTML = B_HTML & "                <tr>" & vbNewLine
            B_HTML = B_HTML & "                  <td colspan='4'>&nbsp;</td>" & vbNewLine
            B_HTML = B_HTML & "                </tr>" & vbNewLine
         Next

         B_HTML = B_HTML & "              </tbody>" & vbNewLine
         B_HTML = B_HTML & "            </table>" & vbNewLine
         B_HTML = B_HTML & "          </div>" & vbNewLine
         B_HTML = B_HTML & "        </div>" & vbNewLine
         B_HTML = B_HTML & "      </div>" & vbNewLine
      End If

      BoardCont = B_HTML
   End Function


   Function ChangeDate(OrgDate)
      If Left(OrgDate,8) = NowDate Then
         ChangeDate = right(f_chang_time(OrgDate),5)
      Else
         ChangeDate = f_chang_date(OrgDate)
      End If
   End Function
%>
