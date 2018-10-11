//%attributes = {}
  // Método: TGR_ActividadesExtraCurr
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:54:07
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

  // Código principal

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If (Old:C35([Actividades:29]Nombre:2)#[Actividades:29]Nombre:2)
					READ WRITE:C146([Alumnos_Actividades:28])
					QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1)
					APPLY TO SELECTION:C70([Alumnos_Actividades:28];[Alumnos_Actividades:28]NombreActividad:43:=[Actividades:29]Nombre:2)
					UNLOAD RECORD:C212([Alumnos_Actividades:28])
					READ WRITE:C146([Alumnos_Actividades:28])
				End if 
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				READ ONLY:C145([Alumnos_Actividades:28])
				QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1)
				
				KRL_DeleteSelection (->[Alumnos_Actividades:28])
				UNLOAD RECORD:C212([Alumnos_Actividades:28])
				READ WRITE:C146([Alumnos_Actividades:28])
		End case 
		CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[Actividades:29])
	End if 
	SN3_MarcarRegistros (SN3_DTi_ActividadesExtraCurr)
End if 





