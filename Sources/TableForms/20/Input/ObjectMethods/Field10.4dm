C_LONGINT:C283($r)

ARRAY TEXT:C222($at_abreviatura;0)

[xxSTR_Materias:20]Abreviatura:8:=ST_CleanString ([xxSTR_Materias:20]Abreviatura:8)
If (([xxSTR_Materias:20]Abreviatura:8#"") & ([xxSTR_Materias:20]Materia:2#""))
	If (KRL_RecordExists (->[xxSTR_Materias:20]Abreviatura:8))
		$r:=CD_Dlog (0;__ ("Ya existe un subsector de aprendizaje con esta abreviatura. ¿Desea mantenerla?");__ ("");__ ("Si");__ ("No"))
		If ($r=2)
			[xxSTR_Materias:20]Abreviatura:8:=Old:C35([xxSTR_Materias:20]Abreviatura:8)
			GOTO OBJECT:C206([xxSTR_Materias:20]Abreviatura:8)
		End if 
	Else 
		$r:=1
	End if 
	
	
	If ($r=1)
		If ([xxSTR_Materias:20]Codigo:10="")
			[xxSTR_Materias:20]Codigo:10:=[xxSTR_Materias:20]Abreviatura:8
		End if 
		
		  // MOD Ticket N° 211054 PA 20180703
		If ([xxSTR_Materias:20]Abreviatura:8#Old:C35([xxSTR_Materias:20]Abreviatura:8))
			  //If (Old([xxSTR_Materias]Abreviatura)#"") & ([xxSTR_Materias]Abreviatura#Old([xxSTR_Materias]Abreviatura))
			START TRANSACTION:C239
			SET QUERY AND LOCK:C661(True:C214)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2)
			
			
			Case of 
				: ((Records in set:C195("lockedset")>0) & (OK=0))
					[xxSTR_Materias:20]Abreviatura:8:=Old:C35([xxSTR_Materias:20]Abreviatura:8)
					CANCEL TRANSACTION:C241
					ModernUI_Notificacion (__ ("Edición de subsector de aprendizaje");__ ("La abreviatura de este subsector de aprendizaje no puede ser modificada en este momento.\rPor favor intente nuevamente más tarde.");"OK")
					
					
				: (Records in selection:C76([Asignaturas:18])>0)
					LOG_RegisterEvt ("Se modifica la Abreviación del Subsector de Aprendizaje"+[xxSTR_Materias:20]Materia:2+", de "+ST_Qte (Old:C35([xxSTR_Materias:20]Abreviatura:8))+" a "+[xxSTR_Materias:20]Abreviatura:8+".")
					AT_Populate (->$at_abreviatura;->[xxSTR_Materias:20]Abreviatura:8;Records in selection:C76([Asignaturas:18]))
					KRL_Array2Selection (->$at_abreviatura;->[Asignaturas:18]Abreviación:26)
					SAVE RECORD:C53([xxSTR_Materias:20])
					VALIDATE TRANSACTION:C240
					
				Else 
					CANCEL TRANSACTION:C241
			End case 
			
			SET QUERY AND LOCK:C661(False:C215)
		End if 
		
		
	End if 
End if 

