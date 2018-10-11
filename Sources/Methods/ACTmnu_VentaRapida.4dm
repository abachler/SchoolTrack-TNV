//%attributes = {}
  //ACTmnu_VentaRapida

If (USR_GetMethodAcces (Current method name:C684))
	ACTinit_LoadPrefs 
	
	TipoTarjeta:=AT_array2text (->atACT_TipoTarjeta)
	Bancos:=AT_array2text (->atACT_BankName)
	Codigos:=AT_array2text (->atACT_BankID)
	
	$VentaRapidaProcID:=Process number:C372("Ventas Rápidas")
	
	READ ONLY:C145([xxACT_Items:179])
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]VentaRapida:3=True:C214)
	If (Records in selection:C76([xxACT_Items:179])>0)
		If ($VentaRapidaProcID>0)
			BRING TO FRONT:C326($VentaRapidaProcID)
		Else 
			$processID:=New process:C317("ACTvr_VentaRapida";Pila_256K;"Ventas Rápidas";TipoTarjeta;Bancos;Codigos;vpXS_IconModule;vsBWR_CurrentModule)
		End if 
	Else 
		CD_Dlog (0;__ ("No existen items de cargo definidos para venta rápida."))
		If ($VentaRapidaProcID>0)
			BRING TO FRONT:C326($VentaRapidaProcID)
			POST KEY:C465(27;0;$VentaRapidaProcID)
		End if 
	End if 
End if 