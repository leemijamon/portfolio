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
<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">디자인관리</a>
    </li>
    <li class="active">메뉴관리</li>
  </ul>
</div>

<link href="css/bootstrap-editable.css" rel="stylesheet">

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">메뉴관리</h2>
    </div>
  </div>

  <div class="row">
    <div class='col-lg-2 col-sm-6 col-xs-12'>
      <strong><label for="skin">편집할 스킨 선택</label></strong>
      <form id="f_skin" name="f_skin" action="#skin/menu" method="get" class="form">
      <label class="select">
        <select id="cs_code" name="cs_code" onchange="goskin();">
<%=SKIN_OPT%>
        </select><i></i>
      </label>
      </form>
    </div>

    <div id="nestable-menu" class='col-lg-10 col-sm-6 col-xs-12' style="padding-top:14px;">
      <button type="button" class="btn btn-default" data-action="expand-all">모두펼치기</button>
      <button type="button" class="btn btn-default" data-action="collapse-all">모두닫기</button>
      <button id="nestableupdate" type="button" class="btn btn-primary"><i class="fa fa-pencil fa-lg"></i> 저장</button>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-5 col-md-5 col-lg-5">

      <div class="panel panel-default">
        <div class="panel-heading">페이지 List</div>
        <div class="panel-body">

          <div class="dd" id="pagelist">
            <ol class="dd-list">
<%
   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CP_SEQ,CP_TYPE,CP_NAME,CP_TITLE,CP_PG_YN,CP_PG_NAME,CP_PG_QUERY
   Dim CP_USE_YN,CP_STATE

   WHERE = "CS_CODE = '" & CS_CODE & "' AND CP_USE_YN='1' AND CP_STATE < '90'"

   ORDER_BY = "CP_SORT"
   SQL = "SELECT * FROM " & CMS_PAGE_LST_Table & " WHERE " & WHERE & " ORDER BY " & ORDER_BY
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      With response
      Do until Rs.EOF
         CP_SEQ = Rs("CP_SEQ")
         CP_CODE = Rs("CP_CODE")
         CP_NAME = Rs("CP_NAME")
         CP_TITLE = Rs("CP_TITLE")

         .write "              <li class='dd-item dd3-item' data-id='p" & CP_SEQ & "'>" & vbNewLine
         .write "                <div class='dd-handle dd3-handle'>Drag</div>" & vbNewLine
         .write "                <div class='dd3-content'>" & vbNewLine
         .write "                  " & CP_NAME & vbNewLine
         .write "                  <button type='button' class='pull-right btn btn-primary btn-xs' onclick=""menu_add(" & CP_SEQ & ",'" & CP_NAME & "');return false;""><i class='fa fa-arrow-right'></i> Add</button>" & vbNewLine
         .write "                </div>" & vbNewLine
         .write "              </li>" & vbNewLine

         Rs.MoveNext
      Loop

      End With
   End If
   Rs.close
%>
            </ol>
          </div>
        </div>
      </div>

    </div>
    <div class="col-sm-7 col-md-7 col-lg-7">

      <div class="panel panel-default" id="memupanel">
        <div class="panel-heading">메뉴 List</div>
        <div class="panel-body">

          <div class="dd" id="memulist">
            <ol class="dd-list" id="memulistol">
<%
   Dim CMS_MENU_LST_Table
   CMS_MENU_LST_Table = "CMS_MENU_LST"

   Dim CM_SEQ,CM_NAME,CM_DEPTH,CM_SORT

   WHERE = "CS_CODE = '" & CS_CODE & "'"

   SQL = "SELECT * FROM " & CMS_MENU_LST_Table & " WHERE " & WHERE & " ORDER BY CM_CODE"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   OLD_DEPTH = 0

   i = 0
   lcnt = 0

   If Rs.BOF = false AND Rs.EOF = false Then
      With response
      Do until Rs.EOF
         CM_SEQ = Rs("CM_SEQ")
         CM_NAME = Rs("CM_NAME")
         CM_DEPTH = Rs("CM_DEPTH")
         CM_SORT = Rs("CM_SORT")
         CP_SEQ = Rs("CP_SEQ")
         CM_CODE = Rs("CM_CODE")

         CM_ID = "m" & CM_SEQ & "p" & CP_SEQ

         If i > 0 Then
            If OLD_DEPTH = 0 AND CM_DEPTH = 0 Then
               .write "                    </li>" & vbNewLine
            Else
               If OLD_DEPTH = 0 OR OLD_DEPTH < CM_DEPTH Then
                  .write "                    <ol class='dd-list'>" & vbNewLine
               Else
                  .write "                    </li>" & vbNewLine
               End If
            End If
         End If

         If OLD_DEPTH > CM_DEPTH Then
            If OLD_DEPTH = 2 AND CM_DEPTH = 0 Then
               .write "                    </ol>" & vbNewLine
               .write "                    </li>" & vbNewLine
            End If

            .write "                    </ol>" & vbNewLine
            .write "                    </li>" & vbNewLine
         End If

         .write Space(CM_DEPTH * 2) & "              <li class='dd-item dd3-item' id='" & CM_ID & "' data-id='" & CM_ID & "'>" & vbNewLine
         .write Space(CM_DEPTH * 2) & "                <div class='dd-handle dd3-handle'>Drag</div>" & vbNewLine
         .write Space(CM_DEPTH * 2) & "                <div class='dd3-content'>" & vbNewLine
         .write Space(CM_DEPTH * 2) & "                  <a href='#' class='mtitle' data-type='text' data-pk='" & CM_ID & "' data-name='menutitle' data-original-title='Enter title'>" & CM_NAME & "</a>" & vbNewLine
         .write Space(CM_DEPTH * 2) & "                  <button type='button' class='pull-right btn btn-warning btn-xs' onclick=""menu_del('" & CM_ID & "');"">Del</button>" & vbNewLine
         .write Space(CM_DEPTH * 2) & "                </div>" & vbNewLine

         If CM_DEPTH > 0 Then
            lcnt = lcnt + 1
         End If

         OLD_DEPTH = CM_DEPTH

         i = i + 1

         Rs.MoveNext
      Loop

      For i = 1 to OLD_DEPTH
         .write "              </ol>" & vbNewLine
      Next

      .write "              </li>" & vbNewLine

      End With
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing
%>
            </ol>
          </div>
        </div>
      </div>
    </div>

  </div>

  <form id="w_form" name="w_form" target="sframe" method="post">
  <input type="hidden" name="action" value="skin.menu">
  <input type="hidden" name="method" value="list">
  <input type="hidden" name="cs_code" value="<%=CS_CODE%>">
  <textarea id="pagelist-output" name="pagelist-output" style="display:none;"></textarea>
  <textarea id="memulist-output" name="memulist-output" style="display:none;"></textarea>
  <textarea id="memulist-new" name="memulist-new" style="display:none;"></textarea>
  <textarea id="memulist-del" name="memulist-del" style="display:none;"></textarea>
  </form>

  <!-- end row -->
