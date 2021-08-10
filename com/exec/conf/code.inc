<%
   '##### 관리자
   ADM_STATE_CD = "00,99"
   ADM_STATE_NAME = "정상,삭제"

   ADM_TYPE_CD = "00,01,02,99"
   ADM_TYPE_NAME = "관리자,운영자,부운영자,사용금지"

   ADM_LEVEL_CD = "01,11,21,31,32,33,34"
   ADM_LEVEL_NAME = "CEO,실장,팀장,과장,대리,주임,사원"

   ADM_POST_CD = "01,11,21,31"
   ADM_POST_NAME = "마케팅/기획팀,디자인팀,개발팀,운영지원팀"

   '##### 회원
   MEM_TYPE_CD = "01,02"
   MEM_TYPE_NAME = "개인,기업"

   MEM_STATE_CD = "00,01,91,92,99"
   MEM_STATE_NAME = "미승인,승인,탈퇴,탈퇴,삭제"

   MEM_SEX_CD = "1,2"
   MEM_SEX_NAME = "남,여"

   ARA_SIDO_CD = "01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16"
   ARA_SIDO_NAME = "강원,경기,경남,경북,광주,대구,대전,부산,서울,울산,인천,전남,전북,제주,충남,충북"

   '##### 게시판
   BC_TYPE_CD = "01,02,03,04"
   BC_TYPE_NAME = "일반형,작은이미지,큰이미지,칼럼형"

   '##### 팝업창구분
   P_TYPE_CD = "default,layer,movelayer"
   P_TYPE_NAME = "기본팝업,고정레이어,이동레이어"

   '##### 고객센터
   Q_RTN_MAIL_CD = "1,0"
   Q_RTN_MAIL_NAME = "받습니다,받지않습니다"

   Q_RTN_SMS_CD = "1,0"
   Q_RTN_SMS_NAME = "받습니다,받지않습니다"

   W_RTN_MAIL_CD = "1,0"
   W_RTN_MAIL_NAME = "받습니다,받지않습니다"

   W_RTN_SMS_CD = "1,0"
   W_RTN_SMS_NAME = "받습니다,받지않습니다"

   '##### 코드분류
   CC_TYPE_CD = "EMAIL_SELECT,MEM_SECEDE,F_TYPE,Q_TYPE,C_TYPE,CI_TYPE,CP_TYPE"
   CC_TYPE_NAME = "이메일선택,회원탈퇴사유,FAQ분류,1:1문의분류,온라인문의분류,메뉴분류,페이지분류"
%>
