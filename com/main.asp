<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Session.CodePage = 65001
   Response.ChaRset = "utf-8"
%>

<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="utf-8">
<title>우리원</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=yes">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="google-site-verification" content="">
<meta name="naver-site-verification" content="0b9ed21d138cca1f3e3dc621652e544acbf3178d"/>
<meta name="description" content="종합 상품 유통 사업, 신개념 유통 플랫폼 서비스 기업" />
<meta name="keywords" content="종합 상품 유통 사업, 신개념 유통 플랫폼 서비스 기업" />
<meta name="author" content="주식회사 우리원커머스" />
<meta property="og:title" content="우리원커머스" />
<meta property="og:description" content="종합 상품 유통 사업, 신개념 유통 플랫폼 서비스 기업" />

<link rel="shortcut icon" href="/skin/default/img/common/favicon.ico">
<link href="/skin/default/fonts/notosans/style.css" rel="stylesheet">
<link href="/skin/default/css/bootstrap.css" rel="stylesheet">
<link href="/skin/default/css/owl.carousel.css" rel="stylesheet">
<link href="/skin/default/css/flexslider.css" rel="stylesheet">
<link href="/skin/default/css/animate.css" rel="stylesheet">
<link href="/skin/default/css/style.css" rel="stylesheet">
<link href="/skin/default/css/main.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<script src="/exec/js/jquery-2.1.1.min.js"></script>
<script src="/skin/default/js/bootstrap.min.js"></script>
<script src="/skin/default/js/pack.js"></script>
<script src="/skin/default/js/Draggable.min.js"></script>
<script src="/exec/js/scripts.js"></script>
<script type="text/javascript">
<!--
	function fnCeo(a){
		if (a == 1)
		{
			document.getElementById('ceo1').style.display = "";
			document.getElementById('ceo2').style.display = "none";
		}
		if (a == 2)
		{
			document.getElementById('ceo1').style.display = "none";
			document.getElementById('ceo2').style.display = "";
		}
	}
	function fnHistory(a){
		if (a == 1)
		{
			document.getElementById('history1').style.display = "";
			document.getElementById('history2').style.display = "none";
		}
		if (a == 2)
		{
			document.getElementById('history1').style.display = "none";
			document.getElementById('history2').style.display = "";
		}
	}
//-->
</script>
</head>

<body class="main header-fixed">
  <div class="pre-loader">
    <div class="load-con">
      <img src="/skin/default/img/common/logo.png" class="animated fadeInDown" alt="">
      <div class="spinner">
        <div class="bounce1"></div>
        <div class="bounce2"></div>
        <div class="bounce3"></div>
      </div>
    </div>
  </div>
  <div class="wrap">

  <div class="header">
  <div class="main-menu navbar">
    <div class="row no-mar">



      <div class="col-xs-5 col-sm-6 col-md-2 col-lg-3 brand no-pad">
        <h1 class="logo">
          <a href="/" title="주식회사 우리원커머스"><img src="/skin/default/img/common/logo.png" class="" alt="주식회사 우리원커머스" /></a>
        </h1>
      </div>

      <div class="hidden-xs col-xs-12 hidden-sm col-sm-12 col-md-8 col-lg-6 no-pad">
        <div class="gnb_wrap">
          <ul class="gnb nav navbar-nav nav-scroll">

            <li>
               <a href="#company" class="smooth" title="Company">Commerce<br>Familymall</a>
            </li><li>
               <a href="#about" class="smooth" title="About oorione">About oorione</a>
            </li><li>
               <a href="#careers" class="smooth" title="Careers">Careers</a>
            </li>
			<!--<li>
               <a href="#service" class="smooth" title="Service">Service</a>
            </li>-->
			<li>
               <a href="#contact" class="smooth" title="Contact us">Contact us</a>
            </li>

          </ul>
        </div>
      </div>

			<div class="col-xs-7 col-sm-6 col-md-2 col-lg-3 no-pad">
        <div class="top_wrap posi-relative">
				 <!--<a href="http://www.oorionemall.com" title="선물세트전용몰 바로가기" class="shop_link" target="_blank">선물세트전용몰 바로가기</a>-->
         <a class="hamburger hamburger--collapse" id="simple-menu" href="#">
            <div class="hamburger-box">
               <div class="hamburger-inner"></div>
            </div>
         </a>

        </div>
      </div>


    </div>

    <div class="mgnb_wrap">
      <div class="container">
        <ul class="mgnb nav-scroll">
          <li>
            <a href="#company" class="smooth hasChild" title="Company">Commerce<br>/Familymall</a>
            <ul class="dropdown-menu">
               <li><a href="#company1" class="smooth_li" title="경영이념">경영이념</a></li>
               <li><a href="#company2" class="smooth_li" title="미션 및 비전">미션 및 비전</a></li>
               <li><a href="#company3" class="smooth_li" title="ceo인사말">ceo인사말</a></li>
               <li><a href="#company4" class="smooth_li" title="연혁">연혁</a></li>
               <li><a href="#company5" class="smooth_li" title="조직 및 업무소개">조직 및 업무소개</a></li>
               <li><a href="#company6" class="smooth_li" title="CI소개">CI소개</a></li>
            </ul>
         </li><li>
            <a href="#about" class="smooth hasChild" title="About oorione">About oorione</a>
            <ul class="dropdown-menu">
               <li><a href="#about1" class="smooth" title="업무개요">업무개요</a></li>
               <li><a href="#about2" class="smooth" title="사업분야">사업분야</a></li>
            </ul>
         </li><li>
            <a href="#careers" class="smooth hasChild" title="Careers">Careers</a>
            <ul class="dropdown-menu">
               <li><a href="#careers1" class="smooth_li" title="인재상">인재상</a></li>
               <li><a href="#careers2" class="smooth_li" title="채용공고">채용공고</a></li>
            </ul>
         </li>
		 <!--
		 <li>
            <a href="#service" class="smooth" title="Service">Service</a>
         </li>
		 //-->
		 <li>
            <a href="#contact" class="smooth hasChild " title="Contact us">Contact us</a>
            <ul class="dropdown-menu">
               <li><a href="#contact1" class="smooth_li" title="공지사항">공지사항</a></li>
               <li><a href="#contact2" class="smooth_li" title="오시는 길">오시는 길</a></li>
            </ul>
         </li>
        </ul>
      </div>
    </div>
  </div>
