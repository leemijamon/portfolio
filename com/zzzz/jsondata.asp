<!--#include virtual = "/zzzz/include/function.AES.asp"-->
<!--#include virtual = "/zzzz/include/class.JSON_2.0.4.asp"-->
<%
Dim p : p = Request.form("p")

If p = "" Then 
	Response.End 
End If 

Dim member
Set member = jsObject()

member("p") = encryptStr("1061376")
member("username") = encryptStr("가나다라마바사아자차카타파하")
member("useremail") = encryptStr("Topuz@naver.com")
member("usermobile") = encryptStr("010-1234-5678-90")

member.Flush
%>
