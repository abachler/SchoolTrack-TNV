C_LONGINT:C283($vCol;$vRow)
LISTBOX GET CELL POSITION:C971(*;"lb_listaIECV";$vCol;$vRow)
If ($vRow>0)
	If (Not:C34([ACT_IECV:253]estado:14 ?? 4))
		$l_resp:=CD_Dlog (0;"¿Está seguro de querer eliminar el libro electrónico para el período "+[ACT_IECV:253]periodo:6+"?";"";"Si";"No")
		If ($l_resp=1)
			KRL_FindAndLoadRecordByIndex (->[ACT_IECV:253]id:1;->alACTiecv_id{$vRow};True:C214)
			If (ok=1)
				LOG_RegisterEvt ("Eliminación de libro electrónico. Período: "+[ACT_IECV:253]periodo:6+", id: "+String:C10([ACT_IECV:253]id:1)+"(en dte: "+String:C10([ACT_IECV:253]id_iecv_dtenet:4)+")"+".")
				DELETE RECORD:C58([ACT_IECV:253])
				
				ACTiecv_cargaArreglosListado ("CargaArreglos")
			Else 
				CD_Dlog (0;"El libro no pudo ser eliminado.")
			End if 
			KRL_UnloadReadOnly (->[ACT_IECV:253])
			
		End if 
	Else 
		CD_Dlog (0;__ ("Libro ya enviado al SII. No es posible eliminarlo"))
	End if 
End if 