</div>
<div class="front-section" id="section1">
	<div class="owl-carousel" id="slider1">
		<div class="item">
			<img src="/skin/default/img/main/msl1.jpg" alt="" class="msl-img">
         <div class="msl-caption">
            <div class="msl-caption-tb">
               <div class="msl-caption-td">
                  <img src="/skin/default/img/main/msl-logo.png" alt="" class="aligncenter">
                  <p>주식회사 우리원커머스는 종합 상품사업과 유익한 정보 제공을 통해 사람들에게 즐거움과 행복을 전해드리고,<br>바른 마음으로 세상을 배려할 수 있는 문화를 만들어 가기 위해 존재합니다.<br>또한, 지속적인 투자와 업무 노하우를 통한 성장과 함께 사회적인 기여를 추구합니다.</p>
               </div>
            </div>
         </div>
		</div>
	</div>
   <div class="mouse-icon">
      <div class="wheel"></div>
   </div>
</div>
<div class="front-section" id="company">
	<div class="container">
	<h2 class="section-title">Commerce/Familymall</h2>
	<div role="tabpanel">
		<!-- Nav tabs -->
		<ul class="nav nav-tabs company-tabs" role="tablist" id="companyTabs">
			<li role="presentation" class="color1 active"><a href="#company1" aria-controls="company1" role="tab" data-toggle="tab"><span class="hidden-xxs">경영이념</span><span class="visible-xxs">경영<br>이념</span></a></li>
			<li role="presentation" class="color2"><a href="#company2" aria-controls="company2" role="tab" data-toggle="tab"><span class="hidden-xxs">미션 및 비전</span><span class="visible-xxs">미션 및<br>비전</span></a></li>
			<li role="presentation" class="color3"><a href="#company3" aria-controls="company3" role="tab" data-toggle="tab"><span class="hidden-xxs">ceo인사말</span><span class="visible-xxs">ceo<br>인사말</span></a></li>
			<li role="presentation" class="color1"><a href="#company4" aria-controls="company4" role="tab" data-toggle="tab">연혁</a></li>
			<li role="presentation" class="color2"><a href="#company5" aria-controls="company5" role="tab" data-toggle="tab"><span class="hidden-xxs">조직 및 업무소개</span><span class="visible-xxs">조직 및<br>업무소개</span></a></li>
			<li role="presentation" class="color3"><a href="#company6" aria-controls="company6" role="tab" data-toggle="tab"><span class="hidden-xxs">CI소개</span><span class="visible-xxs">CI<br>소개</span></a></li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content">
			<!---1------------------------------------------------------------------------------------------------------->
			<div role="tabpanel" class="tab-pane active" id="company1">
				<h3 class="sub-title"><span class="cyan">우리원</span>의 문화</h3>
				<div class="company1-cont">
					<div class="company1-inner row">
						<div class="company1-cols col-xs-4 col-md-4">
							<div class="company1-circle">
								<p class="companyP1">바른마음</p>
								<p class="companyP2">Mind</p>
							</div>
							<p class="companyP3">고객, 협력업체, 사회와 더불어 우리 모두가 성장해 나아갈 수 있는 회사</p>
						</div>
						<div class="company1-cols col-xs-4 col-md-4">
							<div class="company1-circle">
								<p class="companyP1">행복추구</p>
								<p class="companyP2">Happiness</p>
							</div>
							<p class="companyP3">고객이 만족하고 직원도 보람을 찾아 모두가 행복해 질 수 있는 일을 만드는 회사</p>
						</div>
						<div class="company1-cols col-xs-4 col-md-4">
							<div class="company1-circle">
								<p class="companyP1">상호배려</p>
								<p class="companyP2">Kindness</p>
							</div>
							<p class="companyP3">모든 상대방의 입장을 먼저 이해하고 배려하려는 문화를 만들어 가는 회사</p>
						</div>
					</div>
				</div>
			</div>
			<!---2------------------------------------------------------------------------------------------------------->
			<div role="tabpanel" class="tab-pane" id="company2">
				<h3 class="sub-title">SUSTAINABLE GROWTH</h3>
				<p class="sub-desc"><span class="cyan">우리원커머스</span>는 지속 가능한 경영을 통해 사람과 사회, 기업이 공존하는 문화를 만들고자 합니다.<br>변화를 선도하고 끊임없이 도전하며 이를 이루기 위한 열정을 가지고 노력함으로써 지속적인 성장이 가능한 기업을 추구하고자 합니다.</p>
				<h4 class="sm-title">MISSION</h4>
				<div class="company2-cont">
					<div class="company2-circle">
						<div class="row">
							<div class="col-xs-offset-3 col-xs-6 col-sm-offset-0 col-sm-4 col-md-offset-0 col-md-4">
								<div class="company2-cell">
									<p class="companyP4"><span class="hidden-xxs">혁신적인 마인드 지향</span><span class="visible-xxs">혁신적인 마인드<br>지향</span></p>
									<p class="companyP5">현실에 안주하지 않고 변화를 <br class="hidden-xs">예측하고 선도할 수 있는 기업</p>
								</div>
							</div>
							<div class="col-xs-6 col-sm-4 col-md-4">
								<div class="company2-cell">
									<p class="companyP4"><span class="hidden-xxs">고객을 우선하는 마음</span><span class="visible-xxs">고객을 우선하는<br>마음</span></p>
									<p class="companyP5">고객은 물론 협력사, 내부 직원들을 <br class="hidden-xs">최우선으로 하며, 모두의 <br class="hidden-xs">행복을 추구하는 정책 운영</p>
								</div>
							</div>
							<div class="col-xs-6 col-sm-4 col-md-4">
								<div class="company2-cell">
									<p class="companyP4"><span class="hidden-xxs">사회를 위한 나눔</span><span class="visible-xxs">사회를 위한<br>나눔</span></p>
									<p class="companyP5">판매금액의 0.5%를 사회에 기부하는 나눔 소비 프로젝트의 실천</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!---3------------------------------------------------------------------------------------------------------->
			<div role="tabpanel" class="tab-pane" id="company3">
				<div style="width:100%;">
					<div style="float:left;width:50%;text-align:center;font-size:28px;font-weight:700;"><span onclick="fnCeo('1');" style="cursor:pointer;">CEO 인사말</span></div>
					<div style="float:left;width:50%;text-align:center;font-size:28px;font-weight:700;"><span onclick="fnCeo('2');" style="cursor:pointer;">회장 인사말</span></div>
				</div>
				<div style="clear:both;width:100%;height:20px;"></div>
				<div class="ceo1" id="ceo1">
					<h3 class="sub-title">CEO 인사말</h3>
					<div class="row">
						<div class="col-xs-12 col-sm-push-5 col-sm-7 col-md-push-4 col-md-8">
							<div class="ceo-text-cont">
								<p class="companyP6">안녕하십니까<br><span class="cyan">우리원커머스</span> 대표이사 서연태입니다.</p>
								<p class="companyP7">우리원커머스는 유통시장이 Off-line에서 On-line으로 중심축이 이동하고 있는 상황에서  창의적이고 혁신적이며 새로운 유통 Format의 창조를 추구하고 있는 기업입니다. 오랫동안 쌓아온 Off-line 유통의 경험과 노하우를 On-line System에 접목시킴으로써 새로운 유형의 On-line Flatform 망을 구축하고자 합니다. 그렇다고 Off-line은 결코 구세대의 유통이 아니며, 유통사업의 본질은 On-line과 Off-line의 특징을 정확히 이해하고 대응하여 궁극적으로 고객에게 만족을 드리고자 하는 것임에는 다를 바가 없다고 생각합니다.</p>
								<p class="companyP7">우리원커머스의 존재 이유는 바로 고객들에게 만족과 행복을 드리기 위함이며, 이는 끊임없이 변모하는 유통환경에서 새롭고 창의적인 아이디어와 이를 구현하려는 불굴의 열정이 있기 때문입니다. 수십 년간 다져진 업무 노하우와 경험을 바탕으로 많은 협력 회사와 열정적인 임직원 여러분과 함께 Mission impossible을 실현 해냄으로써 사회적 책임을 다하는 기업으로 발전해 나아가고자 합니다. </p>
								<p class="companyP7">우리원커머스의 성장을 위해 아낌없는 사랑과 격려를 부탁드립니다.</p>
								<p class="companyP7 mb00">감사합니다. </p>
								<p class="companyP7 text-right">우리원커머스, 우리원패밀리몰 대표이사<br><img src="/skin/default/img/sub/ceo2.png" alt="" class="inline-block"></p>
							</div>
						</div>
						<div class="col-xs-12 col-sm-pull-7 col-sm-5 col-md-pull-8 col-md-4">
							<div class="ceo-img-cont">
								<img src="/skin/default/img/sub/ceo1.jpg" alt="" class="aligncenter">
							</div>
						</div>
					</div>
				</div>
				<div class="ceo2" id="ceo2" style="display:none;">
					<h3 class="sub-title">회장 인사말</h3>
					<div class="row">
						<div class="col-xs-12 col-sm-push-5 col-sm-7 col-md-push-4 col-md-8">
							<div class="ceo-text-cont">
								<p class="companyP6">안녕하십니까<br><span class="cyan">경영자문</span> 이수철 입니다.</p>
								<p class="companyP7">유통 비즈니스는 급변하고 있습니다. 불과 십여 년 전만해도 오프라인 영역을 벗어나서 생각할 수 없었지만, 지금은 온라인이라는 새로운 네트워크로 그 중심이 옮겨가고 있습니다.</p>
								<p class="companyP7">라인에서 무선으로, PC에서 모바일로, 2D에서 3D, 4D의 기술이 유통과 결합하여 우리의 삶을 더욱 편리하고 풍요롭게 하고 있습니다..</p>
								<p class="companyP7">이에 우리원은 고객 중심의 생각으로 단순한 유통 쇼핑몰 사업이 아닌, 좀 더 폭넓은 영역의 컨텐츠와 다양한 서비스, 우수한 상품을 제공할 수 있는 플랫폼 중심의 기업이 될 것입니다..</p>
								<p class="companyP7">이는 B2B의 기업고객을 넘어, B2C의 회원분들도 이용할 수 있도록 기술적으로, 운영적으로도 끊임없이 노력하는 회사가 될 것입니다..</p>
								<p class="companyP7">새로운 패러다임과 소비자 Needs에 맞는 트랜드를 리딩하는 기업으로 성장할 수 있도록 많은 관심 부탁드립니다..</p>
								<p class="companyP7 mb00">감사합니다. </p>
								<p class="companyP7 text-right">우리원 회장 이수철<br></p>
							</div>
						</div>
						<div class="col-xs-12 col-sm-pull-7 col-sm-5 col-md-pull-8 col-md-4">
							<div class="ceo-img-cont">
								<img src="/skin/default/img/sub/ceo2.jpg" alt="" class="aligncenter">
							</div>
						</div>
					</div>
				</div>			</div>
			<!---4------------------------------------------------------------------------------------------------------->
			<div role="tabpanel" class="tab-pane" id="company4">
				<div style="width:100%;">
					<div style="float:left;width:50%;text-align:center;font-size:28px;font-weight:700;"><span onclick="fnHistory('1');" style="cursor:pointer;">우리원커머스</span></div>
					<div style="float:left;width:50%;text-align:center;font-size:28px;font-weight:700;"><span onclick="fnHistory('2');" style="cursor:pointer;">우리원패밀리몰</span></div>
				</div>
				<div style="clear:both;width:100%;height:20px;"></div>

				<div id="history1">
					<h3 class="sub-title">연혁</h3>
					<div class="history-cont">
						<ul class="historyUl">
							<li class="history-section">
								<div class="history-badge"></div>
								<div class="history-pannel">
									<div class="history-year">2019</div>
									<div class="history-context">
										<div class="history-text">GS리테일 상품공급 계약 체결<span class="month">01</span></div>
									</div>
								</div>
							</li>
							<li class="history-section history-right">
								<div class="history-badge"></div>
								<div class="history-pannel">
									<div class="history-year">2018</div>
									<div class="history-context">
										<div class="history-text"><span class="month">10</span>MRO 전문몰 아이마켓몰 상품공급 계약체결</div>
										<div class="history-text"><span class="month">08</span>LG 임직원복지몰 상품공급계약 체결</div>
										<div class="history-text"><span class="month">08</span>LG CNS(LG그룹 복지몰) 벤더 계약 체결</div>
										<div class="history-text"><span class="month">08</span>현대 H&S 벤더 계약 체결</div>
										<div class="history-text"><span class="month">07</span>롯데닷컴 벤더 계약 체결</div>
										<div class="history-text"><span class="month">02</span>아시아나 임직원몰 상품공급 계약 체결</div>
										<div class="history-text"><span class="month">01</span>AJ전시몰 상품공급 계약 체결</div>
									</div>
								</div>
							</li>
							<li class="history-section">
								<div class="history-badge"></div>
								<div class="history-pannel">
									<div class="history-year">2017</div>
									<div class="history-context">
										<div class="history-text">중소벤처기업부의 Main-Biz(경영혁신형중소기업) 인증 기업 선정<span class="month">12</span></div>
										<div class="history-text">이지웰페어 벤더 계약 체결<span class="month">11</span></div>
										<div class="history-text">한국비앤시 벤더 계약 체결<span class="month">08</span></div>
										<div class="history-text">KT커머스 I bene몰 벤더 계약 체결<span class="month">07</span></div>
										<div class="history-text">중소벤처기업부의 INOBIZ(기술혁신형중소기업) 인증 기업 선정<span class="month">05</span></div>
									</div>
								</div>
							</li>
							<li class="history-section history-right">
								<div class="history-badge"></div>
								<div class="history-pannel">
									<div class="history-year">2016</div>
									<div class="history-context">
										<div class="history-text"><span class="month">12</span>On-Line System 개발 연구소 설립</div>
										<div class="history-text"><span class="month">09</span>Total System Platform 구축 개시</div>
										<div class="history-text"><span class="month">03</span>동부그룹 임직원몰 운영 개시</div>

									</div>
								</div>
							</li>
							<li class="history-section">
								<div class="history-badge"></div>
								<div class="history-pannel">
									<div class="history-year">2015</div>
									<div class="history-context">
									    <div class="history-text">공무원 복지몰 벤더 계약 체결<span class="month">12</span></div>
										<div class="history-text">삼성카드 쇼핑몰 벤더 계약 체결<span class="month">11</span></div>
										<div class="history-text">우리원몰 오픈<span class="month">08</span></div>
									</div>
								</div>
							</li>
							<li class="history-section history-right">
								<div class="history-badge"></div>
								<div class="history-pannel">
									<div class="history-year">2014</div>
									<div class="history-context">
										<div class="history-text"><span class="month">10</span>삼성그룹 임직원 복지몰 벤더 계약 체결</div>
										<div class="history-text"><span class="month">08</span>㈜우리원커머스 설립<br>전자상거래업 / 종합 상품 유통업 / 소프트웨어 개발 및 공급업</div>
									</div>
								</div>
							</li>
						
						</ul>
					</div>
				</div>

				<div id="history2">
					<h3 class="sub-title">연혁</h3>
					<div class="history-cont">
						<ul class="historyUl">
							<li class="history-section">
								<div class="history-badge"></div>
								<div class="history-pannel">
									<div class="history-year">2019</div>
									<div class="history-context">
										<div class="history-text">KBIZ 강소 기업 복지몰 OPEN<span class="month">01</span></div>
										<div class="history-text">제 201911023호 기업부설연구소 인정<span class="month">01</span></div>
										<div class="history-text">리얼야구존 업무 제휴<span class="month">01</span></div>
										<div class="history-text">클립서비스 업무 제휴<span class="month">01</span></div>
										<div class="history-text">제주닷컴 업무 제휴<span class="month">01</span></div>
									</div>
								</div>
							</li>
							<li class="history-section history-right">
								<div class="history-badge"></div>
								<div class="history-pannel">
									<div class="history-year">2018</div>
									<div class="history-context">
										<div class="history-text"><span class="month">12</span>하나투어 업무 제휴</div>
										<div class="history-text"><span class="month">12</span>OK 검진 업무 제휴</div>
										<div class="history-text"><span class="month">11</span>여행스케치 업무 제휴</div>
										<div class="history-text"><span class="month">11</span>컬투플라워 업무 제휴</div>
										<div class="history-text"><span class="month">10</span>컨텐츠(무형서비스) ASP 플랫폼 개발</div>
										<div class="history-text"><span class="month">09</span>기업 전용 특판몰 리뉴얼 OPEN(oorionemall.com)</div>
										<div class="history-text"><span class="month">06</span>이지웰페어 업무 제휴 계약 체결</div>
										<div class="history-text"><span class="month">04</span>이제너두 DB그룹 임직원 쇼핑몰 운영 계약</div>
										<div class="history-text"><span class="month">04</span>LG  그룹 선택적 복리후생사업을 위한 양해 각서 체결</div>
										<div class="history-text"><span class="month">01</span>선물세트 전용몰 ‘우리원몰‘ 오픈</div>
									</div>
								</div>
							</li>
							<li class="history-section">
								<div class="history-badge"></div>
								<div class="history-pannel">
									<div class="history-year">2017</div>
									<div class="history-context">
										<div class="history-text">Total System Platform 구축 완료<span class="month">10</span></div>
									</div>
								</div>
							</li>
							<li class="history-section history-right">
								<div class="history-badge"></div>
								<div class="history-pannel">
									<div class="history-year">2016</div>
									<div class="history-context">
										<div class="history-text"><span class="month">09</span>Total System Platform 구축 개시</div>
										<div class="history-text"><span class="month">08</span>㈜우리원패밀리몰 설립</div>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</div>

			</div>
			<!---5------------------------------------------------------------------------------------------------------->
			<div role="tabpanel" class="tab-pane" id="company5">
            <h3 class="sub-title">조직 및 업무 소개</h3>
            <img src="/skin/default/img/sub/company5.png" alt="" class="aligncenter" />
			</div>
			<!---6------------------------------------------------------------------------------------------------------->
			<div role="tabpanel" class="tab-pane" id="company6">
				<h3 class="sub-title">CI 소개</h3>
				<div class="row no-mar">
					<div class="col-xs-12 col-sm-6 col-md-6 no-pad">
						<div class="ci-cont">
							<div class="ci-cont-td">
								<img src="/skin/default/img/sub/company6-img1.png" alt="우리원커머스" class="aligncenter maw80" />
							</div>

						</div>
					</div>
					<div class="col-xs-12 col-sm-6 col-md-6 no-pad">
						<div class="box445">
							<p class="ciP1">우리원커머스의 CI는 <span class="w400">'함께'</span>와<br><span class="w400">'하나'</span> 무한한 <span class="w400">'소통과 성장'</span> 을 의미합니다.</p>
							<p class="ciP2">차별화한 영문표기와 원형의 반복 배열, 곡선이 강조된 로고를 통해 종합유통기업의 아이덴티티를 상징합니다.</p>
							<a href="/exec/file/download.asp?filepath=/skin/default/img/sub&filename=oorioneCI.jpg" title="JPG 다운로드" class="borderBt hoverBt"><img src="/skin/default/img/sub/borderBt.png" alt="" class="inline-block" /> JPG 다운로드</a> &nbsp;<a href="/exec/file/download.asp?filepath=/skin/default/img/sub&filename=CI.ai" title="AI 다운로드" class="borderBt hoverBt"><img src="/skin/default/img/sub/borderBt.png" alt="" class="inline-block" /> AI 다운로드</a>
						</div>
					</div>
				</div>
				<div class="clear pt70"></div>

				<div class="row mlmr6">
					<div class="col-xs-6 col-sm-4 col-md-4 pad6">
						<h4 class="ci-title">Main</h4>
						<div class="ci-cont bg-check md-mb70">
							<div class="ci-cont-td">
								<img src="/skin/default/img/sub/company6-img2.png" alt="우리원커머스" class="aligncenter maw80 xsh95" />
							</div>
						</div>
					</div>
					<div class="col-xs-6 col-sm-4 col-md-4 pad6">
						<h4 class="ci-title">Sub</h4>
						<div class="ci-cont bg-check md-mb70">
							<div class="ci-cont-td">
								<img src="/skin/default/img/sub/company6-img3.png" alt="우리원커머스" class="aligncenter maw80 xsh95" />
							</div>
						</div>
					</div>
					<div class="col-xs-6 col-sm-4 col-md-4 pad6">
						<h4 class="ci-title">국영문조합</h4>
						<div class="ci-cont bg-check md-mb70">
							<div class="ci-cont-td">
								<img src="/skin/default/img/sub/company6-img4.png" alt="우리원커머스" class="aligncenter maw80 xsh95" />
							</div>
						</div>
					</div>

				</div>
				<div class="row mlmr6">
					<div class="col-xs-12 col-sm-8 col-md-8 pad6">
						<h4 class="ci-title">Background Color</h4>
						<div class="row mlmr6">
							<div class="col-xs-6 col-sm-6 col-md-6 pad6">
								<div class="ci-cont bg-cyan bd-cyan md-mb70">
									<div class="ci-cont-td">
										<img src="/skin/default/img/sub/company6-img5.png" alt="우리원커머스" class="aligncenter maw80 xsh95" />
									</div>
								</div>
							</div>
							<div class="col-xs-6 col-sm-6 col-md-6 pad6">
								<div class="ci-cont bd-cyan md-mb70">
									<div class="ci-cont-td">
										<img src="/skin/default/img/sub/company6-img6.png" alt="우리원커머스" class="aligncenter maw80 xsh95" />
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-6 col-sm-4 col-md-4 pad6">
						<h4 class="ci-title">Main Color</h4>
						<div class="ci-cont bg-cyan bd-cyan md-mb70">
							<div class="ci-cont-td">
								<p class="ci-contP1">PANTONE P 123-7C<br>CMYK 83 / 0 / 24 / 41</p>
							</div>
						</div>
					</div>
				</div>

				<p class="ciP3">㈜ 우리원커머스는 C.I의 불법적인 도용 및 무단 사용을 금지합니다.<br>각종 매체에 적용 시 변형과 왜곡, 임의 수정은 불가하며 정해진 색상 규정을 준수하여야 합니다.</p>
			</div>
		</div>
	</div>
