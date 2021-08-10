<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">설정</a>
    </li>
    <li class="active">코드관리</li>
  </ul>
</div>

<link href="css/bootstrap-editable.css" rel="stylesheet">

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">코드관리</h2>
    </div>
  </div>

  <div class="row">
    <div class='col-sm-6 col-lg-2'>
      <strong><label for="skin">편집할 코드 선택</label></strong>
      <form id="f_skin" name="f_skin" method="get" class="form">
      <label class="select">
        <select id="cc_type" name="cc_type" onchange="gocode();">
<%=f_arr_opt(CC_TYPE_CD, CC_TYPE_NAME)%>
        </select><i></i>
      </label>
      </form>
    </div>
  </div>
  <br>

<%
   Dim CMS_CODE_LST_Table
   CMS_CODE_LST_Table = "CMS_CODE_LST"

   Dim CC_TYPE,CC_CODE,CC_NAME,CC_DISP,CC_SORT

   CC_TYPE = Trim(Request("cc_type"))

   If CC_TYPE <> "" Then
   With response
      .write "  <div class='row'>" & vbNewLine
      .write "    <div class='col-sm-12 col-md-12 col-lg-5'>" & vbNewLine

      .write "      <div class='panel panel-default'>" & vbNewLine
      .write "        <div class='panel-heading'>" & vbNewLine
      .write "          코드 List" & vbNewLine
      .write "          <div class='pull-right'>" & vbNewLine
      .write "            <button id='codenew' type='button' class='btn btn-primary btn-xs'><i class='fa fa-pencil fa-lg'></i> 추가</button>" & vbNewLine
      .write "          </div>" & vbNewLine
      .write "        </div>" & vbNewLine

      .write "        <div class='panel-body'>" & vbNewLine
      .write "          <div class='dd' id='codelist'>" & vbNewLine
      .write "            <ol class='dd-list'>" & vbNewLine

      Dim Conn, Rs
      Set Conn = Server.CreateObject("ADODB.Connection")
      Conn.Open Application("connect")

      SQL = "SELECT * FROM " & CMS_CODE_LST_Table & " WHERE CC_TYPE='" & CC_TYPE & "' AND CC_STATE < '90' ORDER BY CC_SORT"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      i = 0
      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            i = i + 1
            CC_SEQ = Rs("CC_SEQ")
            CC_TYPE = Rs("CC_TYPE")
            CC_CODE = Rs("CC_CODE")
            CC_NAME = Rs("CC_NAME")
            CC_DISP = Rs("CC_DISP")
            CC_SORT = Rs("CC_SORT")

            If CC_DISP = "1" Then
               CC_DISP = "YES"
            Else
               CC_DISP = "NO"
            End If

            'BTN_EDIT = "<a href='code_info.asp?cc_type=" & CC_TYPE & "&cc_seq=" & CC_SEQ & "' class='lytebox' data-lyte-options='width:500 height:300 scrollbars:no'><img src='../img/btn/edit.gif' border='0' align='absmiddle'></a> "

            .write "              <li class='dd-item dd3-item' data-id='c" & CC_SEQ & "'>" & vbNewLine
            .write "                <div class='dd-handle dd3-handle'>Drag</div>" & vbNewLine
            .write "                <div class='dd3-content'>" & vbNewLine
            .write "                  " & CC_CODE & " : " & CC_NAME & vbNewLine
            .write "                  <div class='pull-right'>" & vbNewLine
            .write "                    <button type='button' class='btn btn-primary btn-xs' onclick=""code_edit(" & CC_SEQ & ");"">Edit</button>" & vbNewLine
            .write "                    <button type='button' class='btn btn-warning btn-xs' onclick=""code_del(" & CC_SEQ & ");"">Del</button>" & vbNewLine
            .write "                  </div>" & vbNewLine
            .write "                </div>" & vbNewLine
            .write "              </li>" & vbNewLine

            Rs.MoveNext
         Loop
      End If
      Rs.close

      Conn.Close
      Set Conn = nothing

      .write "            </ol>" & vbNewLine
      .write "          </div>" & vbNewLine
      .write "        </div>" & vbNewLine
      .write "      </div>" & vbNewLine
      .write "    </div>" & vbNewLine
      .write "  </div>" & vbNewLine
   End With

   End If
%>

  <form id="w_form" name="w_form" target="sframe" method="post">
  <input type="hidden" name="action" value="conf.code">
  <input type="hidden" name="method" value="sort">
  <input type="hidden" name="cc_type" value="<%=CC_TYPE%>">
  <textarea id="codelist-output" name="codelist-output" style="display:none;"></textarea>
  </form>

  <!-- end row -->
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">코드 입력/수정</h4>
      </div>
      <div class="modal-body" id="modal-body" style="padding:1px;">

      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
  loadDataTableScripts();
  function loadDataTableScripts() {
    loadScript("js/jquery.nestable.js", runNestable);
  }

  function gocode(){
    AjaxloadURL('page/conf.code.asp?cc_type=' + $('#cc_type').val(), $('#main-content'));
  }

  function runNestable(){
    //$("select[name='cc_type']").val("<%=CC_TYPE%>");
    $('select[name=cc_type]').find('option[value="<%=CC_TYPE%>"]').prop('selected', true);

<% If CC_TYPE <> "" Then %>
    var updateOutput = function(e)
    {
        var list = e.length ? e : $(e.target),
            output = list.data('output');
        if (window.JSON) {
            output.val(window.JSON.stringify(list.nestable('serialize')));//, null, 2));
        } else {
            output.val('JSON browser support required for this demo.');
        }
    };

    $('#codelist').nestable({group:1,maxDepth:1}).on('change', function() {
      updateOutput($('#codelist').data('output', $('#codelist-output')));

      $("#w_form").submit();
    });

    $('#codenew').click(function() {
      AjaxloadURL('page/conf.code.edit.asp?cc_type=<%=CC_TYPE%>', $('#modal-body'));
      $('#myModal').modal('show');
    });
<% End If %>
  }

  function page_reload(){
    $('#myModal').modal('hide');
    setTimeout("gocode()",500);
  }

  function code_edit(cc_seq){
    AjaxloadURL('page/conf.code.edit.asp?cc_type=<%=CC_TYPE%>&cc_seq=' + cc_seq, $('#modal-body'));
    $('#myModal').modal('show');
  }

  function code_del(cc_seq){
    var msg = "삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = "?action=conf.code&method=delete&cc_type=<%=CC_TYPE%>&cc_seq=" + cc_seq;
    }else{
      return;
    }
  }
</script>

