<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->

<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title">상담신청</h4>
  </div>
  <div class="panel-body no-padding">

    <form id="w_form" name="w_form" method="post" action="/<%=URL%>" class="form">
    <input type="hidden" name="action" value="qna">
    <input type="hidden" name="method" value="write">

      <header>
        상담신청
        <p class="note">문의사항을 입력해 주세요. 확인 후 답변드리도록 하겠습니다.</p>
      </header>

      <fieldset>
        <div class="row">
          <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 이름</label>
          <section class="col col-md-4">
            <p class="form-control-static"><%=MEM_NAME%></p>
          </section>
        </div>

        <div class="row">
          <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 문의유형</label>
          <section class="col col-md-4">
            <label class="select">
              <select name="q_type" id="q_type">
                <option value="">문의유형</option>
                <option value="">--------------</option>
<%=f_arr_opt(Q_TYPE_CD,Q_TYPE_NAME)%>
              </select><i></i>
            </label>
          </section>
          <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 답변수신</label>
          <section class="col col-md-4">
          <div class="inline-group">
            <label class="checkbox">
              <input type="checkbox" name="q_rtn_mail" value="1" checked>
              <i></i>메일수신
            </label>
            <label class="checkbox">
              <input type="checkbox" name="q_rtn_sms" value="1" checked>
              <i></i>SMS수신
            </label>
          </div>
          </section>
        </div>

        <div class="row">
          <label class="label col col-md-2"><i class="fa fa-check color-red"></i> 제목</label>
          <section class="col col-md-10">
            <label class="input">
              <i class="icon-append fa fa-tag"></i>
              <input type="text" name="q_title" id="q_title" value="<%=Q_TITLE%>">
            </label>
          </section>
        </div>

        <section>
          <label class="textarea">
            <i class="icon-append fa fa-comment"></i>
            <textarea name="q_cont" id="q_cont" rows="20"></textarea>
          </label>
        </section>
      </fieldset>

      <footer class="text-center">
        <button class="btn btn-theme btn-primary" type="submit"><i class="fa fa-check"></i> 상담신청</button>
        <button class="btn btn-default" onclick="document.location.href='';" type="button">취소</button>
      </footer>
    </form>
  </div>
</div>

<script language="javascript">
<!--
  $(function() {
    $("#w_form").validate({
      rules:{
        q_type:{required:true}
        ,q_title:{required:true,maxlength:50}
        ,q_cont:{required:true,maxlength:500}
      },
      messages:{
        q_type:{
          required:"문의유형을 선택해 주세요."
        }
        ,q_title:{
          required:"문의 제목을 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
        ,q_cont:{
          required:"내용을 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
      },
      submitHandler:function(form){
        var msg = "등록하시겠습니까?"
        if(confirm(msg)){
          form.submit();
        }else{
          return;
        }
      }
    });
  });
-->
</script>

