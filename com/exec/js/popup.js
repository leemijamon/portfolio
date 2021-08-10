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

    window.open(strlink,winname,'top=' + ptop + 'px,left=' + pleft + 'px,width=' + width + 'px,height=' + height + 'px,scrollbars=' + scroll + ',resizable=no');
    return;
  }

  function _ID(obj){return document.getElementById(obj)}

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
