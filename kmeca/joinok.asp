<!--#include virtual="/_include/config.asp"-->

<%
	name = getRequest("name", Null)
	tel = getRequest("tel", Null)
	email = getRequest("email", Null)
	com = getRequest("com", Null)
	position = getRequest("position", Null)
	
	'response.write "name=" & name
	'response.end
	

	sql = " INSERT INTO T_MEMBER_KMECA ("
	sql = sql &" NAME, TEL, EMAIL, COMPANY, POSITION"
	sql = sql &" ) VALUES ("
	sql = sql &" ?, ?, ?, ?, ?"
	sql = sql &" )"
	arrParams = Array( _
		Db.makeParam("@NAME", advarWchar, adParamInput, 50, NAME), _
		Db.makeParam("@TEL", advarWchar, adParamInput, 50, TEL), _
		Db.makeParam("@EMAIL", advarWchar, adParamInput, 100, EMAIL), _
		Db.makeParam("@COMPANY", advarWchar, adParamInput, 100, COMPANY), _
		Db.makeParam("@POSITION", advarWchar, adParamInput, 50, POSITION)_		
	)
	Call Db.exec(sql, DB_CMDTYPE_TEXT, arrParams, Nothing)


	Call jsmsgLink("정상적으로 접수되었습니다.", "/kmeca/index.asp?#section04", "")
%>