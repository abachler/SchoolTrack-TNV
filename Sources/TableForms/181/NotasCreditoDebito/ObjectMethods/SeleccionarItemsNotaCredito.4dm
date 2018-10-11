C_LONGINT:C283($vl_Column;$vl_row)
C_POINTER:C301($vy_pointer1)
C_BOOLEAN:C305($vb_calculaMontos)
LISTBOX GET CELL POSITION:C971(lb_seleccion;$vl_Column;$vl_row;$vy_pointer1)
If ($vl_Column=1)
	vr_montoAfectoSel:=0
	vr_montoExentoSel:=0
	vr_montoIVASel:=0
	vr_montoTotalSel:=0
	vr_montoItemIncluirAfecto:=0
	vr_montoItemIncluirExento:=0
	
	If (Count in array:C907(abACT_ItemsSeleccionado;True:C214)>=1)
		For ($l_indice;1;Size of array:C274(lb_seleccion))
			If (abACT_ItemsSeleccionado{$l_indice})
				If (abACT_Afecto{$l_indice})
					vr_montoAfectoSel:=vr_montoAfectoSel+arACT_MontoItems{$l_indice}
					vr_montoItemIncluirAfecto:=vr_montoItemIncluirAfecto+arACT_MontoItems{$l_indice}
				Else 
					vr_montoExentoSel:=vr_montoExentoSel+arACT_MontoItems{$l_indice}
					vr_montoItemIncluirExento:=vr_montoItemIncluirExento+arACT_MontoItems{$l_indice}
				End if 
				vr_montoIVASel:=vr_montoIVASel+ar_MontoIvaCargoSel{$l_indice}
				vr_montoTotalSel:=vr_montoTotalSel+arACT_MontoItems{$l_indice}
			End if 
		End for 
		
		vr_montoAfecto:=vr_montoAfectoSel-vr_montoIVASel
		vr_montoExento:=vr_montoExentoSel
		vr_montoIVA:=vr_montoIVASel
		vr_montoTotal:=vr_montoTotalSel
		vr_MaxExento:=vr_montoItemIncluirExento
		vr_MaxAfecto:=vr_montoItemIncluirAfecto-vr_montoIVASel
	Else 
		abACT_ItemsSeleccionado{$vl_row}:=abACT_ItemsSeleccionado{0}
	End if 
End if 

