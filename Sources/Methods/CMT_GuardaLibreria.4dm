//%attributes = {"executedOnServer":true}
  // CMT_GuardaLibreria()
  //
  //
  // creado por: Alberto Bachler Klein: 22-12-16, 10:34:55
  // -----------------------------------------------------------
C_TEXT:C284($t_accion;$t_aplicacion;$t_rutaDocumento)


$t_rutaDocumento:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+"CMTCamposUtilizados.txt"
If (SYS_TestPathName ($t_rutaDocumento)=Is a document:K24:1)
	DELETE DOCUMENT:C159($t_rutaDocumento)
End if 
SET CHANNEL:C77(10;$t_rutaDocumento)
READ ONLY:C145([CMT_Transferencia:158])
QUERY:C277([CMT_Transferencia:158];[CMT_Transferencia:158]Aplicacion:2=String:C10(CommTrack))
FIRST RECORD:C50([CMT_Transferencia:158])
$l_registros:=Records in selection:C76([CMT_Transferencia:158])
SEND VARIABLE:C80($l_registros)
While (Not:C34(End selection:C36([CMT_Transferencia:158])))
	SEND RECORD:C78([CMT_Transferencia:158])
	NEXT RECORD:C51([CMT_Transferencia:158])
End while 
SET CHANNEL:C77(11)
UNLOAD RECORD:C212([CMT_Transferencia:158])
