If ([ACT_Boletas:181]documento_electronico:29)
	If ([ACT_Boletas:181]DTE_estado_id:24 ?? 2)
		If (Size of array:C274(atACT_DetallesNCT2)<3)
			C_TEXT:C284($t_dondeDice;$t_debeDecir)
			$t_dondeDice:="Donde dice "
			$t_debeDecir:="Debe decir "
			If (Find in array:C230(atACT_DetallesNCT2;$t_dondeDice)=-1)
				APPEND TO ARRAY:C911(atACT_DetallesNCT2;$t_dondeDice)
			End if 
			If (Find in array:C230(atACT_DetallesNCT2;$t_debeDecir)=-1)
				APPEND TO ARRAY:C911(atACT_DetallesNCT2;$t_debeDecir)
			End if 
			AT_Insert (1;1;->atACT_DetallesNCT2)
		End if 
	Else 
		CD_Dlog (0;"El documento ya fue enviado a dte. No es posible modificar este detalle.")
	End if 
End if 

