<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/conf/member_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<%
   If Login_check = "Y" Then
      Response.Redirect "/member/modify"
      Response.End
   End If

   PG_METHOD = Trim(Request("method"))
%>
<% If PG_METHOD = "" OR PG_METHOD = "search" Then %>
<div class="tabbable">
  <ul class="nav nav-tabs">
    <li class="active"><a href="#1" data-toggle="tab">이메일로 찾기</a></li>
    <li><a href="#2" data-toggle="tab">휴대전화로 찾기</a></li>
    <li><a href="#3" data-toggle="tab">생년월일로 찾기</a></li>
  </ul>
  <div class="tab-content">
    <div class="tab-pane active" id="1">

      <form name="sform1" id="sform1" method="post" action="?method=result" class="form" role="form">
      <input type="hidden" name="stype" value="email">

        <header>
          이메일로 찾기
          <p class="note">가입하신 아이디, 이름, 이메일을 입력해주세요.</p>
        </header>

        <fieldset>
          <div class="row">
            <label class="label col col-md-2"><i class="fa fa-check color-red"></i>아이디</label>
            <section class="col col-md-4">
              <label class="input">
                <input type="text" id="mem_id" name="mem_id">
              </label>
            </section>
          </div>

          <div class="row">
            <label class="label col col-md-2"><i class="fa fa-check color-red"></i>이름</label>
            <section class="col col-md-4">
              <label class="input">
                <input type="text" id="mem_name" name="mem_name">
              </label>
            </section>
          </div>

          <div class="row">
            <label class="label col col-md-2"><i class="fa fa-check color-red"></i>이메일</label>
            <section class="col col-md-4">
              <label class="input">
                <input type="email" id="mem_email" name="mem_email">
              </label>
            </section>
          </div>
        </fieldset>

        <footer class="text-center">
          <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 비밀번호찾기</button>
          <button type="button" class="btn btn-default" onclick="document.location.href='<%=LINK_MAIN%>';">취소</button>
        </footer>
      </form>

    </div>
    <div class="tab-pane" id="2">

      <form name="sform2" id="sform2" method="post" action="?method=result" class="form" role="form">
      <input type="hidden" name="stype" value="hp">

        <header>
          휴대전화로 찾기
          <p class="note">가입하신 아이디, 이름, 휴대전화번호를 입력해주세요.</p>
        </header>

        <fieldset>
          <div class="row">
            <label class="label col col-md-2"><i class="fa fa-check color-red"></i>아이디</label>
            <section class="col col-md-4">
              <label class="input">
                <input type="text" id="mem_id" name="mem_id">
              </label>
            </section>
          </div>

          <div class="row">
            <label class="label col col-md-2"><i class="fa fa-check color-red"></i>이름</label>
            <section class="col col-md-4">
              <label class="input">
                <input type="text" id="mem_name" name="mem_name">
              </label>
            </section>
          </div>

          <div class="row">
            <label class="label col col-md-2"><i class="fa fa-check color-red"></i>휴대폰번호</label>
            <section class="col col-md-4">
              <label class="input">
                <input type="text" id="mem_hp" name="mem_hp">
              </label>
            </section>
          </div>
        </fieldset>

        <footer class="text-center">
          <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 비밀번호찾기</button>
          <button type="button" class="btn btn-default" onclick="document.location.href='<%=LINK_MAIN%>';">취소</button>
        </footer>
      </form>

    </div>
    <div class="tab-pane" id="3">
      <form name="sform3" id="sform3" method="post" action="?method=result" class="form" role="form">
      <input type="hidden" name="stype" value="birth">

        <header>
          생년월일로 찾기
          <p class="note">가입하신 아이디, 이름, 생년월일, 성별을 입력해주세요.</p>
        </header>

        <fieldset>
          <div class="row">
            <label class="label col col-md-2"><i class="fa fa-check color-red"></i>아이디</label>
            <section class="col col-md-4">
              <label class="input">
                <input type="text" id="mem_id" name="mem_id">
              </label>
            </section>
          </div>

          <div class="row">
            <label class="label col col-md-2"><i class="fa fa-check color-red"></i>이름</label>
            <section class="col col-md-4">
              <label class="input">
                <input type="text" id="mem_name" name="mem_name">
              </label>
            </section>
          </div>

          <div class="row">
            <label class="label col col-md-2"><i class="fa fa-check color-red"></i>생년월일</label>
            <section class="col col-md-4">
              <label class="input">
                <input type="text" id="mem_birth" name="mem_birth">
              </label>
            </section>
          </div>

          <div class="row">
            <label class="label col col-md-2"><i class="fa fa-check color-red"></i>성별</label>
            <section class="col col-md-4">

              <div class="inline-group">
                <label class="radio">
                  <input type="radio" name="mem_sex" id="mem_sex" value="1" checked>
                  <i></i>남
                </label>
                <label class="radio">
                  <input type="radio" name="mem_sex" id="mem_sex" value="2">
                  <i></i>여
                </label>
              </div>
            </section>
          </div>
        </fieldset>

        <footer class="text-center">
          <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 비밀번호찾기</button>
          <button type="button" class="btn btn-default" onclick="document.location.href='<%=LINK_MAIN%>';">취소</button>
        </footer>
      </form>

    </div>
  </div>
