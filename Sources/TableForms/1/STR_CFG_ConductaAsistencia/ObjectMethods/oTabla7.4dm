$r:=CD_Dlog (0;__ ("Está seguro de que desea limpiar los rangos");__ ("");__ ("Si");__ ("No");__ ("Cancelar"))
If ($r=1)
	
	If (j_tabla2=1)
		For ($i;1;6)
			ATSTRAL_FALTAMINUTOSDESDE{$i}:=0
			ATSTRAL_FALTAMINUTOSHASTA{$i}:=0
			ATSTRAL_FALTACONV{$i}:=0
		End for 
	Else 
		For ($i;1;4)
			ATSTRAL_FALTAMINUTOSDESDE{$i}:=0
			ATSTRAL_FALTAMINUTOSHASTA{$i}:=0
			ATSTRAL_FALTACONV{$i}:=0
		End for 
	End if 
	
	
	AL_UpdateArrays (xALP_TablaFaltasMin;-2)  //rch 55275
End if 