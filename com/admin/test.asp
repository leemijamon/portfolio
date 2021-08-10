<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/aspJSON1.17.asp" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim CS_CODE,CM_SEQ,CM_NAME,CM_DEPTH,CM_SORT,CM_WDATE,CP_SEQ

   Dim DEPTH1,DEPTH2,DEPTH3


      'MEMULIST = "[{""id"":""m1p7"",""children"":[{""id"":""m2p7""},{""id"":""m3p8""},{""id"":""m4p9""},{""id"":""m5p10""}]},{""id"":""m25p11"",""children"":[{""id"":""m26p11""}]},{""id"":""m27p12"",""children"":[{""id"":""m8p12""},{""id"":""m20p16""}]},{""id"":""m9p15"",""children"":[{""id"":""m10p15""}]},{""id"":""m21p17"",""children"":[{""id"":""m12p13""},{""id"":""m13p14""},{""id"":""m24p20""}]},{""id"":""m14p2"",""children"":[{""id"":""m15p2""},{""id"":""m16p3""},{""id"":""m17p4""},{""id"":""m18p5""},{""id"":""m19p6""},{""id"":""m22p18""},{""id"":""m23p19""}]}]"

      MEMULIST = "[{""id"":""m2p7""},{""id"":""m1p7"",""children"":[{""id"":""m3p8""},{""id"":""m4p9""},{""id"":""m5p10""}]},{""id"":""m25p11"",""children"":[{""id"":""m26p11""}]},{""id"":""m27p12"",""children"":[{""id"":""m8p12""},{""id"":""m20p16""}]},{""id"":""m9p15"",""children"":[{""id"":""m10p15""}]},{""id"":""m21p17"",""children"":[{""id"":""m12p13""},{""id"":""m13p14""},{""id"":""m24p20""}]},{""id"":""m14p2"",""children"":[{""id"":""m15p2""},{""id"":""m16p3""},{""id"":""m17p4""},{""id"":""m18p5""},{""id"":""m19p6""},{""id"":""m22p18""},{""id"":""m23p19""}]}]"
      If MEMULIST <> "" Then
         jsonstring = "{""memulist"":" & MEMULIST & "}"
         'response.write jsonstring

         Set oJSON = New aspJSON

         oJSON.loadJSON(jsonstring)

         Set oJSONdata = oJSON.data("memulist")

         For Each list1 In oJSONdata
            Set objdepth1 = oJSONdata.item(list1)
            SP_SEQ = Replace(objdepth1.item("id"),"m","")

            response.write "<br>depth1:" & objdepth1.item("id")
            Call pro_update(0, objdepth1.item("id"))

            If IsObject(objdepth1.item("children")) Then
               Set objdepth2data = objdepth1.item("children")

               For Each list2 In objdepth2data
                  Set objdepth2 = objdepth2data.item(list2)
                  response.write "<br>&nbsp;&nbsp;depth2:" & objdepth2.item("id")
                  Call pro_update(1, objdepth2.item("id"))

                  If IsObject(objdepth2.item("children")) Then
                     Set objdepth3data = objdepth2.item("children")

                     For Each list3 In objdepth3data
                        Set objdepth3 = objdepth3data.item(list3)
                        response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;depth3:" &objdepth3.item("id")

                        Call pro_update(2, objdepth3.item("id"))
                     Next
                  End If
               Next
            End If
         Next
      End If


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

      If CM_DEPTH = 0 Then
         DEPTH1 = DEPTH1 + 1
         DEPTH2 = 0
         DEPTH3 = 0
      End If

      If CM_DEPTH = 1 Then
         DEPTH2 = DEPTH2 + 1
         DEPTH3 = 0
      End If

      If CM_DEPTH = 2 Then
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

         response.write SQL & "<br>"
         'Conn.Execute SQL, ,adCmdText
      Else
         SQL = "UPDATE " & CMS_MENU_LST_Table & " SET " _
             & "CM_CODE='" & CM_CODE & "', " _
             & "CM_DEPTH=" & CM_DEPTH & ", " _
             & "CM_SORT=" & CM_SORT & ", " _
             & "CM_WDATE='" & CM_WDATE & "' " _
             & "WHERE " _
             & "CS_CODE='" & CS_CODE & "' AND CM_SEQ=" & CM_SEQ

         response.write SQL & "<br>"
         'Conn.Execute SQL, ,adCmdText
      End If

      SQL = "UPDATE " & CMS_PAGE_LST_Table & " SET " _
          & "CP_NUM='" & CM_CODE & "' " _
          & "WHERE " _
          & "CS_CODE='" & CS_CODE & "' AND CP_SEQ=" & CP_SEQ

         'response.write SQL & "<br>"
      'Conn.Execute SQL, ,adCmdText
   End Sub

%>