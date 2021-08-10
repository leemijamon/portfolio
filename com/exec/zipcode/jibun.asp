<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   f_key = request("f_key")
   s_key = Split(f_key,"/")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>우편번호검색 - 지번주소의 우편번호</title>
<link href="zipcode.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
//<![CDATA[
  //검색탭 이미지 토글
  function togSearchTab(n,e){
      var objImg = document.getElementById("Stab"+n);

      if(e.type=="mouseover"||e.type=="focus"){
          objImg.src = objImg.src.replace("off.gif","on.gif");
      }else if(e.type=="mouseout"||e.type=="blur"){
          objImg.src = objImg.src.replace("on.gif","off.gif");
      }
  }

  function replaceStr(str,gubun){
      return str.replace(gubun,"");
  }

  function zip_search(){
      var objF = document.getElementById("f");

      if(objF.keyword.value==""){
          alert("검색어를 입력하세요!");
          objF.keyword.focus();
          return false;
       }
       else if(objF.keyword.value.length<2){
           alert("검색어를 2글자이상으로입력하세요!");
           objF.keyword.focus();
           return false;
       }
       else{
         objF.method ="post";

         if (chkcnum(objF.keyword)) {
           objF.keyword_type.value = "1";
         } else {
           objF.keyword_type.value = "0";
         }

         objF.submit();

         return false;
       }
       return true;
  }

  var codeTypeArr = new Array();
  var codeArr = new Array();
  var codeNameArr = new Array();

  codeTypeArr[0] = "강원";
  codeArr[0] = "강릉시";
  codeNameArr[0] = "강릉시";

  codeTypeArr[1] = "강원";
  codeArr[1] = "고성군";
  codeNameArr[1] = "고성군";

  codeTypeArr[2] = "강원";
  codeArr[2] = "동해시";
  codeNameArr[2] = "동해시";

  codeTypeArr[3] = "강원";
  codeArr[3] = "삼척시";
  codeNameArr[3] = "삼척시";

  codeTypeArr[4] = "강원";
  codeArr[4] = "속초시";
  codeNameArr[4] = "속초시";

  codeTypeArr[5] = "강원";
  codeArr[5] = "양구군";
  codeNameArr[5] = "양구군";

  codeTypeArr[6] = "강원";
  codeArr[6] = "양양군";
  codeNameArr[6] = "양양군";

  codeTypeArr[7] = "강원";
  codeArr[7] = "영월군";
  codeNameArr[7] = "영월군";

  codeTypeArr[8] = "강원";
  codeArr[8] = "원주시";
  codeNameArr[8] = "원주시";

  codeTypeArr[9] = "강원";
  codeArr[9] = "인제군";
  codeNameArr[9] = "인제군";

  codeTypeArr[10] = "강원";
  codeArr[10] = "정선군";
  codeNameArr[10] = "정선군";

  codeTypeArr[11] = "강원";
  codeArr[11] = "철원군";
  codeNameArr[11] = "철원군";

  codeTypeArr[12] = "강원";
  codeArr[12] = "춘천시";
  codeNameArr[12] = "춘천시";

  codeTypeArr[13] = "강원";
  codeArr[13] = "태백시";
  codeNameArr[13] = "태백시";

  codeTypeArr[14] = "강원";
  codeArr[14] = "평창군";
  codeNameArr[14] = "평창군";

  codeTypeArr[15] = "강원";
  codeArr[15] = "홍천군";
  codeNameArr[15] = "홍천군";

  codeTypeArr[16] = "강원";
  codeArr[16] = "화천군";
  codeNameArr[16] = "화천군";

  codeTypeArr[17] = "강원";
  codeArr[17] = "횡성군";
  codeNameArr[17] = "횡성군";

  codeTypeArr[18] = "경기";
  codeArr[18] = "가평군";
  codeNameArr[18] = "가평군";

  codeTypeArr[19] = "경기";
  codeArr[19] = "고양시 덕양구";
  codeNameArr[19] = "고양시 덕양구";

  codeTypeArr[20] = "경기";
  codeArr[20] = "고양시 일산동구";
  codeNameArr[20] = "고양시 일산동구";

  codeTypeArr[21] = "경기";
  codeArr[21] = "고양시 일산서구";
  codeNameArr[21] = "고양시 일산서구";

  codeTypeArr[22] = "경기";
  codeArr[22] = "과천시";
  codeNameArr[22] = "과천시";

  codeTypeArr[23] = "경기";
  codeArr[23] = "광명시";
  codeNameArr[23] = "광명시";

  codeTypeArr[24] = "경기";
  codeArr[24] = "광주시";
  codeNameArr[24] = "광주시";

  codeTypeArr[25] = "경기";
  codeArr[25] = "구리시";
  codeNameArr[25] = "구리시";

  codeTypeArr[26] = "경기";
  codeArr[26] = "군포시";
  codeNameArr[26] = "군포시";

  codeTypeArr[27] = "경기";
  codeArr[27] = "김포시";
  codeNameArr[27] = "김포시";

  codeTypeArr[28] = "경기";
  codeArr[28] = "남양주시";
  codeNameArr[28] = "남양주시";

  codeTypeArr[29] = "경기";
  codeArr[29] = "동두천시";
  codeNameArr[29] = "동두천시";

  codeTypeArr[30] = "경기";
  codeArr[30] = "부천시 소사구";
  codeNameArr[30] = "부천시 소사구";

  codeTypeArr[31] = "경기";
  codeArr[31] = "부천시 오정구";
  codeNameArr[31] = "부천시 오정구";

  codeTypeArr[32] = "경기";
  codeArr[32] = "부천시 원미구";
  codeNameArr[32] = "부천시 원미구";

  codeTypeArr[33] = "경기";
  codeArr[33] = "성남시 분당구";
  codeNameArr[33] = "성남시 분당구";

  codeTypeArr[34] = "경기";
  codeArr[34] = "성남시 수정구";
  codeNameArr[34] = "성남시 수정구";

  codeTypeArr[35] = "경기";
  codeArr[35] = "성남시 중원구";
  codeNameArr[35] = "성남시 중원구";

  codeTypeArr[36] = "경기";
  codeArr[36] = "수원시 권선구";
  codeNameArr[36] = "수원시 권선구";

  codeTypeArr[37] = "경기";
  codeArr[37] = "수원시 영통구";
  codeNameArr[37] = "수원시 영통구";

  codeTypeArr[38] = "경기";
  codeArr[38] = "수원시 장안구";
  codeNameArr[38] = "수원시 장안구";

  codeTypeArr[39] = "경기";
  codeArr[39] = "수원시 팔달구";
  codeNameArr[39] = "수원시 팔달구";

  codeTypeArr[40] = "경기";
  codeArr[40] = "시흥시";
  codeNameArr[40] = "시흥시";

  codeTypeArr[41] = "경기";
  codeArr[41] = "안산시 단원구";
  codeNameArr[41] = "안산시 단원구";

  codeTypeArr[42] = "경기";
  codeArr[42] = "안산시 상록구";
  codeNameArr[42] = "안산시 상록구";

  codeTypeArr[43] = "경기";
  codeArr[43] = "안성시";
  codeNameArr[43] = "안성시";

  codeTypeArr[44] = "경기";
  codeArr[44] = "안양시 동안구";
  codeNameArr[44] = "안양시 동안구";

  codeTypeArr[45] = "경기";
  codeArr[45] = "안양시 만안구";
  codeNameArr[45] = "안양시 만안구";

  codeTypeArr[46] = "경기";
  codeArr[46] = "양주시";
  codeNameArr[46] = "양주시";

  codeTypeArr[47] = "경기";
  codeArr[47] = "양평군";
  codeNameArr[47] = "양평군";

  codeTypeArr[48] = "경기";
  codeArr[48] = "여주군";
  codeNameArr[48] = "여주군";

  codeTypeArr[49] = "경기";
  codeArr[49] = "연천군";
  codeNameArr[49] = "연천군";

  codeTypeArr[50] = "경기";
  codeArr[50] = "오산시";
  codeNameArr[50] = "오산시";

  codeTypeArr[51] = "경기";
  codeArr[51] = "용인시 기흥구";
  codeNameArr[51] = "용인시 기흥구";

  codeTypeArr[52] = "경기";
  codeArr[52] = "용인시 수지구";
  codeNameArr[52] = "용인시 수지구";

  codeTypeArr[53] = "경기";
  codeArr[53] = "용인시 처인구";
  codeNameArr[53] = "용인시 처인구";

  codeTypeArr[54] = "경기";
  codeArr[54] = "의왕시";
  codeNameArr[54] = "의왕시";

  codeTypeArr[55] = "경기";
  codeArr[55] = "의정부시";
  codeNameArr[55] = "의정부시";

  codeTypeArr[56] = "경기";
  codeArr[56] = "이천시";
  codeNameArr[56] = "이천시";

  codeTypeArr[57] = "경기";
  codeArr[57] = "파주시";
  codeNameArr[57] = "파주시";

  codeTypeArr[58] = "경기";
  codeArr[58] = "평택시";
  codeNameArr[58] = "평택시";

  codeTypeArr[59] = "경기";
  codeArr[59] = "포천시";
  codeNameArr[59] = "포천시";

  codeTypeArr[60] = "경기";
  codeArr[60] = "하남시";
  codeNameArr[60] = "하남시";

  codeTypeArr[61] = "경기";
  codeArr[61] = "화성시";
  codeNameArr[61] = "화성시";

  codeTypeArr[62] = "경남";
  codeArr[62] = "거제시";
  codeNameArr[62] = "거제시";

  codeTypeArr[63] = "경남";
  codeArr[63] = "거창군";
  codeNameArr[63] = "거창군";

  codeTypeArr[64] = "경남";
  codeArr[64] = "고성군";
  codeNameArr[64] = "고성군";

  codeTypeArr[65] = "경남";
  codeArr[65] = "김해시";
  codeNameArr[65] = "김해시";

  codeTypeArr[66] = "경남";
  codeArr[66] = "남해군";
  codeNameArr[66] = "남해군";

  codeTypeArr[67] = "경남";
  codeArr[67] = "밀양시";
  codeNameArr[67] = "밀양시";

  codeTypeArr[68] = "경남";
  codeArr[68] = "사천시";
  codeNameArr[68] = "사천시";

  codeTypeArr[69] = "경남";
  codeArr[69] = "산청군";
  codeNameArr[69] = "산청군";

  codeTypeArr[70] = "경남";
  codeArr[70] = "양산시";
  codeNameArr[70] = "양산시";

  codeTypeArr[71] = "경남";
  codeArr[71] = "의령군";
  codeNameArr[71] = "의령군";

  codeTypeArr[72] = "경남";
  codeArr[72] = "진주시";
  codeNameArr[72] = "진주시";

  codeTypeArr[73] = "경남";
  codeArr[73] = "창녕군";
  codeNameArr[73] = "창녕군";

  codeTypeArr[74] = "경남";
  codeArr[74] = "창원시 마산합포구";
  codeNameArr[74] = "창원시 마산합포구";

  codeTypeArr[75] = "경남";
  codeArr[75] = "창원시 마산회원구";
  codeNameArr[75] = "창원시 마산회원구";

  codeTypeArr[76] = "경남";
  codeArr[76] = "창원시 성산구";
  codeNameArr[76] = "창원시 성산구";

  codeTypeArr[77] = "경남";
  codeArr[77] = "창원시 의창구";
  codeNameArr[77] = "창원시 의창구";

  codeTypeArr[78] = "경남";
  codeArr[78] = "창원시 진해구";
  codeNameArr[78] = "창원시 진해구";

  codeTypeArr[79] = "경남";
  codeArr[79] = "통영시";
  codeNameArr[79] = "통영시";

  codeTypeArr[80] = "경남";
  codeArr[80] = "하동군";
  codeNameArr[80] = "하동군";

  codeTypeArr[81] = "경남";
  codeArr[81] = "함안군";
  codeNameArr[81] = "함안군";

  codeTypeArr[82] = "경남";
  codeArr[82] = "함양군";
  codeNameArr[82] = "함양군";

  codeTypeArr[83] = "경남";
  codeArr[83] = "합천군";
  codeNameArr[83] = "합천군";

  codeTypeArr[84] = "경북";
  codeArr[84] = "경산시";
  codeNameArr[84] = "경산시";

  codeTypeArr[85] = "경북";
  codeArr[85] = "경주시";
  codeNameArr[85] = "경주시";

  codeTypeArr[86] = "경북";
  codeArr[86] = "고령군";
  codeNameArr[86] = "고령군";

  codeTypeArr[87] = "경북";
  codeArr[87] = "구미시";
  codeNameArr[87] = "구미시";

  codeTypeArr[88] = "경북";
  codeArr[88] = "군위군";
  codeNameArr[88] = "군위군";

  codeTypeArr[89] = "경북";
  codeArr[89] = "김천시";
  codeNameArr[89] = "김천시";

  codeTypeArr[90] = "경북";
  codeArr[90] = "문경시";
  codeNameArr[90] = "문경시";

  codeTypeArr[91] = "경북";
  codeArr[91] = "봉화군";
  codeNameArr[91] = "봉화군";

  codeTypeArr[92] = "경북";
  codeArr[92] = "상주시";
  codeNameArr[92] = "상주시";

  codeTypeArr[93] = "경북";
  codeArr[93] = "성주군";
  codeNameArr[93] = "성주군";

  codeTypeArr[94] = "경북";
  codeArr[94] = "안동시";
  codeNameArr[94] = "안동시";

  codeTypeArr[95] = "경북";
  codeArr[95] = "영덕군";
  codeNameArr[95] = "영덕군";

  codeTypeArr[96] = "경북";
  codeArr[96] = "영양군";
  codeNameArr[96] = "영양군";

  codeTypeArr[97] = "경북";
  codeArr[97] = "영주시";
  codeNameArr[97] = "영주시";

  codeTypeArr[98] = "경북";
  codeArr[98] = "영천시";
  codeNameArr[98] = "영천시";

  codeTypeArr[99] = "경북";
  codeArr[99] = "예천군";
  codeNameArr[99] = "예천군";

  codeTypeArr[100] = "경북";
  codeArr[100] = "울릉군";
  codeNameArr[100] = "울릉군";

  codeTypeArr[101] = "경북";
  codeArr[101] = "울진군";
  codeNameArr[101] = "울진군";

  codeTypeArr[102] = "경북";
  codeArr[102] = "의성군";
  codeNameArr[102] = "의성군";

  codeTypeArr[103] = "경북";
  codeArr[103] = "청도군";
  codeNameArr[103] = "청도군";

  codeTypeArr[104] = "경북";
  codeArr[104] = "청송군";
  codeNameArr[104] = "청송군";

  codeTypeArr[105] = "경북";
  codeArr[105] = "칠곡군";
  codeNameArr[105] = "칠곡군";

  codeTypeArr[106] = "경북";
  codeArr[106] = "포항시 남구";
  codeNameArr[106] = "포항시 남구";

  codeTypeArr[107] = "경북";
  codeArr[107] = "포항시 북구";
  codeNameArr[107] = "포항시 북구";

  codeTypeArr[108] = "광주";
  codeArr[108] = "광산구";
  codeNameArr[108] = "광산구";

  codeTypeArr[109] = "광주";
  codeArr[109] = "남구";
  codeNameArr[109] = "남구";

  codeTypeArr[110] = "광주";
  codeArr[110] = "동구";
  codeNameArr[110] = "동구";

  codeTypeArr[111] = "광주";
  codeArr[111] = "북구";
  codeNameArr[111] = "북구";

  codeTypeArr[112] = "광주";
  codeArr[112] = "서구";
  codeNameArr[112] = "서구";

  codeTypeArr[113] = "대구";
  codeArr[113] = "남구";
  codeNameArr[113] = "남구";

  codeTypeArr[114] = "대구";
  codeArr[114] = "달서구";
  codeNameArr[114] = "달서구";

  codeTypeArr[115] = "대구";
  codeArr[115] = "달성군";
  codeNameArr[115] = "달성군";

  codeTypeArr[116] = "대구";
  codeArr[116] = "동구";
  codeNameArr[116] = "동구";

  codeTypeArr[117] = "대구";
  codeArr[117] = "북구";
  codeNameArr[117] = "북구";

  codeTypeArr[118] = "대구";
  codeArr[118] = "서구";
  codeNameArr[118] = "서구";

  codeTypeArr[119] = "대구";
  codeArr[119] = "수성구";
  codeNameArr[119] = "수성구";

  codeTypeArr[120] = "대구";
  codeArr[120] = "중구";
  codeNameArr[120] = "중구";

  codeTypeArr[121] = "대전";
  codeArr[121] = "대덕구";
  codeNameArr[121] = "대덕구";

  codeTypeArr[122] = "대전";
  codeArr[122] = "동구";
  codeNameArr[122] = "동구";

  codeTypeArr[123] = "대전";
  codeArr[123] = "서구";
  codeNameArr[123] = "서구";

  codeTypeArr[124] = "대전";
  codeArr[124] = "유성구";
  codeNameArr[124] = "유성구";

  codeTypeArr[125] = "대전";
  codeArr[125] = "중구";
  codeNameArr[125] = "중구";

  codeTypeArr[126] = "부산";
  codeArr[126] = "강서구";
  codeNameArr[126] = "강서구";

  codeTypeArr[127] = "부산";
  codeArr[127] = "금정구";
  codeNameArr[127] = "금정구";

  codeTypeArr[128] = "부산";
  codeArr[128] = "기장군";
  codeNameArr[128] = "기장군";

  codeTypeArr[129] = "부산";
  codeArr[129] = "남구";
  codeNameArr[129] = "남구";

  codeTypeArr[130] = "부산";
  codeArr[130] = "동구";
  codeNameArr[130] = "동구";

  codeTypeArr[131] = "부산";
  codeArr[131] = "동래구";
  codeNameArr[131] = "동래구";

  codeTypeArr[132] = "부산";
  codeArr[132] = "부산진구";
  codeNameArr[132] = "부산진구";

  codeTypeArr[133] = "부산";
  codeArr[133] = "북구";
  codeNameArr[133] = "북구";

  codeTypeArr[134] = "부산";
  codeArr[134] = "사상구";
  codeNameArr[134] = "사상구";

  codeTypeArr[135] = "부산";
  codeArr[135] = "사하구";
  codeNameArr[135] = "사하구";

  codeTypeArr[136] = "부산";
  codeArr[136] = "서구";
  codeNameArr[136] = "서구";

  codeTypeArr[137] = "부산";
  codeArr[137] = "수영구";
  codeNameArr[137] = "수영구";

  codeTypeArr[138] = "부산";
  codeArr[138] = "연제구";
  codeNameArr[138] = "연제구";

  codeTypeArr[139] = "부산";
  codeArr[139] = "영도구";
  codeNameArr[139] = "영도구";

  codeTypeArr[140] = "부산";
  codeArr[140] = "중구";
  codeNameArr[140] = "중구";

  codeTypeArr[141] = "부산";
  codeArr[141] = "해운대구";
  codeNameArr[141] = "해운대구";

  codeTypeArr[142] = "서울";
  codeArr[142] = "강남구";
  codeNameArr[142] = "강남구";

  codeTypeArr[143] = "서울";
  codeArr[143] = "강동구";
  codeNameArr[143] = "강동구";

  codeTypeArr[144] = "서울";
  codeArr[144] = "강북구";
  codeNameArr[144] = "강북구";

  codeTypeArr[145] = "서울";
  codeArr[145] = "강서구";
  codeNameArr[145] = "강서구";

  codeTypeArr[146] = "서울";
  codeArr[146] = "관악구";
  codeNameArr[146] = "관악구";

  codeTypeArr[147] = "서울";
  codeArr[147] = "광진구";
  codeNameArr[147] = "광진구";

  codeTypeArr[148] = "서울";
  codeArr[148] = "구로구";
  codeNameArr[148] = "구로구";

  codeTypeArr[149] = "서울";
  codeArr[149] = "금천구";
  codeNameArr[149] = "금천구";

  codeTypeArr[150] = "서울";
  codeArr[150] = "노원구";
  codeNameArr[150] = "노원구";

  codeTypeArr[151] = "서울";
  codeArr[151] = "도봉구";
  codeNameArr[151] = "도봉구";

  codeTypeArr[152] = "서울";
  codeArr[152] = "동대문구";
  codeNameArr[152] = "동대문구";

  codeTypeArr[153] = "서울";
  codeArr[153] = "동작구";
  codeNameArr[153] = "동작구";

  codeTypeArr[154] = "서울";
  codeArr[154] = "마포구";
  codeNameArr[154] = "마포구";

  codeTypeArr[155] = "서울";
  codeArr[155] = "서대문구";
  codeNameArr[155] = "서대문구";

  codeTypeArr[156] = "서울";
  codeArr[156] = "서초구";
  codeNameArr[156] = "서초구";

  codeTypeArr[157] = "서울";
  codeArr[157] = "성동구";
  codeNameArr[157] = "성동구";

  codeTypeArr[158] = "서울";
  codeArr[158] = "성북구";
  codeNameArr[158] = "성북구";

  codeTypeArr[159] = "서울";
  codeArr[159] = "송파구";
  codeNameArr[159] = "송파구";

  codeTypeArr[160] = "서울";
  codeArr[160] = "양천구";
  codeNameArr[160] = "양천구";

  codeTypeArr[161] = "서울";
  codeArr[161] = "영등포구";
  codeNameArr[161] = "영등포구";

  codeTypeArr[162] = "서울";
  codeArr[162] = "용산구";
  codeNameArr[162] = "용산구";

  codeTypeArr[163] = "서울";
  codeArr[163] = "은평구";
  codeNameArr[163] = "은평구";

  codeTypeArr[164] = "서울";
  codeArr[164] = "종로구";
  codeNameArr[164] = "종로구";

  codeTypeArr[165] = "서울";
  codeArr[165] = "중구";
  codeNameArr[165] = "중구";

  codeTypeArr[166] = "서울";
  codeArr[166] = "중랑구";
  codeNameArr[166] = "중랑구";

  codeTypeArr[168] = "울산";
  codeArr[168] = "남구";
  codeNameArr[168] = "남구";

  codeTypeArr[169] = "울산";
  codeArr[169] = "동구";
  codeNameArr[169] = "동구";

  codeTypeArr[170] = "울산";
  codeArr[170] = "북구";
  codeNameArr[170] = "북구";

  codeTypeArr[171] = "울산";
  codeArr[171] = "울주군";
  codeNameArr[171] = "울주군";

  codeTypeArr[172] = "울산";
  codeArr[172] = "중구";
  codeNameArr[172] = "중구";

  codeTypeArr[173] = "인천";
  codeArr[173] = "강화군";
  codeNameArr[173] = "강화군";

  codeTypeArr[174] = "인천";
  codeArr[174] = "계양구";
  codeNameArr[174] = "계양구";

  codeTypeArr[175] = "인천";
  codeArr[175] = "남구";
  codeNameArr[175] = "남구";

  codeTypeArr[176] = "인천";
  codeArr[176] = "남동구";
  codeNameArr[176] = "남동구";

  codeTypeArr[177] = "인천";
  codeArr[177] = "동구";
  codeNameArr[177] = "동구";

  codeTypeArr[178] = "인천";
  codeArr[178] = "부평구";
  codeNameArr[178] = "부평구";

  codeTypeArr[179] = "인천";
  codeArr[179] = "서구";
  codeNameArr[179] = "서구";

  codeTypeArr[180] = "인천";
  codeArr[180] = "연수구";
  codeNameArr[180] = "연수구";

  codeTypeArr[181] = "인천";
  codeArr[181] = "옹진군";
  codeNameArr[181] = "옹진군";

  codeTypeArr[182] = "인천";
  codeArr[182] = "중구";
  codeNameArr[182] = "중구";

  codeTypeArr[183] = "전남";
  codeArr[183] = "강진군";
  codeNameArr[183] = "강진군";

  codeTypeArr[184] = "전남";
  codeArr[184] = "고흥군";
  codeNameArr[184] = "고흥군";

  codeTypeArr[185] = "전남";
  codeArr[185] = "곡성군";
  codeNameArr[185] = "곡성군";

  codeTypeArr[186] = "전남";
  codeArr[186] = "광양시";
  codeNameArr[186] = "광양시";

  codeTypeArr[187] = "전남";
  codeArr[187] = "구례군";
  codeNameArr[187] = "구례군";

  codeTypeArr[188] = "전남";
  codeArr[188] = "나주시";
  codeNameArr[188] = "나주시";

  codeTypeArr[189] = "전남";
  codeArr[189] = "담양군";
  codeNameArr[189] = "담양군";

  codeTypeArr[190] = "전남";
  codeArr[190] = "목포시";
  codeNameArr[190] = "목포시";

  codeTypeArr[191] = "전남";
  codeArr[191] = "무안군";
  codeNameArr[191] = "무안군";

  codeTypeArr[192] = "전남";
  codeArr[192] = "보성군";
  codeNameArr[192] = "보성군";

  codeTypeArr[193] = "전남";
  codeArr[193] = "순천시";
  codeNameArr[193] = "순천시";

  codeTypeArr[194] = "전남";
  codeArr[194] = "신안군";
  codeNameArr[194] = "신안군";

  codeTypeArr[195] = "전남";
  codeArr[195] = "여수시";
  codeNameArr[195] = "여수시";

  codeTypeArr[196] = "전남";
  codeArr[196] = "영광군";
  codeNameArr[196] = "영광군";

  codeTypeArr[197] = "전남";
  codeArr[197] = "영암군";
  codeNameArr[197] = "영암군";

  codeTypeArr[198] = "전남";
  codeArr[198] = "완도군";
  codeNameArr[198] = "완도군";

  codeTypeArr[199] = "전남";
  codeArr[199] = "장성군";
  codeNameArr[199] = "장성군";

  codeTypeArr[200] = "전남";
  codeArr[200] = "장흥군";
  codeNameArr[200] = "장흥군";

  codeTypeArr[201] = "전남";
  codeArr[201] = "진도군";
  codeNameArr[201] = "진도군";

  codeTypeArr[202] = "전남";
  codeArr[202] = "함평군";
  codeNameArr[202] = "함평군";

  codeTypeArr[203] = "전남";
  codeArr[203] = "해남군";
  codeNameArr[203] = "해남군";

  codeTypeArr[204] = "전남";
  codeArr[204] = "화순군";
  codeNameArr[204] = "화순군";

  codeTypeArr[205] = "전북";
  codeArr[205] = "고창군";
  codeNameArr[205] = "고창군";

  codeTypeArr[206] = "전북";
  codeArr[206] = "군산시";
  codeNameArr[206] = "군산시";

  codeTypeArr[207] = "전북";
  codeArr[207] = "김제시";
  codeNameArr[207] = "김제시";

  codeTypeArr[208] = "전북";
  codeArr[208] = "남원시";
  codeNameArr[208] = "남원시";

  codeTypeArr[209] = "전북";
  codeArr[209] = "무주군";
  codeNameArr[209] = "무주군";

  codeTypeArr[210] = "전북";
  codeArr[210] = "부안군";
  codeNameArr[210] = "부안군";

  codeTypeArr[211] = "전북";
  codeArr[211] = "순창군";
  codeNameArr[211] = "순창군";

  codeTypeArr[212] = "전북";
  codeArr[212] = "완주군";
  codeNameArr[212] = "완주군";

  codeTypeArr[213] = "전북";
  codeArr[213] = "익산시";
  codeNameArr[213] = "익산시";

  codeTypeArr[214] = "전북";
  codeArr[214] = "임실군";
  codeNameArr[214] = "임실군";

  codeTypeArr[215] = "전북";
  codeArr[215] = "장수군";
  codeNameArr[215] = "장수군";

  codeTypeArr[216] = "전북";
  codeArr[216] = "전주시 덕진구";
  codeNameArr[216] = "전주시 덕진구";

  codeTypeArr[217] = "전북";
  codeArr[217] = "전주시 완산구";
  codeNameArr[217] = "전주시 완산구";

  codeTypeArr[218] = "전북";
  codeArr[218] = "정읍시";
  codeNameArr[218] = "정읍시";

  codeTypeArr[219] = "전북";
  codeArr[219] = "진안군";
  codeNameArr[219] = "진안군";

  codeTypeArr[220] = "제주";
  codeArr[220] = "서귀포시";
  codeNameArr[220] = "서귀포시";

  codeTypeArr[221] = "제주";
  codeArr[221] = "제주시";
  codeNameArr[221] = "제주시";

  codeTypeArr[222] = "충남";
  codeArr[222] = "계룡시";
  codeNameArr[222] = "계룡시";

  codeTypeArr[223] = "충남";
  codeArr[223] = "공주시";
  codeNameArr[223] = "공주시";

  codeTypeArr[224] = "충남";
  codeArr[224] = "금산군";
  codeNameArr[224] = "금산군";

  codeTypeArr[225] = "충남";
  codeArr[225] = "논산시";
  codeNameArr[225] = "논산시";

  codeTypeArr[226] = "충남";
  codeArr[226] = "당진시";
  codeNameArr[226] = "당진시";

  codeTypeArr[227] = "충남";
  codeArr[227] = "보령시";
  codeNameArr[227] = "보령시";

  codeTypeArr[228] = "충남";
  codeArr[228] = "부여군";
  codeNameArr[228] = "부여군";

  codeTypeArr[229] = "충남";
  codeArr[229] = "서산시";
  codeNameArr[229] = "서산시";

  codeTypeArr[230] = "충남";
  codeArr[230] = "서천군";
  codeNameArr[230] = "서천군";

  codeTypeArr[231] = "충남";
  codeArr[231] = "아산시";
  codeNameArr[231] = "아산시";

  codeTypeArr[232] = "충남";
  codeArr[232] = "예산군";
  codeNameArr[232] = "예산군";

  codeTypeArr[233] = "충남";
  codeArr[233] = "천안시 동남구";
  codeNameArr[233] = "천안시 동남구";

  codeTypeArr[234] = "충남";
  codeArr[234] = "천안시 서북구";
  codeNameArr[234] = "천안시 서북구";

  codeTypeArr[235] = "충남";
  codeArr[235] = "청양군";
  codeNameArr[235] = "청양군";

  codeTypeArr[236] = "충남";
  codeArr[236] = "태안군";
  codeNameArr[236] = "태안군";

  codeTypeArr[237] = "충남";
  codeArr[237] = "홍성군";
  codeNameArr[237] = "홍성군";

  codeTypeArr[238] = "충북";
  codeArr[238] = "괴산군";
  codeNameArr[238] = "괴산군";

  codeTypeArr[239] = "충북";
  codeArr[239] = "단양군";
  codeNameArr[239] = "단양군";

  codeTypeArr[240] = "충북";
  codeArr[240] = "보은군";
  codeNameArr[240] = "보은군";

  codeTypeArr[241] = "충북";
  codeArr[241] = "영동군";
  codeNameArr[241] = "영동군";

  codeTypeArr[242] = "충북";
  codeArr[242] = "옥천군";
  codeNameArr[242] = "옥천군";

  codeTypeArr[243] = "충북";
  codeArr[243] = "음성군";
  codeNameArr[243] = "음성군";

  codeTypeArr[244] = "충북";
  codeArr[244] = "제천시";
  codeNameArr[244] = "제천시";

  codeTypeArr[245] = "충북";
  codeArr[245] = "증평군";
  codeNameArr[245] = "증평군";

  codeTypeArr[246] = "충북";
  codeArr[246] = "진천군";
  codeNameArr[246] = "진천군";

  codeTypeArr[247] = "충북";
  codeArr[247] = "청원군";
  codeNameArr[247] = "청원군";

  codeTypeArr[248] = "충북";
  codeArr[248] = "청주시 상당구";
  codeNameArr[248] = "청주시 상당구";

  codeTypeArr[249] = "충북";
  codeArr[249] = "청주시 흥덕구";
  codeNameArr[249] = "청주시 흥덕구";

  codeTypeArr[250] = "충북";
  codeArr[250] = "충주시";
  codeNameArr[250] = "충주시";

  //특정 채널을 선택하면 해당 카테고리를 생성
  function jsGetCode(num)
  {
      //해당 채널의 서브 카테고리 배열 길이만큼 반복
      var idx = 0;
      var frm = document.getElementById("f");
      frm.sigungu.options[idx]=new Option("전체","");

      idx++;
      for(ctr=0;ctr < codeTypeArr.length;ctr++)
      {
         //카테고리에 해당하는 콤보박스의 값을 채움

         if(codeTypeArr[ctr] == num)
         {
             frm.sigungu.options[idx]=new Option(codeNameArr[ctr],codeArr[ctr]);
             idx++;
         }
      }

      frm.sigungu.length = idx;

      if(frm.sido.value=='세종'){
        frm.sigungu.disabled=true;
      }else{
        frm.sigungu.disabled=false;
      }

      var sinx;
      if(initChk){
        // init()함수에서 jsGetCode함수를 호출할 경우 : 받아온 시군구의 값을 선택하고, 아닐 경우는 시군구 전체로 초기화
        for(i=0; i<idx; i++)
        {
        if(frm.sigungu.options[i].value == '<%=request("sigungu")%>')
          {
              sinx =  i;
          }
        }
        initChk =false;
      }else{
        sinx=0;
      }
      frm.sigungu.selectedIndex = sinx;
  }

  function chkcnum(obj) {
      var num="1234567890-";

      for (i=0;i<obj.value.length; i++) {
          if (num.indexOf(obj.value.charAt(i)) < 0) {
          return false;
          }
      }
      return true;
  }

  function eventonblur(img_name,img_url){
      if(img_name.value == ""){
          img_name.style.background="url("+img_url+") no-repeat 3px 5px";
          img_name.style.backgroundColor="#fff";
      }
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

  var initChk =false;
  function init(){
      initChk = true;
      set_value(document.getElementById("f").sido,'<%=request("sido")%>');
      jsGetCode('<%=request("sido")%>');
      document.getElementById("f").keyword.focus();
  }

  function add_openr(form){
    var szvalue = form.zipcode.value.split("-");

    var zipcode1 = szvalue[0];
    var zipcode2 = szvalue[1];
    var address1 = form.address.value;
    var ara_code = form.ara_code.value;

    var object

    if(window.opener && !window.opener.closed) object = opener.document.<%=s_key(0)%>;
    if(object != null && object != undefined){
      if(object.<%=s_key(1)%> != null) object.<%=s_key(1)%>.value = zipcode1;
      if(object.<%=s_key(2)%> != null) object.<%=s_key(2)%>.value = zipcode2;
      if(object.<%=s_key(3)%> != null) object.<%=s_key(3)%>.value = address1;
      if(object.ara_code != null) object.ara_code.value = ara_code;
    }

    window.close();
  }

//]]>
</script>
</head>

<body onload="init();">

<div class="popup_addr_area">
  <h1><img src="/exec/zipcode/img/title_addr_search.gif"  alt="우편번호 검색" /></h1>
  <div class="popup_addr_area_con">
    <ul class="popup_addr_tabmenu">
      <li><a href="road.asp?f_key=<%=f_key%>" onmouseover="togSearchTab('4',event);" onmouseout="togSearchTab('4',event);" onfocus="togSearchTab('4',event);" onblur="togSearchTab('4',event);"><img src="/exec/zipcode/img/search_tab01_off.gif" alt="도로명주소의 우편번호"  id="Stab4"/></a></li>
      <li><a href="jibun.asp?f_key=<%=f_key%>" ><img src="/exec/zipcode/img/search_tab02_on.gif" alt="지번주소 우편번호" id="Stab1" /></a></li>
    </ul>
    <form name="f" id="f" action="jibun.asp" onsubmit="return zip_search()">
    <input type="hidden" name="f_key" value="<%=f_key%>" />
    <input type="hidden" name="keyword_type" value="" />
    <fieldset>
    <legend>상세검색</legend>
    <div class="ZiptopSchbox">
      <dl class="dlline">
        <dt><strong><label for="sido">시도</label></strong></dt>
        <dd>
          <select id="sido" name="sido" class="plantext" onchange="jsGetCode(document.f.sido.value);"  title="시도 선택">
            <option value="">전체</option>
            <option value="서울">서울특별시</option>
            <option value="부산">부산광역시</option>
            <option value="대구">대구광역시</option>
            <option value="인천">인천광역시</option>
            <option value="광주">광주광역시</option>
            <option value="대전">대전광역시</option>
            <option value="울산">울산광역시</option>
            <option value="세종">세종특별자치시</option>
            <option value="강원">강원도</option>
            <option value="경기">경기도</option>
            <option value="경남">경상남도</option>
            <option value="경북">경상북도</option>
            <option value="전남">전라남도</option>
            <option value="전북">전라북도</option>
            <option value="제주">제주특별자치도</option>
            <option value="충남">충청남도</option>
            <option value="충북">충청북도</option>
          </select>
        </dd>
        <dt><strong><label for="sigungu">시군구</label></strong></dt>
        <dd><select id="sigungu" name="sigungu" class="plantext" style="width:120px;"  title="시군구 선택">
        <option value="" >전체</option>
        </select></dd>
        <dd>
          <input name="keyword" id="keyword" type="text" size="17" class="popUpinput" value="<%=request("keyword")%>" title="검색어입력" style="IME-MODE:active;width:120px;<? if (!$keyword) { ?>background:url(/exec/zipcode/img/searchinputbg.gif) #fff no-repeat 3px 5px;<?}?>" onclick="this.style.backgroundImage='';" onkeydown="this.style.backgroundImage='';" onblur="eventonblur(this,'/exec/zipcode/img/searchinputbg.gif');"/>
          <input type="image" src="/exec/zipcode/img/popupbtn_sch.gif" alt="검색" />
        </dd>
      </dl>
      <ul class="search_infoma">
        <li>검색방법 : <strong>충무로1가</strong>(동명), <strong>중앙우체국</strong>(건물명), <strong>100709</strong>(우편번호)</li>
      </ul>
    </div>
    </fieldset>
    </form>

    <div class="divTable2">
      <table width="97%" border="0" cellspacing="0" cellpadding="0" summary="우편번호 검색결과입니다." class="zip ie6">
      <caption>우편번호 검색결과</caption>
      <thead>
        <tr>
          <th scope="col" style="width:11%;" class="div">우편번호</th>
          <th scope="col" style="width:77%;" class="div">주소</th>
          <th scope="col" style="width:12%;">입력</th>
        </tr>
      </thead>
      <tbody>
<%
   ZC_SIDO_CD = "서울,부산,대구,인천,광주,대전,울산,세종,강원,경기,경남,경북,전남,전북,제주,충남,충북"
   ZC_SIDO_NAME = "서울특별시,부산광역시,대구광역시,인천광역시,광주광역시,대전광역시,울산광역시,세종특별자치시,강원도,경기도,경상남도,경상북도,전라남도,전라북도,제주특별자치도,충청남도,충청북도"

   With response
      If Request("keyword") <> "" Then
         keyword = Replace(Request("keyword"),"'","")
         keyword_type = Request("keyword_type")

         Dim Conn, Rs
         Set Conn = Server.CreateObject("ADODB.Connection")
         Conn.Open Application("connect")

         Dim ZIPCODE_LST_Table
         ZIPCODE_LST_Table = "ZIPCODENEW..ZIPCODE_LST"

         Dim ZC_CODE,ZC_NUM,ZC_SIDO,ZC_GUGUN,ZC_DONG,ZC_RI,ZC_DOSE,ZC_BUNJI,ZC_POST,ZC_WDATE
         Dim ZC_ADDR,ARA_CODE

         If keyword_type = "1" Then
            WHERE = "ZC_CODE = '" & keyword & "'"
         Else
            WHERE = "(ZC_DONG LIKE '%" & keyword & "%' OR ZC_RI LIKE '%" & keyword & "%' OR ZC_POST LIKE '%" & keyword & "%')"
         End If

         If request("sido") <> "" Then WHERE = WHERE & " AND ZC_SIDO = '" & f_arr_value(ZC_SIDO_CD, ZC_SIDO_NAME, request("sido")) & "'"
         If request("sigungu") <> "" Then WHERE = WHERE & " AND ZC_GUGUN = '" & request("sigungu") & "'"

         SQL = "SELECT * FROM " & ZIPCODE_LST_Table & " WHERE " & WHERE & " ORDER BY ZC_CODE ASC, ZC_NUM ASC"
         Set Rs = Conn.Execute(SQL, ,adCmdText)

         If Rs.BOF = false AND Rs.EOF = false Then
            Do until Rs.EOF
               i = i + 1

               ZC_CODE = Rs("ZC_CODE")
               ZC_NUM = Rs("ZC_NUM")
               ZC_SIDO = trim(Rs("ZC_SIDO"))
               ZC_GUGUN = trim(Rs("ZC_GUGUN"))
               ZC_DONG = trim(Rs("ZC_DONG"))
               ZC_RI = trim(Rs("ZC_RI"))
               ZC_DOSE = trim(Rs("ZC_DOSE"))
               ZC_BUNJI = Rs("ZC_BUNJI")
               ZC_POST = Rs("ZC_POST")

               'ZC_SIDO = f_arr_value(ZC_SIDO_CD, ZC_SIDO_NAME, ZC_SIDO)

               ZC_WDATE = Rs("ZC_WDATE")
               ZC_ADDR = Rs("ZC_ADDR")
               ARA_CODE = Rs("ARA_CODE")

               ZC_CODE = Left(ZC_CODE,3) & "-" & Right(ZC_CODE,3)
               ZC_ADDR1 = ZC_SIDO & " " & ZC_GUGUN & " " & ZC_DONG
               If ZC_RI <> "" Then ZC_ADDR1 = ZC_ADDR1 & " " & ZC_RI
               If ZC_DOSE <> "" Then ZC_ADDR1 = ZC_ADDR1 & " " & ZC_DOSE
               If ZC_POST <> "" Then ZC_ADDR1 = ZC_ADDR1 & " " & ZC_POST

               i = i + 1
               .write "        <form name='zip_code" & i & "' method='POST'>" & vbNewLine
               .write "        <input type='hidden' name='zipcode' value=""" & ZC_CODE & """>" & vbNewLine
               .write "        <input type='hidden' name='address' value=""" & ZC_ADDR1 & """>" & vbNewLine
               .write "        <input type='hidden' name='ara_code' value=""" & ARA_CODE & """>" & vbNewLine

               .write "            <tr>" & vbNewLine
               .write "              <td style='color:#252525;'>" & ZC_CODE & "</td>" & vbNewLine
               .write "              <td style='text-align:left;padding-left:5px;'>" & ZC_ADDR & "</td>" & vbNewLine
               .write "              <td><a href=""javascript:add_openr(document.zip_code" & i & ");""><img src='/exec/zipcode/img/btn_addr.gif' alt='주소입력' /></a></td>" & vbNewLine
               .write "            </tr></form>" & vbNewLine

               Rs.MoveNext
            Loop
         Else
            .write "            <tr id='inputkey'>" & vbNewLine
            .write "              <td colspan='4' style='padding:15px  0;'><strong> - 검색된 우편번호가 없습니다. -</strong></td>" & vbNewLine
            .write "            </tr>" & vbNewLine
         End If
         Rs.close

         Conn.Close
         Set Conn = nothing
      Else
         .write "            <tr id='inputkey'>" & vbNewLine
         .write "              <td colspan='4' style='padding:15px 0;'><strong> - 검색어를 입력하십시오. -</strong></td>" & vbNewLine
         .write "            </tr>" & vbNewLine
      End if
   End With
%>
      </tbody>
      </table>
      </div>
  </div>
  </div>
</body>
</html>
