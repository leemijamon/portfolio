<!--#include virtual = "/zzzz/include/function.AES.asp"-->
<html>
	<title>커뮤니티</title>
	<head>
		<meta http-equiv=Content-Type content="text/html;charset=UTF8">
		<META HTTP-EQUIV="cache-control" content="no-cache">
		<META HTTP-EQUIV="pragma" content="no-cache">
		<META HTTP-EQUIV="imagetoolbar" CONTENT="no">
		<META name="robots" content="noindex">
	</head>
	
	<style>
		.contents {margin:30px auto;width:500px;border:1px solid #ddd;padding:30px 20px;text-align:center;color:#555;}
		.h1 {font-size:18px;padding:20px;}
		.h3 {font-size:16px;padding:10px;}
		.h3.gray {color:#999;}
		.hr {margin:20px 0 ;background-color:#ddd;height:1px;}
		a.btn {font-size:16px;padding:10px 40px;background-color:#eee;border:1px solid #555;margin:20px;}
		.data {margin:10px 20px;padding:10px 20px;border:1px solid #ddd;font-size:14px; white-space: normal; word-break: break-all;}
	</style>
	<body style="text-align:center;">
		<div class="contents">
			<h1 class="h1"> 로그인</h1>
<%
strID = ""
strKey  = "FaMiLyMall1234ezedu"


'			<h3 class="h3">strID ( 회원식별번호 ) : 987654321 </h3>
'			<h3 class="h3">strKey ( 항상동일 ) : FaMiLyMall1234ezedu</h3>
'			<hr class="hr">
'			<h3 class="h3 gray">strID암호화 : 8U/Rtlelubd9zmuc6fFXlA==  </h3>
'			<h3 class="h3 gray">strKey암호화 : hz5mdrUmr8ulMRCnrwjClhK8Kbi3G+o55KjSbwZvc+w=</h3>
%>
			<hr class="hr">
			<form name="frm">
				<input type="hidden" name="oroid" value="<%=encryptStr(strID)%>">
				<input type="hidden" name="orokey" value="<%=encryptStr(strKey)%>">
				<!--
				<a class="btn" href="javascript:;" onclick="fnFamilymall();return false;">이지패밀리몰</a>
				//-->
			</form>
		</div>
		<div class="contents">
				<div><a class="btn" href="javascript:;" onclick="fnFamilymallBlank();return false;">이지패밀리몰 Blank</a></div>
		</div>
		<!--
		<div class="contents">
			<h1 class="h1">회원정보요청</h1>
			<h3 class="h3">strID ( 회원식별번호 ) : 1048308  </h3>
			<h3 class="h3">http://com.ezro.kr/a_home/a_guest/woorione.htm?p=8U/Rtlelubd9zmuc6fFXlA== </h3>
			<div class="h3">
				<a class="btn" href="javascript:;" onclick="getData()">정보요청</a>
			</div>
			<div class="data">

			</div>
		</div>
		//-->
	</body>
	<script>
		function fnFamilymall()
		{
			var myFrm = document.frm;
			var winMall = window.open("","popFrm","fullscreen=yes, menubar=no, scrollbars=no, resizable=yes, center:yes");
			myFrm.action = "http://ezedu.oorionefm.com/gate.asp"
			myFrm.method = "post";
			myFrm.target = "popFrm";
			myFrm.submit();
			winMall.focus();
		}
		function fnFamilymallBlank()
		{
			var myFrm = document.frm;
			myFrm.action = "http://ezedu.oorionefm.com/gate.asp"
//			myFrm.action = "http://ezedu.oorionefm.com/gate_test.asp"
			myFrm.method = "post";
			myFrm.target ="_blank";
			myFrm.submit();
		}
		function getData(){
			$.get("http://com.ezro.kr/a_home/a_guest/woorione.htm?p=8U/Rtlelubd9zmuc6fFXlA==", function(data){
				$(".data").html(data);
				alert("데이터를 받았습니다.");
			}).fail(function() {
				alert( "Error : 관리자에게 문의하세요." );
			});
		}
	</script>
</html>
