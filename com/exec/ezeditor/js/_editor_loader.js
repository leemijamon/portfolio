(function(r){var o="",D="tx_",e="uninitialized",x="loading",A="complete",i="production",w="development",u=1000,k=5;var t=/\/(\d+[a-z.]?\.[a-z0-9\-]+\.[\-\w]+)\//;var f={environment:i,service:"core",version:"",host:""};function C(E){return E.replace(/[^\/]+\/?$/,"")}function b(F){var E=r.getElementsByTagName("script");for(var G=0;G<E.length;G++){if(E[G].src.indexOf(F)>=0){return E[G]}}throw"cannot find '"+F+"' script element"}function g(F){var E=b(F);var G=E.src;return G.substring(G.indexOf("?")+1)}function z(F){var E=b(F);var G=E.src.match(t);if(G&&G.length==2){return G[1]}return""}function q(E){return f[E]||o}function m(E){var F=y.parse(g(j.NAME),"&");return F.findByName(E)}function a(E){var G=y.parse(r.cookie,/;[ ]*/);var F=G.findByName(D+E);return F?decodeURIComponent(F):F}var y=function(){this.data=[]};y.prototype={add:function(E,F){this.data.push({name:E,value:F})},findByName:function(E){var G;for(var F=0;F<this.data.length;F++){if(this.data[F]&&this.data[F].name===E){G=this.data[F].value;
break}}return G}};y.parse=function(G,I){var E=new y();var J=G.split(I);for(var F=0;F<J.length;F++){var H=J[F].split("=");E.add(H[0],H[1])}return E};function p(F){var E=r.createElement("script");E.type="text/javascript";E.src=F;return E}function l(G){var E=r.location;if(G.match(/^(https?:|file:|)\/\//)){}else{if(G.indexOf("/")===0){G="http://"+E.host+G}else{var F=E.href;var H=F.lastIndexOf("/");G=F.substring(0,H+1)+G}}return G}function d(G,H){var E=p(G);var F=r.getElementsByTagName("head")[0]||r.documentElement;h(E,F,H);F.insertBefore(E,F.firstChild);return E}function h(E,F,G){if(G){E.onload=E.onreadystatechange=function(){if(!this.readyState||this.readyState==="loaded"||this.readyState==="complete"){G();if(/MSIE/i.test(navigator.userAgent)){E.onload=E.onreadystatechange=null;if(F&&E.parentNode){F.removeChild(E)}}}}}}function s(E){if(typeof E==="function"){E(Editor)}}var n=function(E){this.TIMEOUT=k*u;this.readyState=e;this.url=E.url;this.callback=E.callback||function(){};this.id=E.id;this.load()
};n.prototype={load:function(){var G=this.url;var F=this;try{b(G)}catch(H){F.readyState=x;var E=d(G,function(){F.callback();F.readyState=A});if(F.id){E.id=F.id}}return this},startErrorTimer:function(){var E=this;setTimeout(function(){if(E.readyState!==A){E.onTimeout()}},E.TIMEOUT)},onTimeout:function(){},onLoadComplete:function(){}};var v=[],B;var j={NAME:"editor_loader.js",TIMEOUT:k*u,readyState:e,loadModule:function(F){function G(H){return !H.match(/^((https?:|file:|)\/\/|\.\.\/|\/)/)}var E=G(F)?this.getJSBasePath()+F:F;if(f.environment===w){E=E+"?dummy="+new Date().getTime()}r.write('<script type="text/javascript" src="'+E+'" charset="utf-8"><\/script>')},asyncLoadModule:function(E){return new n(E)},ready:function(E){if(this.readyState===A){s(E)}else{v.push(E)}},finish:function(){for(var E=0;E<v.length;E++){s(v[E])}v=[]},getBasePath:function(F){var G=a("base_path");if(!G){var E=b(F||j.NAME);G=C(C(E.src))}return l(G)},getJSBasePath:function(E){return this.getBasePath()+"js/"},getCSSBasePath:function(){return this.getBasePath()+"css/"
},getPageBasePath:function(){return this.getBasePath()+"pages/"},getOption:function(E){return a(E)||m(E)||q(E)}};window.EditorJSLoader=j;function c(){var F="editor.js";f.version=z(j.NAME);var E=m("environment");if(E){f.environment=E}j.loadModule(F)}c()})(document);


