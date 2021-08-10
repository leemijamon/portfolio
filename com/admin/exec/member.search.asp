<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_ID

   QUERY = Replace(Trim(Request("query")),"'","''")

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   With Response
      .write "<ul class=""search-list"">" & vbNewLine

      If QUERY <> "" Then
         SQL = "SELECT COUNT(*) FROM " & MEM_LST_Table & " WHERE MEM_NAME LIKE '%" & QUERY & "%' AND MEM_STATE < '90'"
         Set Rs = Conn.Execute(SQL, ,adCmdText)
         If Rs.BOF = false AND Rs.EOF = false Then
            SEARCH_CNT = Rs(0)
         End If
         Rs.Close

         If SEARCH_CNT > 30 Then
            .write "<li>검색범위가 너무 넓습니다. 정확한 이름으로 입력해주세요.</li>" & vbNewLine
         Else
            SQL = "SELECT MEM_SEQ,MEM_NAME,MEM_ID FROM " & MEM_LST_Table & " WHERE MEM_NAME LIKE '%" & QUERY & "%' AND MEM_STATE < '90'"
            Set Rs = Conn.Execute(SQL, ,adCmdText)
            If Rs.BOF = false AND Rs.EOF = false Then
               Do until Rs.EOF
                  MEM_SEQ = Rs("MEM_SEQ")
                  MEM_NAME = Rs("MEM_NAME")
                  MEM_ID = Rs("MEM_ID")

                  .write "<li><a href=""#"" onclick=""setSearch('" & MEM_SEQ & "','" & MEM_NAME & "');return false;"">" & MEM_NAME & "(" & MEM_ID & ")</a></li>" & vbNewLine

                  Rs.MoveNext
               Loop
            Else
               .write "<li>검색하신 회원이 없습니다.</li>" & vbNewLine
            End If
         End if
      Else
         .write "<li>검색하신 회원이 없습니다.</li>" & vbNewLine
      End if

      .write "</ul>" & vbNewLine
   End With
%>