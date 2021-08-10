<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim CMS_SKIN_LST_Table
   CMS_SKIN_LST_Table = "CMS_SKIN_LST"

   Dim CS_CODE,CS_STATE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   folder_dir = Server.MapPath("/skin")

   Set objFile = Server.CreateObject("Scripting.FileSystemObject")
   Set objFolder = objFile.GetFolder(folder_dir)

   For Each folders in objFolder.subfolders
      CS_WDATE = NowDate
      CS_MDATE = NowDate
      CS_STATE = "00"

      CS_CODE = folders.name
      WHERE = "CS_CODE='" & CS_CODE & "'"

      SQL = "SELECT CS_CODE FROM " & CMS_SKIN_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF OR Rs.EOF Then
         SQL = "INSERT INTO " & CMS_SKIN_LST_Table _
             & " (CS_CODE,CS_WDATE,CS_MDATE,CS_STATE,ADM_SEQ)" _
             & " VALUES (N'" _
             & CS_CODE & "','" _
             & CS_WDATE & "','" _
             & CS_MDATE & "','" _
             & CS_STATE & "'," _
             & ADM_SEQ & ")"

         Conn.Execute SQL, ,adCmdText
      Else
         SQL = "UPDATE " & CMS_SKIN_LST_Table & " SET " _
             & "CS_STATE='" & CS_STATE & "' " _
             & "WHERE CS_STATE<>'01' AND CS_CODE='" & CS_CODE & "'"

         Conn.Execute SQL, ,adCmdText
      End If
      Rs.close
   Next
%>
<style type="text/css">
.skin {
  cursor: pointer;
  float: left;
  border: 1px solid #dedede;
  -webkit-box-shadow: 0 1px 1px -1px rgba(0,0,0,.1);
  box-shadow: 0 1px 1px -1px rgba(0,0,0,.1);
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  margin-bottom:25px;
}

.skin.active {
  border: 2px solid #d54e21;
}

.skin-screenshot img {
  height: auto;
  width: 100%;
  -webkit-transform: translateZ(0);
  -webkit-transition: opacity .2s ease-in-out;
  transition: opacity .2s ease-in-out;
}

.skin-screenshot:hover{
  -ms-filter: "alpha(Opacity=50)";
  opacity: 0.5;
}

.skin:hover .more-details {
  -ms-filter: "alpha(Opacity=100)";
  opacity: 1;
}

.skin .more-details {
  -ms-filter: "alpha(Opacity=0)";
  opacity: 0;
  position: absolute;
  top: 35%;
  right: 25%;
  left: 25%;
  background: #222;
  background: rgba(0,0,0,.7);
  color: #fff;
  font-size: 15px;
  text-shadow: 0 1px 0 rgba(0,0,0,.6);
  -webkit-font-smoothing: antialiased;
  font-weight: 600;
  padding: 15px 12px;
  text-align: center;
  border-radius: 3px;
  -webkit-transition: opacity .1s ease-in-out;
  transition: opacity .1s ease-in-out;
}

.skin .skin-name {
  font-size: 15px;
  font-weight: 600;
  margin: 0;
  padding: 15px;
  -webkit-box-shadow: inset 0 1px 0 rgba(0,0,0,.1);
  box-shadow: inset 0 1px 0 rgba(0,0,0,.1);
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  background: #fff;
  background: rgba(255,255,255,.65);
}

.skin.active .skin-name {
  background: #2f2f2f;
  color: #fff;
  font-weight: 300;
  -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.5);
  box-shadow: inset 0 1px 1px rgba(0,0,0,.5);
}
</style>

<link href="css/ekko-lightbox.min.css" rel="stylesheet">

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">디자인관리</a>
    </li>
    <li class="active">스킨</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">스킨</h2>
    </div>
  </div>

  <div class="row">
