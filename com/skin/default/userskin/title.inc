<%
If Left(PAGE_NUM(PG_SEQ),2) = "01" Then
	PAGE_CUSTOM_DESCRIPTIONS = "소형가전 전문기업 리큅이 새로운 제품을 만들어 갑니다."
	PAGE_TITLE_WHITE = " white"
ElseIf Left(PAGE_NUM(PG_SEQ),2) = "02" Then
	PAGE_CUSTOM_DESCRIPTIONS = "소형가전 전문기업 리큅이 새로운 제품을 만들어 갑니다."	
ElseIf Left(PAGE_NUM(PG_SEQ),2) = "03" Then
	PAGE_CUSTOM_DESCRIPTIONS = "소형가전 전문기업 리큅이 새로운 제품을 만들어 갑니다."
	PAGE_TITLE_WHITE = " white"
ElseIf Left(PAGE_NUM(PG_SEQ),2) = "04" Then
	PAGE_CUSTOM_DESCRIPTIONS = "소형가전 전문기업 리큅이 새로운 제품을 만들어 갑니다."
	PAGE_TITLE_WHITE = " white"
ElseIf Left(PAGE_NUM(PG_SEQ),2) = "05" Then
	PAGE_CUSTOM_DESCRIPTIONS = "소형가전 전문기업 리큅이 새로운 제품을 만들어 갑니다."
End If
%>

<div class="subtop">
	<div class="bcg">
		<div class="titleCont<%=PAGE_TITLE_WHITE%>">
			<h2 class="page-title"><%=BIG_TITLE%></h2>
			<p class="page-desc"><%=PAGE_CUSTOM_DESCRIPTIONS%></p>
		</div>
	</div>
</div>
<div class="sub_menu">
	<div class="container">
		<!-- #include virtual = "/skin/default/userskin/leftmenu.inc" -->
	</div>
</div>