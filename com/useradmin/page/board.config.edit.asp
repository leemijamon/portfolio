<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_SKIN,BC_MEMO,BC_READ_MT,BC_WRITE_MT,BC_REPLY_MT,BC_COMM_MT,BC_WDATE
   Dim BC_MDATE,BC_STATE,MEM_SEQ,BC_HEADER

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_ID

   If request("bc_seq") <> "" Then
      BC_SEQ = Trim(Request("bc_seq"))

      If IsNumeric(BC_SEQ) = false Then Response.End

      SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ & " AND BC_STATE < '90'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         BC_SEQ = Rs("BC_SEQ")
         BC_TYPE = Rs("BC_TYPE")
         BC_NAME = Rs("BC_NAME")
         BC_SKIN = Rs("BC_SKIN")
         BC_CATE = Rs("BC_CATE")
         BC_HEADER = Rs("BC_HEADER")
         BC_MEMO = Rs("BC_MEMO")
         BC_READ_MT = Rs("BC_READ_MT")
         BC_WRITE_MT = Rs("BC_WRITE_MT")
         BC_REPLY_MT = Rs("BC_REPLY_MT")
         BC_COMM_MT = Rs("BC_COMM_MT")
         BC_NOTICE = Rs("BC_NOTICE")
         BC_SECRET = Rs("BC_SECRET")
         BC_COMMENT = Rs("BC_COMMENT")
         BC_REPLY = Rs("BC_REPLY")
         BC_LIST = RS("BC_LIST")
         BC_LIST_CNT = Rs("BC_LIST_CNT")
         BC_SYNDI = Rs("BC_SYNDI")
         BC_WDATE = Rs("BC_WDATE")
         MEM_SEQ = Rs("MEM_SEQ")
         If IsNULL(BC_NOTICE) Then BC_NOTICE = "0"
         If IsNULL(BC_SECRET) Then BC_SECRET = "0"
         If IsNULL(BC_SYNDI) Then BC_SYNDI = "0"
      End If
      Rs.close

      If IsNULL(MEM_SEQ) = False Then
      SQL = "SELECT MEM_NAME FROM " & MEM_LST_Table & " WHERE MEM_SEQ=" & MEM_SEQ
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         MEM_NAME = Rs("MEM_NAME")
      End If
      Rs.close
      End If

      BC_METHOD = "modify"
   Else
      BC_TYPE = "01"
      BC_READ_MT = "99"
      BC_WRITE_MT = "00"
      BC_REPLY_MT = "00"
      BC_COMM_MT = "00"
      BC_NOTICE = "0"
      BC_SECRET = "0"
      BC_COMMENT = "0"
      BC_REPLY = "0"
      BC_LIST = "0"
      BC_LIST_CNT = 10
      BC_SYNDI = "0"

      BC_METHOD = "register"
   End If

   Conn.Close
   Set Conn = nothing

   folder_dir = Server.MapPath("/exec/board") & "/"

   Set objFile = Server.CreateObject("Scripting.FileSystemObject")
   Set objFolder = objFile.GetFolder(folder_dir)

   For Each folders in objFolder.subfolders
      SKIN_OPT = SKIN_OPT & "<option value='" & folders.name & "'>" & folders.name & "</option>"
   Next
%>
<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">컨텐츠관리</a>
    </li>
    <li class="active">게시판 관리</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">게시판 관리</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">

      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 게시판 관리</div>
        <div class="panel-body no-padding">

<form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="board.config">
<input type="hidden" name="method" value="<%=BC_METHOD%>">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">
<input type="hidden" name="bc_seq" value="<%=BC_SEQ%>">
<input type="hidden" name="mem_seq" id="mem_seq" value="<%=MEM_SEQ%>">
<input type="hidden" name="rtnquery" value="<%=Request.ServerVariables("QUERY_STRING")%>">

<fieldset>
  <div class="row">
    <label class="label col col-md-2">게시판형태</label>
    <section class="col col-md-10">
    <div class="inline-group">
<%
   With response
      s_code = Split(BC_TYPE_CD,",")
      s_name = Split(BC_TYPE_NAME,",")

      For fn = 0 to UBound(s_code)
         .write "      <label class='radio'>" & vbNewLine
         .write "        <input type='radio' name='bc_type' value='" & s_code(fn) & "'>" & vbNewLine
         .write "        <i></i>" & s_name(fn) & vbNewLine
         .write "      </label>" & vbNewLine
      Next
   End With
