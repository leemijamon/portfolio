<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Dim FAQ_LST_Table
   FAQ_LST_Table = "FAQ_LST"

   Dim F_SEQ,F_TYPE,F_TITLE,F_CONT,F_READCNT,F_DISP,F_SORT
   Dim F_STATE

   Dim F_CNT(30), F_HTML(30)

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   WHERE = "F_DISP='1' AND F_STATE<'90'"
   ORDER_BY = "F_TYPE, F_SORT, F_SEQ"
   SQL = "SELECT * FROM " & FAQ_LST_Table & " WHERE " & WHERE & " ORDER BY " & ORDER_BY
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         i = i + 1
         F_SEQ = Rs("F_SEQ")
         F_TYPE = Rs("F_TYPE")
         F_TITLE = Rs("F_TITLE")
         F_CONT = Rs("F_CONT")
         F_READCNT = Rs("F_READCNT")
         F_DISP = Rs("F_DISP")
         F_SORT = Rs("F_SORT")

         F_NUM = Cint(F_TYPE)

         F_HTML(F_NUM) = F_HTML(F_NUM) & "      <div class='panel panel-default'>" & vbNewLine
         F_HTML(F_NUM) = F_HTML(F_NUM) & "        <div class='panel-heading'>" & vbNewLine
         F_HTML(F_NUM) = F_HTML(F_NUM) & "          <h4 class='panel-title'>" & vbNewLine
         F_HTML(F_NUM) = F_HTML(F_NUM) & "            <a href='#collapse" & F_SEQ & "' data-parent='#accordion" & F_TYPE & "' data-toggle='collapse' class='accordion-toggle'>" & F_TITLE & "</a>" & vbNewLine
         F_HTML(F_NUM) = F_HTML(F_NUM) & "          </h4>" & vbNewLine
         F_HTML(F_NUM) = F_HTML(F_NUM) & "        </div>" & vbNewLine

         'If OLD_TYPE <> F_TYPE Then
         'F_HTML(F_NUM) = F_HTML(F_NUM) & "        <div class='panel-collapse collapse in' id='collapse" & F_SEQ & "'>" & vbNewLine
         'Else
         F_HTML(F_NUM) = F_HTML(F_NUM) & "        <div class='panel-collapse collapse' id='collapse" & F_SEQ & "'>" & vbNewLine
         'End If

         F_HTML(F_NUM) = F_HTML(F_NUM) & "          <div class='panel-body'>" & vbNewLine
         F_HTML(F_NUM) = F_HTML(F_NUM) & "            " & F_CONT & vbNewLine
         F_HTML(F_NUM) = F_HTML(F_NUM) & "          </div>" & vbNewLine
         F_HTML(F_NUM) = F_HTML(F_NUM) & "        </div>" & vbNewLine
         F_HTML(F_NUM) = F_HTML(F_NUM) & "      </div>" & vbNewLine

         OLD_TYPE = F_TYPE
         F_CNT(F_NUM) = F_CNT(F_NUM) + 1

         Rs.MoveNext
      Loop
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing

   With response
      .write "<ul class='nav nav-tabs'>" & vbNewLine

       s_code = Split(F_TYPE_CD,",")
       s_name = Split(F_TYPE_NAME,",")

       For fn = 0 to UBound(s_code)
          If fn = 0 Then
             .write "  <li class='active'><a data-toggle='tab' href='#tab" & s_code(fn) & "'>" & s_name(fn) & "</a></li>" & vbNewLine
          Else
             .write "  <li><a data-toggle='tab' href='#tab" & s_code(fn) & "'>" & s_name(fn) & "</a></li>" & vbNewLine
          End If
       Next

      .write "</ul>" & vbNewLine

      .write "<div class='tab-content'>" & vbNewLine

       For fn = 0 to UBound(s_code)
          If fn = 0 Then
             .write "  <div id='tab" & s_code(fn) & "' class='tab-pane fade in active'>" & vbNewLine
          Else
             .write "  <div id='tab" & s_code(fn) & "' class='tab-pane fade'>" & vbNewLine
          End If

          .write "    <div id='accordion" & s_code(fn) & "' class='panel-group'>" & vbNewLine
          .write F_HTML(Cint(s_code(fn)))
          .write "    </div>" & vbNewLine
          .write "  </div>" & vbNewLine
       Next

      .write "</div>" & vbNewLine
   End With
%>


