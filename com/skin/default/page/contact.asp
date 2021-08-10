<%
	SQL = "SELECT TOP 1 B_SEQ FROM BOARD_LST WHERE B_STATE < '90' AND BC_SEQ = 1 ORDER BY B_SEQ DESC"
	Set Rs = Conn.Execute(SQL, ,adCmdText)
	If Rs.BOF = false AND Rs.EOF = false Then
		CUT_B_SEQ = Rs("B_SEQ")
	End If
	Rs.close
%>
<div class="container">
	<h2 class="section-title">CONTACT US</h2>
	<!-- Nav tabs -->
	<ul class="nav nav-tabs main-tabs" role="tablist" id="contactTabs">
		<li role="presentation"><a href="#contact1" aria-controls="contact1" role="tab" data-toggle="tab" class="contactLink1">우리원 이야기</a></li>
		<li role="presentation" class="active"><a href="#contact2" aria-controls="contact2" role="tab" data-toggle="tab" class="contactLink2">오시는길</a></li>
	</ul>
	<div class="tab-content">
		<!---1------------------------------------------------------------------------------------------------------->
		<div role="tabpanel" class="tab-pane" id="contact1">
			<div class="flexslider noticeSlider">
				<ul class="slides">
				<%
					SQL = "SELECT TOP 1 * FROM BOARD_LST WHERE B_STATE < '90' AND BC_SEQ = 1 ORDER BY B_SEQ DESC"
					Set Rs = Conn.Execute(SQL, ,adCmdText)
					If Rs.BOF = false AND Rs.EOF = false Then
						TOP_B_SEQ = Rs("B_SEQ")
						TOP_B_TITLE = Rs("B_TITLE")
						TOP_B_TEXT = Rs("B_TEXT")
						TOP_B_ADD1 = Rs("B_ADD1")

						If Len(TOP_B_TEXT) > 400 Then TOP_B_TEXT = Left(TOP_B_TEXT,400) & "..."
					End If
					Rs.close
				%>
					<div>
						<div class="notice-slide">
							<div class="row">
								<div class="col-xxs-12 col-xs-6 col-sm-5 col-md-4 col-lg-3">
									<a class="modalTrigger notice-img-cont" title="<%=TOP_B_TITLE%>" href="#" onclick="getView(<%=TOP_B_SEQ%>);return false;" data-toggle="modal" data-target="#noticeModal">
										<%If TOP_B_ADD1 = "" Then%>
											<img src="/skin/default/img/sub/notice-img1.png" alt="<%=TOP_B_TITLE%>" class="notice-img">
										<%Else%>
											<img src="/file/board_thumbnail/<%=TOP_B_ADD1%>" alt="<%=TOP_B_TITLE%>" class="notice-img">
										<%End If%>
									</a>
								</div>
								<div class="col-xxs-12 col-xs-6 col-sm-7 col-md-8 col-lg-9">
									<a class="modalTrigger notice-caption" title="" href="#" onclick="getView(<%=TOP_B_SEQ%>);return false;">
										<div class="notice-title"><%=TOP_B_TITLE%></div>
										<div class="notice-desc" style="width:90%;"><%=TOP_B_TEXT%></div>
									</a>
								</div>
							</div>
						</div>
					</div>
				</ul>
			</div>
			<div class="clear pt60"></div>
			<div id="notice_list"></div>
		</div>
		<!---2------------------------------------------------------------------------------------------------------->
		<div role="tabpanel" class="tab-pane active" id="contact2">
			<div class="row no-mar" style="margin:0 auto;">
				<div class="col-xs-12 col-sm-6 col-md-6 no-pad contact21">
					<!--## 구글지도 ##-->
					<div class="map_wrap">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3166.1565564284138!2d126.87838151530914!3d37.480631779814104!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b613ab894f3d7%3A0x9e9ae0d75ac2f089!2z6rCA7IKwV-yEvO2EsA!5e0!3m2!1sko!2skr!4v1619597069327!5m2!1sko!2skr" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
					</div>
					<!--## 2019.10.23 API 문제(유료)로 지도를 불러오지 못함. ## <% ' ----<< 구글지도 %>
					<div class="gmaps" id="map_canvas" style="border:0px solid #000;"></div>
					<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCySi8lC4zXEXzNvHWL9HdogQ1_tnUnSCw"></script>
					<script src="/skin/default/js/sub.js"></script>
					<% ' ---- %> -->

				</div>
				<div class="col-xs-12 col-sm-6 col-md-6 no-pad contact22">
					<div class="contact22-tb">
						<div class="contact22-td">
							<div style="text-align:center;font-size:30px;color:#22b5e6;font-weight:700;">|주| 우리원커머스</div>
							<div style="width:100%;height:20px;"></div>
							<div style="text-align:center;font-size:30px;color:#22b5e6;font-weight:700;">|주| 우리원넷</div>
							<div style="width:100%;height:20px;"></div>

							<p class="contactP1">
								<span class="w400">ADDRESS</span>
						 <br>서울특별시 금천구 가산디지털1로 181<br>(가산동 371-106) 가산 W CENTER 1709, 1710호<br>
					  </p>
					  <p class="contactP1">
						 <span class="w400">PARTNERSHIP INFO</span>
						 <br>상품판매 및 입점 문의 : 02.6268.8106
						 <a href="mailto:oorionemd@oorione.com" title="상품판매 및 입점 문의">order@oorione.com <span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
						 <br>사업 제휴 및 마케팅 문의 : 02.6951.4773
						 <a href="mailto:marketing@oorione.com" title="사업 제휴 및 마케팅 문의">marketing@oorione.com <span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
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