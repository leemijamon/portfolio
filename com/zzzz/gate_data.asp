<%
	Response.CharSet="utf-8"
	Response.codepage="65001"
	Response.ContentType="text/html;charset=utf-8"
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
  
  		ck_getdate = "http://com.ezro.kr/a_home/a_guest/woorione.htm?p=" & EncP
		set jsonResult = new aspJSON
		jsonResult.loadJSON(ck_getdate)

		p = jsonResult.data("p")
		If p <> "" And isNull(p) = False Then 
			p = Trim(decryptStr(p))
		End If 
		username = jsonResult.data("username")
		If username <> "" And isNull(username) = False Then 
			username = Trim(decryptStr(username))
		End If 
		useremail = jsonResult.data("useremail")
		If useremail <> "" And isNull(useremail) = False Then 
			useremail = Trim(decryptStr(useremail))
		End If 
		usermobile = jsonResult.data("usermobile")
		If usermobile <> "" And isNull(usermobile) = False Then 
			usermobile = Trim(decryptStr(usermobile))
		End If 
		userpost = jsonResult.data("userpost")
		If userpost <> "" And isNull(userpost) = False Then 
			userpost = Trim(decryptStr(userpost))
		End If 
		useraddr = jsonResult.data("useraddr")
		If useraddr <> "" And isNull(useraddr) = False Then 
			useraddr = Trim(decryptStr(useraddr))
		End If 
		useraddrdetail = jsonResult.data("useraddrdetail")
		If useraddrdetail <> "" And isNull(useraddrdetail) = False Then 
			useraddrdetail = Trim(decryptStr(useraddrdetail))
		End If 
		msg = jsonResult.data("msg")
		If msg <> "" And isNull(msg) = False Then 
			msg = Trim(decryptStr(msg))
		End If 
		
<!--#include file="JSON_2.0.4.asp"-->
<%
    Dim member Set member = jsObject() 
    member("p") = "123456789"
    member("username") = "15"
    member("useremail") = "15"
    member("usermobile") = "15"
    member("userpost") = "15"
    member("useraddr") = "15"
    member("useraddrdetail") = "15"
    member("msg") = "15"
    member.Flush
%>
{"name":"ollagaza","age":"15","message":"ollagaza's story"}

 </body>
</html>
