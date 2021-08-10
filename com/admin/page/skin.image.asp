<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->

<link href="css/dropzone.css" rel="stylesheet">
<link href="css/superbox.css" rel="stylesheet">

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">디자인관리</a>
    </li>
    <li class="active">이미지관리</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">이미지관리</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 이미지 업로드</div>
        <div class="panel-body no-padding">
          <form class="dropzone" id="mydropzone"></form>
        </div>
      </div>

      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 이미지 관리</div>
        <div class="panel-body no-padding">

<%
   Dim CMS_IMAGE_LST_Table
   CMS_IMAGE_LST_Table = "CMS_IMAGE_LST"

   Dim CI_SEQ,CI_TYPE,CI_CODE,CI_NAME,CI_FILE,CI_WIDTH,CI_HEIGHT,CI_WDATE,CI_MDATE
   Dim CI_STATE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim page : page = request("page")
   If page = "" then page = 1
   page = int(page)

   If Request("sort_key") = "" Then
      Sort_Key = "CI_SEQ"
   Else
      Sort_Key = Request("sort_key")
   End If

   If Request("sort_rul") = "" Then
      Sort_Rul = "DESC"
   Else
      Sort_Rul = Request("sort_rul")
   End If

   WHERE = "CI_STATE<'90'"

   search_key = trim(request("search_key"))
   search_word = trim(replace(request("search_word"), chr(34), "&#34;"))

   If search_key <> "" AND search_word <> "" Then WHERE = WHERE & " AND " & search_key & " LIKE '%" & search_word & "%'"

   SQL = "SELECT COUNT(*) FROM " & CMS_IMAGE_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   recordCount = Rs(0)
   Rs.close

   Dim pageSize : pageSize = 40
   Dim recordCount, recentCount

   Dim n_from,n_to,s_desc,s_asc,n_range,n_limit
   Dim pageCount : pageCount=int((recordCount-1)/pageSize)+1

   If page > pageCount Then page = pageCount
   If page = 0 Then page = 1

   Select_Key = "CI_SEQ"

   If Sort_Key = Select_Key Then
      ORDER_BY = Select_Key & " " & Sort_Rul
   Else
      ORDER_BY = Sort_Key & " " & Sort_Rul & ", " & Select_Key & " ASC"
   End If

   S_ROWNUM = (page-1) * pageSize + 1
   E_ROWNUM = page * pageSize

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & CMS_IMAGE_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   With response
      .write "  <div class='superbox'>" & vbNewLine
      i = 0
      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            CI_SEQ = Rs("CI_SEQ")
            CI_CODE = Rs("CI_CODE")
            CI_NAME = Rs("CI_NAME")
            CI_FILE = Rs("CI_FILE")
            CI_DESCRIPTION = Rs("CI_DESCRIPTION")
            CI_WIDTH = Rs("CI_WIDTH")
            CI_HEIGHT = Rs("CI_HEIGHT")
            CI_WDATE = Rs("CI_WDATE")
            CI_MDATE = Rs("CI_MDATE")

            If i > 0 Then
               .write "<!--" & vbNewLine & "    -->"
            Else
               .write "    "
            End If

            .write "<div class='superbox-list'>" & vbNewLine
            .write "      <img src=""/file/img/" & CI_FILE & "?w=195&h=195&mode=crop"" data-seq=""" & CI_SEQ & """ data-img=""/file/img/" & CI_FILE & """ alt=""" & CI_DESCRIPTION & """ title=""" & CI_NAME & """ class=""superbox-img"">" & vbNewLine
            .write "    </div>"

            i = i + 1

            Rs.MoveNext
         Loop
      End If
      Rs.close

      .write vbNewLine
      .write "    <div class='superbox-float'></div>" & vbNewLine
      .write "  </div>" & vbNewLine
   End With

   Conn.Close
   Set Conn = nothing

   If pagecount > 1 Then
   With response
      .write "<br style='line-height:10px'>" & vbNewLine
      .write "<table width='100%' border='0' cellspacing='0' cellpadding='0'>" & vbNewLine
      .write "  <tr>" & vbNewLine
      .write "    <td align='center'>" & vbNewLine

      goto_directly page, pagecount, 10

      .write "    </td>" & vbNewLine
      .write "  </tr>" & vbNewLine
      .write "</table>" & vbNewLine & vbNewLine

      .write "<form name='result' method='get'>" & vbNewLine
      .write "  <input type='hidden' name='search_key' value='" & search_key & "'>" & vbNewLine
      .write "  <input type='hidden' name='search_word' value='" & search_word & "'>" & vbNewLine
      .write "  <input type='hidden' name='sort_key' value='" & Sort_Key & "'>" & vbNewLine
      .write "  <input type='hidden' name='sort_rul' value='" & Sort_Rul & "'>" & vbNewLine
      .write "  <input type='hidden' name='page'>" & vbNewLine
      .write "  <input type='hidden' name=''>" & vbNewLine
      .write "</form>" & vbNewLine & vbNewLine

   End With
   End If
