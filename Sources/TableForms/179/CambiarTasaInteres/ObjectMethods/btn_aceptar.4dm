If ((vrACT_tasa>0) | (cs_generarIntereses=1))
	C_BOOLEAN:C305($vb_continuar)
	C_LONGINT:C283($vl_records)
	$vb_continuar:=True:C214
	
	If (cs_generarIntereses=1)
		If (vdACT_fechaIntereses=!00-00-00!)
			$vb_continuar:=False:C215
			BEEP:C151
			CD_Dlog (0;__ ("Fecha inválida."))
		End if 
	End if 
	
	If ($vb_continuar)
		If (cs_generarIntereses=1)
			If (bo_seleccionados=1)
				$vl_records:=BWR_SearchRecords 
				If ($vl_records=-1)
					$vb_continuar:=False:C215
				End if 
			End if 
			
			C_BOOLEAN:C305($vb_alertarPorTiempo)
			If ((bo_todos=1) | ((bo_seleccionados=1) & ($vl_records>100)))
				$vb_alertarPorTiempo:=True:C214
			Else 
				$vb_alertarPorTiempo:=False:C215
			End if 
		End if 
		
		If ($vb_continuar)
			Case of 
				: ((vrACT_tasa>0) & (cs_generarIntereses=0))  //solo cambia tasa
					If ((cs_simple=1) | (cs_compuesto=1))
						$vl_resp:=CD_Dlog (0;__ ("Se cambiará la tasa de interés a los ítems de cargo sin recalcular los Avisos de Cobranza.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
						If ($vl_resp=2)
							$vb_continuar:=False:C215
						End if 
					Else 
						BEEP:C151
					End if 
					
				: ((vrACT_tasa=0) & (cs_generarIntereses=1))  //solo  calcula
					$vl_resp:=CD_Dlog (0;__ ("Se recalcularán los Avisos de Cobranza al día ")+String:C10(vdACT_fechaIntereses)+__ (" sin cambiar la tasa de interés de los ítems de cargo.")+"\r\r"+ST_Boolean2Str ($vb_alertarPorTiempo;__ ("Esta operación podría tardar varios minutos.")+" ";"")+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
					If ($vl_resp=2)
						$vb_continuar:=False:C215
					End if 
					
					
				: ((vrACT_tasa>0) & (cs_generarIntereses=1))  //cambia tasa y calcula
					If ((cs_simple=1) | (cs_compuesto=1))
						$vl_resp:=CD_Dlog (0;__ ("Se cambiará la tasa de interés a los ítems de cargo y se recalcularán los intereses de los Avisos de Cobranza al día ")+String:C10(vdACT_fechaIntereses)+"."+"\r\r"+ST_Boolean2Str ($vb_alertarPorTiempo;__ ("Esta operación podría demorar varios minutos.")+" ";"")+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
						If ($vl_resp=2)
							$vb_continuar:=False:C215
						End if 
					Else 
						BEEP:C151
						$vb_continuar:=False:C215
					End if 
					
			End case 
			
			If ($vb_continuar)
				ACCEPT:C269
			Else 
				BEEP:C151
			End if 
		Else 
			BEEP:C151
			CD_Dlog (0;__ ("No hay Avisos de Cobranza seleccionados."))
		End if 
	End if 
End if 