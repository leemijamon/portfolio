<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<!-- #include virtual = "/exec/module/goto_page.inc" -->
<%
   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim QNA_LST_Table
   QNA_LST_Table = "QNA_LST"

   Dim Q_SEQ,Q_TYPE,Q_TITLE,Q_CONT,Q_ANSER,Q_READCNT,Q_IP,Q_WDATE,Q_MDATE,Q_ADATE

   Dim page : page = request("page")
   if page = "" then page = 1
   page = int(page)

   Dim pageSize : pageSize = 10
   Dim recordCount, recentCount

   WHERE = "MEM_SEQ=" & MEM_SEQ & " AND Q_STATE < '90'"

   SQL = "SELECT COUNT(*) FROM " & QNA_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   recordCount = Rs(0)
   Rs.close

   Dim n_from,n_to,s_desc,s_asc,n_range,n_limit
   Dim pageCount : pageCount=int((recordCount-1)/pageSize)+1

   If page > pageCount Then page = pageCount
   If page = 0 Then page = 1

   ORDER_BY = "Q_SEQ DESC"

   S_ROWNUM = (page-1) * pageSize + 1
   E_ROWNUM = page * pageSize

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & QNA_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   With response
      .write "<div class='table-responsive'>" & vbNewLine

      .write "  <table class='table table-striped'>" & vbNewLine
      .write "    <thead>" & vbNewLine
      .write "      <tr>" & vbNewLine
      .write "        <th width='*'>제목</th>" & vbNewLine
      .write "        <th width='120'>상담일자</th>" & vbNewLine
      .write "        <th width='120'>답변일자</th>" & vbNewLine
      .write "      </tr>" & vbNewLine
      .write "    </thead>" & vbNewLine
      .write "    <tbody>" & vbNewLine

      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            i = i + 1
            Q_SEQ = Rs("Q_SEQ")
            Q_TYPE = Rs("Q_TYPE")
            Q_TITLE = Rs("Q_TITLE")
            Q_CONT = Rs("Q_CONT")
            Q_ANSER = Rs("Q_ANSER")
            Q_READCNT = Rs("Q_READCNT")
            Q_IP = Rs("Q_IP")
            Q_WDATE = Rs("Q_WDATE")
            Q_ADATE = Rs("Q_ADATE")
            Q_MEM_SEQ = Rs("MEM_SEQ")

            Q_TYPE = f_arr_value(Q_TYPE_CD,Q_TYPE_NAME,Q_TYPE)

            Q_TITLE = Replace(Q_TITLE,"<","&lt;")
            Q_TITLE = Replace(Q_TITLE,">","&gt;")

            If Login_check = "Y" AND Q_MEM_SEQ = MEM_SEQ Then
               BTN_IMG = " <a href=""javascript:qna_del(" & Q_SEQ & ");""><img src='/img/board/btn_com_del.gif' width='9' height='9' border='0' align='absmiddle'></a>"
            Else
               BTN_IMG = ""
            End If

            If IsNULL(Q_ADATE) = false AND Q_ADATE <> "" Then
               Q_ADATE = f_chang_date(Q_ADATE)
            Else
               Q_ADATE = "답변대기중"
            End If

            .write "      <tr>" & vbNewLine
            .write "        <td class='left'>&nbsp;<a href='javascript:q_view(" & Q_SEQ & ");'>[" & Q_TYPE & "] " & Q_TITLE & "</a></td>" & vbNewLine
            .write "        <td>" & f_chang_date(Q_WDATE) & "</td>" & vbNewLine
            .write "        <td>" & Q_ADATE & "</td>" & vbNewLine
            .write "      </tr>" & vbNewLine

            Rs.MoveNext
         Loop

         For t = i to pageSize - 1
            .write "      <tr>" & vbNewLine
            .write "        <td colspan='3'>&nbsp;</td>" & vbNewLine
            .write "      </tr>" & vbNewLine
         Next
      Else
         .write "  <tr>" & vbNewLine
         .write "    <td colspan='3' style='height:200px;vertical-align:middle;'>회원님의 문의하신 내역이 없습니다.</td>" & vbNewLine
         .write "  </tr>" & vbNewLine
      End If
      Rs.close

      .write "    </tbody>" & vbNewLine
      .write "  </table>" & vbNewLine

      .write "</div>" & vbNewLine
   End With

   With response
      .write "<div class='board-page'>" & vbNewLine
      goto_directly page, pagecount, 10
      .write "</div>" & vbNewLine

      .write "<div class='board-btn-center'>" & vbNewLine
      .write "  답변을 찾지 못하셨다면 <font color='#FF6600'>상담신청을 해주세요</font>. 친절하게 안내해 드리겠습니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & vbNewLine
      .write "  <a href=""?method=reg"" class='btn btn-primary btn-theme'>상담신청</a>" & vbNewLine
      .write "</div>" & vbNewLine
   End With
%>

<form name="result" method="get">
<input type="hidden" name="method" value="<%=request("method")%>">
<input type="hidden" name="page" value="<%=request("page")%>">
<input type="hidden" name="q_seq">
</form>

<script language="javascript">
<!--
  function goto(page){
    document.result.page.value = page;
    document.result.submit();
  }

  function q_view(q_seq){
    document.result.method.value = "view";
    document.result.q_seq.value = q_seq;
    document.result.submit();
  }

  function qna_del(q_seq){
    var msg = "삭제하시겠습니까?"
    if(confirm(msg)){
      sframe.location.href = "/exec/board/qna_pro.asp?method=delete&q_seq=" + q_seq;
    }else{
      return;
    }
  }
-->
</script>