</div>

</div>
<div class="front-section" id="about">
	<div class="sub-section parallax" id="about1">
   <div class="section31-tb">
      <div class="section31-td">
         <h2 class="section-title white">ABOUT &nbsp;<img src="/skin/default/img/sub/logo_white.png" alt="" class="inline-block"></h2>
         <p class="sub-desc white mb00">우리원커머스는 우수한 상품 개발 및 소싱 노하우를 기반으로 합리적인 쇼핑과 <br class="hidden-xxs">다양한 즐거움을 느낄 수 있는 서비스를 제공하기 위해 독창적인 기술과 아이디어를 접목한 <br class="hidden-xxs">종합 유통 플랫폼 서비스를 만들고자 합니다.</p>
      </div>
   </div>
</div>
<div class="sub-section" id="about2">
   <div class="container">
      <h3 class="sub-title">사업분야</h3>
      <img src="/skin/default/img/sub/about-img01.png" alt="" class="aligncenter hidden-xs" />
      <img src="/skin/default/img/sub/about-img02.png" alt="" class="aligncenter visible-xs" />
   </div>

</div>
<div class="sub-section" id="about3">
	<div class="container">
		<h3 class="sub-title">대표 협력사 및 제휴사</h3>
		<div class="row mlmr6">
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img03.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img04.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img05.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img06.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img07.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img08.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img09.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img10.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img11.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img12.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img13.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img14.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img15.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img16.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img17.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img18.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img19.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img20.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img21.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img22.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img23.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img24.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img25.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img26.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img27.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img28.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img29.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img30.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img31.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img32.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img33.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img34.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img35.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img36.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img37.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img38.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img39.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img40.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img41.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img42.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img43.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img44.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img45.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img46.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img47.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img48.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img49.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-sm-3 col-md-2 pad6 section33-item">
				<div class="section33-inner">
					<div class="section33-td">
						<img src="/skin/default/img/sub/about-img50.png" alt="" class="section33-img" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<div class="front-section" id="careers">
	
