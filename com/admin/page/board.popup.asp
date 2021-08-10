<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->

<link href="css/jquery.dataTables.css" rel="stylesheet">
<link href="css/dataTables.bootstrap.css" rel="stylesheet">

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li class="active">컨텐츠관리</li>
    <li class="active">팝업창 관리</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">팝업창 관리</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">

      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="p_reg();">신규등록</button>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 팝업창 목록</div>
        <div class="panel-body no-padding">

          <table id="datatable_col_reorder" class="display dataTable">
            <thead>
              <tr>
                <th>관리번호</th>
                <th>노출</th>
                <th>창타입</th>
                <th>제목</th>
                <th>위치</th>
                <th>크기</th>
                <th>게시일</th>
                <th>등록일</th>
                <th>조회수</th>
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
      "sAjaxSource": "page/board.popup.json.asp",
      "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs no-right-padding'l>r>t<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
      "aaSorting" : [[0, 'desc']],
      "aoColumns": [
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-xs" },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
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
    setTimeout("loadURL('board/popup')",500);
  }

  function p_reg(){
    AjaxloadURL('page/board.popup.edit.asp', $('#main-content'));
  }

  function p_view(p_seq,p_whdth,p_height){
    win_open('pop' + p_seq,'/exec/popup/popup.asp?p_seq=' + p_seq,p_whdth,p_height,'no');
  }

  function p_edit(p_seq){
    var table = $('#datatable_col_reorder').DataTable();
    var info = table.page.info();
    var plen = table.page.len()
    var psearch = table.search();
    var order = table.order();

    AjaxloadURL("page/board.popup.edit.asp?search=" + encodeURI(psearch) + "&sort_key=" + order[0][0] + "&sort_rul=" + order[0][1] + "&page=" + parseInt(info.page+1) + "&len=" + plen+ "&p_seq=" + p_seq, $('#main-content'));
  }

  function p_del(p_seq){
    var msg = "삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = "?action=board.popup&method=delete&p_seq=" + p_seq;
    }else{
      return;
    }
  }
</script>
