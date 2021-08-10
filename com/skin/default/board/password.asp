<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim BCM_SEQ,BCM_PSEQ,BCM_CONT,BCM_WDATE,BCM_MEM_SEQ

   BC_METHOD = Trim(Request("method"))
   ACTURL = Trim(Request("acturl"))

   B_SEQ = Trim(Request("b_seq"))
   BCM_SEQ = Trim(Request("bcm_seq"))
%>
<form name="p_form" id="p_form" method="post" target="bframe" action="<%=ACTURL%>" class="form">
<input type="hidden" name="action" value="<% If BCM_SEQ = "" then %>board<% Else %>board.comment<% End If %>">
<input type="hidden" name="b_seq" value="<%=B_SEQ%>">
<input type="hidden" name="bcm_seq" value="<%=BCM_SEQ%>">
<input type="hidden" name="method" value="<%=BC_METHOD%>">

  <fieldset>
    <div class="row">
      <section class="col col-md-12">
      <label class="label">비밀번호</label>
      <label class="input">
      <i class="icon-append fa fa-lock"></i>
<% If BCM_SEQ = "" then %>
      <input type="password" name="b_guest_pwd" id="b_guest_pwd" value="">
<% Else %>
      <input type="password" name="bcm_guest_pwd" id="bcm_guest_pwd" value="">
<% End If %>
      </label>
      </section>
    </div>
  </fieldset>
  <footer class="text-center">
    <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 확인</button>
    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
  </footer>
</form>

<script type="text/javascript">
$(function() {
  $("#p_form").validate({
<% If BCM_SEQ = "" then %>
    rules:{
      b_guest_pwd:{required:true,minlength:4,maxlength:15}
    },
    messages:{
      b_guest_pwd:{
        required:"비밀번호를 입력해 주세요.",
        minlength:jQuery.validator.format("비밀번호는 최소 {0}자 이상 입력해주세요."),
        maxlength:jQuery.validator.format("비밀번호는 최대 {0}자 이하로 입력해주세요.")
      }
    }
<% Else %>
    rules:{
      bcm_guest_pwd:{required:true,minlength:4,maxlength:15}
    },
    messages:{
      bcm_guest_pwd:{
        required:"비밀번호를 입력해 주세요.",
        minlength:jQuery.validator.format("비밀번호는 최소 {0}자 이상 입력해주세요."),
        maxlength:jQuery.validator.format("비밀번호는 최대 {0}자 이하로 입력해주세요.")
      }
    }
<% End If %>
  });
});
</script>

