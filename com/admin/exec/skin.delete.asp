<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim CMS_SKIN_LST_Table
   CMS_SKIN_LST_Table = "CMS_SKIN_LST"

   Dim CS_CODE,CS_STATE

   CS_CODE = Trim(Request.Form("cs_code"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   CS_MDATE = NowDate
   CS_STATE = "99"

   SQL = "UPDATE " & CMS_SKIN_LST_Table & " SET " _
       & "CS_MDATE='" & CS_MDATE & "', " _
       & "CS_STATE='" & CS_STATE & "' " _
       & "WHERE CS_CODE='" & CS_CODE & "'"

   Conn.Execute SQL, ,adCmdText

   'DB삭제

   Dim CMS_ITEM_LST_Table
   CMS_ITEM_LST_Table = "CMS_ITEM_LST"

   Dim CI_CODE,CI_TYPE,CI_NAME,CI_CONT,CI_SKIN,CI_SORT,CI_WDATE,CI_MDATE,CI_STATE

   Dim CMS_LAYOUT_LST_Table
   CMS_LAYOUT_LST_Table = "CMS_LAYOUT_LST"

   Dim CL_CODE,CL_NAME,CL_SORT,CL_WDATE,CL_MDATE,CL_STATE

   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CP_SEQ,CP_CODE,CP_TYPE,CP_NUM,CP_NAME,CP_TITLE,CP_TITLE_ENG,CP_KEYWORDS,CP_DESCRIPTION
   Dim CP_MEM_LEVEL,CP_SKIN,CP_PG_YN,CP_PG_ITEM,CP_PG_NAME,CP_PG_QUERY,CP_SSL_YN,CP_USE_YN,CP_SORT,CP_WDATE
   Dim CP_MDATE,CP_STATE

   Dim CMS_MENU_LST_Table
   CMS_MENU_LST_Table = "CMS_MENU_LST"

   SQL = "DELETE FROM " & CMS_MENU_LST_Table & " WHERE CS_CODE='" & CS_CODE & "'"
   Conn.Execute SQL, ,adCmdText

   SQL = "DELETE FROM " & CMS_PAGE_LST_Table & " WHERE CS_CODE='" & CS_CODE & "'"
   Conn.Execute SQL, ,adCmdText

   SQL = "DELETE FROM " & CMS_LAYOUT_LST_Table & " WHERE CS_CODE='" & CS_CODE & "'"
   Conn.Execute SQL, ,adCmdText

   SQL = "DELETE FROM " & CMS_ITEM_LST_Table & " WHERE CS_CODE='" & CS_CODE & "'"
   Conn.Execute SQL, ,adCmdText

   Conn.Close
   Set Conn = nothing

   '폴더삭제

   Dim FileControl
   Set FileControl = Server.CreateObject("Server.FileControl") '컴포넌트 Object 선언

   Dim Result

   skin_path = Server.MapPath("/skin") & "/" & CS_CODE

   FileControl.DeleteFolder skin_path '메소드(함수) 호출

   Set FileControl = Nothing

   loadURL "\'" & CS_CODE & "\' 스킨을 삭제 하였습니다.", "skin.active"
   response.end
%>
