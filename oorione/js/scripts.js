<!--
  function AjaxloadURL(url, container) {
    $.ajax({
      type : "GET",
      url : url,
      dataType : 'html',
      cache : true, // (warning: this will cause a timestamp and will call the request twice)
      beforeSend : function() {
        container.html('<h1><i class="fa fa-cog fa-spin"></i> Loading...</h1>');

        if (container[0] == $("#content")[0]) {
          document.title = $(".breadcrumb li:last-child").text();
          $("html, body").animate({
            scrollTop : 0
          }, "fast");
        } else {
          container.animate({
            scrollTop : 0
          }, "fast");
        }
      },
      success : function(data) {
        container.css({
          opacity : '0.0'
        }).html(data).delay(50).animate({
          opacity : '1.0'
        }, 300);
      },
      error : function(xhr, ajaxOptions, thrownError) {
        container.html('<h4 style="margin-top:10px; display:block; text-align:left"><i class="fa fa-warning txt-color-orangeDark"></i> Error 404! Page not found.</h4>');
      },
      async : false
    });
  }

  function not_login(login_page,rtn_page){
    var msg = "로그인이 필요한 서비스입니다."
    if(confirm(msg)){
      document.location.href = login_page + "rtn_page=" + rtn_page;
    }else{
      return;
    }
  }

  function popup(src,width,height){
    window.open(src,'','width='+width+',height='+height+',scrollbars=1');
    return;
  }

  function win_open(winname,strlink,width,height,scroll){
    window.open(strlink,winname,'width=' + width + ',height=' + height + ',scrollbars=' + scroll + ',resizable=no');
    return;
  }

  function open_sms(){
    window.open("/exec/sms/send.asp","sms_send", "scrollbars=no,width=516,height=320,resizable=no");
    return;
  }

  function goBoard(board_link,bc_seq,b_cate,method,page,b_seq,search_key,search_word){
    document.location.href = board_link + "?bc_seq=" + bc_seq + "&b_cate=" + b_cate + "&method=" + method + "&page=" + page + "&b_seq=" + b_seq + "&search_key=" + search_key + "&search_word=" + search_word;
  }

  function goComment(board_link,bc_seq,b_cate,method,page,b_seq,bcm_seq,search_key,search_word){
    document.location.href = board_link + "?bc_seq=" + bc_seq + "&b_cate=" + b_cate + "&method=" + method + "&page=" + page + "&b_seq=" + b_seq + "&bcm_seq=" + bcm_seq + "&search_key=" + search_key + "&search_word=" + search_word;
  }

  //이미지 보기
  function openImage(img){
    img_conf1= new Image();
    img_conf1.src=(img);
    img_view_conf(img);
  }

  function img_view_conf(img){
    if((img_conf1.width!=0)&&(img_conf1.height!=0)){
      img_view_img(img);
    }else{
      funzione="img_view_conf('"+img+"')";
      intervallo=setTimeout(funzione,20);
    }
  }

  var img_view = null;
  function img_view_img(img){
    if(img_view != null){
      if(!img_view.closed){
        img_view.close();
      }
    }

    img_width=img_conf1.width+6;
    img_height=img_conf1.height+6;

    if(img_height > screen.height - 80){
      img_height = screen.height - 80;
      img_width = img_width + 16;
      str_img = "width="+img_width+",height="+img_height+",scrollbars=1";
    }else{
      str_img = "width="+img_width+",height="+img_height;
    }

    img_view=window.open("about:blank","",str_img);
    img_view.document.open(); // document.open()
    img_view.document.writeln("<html>");
    img_view.document.writeln("<head>");
    img_view.document.writeln("<title>이미지보기</title>");
    img_view.document.writeln("<meta http-equiv='content-type' content='text/html; charset=euc-kr'>");
    img_view.document.writeln("<meta http-equiv='imagetoolbar' content='no'>");
    var start="<";
//    img_view.document.writeln("<script language='javascript'>");
//    img_view.document.writeln("function click() {");
//    img_view.document.writeln("if ((event.button==1) || (event.button==2)) {");
//    img_view.document.writeln("top.close();");
//    img_view.document.writeln(" }");
//    img_view.document.writeln("}");
//    img_view.document.writeln("document.onmousedown=click");
//    img_view.document.writeln(start+"/script>");
    img_view.document.writeln("</head>");
    img_view.document.writeln("<body style='margin:3px;'>");
    img_view.document.writeln("<center><img src="+ img +" border=0 style='cursor:hand' onclick='top.close();'></center>") // 소스 테스트 부분
    img_view.document.writeln("</body></html>");
    img_view.document.close(); // 반드시 document.close() 닫아주어야 함
    img_view.focus();
    return;
  }

  // 기본 스크립트
  function chkNull(obj, msg){
    if(obj.value.split(" ").join("") == ""){
      alert(msg);
      if(obj.type != "hidden"){
        obj.focus();
      }
      return false;
    }else{
      return true;
    }
  }

  function chkLen(obj, minSize, maxSize, msg){
    if(minSize > maxSize){
      alert(obj.name + '에 대한 길이 체크에 잘못된 범위를 사용했습니다.');
      return false;
    }

    var objval_len = obj.value.length;
    var temp;

    for(i = 0; i < objval_len; i++){
      temp = obj.value.charAt(i);
      if(escape(temp).length > 4)
      objval_len++;
    }

    if((objval_len < minSize) || (objval_len > maxSize)){
      alert(msg);
      obj.focus();
      return false;
    }else{
      return true;
    }
  }

  function chkByte(obj, minSize, maxSize, msg){
    var curText;
    var strLen;
    var byteIs;
    var lastByte;
    var thisChar;
    var escChar;
    var curTotalMsg;
    var okMsg;

    curText = new String(obj.value);
    strLen = curText.length;
    byteIs = 0;

    for(i=0; i<strLen; i++) {
      thisChar = curText.charAt(i);
      escChar = escape(thisChar);

      // ´,¨, ¸ : 2byte 임에도 브라우져에서 1byte로 계산
      if(thisChar == "´" || thisChar == "¨" || thisChar == "¸" || thisChar == "§" ){
        byteIs++;
      }

      if (escChar.length > 4) {
        byteIs += 2;  //특수문자 한글인 경우.
      }else if(thisChar != '\r') {  //개행을 제외한 이외의 경우
        byteIs += 1;
      }

      lastByte = byteIs;
    }

    if((byteIs < minSize) || (byteIs > maxSize)){
      alert(msg);
//      obj.focus();
      return false;
    }else{
      return true;
    }
  }

  function number_validate(theForm){
    if(theForm.value != ""){
      var str=theForm.value;
      for(var i = 0; i< str.length; i++){
        var ch = str.substring(i, i + 1);
        if((ch<"0" || ch>"9")){
          alert("숫자 만을 입력할수 있습니다.");
          tye = 1;
          theForm.value="";
          theForm.focus();
          return false;
        }else{
          tye=0;
        }
      }
    }else{
      tye=0;
    }
    return true;
  }

  function chkCheck(obj, msg){
    var cnt = 0;
    if(obj.length > 1){
      for(var i = 0; i < obj.length; i++){
        if(obj[i].checked){
          cnt++;
        }
      }
    }else{
      if(obj.checked){
        cnt++;
      }
    }

    if(cnt == 0){
      alert(msg);
//      obj.focus();
      return false;
    }else{
      return true;
    }
  }

  function chkRadio(obj, msg){
    var rchk = "0";
    if(obj.length > 1){
      for(var i = 0; i < obj.length; i++){
        if(obj[i].checked){
          rchk = "1";
          break;
        }
      }
    }else{
      if(obj.checked){
        rchk = "1";
      }
    }

    if(rchk == "0"){
      alert(msg);
      return false;
    }else{
      return true;
    }
  }

  function valRadio(obj){
    var val = "";
    if(obj.length > 1){
      for(var i = 0; i < obj.length; i++){
        if(obj[i].checked){
          val = obj[i].value;
          break;
        }
      }
    }else{
      if(obj.checked){
        val = obj.value;
      }
    }

    return val;
  }

  function chkEmail(obj){
    var val = obj.value;

    if(val != ""){
      if(val.indexOf(" ") != -1){
        alert("공백허용 되지 않습니다.");
        obj.focus();
        return false;
      }
      if(val.indexOf("@") < 1){
        alert("'@' 누락되었습니다.");
        obj.focus();
        return false;
      }
      if(val.indexOf(".") == -1){
        alert("'.' 누락되었습니다.");
        obj.focus();
        return false;
      }
      if(val.indexOf(".") - val.indexOf("@") == 1){
        alert("'@' 다음에 바로 '.'이 올 수 없습니다.");
        obj.focus();
        return false;
      }
      if(val.charAt(val.length-1) == '.'){
        alert("'.'은 EMAIL주소 끝에 올 수 없습니다.");
        obj.focus();
        return false;
      }
      if(val.charAt(val.length-1) == '@'){
        alert("'@'은 EMAIL주소 끝에 올 수 없습니다.");
        obj.focus();
        return false;
      }
    }

    return true;
  }

  //영문+숫자 체크
  function isAlphanumeric(s){
    var i;
    if (isEmpty(s))
      if (isAlphanumeric.arguments.length == 1) return defaultEmptyOK;
      else return (isAlphanumeric.arguments[1] == true);

    for (i = 0; i < s.length; i++) {
      var c = s.charAt(i);

    if (!(isLetter(c) || isDigit(c)))
      return false;
    }
    return true;
  }

  function isDigit(c){
    return ((c >= "0") && (c <= "9"))
  }
  function isEmpty(s){
    return ((s == null) || (s.length == 0))
  }
  function isLetter(c){
    return ( ((c >= "a") && (c <= "z")) || ((c >= "A") && (c <= "Z")) || c=="_")
  }

  // SET_VALUE
  function set_value(object, value){
    if(object==null||object=='undefined') return;
    if(object.type=='hidden' || object.type=='text' || object.type=='password' || object.type=='textarea'){
      object.value=value;
    }else if(object.type=='checkbox'){
      if(object.value.toUpperCase()==value.toUpperCase()) object.checked = true;
    }else if(!isNaN(object.length)){
      for(i=0; i<object.length; i++){
        if(object[i].value.toUpperCase()==value.toUpperCase()){
          if(object.type=='select-one') object.value=value;
          if(object[0].type=='radio') object[i].checked = true;
        }
      }
    }
  }

  // 체크박스 배열로체크
  function set_checkarr(object, value){
    if(object==null||object=='undefined') return;

    var vcnt = value.indexOf(",");

    if(vcnt < 1){
      set_checkbox(object, value);
    }else{
      var szvalue = value.split(",");

      for(var i = 0; i < szvalue.length; i++){
        set_checkbox(object, szvalue[i]);
      }
    }
  }

  // 체크박스체크
  function set_checkbox(object, value){
    if(object==null||object=='undefined') return;

    if(object.length > 1){
      for(var i = 0; i < object.length; i++){
        if(object[i].value.toUpperCase() == value.toUpperCase()) object[i].checked = true;
      }
    }else{
      if(object.value.toUpperCase() == value.toUpperCase()) object.checked = true;
    }
  }

  // 문자열 공백제거
  function trim(str){
    return str.replace(/(^\s*)|(\s*$)/g, "");
  }

  function getCookie(name){
    var nameOfCookie = name + "=";
    var x = 0;

    while(x <= document.cookie.length){
      var y = (x+nameOfCookie.length);
      if(document.cookie.substring(x,y) == nameOfCookie){
        if((endOfCookie=document.cookie.indexOf(";", y)) == -1 )
        endOfCookie = document.cookie.length;
        return unescape(document.cookie.substring(y, endOfCookie));
      }
      x = document.cookie.indexOf( " ", x ) + 1;
      if ( x == 0 )
      break;
    }
    return "";
  }

  function setCookie(name, value, expiredays){
    var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
  }

  function popupclose(name,elemnt){
    if(elemnt) setCookie(name, "done" , 1);
    if (_ID(name) == null) setTimeout( "self.close()" );
    else setTimeout( "_ID('" + name + "').style.display='none'" );
  }

  function popupcenter(winname,strlink,width,height,scroll){
    pleft = screen.width/2 - width/2;
    ptop = screen.height/2 - height/2;

    window.open(strlink,winname,'top=' + ptop + ',left=' + pleft + ',width=' + width + ',height=' + height + ',scrollbars=' + scroll + ',resizable=no');
    return;
  }

