<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/skin/default/page/new_goto_page.inc" -->
<%
   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")
%>

<!--<script type="text/javascript" src="/jscript/jquery-1.12.4.min.js"></script>-->
<script type="text/javascript" src="/jscript/jquery.bxslider.min.js"></script>

<style type="text/css">
</style>

<div class="front-section" id="section1">

	<div class="visualWrap">
		<div class="visual_img">
			<div class="visual_content">
				 <img src="http://www.oorione.com/skin/default/img/main/msl1.jpg" alt="" class="msl-img">
				 <div class="msl-caption">
						<div class="msl-caption-tb">
						   <div class="msl-caption-td">
							  <img src="http://www.oorione.com/skin/default/img/main/msl-logo.png" alt="" class="aligncenter">
							  <p>주식회사 우리원커머스는 종합 상품사업과 유익한 정보 제공을 통해 사람들에게 즐거움과 행복을 전해드리고,</p>
							  <p>바른 마음으로 세상을 배려할 수 있는 문화를 만들어 가기 위해 존재합니다.</p>
							  <p>또한, 지속적인 투자와 업무 노하우를 통한 성장과 함께 사회적인 기여를 추구합니다.</p>
						   </div>
						</div>
				 </div>
			</div>
			<div class="visual_content">
				 <img src="http://www.oorione.com/skin/default/img/main/msl2.jpg" alt="" class="msl-img">
				 <div class="msl-caption">
						<div class="msl-caption-tb">
						   <div class="msl-caption-td">
							  <img src="http://www.oorione.com//skin/default/img/main/msl2-logo.png" alt="" class="aligncenter">
							  <p>주식회사 우리원넷은 사람들의 삶에 있어 필요한 모든 것을 플랫폼으로 실현하는 기업으로,</p>
							  <p>고객에게 좀 더 나은 환경과, 풍요로운 가치, 행복한 복지를 이루어 드리기 위해 노력하겠습니다.</p>
							  <p>많은 기업과 함께 나눌 수 있는 비전을 가지고, 고객을 위한 플랫폼을 만들어 나아가겠습니다.</p>
						   </div>
						</div>
				 </div>
			</div>
		</div>
	</div>

   <div class="mouse-icon">
      <div class="wheel"></div>
   </div>

	<script type="text/javascript">
		$(document).ready(function(){
			$(".visual_img").bxSlider({
				mode:"fade",
				auto:true,
				pager: false,
				pause:5000,
				controls:false, 
			});
		});
	</script>

</div>
<div class="front-section" id="company">
	<!-- #include virtual = "/skin/default/page/company.asp" -->
</div>
<div class="front-section" id="about">
	<!-- #include virtual = "/skin/default/page/about.asp" -->
</div>
<div class="front-section" id="careers">
	<!-- #include virtual = "/skin/default/page/careers.asp" -->
</div>
<!--
<div class="front-section" id="service">
</div>
-->
<div class="front-section" id="contact">
	<!-- #include virtual = "/skin/default/page/contact.asp" -->
</div>
<script type="text/javascript">
   $(function(){
		getList2(2);
		getList(1,'<%=TOP_B_SEQ%>');
   })

	function getList2(bc_seq){
		$.ajax({url: "/skin/default/page/getBoardList2.asp",dataType:'html',data:{bc_seq:bc_seq},timeout: 5000,success: function(data){
			$("#employment_list").html(data);
		}});
	}

	function getView2(seq){
		$.ajax({url: "/skin/default/page/getBoardView2.asp",dataType:'html',data:{seq:seq},timeout: 5000,success: function(data){
			$("#notice_view").html(data);
			$("#noticeModal").modal("show");
		}});
	}

	function gotoBoard2(num){
		$.ajax({url: "/skin/default/page/getBoardList2.asp",dataType:'html',data:{page:num,bc_seq:2},timeout: 5000,success: function(data){
			$("#employment_list").html(data);
		}});
	}


	function getList(bc_seq,cut){
		$.ajax({url: "/skin/default/page/getBoardList.asp",dataType:'html',data:{bc_seq:bc_seq,cut:cut},timeout: 5000,success: function(data){
			$("#notice_list").html(data);
		}});
	}

	function getView(seq){
		$.ajax({url: "/skin/default/page/getBoardView.asp",dataType:'html',data:{seq:seq},timeout: 5000,success: function(data){
			$("#notice_view").html(data);
			$("#noticeModal").modal("show");
		}});
	}
	
	// 20.08.20 연혁 관련 인증서 확인용 팝업 띄우기
	function infoView(seq){
		var img = $('#infoimage');
		img.attr('src','');

		//if (seq=="1")
		//{
			//document.getElementById("infoimage").src = "/skin/default/img/sub/Certification_01.jpg"
			//img.attr('src' , '/skin/default/img/sub/Certification_01.jpg')
		//}
		//else if (seq=="2")
		//{
			//document.getElementById("infoimage").src = "/skin/default/img/sub/Certification_02.jpg"
			//img.attr('src' , '/skin/default/img/sub/Certification_02.jpg')
		//}
		//else if (seq=="3")
		//{
			//document.getElementById("infoimage").src = "/skin/default/img/sub/Certification_03.jpg"
			//img.attr('src' , '/skin/default/img/sub/Certification_03.jpg')
		//}
		//else if (seq=="4")
		//{
			//document.getElementById("infoimage").src = "/skin/default/img/sub/Certification_04.jpg"
			//img.attr('src' , '/skin/default/img/sub/Certification_04.jpg')
		//}

		img.attr('src','/skin/default/img/sub/Certification_'+seq+'.jpg')

		$("#info_wrap").modal("show");	
	}
	
	function infoClose(){
		$("#info_wrap").modal("hide");	
	}
	///////////////////////////////////////////////////////

	function CloseView(){
		 $("#notice_view").empty();
		 $("#noticeModal").modal("hide");
	}

	function gotoBoard(num){
		$.ajax({url: "/skin/default/page/getBoardList.asp",dataType:'html',data:{page:num,bc_seq:1,cut:'<%=TOP_B_SEQ%>'},timeout: 5000,success: function(data){
			$("#notice_list").html(data);
		}});
	}
</script>
<%
	Conn.Close
	Set Conn = Nothing
%>