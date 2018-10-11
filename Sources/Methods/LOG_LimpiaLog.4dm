//%attributes = {}
  // LOG_LimpiaLog()
  // 
  //
  // creado por: Alberto Bachler Klein: 06-06-16, 16:39:32
  // -----------------------------------------------------------
C_DATE:C307($d_fechaLimite)

  // solo se conservan en la BD los registros de eventos des los últimos 365 días
  // en la carpeta Log/Actividad se mantienen todos los logs históricos (ver método LOG_AbreDOcumento)
$d_fechaLimite:=Add to date:C393(Current date:C33(*);-1;0;0)
READ WRITE:C146([xShell_Logs:37])
QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Date:3<$d_fechaLimite)
If (Records in selection:C76([xShell_Logs:37])>0)
	KRL_DeleteSelection (->[xShell_Logs:37])
End if 


