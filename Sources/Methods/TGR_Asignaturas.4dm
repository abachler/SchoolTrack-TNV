//%attributes = {}
  // Método: TGR_Asignaturas
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:04:08
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)
C_TEXT:C284($value)

  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		Case of 
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				
				[Asignaturas:18]nivel_jerarquico:107:=ST_CountWords ([Asignaturas:18]ordenGeneral:105;0;".")-1
				If ([Asignaturas:18]Seleccion_por_sexo:24=0)
					[Asignaturas:18]Seleccion_por_sexo:24:=1
				End if 
				
				If ([Asignaturas:18]Incide_en_promedio:27#Old:C35([Asignaturas:18]Incide_en_promedio:27))
					EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$aIds)
					
					For ($i;1;Size of array:C274($aIds))
						$0:=BM_CreateRequest ("Recalcular Situación";String:C10($aIds{$i});String:C10($aIds{$i}))
					End for 
				End if 
				
				[Asignaturas:18]Fecha_de_modificacion:15:=Current date:C33(*)
				
				If ([Asignaturas:18]Asignatura:3#Old:C35([Asignaturas:18]Asignatura:3))
					$p:=New process:C317("AS_ActualizaNombreAsignatura";Pila_256K;"AS_ActualizaNombreAsignatura";[Asignaturas:18]Numero:1;[Asignaturas:18]Asignatura:3)
				End if 
				
				  //20100610 ASM 
				If ([Asignaturas:18]denominacion_interna:16#Old:C35([Asignaturas:18]denominacion_interna:16)) & ([Asignaturas:18]nivel_jerarquico:107>0)
					$0:=BM_CreateRequest ("AS_VerificaNombreHijaEnMadre";String:C10([Asignaturas:18]Numero:1);String:C10([Asignaturas:18]Numero:1))
				End if 
				
				
				Case of 
					: (<>vs_AppDecimalSeparator=",")
						$badSeparator:="."
					: (<>vs_AppDecimalSeparator=".")
						$badSeparator:=","
				End case 
				[Asignaturas:18]PromedioFinal_texto:53:=Replace string:C233([Asignaturas:18]PromedioFinal_texto:53;$badSeparator;<>vs_AppDecimalSeparator)
				[Asignaturas:18]PromedioFinalOficial_texto:67:=Replace string:C233([Asignaturas:18]PromedioFinalOficial_texto:67;$badSeparator;<>vs_AppDecimalSeparator)
				
				
				
				
				
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				
				If ([Asignaturas:18]Numero:1=0)
					[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)
				End if 
				If ([Asignaturas:18]Numero_de_EstiloEvaluacion:39=0)
					[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=-5
				End if 
				[Asignaturas:18]Fecha_de_Creacion:56:=Current date:C33(*)
				[Asignaturas:18]Fecha_de_modificacion:15:=Current date:C33(*)
				If ([Asignaturas:18]Seleccion_por_sexo:24=0)
					[Asignaturas:18]Seleccion_por_sexo:24:=1
				End if 
				[Asignaturas:18]nivel_jerarquico:107:=ST_CountWords ([Asignaturas:18]ordenGeneral:105;0;".")-1
				
				$key:=String:C10(0)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero:1)
				$recNum:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_SintesisAnual:202]LLavePrimaria:5;->$key)
				If ($recNum<0)
					CREATE RECORD:C68([Asignaturas_SintesisAnual:202])
					[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=[Asignaturas:18]Numero:1
					[Asignaturas_SintesisAnual:202]ID_Institucion:1:=<>gInstitucion
					[Asignaturas_SintesisAnual:202]Año:3:=<>gYear
					SAVE RECORD:C53([Asignaturas_SintesisAnual:202])
					KRL_ReloadAsReadOnly (->[Asignaturas_SintesisAnual:202])
				End if 
				
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				PERIODOS_Init 
				PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
				EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
				READ WRITE:C146([Asignaturas_SintesisAnual:202])
				DELETE RECORD:C58([Asignaturas_SintesisAnual:202])
				
				  //20160219 RCH Elimina posibles guias.  En el trigger se marca el registro para eliminación en SN
				READ WRITE:C146([Asignaturas_Adjuntos:230])
				QUERY:C277([Asignaturas_Adjuntos:230];[Asignaturas_Adjuntos:230]id_asignatura:7=[Asignaturas:18]Numero:1)
				DELETE SELECTION:C66([Asignaturas_Adjuntos:230])
				KRL_UnloadReadOnly (->[Asignaturas_Adjuntos:230])
				
				
		End case 
		CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[Asignaturas:18])
		
		SN3_MarcarRegistros (SN3_DTi_Asignaturas)
	End if 
End if 



