<nav id="ad_menu">
	<div class="ad_menu_wrap clear">
		<img src="/skin/default/img/sub/company6-img3.png" alt="우리원로고">
		<ul class="nav_pc hidden-sm hidden-xs">
			<li><a href="#section_01" class="smooth">Home</a></li>
			<li><a href="#section_02" class="smooth">About</a></li>
			<li><a href="#section_03" class="smooth">Data</a></li>
			<li><a href="#section_04" class="smooth">Type</a></li>
			<li><a href="#section_05" class="smooth">Reference</a></li>
		</ul>
		<header class="hidden-md hidden-lg">
			<a href="#" class="menuBtn">
				<span class="lines"></span>
			</a>
			<nav class="mainMenu">
				<ul>
					<li><a href="#section_01" class="smooth">Home</a></li>
					<li><a href="#section_02" class="smooth">About</a></li>
					<li><a href="#section_03" class="smooth">Data</a></li>
					<li><a href="#section_04" class="smooth">Type</a></li>
					<li><a href="#section_05" class="smooth">Reference</a></li>
				</ul>
			</nav>
		</header>
	</div>
</nav>

<script>
	$('.ad_menu_wrap ul.nav_pc li a').on('click', function(event) {
		$(this).parent().find('a').removeClass('active');
		$(this).addClass('active');
	});

	$(window).on('scroll', function() {
		$('.target').each(function() {
			if($(window).scrollTop() >= $(this).offset().top) {
				var id = $(this).attr('id');
				$('.ad_menu_wrap ul.nav_pc li a').removeClass('active');
				$('.ad_menu_wrap ul.nav_pc li a[href=#'+ id +']').addClass('active');
			}
		});
	});

	$(document).ready(function(){
		// menu click event
		$('.menuBtn').click(function() {
			$(this).toggleClass('act');
				if($(this).hasClass('act')) {
					$('.mainMenu').addClass('act');
				}
				else {
					$('.mainMenu').removeClass('act');
				}
		});
		$('.mainMenu.act').click(function(){
			$(this).removeClass('act');
		});
	});
</script>