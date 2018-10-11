  // [xxSTR_Materias].Input.Field9()
  // Por: Alberto Bachler K.: 20-05-14, 15:38:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_abortar)
C_LONGINT:C283($l_idProceso)

ARRAY TEXT:C222($at_nombreAsignatura;0)

Case of 
	: (Form event:C388=On Data Change:K2:15)
		[xxSTR_Materias:20]Materia:2:=ST_CleanString ([xxSTR_Materias:20]Materia:2)
		[xxSTR_Materias:20]Materia:2:=ST_Format (->[xxSTR_Materias:20]Materia:2)
		
		If (KRL_RecordExists (->[xxSTR_Materias:20]Materia:2))
			$b_abortar:=True:C214
			CD_Dlog (0;__ ("Esta nombre ya existe en la lista de subsectores oficiales."))
			
		Else 
			
			If ((Old:C35([xxSTR_Materias:20]Materia:2)#"") & ([xxSTR_Materias:20]Materia:2#""))
				START TRANSACTION:C239
				
				SET QUERY AND LOCK:C661(True:C214)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=Old:C35([xxSTR_Materias:20]Materia:2))
				If (OK=1)
					QUERY:C277([Asignaturas_Objetivos:104];[Asignaturas_Objetivos:104]Subsector:2=Old:C35([xxSTR_Materias:20]Materia:2))
				End if 
				If (OK=1)
					QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=Old:C35([xxSTR_Materias:20]Materia:2))
				End if 
				
				Case of 
					: ((Records in set:C195("lockedset")>0) & (OK=0))
						[xxSTR_Materias:20]Materia:2:=Old:C35([xxSTR_Materias:20]Materia:2)
						CANCEL TRANSACTION:C241
						ModernUI_Notificacion (__ ("Edición de subsector de aprendizaje");__ ("El nombre de este subsector de aprendizaje no puede ser modificado en este momento.\rPor favor intente nuevamente más tarde.");"OK")
						
					: ((Records in selection:C76([Asignaturas:18])>0) | (Records in selection:C76([Asignaturas_Objetivos:104])>0) | (Records in selection:C76([MPA_AsignaturasMatrices:189])>0))
						$l_idProceso:=IT_UThermometer (1;0;__ ("Actualizando Materia…"))
						AT_Populate (->$at_nombreAsignatura;->[xxSTR_Materias:20]Materia:2;Records in selection:C76([Asignaturas:18]))
						KRL_Array2Selection (->$at_nombreAsignatura;->[Asignaturas:18]Asignatura:3)
						
						AT_Populate (->$at_nombreAsignatura;->[xxSTR_Materias:20]Materia:2;Records in selection:C76([Asignaturas_Objetivos:104]))
						KRL_Array2Selection (->$at_nombreAsignatura;->[Asignaturas_Objetivos:104]Subsector:2)
						
						AT_Populate (->$at_nombreAsignatura;->[xxSTR_Materias:20]Materia:2;Records in selection:C76([MPA_AsignaturasMatrices:189]))
						KRL_Array2Selection (->$at_nombreAsignatura;->[MPA_AsignaturasMatrices:189]Asignatura:3)
						
						[xxSTR_Materias:20]Materia_NombreLargo:20:=[xxSTR_Materias:20]Materia:2
						SAVE RECORD:C53([xxSTR_Materias:20])
						VALIDATE TRANSACTION:C240
						$l_idProceso:=IT_UThermometer (-2;$l_idProceso)
						
					Else 
						[xxSTR_Materias:20]Materia_NombreLargo:20:=[xxSTR_Materias:20]Materia:2
						CANCEL TRANSACTION:C241
				End case 
				SET QUERY AND LOCK:C661(False:C215)
				
			End if 
			
		End if 
End case 