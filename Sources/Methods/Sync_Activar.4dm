//%attributes = {}
C_BOOLEAN:C305($0;$b_ejecutar)
C_LONGINT:C283($uid)

$b_ejecutar:=False:C215
$uid:=USR_GetUserID 
If ((Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Volume desktop:K5:2))
	  //JHB, COB, LAH, EQR
	  //If (($uid=-2) | ($uid=-703) | ($uid=-101) | ($uid=-1077))
	If ($uid=-2)  //20180404 RCH A pedido de JHB
		  //If (<>GROLBD="QA@")
		$b_ejecutar:=True:C214
		  //End if 
	End if 
Else 
	If (Application type:C494=4D Server:K5:6)
		If (<>bXS_esServidorOficial & (SN3_CheckNotColegium ))  //20151005 RCH Según lo solicitado por JHB
			$b_ejecutar:=True:C214
			Sync_UsarLog (True:C214)
		End if 
	End if 
End if 
$0:=$b_ejecutar