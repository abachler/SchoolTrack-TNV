//%attributes = {}
  //NET_PROXY_Settings

C_BLOB:C604($vx_Blob)
SET BLOB SIZE:C606($vx_Blob;0)
C_TEXT:C284($1;$vt_action)
C_POINTER:C301($2)
C_REAL:C285($OT_Object_Ref)

If (Count parameters:C259>=1)
	$vt_action:=$1
End if 
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_action="DeclareVars")
		C_TEXT:C284(<>vt_SNT_Proxy_Host;<>vt_SNT_Proxy_UserID;<>vt_SNT_Proxy_Password)
		C_LONGINT:C283(<>vl_SNT_Proxy_IsSocks;<>vl_SNT_Proxy_ServerPort)
		
	: ($vt_action="GetBlob")
		$OT_Object_Ref:=OT New 
		OT PutText ($OT_Object_Ref;"vt_SNT_Proxy_Host";<>vt_SNT_Proxy_Host)
		OT PutLong ($OT_Object_Ref;"vl_SNT_Proxy_ServerPort";<>vl_SNT_Proxy_ServerPort)
		OT PutLong ($OT_Object_Ref;"vl_SNT_Proxy_IsSocks";<>vl_SNT_Proxy_IsSocks)
		OT PutText ($OT_Object_Ref;"vt_SNT_Proxy_UserID";<>vt_SNT_Proxy_UserID)
		OT PutText ($OT_Object_Ref;"vt_SNT_Proxy_Password";<>vt_SNT_Proxy_Password)
		$ptr1->:=OT ObjectToNewBLOB ($OT_Object_Ref)
		OT Clear ($OT_Object_Ref)
		
	: ($vt_action="Save")
		NET_PROXY_Settings ("DeclareVars")
		NET_PROXY_Settings ("GetBlob";->$vx_Blob)
		PREF_SetBlob (0;"NET_PROXY_Settings";$vx_Blob)
		
	: ($vt_action="Read")
		$OT_Object_Ref:=OT New 
		NET_PROXY_Settings ("GetBlob";->$vx_Blob)
		$vx_Blob:=PREF_fGetBlob (0;"NET_PROXY_Settings";$vx_Blob)
		$OT_Object_Ref:=OT BLOBToObject ($vx_Blob)
		<>vt_SNT_Proxy_Host:=OT GetText ($OT_Object_Ref;"vt_SNT_Proxy_Host")
		<>vl_SNT_Proxy_ServerPort:=OT GetLong ($OT_Object_Ref;"vl_SNT_Proxy_ServerPort")
		<>vl_SNT_Proxy_IsSocks:=OT GetLong ($OT_Object_Ref;"vl_SNT_Proxy_IsSocks")
		<>vt_SNT_Proxy_UserID:=OT GetText ($OT_Object_Ref;"vt_SNT_Proxy_UserID")
		<>vt_SNT_Proxy_Password:=OT GetText ($OT_Object_Ref;"vt_SNT_Proxy_Password")
		OT Clear ($OT_Object_Ref)
		
End case 
SET BLOB SIZE:C606($vx_Blob;0)
