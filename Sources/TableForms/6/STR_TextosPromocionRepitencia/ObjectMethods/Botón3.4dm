If ([xxSTR_Niveles:6]NoNivel:5=12)
	vtSTR_TextoPromocion:="En consecuencia obtiene Licencia de Educación Media"
Else 
	
	$el:=Find in array:C230(<>al_NumeroNivelesOficiales;[xxSTR_Niveles:6]NoNivel:5)
	If ($el>0)
		If (($el+1)>Size of array:C274(<>at_NombreNivelesOficiales))
			$el:=Find in array:C230(<>aNivNo;[xxSTR_Niveles:6]NoNivel:5)
			$nivel_siguiente:=<>aNivel{$el+1}
		Else 
			$nivel_siguiente:=<>at_NombreNivelesOficiales{$el+1}
		End if 
	Else 
		$nivel_siguiente:=""
	End if 
	
	If ($el>0)
		vtSTR_TextoPromocion:="En consecuencia: es promovido(a) a "+$nivel_siguiente+"."
	Else 
		vtSTR_TextoPromocion:=""
	End if 
End if 

vtSTR_TextoRepitencia:="En consecuencia: debe repetir curso"

sfinalSit:=vtSTR_TextoPromocion
vModif:=True:C214