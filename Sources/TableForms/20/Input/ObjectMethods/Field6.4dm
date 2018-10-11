  // [xxSTR_Materias].Input.Field6()
  // Por: Alberto Bachler K.: 20-05-14, 16:03:45
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_idProceso)

ARRAY TEXT:C222($at_codigoMineduc;0)

If (([xxSTR_Materias:20]Codigo:10#"") & ([xxSTR_Materias:20]Materia:2#""))
	If (KRL_RecordExists (->[xxSTR_Materias:20]Codigo:10))
		CD_Dlog (0;__ ("Ya existe un subsector de aprendizaje con este nombre con este código."))
		[xxSTR_Materias:20]Codigo:10:=""
		GOTO OBJECT:C206([xxSTR_Materias:20]Codigo:10)
	Else 
		START TRANSACTION:C239
		SET QUERY AND LOCK:C661(True:C214)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2)
		
		Case of 
			: ((Records in set:C195("lockedset")>0) & (OK=0))
				[xxSTR_Materias:20]Codigo:10:=Old:C35([xxSTR_Materias:20]Codigo:10)
				CANCEL TRANSACTION:C241
				ModernUI_Notificacion (__ ("Edición de subsector de aprendizaje");__ ("El código de este subsector de aprendizaje no puede ser modificado en este momento.\rPor favor intente nuevamente más tarde.");"OK")
				
			: (Records in selection:C76([Asignaturas:18])>0)
				$l_idProceso:=IT_UThermometer (1;0;__ ("Actualizando codigo…"))
				AT_Populate (->$at_codigoMineduc;->[xxSTR_Materias:20]Codigo:10;Records in selection:C76([Asignaturas:18]))
				KRL_Array2Selection (->$at_codigoMineduc;->[Asignaturas:18]CHILE_CodigoMineduc:41)
				SAVE RECORD:C53([xxSTR_Materias:20])
				VALIDATE TRANSACTION:C240
				IT_UThermometer (-2;$l_idProceso)
				
			Else 
				CANCEL TRANSACTION:C241
		End case 
		SET QUERY AND LOCK:C661(False:C215)
	End if 
End if 

