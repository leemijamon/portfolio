<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim BOARD_COMMENT_LST_Table
   BOARD_COMMENT_LST_Table = "BOARD_COMMENT_LST"

   Dim BCM_SEQ,BCM_PSEQ,BCM_CONT,BCM_IP,BCM_GUEST_NAME,BCM_GUEST_PWD,BCM_WDATE,BCM_MDATE,BCM_STATE,B_SEQ

   B_SEQ = Trim(Request("b_seq"))
   BCM_SEQ = Trim(Request("bcm_seq"))
   BCM_PSEQ = Trim(Request("bcm_pseq"))
   ACTURL = Trim(Request("acturl"))
   BC_METHOD = Trim(Request("method"))

   If BC_METHOD = "edit" AND BCM_SEQ <> "" Then
      Dim Conn, Rs
      Set Conn = Server.CreateObject("ADODB.Connection")
      Conn.Open Application("connect")

      WHERE = "BCM_SEQ=" & BCM_SEQ

      SQL = "SELECT * FROM " & BOARD_COMMENT_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         BCM_SEQ = Rs("BCM_SEQ")
         BCM_PSEQ = Rs("BCM_PSEQ")
         BCM_CONT = Rs("BCM_CONT")
         BCM_IP = Rs("BCM_IP")
         BCM_GUEST_NAME = Rs("BCM_GUEST_NAME")
         BCM_GUEST_PWD = Rs("BCM_GUEST_PWD")
         BCM_WDATE = Rs("BCM_WDATE")
         BCM_MDATE = Rs("BCM_MDATE")
         BCM_STATE = Rs("BCM_STATE")
         B_SEQ = Rs("B_SEQ")
         MEM_SEQ = Rs("MEM_SEQ")
      End If
      Rs.close

      Conn.Close
      Set Conn = nothing
   End If
%>
<form name="w_form" id="w_form" method="post" target="bframe" action="<%=ACTURL%>" class="form">
<input type="hidden" name="action" value="board.comment">
<input type="hidden" name="b_seq" value="<%=B_SEQ%>">
<input type="hidden" name="bcm_seq" value="<%=BCM_SEQ%>">
<input type="hidden" name="bcm_pseq" value="<%=BCM_PSEQ%>">
<input type="hidden" name="method" value="<%=BC_METHOD%>">

  <fieldset>
<% If MEM_LEVEL <> "99" Then %>
    <input type="hidden" name="mem_seq" value="<%=MEM_SEQ%>">
<% Else %>

    <div class="row">
      <section class="col col-md-6">
      <label class="label">작성자</label>
      <label class="input">
      <i class="icon-append fa fa-user"></i>
      <input type="text" name="bcm_guest_name" id="bcm_guest_name" value="<%=BCM_GUEST_NAME%>">
      </label>
      </section>
      <section class="col col-md-6">
      <label class="label">비밀번호</label>
      <label class="input">
      <i class="icon-append fa fa-lock"></i>
      <input type="password" name="bcm_guest_pwd" id="bcm_guest_pwd" value="">
      </label>
      </section>
    </div>
<% End If %>

    <section>
    <label class="label">댓글</label>
    <label class="textarea">
    <i class="icon-append fa fa-comment"></i>
    <textarea rows="7" name="bcm_cont" id="bcm_cont"><%=BCM_CONT%></textarea>
    </label>
    </section>
  </fieldset>
  <footer class="text-center">
    <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 확인</button>
    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
  </footer>
</form>

<script type="text/javascript">
$(function() {
  $("#w_form").validate({
    rules:{
      bcm_guest_name:{required:true,maxlength:10}
      ,bcm_guest_pwd:{required:true,minlength:4,maxlength:15}
      ,bcm_cont:{required:true,maxlength:200}
    },
    messages:{
      bcm_guest_name:{
        required:"이름을 입력해 주세요.",
        maxlength:jQuery.validator.format("이름은 최대 {0}자 이하로 입력해주세요.")
      }
      ,bcm_guest_pwd:{
        required:"비밀번호를 입력해 주세요.",
        minlength:jQuery.validator.format("비밀번호는 최소 {0}자 이상 입력해주세요."),
        maxlength:jQuery.validator.format("비밀번호는 최대 {0}자 이하로 입력해주세요.")
      }
      ,bcm_cont:{
        required:"댓글을 입력해 주세요.",
        maxlength:jQuery.validator.format("이름은 최대 {0}자 이하로 입력해주세요.")
      }
    }
  });
});
</script>

