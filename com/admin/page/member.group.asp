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
      <a href="#">회원관리</a>
    </li>
    <li class="active">회원그룹관리</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">회원그룹관리</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">

      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 회원그룹</div>
        <div class="panel-body no-padding">

          <table id="datatable_col_reorder" class="display dataTable">
            <thead>
              <tr>
                <th>그룹레벨</th>
                <th>그룹명</th>
                <th>사용여부</th>
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
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">회원그룹 수정</h4>
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
      "sAjaxSource": "page/member.group.json.asp",
      "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs no-right-padding'l>r>t<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
      "aoColumns": [
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": false, "bSortable": false, "bVisible": true }
        ]
    });
  }

  function page_reload(){
    $('#myModal').modal('hide');
    setTimeout("loadURL('member/group')",500);
  }

  function level_edit(mem_level){
    AjaxloadURL('page/member.group.edit.asp?mem_level=' + mem_level, $('#modal-body'));
    $('#myModal').modal('show');
  }

</script>
