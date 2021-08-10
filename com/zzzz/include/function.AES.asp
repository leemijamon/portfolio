<%
	Const conKey = "key" 		'암호화 비밀키
	Const conIV = "vector"  	'초기화 벡터
	
	' 인스턴스 만들기
	Set objEncrypter = Server.CreateObject("Ryeol.StringEncrypter")

	objEncrypter.Key = conKey
	objEncrypter.IV = conIV
	
' ######################################################################
'	Function name	: encryptStr
'	Parameter		:
'	Return			: strEncrypted
'	Description		:
' ######################################################################
Function encryptStr(ByVal str)
	dim strContents
	dim strEncrypted 
	
	strContents = str
	Session("encode") = strContents
	strEncrypted = objEncrypter.Encrypt(Session("encode"))
	
'	Response.Write "strEncrypted: " & strEncrypted & "<br>"
	
	encryptStr = strEncrypted
End Function

' ######################################################################
'	Function name	: decryptStr
'	Parameter		:
'	Return			: strDecrypted
'	Description		:
' ######################################################################
Function decryptStr(ByVal strEncrypted)
	dim ecpContents
	dim strDecrypted 
	
	ecpContents = strEncrypted
	
	Session("decode") = strEncrypted
	strDecrypted = objEncrypter.Decrypt(Session("decode"))
	
'	Response.Write "strDecrypted: " & strDecrypted & "<br>"
	
	decryptStr = strDecrypted
End Function
	
' ######################################################################	
' 테스트 
'	strContents = "테스트 문자열abc123@@##"
'	Response.Write "테스트 문자열abc123@@##" & "<br>"
	
'	dim testEcp
'	testEcp = encryptStr(strContents)
	
'	dim testDcp
'	testDcp =  decryptStr(testEcp)
' ######################################################################
%>
