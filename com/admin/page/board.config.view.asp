<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->

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
    <div class='col-sm-12 col-md-12 col-lg-2'>

      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 게시판 목록</div>
        <ul class="list-group in">
<%
   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_READ_MT,BC_WRITE_MT

   SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_STATE < '90' ORDER BY BC_SEQ"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   With response
      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            BC_SEQ = Rs("BC_SEQ")
            BC_NAME = Rs("BC_NAME")

            .write "          <li class='list-group-item'><a href='javascript:boardview(" & BC_SEQ & ")'>" & BC_NAME & "</a></li>" & vbNewLine

            Rs.MoveNext
         Loop
      End If
      Rs.close
   End With

   Conn.Close
   Set Conn = nothing
%>
        </ul>
      </div>
    </div>
    <div class="col-sm-12 col-md-12 col-lg-10">
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 게시판 관리</div>
        <div class="panel-body no-padding">

        <div>
        <iframe name="viewfrm" id="viewfrm" src="page/board.asp?bc_seq=<%=Request("bc_seq")%>&method=<%=Request("method")%>&b_seq=<%=Request("b_seq")%>" scrolling="no" frameborder="0" style="width:100%; height:100%;" allowtransparency="false"></iframe>
        </div>

<div class="form">

<footer>
  <button class="btn btn-default" type="button" onclick="go_list();">돌아가기</button>
</footer>
</div>

        </div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  function viewfrmresize2(){
    $('#viewfrm').css("height", $('#viewfrm').contents().find("body").height() + "px");
  }

  function viewfrmresize(height){
    $('#viewfrm').css("height", height + "px");
  }

  function go_list(){
<% If Request("rtn") = "index" Then %>
    AjaxloadURL("page/index.asp", $('#main-content'));
<% Else %>
    AjaxloadURL("page/board.config.asp?<%=Request.ServerVariables("QUERY_STRING")%>", $('#main-content'));
<% End If %>
  }
</script>

