<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/conf/member_config.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ,MEM_NAME,MEM_NICKNAME,MEM_ID,MEM_PWD,MEM_LEVEL,MEM_SEX,MEM_BIRTH
   Dim MEM_CALENDAR,MEM_MARRI_YN,MEM_MERRI_DATE,MEM_HP,MEM_TEL,MEM_FAX,MEM_EMAIL,MEM_CNO,MEM_CNAME,MEM_CSERVICE
   Dim MEM_CITEM,MEM_ZIPCODE,MEM_ADDR1,MEM_ADDR2,MEM_URL,MEM_JOB,MEM_INTEREST,MEM_SMS_YN,MEM_EMAIL_YN,MEM_LOG_IP
   Dim MEM_LOG_DATE,MEM_LOG_CNT,MEM_RECOMM_ID,MEM_MEMO,MEM_ADD1,MEM_ADD2,MEM_ADD3,MEM_ADD4,MEM_SALE,MEM_MONEY
   Dim MEM_WDATE,MEM_MDATE,MEM_STATE,ARA_CODE

   Dim M_ITEM,M_TITLE,M_CONT

   MEM_SEQ = Trim(Request("mem_seq"))
   MEM_NAME = Replace(Trim(Request.Form("mem_name")),"'","''")
   MEM_NICKNAME = Replace(Trim(Request.Form("mem_nickname")),"'","''")
   MEM_ID = Replace(Trim(Request.Form("mem_id")),"'","''")
   MEM_HASH = HASH_TYPE
   MEM_PWD = Replace(Trim(Request.Form("mem_pwd")),"'","''")
   MEM_LEVEL = MC_GROUP
   MEM_SEX = Trim(Request.Form("mem_sex"))
   MEM_BIRTH = Trim(Request.Form("mem_birth"))
   If IsDate(MEM_BIRTH) Then
      MEM_BIRTH = Replace(MEM_BIRTH,"-","")
   Else
      MEM_BIRTH = ""
   End If
   MEM_CALENDAR = Trim(Request.Form("mem_calendar"))
   MEM_MERRI_DATE = Trim(Request.Form("mem_merri_date"))
   If IsDate(MEM_MERRI_DATE) Then
      MEM_MERRI_DATE = Replace(MEM_MERRI_DATE,"-","")
      MEM_MARRI_YN = "1"
   Else
      MEM_MERRI_DATE = ""
      MEM_MARRI_YN = "0"
   End If
   MEM_HP = Replace(Trim(Request.Form("mem_hp")),"'","''")
   MEM_TEL = Replace(Trim(Request.Form("mem_tel")),"'","''")
   MEM_FAX = Replace(Trim(Request.Form("mem_fax")),"'","''")
   MEM_EMAIL = Replace(Trim(Request.form("mem_email")),"'","''")
   MEM_CNO = Replace(Trim(Request.Form("mem_cno")),"'","''")
   MEM_CNAME = Trim(Request.Form("mem_cname"))
   MEM_CSERVICE = Trim(Request.Form("mem_cservice"))
   MEM_CITEM = Trim(Request.Form("mem_citem"))
   MEM_ZIPCODE = Trim(Request.Form("mem_zipcode"))
   MEM_ADDR1 = Replace(Trim(Request.Form("mem_addr1")),"'","''")
   MEM_ADDR2 = Replace(Trim(Request.Form("mem_addr2")),"'","''")
   MEM_URL = Trim(Request.Form("mem_url"))
   MEM_JOB = Trim(Request.Form("mem_job"))
   MEM_INTEREST = Replace(Trim(Request.Form("mem_interest"))," ","")
   MEM_SMS_YN = Trim(Request.Form("mem_sms_yn"))
   MEM_EMAIL_YN = Trim(Request.Form("mem_email_yn"))
   MEM_ADD1 = Replace(Trim(Request.Form("mem_add1")),"'","''")
   MEM_ADD2 = Replace(Trim(Request.Form("mem_add2")),"'","''")
   MEM_ADD3 = Replace(Trim(Request.Form("mem_add3")),"'","''")
   MEM_ADD4 = Replace(Trim(Request.Form("mem_add4")),"'","''")
   MEM_WDATE = NowDate
   MEM_MDATE = NowDate

   If MEM_NAME = "" Then response.end

   If MC_CONFIRM = "1" Then
      MEM_STATE = "00"
   Else
      MEM_STATE = "01"
   End If

   ARA_CODE = Trim(Request.Form("ara_code"))

   If MEM_SMS_YN = "" Then MEM_SMS_YN = "0"
   If MEM_EMAIL_YN = "" Then MEM_EMAIL_YN = "0"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   '############## 트랜잭션시작 #############
   'On Error Resume Next
   'Err.Clear
   sngErrorFound = 0

   Conn.BeginTrans()

   SQL = "SELECT MEM_SEQ FROM " & MEM_LST_Table & " WHERE MEM_ID='" & MEM_ID & "' AND MEM_STATE < '90'"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Page_Msg_Back "사용중인 아이디입니다.\n\n다른 아이디를 입력후 중복확인해 주세요."
      response.end
   End If
   Rs.close

   SQL = "SELECT MEM_SEQ FROM " & MEM_LST_Table & " WHERE MEM_EMAIL='" & MEM_EMAIL & "' AND MEM_STATE < '90'"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Page_Msg_Back "이미 가입된 이메일 입니다.\n\n이메일을 확인하여 주세요."
      Response.end
   End If
   Rs.close

   MEM_PWD = GetHash(MEM_HASH,MEM_PWD)

   SQL = "INSERT INTO " & MEM_LST_Table _
       & " (MEM_NAME,MEM_NICKNAME,MEM_ID,MEM_HASH,MEM_PWD,MEM_LEVEL,MEM_SEX,MEM_BIRTH,MEM_MARRI_YN,MEM_MERRI_DATE,MEM_HP,MEM_TEL,MEM_FAX,MEM_EMAIL,MEM_CNO,MEM_CNAME,MEM_CSERVICE,MEM_CITEM,MEM_ZIPCODE,MEM_ADDR1,MEM_ADDR2,MEM_URL,MEM_JOB,MEM_INTEREST,MEM_SMS_YN,MEM_EMAIL_YN,MEM_MEMO,MEM_ADD1,MEM_ADD2,MEM_ADD3,MEM_ADD4,MEM_WDATE,MEM_MDATE,MEM_STATE,ARA_CODE)" _
       & " VALUES (N'" _
       & MEM_NAME & "',N'" _
       & MEM_NICKNAME & "',N'" _
       & MEM_ID & "',N'" _
       & MEM_HASH & "',N'" _
       & MEM_PWD & "','" _
       & MEM_LEVEL & "','" _
       & MEM_SEX & "','" _
       & MEM_BIRTH & "','" _
       & MEM_MARRI_YN & "','" _
       & MEM_MERRI_DATE & "',N'" _
       & MEM_HP & "',N'" _
       & MEM_TEL & "',N'" _
       & MEM_FAX & "',N'" _
       & MEM_EMAIL & "',N'" _
       & MEM_CNO & "',N'" _
       & MEM_CNAME & "',N'" _
       & MEM_CSERVICE & "',N'" _
       & MEM_CITEM & "','" _
       & MEM_ZIPCODE & "',N'" _
       & MEM_ADDR1 & "',N'" _
       & MEM_ADDR2 & "',N'" _
       & MEM_URL & "',N'" _
       & MEM_JOB & "',N'" _
       & MEM_INTEREST & "','" _
       & MEM_SMS_YN & "','" _
       & MEM_EMAIL_YN & "',N'" _
       & MEM_MEMO & "',N'" _
       & MEM_ADD1 & "',N'" _
       & MEM_ADD2 & "',N'" _
       & MEM_ADD3 & "',N'" _
       & MEM_ADD4 & "','" _
       & MEM_WDATE & "','" _
       & MEM_MDATE & "','" _
       & MEM_STATE & "',N'" _
       & ARA_CODE & "')"

   Conn.Execute SQL, ,adCmdText
   sngErrorFound = sngErrorFound + Conn.Errors.count

   '## 회원시퀸스
   SQL = "SELECT @@IDENTITY AS MEM_SEQ"
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   MEM_SEQ = Rs("MEM_SEQ")
   Rs.close

   If sngErrorFound <> 0 Then
      Conn.RollbackTrans
      Conn.Close
      Set Conn = nothing

      Page_Msg_Back sngErrorFound & "입력 에러 발생!!\n\n잠시후 다시 시도해 주세요."
      Response.End
   Else
      Conn.commitTrans
      Conn.Close
      Set Conn = nothing

      Msg = "회원정보를 등록하였습니다."
      Page_Msg_Parent_ScriptReload MSG
   End If

   Function GetHash(HashType,HashValue)
      If IsNULL(HashType) OR HashType = "" Then
         GetHash = HashValue
      ElseIf HashType = "MySQL4" OR HashType = "MySQL5" Then
         Set Hash = Server.CreateObject("EzWebUtil.Hash")
         GetHash = Hash.GetHash(HashValue,HashType)
         Set Hash = Nothing
      Else
         If HashType = "SHA256" Then HashType = "SHA2_256"
         If HashType = "SHA512" Then HashType = "SHA2_512"

         SQL = "SELECT SubString(master.dbo.fn_varbintohexstr(HashBytes('" & HashType & "', CONVERT(nvarchar(4000),'" & HashValue & "'))), 3, 150) AS HashValue"
         Set Rs = Conn.Execute(SQL, ,adCmdText)
         GetHash = Rs("HashValue")
         Rs.close
      End If
   End Function
%>