<div class="container beforeLogo">
	<h2 class="section-title">CAREERS</h2>
   <div role="tabpanel">
		<!-- Nav tabs -->
		<ul class="nav nav-tabs main-tabs" role="tablist" id="careersTabs">
			<li role="presentation" class="active"><a href="#careers1" aria-controls="careers1" role="tab" data-toggle="tab">인재상</a></li>
			<li role="presentation"><a href="#careers2" aria-controls="careers2" role="tab" data-toggle="tab">채용공고</a></li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content">
			<!---1------------------------------------------------------------------------------------------------------->
			<div role="tabpanel" class="tab-pane active" id="careers1">
				<div class="career-cont1">
					<div class="career-cont-td">
						<div class="career-cont-inner">
							<h3 class="career-title">우리원커머스와 함께 성장할<br>인재들을 찾고 있습니다. </h3>
							<p class="careerP1">회사와 지속적인 발전을 함께 할 수 있는 창의적이고 도전하는 인재, 배려할 줄 아는 인재, <br class="hidden-xs" />신뢰할 수 있는 인재를 중요하게 생각합니다. </p>
							<div class="box635">
								<div class="row mlmr6">
									<div class="col-xs-4 col-sm-4 col-md-4 pad6 career1-item">
										<div class="career1-inner career11">
											<div class="career1-td">창의적이고<br>도전하는 인재</div>
										</div>
									</div>
									<div class="col-xs-4 col-sm-4 col-md-4 pad6 career1-item">
										<div class="career1-inner  career12">
											<div class="career1-td">배려할 줄 아는<br>인재</div>
										</div>
									</div>
									<div class="col-xs-4 col-sm-4 col-md-4 pad6 career1-item">
										<div class="career1-inner career13">
											<div class="career1-td">신뢰받는<br>인재</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="clear pt50"></div>

				<h3 class="sub-title">복지제도</h3>
				<div class="career-cont2">
					<div class="row no-mar">
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img05.png" alt="" class="career-img" />
								<p class="welfareP1">4대보험</p>
								<p class="welfareP2">국민연금, 고용보험<br>산재보험, 건강보험</p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img06.png" alt="" class="career-img" />
								<p class="welfareP1">급여제도</p>
								<p class="welfareP2">연봉제, 인센티브제<br>, 퇴직금</p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img07.png" alt="" class="career-img" />
								<p class="welfareP1">수당제도</p>
								<p class="welfareP2">연장근로수당, 육아수당<br>, 자가운전보조금</p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img08.png" alt="" class="career-img" />
								<p class="welfareP1">회사 분위기</p>
								<p class="welfareP2">인재육성중시, 초고속승진가능, <br class="hidden-xxs">자율복장, 탄력시간근무제, 재택근무제</p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img09.png" alt="" class="career-img" />
								<p class="welfareP1">명절/기념일</p>
								<p class="welfareP2">복지포인트 지급</p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img10.png" alt="" class="career-img" />
								<p class="welfareP1">식사관련</p>
								<p class="welfareP2">냉장고/전자레인지<br>간식/음료 무한제공</p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img11.png" alt="" class="career-img" />
								<p class="welfareP1">지급품</p>
								<p class="welfareP2">PC, 노트북, 개인직통전화</p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img12.png" alt="" class="career-img" />
								<p class="welfareP1">교육/훈련</p>
								<p class="welfareP2">신입사원교육(OJT), 직무능력향상교육 </p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img13.png" alt="" class="career-img" />
								<p class="welfareP1">휴일/휴가</p>
								<p class="welfareP2"> 연차/반차.정기.경조휴가<br class="hidden-xxs">노동절/징검다리휴무<br class="hidden-xxs">출산/육아 휴직</p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img14.png" alt="" class="career-img" />
								<p class="welfareP1">회사행사</p>
								<p class="welfareP2">워크샵, 단합대회, MT</p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img15.png" alt="" class="career-img" />
								<p class="welfareP1">역량개발교육시행</p>
								<p class="welfareP2">직무관련외부교육</p>
							</div>
						</div>
						<div class="col-xs-6 col-sm-4 col-md-3 welfare-item no-pad">
							<div class="welfare-inner">
								<img src="/skin/default/img/sub/career-img16.png" alt="" class="career-img" />
								<p class="welfareP1">장기근속포상</p>
							</div>
						</div>
					</div>
				</div>
         </div>
			<!---2------------------------------------------------------------------------------------------------------->
			<div role="tabpanel" class="tab-pane" id="careers2">
				<div class="career-cont3">
					<h3 class="sub-title white">채용프로세스</h3>
					<img src="/skin/default/img/sub/process-img01.png" alt="" class="process-img hidden-xxs" />
					<img src="/skin/default/img/sub/process-arrow.png" alt="" class="process-arrow hidden-xxs" />
					<img src="/skin/default/img/sub/process-img02.png" alt="" class="process-img hidden-xxs" />
					<img src="/skin/default/img/sub/process-arrow.png" alt="" class="process-arrow hidden-xxs" />
					<img src="/skin/default/img/sub/process-img03.png" alt="" class="process-img hidden-xxs" />
					<img src="/skin/default/img/sub/process-arrow.png" alt="" class="process-arrow hidden-xxs" />
					<img src="/skin/default/img/sub/process-img04.png" alt="" class="process-img hidden-xxs" />
					<img src="/skin/default/img/sub/process-arrow.png" alt="" class="process-arrow hidden-xxs" />
					<img src="/skin/default/img/sub/process-img05.png" alt="" class="process-img hidden-xxs" />
					<img src="/skin/default/img/sub/process-img06.png" alt="" class="visible-xxs aligncenter" />
				</div>

				<div class="clear pt50"></div>
				<h3 class="sub-title">채용공고</h3>
				<div id="employment_list">
				</div>
			</div>
		</div>
	</div>
