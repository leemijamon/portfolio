<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"
%>

<table id="ip_page_data" class="display dataTable">
  <thead>
    <tr>
      <th>기록시간</th>
      <th>URL</th>
      <th>페이지뷰</th>
    </tr>
  </thead>
</table>

<script type="text/javascript">
  $('#ip_page_data').dataTable({
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": "page/state.ip.page.json.asp?lv_seq=<%=request("lv_seq")%>",
    "iDisplayLength": 10,
    "aLengthMenu": [[10, 20, 30, 50], [10, 20, 30, 50]],
    "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs no-right-padding'l>r>t<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
    "aoColumns": [
      { "bSearchable": false, "bSortable": true, "bVisible": true },
      { "bSearchable": true, "bSortable": true, "bVisible": true },
      { "bSearchable": false, "bSortable": true, "bVisible": true }
      ]
  });
</script>
