<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/conf/member_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->

<form name="c_form" id="c_form" method="get" class="form">
  <label style="margin-bottom:15px;"><strong><font color="#5288D8"><strong>비회원</strong></font>글 작성에 대한 개인정보 수집에 대한 동의</strong></label>
    <pre style="border:1px solid #C8C8C8;height:250px;overflow:auto;position:relative; margin-bottom:15px;padding:5px;border-radius: 0 !important;">
<%
      Server.Execute("/skin/" & SKIN & "/items/privacy.asp")
%>
    </pre>
  <label class="checkbox">
  <input type="checkbox" name="row_check" id="row_check" value="1">
  <i></i><font color="#666666">위의 '개인정보보호취급방침'에 동의합니다.</font>
  </label>
</form>
<br>
<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title">온라인문의</h4>
  </div>
  <div class="panel-body no-padding">
    <form name="w_form" id="w_form" method="post" target="sframe" class="form">
    <input type="hidden" name="action" value="consult">
      <fieldset>
        <div class="row">
          <section class="col col-md-6">
          <label class="label">이름</label>
          <label class="input">
          <i class="icon-append fa fa-user"></i>
          <input type="text" name="c_name" id="c_name" value="<%=MEM_NAME%>">
          </label>
          </section>
          <section class="col col-md-6">
          <label class="label">이메일</label>
          <label class="input">
          <i class="icon-append fa fa-envelope-o"></i>
          <input type="email" name="c_email" id="c_email" value="<%=MEM_EMAIL%>">
          </label>
          </section>
        </div>
        <div class="row">
          <section class="col col-md-6">
          <label class="label">휴대전화</label>
          <label class="input">
          <i class="icon-append fa fa-phone"></i>
          <input type="text" name="c_hp" id="c_hp" value="<%=MEM_HP%>">
          </label>
          </section>
          <section class="col col-md-6">
          <label class="label">일반전화</label>
          <label class="input">
          <i class="icon-append fa fa-phone"></i>
          <input type="text" name="c_tel" id="c_tel" value="<%=MEM_TEL%>">
          </label>
          </section>
        </div>

        <div class="row">
          <section class="col col-md-3">
          <label class="label">문의구분</label>
          <label class="select">
            <select name="c_type" id="c_type">
              <option value="">문의구분</option>
<%=f_arr_opt(C_TYPE_CD, C_TYPE_NAME)%>
            </select><i></i>
          </label>
          </section>
          <section class="col col-md-9">
          <label class="label">제목</label>
          <label class="input">
          <i class="icon-append fa fa-tag"></i>
          <input type="text" name="c_title" id="c_title">
          </label>
          </section>
        </div>

        <section>
        <label class="label">내용</label>
        <label class="textarea">
        <i class="icon-append fa fa-comment"></i>
        <textarea rows="14" name="c_cont" id="c_cont"></textarea>
        </label>
        </section>
      </fieldset>
      <footer class="text-center">
        <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 보내기</button>
        <button type="button" class="btn btn-default" onclick="document.location.href='<%=LINK_MAIN%>';">취소</button>
      </footer>
    </form>
  </div>
</div>

<script type="text/javascript">
$(function() {
  $.validator.addMethod("hpnumber", function(value, element) {
    return this.optional(element) || /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/.test(value);
  });

  $.validator.addMethod("telnumber", function(value, element) {
    return this.optional(element) || /^\d{2,3}-\d{3,4}-\d{4}$/.test(value);
  });

  $("#w_form").validate({
    rules:{
      c_name:{required:true,maxlength:10}
      ,c_hp:{required:true,hpnumber:true,maxlength:15}
      ,c_tel:{required:false,telnumber:true,maxlength:15}
      ,c_email:{required:true,email:true,maxlength:50}
      ,c_type:{required:true}
      ,c_title:{required:true,maxlength:50}
      ,c_cont:{required:true,maxlength:500}
    },
    messages:{
      c_name:{
        required:"이름을 입력해 주세요.",
        maxlength:jQuery.validator.format("이름은 최대 {0}자 이하로 입력해주세요.")
      }
      ,c_hp:{
        required:"휴대전화 번호를 입력해 주세요.",
        hpnumber:"휴대전화 형식에 맞게 입력해 주세요.",
        maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
      }
      ,c_tel:{
        required:"전화번호를 입력해 주세요.",
        telnumber:"전화번호 형식에 맞게 입력해 주세요.",
        maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
      }
      ,c_email:{
        required:"이메일을 입력해 주세요.",
        email:"이메일 형식에 맞게 입력해 주세요."
      }
      ,c_type:{
        required:"문의 분류를 선택해 주세요.",
      }
      ,c_title:{
        required:"문의 제목을 입력해 주세요.",
        maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
      }
      ,c_cont:{
        required:"내용을 입력해 주세요.",
        maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
      }
    },
    submitHandler:function(form){
      if($("input:checkbox[id='row_check']").is(":checked") != true){
        alert("개인정보취급방침에 동의해야 합니다.");
        return;
      }
      form.submit();
    }
  });
});
</script>