</div>
</div><!--
<div class="front-section" id="service">

</div>-->
<div class="front-section" id="contact">
<%
'	AIzaSyCySi8lC4zXEXzNvHWL9HdogQ1_tnUnSCw ---- 구글계정 모름
%>	
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCySi8lC4zXEXzNvHWL9HdogQ1_tnUnSCw"></script>
<div class="container">
	<h2 class="section-title">CONTACT US</h2>
	<!-- Nav tabs -->
	<ul class="nav nav-tabs main-tabs" role="tablist" id="contactTabs">
		<li role="presentation"><a href="#contact1" aria-controls="contact1" role="tab" data-toggle="tab" class="contactLink1">회사동향</a></li>
		<li role="presentation" class="active"><a href="#contact2" aria-controls="contact2" role="tab" data-toggle="tab" class="contactLink2">오시는길</a></li>
	</ul>
</div>
<div class="tab-content">
	<!---1------------------------------------------------------------------------------------------------------->
	<div role="tabpanel" class="tab-pane" id="contact1">
		<div class="container">
			<div class="flexslider noticeSlider">
				<ul class="slides">
				
					<li>
						<div class="notice-slide">
							<div class="row">
								<div class="col-xxs-12 col-xs-6 col-sm-5 col-md-4 col-lg-3">
									<a class="modalTrigger notice-img-cont" title="(주)우리원커머스 사옥 이전 공지" href="#" onclick="getView(30);return false;" data-toggle="modal" data-target="#noticeModal">
										
											<img src="/skin/default/img/sub/notice-img1.png" alt="(주)우리원커머스 사옥 이전 공지" class="notice-img">
										
									</a>
								</div>
								<div class="col-xxs-12 col-xs-6 col-sm-7 col-md-8 col-lg-9">
									<a class="modalTrigger notice-caption" title="" href="#" onclick="getView(30);return false;">
										<div class="notice-title">(주)우리원커머스 사옥 이전 공지</div>
										<div class="notice-desc">[(주)우리원커머스 사옥 이전 공지]

