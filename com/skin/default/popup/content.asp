<!--## 팝업관리 ##-->
<style>
	#popup{position:absolute; top:10px; left:10px; z-index:9999; width:620px; height:710px;}
	.popup_wrap{position:relative;}
	.close_btn{position:absolute; top:35px; right:45px; border:0; background-color:#fff; font-size:20px;}
	.today_close{position:absolute; bottom:15px; right:25px; color:#fff; display:block; font-size:14px;}
</style>

<div id="popup" align="center" style="display:none;">
	<div class="popup_wrap">
			<a href="javascript:closeMainPopup();" class="close_btn">X</a>
			<img src="/skin/default/img/popup/name_change.png" alt="사명변경 공지" class="popup_content">
			<a href="javascript:closePopupNotToday()" class="today_close">오늘 하루동안 보지 않기</a>
        </form>
	</div>
</div>

<script>
	if(getCookie("notToday")!="Y"){
			$("#popup").show();
	}
	/*****## 오늘 하루동안 보지 않기 ##*****/
	function closePopupNotToday(){	             
			setCookie('notToday','Y', 1);
			$("#popup").hide();
	}

	/*****## 쿠기 가져오기 ##*****/
	function setCookie(name, value, expiredays) {
		var today = new Date();
			today.setDate(today.getDate() + expiredays);

			document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
	}
	function getCookie(name) 
	{ 
		var cName = name + "="; 
		var x = 0; 
		while ( x <= document.cookie.length ) 
		{ 
			var y = (x+cName.length); 
			if ( document.cookie.substring( x, y ) == cName ) 
			{ 
				if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
					endOfCookie = document.cookie.length;
				return unescape( document.cookie.substring( y, endOfCookie ) ); 
			} 
			x = document.cookie.indexOf( " ", x ) + 1; 
			if ( x == 0 ) 
				break; 
		} 
		return ""; 
	}
	/*****## 닫기 ##*****/
	function closeMainPopup(){
		$("#popup").hide();
	}
</script>