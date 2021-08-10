<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<%
   Dim QNA_LST_Table
   QNA_LST_Table = "QNA_LST"

   Dim Q_SEQ,Q_TYPE,Q_TITLE,Q_CONT,Q_READCNT,Q_WDATE

   Q_SEQ = Trim(Request("q_seq"))
   If IsNumeric(Q_SEQ) = false Then Response.end

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT * FROM " & QNA_LST_Table & " WHERE Q_SEQ=" & Q_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Q_TYPE = Rs("Q_TYPE")
      Q_TITLE = Rs("Q_TITLE")
      Q_CONT = Rs("Q_CONT")
      Q_ANSER = Rs("Q_ANSER")
      Q_READCNT = Rs("Q_READCNT")
      Q_IP = Rs("Q_IP")
      Q_WDATE = Rs("Q_WDATE")
      Q_ADATE = Rs("Q_ADATE")

      Q_TYPE = f_arr_value(Q_TYPE_CD,Q_TYPE_NAME,Q_TYPE)
      Q_TITLE = "[" & Q_TYPE & "] " & Q_TITLE
      Q_READCNT = FormatNumber(Q_READCNT,0)
      Q_WDATE = f_chang_date(Q_WDATE)

      If IsNULL(Q_ADATE) = false AND Q_ADATE <> "" Then
         Q_ADATE = f_chang_date(Q_ADATE)
      Else
         Q_ADATE = "답변대기중"
      End If

      Q_TITLE = Replace(Q_TITLE,"<","&lt;")
      Q_TITLE = Replace(Q_TITLE,">","&gt;")

      'Q_CONT = Replace(Q_CONT,"<","&lt;")
      'Q_CONT = Replace(Q_CONT,">","&gt;")
      'Q_CONT = replace(Q_CONT, chr(13)&chr(10), chr(13)&chr(10) & "<br>")
   End If
   Rs.close

   SQL = "UPDATE " & QNA_LST_Table & " SET " _
       & "Q_READCNT=Q_READCNT + 1 " _
       & "WHERE Q_SEQ=" & Q_SEQ

   Conn.Execute SQL, ,adCmdText

   WHERE = "Q_STATE < '90' AND MEM_SEQ=" & MEM_SEQ
   If request("search_key") <> "" AND request("search_word") <> "" Then WHERE = WHERE & " AND " & request("search_key") & " LIKE '%" & replace(request("search_word"), chr(34), "&#34;") & "%'"

   SQL = "SELECT TOP 1 Q_SEQ,Q_TYPE,Q_TITLE,Q_WDATE FROM " & QNA_LST_Table _
       & " WHERE " & WHERE & " AND Q_SEQ > " & Q_SEQ & " ORDER BY Q_SEQ"

   Set Rs = Conn.Execute(SQL, ,adCmdText)
   If Rs.BOF = false AND Rs.EOF = false Then
      Q_TYPE = f_arr_value(Q_TYPE_CD,Q_TYPE_NAME,Rs("Q_TYPE"))

      BACK_LINK = "javascript:q_view(" & Rs("Q_SEQ") & ");"
      BACK_TITLE = "<strong>이전글</strong><span>[" & Q_TYPE & "] " & Rs("Q_TITLE") & "</span><span>" & f_chang_date(Rs("Q_WDATE")) & "</span>"
   Else
      BACK_LINK = "#"
      BACK_TITLE = "<strong>이전글</strong><span>이전 목록이 없습니다.</span>"
   End If
   Rs.close

   SQL = "SELECT TOP 1 Q_SEQ,Q_TYPE,Q_TITLE,Q_WDATE FROM " & QNA_LST_Table _
       & " WHERE " & WHERE & " AND Q_SEQ < " & Q_SEQ & " ORDER BY Q_SEQ DESC"

   Set Rs = Conn.Execute(SQL, ,adCmdText)
   If Rs.BOF = false AND Rs.EOF = false Then
      Q_TYPE = f_arr_value(Q_TYPE_CD,Q_TYPE_NAME,Rs("Q_TYPE"))

      NEXT_LINK = "javascript:q_view(" & Rs("Q_SEQ") & ");"
      NEXT_TITLE = "<strong>다음글</strong><span>[" & Q_TYPE & "] " & Rs("Q_TITLE") & "</span><span>" & f_chang_date(Rs("Q_WDATE")) & "</span>"
   Else
      NEXT_LINK = "#"
      NEXT_TITLE = "<strong>다음글</strong><span>다음 목록이 없습니다.</span>"
   End If

   Conn.Close
   Set Conn = nothing
%>
<div class='board-view'>
  <h2><%=Q_TITLE%></h2>
  <div class='board-view-tags'>
    <ul class='list-unstyled list-inline board-view-info'>
      <li><i class='fa fa-user'></i> <%=Session("MEM_NAME")%></li>
      <li><i class='fa fa-calendar'></i> <%=Q_WDATE%></li>
      <li><i class='fa fa-check-square'></i> <%=FormatNumber(Q_READCNT,0)%></li>
    </ul>
  </div>
  <div class='board-view-content'>
<%=Q_CONT%>
  </div>
  <div class='board-anser-content'>
답변일 : <%=Q_ADATE%><br>
<%=Q_ANSER%>
  </div>
</div>

<div class="board-btn-mod">
  <a class='btn btn-default' href="javascript:q_del();">삭제</a>
</div>

<ul class="list-unstyled prev-next">
  <li><a href="<%=BACK_LINK%>"><%=BACK_TITLE%></a><i class="fa fa-angle-right"></i></li>
  <li><a href="<%=NEXT_LINK%>"><%=NEXT_TITLE%></a><i class="fa fa-angle-right"></i></li>
</ul>

<div class="board-btn">
  <a class='btn btn-default' href="javascript:go_list();">목록보기</a>
</div>

<form name="result" method="get">
<input type="hidden" name="method" value="<%=request("method")%>">
<input type="hidden" name="page" value="<%=request("page")%>">
<input type="hidden" name="q_seq">
</form>

<script language="javascript">
<!--
  function go_list(){
    document.result.method.value = "list";
    document.result.submit();
  }

  function q_view(q_seq){
    document.result.method.value = "view";
    document.result.q_seq.value = q_seq;
    document.result.submit();
  }

  function q_del(){
    var msg = "삭제하시겠습니까?"
    if(confirm(msg)){
      document.location.href = "?action=qna&method=delete&q_seq=<%=Q_SEQ%>";
    }else{
      return;
    }
  }
-->
</script>