%>
    </div>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">게시판명</label>
    <section class="col col-md-10">
      <label class="input">
        <input type="text" name="bc_name" data-parsley-maxlength="50" required value="<%=BC_NAME%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">게시판스킨</label>
    <section class="col col-md-5">
      <label class="select">
      <select name="bc_skin" required>
        <option value="">스킨선택</option>
<%=SKIN_OPT%>
        <option value="userskin">사용자스킨(userskin)</option>
      </select>
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">카테고리</label>
    <section class="col col-md-10">
      <label class="input">
        <input type="text" name="bc_cate" data-parsley-maxlength="100" value="<%=BC_CATE%>">
        <p class='note'>","로 구분하여 입력하세요. ex) 제품1,제품2</p>
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">머리말</label>
    <section class="col col-md-10">
      <label class="input">
        <input type="text" name="bc_header" data-parsley-maxlength="100" value="<%=BC_HEADER%>">
        <p class='note'>","로 구분하여 입력하세요. ex) 제품1,제품2</p>
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">메모</label>
    <section class="col col-md-10">
      <label class="input">
        <input type="text" name="bc_memo" data-parsley-maxlength="150" value="<%=BC_MEMO%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">읽기</label>
    <section class="col col-md-5">
      <label class="select">
      <select name="bc_read_mt">
<%=f_arr_opt(MEM_LEVEL_CD, MEM_LEVEL_NAME)%>
        <option value="99">전체공개</option>
      </select>
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">쓰기</label>
    <section class="col col-md-5">
      <label class="select">
      <select name="bc_write_mt">
        <option value="00">관리자</option>
<%=f_arr_opt(MEM_LEVEL_CD, MEM_LEVEL_NAME)%>
        <option value="99">전체공개</option>
      </select>
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">답글</label>
    <section class="col col-md-5">
      <label class="select">
      <select name="bc_reply_mt">
        <option value="00">관리자</option>
<%=f_arr_opt(MEM_LEVEL_CD, MEM_LEVEL_NAME)%>
        <option value="99">전체공개</option>
      </select>
      </label>
    </section>

    <section class="col col-md-5">
    <div class="inline-group">
      <label class="radio">
        <input name="bc_reply" type="radio" value="1">
        <i></i>사용
      </label>
      <label class="radio">
        <input name="bc_reply" type="radio" value="0">
        <i></i>미사용
      </label>
    </div>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">댓글</label>
    <section class="col col-md-5">
      <label class="select">
      <select name="bc_comm_mt">
        <option value="00">관리자</option>
<%=f_arr_opt(MEM_LEVEL_CD, MEM_LEVEL_NAME)%>
        <option value="99">전체공개</option>
      </select>
      </label>
    </section>

    <section class="col col-md-5">
    <div class="inline-group">
      <label class="radio">
        <input name="bc_comment" type="radio" value="1">
        <i></i>사용
      </label>
      <label class="radio">
        <input name="bc_comment" type="radio" value="0">
        <i></i>미사용
      </label>
    </div>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">공지글</label>
    <section class="col col-md-5">
    <div class="inline-group">
      <label class="radio">
        <input name="bc_notice" type="radio" value="1">
        <i></i>사용
      </label>
      <label class="radio">
        <input name="bc_notice" type="radio" value="0">
        <i></i>미사용
      </label>
    </div>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">비밀글</label>
    <section class="col col-md-5">
    <div class="inline-group">
      <label class="radio">
        <input name="bc_secret" type="radio" value="1">
        <i></i>사용
      </label>
      <label class="radio">
        <input name="bc_secret" type="radio" value="0">
        <i></i>미사용
      </label>
    </div>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">뷰+글목록</label>
    <section class="col col-md-5">
    <div class="inline-group">
      <label class="radio">
        <input name="bc_list" type="radio" value="1">
        <i></i>사용
      </label>
      <label class="radio">
        <input name="bc_list" type="radio" value="0">
        <i></i>미사용
      </label>
    </div>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">목록수</label>
    <section class="col col-md-5">
      <label class="select">
      <select name="bc_list_cnt">
<%
   For i = 1 to 30
      response.write "        <option value='" & i & "'>" & i & "개</option>"
   Next
