<html>
<head>
<meta http-equiv=content-type content=text/html; charset=utf-8>
<title>파일 첨부</title>
<style type=text/css>
td {color:#000000; font-family:굴림; font-size:12px; line-height:16px}
img {border:none}
textarea {border:1px solid #D6D6D6;}
select {font-size:12px; font-family:굴림 ; color:#000000; border:1px solid #CCCCCC}
input {border:1px solid #D6D6D6;font-size:12px; font-family:굴림 ; color:#000000;}
a:link{font-family:굴림 ; color:#000000 ; text-decoration:none }
a:visited{font-family:굴림 ; color:#000000 ; text-decoration:none }
a:hover{font-family:굴림 ; color:#8E8E8E ; text-decoration:none }
a:active{font-family:굴림 ; color:#8E8E8E ; text-decoration:none }

.stit_p {letter-spacing:-1px; font-size:12px; font-weight:bold; color:#FFFFFF;}/*팝업제목*/
.box {border:1px solid #E2E2E2}/*박스라인 color*/
.box_bg {background-color:#FFFFFF}/*전체 bg*/
.box_pop {background-color:#B5B5B5}/*팝업창 상단*/
.box_bot {background-color:#EDEDED}/*팝업창 하단*/
.box_g {background-color:#F3F3F3}/*팝업창 박스*/
</style>
</head>

<body class='box_bg' bottommargin=0 topmargin=0 marginheight=0 leftmargin=0>

<form method="post" action="upload_pro.asp" enctype="multipart/form-data">
<input type="hidden" name="f_num" value="<%=request("f_num")%>">
<input type="hidden" name="f_type" value="<%=request("f_type")%>">
<input type="hidden" name="f_path" value="<%=request("f_path")%>">
<input type="hidden" name="m_with" value="<%=request("m_with")%>">
<input type="hidden" name="s_with" value="<%=request("s_with")%>">
<input type="hidden" name="s_height" value="<%=request("s_height")%>">

<table width="400" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6" bgcolor="#00008B"> </td>
  </tr>
  <tr>
    <td height="246" align="center">
      <table width="380" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="../img/popup/pop_title_file.gif" width="59" height="33"></td>
        </tr>
        <tr>
          <td height="3" background="../img/popup/pop_title_bg.gif"> </td>
        </tr>
        <tr>
          <td align="center">
            <table width="360" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="60" valign="bottom" style="line-height: 160%;"><font color="#565656"> <font color="#0066CC">[찾아보기]</font>
                  버튼을 클릭하신 후 업로드할 사진/파일을 선택 후 <br>
                  열기 버튼을 클릭하세요.</font></td>
              </tr>
              <tr>
                <td height="44"><font color="#565656"><strong>참조 :</strong> 사진/파일명은 영문과 숫자로 등록하시기 바랍니다.</font></td>
              </tr>
              <tr>
                <td height="42" align="center" bgcolor="#F1F1F1"><input type="file" name="upfile" class="form" style="width:270px;"></td>
              </tr>
              <tr>
                <td height="64" align="center" valign="top" style="padding:10 0 0 0"><span id="uploadbtn"><a href="javascript:image_upload();"><img src="../img/popup/btn_file.gif" width="86" height="21" border="0"></a></span></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td height="1" bgcolor="#E7E7E7"> </td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#F5F5F5"><a href="javascript:window.close()"><img src="../img/popup/pop_cl.gif" width="40" height="25" border="0"></a></td>
  </tr></form>
</table>

<script language=javascript>
function image_upload(){
  if(!document.forms[0].upfile.value){
    alert('첨부할 파일을 입력하세요~');
    return;
  }

  document.all.uploadbtn.style.display = 'none';
  document.forms[0].submit();
}
</script>

</body>
</html>

