<%
	k = Request.form("k")
	m = Request.form("m")

	If k = "zzzz" And m = "in" Then 
		Response.Cookies("zzzz") = k
	ElseIf m = "out"  Then 
		Response.Cookies("zzzz") = ""
	End If 
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
	<script>
		function fnIN()
		{
			document.frm.m.value = "in";
			document.frm.action = "cookie.asp";
			document.frm.submit();
		}
		function fnOUT()
		{
			document.frm.m.value = "out";
			document.frm.action = "cookie.asp";
			document.frm.submit();
		}
	</script>
 </head>
 <body>
	<form name="frm" method="post">
		<input type="hidden" name="m" value="">
 <%
	If Request.Cookies("zzzz") = "" Then 
 %>
	<input type="text" name="k" value="">
	<button onclick="fnIN();">클릭</button>
<%
	Else 
%>
	<%=Request.Cookies("zzzz")%><button onclick="fnOUT();">클릭</button>
<%
	End If 
%>
	</form>
 </body>
</html>
