<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->

<link href="css/jquery.dataTables.css" rel="stylesheet">
<link href="css/dataTables.bootstrap.css" rel="stylesheet">
<link href="css/dataTables.tableTools.css" rel="stylesheet">

<style type="text/css">
  table.dataTable tr td:first-child {
        text-align: center;
    }

    table.dataTable tr td:first-child:before {
        content: "\f096"; /* fa-square-o */
        font-family: FontAwesome;
        font-size:1.3em;
    }

    table.dataTable tr.selected td:first-child:before {
        content: "\f046"; /* fa-check-square-o */
    }
</style>


<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">회원관리</a>
    </li>
    <li class="active">회원리스트</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">회원리스트</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">

      <div class="pull-right" style="padding:9px;">
        <button type="button" class="btn btn-primary btn-xs" onclick="mem_edit('');">신규등록</button>
        <!--button type="button" class="btn btn-primary btn-xs" onclick="alert('준비중');">상세검색</button-->
      </div>
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 회원목록</div>
        <div class="panel-body no-padding">

          <table id="datatable_col_reorder" class="display dataTable DTTT_selectable">
            <thead>
              <tr>
                <th></th>
                <th>번호</th>
                <th>이름</th>
                <th>아이디</th>
                <th>휴대전화</th>
                <th>그룹</th>
                <th>가입일</th>
                <th>최근접속일</th>
                <th>메일링</th>
                <th>승인</th>
                <th>관리</th>
              </tr>
            </thead>
          </table>

        </div>
      </div>

    </div>
  </div>
</div>

<form name="result" method="get">
  <input type="hidden" name="search">
  <input type="hidden" name="sort_key">
  <input type="hidden" name="sort_rul">
  <input type="hidden" name="page">
  <input type="hidden" name="mem_seq">
</form>

<script type="text/javascript">
  loadDataTableScripts();
  function loadDataTableScripts() {
    loadScript("js/jquery.dataTables.js", dt_2);

    function dt_2() {
      loadScript("js/dataTables.bootstrap.js", dt_3);
    }

    function dt_3() {
      loadScript("js/dataTables.tableTools.min.js", runDataTables);
    }
  }

  function runDataTables(){
$.fn.dataTable.TableTools.buttons.newmember = $.extend(
    true,
    $.fn.dataTable.TableTools.buttonBase,
    {
        "sNewLine": "<br>",
        "sButtonText": "Copy to element",
        "fnClick": function( nButton, oConfig ) {
            //document.getElementById(oConfig.sDiv).innerHTML =
                //this.fnGetTableData(oConfig);
                alert("1");
        }
    }
);

$.fn.dataTable.TableTools.buttons.search = $.extend(
    true,
    $.fn.dataTable.TableTools.buttonBase,
    {
        "sNewLine": "<br>",
        "sButtonText": "Copy to element",
        "fnClick": function( nButton, oConfig ) {
            //document.getElementById(oConfig.sDiv).innerHTML =
                //this.fnGetTableData(oConfig);
                alert("1");
        }
    }
);

    var table = $('#datatable_col_reorder').dataTable({
      "page": 1,
      "length": 25,
      "bProcessing": true,
      "bServerSide": true,
      "sAjaxSource": "page/member.list.json.asp",
      "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs no-right-padding'l>r>t<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
      "aaSorting" : [[1, 'desc']],
      "aoColumns": [
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true, "sClass": "hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": false, "bSortable": false, "bVisible": true }
      ],
      "oTableTools": {
        "sRowSelect": "multi",
        "aButtons": [
          "select_all",
          "select_none",
          {
                "sExtends":    "search",
                "sButtonText": "Search"
          },
          "copy",
          "csv",
          {
            "sExtends": "pdf",
            "sTitle": "PDF",
            "sPdfMessage": "SmartAdmin PDF Export",
            "sPdfSize": "letter"
          },
          {
                "sExtends":    "newmember",
                "sButtonText": "New"
          }
        ],
        "sSwfPath": "images/copy_csv_xls_pdf.swf"
      }
    });


    $('#datatable_col_reorder tbody').on( 'click', 'tr', function () {
      $(this).toggleClass('selected');
    });

    $('#button').click( function () {
        alert( table.rows('.selected').data().length +' row(s) selected' );
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
    setTimeout("loadURL('member/list')",500);
  }

  function mem_edit(mem_seq){
    var table = $('#datatable_col_reorder').DataTable();
    var info = table.page.info();
    var plen = table.page.len()
    var psearch = table.search();
    var order = table.order();

    //var form = document.result;
    //form.search.value = psearch;
    //form.sort_key.value = order[0][0];
    //form.sort_rul.value = order[0][1];
    //form.page.value = info.page+1;

    AjaxloadURL("page/member.edit.asp?search=" + encodeURI(psearch) + "&sort_key=" + order[0][0] + "&sort_rul=" + order[0][1] + "&page=" + parseInt(info.page+1) + "&len=" + plen+ "&mem_seq=" + mem_seq, $('#main-content'));
  }

</script>
