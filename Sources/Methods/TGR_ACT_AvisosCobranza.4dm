//%attributes = {}
  // Método: TGR_ACT_AvisosCobranza
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:42:34
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
				[ACT_Avisos_de_Cobranza:124]DTS_Creacion:28:=DTS_MakeFromDateTime 
				If ([ACT_Avisos_de_Cobranza:124]Moneda:17="")  //un colegio tenia avisos sin moneda...
					[ACT_Avisos_de_Cobranza:124]Moneda:17:=ST_GetWord (ACT_DivisaPais ;1;";")
				End if 
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If ([ACT_Avisos_de_Cobranza:124]Moneda:17="")
					[ACT_Avisos_de_Cobranza:124]Moneda:17:=ST_GetWord (ACT_DivisaPais ;1;";")
				End if 
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
				
		End case 
	End if 
	SN3_MarcarRegistros (SN3_DTi_AvisosCobranza)
End if 

If (Trigger event:C369=On Deleting Record Event:K3:3)
	$t_rutaDocumento:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"AvisosPDF"+Folder separator:K24:12+"AC_"+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+".pdf"
	SYS_DeleteFile ($t_rutaDocumento)
	
	$t_rutaDocumento:=SYS_CarpetaAplicacion (CLG_Intercambios_SNT)+"AvisosPDF4SN"+Folder separator:K24:12+"AC_"+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+".pdf"
	SYS_DeleteFile ($t_rutaDocumento)
End if 