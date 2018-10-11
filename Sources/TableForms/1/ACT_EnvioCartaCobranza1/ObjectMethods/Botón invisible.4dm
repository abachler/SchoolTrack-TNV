C_TEXT:C284($t_textoCuerpo)

If (Size of array:C274(alACTecc_ApoderadoID)>0)
	ARRAY LONGINT:C221($alACT_seleccionados;0)
	C_LONGINT:C283($l_indice)
	lb_ACTecc_Apoderados{0}:=True:C214
	AT_SearchArray (->lb_ACTecc_Apoderados;"=";->$alACT_seleccionados)
	If (Size of array:C274($alACT_seleccionados)>0)
		$l_indice:=$alACT_seleccionados{1}
	Else 
		$l_indice:=1
	End if 
	
	ACTecc_OpcionesGenerales ("ProcesaTextoCuerpo";->$t_textoCuerpo;->alACTecc_ApoderadoID{$l_indice})
	
	CD_Dlog (0;$t_textoCuerpo)
Else 
	CD_Dlog (0;__ ("No hay apoderados en a lista. No es posible generar la vista previa."))
End if 