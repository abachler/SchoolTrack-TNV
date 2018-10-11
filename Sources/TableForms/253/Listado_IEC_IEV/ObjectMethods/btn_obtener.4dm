C_LONGINT:C283($l_columna;$l_fila;$l_result)
C_POINTER:C301($vy_arreglo)
C_LONGINT:C283($l_idDTE)
C_BOOLEAN:C305($b_respuestaObtenida)
LISTBOX GET CELL POSITION:C971(lb_listaIECV;$l_columna;$l_fila;$vy_arreglo)

If ($l_fila>0)
	READ ONLY:C145([ACT_IECV:253])
	$l_idDTE:=alACTiecv_id{$l_fila}
	KRL_FindAndLoadRecordByIndex (->[ACT_IECV:253]id:1;->$l_idDTE)
	If (ok=1)
		If (([ACT_IECV:253]estado:14 ?? 1) & (Not:C34([ACT_IECV:253]estado:14 ?? 2)))
			$b_respuestaObtenida:=ACTiecv_obtieneEstadoDesdeDTE ($l_idDTE)
			
			  //actualiza glosa
			If ($b_respuestaObtenida)
				ACTiecv_cargaArreglosListado ("ActualizaGlosaArreglo";->$l_idDTE;->$l_fila)
			Else 
				CD_Dlog (0;__ ("No fue posible conectarse con DTENet"))
			End if 
			
		End if 
	End if 
End if 