%>
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
        <h4 class="modal-title">이미지정보</h4>
      </div>
      <div class="modal-body" id="modal-body" style="padding:1px;">

      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
  var pagefunction = function() {
    $('.superbox').SuperBox();

    Dropzone.autoDiscover = false;

    Dropzone.options.mydropzone = {
      url: "exec/skin.imageupload.asp",
      paramName: "file", // The name that will be used to transfer the file
      maxFilesize: 2, // MB
      addRemoveLinks : true,
      dictResponseError: 'Error uploading file!'
    };

    var myDropzone = new Dropzone("#mydropzone");

    myDropzone.on("complete", function(file) {
      page_reload();
    });
  };

  loadScript("js/superbox.js", function(){
    loadScript("js/dropzone.js", pagefunction);
  });

  function goto(page){
    document.result.page.value = page;
    AjaxloadURL('page/skin.image.asp?page=' + page, $('#main-content'));
  }

  function page_reload(){
    $('#myModal').modal('hide');
    setTimeout("AjaxloadURL('page/skin.image.asp?page=<%=page%>', $('#main-content'))",500);
  }

  function img_edit(ci_seq){
    AjaxloadURL('page/skin.image.edit.asp?ci_seq=' + ci_seq, $('#modal-body'));
    $('#myModal').modal('show');
  }

  function img_del(ci_seq){
    var msg = "이미지를 삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = "?action=skin.image&method=delete&ci_seq=" + ci_seq;
    }else{
      return;
    }
  }
</script>

<%
  Sub goto_directly(page, Pagecount, blodkcount)
    Dim BlodkEnd
    Dim endNum : endNum = page mod blodkcount

    '현재 자신의 페이지 블럭에서 마지막 페이지 구하기.
    If (page Mod blodkcount) = 0 Then
       BlodkEnd = page
    Else
       BlodkEnd = (Int(page) + blodkcount) - Int(endNum)   '13 + 10 - 3  / 23 + 10 -3
    End If

    If Pagecount <> 0 Then
       Response.Write "<ul class='pagination'>" & vbNewLine

       '이전 10개 기능 적용
       If Int(BlodkEnd) > blodkcount Then
          Response.Write "<li><a href=""javascript:goto(" & BlodkEnd - (blodkcount * 2) + 1 & ");"">&laquo;</a></li>" & vbNewLine
       Else
          Response.Write "<li><a href='javascript:void(0);'>&laquo;</a></li>" & vbNewLine
       End If

       Dim i, endNumOfLoop
       If Int(pagecount) > Int(BlodkEnd) Then
          endNumOfLoop = BlodkEnd
       else
          endNumOfLoop = Int(pagecount)
       end if

       For i = BlodkEnd - blodkcount + 1 To endNumOfLoop
          if i = int(page) then
             Response.Write "<li><a href='javascript:void(0);'>" & i & "</a></li>" & vbNewLine
          else
             Response.Write "<li><a href=""javascript:goto(" & i & ");"">" & i & "</a></li>" & vbNewLine
          end if
       Next

       '다음 10개 기능 적용
       If Int(pagecount) > Int(BlodkEnd) Then
          Response.Write "<li><a href=""javascript:goto(" & BlodkEnd + 1 & ");"">&raquo;</a></li>" & vbNewLine
       Else
          Response.Write "<li><a href='javascript:void(0);'>&raquo;</a></li>" & vbNewLine
       End If

       Response.Write "</ul>" & vbNewLine
    End If
  End Sub
%>
