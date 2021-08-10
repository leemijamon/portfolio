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

      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="bc_reg();">신규등록</button>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 게시판 목록</div>
        <div class="panel-body no-padding">

          <table id="datatable_col_reorder" class="display dataTable">
            <thead>
              <tr>
                <th>관리번호</th>
                <th>형태</th>
                <th>게시판명</th>
                <th>스킨</th>
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
      "sAjaxSource": "page/board.config.json.asp",
      "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs no-right-padding'l>r>t<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
      "aoColumns": [
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true }
        ]
    });

    var table = $('#datatable_col_reorder').DataTable();
<% If request("search") <> "" Then %>
    $("#datatable_col_reorder_filter input").val("<%=request("search")%>");
    table.search("<%=request("search")%>").draw();
<% End If %>
<% If request("page") <> "" Then %>
    table.page(<%=request("page")%>).draw();
<% End If %>
<% If request("len") <> "" Then %>
    table.page.len(<%=request("len")%>).draw();
<% End If %>
<% If request("sort_rul") <> "" Then %>
    table.order( [<%=request("sort_key")%>, '<%=request("sort_rul")%>'] ).draw();
<% End If %>
  }

  function page_reload(){
    setTimeout("loadURL('board/config')",500);
  }

  function bc_reg(){
    AjaxloadURL('page/board.config.edit.asp', $('#main-content'));
  }

  function bc_edit(bc_seq){
    var table = $('#datatable_col_reorder').DataTable();
    var info = table.page.info();
    var plen = table.page.len()
    var psearch = table.search();
    var order = table.order();

    AjaxloadURL("page/board.config.edit.asp?search=" + encodeURI(psearch) + "&sort_key=" + order[0][0] + "&sort_rul=" + order[0][1] + "&page=" + parseInt(info.page+1) + "&len=" + plen+ "&bc_seq=" + bc_seq, $('#main-content'));
  }

  function bc_view(bc_seq){
    var table = $('#datatable_col_reorder').DataTable();
    var info = table.page.info();
    var plen = table.page.len()
    var psearch = table.search();
    var order = table.order();

    AjaxloadURL("page/board.config.view.asp?search=" + encodeURI(psearch) + "&sort_key=" + order[0][0] + "&sort_rul=" + order[0][1] + "&page=" + parseInt(info.page+1) + "&len=" + plen+ "&bc_seq=" + bc_seq, $('#main-content'));
  }

  function bc_del(bc_seq){
    var msg = "삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = "?action=board.config&method=delete&bc_seq=" + bc_seq;
    }else{
      return;
    }
  }

</script>
