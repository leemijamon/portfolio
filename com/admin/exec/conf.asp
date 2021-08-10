<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim CMS_CONFIG_LST_Table
   CMS_CONFIG_LST_Table = "CMS_CONFIG_LST"

   Dim CC_TYPE,CC_KEY,CC_VALUE,CC_WDATE,CC_MDATE,ADM_SEQ

   CC_TYPE = Trim(Request.Form("cc_type"))
   CC_WDATE = NowDate
   CC_MDATE = NowDate
   ADM_SEQ = Session("ADM_SEQ")
   If ADM_SEQ = "" Then ADM_SEQ = "NULL"

   i = 0
   For each item in Request.Form
      If item <> "x" AND item <> "y" AND item <> "cc_type" AND item <> "action" AND item <> "rtnurl" AND item <> "msg" Then
         R_VALUE = Trim(Request.Form(item))
         R_VALUE = Replace(R_VALUE,"'","''")
         R_VALUE = Replace(R_VALUE,"""","")
         R_VALUE = Replace(R_VALUE,"|","")
         R_VALUE = Replace(R_VALUE,",","|")

         If i > 0 Then CC_KEY = CC_KEY & ","
         If i > 0 Then CC_VALUE = CC_VALUE & ","
         CC_KEY = CC_KEY & UCase(item)
         CC_VALUE = CC_VALUE & R_VALUE
         i = i + 1
      End If
   Next

   If CC_TYPE = "map" AND Session("MAP_CODE") <> "" Then
      CC_KEY = CC_KEY & ",MAP_CODE1,MAP_CODE2"
      CC_VALUE = CC_VALUE & "," & Session("MAP_CODE")
   End If

   WHERE = "CC_TYPE='" & CC_TYPE & "'"
   SQL = "SELECT * FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      '수정
      SQL = "UPDATE " & CMS_CONFIG_LST_Table & " SET " _
          & "CC_KEY='" & CC_KEY & "', " _
          & "CC_VALUE='" & CC_VALUE & "', " _
          & "CC_MDATE='" & CC_MDATE & "', " _
          & "ADM_SEQ=" & ADM_SEQ & " " _
          & "WHERE " _
          & "CC_TYPE='" & CC_TYPE & "'"

      Conn.Execute SQL, ,adCmdText
   Else
      '등록
      SQL = "INSERT INTO " & CMS_CONFIG_LST_Table _
          & " (CC_TYPE,CC_KEY,CC_VALUE,CC_WDATE,CC_MDATE,ADM_SEQ)" _
          & " VALUES ('" _
          & CC_TYPE & "','" _
          & CC_KEY & "','" _
          & CC_VALUE & "','" _
          & CC_WDATE & "','" _
          & CC_MDATE & "'," _
          & ADM_SEQ & ")"

      Conn.Execute SQL, ,adCmdText
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing

   '##코드 생성
   Server.Execute "/admin/exec/make.conf.asp"

   If Trim(Request("rtnurl")) <> "" Then
      rtnurl = Trim(Request("rtnurl"))
   Else
      rtnurl = "conf.site"
   End If

   If Trim(Request("msg")) <> "" Then
      rtnmsg = Trim(Request("msg"))
   Else
      rtnmsg = "사이트정보를 등록하였습니다."
   End If

   loadURL rtnmsg, rtnurl
   response.end
%>