*
*

(주)우리원커머스가2018년6월4일(월)에 사무실을
아래 주소로확장이전 하여 업무을 진행하고 있음을 알려드립니다.




서울특별시 금천구 가산디지털1로 181(가산동 371-106) 가산 W CENTER 1709, 1710호







핵심업무를 보다 효율적이고 집중적으로 처리 할 수 있도록 하기 위함이며,
종합 유통 플랫폼 서비스를 만들어 가는데 더욱 최선을 다하겠습니다.

앞으로도 변함없는 성원과 격려 부탁드립니다.</div>
									</a>
								</div>
							</div>
						</div>
					</li>
					<!--
					<li>
						<div class="notice-slide">
							<div class="row">
								<div class="col-xxs-12 col-xs-6 col-sm-5 col-md-4 col-lg-3">
									<a class="modalTrigger notice-img-cont" title="" href="" data-toggle="modal" data-target="#noticeModal">
										<img src="/skin/default/img/sub/notice-img1.png" alt="" class="notice-img">
									</a>
								</div>
								<div class="col-xxs-12 col-xs-6 col-sm-7 col-md-8 col-lg-9">
									<a class="modalTrigger notice-caption" title="" href="" data-toggle="modal" data-target="#noticeModal">
										<div class="notice-title">우리원커머스, 오픈마켓 최초 일 거래액 '200억' 돌파</div>
										<div class="notice-desc">온라인 쇼핑몰 우리원커머스의 일 거래액이 200억원을 넘어섰다.<br>소셜커머스 업계에서 일 거래액 200억원을 넘어선 것은 위메프가 처음이다. 우리원커머스의 공격적인 프로모션이 이어지며 업계 1위의 거래액을 역전할 수 있다는 분석도 나온다. 우리원커머스 관계자는 “역대 일 거래액 최고치를 경신했다는 점에서 고무적“이라며 “특가 행사를 이어가 소비자에게 인지도와 존재감을 확실히 각인시키겠다”고 말했다.</div>
									</a>
								</div>
							</div>
						</div>
					</li>
					-->
				</ul>
			</div>
			<div class="clear pt60"></div>
			<div id="notice_list"></div>
		</div>
	</div>
	<!---2------------------------------------------------------------------------------------------------------->
	<div role="tabpanel" class="tab-pane active" id="contact2">
		<div class="row no-mar">
			<div class="col-xs-12 col-sm-6 col-md-6 no-pad contact21">
				<div class="gmaps" id="map_canvas"></div>
			</div>
			<div class="col-xs-12 col-sm-6 col-md-6 no-pad contact22">
				<div class="contact22-tb">
					<div class="contact22-td">
						<h3 class="contactH31">(주)우리원커머스</h3>
						<p class="contactP1">
							<span class="w400">ADDRESS</span>
                     <br>서울특별시 금천구 가산디지털1로 181<br>(가산동 371-106) 가산 W CENTER 1709, 1710호<br>
                  </p>
                  <p class="contactP1">
                     <span class="w400">PARTNERSHIP INFO.....</span>
                     <br>상품판매 및 입점 문의 : 02.6268.8106
                     <a href="mailto:oorionemd@oorione.com" title="상품판매 및 입점 문의">oorionemd@oorione.com <span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                     <br>마케팅 및 홍보 문의 : 02.6268.8109
                     <a href="mailto:marketing@oorione.com" title="마케팅 및 홍보 문의">marketing@oorione.com <span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                     <br>일반 문의 : 02.6268.8100
                     <a href="mailto:oorione@oorione.com" title="일반 문의">oorione@oorione.com <span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
						</p>
                  <p class="contactP1">
                     <span class="w400">FAX</span> &nbsp;02. 6268. 8104<br>
                  </p>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<script type="text/javascript">
   $(function(){
		getList2(2);
		getList(1,'30');
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

	function CloseView(){
		 $("#notice_view").empty();
		 $("#noticeModal").modal("hide");
	}

	function gotoBoard(num){
		$.ajax({url: "/skin/default/page/getBoardList.asp",dataType:'html',data:{page:num,bc_seq:1,cut:'30'},timeout: 5000,success: function(data){
			$("#notice_list").html(data);
		}});
	}
</script>
<footer>
	<div class="footer">
		<div class="clear pb30"></div>
		<div class="container">
			<a href="/" title="주식회사 우리원커머스" class="footerLogo hoverBt">
				<img alt="주식회사 우리원커머스" src="/skin/default/img/common/logo.png" class="img-responsive" />
			</a>
			<p class="copyrights1">㈜우리원커머스     서울특별시 금천구 가산디지털1로 181 (가산동 371-106) 가산 W CENTER 1709, 1710호</p>
			<p class="copyrights2">Copyright (c) 2019 oorione. co., Ltd All rights reserved.</p>
		</div>
	</div>
</footer>
<div id="notice_view"></div>

  </div>



<div style="display:none"><iframe name='sframe' style="width:0px;height:0px;"></iframe></div>
</body>
<script src="/skin/default/js/common.js"></script>
<script src="/skin/default/js/main.js"></script>
<script src="/skin/default/js/back-to-top.js"></script>
</html>