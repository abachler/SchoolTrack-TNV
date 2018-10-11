//%attributes = {}
  //CMT_FTP_Settings

C_BLOB:C604($vx_Blob)
SET BLOB SIZE:C606($vx_Blob;0)
C_TEXT:C284($1;$vt_action)
C_POINTER:C301($2)
C_REAL:C285($OT_Object_Ref)
C_TEXT:C284($3;$aplicacion)

If (Count parameters:C259>=1)
	$vt_action:=$1
End if 
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$aplicacion:=$3
End if 


Case of 
	: ($vt_action="DeclareVars")
		C_TEXT:C284(<>vt_CMT_FTP_ServerAddres;<>vt_CMT_FTP_Login;<>vt_CMT_FTP_Password)
		C_LONGINT:C283(<>vl_CMT_FTP_ServerPort;<>vl_CMT_FTP_Passive)
		C_LONGINT:C283(<>vl_CMT_OnOff)
		
	: ($vt_action="InitVars")
		CMT_FTP_Settings ("DeclareVars")
		If (<>vt_CMT_FTP_ServerAddres="")
			Case of 
				: ($aplicacion="CMT")
					<>vt_CMT_FTP_ServerAddres:="ftp.colegium.com"
					<>vl_CMT_FTP_ServerPort:=21
					<>vt_CMT_FTP_Login:="SchoolTrack"
					<>vt_CMT_FTP_Password:="quasimodo"
				: ($aplicacion="STS")
					<>vt_CMT_FTP_ServerAddres:="ftp.admissionet.cl"
					<>vl_CMT_FTP_ServerPort:=21
					<>vt_CMT_FTP_Login:="admnet"
					<>vt_CMT_FTP_Password:="adm090221"
			End case 
		End if 
		
	: ($vt_action="GetBlob")
		CMT_FTP_Settings ("InitVars")
		$OT_Object_Ref:=OT New 
		OT PutText ($OT_Object_Ref;"vt_CMT_FTP_ServerAddres";<>vt_CMT_FTP_ServerAddres)
		OT PutLong ($OT_Object_Ref;"vl_CMT_FTP_ServerPort";<>vl_CMT_FTP_ServerPort)
		OT PutLong ($OT_Object_Ref;"vl_CMT_FTP_Passive";<>vl_CMT_FTP_Passive)
		OT PutText ($OT_Object_Ref;"vt_CMT_FTP_Login";<>vt_CMT_FTP_Login)
		OT PutText ($OT_Object_Ref;"vt_CMT_FTP_Password";<>vt_CMT_FTP_Password)
		$ptr1->:=OT ObjectToNewBLOB ($OT_Object_Ref)
		OT Clear ($OT_Object_Ref)
		
	: ($vt_action="Save")
		CMT_FTP_Settings ("GetBlob";->$vx_Blob)
		PREF_SetBlob (0;"CMT_FTP_Settings";$vx_Blob)
		PREF_Set (0;"CMT_ONOFF";String:C10(<>vl_CMT_OnOff))
		
	: ($vt_action="Read")
		$OT_Object_Ref:=OT New 
		CMT_FTP_Settings ("GetBlob";->$vx_Blob)
		$vx_Blob:=PREF_fGetBlob (0;"CMT_FTP_Settings";$vx_Blob)
		$OT_Object_Ref:=OT BLOBToObject ($vx_Blob)
		<>vt_CMT_FTP_ServerAddres:=OT GetText ($OT_Object_Ref;"vt_CMT_FTP_ServerAddres")
		<>vl_CMT_FTP_ServerPort:=OT GetLong ($OT_Object_Ref;"vl_CMT_FTP_ServerPort")
		<>vl_CMT_FTP_Passive:=OT GetLong ($OT_Object_Ref;"vl_CMT_FTP_Passive")
		<>vt_CMT_FTP_Login:=OT GetText ($OT_Object_Ref;"vt_CMT_FTP_Login")
		<>vt_CMT_FTP_Password:=OT GetText ($OT_Object_Ref;"vt_CMT_FTP_Password")
		OT Clear ($OT_Object_Ref)
		<>vl_CMT_OnOff:=Num:C11(PREF_fGet (0;"CMT_ONOFF";String:C10(<>vl_CMT_OnOff)))
		Case of 
			: ($aplicacion="CMT")
				<>vt_CMT_FTP_ServerAddres:="ftp.colegium.com"
				<>vl_CMT_FTP_ServerPort:=21
				<>vt_CMT_FTP_Login:="SchoolTrack"
				<>vt_CMT_FTP_Password:="quasimodo"
			: ($aplicacion="STS")
				<>vt_CMT_FTP_ServerAddres:="ftp.admissionnet.cl"
				<>vl_CMT_FTP_ServerPort:=21
				<>vt_CMT_FTP_Login:="admnet"
				<>vt_CMT_FTP_Password:="adm090221"
		End case 
End case 
SET BLOB SIZE:C606($vx_Blob;0)






