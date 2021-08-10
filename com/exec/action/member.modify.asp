<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/member_config.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MSG,GO_PAGE,PRO_METHOD

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ,MEM_NAME,MEM_NICKNAME,MEM_ID,MEM_PWD,MEM_SEX,MEM_BIRTH
   Dim MEM_CALENDAR,MEM_MARRI_YN,MEM_MERRI_DATE,MEM_HP,MEM_TEL,MEM_FAX,MEM_EMAIL,MEM_CNO,MEM_CNAME,MEM_CSERVICE
   Dim MEM_CITEM,MEM_ZIPCODE,MEM_ADDR1,MEM_ADDR2,MEM_URL,MEM_JOB,MEM_INTEREST,MEM_SMS_YN,MEM_EMAIL_YN,MEM_LOG_IP
   Dim MEM_LOG_DATE,MEM_LOG_CNT,MEM_RECOMM_ID,MEM_MEMO,MEM_ADD1,MEM_ADD2,MEM_ADD3,MEM_ADD4,MEM_SALE,MEM_MONEY
   Dim MEM_WDATE,MEM_MDATE,MEM_STATE,ARA_CODE

   MEM_SEQ = Trim(Request("mem_seq"))
   MEM_NAME = Replace(Trim(Request.Form("mem_name")),"'","''")
   MEM_NICKNAME = Replace(Trim(Request.Form("mem_nickname")),"'","''")
   MEM_ID = Replace(Trim(Request.Form("mem_id")),"'","''")
   MEM_HASH = HASH_TYPE
   MEM_PWD = Replace(Trim(Request.Form("mem_pwd")),"'","''")
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
   MEM_ZIPCODE = Trim(Request.Form("mem_zipcode1")) & Trim(Request.Form("mem_zipcode2"))
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
   MEM_MDATE = NowDate

   ARA_CODE = Trim(Request.Form("ara_code"))

   If MEM_SMS_YN = "" Then MEM_SMS_YN = "0"
   If MEM_EMAIL_YN = "" Then MEM_EMAIL_YN = "0"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT MEM_SEQ FROM " & MEM_LST_Table & " WHERE MEM_EMAIL='" & MEM_EMAIL & "' AND MEM_SEQ <> " & MEM_SEQ & " AND MEM_STATE < '90'"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Page_Msg_Back "사용중인 이메일 입니다.\n\n다른 이메일을 입력후 중복확인해 주세요."
      response.end
   End If
   Rs.close

   If MEM_PWD <> "" Then
      MEM_PWD = GetHash(MEM_HASH,MEM_PWD)
      UPSQL = UPSQL & "MEM_HASH=N'" & MEM_HASH & "', "
      UPSQL = UPSQL & "MEM_PWD=N'" & MEM_PWD & "', "
   End If

   If MUSE_NICKNAME = "1" Then UPSQL = UPSQL & "MEM_NICKNAME=N'" & MEM_NICKNAME & "', "
   If MUSE_BIRTH = "1" Then UPSQL = UPSQL & "MEM_BIRTH='" & MEM_BIRTH & "', "
   If MUSE_SEX = "1" Then UPSQL = UPSQL & "MEM_SEX='" & MEM_SEX & "', "
   If MUSE_HP = "1" Then UPSQL = UPSQL & "MEM_HP='" & MEM_HP & "', "
   If MUSE_TEL = "1" Then UPSQL = UPSQL & "MEM_TEL='" & MEM_TEL & "', "
   If MUSE_FAX = "1" Then UPSQL = UPSQL & "MEM_FAX='" & MEM_FAX & "', "
   If MUSE_EMAIL = "1" Then UPSQL = UPSQL & "MEM_EMAIL=N'" & MEM_EMAIL & "', "
   If MUSE_ADDR = "1" Then UPSQL = UPSQL & "MEM_ZIPCODE='" & MEM_ZIPCODE & "', "
   If MUSE_ADDR = "1" Then UPSQL = UPSQL & "MEM_ADDR1=N'" & MEM_ADDR1 & "', "
   If MUSE_ADDR = "1" Then UPSQL = UPSQL & "MEM_ADDR2=N'" & MEM_ADDR2 & "', "
   If MUSE_EMAIL_YN = "1" Then UPSQL = UPSQL & "MEM_EMAIL_YN='" & MEM_EMAIL_YN & "', "
   If MUSE_SMS_YN = "1" Then UPSQL = UPSQL & "MEM_SMS_YN='" & MEM_SMS_YN & "', "
   If MUSE_CNO = "1" Then UPSQL = UPSQL & "MEM_CNO='" & MEM_CNO & "', "
   If MUSE_CNAME = "1" Then UPSQL = UPSQL & "MEM_CNAME=N'" & MEM_CNAME & "', "
   If MUSE_CSERVICE = "1" Then UPSQL = UPSQL & "MEM_CSERVICE=N'" & MEM_CSERVICE & "', "
   If MUSE_CITEM = "1" Then UPSQL = UPSQL & "MEM_CITEM=N'" & MEM_CITEM & "', "
   If MUSE_MERRI_DATE = "1" Then UPSQL = UPSQL & "MEM_MARRI_YN='" & MEM_MARRI_YN & "', "
   If MUSE_MERRI_DATE = "1" Then UPSQL = UPSQL & "MEM_MERRI_DATE='" & MEM_MERRI_DATE & "', "

   If MUSE_URL = "1" Then UPSQL = UPSQL & "MEM_URL=N'" & MEM_URL & "', "
   If MUSE_JOB = "1" Then UPSQL = UPSQL & "MEM_JOB=N'" & MEM_JOB & "', "
   If MUSE_INTEREST = "1" Then UPSQL = UPSQL & "MEM_INTEREST=N'" & MEM_INTEREST & "', "

   If MUSE_ADD1 = "1" Then UPSQL = UPSQL & "MEM_ADD1=N'" & MEM_ADD1 & "', "
   If MUSE_ADD2 = "1" Then UPSQL = UPSQL & "MEM_ADD2=N'" & MEM_ADD2 & "', "
   If MUSE_ADD3 = "1" Then UPSQL = UPSQL & "MEM_ADD3=N'" & MEM_ADD3 & "', "
   If MUSE_ADD4 = "1" Then UPSQL = UPSQL & "MEM_ADD4=N'" & MEM_ADD4 & "', "

   If ARA_CODE <> "" Then UPSQL = UPSQL & "ARA_CODE=N'" & ARA_CODE & "', "

   SQL = "UPDATE " & MEM_LST_Table & " SET " & UPSQL _
       & "MEM_MDATE='" & MEM_MDATE & "' " _
       & "WHERE MEM_SEQ=" & MEM_SEQ

   Conn.Execute SQL, ,adCmdText

   Conn.Close
   Set Conn = nothing

   Page_Msg_Href "회원정보를 수정하였습니다.", "?method=modify"
   response.end

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