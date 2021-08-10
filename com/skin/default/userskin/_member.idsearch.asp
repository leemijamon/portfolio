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
          <p class="note">가입하신 이름과 이메일을 입력해주세요.</p>
        </header>

        <fieldset>
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
          <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 아이디찾기</button>
          <button type="button" class="btn btn-default" onclick="document.location.href='/';">취소</button>
        </footer>
      </form>

    </div>
    <div class="tab-pane" id="2">

      <form name="sform2" id="sform2" method="post" action="?method=result" class="form" role="form">
      <input type="hidden" name="stype" value="hp">

        <header>
          휴대전화로 찾기
          <p class="note">가입하신 이름과 휴대전화번호를 입력해주세요.</p>
        </header>

        <fieldset>
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
          <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 아이디찾기</button>
          <button type="button" class="btn btn-default" onclick="document.location.href='/';">취소</button>
        </footer>
      </form>

    </div>
    <div class="tab-pane" id="3">

      <form name="sform3" id="sform3" method="post" action="?method=result" class="form" role="form">
      <input type="hidden" name="stype" value="birth">

        <header>
          생년월일로 찾기
          <p class="note">가입하신 이름과 생년월일과 성별을 입력해주세요.</p>
        </header>

        <fieldset>
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
          <button type="submit" class="btn btn-theme btn-primary"><i class="fa fa-check"></i> 아이디찾기</button>
          <button type="button" class="btn btn-default" onclick="document.location.href='/';">취소</button>
        </footer>
      </form>

    </div>
  </div>
</div>

<script type="text/javascript">
  $(function() {
    $.validator.addMethod("hpnumber", function(value, element) {
      return this.optional(element) || /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/.test(value);
    });

    $.validator.addMethod("isdate", function(value, element) {
      return this.optional(element) || /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/.test(value);
    });

    $("#sform1").validate({
      rules:{
        mem_name:{required:true,minlength:2,maxlength:5}
        ,mem_email:{required:true,email:true}
      },
      messages:{
        mem_name:{
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
        mem_name:{required:true,minlength:2,maxlength:5}
        ,mem_hp:{required:true,hpnumber:true,maxlength:15}
      },
      messages:{
        mem_name:{
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
        mem_name:{required:true,minlength:2,maxlength:5}
        ,mem_birth:{required:true,isdate:true}
        ,mem_sex:{required:true}
      },
      messages:{
        mem_name:{
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
   MEM_NAME = Replace(Trim(Request.Form("mem_name")),"'","''")

   If stype = "email" Then
      MEM_EMAIL = Replace(Trim(Request.Form("mem_email")),"'","''")
      WHERE = "MEM_NAME='" & MEM_NAME & "' AND MEM_EMAIL='" & MEM_EMAIL & "' AND MEM_STATE < '90'"
   End If

   If stype = "hp" Then
      MEM_HP = Replace(Trim(Request.Form("mem_hp")),"'","''")
      WHERE = "MEM_NAME='" & MEM_NAME & "' AND MEM_HP='" & MEM_HP & "' AND MEM_STATE < '90'"
   End If

   If stype = "birth" Then
      MEM_BIRTH = Replace(Trim(Request.Form("mem_birth")),"'","''")
      MEM_SEX = Trim(Request.Form("mem_sex"))
      WHERE = "MEM_NAME='" & MEM_NAME & "' AND MEM_BIRTH='" & MEM_BIRTH & "' AND MEM_SEX='" & MEM_SEX & "' AND MEM_STATE < '90'"
   End If

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT COUNT(*) FROM " & MEM_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   recordCount = Rs(0)
   Rs.close

   If recordCount = 0 Then
      With response
         .write "<div class='panel panel-default'>" & vbNewLine
         .write "  <div class='panel-heading'>" & vbNewLine
         .write "    <h4 class='panel-title'>아이디찾기결과</h4>" & vbNewLine
         .write "  </div>" & vbNewLine
         .write "  <div class='panel-body'>" & vbNewLine

         .write "    <ul class='unstyled margin-bottom-20'>" & vbNewLine
         .write "      <li><strong>아이디를 찾을수 없습니다.</strong></li>" & vbNewLine
         .write "      <li>등록하신 정보와 일치하는 아이디를 찾을 수 없습니다.</li>" & vbNewLine
         .write "    </ul>" & vbNewLine

         .write "    <div class='form-btn'>" & vbNewLine
         .write "      <button type='button' class='btn btn-theme btn-primary' onclick=""document.location.href='?method=search';"">아이디찾기</button>" & vbNewLine
         .write "      <button type='button' class='btn btn-default' onclick=""document.location.href='/';"">취소</button>" & vbNewLine
         .write "    </div>" & vbNewLine

         .write "  </div>" & vbNewLine
         .write "</div>" & vbNewLine
      End With
   Else
      With response
         .write "<div class='panel panel-default'>" & vbNewLine
         .write "  <div class='panel-heading'>" & vbNewLine
         .write "    <h4 class='panel-title'>아이디 일부확인</h4>" & vbNewLine
         .write "  </div>" & vbNewLine
         .write "  <div class='panel-body'>" & vbNewLine

         .write "  <form name='sform' id='sform' method='post'>" & vbNewLine
         .write "  <input type='hidden' name='action' value='member.idsearch_send'>" & vbNewLine
         .write "    <ul class='unstyled margin-bottom-20'>" & vbNewLine

         SQL = "SELECT MEM_SEQ,MEM_ID,MEM_WDATE FROM " & MEM_LST_Table & " WHERE " & WHERE
         Set Rs = Conn.Execute(SQL, ,adCmdText)

         i = 0
         If Rs.BOF = false AND Rs.EOF = false Then
            Do until Rs.EOF
               MEM_SEQ = Rs("MEM_SEQ")
               MEM_ID = Rs("MEM_ID")
               MEM_WDATE = f_date(Rs("MEM_WDATE"),".")

               .write "      <li>" & vbNewLine

               If recordCount = 1 Then
                  .write "      <input type='hidden' name='mem_seq' value='" & MEM_SEQ & "'>" & vbNewLine
               Else
                  .write "      <input type='radio' name='mem_seq' value='" & MEM_SEQ & "'>" & vbNewLine
               End If

               .write "        <strong class='color-red'>" & Left(MEM_ID,Len(MEM_ID)-3) & "***</strong> <span class='note'>(가입 날짜 : " & MEM_WDATE & ")</span>" & vbNewLine
               .write "      </li>" & vbNewLine

               i = i + 1
               Rs.MoveNext
            Loop
         End If
         Rs.close

         .write "    </ul>" & vbNewLine

         .write "    <ul class='unstyled margin-bottom-20'>" & vbNewLine
         .write "      <li>개인정보보호를 위해 아이디 끝자리는 ***로 표시됩니다.</li>" & vbNewLine
         .write "      <li>동일한 등록정보를 가진 동명이인의 아이디가 함께 검색될 수 있습니다.</li>" & vbNewLine
         .write "      <li>끝자리 '*' 처리된 부분을 확인하시려면 E-mail로 받아보세요. 회원정보에 기재된 이메일주소로 회원아이디를 전송해드립니다.</li>" & vbNewLine
         .write "    </ul>" & vbNewLine

         .write "    <div class='form-btn'>" & vbNewLine
         .write "      <button type='submit' class='btn btn-theme btn-primary'>이메일로 아이디 전송</button>" & vbNewLine
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

   Conn.Close
   Set Conn = nothing
%>
<% End If %>
<br>