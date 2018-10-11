Case of 
	: (Form event:C388=On Clicked:K2:4)
		vlACT_id_modo_pago:=alACT_FormasdePagoID{atACT_formas_de_pago}
		$vb_importador:=True:C214
		$vb_retorno:=ACTac_OpcionesGenerales ("BuscaExportadoArchivoTransferencia";->$vb_importador;->vlACT_id_modo_pago;->vImportador;->vlACT_ImportadorID)
		
		If ((vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-10) | (vlACT_id_modo_pago=-11))
			OBJECT SET VISIBLE:C603(*;"tipoImport@";True:C214)
			OBJECT SET VISIBLE:C603(*;"pagos@";False:C215)
			If (<>gCountryCode="mx")
				$visible:=ACTusr_AllowChange ("onLoad";->vdACT_ImpRealDate)
				$visible:=ACTusr_AllowChange ("visible";->bCalendar1;$visible)
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*;"tipoImport@";False:C215)
			OBJECT SET VISIBLE:C603(*;"pagos@";True:C214)
			OBJECT SET VISIBLE:C603(bPadlock;False:C215)
			OBJECT SET VISIBLE:C603(*;"padlockUnlocked";False:C215)
			OBJECT SET VISIBLE:C603(*;"padlockLocked";False:C215)
			
		End if 
		IT_SetButtonState (((vt_ruta#"") & (vlACT_id_modo_pago#0) & (vlACT_ImportadorID#0));->bCont)
		
	: (Form event:C388=On Data Change:K2:15)
		vb_fechaPago:=False:C215
		
End case 

REDRAW WINDOW:C456
