$confirm:=False:C215
For ($i;1;Size of array:C274(aiEVLG_Indicadores_Valor))
	If (Self:C308-><aiEVLG_Indicadores_Valor{$i})
		$i:=Size of array:C274(aiEVLG_Indicadores_Valor)+1
		$confirm:=True:C214
	End if 
End for 

If ($confirm)
	  //$msg:="Este valor es inferior al valor definido para uno más indicadores.\rPuede ajustar "+"la valoración de los indicadores a este máximo o modificar este valor.\r\r¿Que dese"+"a Usted hacer?"
	$result:=CD_Dlog (0;__ ("Este valor es inferior al valor definido para uno más indicadores.\rPuede ajustar la valoración de los indicadores a este máximo o modificar este valor.\r\r¿Que desea Usted hacer?");__ ("");__ ("Modificar Máximo");__ ("Ajustar Indicadores");__ ("Cancelar"))
	Case of 
		: ($result=3)  //cancel
			
		: ($result=1)
			Self:C308->:=aiEVLG_Indicadores_Valor{1}
			For ($i;1;Size of array:C274(aiEVLG_Indicadores_Valor))
				If (aiEVLG_Indicadores_Valor{$i}>Self:C308->)
					Self:C308->:=aiEVLG_Indicadores_Valor{$i}
				End if 
			End for 
		: ($result=2)
			For ($i;1;Size of array:C274(aiEVLG_Indicadores_Valor))
				If (aiEVLG_Indicadores_Valor{$i}>Self:C308->)
					aiEVLG_Indicadores_Valor{$i}:=Self:C308->
				End if 
			End for 
			AL_UpdateArrays (xALP_Indicadores;-1)
	End case 
End if 