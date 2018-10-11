//%attributes = {}
  //AS_LimitarIngresoNParcialMasivo
  //pone fechas limite de ingreso de parciales masivamente para los registros de asigntaturas 
  //que están en el explorador

If (yBWR_currentTable=->[Asignaturas:18])
	
	If (Size of array:C274(alBWR_recordNumber)>0)
		$l_refVentana:=Open form window:C675("AS_FechasLimitesParciales";Plain form window:K39:10;Horizontally centered:K39:1;At the top:K39:5)
		SET WINDOW TITLE:C213(__ ("Fechas Límites de Parciales");$l_refVentana)
		DIALOG:C40("AS_FechasLimitesParciales")
		CLOSE WINDOW:C154
	Else 
		CD_Dlog (0;__ ("Debe haber al menos una Asignatura en el explorador"))
	End if 
Else 
	CD_Dlog (0;__ ("Esta Herramienta debe ejecutarse desde el panel de Asignaturas"))
End if 