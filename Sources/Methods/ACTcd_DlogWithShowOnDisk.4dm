//%attributes = {}
  //ACTcd_DlogWithShowOnDisk

C_LONGINT:C283($0;$2;$vl_resp)
C_TEXT:C284($1;$3;$vt_filePath;$vt_message)
$vt_filePath:=$1
$vt_message:=$3
$vl_resp:=CD_Dlog ($2;$vt_message;"";__ ("OK");__ ("Ubicar"))
If ($vl_resp=2)
	  //20120227 RCH ticket 108009. Salio un error al hacer show on disk...
	  //SHOW ON DISK($vt_filePath)
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	SHOW ON DISK:C922($vt_filePath)
	EM_ErrorManager ("Clear")
	If (ok=0)
		CD_Dlog (0;__ ("Se produjo un error al intentar abrir la carpeta que contiene el archivo.")+" "+__ ("Por favor ubique el archivo manualmente en "+SYS_GetParentNme ($vt_filePath)+"."))
	End if 
End if 
$0:=$vl_resp