</div>

<script type="text/javascript">
  $(function() {
    $.validator.addMethod("alphanumeric", function(value, element) {
      return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);
    });

    $.validator.addMethod("hpnumber", function(value, element) {
      return this.optional(element) || /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/.test(value);
    });

    $.validator.addMethod("isdate", function(value, element) {
      return this.optional(element) || /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/.test(value);
    });

    $("#sform1").validate({
      rules:{
        mem_id:{required:true,minlength:4,maxlength:15,alphanumeric:true}
        ,mem_name:{required:true,minlength:2,maxlength:5}
        ,mem_email:{required:true,email:true}
      },
      messages:{
        mem_id:{
          required:"아이디를 입력해 주세요.",
          minlength:jQuery.validator.format("아이디는 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("아이디는 최대 {0}자 이하로 입력해주세요."),
          alphanumeric:"알파벳과 숫자만 사용가능합니다."
        }
        ,mem_name:{
          required:"이름을 입력해 주세요.",
          minlength:jQuery.validator.format("이름은 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("이름은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_email:{
          required:"이메일을 입력해 주세요.",
          email:"이메일 형식에 맞게 입력해 주세요."
        }
      }
    });

    $("#sform2").validate({
      rules:{
        mem_id:{required:true,minlength:4,maxlength:15,alphanumeric:true}
        ,mem_name:{required:true,minlength:2,maxlength:5}
        ,mem_hp:{required:true,hpnumber:true,maxlength:15}
      },
      groups: {
        HpofNum:"mem_hp1 mem_hp2 mem_hp3"
      },
      messages:{
        mem_id:{
          required:"아이디를 입력해 주세요.",
          minlength:jQuery.validator.format("아이디는 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("아이디는 최대 {0}자 이하로 입력해주세요."),
          alphanumeric:"알파벳과 숫자만 사용가능합니다."
        }
        ,mem_name:{
          required:"이름을 입력해 주세요.",
          minlength:jQuery.validator.format("이름은 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("이름은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_hp:{
          required:"휴대전화 번호를 입력해 주세요.",
          hpnumber:"휴대전화 형식에 맞게 입력해 주세요.",
          maxlength:jQuery.validator.format("최대 {0}자 이하로 입력해주세요.")
        }
      }
    });

    $("#sform3").validate({
      rules:{
        mem_id:{required:true,minlength:4,maxlength:15,alphanumeric:true}
        ,mem_name:{required:true,minlength:2,maxlength:5}
        ,mem_birth:{required:true,isdate:true}
        ,mem_sex:{required:true}
      },
      messages:{
        mem_id:{
          required:"아이디를 입력해 주세요.",
          minlength:jQuery.validator.format("아이디는 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("아이디는 최대 {0}자 이하로 입력해주세요."),
          alphanumeric:"알파벳과 숫자만 사용가능합니다."
        }
        ,mem_name:{
          required:"이름을 입력해 주세요.",
          minlength:jQuery.validator.format("이름은 최소 {0}자 이상 입력해주세요."),
          maxlength:jQuery.validator.format("이름은 최대 {0}자 이하로 입력해주세요.")
        }
        ,mem_birth:{
          required:"생년월일을 입력해 주세요.",
          isdate:"날짜 형식(YYYY-MM-DD)에 맞게 입력하세요."
        }
      }
    });
  });
</script>
<% End If %>
<% If PG_METHOD = "result" Then %>
<%
   stype = request("stype")
   MEM_ID = Replace(Trim(Request.Form("mem_id")),"'","''")
   MEM_NAME = Replace(Trim(Request.Form("mem_name")),"'","''")

   If stype = "email" Then
      MEM_EMAIL = Replace(Trim(Request.Form("mem_email")),"'","''")
      WHERE = "MEM_ID='" & MEM_ID & "' AND MEM_NAME='" & MEM_NAME & "' AND MEM_EMAIL='" & MEM_EMAIL & "' AND MEM_STATE < '90'"
   End If

   If stype = "hp" Then
      MEM_HP = Replace(Trim(Request.Form("mem_hp")),"'","''")
      WHERE = "MEM_ID='" & MEM_ID & "' AND MEM_NAME='" & MEM_NAME & "' AND MEM_HP='" & MEM_HP & "' AND MEM_STATE < '90'"
   End If

   If stype = "birth" Then
      MEM_BIRTH = Replace(Trim(Request.Form("mem_birth")),"'","''")
      MEM_SEX = Trim(Request.Form("mem_sex"))
      WHERE = "MEM_ID='" & MEM_ID & "' AND MEM_NAME='" & MEM_NAME & "' AND MEM_BIRTH='" & MEM_BIRTH & "' AND MEM_STATE < '90'"
   End If

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT MEM_SEQ,MEM_ID,MEM_EMAIL,MEM_WDATE FROM " & MEM_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF OR Rs.EOF Then
      With response
         .write "<div class='panel panel-default animated fadeInUp'>" & vbNewLine
         .write "  <div class='panel-heading'>" & vbNewLine
         .write "    <h4 class='panel-title'>아이디찾기결과</h4>" & vbNewLine
         .write "  </div>" & vbNewLine
         .write "  <div class='panel-body'>" & vbNewLine

         .write "    <ul class='unstyled margin-bottom-20'>" & vbNewLine
         .write "      <li><strong>회원정보를 찾을수 없습니다.</strong></li>" & vbNewLine
         .write "      <li>등록하신 정보와 일치하는 회원정보를 찾을 수 없습니다.</li>" & vbNewLine
         .write "    </ul>" & vbNewLine

         .write "    <div class='form-btn'>" & vbNewLine
         .write "      <button type='button' class='btn btn-theme btn-primary' onclick=""document.location.href='?method=search';"">비밀번호찾기</button>" & vbNewLine
         .write "      <button type='button' class='btn btn-default' onclick=""document.location.href='/';"">취소</button>" & vbNewLine
         .write "    </div>" & vbNewLine

         .write "  </div>" & vbNewLine
         .write "</div>" & vbNewLine
      End With
   Else
      With response
         .write "<div class='panel panel-default animated fadeInUp'>" & vbNewLine
         .write "  <div class='panel-heading'>" & vbNewLine
         .write "    <h4 class='panel-title'>아이디 일부확인</h4>" & vbNewLine
         .write "  </div>" & vbNewLine
         .write "  <div class='panel-body'>" & vbNewLine

         .write "  <form name='sform' id='sform' method='post'>" & vbNewLine
         .write "  <input type='hidden' name='action' value='member.pwsearch_send'>" & vbNewLine
         .write "    <ul class='unstyled margin-bottom-20'>" & vbNewLine

         MEM_SEQ = Rs("MEM_SEQ")
         MEM_EMAIL = Rs("MEM_EMAIL")
         MEM_WDATE = f_date(Rs("MEM_WDATE"),".")

         .write "      <li>" & vbNewLine
         .write "        <input type='hidden' name='mem_seq' value='" & MEM_SEQ & "'>" & vbNewLine
         .write "        <strong>이메일 주소 : " & MEM_EMAIL & "</strong>" & vbNewLine
         .write "      </li>" & vbNewLine

         .write "    </ul>" & vbNewLine

         .write "    <ul class='unstyled margin-bottom-20'>" & vbNewLine
         .write "      <li><span style='color:#ff6600'>회원정보상의 이메일주소</span>로 임시 비밀번호를 보내드립니다.</li>" & vbNewLine
         .write "      <li>임시비밀번호로 로그인 하신 후, 회원정보에서 비밀번호를 변경해주세요.</li>" & vbNewLine
         .write "    </ul>" & vbNewLine

         .write "    <div class='form-btn'>" & vbNewLine
         .write "      <button type='submit' class='btn btn-theme btn-primary'>이메일로 임시비밀번호 전송</button>" & vbNewLine
         .write "      <button type='button' class='btn btn-default' onclick=""document.location.href='/';"">취소</button>" & vbNewLine
         .write "    </div>" & vbNewLine
         .write "  </form>" & vbNewLine

         .write "  </div>" & vbNewLine
         .write "</div>" & vbNewLine

         .write "<script type='text/javascript'>" & vbNewLine
         .write "$(function() {" & vbNewLine
         .write "  $('#sform').validate({" & vbNewLine
         .write "    rules:{" & vbNewLine
         .write "      mem_seq:{required:true}" & vbNewLine
         .write "    }," & vbNewLine
         .write "    messages:{" & vbNewLine
         .write "      mem_seq:{" & vbNewLine
         .write "        required:'이메일을 선택해 주세요.'" & vbNewLine
         .write "      }" & vbNewLine
         .write "    }" & vbNewLine
         .write "  });" & vbNewLine
         .write "});" & vbNewLine
         .write "</script>" & vbNewLine
      End With
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing
%>
<% End If %>