	geocoder = new google.maps.Geocoder();

	function setMap(g,id,tit) {
			var address = g;
			geocoder.geocode( { 'address': address}, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {		// 위경도값을 올바로 리턴 받았을 경우
					la = eval( results[0].geometry.location.toString().split(",")[0].replace("(","") );
					lo = eval( results[0].geometry.location.toString().split(",")[1].replace(")","") );
					drawMap(id,tit);
				} else {			// 위경도값을 리턴받지 못했을 경우 - 전달된 주소값이 잘못되거나 구글맵에 존재하지 않는 주소일 경우
					alert("Geocode was not successful for the following reason: " + status);
				}
			});
	}
	function drawMap(id,tit) {
		var latlng = new google.maps.LatLng(la, lo);
		var myOptions = {
				zoom: 17,			// 기본 zoom레벨
				zoomControlOptions: {
					style: google.maps.ZoomControlStyle.LARGE		// zoom컨트롤러를 강제로 슬라이드바 UI로 세팅
				},
				maxZoom:19,		// zoom컨트롤러에 의해 조정가능한 최대 zoom레벨
				minZoom:12,		// zoom컨트롤러에 의해 조정가능한 최소 zoom레벨
				center: latlng,
				//navigationControl: false,
				//zoomControl:false,
				streetViewControl:true,	// 거리뷰 기능 disable
				disableDoubleClickZoom:true,	// 마우스 더블클릭으로 zoom레벨 변경기능 disable
				mapTypeId: google.maps.MapTypeId.ROADMAP
			};
		map = new google.maps.Map(document.getElementById(id), myOptions);

		var infowindow = new google.maps.InfoWindow({
		    content: tit
	    });

		var marker = new google.maps.Marker({position: latlng,map: map,title:tit});

		infowindow.open(map,marker);
		marker.setAnimation(google.maps.Animation.BOUNCE)
	}