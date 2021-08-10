<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Response.Expires = -1
   Response.ContentType = "text/xml"

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim xmlPars, rss, i
   Set xmlPars = Server.CreateObject("Msxml2.DOMDocument")

   Set rss = xmlPars.CreateElement("rss")
   xmlPars.AppendChild(rss)

   Dim BOARD_LST_Table
   BOARD_LST_Table = "BOARD_LST"

   Dim B_SEQ,B_TITLE,B_WDATE

   BC_SEQ = Trim(Request("bc_seq"))
   LIST_CNT = Trim(Request("list_cnt"))
   CUT_TITLE = Trim(Request("cut_title"))

   If IsNumeric(BC_SEQ) = false Then Response.End

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   CUT_SQL = "CASE WHEN DATALENGTH(B_TITLE) > " & CUT_TITLE & " THEN CONVERT(NVARCHAR(" & CUT_TITLE - 2 & "), B_TITLE) + '..' ELSE B_TITLE END AS C_TITLE "

   SQL = "SELECT TOP " & LIST_CNT & " B_SEQ,B_TITLE,B_WDATE,B_URL," & CUT_SQL & " FROM " & BOARD_LST_Table & " WHERE B_STATE < '90' AND BC_SEQ=" & BC_SEQ & " ORDER BY B_SEQ DESC"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         Set list = xmlPars.CreateElement("list")
         rss.AppendChild(list)

         Set b_seq = xmlPars.CreateElement("b_seq")
         Set b_title = xmlPars.CreateElement("b_title")
         Set b_wdate = xmlPars.CreateElement("b_wdate")
         Set b_new = xmlPars.CreateElement("b_new")
         Set b_url = xmlPars.CreateElement("b_url")

         list.AppendChild(b_seq)
         list.AppendChild(b_title)
         list.AppendChild(b_wdate)
         list.AppendChild(b_new)
         list.AppendChild(b_url)

         list.childnodes(0).text = Rs("B_SEQ")
         list.childnodes(1).text = Rs("C_TITLE")
         list.childnodes(2).text = f_chang_date(Rs("B_WDATE"))

         If DateDiff("n",f_chang_time(Rs("B_WDATE")),now()) < 1440 Then
            list.childnodes(3).text = "1"
         Else
            list.childnodes(3).text = "0"
         End If
         list.childnodes(4).text = Rs("B_URL")

         Rs.MoveNext
      Loop
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing

   Response.Write "<?xml version=""1.0"" encoding=""utf-8"" ?>"
   Response.Write xmlPars.xml

   Set xmlPars = nothing

   Function f_chang_date(c_date)
      If mid(c_date,1,4) <> Cstr(Year(Now)) Then
         f_chang_date = mid(c_date,1,4) & "." & mid(c_date,5,2) & "." & mid(c_date,7,2)
      Else
         f_chang_date = mid(c_date,5,2) & "." & mid(c_date,7,2)
      End If
   End Function

   Function f_chang_time(c_date)
      f_chang_time = mid(c_date,1,4) & "-" & mid(c_date,5,2) & "-" & mid(c_date,7,2) & " " & mid(c_date,9,2) & ":" & mid(c_date,11,2)
   End Function
%>