<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc"-->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/file_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CP_CODE,CP_TYPE,CP_NAME,CP_TITLE,CP_MEM_LEVEL,CP_CONT,CP_NUM,CP_PG_YN,CP_PG_ITEM
   Dim CP_PG_NAME,CP_PG_QUERY,CP_USE_YN

   CS_CODE = Trim(Request("cs_code"))
   CP_CODE = Trim(Request("cp_code"))

   WHERE = "CS_CODE='" & CS_CODE & "' AND CP_CODE='" & CP_CODE & "'"

   SQL = "SELECT * FROM " & CMS_PAGE_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      CP_CODE = Rs("CP_CODE")
      CP_NUM = Rs("CP_NUM")
      CP_NAME = Rs("CP_NAME")
      CP_TITLE = Rs("CP_TITLE")
      CP_TITLE_ENG = Rs("CP_TITLE_ENG")
      CP_PG_QUERY = Rs("CP_PG_QUERY")
      CP_STATE = Rs("CP_STATE")

      CP_LINK = "/" & CP_CODE
      If CP_PG_QUERY <> "" Then CP_LINK = CP_LINK & "?" & CP_PG_QUERY
   End If
   Rs.close

   NowDate = FormatDateTime(now(),2) & "T" & FormatDateTime(now(),4) & ":" & Right("00" & Second(Now()), 2)
   '2014-10-10T05:50:59+09:00

   If CP_STATE < "90" Then
      skin_path = "/skin/" & CS_CODE
      'skin_mappath = Server.MapPath(skin_path)

      'make_file_path = skin_mappath & "/page/" & Replace(CP_CODE,"/",".") & ".asp"
      'make_date = File_ModifyDate(make_file_path)
      'makeDate = FormatDateTime(make_date,2) & "T" & FormatDateTime(make_date,4) & ":" & Right("00" & Second(make_date), 2)

      PAGE_ID = "http://" & CS_URL & CP_LINK
      PAGE_URL = "http://" & CS_URL & skin_path & "/page/" & Replace(CP_CODE,"/",".") & ".asp"
      If CP_PG_QUERY <> "" Then PAGE_URL = PAGE_URL & "?" & CP_PG_QUERY

      CP_CONT = GetHTMLBin(PAGE_URL)

      'response.write CP_CONT
      'response.end

      'Dim FileControl
      'Set FileControl = Server.CreateObject("Server.FileControl")

      'inc_start = "<" & chr(37) & "@ LANGUAGE=""VBSCRIPT"" CODEPAGE=65001 " & chr(37) & ">" & vbNewLine
      'inc_start = inc_start & "<!-- #include virtual = ""/conf/site_config.inc"" -->" & vbNewLine

      'CP_CONT = FileControl.ReadFile(make_file_path, "UTF-8")
      'CP_CONT = Replace(CP_CONT,inc_start,"")

      CP_TITLE = Replace(CP_TITLE,"""","&quot;") ' "처리하기
      CP_TITLE = Replace(CP_TITLE,"&","&amp;") ' &처리하기

      CP_CONT = Replace(CP_CONT,"""","&quot;")
      CP_CONT = Replace(CP_CONT,"&","&amp;")
       'CP_CONT = Replace(CP_CONT,Chr(10)&Chr(13),"<br>")

      'Set FileControl = Nothing
   End If
%>
<?xml version="1.0" encoding="UTF-8" ?>
<feed xmlns="http://webmastertool.naver.com">
  <id>http://<%=CS_URL%></id>
  <title><%=CS_NAME%></title>
  <author>
    <name><%=CM_NAME%></name>
    <email><%=CM_EMAIL%></email>
  </author>
  <updated><%=NowDate%>+09:00</updated>
  <link rel="site" href="http://<%=CS_URL%>" title="<%=CS_NAME%>" />
<% If CP_STATE < "90" Then %>
  <entry>
    <id><%=PAGE_ID%></id>
    <title><![CDATA[<%=CP_TITLE%>]]></title>
    <author>
      <name><%=CM_NAME%></name>
    </author>
    <updated><%=NowDate%>+09:00</updated>
    <published><%=NowDate%>+09:00</published>
    <link rel="via" href="<%=PAGE_ID%>" title="<%=CP_TITLE%>" />
    <link rel="mobile" href="<%=PAGE_ID%>" />
    <content type="html"><![CDATA[<%=CP_CONT%>]]></content>
  </entry>
<% Else %>
  <deleted-entry ref="<%=PAGE_ID%>" when="<%=NowDate%>+09:00"/>
<% End If %>
</feed>