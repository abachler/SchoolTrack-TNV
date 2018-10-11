//%attributes = {}
  // Método: TGR_xxSTR_Subasignaturas
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 11:00:21
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[xxSTR_Subasignaturas:83]ID:19:=SQ_SeqNumber (->[xxSTR_Subasignaturas:83]ID:19)
				[xxSTR_Subasignaturas:83]LongID:7:=-Abs:C99([xxSTR_Subasignaturas:83]ID_Mother:6)
				[xxSTR_Subasignaturas:83]Referencia:11:=String:C10([xxSTR_Subasignaturas:83]ID_Mother:6)+"."+String:C10([xxSTR_Subasignaturas:83]Periodo:12)+"."+String:C10([xxSTR_Subasignaturas:83]Columna:13)
				[xxSTR_Subasignaturas:83]ID_SubAsignatura:1:=String:C10(-Abs:C99([xxSTR_Subasignaturas:83]ID_Mother:6))+"."+String:C10([xxSTR_Subasignaturas:83]Periodo:12)+"."+String:C10([xxSTR_Subasignaturas:83]Columna:13)
				[xxSTR_Subasignaturas:83]FechaCreacion:14:=Current date:C33(*)
				[xxSTR_Subasignaturas:83]DTS_Modificacion_GMT:17:=DTS_Get_GMT_TimeStamp 
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				[xxSTR_Subasignaturas:83]LongID:7:=-Abs:C99([xxSTR_Subasignaturas:83]ID_Mother:6)
				[xxSTR_Subasignaturas:83]Referencia:11:=String:C10([xxSTR_Subasignaturas:83]ID_Mother:6)+"."+String:C10([xxSTR_Subasignaturas:83]Periodo:12)+"."+String:C10([xxSTR_Subasignaturas:83]Columna:13)
				[xxSTR_Subasignaturas:83]ID_SubAsignatura:1:=String:C10(-Abs:C99([xxSTR_Subasignaturas:83]ID_Mother:6))+"."+String:C10([xxSTR_Subasignaturas:83]Periodo:12)+"."+String:C10([xxSTR_Subasignaturas:83]Columna:13)
				[xxSTR_Subasignaturas:83]DTS_Modificacion_GMT:17:=DTS_Get_GMT_TimeStamp 
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
	End if 
	SN3_MarcarRegistros (100021)
End if 



