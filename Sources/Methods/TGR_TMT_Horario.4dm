//%attributes = {}
  // Método: TGR_TMT_Horario
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:34:27
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)
C_TIME:C306($h_HoraInicio;$h_HoraFin)

  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[TMT_Horario:166]ID:15:=SQ_SeqNumber (->[TMT_Horario:166]ID:15)
				KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;True:C214)
				If (OK=1)
					[Asignaturas:18]Horas_Semanales:51:=[Asignaturas:18]Horas_Semanales:51+1
					SAVE RECORD:C53([Asignaturas:18])
					KRL_UnloadReadOnly (->[Asignaturas:18])
				Else 
					$0:=BM_CreateRequest ("Cuenta horas de clase";String:C10([Asignaturas:18]Numero:1);String:C10([Asignaturas:18]Numero:1))
				End if 
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				  //ASM 20180219 Agrego por cambio en las fechas de sesiones.
				$0:=BM_CreateRequest ("Cuenta horas de clase";String:C10([Asignaturas:18]Numero:1);String:C10([Asignaturas:18]Numero:1))
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				$readOnlyState:=KRL_ReadWrite (->[Asignaturas:18])
				RELATE ONE:C42([TMT_Horario:166]ID_Asignatura:5)
				If (Not:C34(Locked:C147([Asignaturas:18])))
					[Asignaturas:18]Horas_Semanales:51:=[Asignaturas:18]Horas_Semanales:51-1
					SAVE RECORD:C53([Asignaturas:18])
					KRL_ResetPreviousRWMode (->[Asignaturas:18];$readOnlyState)
				Else 
					$0:=BM_CreateRequest ("Cuenta horas de clase";String:C10([Asignaturas:18]Numero:1);String:C10([Asignaturas:18]Numero:1))
				End if 
		End case 
	End if 
	SN3_MarcarRegistros (SN3_DTi_Horarios)
End if 



