//%attributes = {"executedOnServer":true}
  // 4DInfoReports_StartOnServer()
  // Por: Alberto Bachler Klein: 19-10-15, 11:09:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_rutaOK)
C_TEXT:C284($t_encabezado;$t_rutaInformes)

$t_rutaInformes:=SYS_GetServerProperty (XS_DataFileFolder)+"Reportes de ejecución"+Folder separator:K24:12
If (Test path name:C476($t_rutaInformes)#Is a folder:K24:2)
	SYS_CreaCarpetaServidor ($t_rutaInformes)
End if 
EXECUTE METHOD:C1007("aa4D_M_Folder_Rep_SetPath_local";$b_rutaOK;->$t_rutaInformes)
If ($b_rutaOK)
	  //EXECUTE METHOD("aa4D_NP_Util_CreateReport";*;0)
	$t_encabezado:="Estos son los reportes de la BD que está abierta"
	EXECUTE METHOD:C1007("aa4D_NP_Schedule_Reports_Server";*;5;0;->$t_encabezado;-1)
End if 