</div>

<script type="text/javascript">
  loadDataTableScripts();
  function loadDataTableScripts() {
    loadScript("js/bootstrap-editable.js", dt_2);

    function dt_2() {
      loadScript("js/jquery.nestable.js", runNestable);
    }
  }

  var navigationFn = {
    goToSection: function(id) {
      $('html, body').animate({
        scrollTop: $(id).offset().top
      }, 0);
    }
  }

  function goskin(){
    AjaxloadURL('page/skin.menu.asp?cs_code=' + $('#cs_code').val(), $('#main-content'));
  }

  function runNestable(){
    //$("select[name='cs_code']").val("<%=CS_CODE%>");
    $('select[name=cs_code]').find('option[value="<%=CS_CODE%>"]').prop('selected', true);

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

    $('#pagelist').nestable({group:1,maxDepth:1}).on('change', updateOutput);;
    $('#memulist').nestable({group:2,maxDepth:3}).on('change', updateOutput);;

    updateOutput($('#pagelist').data('output', $('#pagelist-output')));
    updateOutput($('#memulist').data('output', $('#memulist-output')));

    $('#nestable-menu').on('click', function(e){
        var target = $(e.target),
            action = target.data('action');
        if (action === 'expand-all') {
            $('.dd').nestable('expandAll');
        }
        if (action === 'collapse-all') {
            $('.dd').nestable('collapseAll');
        }
    });

    $('#nestableupdate').click(function() {
      updateOutput($('#pagelist').data('output', $('#pagelist-output')));
      updateOutput($('#memulist').data('output', $('#memulist-output')));

      $("#w_form").submit();
    });

    $.fn.editable.defaults.mode = 'inline';

    $('.mtitle').editable({
      url: '?action=skin.menu&method=title&cs_code=<%=CS_CODE%>'
    });
  }

  function menu_del(menuid){
    $("#" + menuid).remove();

     var delval = $('#memulist-del').val();
     if(delval!="") delval = delval + ",";
     $('#memulist-del').val(delval + menuid);
  }

  var cnt = 0;

  function menu_add(cp_seq,cp_name){
    var addhtml = "";
    addhtml = addhtml + "<li class='dd-item dd3-item' id='p" + cp_seq + "_" + cnt + "' data-id='p" + cp_seq + "_" + cnt + "'>";
    addhtml = addhtml + "  <div class='dd-handle dd3-handle'>Drag</div>";
    addhtml = addhtml + "  <div class='dd3-content'>";
    addhtml = addhtml + "    <a href='#' id='" + cp_seq + "_" + cnt + "' class='ptitle editable editable-click' data-type='text' data-pk='p" + cp_seq + "_" + cnt + "' data-name='menutitle' data-original-title='Enter title'>" + cp_name + "</a>";
    addhtml = addhtml + "    <button type='button' class='pull-right btn btn-warning btn-xs' onclick=menu_del('p" + cp_seq + "_" + cnt + "');>Del</button>";
    addhtml = addhtml + "  </div>";
    addhtml = addhtml + "</li>";

    $("#memulistol").append(addhtml);
    //navigationFn.goToSection('#memupanel');
    //navigationFn.goToSection('#p' + cp_seq + '_' + cnt);

    $('.ptitle').editable({
      success: function(response, newValue) {
        var newval = $('#memulist-new').val();
        $('#memulist-new').val(newval + $(this).attr("id") + "," + newValue + ",");
      }
    });

    cnt ++;
  }

</script>

