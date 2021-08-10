<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CP_CODE,CP_TYPE,CP_NAME,CP_TITLE,CP_MEM_LEVEL,CP_CONT,CP_NUM,CP_PG_YN,CP_PG_ITEM
   Dim CP_PG_NAME,CP_PG_QUERY,CP_USE_YN

   CS_CODE = Trim(Request("cs_code"))
   CP_SEQ = Trim(Request("cp_seq"))

   If CS_CODE <> "" AND CP_SEQ <> "" Then
      WHERE = "CS_CODE='" & CS_CODE & "' AND CP_SEQ=" & CP_SEQ

      SQL = "SELECT * FROM " & CMS_PAGE_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         CP_TYPE = Rs("CP_TYPE")
         CP_CODE = Rs("CP_CODE")
         CP_NUM = Rs("CP_NUM")
         CP_NAME = Rs("CP_NAME")
         CP_TITLE = Rs("CP_TITLE")
         CP_TITLE_ENG = Rs("CP_TITLE_ENG")
         CP_KEYWORDS = Rs("CP_KEYWORDS")
         CP_DESCRIPTION = Rs("CP_DESCRIPTION")
         CP_MEM_LEVEL = Rs("CP_MEM_LEVEL")
         CP_SKIN = Rs("CP_SKIN")
         CP_PG_YN = Rs("CP_PG_YN")
         CP_PG_ITEM = Rs("CP_PG_ITEM")
         CP_PG_NAME = Rs("CP_PG_NAME")
         CP_PG_QUERY = Rs("CP_PG_QUERY")
         CP_USE_YN = Rs("CP_USE_YN")
         CP_SSL_YN = Rs("CP_SSL_YN")
         CL_CODE = Rs("CL_CODE")

         If CP_PG_YN = "1" Then CP_PG = CP_PG_ITEM & "|" & CP_PG_QUERY & "|" & CP_PG_NAME
      End If
      Rs.close

      CP_METHOD = "modify"
   Else
      CP_METHOD = "register"
      CP_MEM_LEVEL = "99"
      CP_USE_YN = "1"
      CP_SSL_YN = "0"
      CL_CODE = "sub"
   End If

   If IsNULL(CP_TYPE) OR CP_TYPE = "" Then CP_TYPE = "web"

   Dim CMS_LAYOUT_LST_Table
   CMS_LAYOUT_LST_Table = "CMS_LAYOUT_LST"

   WHERE = "CS_CODE='" & CS_CODE & "' AND CL_STATE<'90'"
   SQL = "SELECT CL_CODE,CL_NAME FROM " & CMS_LAYOUT_LST_Table & " WHERE " & WHERE & " ORDER BY CL_SORT"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   i = 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         i = i + 1
         L_CODE = Rs("CL_CODE")
         L_NAME = Rs("CL_NAME")

         LAYOUT_OPT = LAYOUT_OPT & "<option value='" & L_CODE & "'>" & L_NAME & " (" & L_CODE & ")</option>"

         Rs.MoveNext
      Loop
   End If
   Rs.close

   Dim PG_OPT

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_READ_MT,BC_WRITE_MT

   SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_STATE < '90' ORDER BY BC_SEQ"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   i = 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         i = i + 1
         BC_SEQ = Rs("BC_SEQ")
         BC_NAME = Rs("BC_NAME")
         BC_CATE = RS("BC_CATE")

         PG_OPT = PG_OPT & "<option value='board|bc_seq=" & BC_SEQ & "|" & BC_NAME & "'>" & BC_NAME & "</option>"

         If BC_CATE <> "" Then
            If InStr(BC_CATE,",") > 0 Then
               SP_CATE = Split(BC_CATE,",")

               For fn = 0 to UBound(SP_CATE)
                  PG_OPT = PG_OPT & "<option value='board|bc_seq=" & BC_SEQ & "&b_cate=" & SP_CATE(fn) & "|" & BC_NAME & "'>" & BC_NAME & "(" & SP_CATE(fn) & ")</option>"
               Next
            Else
               PG_OPT = PG_OPT & "<option value='board|bc_seq=" & BC_SEQ & "&b_cate=" & BC_CATE & "|" & BC_NAME & "'>" & BC_NAME & "(" & BC_CATE & ")</option>"
            End If
         End If

         Rs.MoveNext
      Loop
   End If
   Rs.close

   Call PgList("qna", "", "1:1문의")
   Call PgList("faq", "", "자주하는질문")
   Call PgList("consult", "", "온라인문의")
   Call PgList("map", "", "오시는길")

   Sub PgList(pg_item,pg_query,pg_name)
      PG_OPT = PG_OPT & "<option value='" & pg_item & "|" & pg_query & "|" & pg_name & "'>" & pg_name & "</option>"
   End Sub

   Conn.Close
   Set Conn = nothing

   folder_dir = Server.MapPath("/execskin")

   Set objFile = Server.CreateObject("Scripting.FileSystemObject")
   Set objFolder = objFile.GetFolder(folder_dir)

   For Each folders in objFolder.subfolders
      SKIN_OPT = SKIN_OPT & "<option value='" & folders.name & "'>" & folders.name & "</option>"
   Next