/*** 이동레이어 관련 : start ***/
var appname = navigator.appName.charAt(0);
var move_type = false;
var divpop_id;

 function Start_move(e,thisID){
   var event = e || window.event;
   divpop_id = thisID;
   //익스
   if( appname == "M" ){
     target_Element = event.srcElement;
  }else{ //익스외
    if (event.which !=1){
      return false;
    }
    else{
      move_type = true;
      target_Element = event.target;
    }
  }

  move_type = true;
  Move_x = event.clientX;
  Move_y = event.clientY;
  if( appname == "M" ) target_Element.onmousemove = Moveing;
  else document.onmousemove = Moveing;
 }


 function Moveing(e){
  var event = e || window.event;

  if(move_type == true){
    var Nowx = event.clientX - Move_x;
    var Nowy = event.clientY - Move_y;
    var targetName = document.getElementById(divpop_id);
    targetName.style.left = int_n(targetName.style.left) + Nowx;
    targetName.style.top = int_n(targetName.style.top) + Nowy;
    Move_x = event.clientX;
    Move_y = event.clientY;
    return false;
  }
 }

 function Moveing_stop(){
  move_type =  false;
}

function int_n(cnt){
  if( isNaN(parseInt(cnt)) == true ) var re_cnt = 0;
  else var re_cnt = parseInt(cnt);
  return re_cnt;
}

