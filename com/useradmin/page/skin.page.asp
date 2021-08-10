<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim CMS_SKIN_LST_Table
   CMS_SKIN_LST_Table = "CMS_SKIN_LST"

   Dim CS_CODE,CS_STATE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   WHERE = "CS_STATE < '90'"
   ORDER_BY = "CS_STATE DESC, CS_CODE"
   SQL = "SELECT * FROM " & CMS_SKIN_LST_Table & " WHERE " & WHERE & " ORDER BY " & ORDER_BY
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         CS_CODE = Rs("CS_CODE")
         CS_STATE = Rs("CS_STATE")

         If CS_STATE = "01" Then ACTIVE_CODE = CS_CODE

         SKIN_OPT = SKIN_OPT & "<option value='" & CS_CODE & "'>" & CS_CODE & "</option>"

         Rs.MoveNext
      Loop
   End If
   Rs.close

   If request("cs_code") <> "" Then
      CS_CODE = request("cs_code")
   Else
      CS_CODE = ACTIVE_CODE
   End If
%>
<link href="css/jquery.dataTables.css" rel="stylesheet">
<link href="css/dataTables.bootstrap.css" rel="stylesheet">

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">디자인관리</a>
    </li>
    <li class="active">페이지관리</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">페이지관리</h2>
    </div>
  </div>

  <div class="row">
    <div class='col-lg-2 col-sm-6 col-xs-12'>
    <strong><label for="skin">편집할 스킨 선택</label></strong>
    <form id="f_skin" name="f_skin" action="#skin/editor" method="get" class="form">
      <label class="select">
        <select id="cs_code" name="cs_code" onchange="goskin();">
<%=SKIN_OPT%>
        </select><i></i>
      </label>
      </form>
      <br>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">
      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="page_edit('');">신규등록</button>
      </div>

      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 페이지관리</div>
        <div class="panel-body no-padding">

          <table id="datatable_col_reorder" class="display dataTable">
            <thead>
              <tr>
                <th>순번</th>
                <th>페이지명</th>
                <th>페이지주소</th>
                <th>페이지코드</th>
                <th>사용여부</th>
                <th>관리</th>
              </tr>
            </thead>
          </table>

        </div>
      </div>
    </div>
  </div>

  <iframe name="ifrm" id="ifrm" src="blank.html" scrolling="no" frameborder="0" style="width:100%; height:100%;" allowtransparency="false"></iframe>

</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">페이지정보 입력/수정</h4>
      </div>
      <div class="modal-body" id="modal-body" style="padding:1px;">

      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
  loadDataTableScripts();
  function loadDataTableScripts() {
    loadScript("js/jquery.dataTables.js", dt_2);

    function dt_2() {
      loadScript("js/dataTables.bootstrap.js", runDataTables);
    }
  }

  function runDataTables(){
    //$("select[name='cs_code']").val("<%=CS_CODE%>");
    $('select[name=cs_code]').find('option[value="<%=CS_CODE%>"]').prop('selected', true);

    var table = $('#datatable_col_reorder').dataTable({
      "bProcessing": true,
      "bServerSide": true,
      "sAjaxSource": "page/skin.page.json.asp?cs_code=<%=CS_CODE%>",
      "iDisplayLength": 25,
      "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs no-right-padding'l>r>t<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
      "aoColumns": [
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true, "sClass": "hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true }
        ]
    });
  }

  $('#ifrm').load(function() {
    resize();
  });

  function goskin(){
    AjaxloadURL('page/skin.page.asp?cs_code=' + $('#cs_code').val(), $('#main-content'));
  }

  function reloadskin(){
    $('#myModal').modal('hide');
    setTimeout("goskin()",500);
  }

  function page_cont(cp_mode,cp_code){
    $("#ifrm").attr("src","page/skin.page.cont.asp?cp_mode=" + cp_mode + "&cs_code=" + $('#cs_code').val() + "&cp_code=" + cp_code);
    setTimeout("navigationFn.goToSection('#ifrm')",500);
  }

  function page_edit(cp_seq){
    AjaxloadURL('page/skin.page.edit.asp?cs_code=' + $('#cs_code').val() + '&cp_seq=' + cp_seq, $('#modal-body'));
    $('#myModal').modal('show');
  }

  function page_del(cp_seq){
    var msg = "페이지를 삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = "?action=skin.page&method=delete&cs_code=" + $('#cs_code').val() + "&cp_seq=" + cp_seq;
    }else{
      return;
    }
  }

  function resize(){
    $('#ifrm').css("height", $('#ifrm').contents().find("body").height() + "px");
  }

  function page_reload(){
    document.location.reload();
  }
</script>
