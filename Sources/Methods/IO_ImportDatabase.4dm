//%attributes = {}
  // IO_ImportDatabase()
  // Por: Alberto Bachler K.: 14-10-14, 19:43:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


KRL_DisableIndexes 
0xDev_AvoidTriggerExecution (True:C214)
<>vb_ImportHistoricos_STX:=True:C214

If (Count parameters:C259=1)
	$t_rutaExport:=$1
Else 
	$t_rutaExport:=SYS_SelectFolder ("Seleccione la carpeta que contiene los datos a importar...")
End if 
If ($t_rutaExport#"")
	$l_tablas:=Get last table number:C254
	$l_idProgreso:=Progress New 
	Progress SET TITLE ($l_idProgreso;"Reconstruyendo base de datos")
	For ($i;1;$l_tablas)
		If (Is table number valid:C999($i))
			Progress SET PROGRESS ($l_idProgreso;$i/$l_tablas;String:C10($i)+" / "+String:C10($l_tablas))
			$y_tabla:=Table:C252($i)
			$t_rutaArchivo:=$t_rutaExport+"Tabla"+String:C10(Table:C252($y_tabla))+".txt"
			If (Test path name:C476($t_rutaArchivo)=Is a document:K24:1)
				If (Records in table:C83($y_tabla->)>0)
					TRUNCATE TABLE:C1051($y_tabla->)
				End if 
				IO_ImportRecords2OneTable ($y_tabla;$t_rutaArchivo)
			End if 
		End if 
	End for 
	Progress QUIT ($l_idProgreso)
End if 



0xDev_AvoidTriggerExecution (False:C215)
<>vb_ImportHistoricos_STX:=False:C215
KRL_EnableIndexes 
