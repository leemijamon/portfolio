<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   B_SEQ = Trim(Request("seq"))

   If IsNumeric(B_SEQ) = false Then Response.End

   SQL = "SELECT *,(SELECT MEM_NAME FROM MEM_LST WHERE MEM_SEQ = BOARD_LST.MEM_SEQ) AS MEM_NAME FROM BOARD_LST WHERE B_SEQ=" & B_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
		B_SEQ = Rs("B_SEQ")
		B_TITLE = Rs("B_TITLE")
		B_CONT = Rs("B_CONT")
		B_FILE_NAME = Rs("B_FILE_NAME")
		MEM_NAME = Rs("MEM_NAME")
		B_WDATE = f_chang_date(Rs("B_WDATE"))

		B_CONT = Replace(B_CONT,Chr(13) & Chr(10),"<br>")
   End If
   Rs.close

   Conn.Close
   Set Conn = Nothing
%>
<div class="modal fade" id="noticeModal" role="dialog" aria-labelledby="noticeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
			<div class="modal-breadcrumbs">
				<div class="row no-mar">
					<div class="col-xs-6 col-md-6 no-pad">
						<p class="modal-breadcrumbs-p1">글쓴이 : <%=MEM_NAME%></p>
					</div>
					<div class="col-xs-6 col-md-6 no-pad">
						<p class="modal-breadcrumbs-p1 text-right">등록일 : <%=B_WDATE%></p>
					</div>
				</div>
			</div>
			<div class="modal-context"><%=B_CONT%></div>
		</div>

      <div class="modal-footer">
			<a href="" class="hoverBt serviceBt" title="목록보기">목록보기</a>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->