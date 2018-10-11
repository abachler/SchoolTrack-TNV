//%attributes = {}
  //KRL_LockedRecordInfos

LOCKED BY:C353($1->;$idprocess;$user;$machine;$processName)
If ((Position:C15(":";$processName)>0) & (($user="") | ($user="Designer")))
	$user:=Substring:C12($processname;Position:C15(":  ";$processname)+2)
End if 
If ($user="")
	$user:=<>tUSR_CurrentUser
End if 
If ($machine="")
	$machine:=Current machine:C483+__ (" (esta misma)")
End if 
OK:=CD_Dlog (0;__ ("El registro de ")+Table name:C256($1)+__ (" está siendo editado por otro usuario. Por favor espere que se libere e intente nuevamente más tarde.\rUsuario: ")+$user+__ ("\rEstación: ")+$machine+__ ("\rProceso: ")+$processName)
