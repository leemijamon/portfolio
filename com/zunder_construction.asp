<%
	If Datediff( "s", Now(), "2020-03-27 AM 03:50:00") <= 0 And Datediff( "s", Now(), "2020-03-27 AM 06:00:00") >= 0 Then 
	Else 
		Response.Write "<script>alert('Not Service.');history.back(-1);</script>"
		Response.End 
	End If 
%>

<!doctype html>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <meta name="viewport" content="width=device-width, user-scalable=no">
  <title>Document</title>

<style> 
.vCenter { display: table; width: 100%; height: 100%; border: 0px solid red; } .vCenter span { display: table-cell; text-align: center; vertical-align: middle; } 
</style>

 </head>
 <body style="background-color:#f0f0f0;">
	<br><br><br>
	<br><br>
	<div class="vCenter">
		<span style="text-align:center;">

			<div id="img1" name="img1" style="display:none;"><img src="https://oorionefm.com/images/pc_server_now.jpg" style="border:0px;"></div>
			<div id="img2" name="img2" style="display:none;"><img src="https://oorionefm.com/images/mo_server_now.jpg" style="border:0px;"></div>

<!--
			<div style="font-size:24px;color:#ff0080;font-weight:700;">
			사이트 점검중 입니다.</div><br>
			<div style="font-size:28px;color:#ff0080;font-weight:700;">
			5월 30일 오전 03시 ~ 5월 30일 오전 07시 (4시간)</div><br><br>
			<div style="font-size:24px;color:#747474;">
			이용에 불편을 드려 죄송합니다.</div><br>
			<div style="font-size:24px;color:#747474;">
			더 나은 서비스 제공을 위해 최선을 다하겠습니다.</div>
//-->

		</span>
	</div>
 </body>
</html>

<script type="text/javascript">
function isMobile(){
	var UserAgent = navigator.userAgent;
	if (UserAgent.match(/iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)
	{
		return true;
	}else{
		return false;
	}
}
if(isMobile()){
	document.getElementById("img1").style.display = "none";
	document.getElementById("img2").style.display = "";
}else{
	document.getElementById("img1").style.display = "";
	document.getElementById("img2").style.display = "none";
}
</script>
