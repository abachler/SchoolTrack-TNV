

If (sFinalSit="")
	If ([xxSTR_Niveles:6]NoNivel:5=12)
		vtSTR_TextoPromocion:="En consecuencia obtiene Licencia de Educación Media"
	Else 
		$el:=Find in array:C230(<>al_NumeroNivelesOficiales;[xxSTR_Niveles:6]NoNivel:5)
		If ($el>0)
			If (($el+1)>Size of array:C274(<>at_NombreNivelesOficiales))
				$el:=Find in array:C230(<>aNivNo;[xxSTR_Niveles:6]NoNivel:5)
				vtSTR_TextoPromocion:="es promovido(a) a "+<>aNivel{$el+1}+"."
			Else 
				vtSTR_TextoPromocion:="es promovido(a) a "+<>at_NombreNivelesOficiales{$el+1}+"."
			End if 
		Else 
			vtSTR_TextoPromocion:=""
		End if 
	End if 
Else 
	  //vtSTR_TextoPromocion:=sFinalSit
	sFinalSit:=vtSTR_TextoPromocion
End if 

If (vtSTR_TextoRepitencia="")
	vtSTR_TextoRepitencia:="En consecuencia: debe repetir curso"
End if 

WDW_OpenDialogInDrawer (->[xxSTR_Niveles:6];"STR_TextosPromocionRepitencia")
CLOSE WINDOW:C154
