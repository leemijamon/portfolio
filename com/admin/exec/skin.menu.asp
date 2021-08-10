<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/aspJSON1.17.asp" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MSG,GO_PAGE

   PRO_METHOD = Trim(Request("method"))

   Dim CMS_MENU_LST_Table
   CMS_MENU_LST_Table = "CMS_MENU_LST"

   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CS_CODE,CM_SEQ,CM_NAME,CM_DEPTH,CM_SORT,CM_WDATE,CP_SEQ

   CS_CODE = Trim(Request("cs_code"))

   Dim DEPTH1,DEPTH2,DEPTH3

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case PRO_METHOD
      Case "list" : pro_list
      Case "title" : pro_title
   End Select

   '##코드 생성
   Server.Execute "/admin/exec/make.menu.asp"

   Conn.Close
   Set Conn = nothing

   Sub pro_list()
      PAGELIST = Trim(Request.Form("pagelist-output"))
      If PAGELIST <> "" Then
         jsonstring = "{""pagelist"":" & PAGELIST & "}"
         'response.write jsonstring

         Set oJSON = New aspJSON

         oJSON.loadJSON(jsonstring)

         CP_SORT = 0
         For Each lists In oJSON.data("pagelist")
            Set this = oJSON.data("pagelist").item(lists)
            SP_SEQ = Replace(this.item("id"),"p","")

            CP_SORT = CP_SORT + 1

            SQL = "UPDATE " & CMS_PAGE_LST_Table & " SET " _
                & "CP_SORT=" & CP_SORT & " " _
                & "WHERE CS_CODE='" & CS_CODE & "' AND CP_SEQ=" & SP_SEQ

            Conn.Execute SQL, ,adCmdText
         Next
      End If

      DEL_LIST = Trim(Request.Form("memulist-del"))
         If DEL_LIST <> "" Then

         SP_DEL = Split(DEL_LIST,",")

         For i = 0 To UBound(SP_DEL)
            If Left(SP_DEL(i),1) = "m" Then
               SP_ID = Split(SP_DEL(i),"p")
               CM_SEQ = Replace(SP_ID(0),"m","")
               CP_SEQ = SP_ID(1)

            'If InStr(SP_DEL(i),"m") > 0 Then
            '   CM_SEQ = Replace(SP_DEL(i),"m","")

               SQL = "DELETE FROM " & CMS_MENU_LST_Table & " WHERE CS_CODE='" & CS_CODE & "' AND CM_SEQ=" & CM_SEQ
               'response.write SQL & "<br>"
               Conn.Execute SQL, ,adCmdText
            End If
         Next
      End If

      MEMULIST = Trim(Request.Form("memulist-output"))
      If MEMULIST <> "" Then
         jsonstring = "{""memulist"":" & MEMULIST & "}"
         'response.write jsonstring

         Set oJSON = New aspJSON

         oJSON.loadJSON(jsonstring)

         Set oJSONdata = oJSON.data("memulist")

         For Each list1 In oJSONdata
            Set objdepth1 = oJSONdata.item(list1)
            SP_SEQ = Replace(objdepth1.item("id"),"m","")

            'response.write "<br>depth1:" & objdepth1.item("id")
            Call pro_update(0, objdepth1.item("id"))

            If IsObject(objdepth1.item("children")) Then
               Set objdepth2data = objdepth1.item("children")

               For Each list2 In objdepth2data
                  Set objdepth2 = objdepth2data.item(list2)
                  'response.write "<br>&nbsp;&nbsp;depth2:" & objdepth2.item("id")
                  Call pro_update(1, objdepth2.item("id"))

                  If IsObject(objdepth2.item("children")) Then
                     Set objdepth3data = objdepth2.item("children")

                     For Each list3 In objdepth3data
                        Set objdepth3 = objdepth3data.item(list3)
                        'response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;depth3:" &objdepth3.item("id")

                        Call pro_update(2, objdepth3.item("id"))
                     Next
                  End If
               Next
            End If
         Next
      End If

      NEWLIST = Trim(Request.Form("memulist-new"))
      If NEWLIST <> "" Then
         SPLIST = Split(NEWLIST,",")

         If UBound(SPLIST) > 1 Then
            For fn = 0 to UBound(SPLIST) - 1 STEP 2
               CM_ID = "p" & SPLIST(fn)
               CM_NAME = SPLIST(fn + 1)

               SQL = "UPDATE " & CMS_MENU_LST_Table & " SET " _
                   & "CM_NAME=N'" & CM_NAME & "' " _
                   & "WHERE " _
                   & "CS_CODE='" & CS_CODE & "' AND CM_ID='" & CM_ID & "'"

               'response.write SQL & "<br>"
               Conn.Execute SQL, ,adCmdText
            Next
         End If
      End If

      MSG = "메뉴를 설정하였습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.goskin();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With
      'loadURL "메뉴를 설정하였습니다.", "skin.menu"
      'response.end
   End Sub

   Sub pro_update(CM_DEPTH,CM_ID)
      If Left(CM_ID,1) = "m" Then
         SP_ID = Split(CM_ID,"p")
         CM_SEQ = Replace(SP_ID(0),"m","")
         CP_SEQ = SP_ID(1)
      Else
         CM_SEQ = "0"
         SP_SEQ = Split(Replace(CM_ID,"p",""),"_")
         CP_SEQ = SP_SEQ(0)

         SQL = "SELECT CP_NAME FROM " & CMS_PAGE_LST_Table & " WHERE CS_CODE='" & CS_CODE & "' AND CP_SEQ=" & CP_SEQ
         Set Rs = Conn.Execute(SQL, ,adCmdText)

         If Rs.BOF = false AND Rs.EOF = false Then
            CM_NAME = Rs("CP_NAME")
         End If
         Rs.close
      End If

      CM_SORT = CM_SORT + 1

      If CM_DEPTH = "0" Then
         DEPTH1 = DEPTH1 + 1
         DEPTH2 = 0
         DEPTH3 = 0
      End If

      If CM_DEPTH = "1" Then
         DEPTH2 = DEPTH2 + 1
         DEPTH3 = 0
      End If

      If CM_DEPTH = "2" Then
         DEPTH3 = DEPTH3 + 1
      End If

      CM_CODE = Right("00" & DEPTH1, 2) & Right("00" & DEPTH2, 2) & Right("00" & DEPTH3, 2)

      CM_WDATE = NowDate

      If CM_SEQ = "0" Then
         Call MAX_ID

         SQL = "INSERT INTO " & CMS_MENU_LST_Table _
             & " (CS_CODE,CM_SEQ,CM_NAME,CM_ID,CM_CODE,CM_DEPTH,CM_SORT,CM_WDATE,CP_SEQ)" _
             & " VALUES (N'" _
             & CS_CODE & "'," _
             & CM_SEQ & ",N'" _
             & CM_NAME & "',N'" _
             & CM_ID & "','" _
             & CM_CODE & "'," _
             & CM_DEPTH & "," _
             & CM_SORT & ",'" _
             & CM_WDATE & "'," _
             & CP_SEQ & ")"

         'response.write SQL & "<br>"
         Conn.Execute SQL, ,adCmdText
      Else
         SQL = "UPDATE " & CMS_MENU_LST_Table & " SET " _
             & "CM_CODE='" & CM_CODE & "', " _
             & "CM_DEPTH=" & CM_DEPTH & ", " _
             & "CM_SORT=" & CM_SORT & ", " _
             & "CM_WDATE='" & CM_WDATE & "' " _
             & "WHERE " _
             & "CS_CODE='" & CS_CODE & "' AND CM_SEQ=" & CM_SEQ

         Conn.Execute SQL, ,adCmdText
      End If

      SQL = "UPDATE " & CMS_PAGE_LST_Table & " SET " _
          & "CP_NUM='" & CM_CODE & "' " _
          & "WHERE " _
          & "CS_CODE='" & CS_CODE & "' AND CP_SEQ=" & CP_SEQ

         'response.write SQL & "<br>"
      Conn.Execute SQL, ,adCmdText
   End Sub

   Sub MAX_ID()
      SQL = "SELECT MAX(CM_SEQ) AS MAX_SEQ FROM " & CMS_MENU_LST_Table & " WHERE CS_CODE='" & CS_CODE & "'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      CM_SEQ = Rs("MAX_SEQ")
      Rs.close

      If IsNULL(CM_SEQ) Then CM_SEQ = 0
      CM_SEQ = CM_SEQ + 1
   End Sub

   Sub pro_title()
      E_PK = Trim(Request.Form("pk"))
      E_NAME = Trim(Request.Form("name"))
      E_VALUE = Replace(Trim(Request.Form("value")),"'","''")

      If E_VALUE <> "" AND Left(E_PK,1) = "m" Then
         SP_ID = Split(E_PK,"p")
         CM_SEQ = Replace(SP_ID(0),"m","")
         CP_SEQ = SP_ID(1)

         'CM_SEQ = Replace(E_PK,"m","")
         CM_NAME = E_VALUE

         SQL = "UPDATE " & CMS_MENU_LST_Table & " SET " _
             & "CM_NAME=N'" & CM_NAME & "' " _
             & "WHERE " _
             & "CS_CODE='" & CS_CODE & "' AND CM_SEQ=" & CM_SEQ

         Conn.Execute SQL, ,adCmdText

         'Dim FileControl
         'Set FileControl = Server.CreateObject("Server.FileControl")

         'make_file_path = Server.MapPath("/admin") & "\exec\log.txt"

         '실제파일저장
         'FileControl.CreateFile make_file_path, "UTF-8", E_PK & "|" & E_NAME & "|" & E_VALUE

         'Set FileControl = Nothing

         Response.Write "{name:'" & E_NAME & "',pk:'" & E_PK & "',value:'" & E_VALUE & "'}"
      Else
         Response.AddHeader "Status","HTTP 400 Bad Request"
         Response.Status = "400"
         Response.Write "This field is required!"
      End If
   End Sub
%>