%>
      </select>
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">신디케이션</label>
    <section class="col col-md-5">
    <div class="inline-group">
      <label class="radio">
        <input name="bc_syndi" type="radio" value="1">
        <i></i>사용
      </label>
      <label class="radio">
        <input name="bc_syndi" type="radio" value="0">
        <i></i>미사용
      </label>
    </div>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-2">관리회원</label>
    <section class="col col-md-5">
      <label class="input">
        <input type="text" name="mem_name" id="mem_name" data-parsley-maxlength="20" value="<%=MEM_NAME%>" required onkeypress="if(event.keyCode==13) {getSearch(); return false;}" autocomplete="false">
        <div id="rtn-search" class="rtn-search">
        </div>

        <p class="note">* 회원명을 입력하여 검색해 주세요.</p>
      </label>
    </section>
    <section class="col col-md-5" id="btn-search">
       <button type="button" class="btn btn-default" onclick="getSearch();">찾기</button>
    </section>
  </div>
</fieldset>

<footer>
  <button type="submit" class="btn btn-primary">
    <i class="fa fa-pencil fa-lg"></i> 저장
  </button>
  <button class="btn btn-default" type="button" onclick="go_list();">목록보기</button>
</footer>
</form>

        </div>
      </div>
    </div>
  </div>

</div>

<script type="text/javascript">
  runConfigList();

  function runConfigList(){
    $("input:radio[name='bc_type']:radio[value='<%=BC_TYPE%>']").attr("checked",true);
    $("input:radio[name='bc_reply']:radio[value='<%=BC_REPLY%>']").attr("checked",true);
    $("input:radio[name='bc_comment']:radio[value='<%=BC_COMMENT%>']").attr("checked",true);
    $("input:radio[name='bc_notice']:radio[value='<%=BC_NOTICE%>']").attr("checked",true);
    $("input:radio[name='bc_secret']:radio[value='<%=BC_SECRET%>']").attr("checked",true);
    $("input:radio[name='bc_list']:radio[value='<%=BC_LIST%>']").attr("checked",true);
    $("input:radio[name='bc_syndi']:radio[value='<%=BC_SYNDI%>']").attr("checked",true);

    $('select[name=bc_skin]').find('option[value="<%=BC_SKIN%>"]').prop('selected', true);
    $('select[name=bc_read_mt]').find('option[value="<%=BC_READ_MT%>"]').prop('selected', true);
    $('select[name=bc_write_mt]').find('option[value="<%=BC_WRITE_MT%>"]').prop('selected', true);
    $('select[name=bc_reply_mt]').find('option[value="<%=BC_REPLY_MT%>"]').prop('selected', true);
    $('select[name=bc_comm_mt]').find('option[value="<%=BC_COMM_MT%>"]').prop('selected', true);
    $('select[name=bc_list_cnt]').find('option[value="<%=BC_LIST_CNT%>"]').prop('selected', true);

    $("#editform").parsley();
  }

  function hideSearch(){
    $("#rtn-search").fadeOut();
  }

  function getSearch(){
    var query = escape($("#mem_name").val());
    if(query.length > 2){
      $("#rtn-search").fadeIn();
      try{
        var sUrl = "exec/member.search.asp";
        var params = "query=" + query;

        $.ajax({
          type:"get", // 방식
          url:sUrl, //주소
          data:params,
          dataType:"html",
          success:function(args){
            $("#rtn-search").html('<button class="close" aria-hidden="true" type="button" onclick="hideSearch();return false;">×</button><div class="rtn-search-relative">'+args+'</div>');
          },
          error:function(E){
            alert("Error : " + E.responseText);
          }
        });
      }catch(E){
          alert("Error");
      }
    }else{
      alert("회원명을 입력해 주세요.");
      $("#mem_name").focus();
      return;
    }
  }

  function setSearch(seq,nm){
    $("#mem_name").val(nm).attr("readonly",true);
    $("#mem_seq").val(seq);
    $("#rtn-search").fadeOut();
    $("#btn-search").html('<button type="button" class="btn btn-default" onclick="getReSearch();">다시찾기</button>');
  }

  function getReSearch(){
    $("#mem_name").val('').attr("readonly",false);
    $("#mem_seq").val('');
    $("#btn-search").html('<button type="button" class="btn btn-default" onclick="getSearch();">찾기</button>');
  }

  function go_list(){
    AjaxloadURL("page/board.config.asp?<%=Request.ServerVariables("QUERY_STRING")%>", $('#main-content'));
  }
</script>
