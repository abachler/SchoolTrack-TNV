  // [xxSTR_Materias].Input.Campo1()
  // Por: Alberto Bachler K.: 20-05-14, 16:29:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_idProceso;$l_resultado)

ARRAY TEXT:C222($at_nombreAsignaturas;0)

[xxSTR_Materias:20]Denominación_Interna:18:=ST_CleanString ([xxSTR_Materias:20]Denominación_Interna:18)
[xxSTR_Materias:20]Denominación_Interna:18:=ST_Format (->[xxSTR_Materias:20]Denominación_Interna:18)


If (([xxSTR_Materias:20]Denominación_Interna:18#Old:C35([xxSTR_Materias:20]Denominación_Interna:18)) & (Old:C35([xxSTR_Materias:20]Denominación_Interna:18)#""))
	START TRANSACTION:C239
	SET QUERY AND LOCK:C661(True:C214)
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2)
	Case of 
		: ((Records in set:C195("lockedset")>0) & (OK=0))
			[xxSTR_Materias:20]Denominación_Interna:18:=Old:C35([xxSTR_Materias:20]Denominación_Interna:18)
			CANCEL TRANSACTION:C241
			ModernUI_Notificacion (__ ("Edición de subsector de aprendizaje");__ ("La denominaciójn interna de este subsector de aprendizaje no puede ser modificada en este momento.\rPor favor intente nuevamente más tarde.");"OK")
			
		: (Records in selection:C76([Asignaturas:18])>0)
			$l_resultado:=CD_Dlog (0;__ ("¿Desea usted actualizar el nombre interno de las asignaturas?");__ ("");__ ("Si");__ ("No"))
			If ($l_resultado=1)
				$l_idProceso:=IT_UThermometer (1;0;__ ("Actualizando Nombre interno del subsector…"))
				AT_Populate (->$at_nombreAsignaturas;->[xxSTR_Materias:20]Denominación_Interna:18;Records in selection:C76([Asignaturas:18]))
				KRL_Array2Selection (->$at_nombreAsignaturas;->[Asignaturas:18]denominacion_interna:16)
				IT_UThermometer (-2;$l_idProceso)
				SAVE RECORD:C53([xxSTR_Materias:20])
				VALIDATE TRANSACTION:C240
			Else 
				[xxSTR_Materias:20]Denominación_Interna:18:=Old:C35([xxSTR_Materias:20]Denominación_Interna:18)
				CANCEL TRANSACTION:C241
			End if 
			
		Else 
			CANCEL TRANSACTION:C241
	End case 
	SET QUERY AND LOCK:C661(False:C215)
	
End if 

