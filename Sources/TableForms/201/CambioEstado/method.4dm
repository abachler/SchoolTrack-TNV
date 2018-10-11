Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(vbACT_CEdesdePago)
		
		  //20160425 ASM Ticket 140209
		C_DATE:C307(vbACT_fecha)
		vbACT_fecha:=Current date:C33(*)
		If (vbACT_CEdesdePago)
			CREATE SET:C116([ACT_Pagos:172];"SetPagosCambioEstado")
		Else 
			CREATE SET:C116([ACT_Pagares:184];"SetPagaresCambioEstado")
		End if 
		
		ACTcfg_OpcionesCambioEstadoPago ("OnLoad")
		OBJECT SET ENABLED:C1123(atACT_formaModCE;(cs_particularCE=1))
		If (Size of array:C274(alACT_formaDePagoCE)=0)
			_O_DISABLE BUTTON:C193(btn_aceptar)
		End if 
		
		OBJECT SET VISIBLE:C603(*;"Texto1_@";vbACT_CEdesdePago)
		
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET ENABLED:C1123(atACT_formaModCE;(cs_particularCE=1))
		
	: (Form event:C388=On Close Box:K2:21)
		SET_ClearSets ("SetPagosCambioEstado";"SetPagaresCambioEstado")
		CANCEL:C270
		
End case 

Spell_CheckSpelling 