var editorpath = "/exec/editor";
var editorelement = "tx_trex_container";
var contwidth = null;
var editorwidth = "700px";
var editorheight = "500px";
var imgmaxwidth = 650;
var imgzoom = false;
var bgcolor = false;

var formname = "w_form";
var loadcontent = "paste";
var savehtml = "bodyhtml";
var savetxt = "bodytxt";

var uploadpath = "/file/upload";
var uploadmax = 10;
var fileboxview = false;

var attachimage = "attachimage";
var attachfile = "attachfile";

var siteurl = "http://" + document.domain;

var loadwidth = 0;

function loadEditor(setconfig){
  editorpath = setconfig.editorpath;
  editorelement = setconfig.editorelement;
  contwidth = setconfig.contwidth;
  editorwidth = setconfig.editorwidth;
  editorheight = setconfig.editorheight;
  imgmaxwidth = setconfig.imgmaxwidth;
  imgzoom = setconfig.imgzoom;
  if(typeof(imgzoom) == 'undefined') imgzoom = false;
  bgcolor = setconfig.bgcolor;
  if(typeof(bgcolor) == 'undefined') bgcolor = false;

  formname = setconfig.formname;
  loadcontent = setconfig.loadcontent;
  savehtml = setconfig.savehtml;
  savetxt = setconfig.savetxt;

  uploadpath = setconfig.uploadpath;
  uploadmax = setconfig.uploadmax;
  if(typeof(uploadmax) == 'undefined') uploadmax = 10;
  fileboxview = setconfig.fileboxview;

  attachimage = setconfig.attachimage;
  attachfile = setconfig.attachfile;

  loadwidth = document.getElementById(editorelement).offsetWidth;

  var editorHTML = "";

  editorHTML += '<div class="tx-editor-container" style="float:left;width:' + editorwidth + '; padding:0px;">';

  editorHTML += '<div id="tx_sidebar" class="tx-sidebar">';
  editorHTML += '  <div class="tx-sidebar-boundary">';
  editorHTML += '    <ul class="tx-bar tx-bar-left tx-nav-attach">';
  editorHTML += '      <li class="tx-list">';
  editorHTML += '        <div unselectable="on" id="tx_image" class="tx-image tx-btn-trans">';
  editorHTML += '          <a href="javascript:;" title="사진" class="tx-text">사진</a>';
  editorHTML += '        </div>';
  editorHTML += '      </li>';
  editorHTML += '      <li class="tx-list">';
  editorHTML += '        <div unselectable="on" id="tx_file" class="tx-file tx-btn-trans">';
  editorHTML += '          <a href="javascript:;" title="파일" class="tx-text">파일</a>';
  editorHTML += '        </div>';
  editorHTML += '      </li>';
  editorHTML += '      <li class="tx-list">';
  editorHTML += '        <div unselectable="on" id="tx_media" class="tx-media tx-btn-trans">';
  editorHTML += '          <a href="javascript:;" title="외부컨텐츠" class="tx-text">외부컨텐츠</a>';
  editorHTML += '        </div>';
  editorHTML += '      </li>';
  editorHTML += '    </ul>';
  editorHTML += '    <ul class="tx-bar tx-bar-right">';
  editorHTML += '      <li class="tx-list">';
  editorHTML += '        <div unselectable="on" class="tx-btn-lrbg tx-fullscreen" id="tx_fullscreen">';
  editorHTML += '          <a href="javascript:;" class="tx-icon" title="넓게쓰기 (Ctrl+M)">넓게쓰기</a>';
  editorHTML += '        </div>';
  editorHTML += '      </li>';
  editorHTML += '    </ul>';
  editorHTML += '    <ul class="tx-bar tx-bar-right tx-nav-opt">';
  editorHTML += '      <li class="tx-list">';
  editorHTML += '        <div unselectable="on" class="tx-switchtoggle" id="tx_switchertoggle">';
  editorHTML += '          <a href="javascript:;" title="에디터 타입">에디터</a>';
  editorHTML += '        </div>';
  editorHTML += '      </li>';
  editorHTML += '    </ul>';
  editorHTML += '  </div>';
  editorHTML += '</div>';

  editorHTML += '<div id="tx_toolbar_basic" class="tx-toolbar tx-toolbar-basic"><div class="tx-toolbar-boundary">';
  editorHTML += '  <ul class="tx-bar tx-bar-left">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div id="tx_fontfamily" unselectable="on" class="tx-slt-70bg tx-fontfamily">';
  editorHTML += '        <a href="javascript:;" title="글꼴">굴림</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_fontfamily_menu" class="tx-fontfamily-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-left">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-slt-42bg tx-fontsize" id="tx_fontsize">';
  editorHTML += '        <a href="javascript:;" title="글자크기">9pt</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_fontsize_menu" class="tx-fontsize-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-left tx-group-font">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-lbg tx-bold" id="tx_bold">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="굵게 (Ctrl+B)">굵게</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-bg  tx-underline" id="tx_underline">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="밑줄 (Ctrl+U)">밑줄</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-bg  tx-italic" id="tx_italic">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="기울임 (Ctrl+I)">기울임</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-bg  tx-strike" id="tx_strike">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="취소선 (Ctrl+D)">취소선</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-slt-tbg   tx-forecolor" id="tx_forecolor">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="글자색">글자색</a>';
  editorHTML += '        <a href="javascript:;" class="tx-arrow" title="글자색 선택">글자색 선택</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_forecolor_menu" class="tx-menu tx-forecolor-menu tx-colorpallete" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-slt-brbg  tx-backcolor" id="tx_backcolor">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="글자 배경색">글자 배경색</a>';
  editorHTML += '        <a href="javascript:;" class="tx-arrow" title="글자 배경색 선택">글자 배경색 선택</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_backcolor_menu" class="tx-menu tx-backcolor-menu tx-colorpallete" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-left hidden-xs tx-group-align">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-lbg tx-alignleft" id="tx_alignleft">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="왼쪽정렬 (Ctrl+,)">왼쪽정렬</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-bg tx-aligncenter" id="tx_aligncenter">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="가운데정렬 (Ctrl+.)">가운데정렬</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-bg tx-alignright" id="tx_alignright">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="오른쪽정렬 (Ctrl+/)">오른쪽정렬</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-rbg tx-alignfull" id="tx_alignfull">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="양쪽정렬">양쪽정렬</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-left hidden-xs tx-group-tab">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-lbg tx-indent" id="tx_indent">';
  editorHTML += '        <a href="javascript:;" title="들여쓰기 (Tab)" class="tx-icon">들여쓰기</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-rbg tx-outdent" id="tx_outdent">';
  editorHTML += '        <a href="javascript:;" title="내어쓰기 (Shift+Tab)" class="tx-icon">내어쓰기</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-left hidden-xs tx-group-list">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-slt-31lbg tx-lineheight" id="tx_lineheight">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="줄간격">줄간격</a>';
  editorHTML += '        <a href="javascript:;" class="tx-arrow" title="줄간격">줄간격 선택</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_lineheight_menu" class="tx-lineheight-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-slt-31rbg tx-styledlist" id="tx_styledlist">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="리스트">리스트</a>';
  editorHTML += '        <a href="javascript:;" class="tx-arrow" title="리스트">리스트 선택</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_styledlist_menu" class="tx-styledlist-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-left hidden-xs tx-group-etc">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-lbg tx-emoticon" id="tx_emoticon">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="이모티콘">이모티콘</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_emoticon_menu" class="tx-emoticon-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-bg tx-link" id="tx_link">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="링크 (Ctrl+K)">링크</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_link_menu" class="tx-link-menu tx-menu"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-bg tx-specialchar" id="tx_specialchar">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="특수문자">특수문자</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_specialchar_menu" class="tx-specialchar-menu tx-menu"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-bg tx-table" id="tx_table">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="표만들기">표만들기</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_table_menu" class="tx-table-menu tx-menu" unselectable="on">';
  editorHTML += '        <div class="tx-menu-inner">';
  editorHTML += '          <div class="tx-menu-preview"></div>';
  editorHTML += '          <div class="tx-menu-rowcol"></div>';
  editorHTML += '          <div class="tx-menu-deco"></div>';
  editorHTML += '          <div class="tx-menu-enter"></div>';
  editorHTML += '        </div>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-rbg tx-horizontalrule" id="tx_horizontalrule">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="구분선">구분선</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_horizontalrule_menu" class="tx-horizontalrule-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';

  if(loadwidth >= 730){
    editorHTML += '  <ul class="tx-bar tx-bar-left hidden-xs">';
    editorHTML += '    <li class="tx-list">';
    editorHTML += '      <div unselectable="on" class="tx-btn-lbg tx-richtextbox" id="tx_richtextbox">';
    editorHTML += '        <a href="javascript:;" class="tx-icon" title="글상자">글상자</a>';
    editorHTML += '      </div>';
    editorHTML += '      <div id="tx_richtextbox_menu" class="tx-richtextbox-menu tx-menu">';
    editorHTML += '        <div class="tx-menu-header">';
    editorHTML += '          <div class="tx-menu-preview-area">';
    editorHTML += '            <div class="tx-menu-preview"></div>';
    editorHTML += '          </div>';
    editorHTML += '          <div class="tx-menu-switch">';
    editorHTML += '            <div class="tx-menu-simple tx-selected"><a><span>간단 선택</span></a></div>';
    editorHTML += '            <div class="tx-menu-advanced"><a><span>직접 선택</span></a></div>';
    editorHTML += '          </div>';
    editorHTML += '        </div>';
    editorHTML += '        <div class="tx-menu-inner">';
    editorHTML += '        </div>';
    editorHTML += '        <div class="tx-menu-footer">';
    editorHTML += '          <img class="tx-menu-confirm" src="' + editorpath + '/images/icon/editor/btn_confirm.gif?rv=1.0.1" alt=""/>';
    editorHTML += '          <img class="tx-menu-cancel" hspace="3" src="' + editorpath + '/images/icon/editor/btn_cancel.gif?rv=1.0.1" alt=""/>';
    editorHTML += '        </div>';
    editorHTML += '      </div>';
    editorHTML += '    </li>';
    editorHTML += '    <li class="tx-list">';
    editorHTML += '      <div unselectable="on" class="tx-btn-bg tx-quote" id="tx_quote">';
    editorHTML += '        <a href="javascript:;" class="tx-icon" title="인용구 (Ctrl+Q)">인용구</a>';
    editorHTML += '      </div>';
    editorHTML += '      <div id="tx_quote_menu" class="tx-quote-menu tx-menu" unselectable="on"></div>';
    editorHTML += '    </li>';
    editorHTML += '    <li class="tx-list">';
    editorHTML += '      <div unselectable="on" class="tx-btn-bg tx-background" id="tx_background">';
    editorHTML += '        <a href="javascript:;" class="tx-icon" title="배경색">배경색</a>';
    editorHTML += '      </div>';
    editorHTML += '      <div id="tx_background_menu" class="tx-menu tx-background-menu tx-colorpallete" unselectable="on"></div>';
    editorHTML += '    </li>';
    editorHTML += '    <li class="tx-list">';
    editorHTML += '      <div unselectable="on" class="tx-btn-rbg tx-dictionary" id="tx_dictionary">';
    editorHTML += '        <a href="javascript:;" class="tx-icon" title="사전">사전</a>';
    editorHTML += '      </div>';
    editorHTML += '    </li>';
    editorHTML += '  </ul>';
  }

  editorHTML += '  <ul class="tx-bar tx-bar-left hidden-xs tx-group-undo">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-lbg tx-undo" id="tx_undo">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="실행취소 (Ctrl+Z)">실행취소</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-rbg tx-redo" id="tx_redo">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="다시실행 (Ctrl+Y)">다시실행</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-right">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-nlrbg tx-advanced" id="tx_advanced">';
  editorHTML += '        <a href="javascript:;" class="tx-icon" title="툴바 더보기">툴바 더보기</a>';
  editorHTML += '      </div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '</div></div>';

  editorHTML += '<div id="tx_toolbar_advanced" class="tx-toolbar tx-toolbar-advanced"><div class="tx-toolbar-boundary">';
  editorHTML += '  <ul class="tx-bar tx-bar-left">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div class="tx-tableedit-title"></div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-left tx-group-align">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-lbg tx-mergecells" id="tx_mergecells">';
  editorHTML += '        <a href="javascript:;" class="tx-icon2" title="병합">병합</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_mergecells_menu" class="tx-mergecells-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-bg tx-insertcells" id="tx_insertcells">';
  editorHTML += '        <a href="javascript:;" class="tx-icon2" title="삽입">삽입</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_insertcells_menu" class="tx-insertcells-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div unselectable="on" class="tx-btn-rbg tx-deletecells" id="tx_deletecells">';
  editorHTML += '        <a href="javascript:;" class="tx-icon2" title="삭제">삭제</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_deletecells_menu" class="tx-deletecells-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-left tx-group-align">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div id="tx_cellslinepreview" unselectable="on" class="tx-slt-70lbg tx-cellslinepreview">';
  editorHTML += '        <a href="javascript:;" title="선 미리보기"></a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_cellslinepreview_menu" class="tx-cellslinepreview-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div id="tx_cellslinecolor" unselectable="on" class="tx-slt-tbg tx-cellslinecolor">';
  editorHTML += '        <a href="javascript:;" class="tx-icon2" title="선색">선색</a>';
  editorHTML += '        <div class="tx-colorpallete" unselectable="on"></div>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_cellslinecolor_menu" class="tx-cellslinecolor-menu tx-menu tx-colorpallete" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div id="tx_cellslineheight" unselectable="on" class="tx-btn-bg tx-cellslineheight">';
  editorHTML += '        <a href="javascript:;" class="tx-icon2" title="두께">두께</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_cellslineheight_menu" class="tx-cellslineheight-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div id="tx_cellslinestyle" unselectable="on" class="tx-btn-bg tx-cellslinestyle">';
  editorHTML += '        <a href="javascript:;" class="tx-icon2" title="스타일">스타일</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_cellslinestyle_menu" class="tx-cellslinestyle-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div id="tx_cellsoutline" unselectable="on" class="tx-btn-rbg tx-cellsoutline">';
  editorHTML += '        <a href="javascript:;" class="tx-icon2" title="테두리">테두리</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_cellsoutline_menu" class="tx-cellsoutline-menu tx-menu" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-left">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div id="tx_tablebackcolor" unselectable="on" class="tx-btn-lrbg tx-tablebackcolor" style="background-color:#9aa5ea;">';
  editorHTML += '        <a href="javascript:;" class="tx-icon2" title="테이블 배경색">테이블 배경색</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_tablebackcolor_menu" class="tx-tablebackcolor-menu tx-menu tx-colorpallete" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '  <ul class="tx-bar tx-bar-left">';
  editorHTML += '    <li class="tx-list">';
  editorHTML += '      <div id="tx_tabletemplate" unselectable="on" class="tx-btn-lrbg tx-tabletemplate">';
  editorHTML += '        <a href="javascript:;" class="tx-icon2" title="테이블 서식">테이블 서식</a>';
  editorHTML += '      </div>';
  editorHTML += '      <div id="tx_tabletemplate_menu" class="tx-tabletemplate-menu tx-menu tx-colorpallete" unselectable="on"></div>';
  editorHTML += '    </li>';
  editorHTML += '  </ul>';
  editorHTML += '</div></div>';


  editorHTML += '<div id="tx_canvas" class="tx-canvas">';
  editorHTML += '  <div id="tx_loading" class="tx-loading"><div><img src="' + editorpath + '/images/icon/editor/loading2.png" width="113" height="21" align="absmiddle"/></div></div>';
  editorHTML += '  <div id="tx_canvas_wysiwyg_holder" class="tx-holder" style="display:block;">';
  editorHTML += '    <iframe id="tx_canvas_wysiwyg" name="tx_canvas_wysiwyg" allowtransparency="true" frameborder="0"></iframe>';
  editorHTML += '  </div>';
  editorHTML += '  <div class="tx-source-deco">';
  editorHTML += '    <div id="tx_canvas_source_holder" class="tx-holder">';
  editorHTML += '      <textarea id="tx_canvas_source" rows="30" cols="30"></textarea>';
  editorHTML += '    </div>';
  editorHTML += '  </div>';
  editorHTML += '  <div id="tx_canvas_text_holder" class="tx-holder">';
  editorHTML += '    <textarea id="tx_canvas_text" rows="30" cols="30"></textarea>';
  editorHTML += '  </div>';
  editorHTML += '</div>';

  editorHTML += '<div id="tx_resizer" class="tx-resize-bar">';
  editorHTML += '  <div class="tx-resize-bar-bg"></div>';
  editorHTML += '  <img id="tx_resize_holder" src="' + editorpath + '/images/icon/editor/skin/01/btn_drag01.gif" width="58" height="12" unselectable="on" alt="" />';
  editorHTML += '</div>';
  editorHTML += '<div class="tx-side-bi" id="tx_side_bi">';
  editorHTML += '</div>';

  editorHTML += '<div id="tx_attach_div" class="tx-attach-div">';
  editorHTML += '  <div id="tx_attach_txt" class="tx-attach-txt">파일 첨부</div>';
  editorHTML += '  <div id="tx_attach_box" class="tx-attach-box">';
  editorHTML += '    <div class="tx-attach-box-inner">';
  editorHTML += '      <div id="tx_attach_preview" class="tx-attach-preview"><p></p><img src="' + editorpath + '/images/icon/editor/pn_preview.gif" width="147" height="108" unselectable="on"/></div>';
  editorHTML += '      <div class="tx-attach-main">';
  editorHTML += '        <div id="tx_upload_progress" class="tx-upload-progress"><div>0%</div><p>파일을 업로드하는 중입니다.</p></div>';
  editorHTML += '        <ul class="tx-attach-top">';
  editorHTML += '          <li id="tx_attach_delete" class="tx-attach-delete"><a>전체삭제</a></li>';
  editorHTML += '          <li id="tx_attach_size" class="tx-attach-size">';
  editorHTML += '            파일: <span id="tx_attach_up_size" class="tx-attach-size-up"></span>/<span id="tx_attach_max_size"></span>';
  editorHTML += '          </li>';
  editorHTML += '          <li id="tx_attach_tools" class="tx-attach-tools">';
  editorHTML += '          </li>';
  editorHTML += '        </ul>';
  editorHTML += '        <ul id="tx_attach_list" class="tx-attach-list"></ul>';
  editorHTML += '      </div>';
  editorHTML += '    </div>';
  editorHTML += '  </div>';
  editorHTML += '</div>';

  var element = document.getElementById(editorelement);
  element.innerHTML = editorHTML;

    TrexMessage.addMsg({
        '@fontfamily.nanumgothic': '나눔고딕'
    });

  new Editor({
    txHost: '',
    txPath: editorpath + '',
    txService: 'sample',
    txProject: 'sample',
    initializedId: "",
    wrapper: editorelement,
    form: formname+"",
    txIconPath: editorpath + "/images/icon/editor/",
    txDecoPath: editorpath + "/images/deco/contents/",
    canvas: {
      styles: {
        color: "#123456",
        fontFamily: "굴림",
        fontSize: "10pt",
        backgroundColor: "#ffffff",
        lineHeight: "1.5",
        padding: "8px"
      },
      showGuideArea: false
    },
    events: {
      preventUnload: false
    },
    sidebar: {
      attachbox: {
        show: fileboxview,
        confirmForDeleteAll: true
      },
      capacity: {
        maximum: uploadmax * 1024 * 1024
      }
    },
    toolbar: {
        fontfamily: {
            options: [
                { label: ' 나눔고딕 (<span class="tx-txt">가나다라</span>)', title: '나눔고딕', data: 'NanumGothic,"나눔고딕"', klass: 'tx-nanumgothic' },
                { label: ' 맑은고딕 (<span class="tx-txt">가나다라</span>)', title: '맑은고딕', data: '"맑은 고딕",AppleGothic,sans-serif', klass: 'tx-gulim' },
                { label: ' 굴림 (<span class="tx-txt">가나다라</span>)', title: '굴림', data: 'Gulim,굴림,AppleGothic,sans-serif', klass: 'tx-gulim' },
                { label: ' 바탕 (<span class="tx-txt">가나다라</span>)', title: '바탕', data: 'Batang,바탕', klass: 'tx-batang' },
                { label: ' 돋움 (<span class="tx-txt">가나다라</span>)', title: '돋움', data: 'Dotum,돋움', klass: 'tx-dotum' },
                { label: ' 궁서 (<span class="tx-txt">가나다라</span>)', title: '궁서', data: 'Gungsuh,궁서', klass: 'tx-gungseo' },
                { label: ' Arial (<span class="tx-txt">abcde</span>)', title: 'Arial', data: 'Arial', klass: 'tx-arial' },
                { label: ' Verdana (<span class="tx-txt">abcde</span>)', title: 'Verdana', data: 'Verdana', klass: 'tx-verdana' },
                { label: ' Arial Black (<span class="tx-txt">abcde</span>)', title: 'Arial Black', data: 'Arial Black', klass: 'tx-arial-black' },
                { label: ' Book Antiqua (<span class="tx-txt">abcde</span>)', title: 'Book Antiqua', data: 'Book Antiqua', klass: 'tx-book-antiqua' },
                { label: ' Comic Sans MS (<span class="tx-txt">abcde</span>)', title: 'Comic Sans MS', data: 'Comic Sans MS', klass: 'tx-comic-sans-ms' },
                { label: ' Courier New (<span class="tx-txt">abcde</span>)', title: 'Courier New', data: 'Courier New', klass: 'tx-courier-new' },
                { label: ' Georgia (<span class="tx-txt">abcde</span>)', title: 'Georgia', data: 'Georgia', klass: 'tx-georgia' },
                { label: ' Helvetica (<span class="tx-txt">abcde</span>)', title: 'Helvetica', data: 'Helvetica', klass: 'tx-helvetica' },
                { label: ' Impact (<span class="tx-txt">abcde</span>)', title: 'Impact', data: 'Impact', klass: 'tx-impact' },
                { label: ' Symbol (<span class="tx-txt">abcde</span>)', title: 'Symbol', data: 'Symbol', klass: 'tx-symbol' },
                { label: ' Tahoma (<span class="tx-txt">abcde</span>)', title: 'Tahoma', data: 'Tahoma', klass: 'tx-tahoma' },
                { label: ' Terminal (<span class="tx-txt">abcde</span>)', title: 'Terminal', data: 'Terminal', klass: 'tx-terminal' },
                { label: ' Times New Roman (<span class="tx-txt">abcde</span>)', title: 'Times New Roman', data: 'Times New Roman', klass: 'tx-times-new-roman' },
                { label: ' Trebuchet MS (<span class="tx-txt">abcde</span>)', title: 'Trebuchet MS', data: 'Trebuchet MS', klass: 'tx-trebuchet-ms' }
            ]
        }
    },
    size: {
      contentWidth: contwidth
    }
  });

  Editor.getCanvas().setCanvasSize({
    height: editorheight
  });

  loadContent();
}

