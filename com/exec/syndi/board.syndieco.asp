<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc"-->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_READ_MT,BC_WRITE_MT,BC_MEM_SEQ

   Dim BOARD_LST_Table
   BOARD_LST_Table = "BOARD_LST"

   Dim B_SEQ,B_PTSEQ,B_PSEQ,B_PSORT,B_PDEPTH,B_TITLE,B_CONT,B_FILE_NAME,B_FILE_SIZE,B_READ_CNT
   Dim B_RECO_CNT,B_IP,B_WDATE,B_MDATE,B_STATE,B_MEM_SEQ,B_MEM_NAME

   BC_SEQ = Trim(Request("bc_seq"))
   B_SEQ = Trim(Request("b_seq"))

   If IsNumeric(BC_SEQ) = false Then Response.End
   If IsNumeric(B_SEQ) = false Then Response.End

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      BC_NAME = Rs("BC_NAME")
   End If
   Rs.close

   SQL = "SELECT *, MEM_NAME = (SELECT MEM_NAME FROM MEM_LST WHERE MEM_LST.MEM_SEQ=BOARD_LST.MEM_SEQ) FROM " & BOARD_LST_Table _
       & " WHERE B_SEQ=" & B_SEQ

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      B_SECRET = Rs("B_SECRET")
      B_HEADER = Rs("B_HEADER")
      B_TITLE = Rs("B_TITLE")
      B_CONT = Rs("B_CONT")
      B_TEXT = Rs("B_TEXT")
      B_WDATE = chang_time(Rs("B_WDATE"))
      B_MDATE = chang_time(Rs("B_MDATE"))
      B_MEM_SEQ = Rs("MEM_SEQ")
      B_MEM_NAME = Rs("MEM_NAME")
      B_STATE = Rs("B_STATE")

      If IsNULL(B_MEM_SEQ) Then
         B_MEM_SEQ = 0
         B_MEM_NAME = Rs("B_GUEST_NAME")
      End If

      If B_HEADER <> "" Then B_TITLE = "[" & B_HEADER & "] " & B_TITLE
   End If
   Rs.close

   SELF_URL = Replace(Trim(Request("self_url")),"|","&amp;")

   NowDate = FormatDateTime(now(),2) & "T" & FormatDateTime(now(),4) & ":" & Right("00" & Second(Now()), 2)
   '2014-10-10T05:50:59+09:00

   '######## 날짜 변환
   Function chang_time(c_date)
      If Len(c_date) > 11 Then
         chang_time = mid(c_date,1,4) & "-" & mid(c_date,5,2) & "-" & mid(c_date,7,2) & "T" & mid(c_date,9,2) & ":" & mid(c_date,11,2) & ":00"
      Else
         chang_time = ""
      End If
   End Function

   B_TITLE = Replace(B_TITLE,"""","&quot;") ' "처리하기
   B_TITLE = Replace(B_TITLE,"&","&amp;") ' &처리하기

   B_CONT = Replace(B_CONT,"""","&quot;")
   B_CONT = Replace(B_CONT,"&","&amp;")

   BC_LINK = "http://" & CS_URL & SELF_URL & "?bc_seq=" & BC_SEQ
   B_LINK = BC_LINK & "&amp;b_seq=" & B_SEQ

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
<% If B_STATE < "90" Then %>
  <entry>
    <id><%=B_LINK%></id>
    <title><![CDATA[<%=B_TITLE%>]]></title>
    <author>
      <name><%=CM_NAME%></name>
    </author>
    <updated><%=B_MDATE%>+09:00</updated>
    <published><%=B_WDATE%>+09:00</published>
    <link rel="via" href="<%=BC_LINK%>" title="<%=BC_NAME%>" />
    <link rel="mobile" href="<%=BC_LINK%>" />
    <content type="html"><![CDATA[<%=B_CONT%>]]></content>
    <summary type="text"><![CDATA[<%=B_TEXT%>]]></summary>
  </entry>
<% Else %>
  <deleted-entry ref="<%=B_LINK%>" when="<%=B_MDATE%>+09:00"/>
<% End If %>
</feed>