document.onmouseup = Moveing_stop;
/*** 이동레이어 관련 : end ***/


  function _ID(obj){return document.getElementById(obj)}

  function getTargetElement(evt){
    if ( evt.srcElement ) return target_Element = evt.srcElement; // 익스
    else return target_Element = evt.target; // 익스외
  }

  function inArray( needle, haystack ){
    for ( i = 0; i < haystack.length; i++ )
      if ( haystack[i] == needle ) return true;
    return false;
  }

  /* 브라우저별 이벤트 처리*/
  function addEvent(obj, evType, fn){
    if (obj.addEventListener) {
      obj.addEventListener(evType, fn, false);
      return true;
    } else if (obj.attachEvent) {
      var r = obj.attachEvent("on"+evType, fn);
      return r;
    } else {
      return false;
    }
  }

  function delEvent(obj, evType, fn){
    if (obj.removeEventListener) {
      obj.removeEventListener(evType, fn, false);
      return true;
    } else if (obj.detachEvent) {
      var r = obj.detachEvent("on"+evType, fn);
      return r;
    } else {
      return false;
    }
  }

  function poplay(flag,lyrname,lwidth,lheight){
    var divaddlyr = document.getElementById(lyrname);

    if(divaddlyr.currentStyle) {
        // IE
        addlyrWidth = parseInt(divaddlyr.currentStyle.width);
        addlyrHeight = parseInt(divaddlyr.currentStyle.height);
    } else if (window.getComputedStyle) {
        // FF
        addlyrWidth = parseInt(window.getComputedStyle(divaddlyr, null).width);
        addlyrHeight = parseInt(window.getComputedStyle(divaddlyr, null).height);
    }

    if(lwidth!=""){
        addlyrWidth = parseInt(lwidth);
        addlyrHeight = parseInt(lheight);
    }

    //스크롤 위치 파악
    if (self.pageYOffset) { //IE외 모든 브라우저
        scrollX = self.pageXOffset;
        scrollY = self.pageYOffset;
    } else if(document.documentElement && document.documentElement.scrollTop){
    //Explorer 6 Strict mode
        scrollX = document.documentElement.scrollLeft;
        scrollY = document.documentElement.scrollTop;
    } else if(document.body){//다른 IE
        scrollX = document.body.scrollLeft;
        scrollY = document.body.scrollTop;
    }

    //윈도우나 프레임의 내부크기를 알아 낸다.
    if(self.innerHeight){//IE외 모든 브라우저
        frameX = self.innerWidth;
        frameY = self.innerHeight;
    } else if(document.documentElement && document.documentElement.clientHeight){
    //Explorer 6 Strict mode
        frameX = document.documentElement.clientWidth;
        frameY = document.documentElement.clientHeight;
    } else if(document.body){ //다른 IE
        frameX = document.body.clientWidth;
        frameY = document.body.clientHeight;
    }

    divaddlyr.style.top = (scrollY + (frameY / 2) - (addlyrHeight / 2)) + "px";
    divaddlyr.style.left = (scrollX + (frameX / 2) - (addlyrWidth / 2)) + "px";

    if(flag == "open"){
      divaddlyr.style.visibility = 'visible';
    }else{
      divaddlyr.style.visibility = 'hidden';
    }
  }

  function inputGetScript(id){
    var txt = '';
    txt = 'function form_check(form){\n';
    $.each(id.find("input:text"),function(i,val){
      var th = $(val).parent().parent().find(".th").html();
      var td = $(this).attr("name");
      txt += 'if(!chkNull(form.'+td+', "\''+th+'\'를 입력해 주세요")) return false;\n'
    });

    txt += 'return true;\n';
    txt += '}';
    console.log(txt)
  }
//-->
