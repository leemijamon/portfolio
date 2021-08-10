<!-- #include virtual = "/exec/conf/code.inc" -->
<%
	SQL = "SELECT TOP 1 B_SEQ FROM BOARD_LST WHERE B_STATE < '90' AND BC_SEQ = 1 ORDER BY B_SEQ DESC"
	Set Rs = Conn.Execute(SQL, ,adCmdText)
	If Rs.BOF = false AND Rs.EOF = false Then
		CUT_B_SEQ = Rs("B_SEQ")
	End If
	Rs.close
%>
<!doctype html>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <title>Document</title>
 </head>
 <body>
  
<table style="width:100%;height:200px;">

<td id="td1" background='red.png'>

aaaa

bbbb

cccc

</td>

</table>

<input type=button value='배경변경' onclick="ch_bg()">



<script>

function ch_bg()
{
	document.getElementById("td1").style.backgroundImage = "url('blue.png')";
}
</script>


 </body>
</html>
