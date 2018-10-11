  // [xxSTR_Materias].Input.Field8()
  // Por: Alberto Bachler K.: 20-05-14, 15:25:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_idProceso)

ARRAY TEXT:C222($at_asignaturas;0)

[xxSTR_Materias:20]Area:12:=ST_Format (->[xxSTR_Materias:20]Area:12)
[xxSTR_Materias:20]Area:12:=ST_CleanString ([xxSTR_Materias:20]Area:12)

If (([xxSTR_Materias:20]Area:12#"") & ([xxSTR_Materias:20]Materia:2#"") & ([xxSTR_Materias:20]Area:12#Old:C35([xxSTR_Materias:20]Area:12)))
	
	START TRANSACTION:C239
	SET QUERY AND LOCK:C661(True:C214)
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2)
	
	Case of 
		: ((Records in set:C195("lockedset")>0) & (OK=0))
			[xxSTR_Materias:20]Area:12:=Old:C35([xxSTR_Materias:20]Area:12)
			CANCEL TRANSACTION:C241
			ModernUI_Notificacion (__ ("Edición de subsector de aprendizaje");__ ("El nombre del sector de aprendizaje no puede ser modificado en este momento.\rPor favor intente nuevamente más tarde.");"OK")
			
			
		: (Records in selection:C76([Asignaturas:18])>0)
			AT_Populate (->$at_asignaturas;->[xxSTR_Materias:20]Area:12;Records in selection:C76([Asignaturas:18]))
			$l_idProceso:=IT_UThermometer (1;0;__ ("Actualizando Materia…"))
			KRL_Array2Selection (->$at_asignaturas;->[Asignaturas:18]Sector:9)
			SAVE RECORD:C53([xxSTR_Materias:20])
			VALIDATE TRANSACTION:C240
			IT_UThermometer (-2;$l_idProceso)
			
		Else 
			CANCEL TRANSACTION:C241
	End case 
	SET QUERY AND LOCK:C661(False:C215)
	
End if 