function loadContent() {
  var attachments = {};

  if($tx(attachimage) != null){
    imagements = $tx(attachimage).value;

    if(imagements != ""){
      var imagealldata = imagements.split(',');

      for(var i=0,len=imagealldata.length;i<len;i++) {
        if(!imagealldata[i].empty()){
          var imagedata = imagealldata[i].split('|');
          attachments['image' + i] = [];
          attachments['image' + i].push( {
            'attacher': 'image',
            'data': {
              'imageurl': siteurl + imagedata[0].strip(),
              'filename': imagedata[1],
              'filesize': parseFloat(imagedata[2]),
              'originalurl': siteurl + imagedata[0].strip(),
              'thumburl': siteurl + imagedata[0].strip(),
              'originalwidth': imagedata[3],
              'originalheight': imagedata[4],
              'width': imagedata[5],
              'height': imagedata[6]
            }
          });
        }
      }
    }
  }

  if($tx(attachfile) != null){
    filements = $tx(attachfile).value;

    if(filements != ""){
      var filealldata = filements.split(',');

      for(var i=0,len=filealldata.length;i<len;i++) {
        if(!filealldata[i].empty()){
          var filedata = filealldata[i].split('|');
          attachments['file' + i] = [];
          attachments['file' + i].push( {
            'attacher': 'file',
            'data': {
              'attachurl': filedata[0].strip(),
              'filemime': filedata[1],
              'filename': filedata[2],
              'filesize': parseFloat(filedata[3])
            }
          });
        }
      }
    }
  }

  Editor.modify({
    "attachments": function () {
      var allattachments = [];
      for (var i in attachments) {
        allattachments = allattachments.concat(attachments[i]);
      }
      return allattachments;
    }(),
    "content": document.getElementById(loadcontent)
  });
}

