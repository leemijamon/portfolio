<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <title>Daum 에디터 - 등록화면 예제</title>
</head>
<body>
<div class="body" style="width:730px;">
    <link rel="stylesheet" href="css/editor.css" type="text/css" charset="utf-8"/>
    <script src="js/editor_loader.js" type="text/javascript" charset="utf-8"></script>

  <!-- 에디터 시작 -->
  <!--
    @decsription
    등록하기 위한 Form으로 상황에 맞게 수정하여 사용한다. Form 이름은 에디터를 생성할 때 설정값으로 설정한다.
  -->
  <form name="w_form" id="w_form" method="post">
  <textarea name="bodyhtml"id="bodyhtml" style="display:none;"></textarea>
  <textarea name="bodytxt"id="bodytxt" style="display:none;"></textarea>
<textarea id="paste" style="display:none;">
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
</textarea>

<input type="hidden" name="attachimage" id="attachimage" value="" />
<input type="hidden" name="attachfile" id="attachfile" value="" />

    <!-- 에디터 컨테이너 시작 -->
    <div id="editor_div">

    </div>
    <!-- 에디터 컨테이너 끝 -->
  </form>
</div>
<!-- 에디터 끝 -->

<script type="text/javascript">
  var editorConfig = {
    'editorpath': '.', /* 에디터경로 */
    'editorelement': 'editor_div', /* 에디터삽입element */
    'editorwidth': '100%', /* 에디터폭 */
    'editorheight': '600px', /* 에디터높이 */
    'contwidth': null, /* 컨텐츠폭 null(100%) */
    'imgmaxwidth': 600, /* 이미지최대폭 */
    'imgzoom': false, /* 이미지줌사용여부 */
    'formname': 'w_form', /* 폼이름 */
    'loadcontent': 'paste', /* 로드element */
    'savehtml': 'bodyhtml', /* HTML저장element */
    'savetxt': 'bodytxt', /* Text저장element */
    'uploadpath': '/file/board', /* 업로드경로 */
    'fileboxview': true, /* 첨부박스표시여부 */
    'attachimage': 'attachimage', /* 첨부이미지element */
    'attachfile': 'attachfile' /* 첨부파일element */
  };

  window.onload = function () {
    loadEditor(editorConfig);
  }
</script>

<!-- Sample: Saving Contents -->
<script type="text/javascript">
  /* 예제용 함수 */
  var form = document.w_form;

  function saveContent() {
    if(!editorcheck()) return;

    var msg = "등록하시겠습니까?"
    if(confirm(msg)){
      form.action = "register.asp";
      form.submit();
    }else{
      return;
    }
  }
</script>

<div><button onclick='saveContent()'>SAMPLE - submit contents</button></div>
<!-- End: Saving Contents -->

<!-- Sample: Loading Contents -->

</body>
</html>