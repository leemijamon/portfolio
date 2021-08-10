  var navigationFn = {
    goToSection: function(id) {
        $('html, body').animate({
            scrollTop: $(id).offset().top
        }, 0);
    }
  }

  $(document).ready(function() {
    //$('#main-nav').metisMenu();

    Nav.init ();

    // fire this on page load if nav exists
    if ($('#main-nav').length) {
      loadURL();
    };

    // fire links with targets on different window
    $(document).on('click', '#main-nav a[target="_blank"]', function(e) {
      e.preventDefault();
      $this = $(e.currentTarget);

      window.open($this.attr('href'));
    });

    // fire links with targets on same window
    $(document).on('click', '#main-nav a[target="_top"]', function(e) {
      e.preventDefault();
      $this = $(e.currentTarget);

      window.location = ($this.attr('href'));
    });

    $(document).on('click', '#main-nav a[href!="#"]', function(e) {
      e.preventDefault();
      $this = $(e.currentTarget);

      if (!$this.parent().hasClass("active") && !$this.attr('target')) {
        window.location.hash = $this.attr('href');
      }
    });

    // all links with hash tags are ignored
    $(document).on('click', '#main-nav a[href="#"]', function(e) {
      e.preventDefault();
    });

    // DO on hash change
    $(window).on('hashchange', function() {
      if(!$('#top-bar-toggle').hasClass('collapsed')) {
        $('#top-bar-toggle').click()
      }

      if(!$('#sidebar-toggle').hasClass('collapsed')) {
        $('#sidebar-toggle').click()
      }

      loadURL();
    });

    $(window).bind("load resize", function() {
        //console.log($(this).width())
        if ($(this).width() < 991) {
            $('div.sidebar-collapse').addClass('collapse')
        } else {
            $('div.sidebar-collapse').removeClass('collapse')
        }
    });

    $('#logout').click(function(e) {
      document.sframe.location.href='?action=admin.logout';
    });

    if($(window).width() > 768){
      var mainH = $(window).height() - 80;
      $('.main-content').css({'min-height':mainH+'px'});
    }
  });

  /** LOAD SCRIPTS */

  var jsArray = {};

  function loadScript(scriptName, callback) {
    if (!jsArray[scriptName]) {
      jsArray[scriptName] = true;

      // adding the script tag to the head as suggested before
      var body = document.getElementsByTagName('body')[0];
      var script = document.createElement('script');
      //script.type = 'text/javascript';
      script.src = scriptName;

      // then bind the event to the callback function
      // there are several events for cross browser compatibility
      //script.onreadystatechange = callback;
      script.onload = callback;

      // fire the loading
      body.appendChild(script);

    } else if (callback) {// changed else to else if(callback)
      //console.log("JS file already added!");
      //execute function
      callback();
    }
  }

  var Nav = function () {
    return { init: init };

    function init () {
      var mainnav = $('#main-nav'),
        openActive = mainnav.is ('.open-active'),
        navActive = mainnav.find ('> .active');

      mainnav.find ('> .dropdown > a').bind ('click', navClick);

      if (openActive && navActive.is ('.dropdown')) {
        navActive.addClass ('opened').find ('.sub-nav').show ();
      }
    }

    function navClick (e) {
      e.preventDefault ();

      var li = $(this).parents ('li');

      if (li.is ('.opened')) {
        closeAll ();
      } else {
        closeAll ();
        li.addClass ('opened').find ('.sub-nav').slideDown ();
      }
    }

    function closeAll () {
      $('.sub-nav').slideUp ().parents ('li').removeClass ('opened');
    }
  }();

  // CHECK TO SEE IF URL EXISTS
  function loadURL(url) {
    //get the url by removing the hash
    if(!url){
      url = location.hash.replace(/^#/, '');
    }

    container = $('#main-content');
    // Do this if url exists (for page refresh, etc...)
    if (url) {
      // remove all active class
      $('#main-nav li.active').removeClass("active");
      // match the url and add the active class

      $('#main-nav li:has(a[href="' + url + '"])').addClass("active");
      title = ($('#main-nav a[href="' + url + '"]').attr('title'))

      // change page title from global var
      document.title = (title || document.title);
      //console.log("page title: " + document.title);

      if(urlcheck(url)){
        url = "page/" + url.replace("/",".") + ".asp";
      }else{
        url = "/useradmin/page/" + url.replace("/",".") + ".asp";
      }

      AjaxloadURL(url, container);
    } else {
      // grab the first URL from nav
      $this = $('#main-nav > li:first-child > a[href!="#"]');

      //update hash
      window.location.hash = $this.attr('href');
    }
  }

  function urlcheck(url) {
    if(url.indexOf('index') > -1) return true;
    if(url.indexOf('admin/') > -1) return true;
    if(url.indexOf('board/') > -1) return true;
    if(url.indexOf('conf/') > -1) return true;
    if(url.indexOf('member/') > -1) return true;
    if(url.indexOf('skin/') > -1) return true;
    if(url.indexOf('state/') > -1) return true;

    return false;
  }

  function AjaxURL(url) {
    container = $('#main-content');
    AjaxloadURL(url, container);
  }

  function AjaxloadURL(url, container) {
    $.ajax({
      type : "GET",
      url : url,
      dataType : 'html',
      cache : true, // (warning: this will cause a timestamp and will call the request twice)
      beforeSend : function() {
        container.html('<h1><i class="fa fa-cog fa-spin"></i> Loading...</h1>');

        if (container[0] == $("#content")[0]) {
          //drawBreadCrumb();
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
        //alert(data);
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

  function win_open(winname,strlink,width,height,scroll){
    window.open(strlink,winname,'width=' + width + ',height=' + height + ',scrollbars=' + scroll + ',resizable=no');
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
  //alert(object.type);
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