function editorcheck() {
  if (!validForm()) {
    return false;
  }

  if (!setForm()) {
    return false;
  }

  return true;
}

function validForm() {
  var validator = new Trex.Validator();
  var content = Editor.getContent();
  if (!validator.exists(content)) {
    alert('내용을 입력하세요');
    return false;
  }

  return true;
}

function setForm() {
  var i, input;
  var form = Editor.getForm();
  if(bgcolor){
    var content = Editor.getContentWithBg();
  }else{
    var content = Editor.getContent();
  }
  //var getbgcolor = Editor.getContent();

  content = content.replace("<P>&nbsp;</P>", "<br>");
  content = content.replace("target=_blank", "target=\"_blank\"");

  var textcontent = Editor.getContent().replace(/(<p[^>]*>(.+?)<\/p>)/gi, "$1\n").replace(/<[\/a-z!]+[^>]*>/gi, "");
  textcontent = textcontent.stripTags();
  textcontent = textcontent.replaceAll('&nbsp;', '');
  textcontent = textcontent.strip();

  /* input 없을 경우 생성 */
  if($tx(savehtml) != null) $tx(savehtml).value = content;
  if($tx(savetxt) != null) $tx(savetxt).value = textcontent;

  if($tx(attachimage) != null){
    var imagevalue = "";
    var images = Editor.getAttachments('image');
    for (i = 0; i < images.length; i++) {
      if(i>0) imagevalue += ",";
      imagevalue += images[i].data.imageurl.replace(siteurl, "") + "|" + images[i].data.filename + "|" + images[i].data.filesize + "|"
      imagevalue += images[i].data.originalwidth + "|" + images[i].data.originalheight + "|" + images[i].data.width + "|" + images[i].data.height;

      if (images[i].existStage) {
        imagevalue += "|yes"
      }else{
        imagevalue += "|no"
      }
    }

    $tx(attachimage).value = imagevalue;
  }

  if($tx(attachfile) != null){
    var filevalue = "";
    var files = Editor.getAttachments('file');

    for (i = 0; i < files.length; i++) {
      if(i>0) filevalue += ",";
      filevalue += files[i].data.attachurl + "|" + files[i].data.filemime + "|" + files[i].data.filename + "|" + files[i].data.filesize;

      /* existStage는 현재 본문에 존재하는지 여부 */
      if (files[i].existStage) {
        filevalue += "|yes"
      }else{
        filevalue += "|no"
      }
    }

    $tx(attachfile).value = filevalue;
  }

  return true;
}
