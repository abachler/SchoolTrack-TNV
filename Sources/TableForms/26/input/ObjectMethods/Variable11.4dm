_O_C_INTEGER:C282($i)
ARRAY INTEGER:C220(aLines;0)
ARRAY TEXT:C222(atQuitar;0)
$r:=AL_GetSelect (xalp_ListaComunas;aLines)

If ($r=1)
	AL_UpdateArrays (xalp_Comunas;0)
	For ($i;1;Size of array:C274(aLines))
		$IndiceCreacion:=Size of array:C274(atBU_GenNomCom)+1
		INSERT IN ARRAY:C227(atBU_GenNomCom;$IndiceCreacion)
		atBU_GenNomCom{$IndiceCreacion}:=atBU_NomCom{aLines{$i}}
		INSERT IN ARRAY:C227(atQuitar;$i)
		atQuitar{$i}:=atBU_NomCom{aLines{$i}}
	End for 
	
	AL_UpdateArrays (xalp_Comunas;-2)
	
	AL_UpdateArrays (xalp_ListaComunas;0)
	For ($i;Size of array:C274(aLines);1;-1)
		AT_Delete (aLines{$i};1;->atBU_NomCom)
	End for 
	AL_UpdateArrays (xalp_ListaComunas;-2)
	AT_Initialize (->aLines)
End if 