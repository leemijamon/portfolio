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
 <%
	Function rndNum(lenNum)
		num = ""
		For i = 1 to lenNum
			Randomize                '//랜덤을 초기화 한다.
			num = num & CInt(Rnd*9)    '//랜덤 숫자를 만든다. 
		Next
		rndNum = num
	End Function

	Dim a, b, c, d, e, f
	a = rndNum(10)
	b = rndNum(10)
	c = rndNum(10)
	d = rndNum(10)
	e = rndNum(10)
	f = rndNum(10)
%>
 <body>
	<a href="http://onbt.oorionefm.com/gatenbt.asp?pid=286866&click_key=<%=a%>" target="_blank">go NBT 상품1 / <%=a%></a><br>
	<br><br>
	<a href="http://onbt.oorionefm.com/gatenbt.asp?pid=286867&click_key=<%=b%>" target="_blank">go NBT 상품2 / <%=b%></a><br>
	<br><br>
	<a href="http://onbt.oorionefm.com/gatenbt.asp?pid=286871&click_key=<%=c%>" target="_blank">go NBT 상품3 / <%=c%></a><br>
	<br><br>
	<a href="http://onbt.oorionefm.com/gatenbt.asp?pid=286849&click_key=<%=d%>" target="_blank">go NBT 상품4 / <%=d%></a><br>
	<br><br>
	<a href="http://onbt.oorionefm.com/gatenbt.asp?pid=286850&click_key=<%=e%>" target="_blank">go NBT 상품5 / <%=e%></a><br>
	<br><br>
	<a href="http://onbt.oorionefm.com/gatenbt.asp?pid=286852&click_key=<%=f%>" target="_blank">go NBT 상품6 / <%=f%></a><br>
	<br><br>
 </body>
</html>