<%
   WHERE = "CS_STATE < '90'"
   ORDER_BY = "CS_STATE DESC, CS_CODE"
   SQL = "SELECT * FROM " & CMS_SKIN_LST_Table & " WHERE " & WHERE & " ORDER BY " & ORDER_BY
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   i = 0
   If Rs.BOF = false AND Rs.EOF = false Then
      With response
      Do until Rs.EOF
         CS_CODE = Rs("CS_CODE")
         CS_STATE = Rs("CS_STATE")

         .write "    <div class='col-sm-6 col-lg-3'>" & vbNewLine
         If CS_STATE = "01" Then
            .write "      <div class='skin active'>" & vbNewLine
         Else
            .write "      <div class='skin'>" & vbNewLine
         End If
         .write "        <div class='skin-screenshot'>" & vbNewLine
         .write "          <img alt='' src='/skin/" & CS_CODE & "/screenshot.png'>" & vbNewLine
         .write "        </div>" & vbNewLine
         .write "        <a href='/skin/" & CS_CODE & "/screenshot.png' data-toggle='lightbox' data-title='screenshot' data-gallery='multiimages'><span class='more-details'>스크린샷</span></a>" & vbNewLine
         .write "        <h3 class='skin-name' id='" & CS_CODE & "-name'>" & CS_CODE & vbNewLine
         .write "          <div class='pull-right'>" & vbNewLine

         If CS_STATE <> "01" Then
            .write "            <a class='btn btn-primary btn-xs' href=""javascript:changeskin('" & CS_CODE & "');"">활성화</a>" & vbNewLine
         End If

         .write "            <a class='btn btn-success btn-xs' href=""javascript:copyskin('" & CS_CODE & "');"">스킨복사</a>" & vbNewLine

         If CS_STATE <> "01" Then
            .write "            <a class='btn btn-warning btn-xs' href=""javascript:deleteskin('" & CS_CODE & "');"">삭제</a>" & vbNewLine
         End If

         .write "            <a class='btn btn-default btn-xs' href='skin.asp?skin=" & CS_CODE & "' target='_blank'>미리보기</a>" & vbNewLine
         .write "          </div>" & vbNewLine
         .write "        </h3>" & vbNewLine
         .write "      </div>" & vbNewLine
         .write "    </div>" & vbNewLine

         i = i + 1
         Rs.MoveNext
      Loop
      End With
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing
%>
  </div>
</div>

<form id="w_form" name="w_form" target="sframe" method="post">
<input type="hidden" id="form_action" name="action" value="skin.active">
<input type="hidden" id="form_msg" name="msg">
<input type="hidden" id="form_skin" name="cs_code">
</form>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">스킨복사</h4>
      </div>
      <div class="modal-body" id="modal-body" style="padding:1px;">
        <form id="editform" name="editform" target="sframe" method="post" class="form" data-parsley-validate>
        <input type="hidden" name="action" value="skin.copy">
        <input type="hidden" name="adm_seq" value="<%=ADM_SEQ%>">

        <fieldset>
          <div class="row">
            <label class="label col col-md-3">복사스킨</label>
            <section class="col col-md-9">
              <label class="input">
                <input type="text" name="old_code" id="old_code" data-parsley-maxlength="30" value="" readonly>
              </label>
            </section>
          </div>
          <div class="row">
            <label class="label col col-md-3">NEW스킨</label>
            <section class="col col-md-9">
              <label class="input">
                <input type="text" name="new_code" data-parsley-type="alphanum" data-parsley-maxlength="30" value="<%=NEW_CODE%>" required>
              </label>
            </section>
          </div>
        </fieldset>

        <footer>
          <button type="submit" class="btn btn-primary">
            <i class="fa fa-pencil fa-lg"></i> 스킨복사
          </button>
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </footer>
        </form>

        <script type="text/javascript">
          $("#editform").parsley();
        </script>

      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  loadDataTableScripts();
  function loadDataTableScripts() {
    loadScript("js/ekko-lightbox.js", runScripts);
  }

  function runScripts(){
    $(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
        event.preventDefault();
        return $(this).ekkoLightbox({
            onShown: function() {
                if (window.console) {
                    return console.log('Checking our the events huh?');
                }
            }
        });
    });
  }

  function page_reload(){
    $('#myModal').modal('hide');
    setTimeout("loadURL('skin.active')",500);
  }

  function copyskin(skin){
    $('#old_code').val(skin);
    $('#myModal').modal('show');
  }

  function changeskin(skin){
    var msg = "스킨을 활성화 하시겠습니까?"
    if(confirm(msg)){
      $('#form_skin').val(skin);
      $('#form_action').val("skin.active");
      $('#w_form').submit();
    }else{
      return;
    }
  }

  function deleteskin(skin){
    var msg = "스킨 삭제시 다시 복구 하실수 없습니다.\n\n스킨을 삭제 하시겠습니까?"
    if(confirm(msg)){
      $('#form_skin').val(skin);
      $('#form_action').val("skin.delete");
      $('#w_form').submit();
    }else{
      return;
    }
  }
</script>
