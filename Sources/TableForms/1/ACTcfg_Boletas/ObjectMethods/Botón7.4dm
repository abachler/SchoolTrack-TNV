ACTfear_OpcionesGenerales ("GuardaBlob";->vlACT_RSSel)
IT_MODIFIERS 
If ((<>Command) & (<>CapsLock) & (<>Shift))
	C_DATE:C307($d_currDate)
	C_TIME:C306($h_currTime)
	C_TEXT:C284($t_dtsAhora)
	C_BLOB:C604($xBlob)
	$d_currDate:=Current date:C33
	$h_currTime:=Current time:C178
	$t_dtsAhora:=DTS_MakeFromDateTime ($d_currDate;$h_currTime)
	vtACT_errorPHPExec:=ACTfear_GeneraTRA (vlACT_RSSel;True:C214;->$xBlob;$t_dtsAhora)
Else 
	vtACT_errorPHPExec:=ACTfear_GeneraTRA (vlACT_RSSel;False:C215)
End if 
If (vtACT_errorPHPExec="")
	OBJECT SET VISIBLE:C603(*;"vt_TRA";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"vt_TRA";False:C215)
End if 

