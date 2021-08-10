<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->

<style type="text/css">
  .panel-body-toolbar {
    display: block;
    padding: 8px 10px;
    min-height: 44px;
    border-bottom: 1px solid #ccc;
    background: #fafafa;
  }
</style>

<link href="css/jquery.dataTables.css" rel="stylesheet">
<link href="css/dataTables.bootstrap.css" rel="stylesheet">

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">설정</a>
    </li>
    <li class="active">관리자 설정</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">관리자 설정</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">

      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="adm_reg();">신규등록</button>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 관리자 목록</div>
        <div class="panel-body no-padding">

          <table id="datatable_col_reorder" class="display dataTable">
            <thead>
              <tr>
                <th>아이디</th>
                <th>유형</th>
                <th>이름</th>
                <th>휴대전화</th>
                <th>최근접속</th>
                <th>등록일</th>
                <th>관리</th>
              </tr>
            </thead>
          </table>

        </div>
      </div>
    </div>
  </div>

</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">관리자정보 입력/수정</h4>
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
    var table = $('#datatable_col_reorder').dataTable({
      "bProcessing": true,
      "bServerSide": true,
      "sAjaxSource": "page/conf.admin.json.asp",
      "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs no-right-padding'l>r>t<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
      "aoColumns": [
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true, "sClass": "hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true }
        ]
    });
  }

  function page_reload(){
    $('#myModal').modal('hide');
    setTimeout("loadURL('conf/admin')",500);
  }

  function adm_reg(){
    AjaxloadURL('page/conf.admin.edit.asp', $('#modal-body'));
    $('#myModal').modal('show');
  }

  function adm_edit(adm_seq){
    AjaxloadURL('page/conf.admin.edit.asp?adm_seq=' + adm_seq, $('#modal-body'));
    $('#myModal').modal('show');
  }

  function adm_del(adm_seq){
    if(adm_seq=="0"){
      alert("최고관리자는 삭제할 수 없습니다.");
      return;
    }

    var msg = "삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = "?action=conf/admin&method=delete&adm_seq=" + adm_seq;
    }else{
      return;
    }
  }

</script>
