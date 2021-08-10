<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<%
   PG_ITEM = request("item")

   SelfUrl = Request.ServerVariables("URL")
   SelfQuery = Replace(Request.ServerVariables("QUERY_STRING"),"&","|")

   PageQuery = "?item=" & PG_ITEM

   PreDate = Replace(FormatDateTime(DateAdd("d", -2, now()),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_READ_MT,BC_WRITE_MT,BC_MEM_SEQ

   Dim BOARD_LST_Table
   BOARD_LST_Table = "BOARD_LST"

   Dim B_SEQ,B_PTSEQ,B_PSEQ,B_PSORT,B_PDEPTH,B_TITLE,B_CONT,B_FILE_NAME,B_FILE_SIZE,B_READ_CNT
   Dim B_RECO_CNT,B_IP,B_WDATE,B_MDATE,B_STATE,B_MEM_SEQ,B_MEM_NAME

   Dim BOARD_COMMENT_LST_Table
   BOARD_COMMENT_LST_Table = "BOARD_COMMENT_LST"

   Dim BCM_SEQ,BCM_PSEQ,BCM_CONT,BCM_WDATE,BCM_MEM_SEQ

   BC_SEQ = Trim(Request("bc_seq"))
   BC_METHOD = Trim(Request("method"))
   B_CATE = Trim(Request("b_cate"))
   page = Trim(Request("page"))
   B_SEQ = Trim(Request("b_seq"))
   BCM_SEQ = Trim(Request("bcm_seq"))
   search_key = trim(request("search_key"))
   search_word = trim(replace(request("search_word"), chr(34), "&#34;"))

   If page = "" Then page = 1

   If IsNumeric(BC_SEQ) = false Then Response.End

   SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      BC_SEQ = Rs("BC_SEQ")
      BC_TYPE = Rs("BC_TYPE")
      BC_NAME = Rs("BC_NAME")
      BC_SKIN = RS("BC_SKIN")
      BC_READ_MT = Rs("BC_READ_MT")
      BC_WRITE_MT = Rs("BC_WRITE_MT")
      BC_MEM_SEQ = Rs("MEM_SEQ")
   End If
   Rs.close

   If IsNULL(BC_SKIN) OR BC_SKIN = "" Then BC_SKIN = "default"
   SKIN_PATH = "/exec/board/" & BC_SKIN
%>
<form name="w_form" method="post">
<input type="hidden" name="pageid" value="<%=PageID%>">
<input type="hidden" name="pagenum" value="<%=PageNum%>">

<input type="hidden" name="method" value="<%=BC_METHOD%>">

<input type="hidden" name="bc_seq" value="<%=BC_SEQ%>">
<input type="hidden" name="b_cate" value="<%=B_CATE%>">
<input type="hidden" name="b_seq" value="<%=B_SEQ%>">
<input type="hidden" name="bcm_seq" value="<%=BCM_SEQ%>">

<table width="645" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="2" bgcolor="#DBDDDE"></td>
  </tr>
  <tr>
    <td height="30" bgcolor="#F9F9F9">&nbsp;이 게시물의 패스워드를 입력하십시오.</td>
  </tr>
  <tr>
    <td height="200" align="center" style="padding: 10px 10px 10px 10px;">
<% If BCM_SEQ = "" then %>
      <input type="password" name="b_guest_pwd" class="input_02" size="20" maxlength="15" value="">
      <input type="hidden" name="self_url" value="<%=SelfUrl & PageQuery%>">
<% Else %>
      <input type="password" name="bcm_guest_pwd" class="input_02" size="20" maxlength="15" value="">
      <input type="hidden" name="rtn_url" value="<%=SelfUrl%>?<%=SelfQuery%>">
<% End If %>
      <a href="javascript:form_check();"><img src="<%=SKIN_PATH%>/img/btn_ok.gif" border="0" align="absmiddle"></a>
    </td>
  </tr>
  <tr>
    <td height="1" bgcolor="#DBDDDE"></td>
  </tr>
</table>
</form>

<script language="javascript">
<!--
  var form = document.w_form;

  function form_check(){
<% If BCM_SEQ = "" then %>
    if(!chkNull(form.b_guest_pwd, "\'비밀번호\'를 입력해 주세요")) return;

    form.action = "/exec/board/board_pro.asp";
    form.submit();
<% Else %>
    if(!chkNull(form.bcm_guest_pwd, "\'비밀번호\'를 입력해 주세요")) return;

    form.action = "/exec/board/comment_pro.asp";
    form.submit();
<% End If %>
  }
-->
</script>
