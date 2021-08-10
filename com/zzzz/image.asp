<!DOCTYPE html>
<html>
  <head>
	<meta charset="UTF-8">
    <style type="text/css">
		  p {
			position: relative;
			width: 400px;
			height: 90px;
		  }
		  #test1,#test2 {
			position: absolute;
			width: 400px;
			height: 65px;
			font-size: 36px;
			text-align: center;
			padding-top: 25px;
			top: 0;
			left: 0;
		  }
		  #test1{
		  }

		  #test2{
			display: none;
		  }		
    </style>
    <script src="/jscript/jquery-1.11.1.min.js"></script>
  </head>
  <body>
    <p>
      <div id="test1" style="color:#000;"><img src="/skin/default/img/main/msl1.jpg" style="width:400px;">123456789</div>
      <div id="test2" style="color:#000;"><img src="/skin/default/img/main/msl2.jpg" style="width:400px;">ABCDEFG</div>
    </p>
  </body>

<script>
	var fnImg = function(){
  	  $( "div#test2" ).fadeIn( 100 );
	  $( "div#test1" ).fadeIn( 5000 );
	  $( "div#test1" ).fadeOut( 10000 );
	  };

	setInterval(function(){
		fnImg();
	}, 10000);
</script>

</html>

https://codepen.io/eond/pen/YyPxeY