%>
<form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
<input type="hidden" name="action" value="skin.page">
<input type="hidden" name="cs_code" value="<%=CS_CODE%>">
<input type="hidden" name="cp_seq" value="<%=CP_SEQ%>">
<input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">
<input type="hidden" name="method" value="<%=CP_METHOD%>">
<input type="hidden" name="cp_type" value="web">

<fieldset>
  <div class="row">
    <label class="label col col-md-3">페이지주소</label>
    <section class="col col-md-9">
      <label class="input">
        <input type="text" name="cp_code" data-parsley-maxlength="30" data-parsley-minlength="2" required value="<%=CP_CODE%>">
        <p class="note">예) business or compamy/business - 반드시 형식에 맞게 입력하세요!!</p>
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">사용여부</label>
    <section class="col col-md-9">
    <div class="inline-group">
      <label class="radio">
        <input type="radio" name="cp_use_yn" value="1">
        <i></i>사용
      </label>
      <label class="radio">
        <input type="radio" name="cp_use_yn" value="0">
        <i></i>미사용
      </label>
    </div>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">페이지명/메뉴번호</label>
    <section class="col col-md-5">
      <label class="input">
        <input type="text" name="cp_name" data-parsley-maxlength="50" required value="<%=CP_NAME%>">
      </label>
    </section>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="cp_num" data-parsley-maxlength="10" value="<%=CP_NUM%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">타이틀/영문</label>
    <section class="col col-md-5">
      <label class="input">
        <input type="text" name="cp_title" data-parsley-maxlength="50" required value="<%=CP_TITLE%>">
      </label>
    </section>
    <section class="col col-md-4">
      <label class="input">
        <input type="text" name="cp_title_eng" data-parsley-maxlength="50" value="<%=CP_TITLE_ENG%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">메타테그 키워드</label>
    <section class="col col-md-9">
      <label class="input">
        <input type="text" name="cp_keywords" data-parsley-maxlength="150" value="<%=CP_KEYWORDS%>">
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">메타테그 설명</label>
    <section class="col col-md-9">
      <label class="textarea">
        <textarea rows="4" name="cp_description"><%=CP_DESCRIPTION%></textarea>
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">페이지접근권한</label>
    <section class="col col-md-5">
      <label class="select">
        <select name="cp_mem_level" required>
<%=f_arr_opt(MEM_LEVEL_CD, MEM_LEVEL_NAME)%>
          <option value="99">전체공개</option>
        </select><i></i>
      </label>
    </section>
    <section class="col col-md-4">
      <label class="select">
        <input type="checkbox" name="cp_ssl_yn" value="1"> 보안서버대상
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">페이지스킨</label>
    <section class="col col-md-5">
      <label class="select">
      <select name="cp_skin">
        <option value="">사용자입력</option>
        <option value="userskin">사용자스킨</option>
<%=SKIN_OPT%>
      </select><i></i>
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">기능성페이지</label>
    <section class="col col-md-5">
      <label class="select">
      <select name="cp_pg">
        <option value="">사용안함</option>
<%=PG_OPT%>
<%
   layout_file = Server.MapPath("/useradmin") & "\pgitem.asp"

   If File_Exists(layout_file) Then
      EXEC_FILE = "/useradmin/pgitem.asp"
      Server.Execute(EXEC_FILE)
   End If

   Function File_Exists(file)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")
      If (fso.FileExists(file)) Then
         File_Exists = True
      Else
         File_Exists = false
      End If
   End Function
%>
      </select><i></i>
      </label>
    </section>
  </div>
  <div class="row">
    <label class="label col col-md-3">레이아웃선택</label>
    <section class="col col-md-5">
      <label class="select">
      <select name="cl_code" required>
<%=LAYOUT_OPT%>
      </select><i></i>
      </label>
    </section>
  </div>
</fieldset>

<footer>
  <button type="submit" class="btn btn-primary">
    <i class="fa fa-pencil fa-lg"></i> 저장
  </button>
  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
</footer>
</form>

<script type="text/javascript">
  $("input:radio[name='cp_use_yn']:radio[value='<%=CP_USE_YN%>']").attr("checked",true);

  //$("select[name='cp_mem_level']").val("<%=CP_MEM_LEVEL%>");
  //$("select[name='cp_skin']").val("<%=CP_SKIN%>");
  //$("select[name='cp_pg']").val("<%=CP_PG%>");
  //$("select[name='cl_code']").val("<%=CL_CODE%>");

  $('select[name=cp_mem_level]').find('option[value="<%=CP_MEM_LEVEL%>"]').prop('selected', true);
  $('select[name=cp_skin]').find('option[value="<%=CP_SKIN%>"]').prop('selected', true);
  $('select[name=cp_pg]').find('option[value="<%=CP_PG%>"]').prop('selected', true);
  $('select[name=cl_code]').find('option[value="<%=CL_CODE%>"]').prop('selected', true);

  $("input:checkbox[name='cp_ssl_yn']:checkbox[value='<%=CP_SSL_YN%>']").attr("checked",true);

  $("#editform").parsley();
</script>
