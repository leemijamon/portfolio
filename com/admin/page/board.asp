<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   BC_SEQ = Trim(Request("bc_seq"))

   Dim MEM_SEQ,MEM_NAME,MEM_REGNO,MEM_ID,MEM_REGNO_CK,MEM_SEX,MEM_HP,MEM_EMAIL

   SQL = "SELECT C.BC_TYPE, C.BC_NAME, M.MEM_SEQ, M.MEM_NAME, M.MEM_ID, M.MEM_LEVEL, M.MEM_HP, M.MEM_EMAIL, M.ARA_CODE " _
       & "FROM BOARD_CONFIG_LST AS C INNER JOIN MEM_LST AS M ON C.MEM_SEQ = M.MEM_SEQ " _
       & "WHERE M.MEM_STATE < '90' AND C.BC_SEQ = " & BC_SEQ

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      BC_TYPE = Rs("BC_TYPE")
      BC_NAME = Rs("BC_NAME")
      MEM_SEQ = Rs("MEM_SEQ")

      Session("MEM_SEQ") = Rs("MEM_SEQ")
      Session("MEM_LEVEL") = "00"
      Session("MEM_NAME") = Rs("MEM_NAME")
      Session("MEM_ID") = Rs("MEM_ID")
      Session("MEM_HP") = Rs("MEM_HP")
      Session("MEM_EMAIL") = Rs("MEM_EMAIL")
      Session("MEM_IP") = Request.ServerVariables("Remote_Addr")
   End If
   Rs.close
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>[ <%=CS_NAME%> Admin Version 2.0]</title>

<link href="/exec/css/bootstrap.min.css" rel="stylesheet">
<link href="/exec/css/font-awesome.min.css" rel="stylesheet">
<link href='/skin/default/css/style.css' rel='stylesheet' type='text/css'>
<link href='/skin/default/css/sub.css' rel='stylesheet' type='text/css'>
<link href='/skin/default/css/board.css?v=3' rel='stylesheet' type='text/css'>

<script src="/exec/js/jquery-2.1.1.min.js"></script>
<script src="/exec/js/jquery-ui.min.js"></script>
<script src="/exec/js/bootstrap.min.js"></script>
<script src="/exec/js/jquery.validate.min.js"></script>
<script src="/exec/js/messages_ko.js"></script>
<script src="/admin/js/admin.js"></script>
</head>

<body style="background:#fff;">
<div id="wrapper" style="padding:15px;">
<%
   If MEM_SEQ > 0 Then
      SP_PG_EXEC = "/exec/board/board.asp"
      Server.Execute(SP_PG_EXEC)
   Else
      with response
         .write "<div class='alert alert-warning' role='alert'>게시판 관리자를 찾을 수 없습니다.</div>" & vbNewLine
      End with
   End If
%>
<% If request("method") = "" Or request("method") = "list" Then %>
<div style="height:50px;"></div>
<% End If %>
<div style="height:1px;"></div>
</div>

<script type="text/javascript">
  parent.viewfrmresize($("#wrapper").height() + 50);
</script>

<div style="display:none"><iframe name='sframe' style="width:0px;height:0px;"></iframe></div>
<% If request("method") = "write" Or request("method") = "edit" Or request("method") = "reply" Then %>
<script type="text/javascript">
  Editor.getCanvas().observeJob('canvas.height.change', function () {
    parent.viewfrmresize($("#wrapper").height() + 50);
  });
</script>
<% End If %>

</body>
</html>