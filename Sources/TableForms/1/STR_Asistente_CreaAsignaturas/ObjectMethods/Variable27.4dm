GET LIST ITEM:C378(Self:C308->;*;$numeroNivel;$vt_NivelDesde)
$choice:=CD_Dlog (0;__ ("¿Desea realmente reemplazar la malla curricular de ")+vt_Nivel+__ (" por la de ")+$vt_NivelDesde+__ ("?");__ ("");__ ("No");__ ("Si, Reemplazar"))
If ($choice=2)
	AL_UpdateArrays (xALP_PlanNivel;0)
	WZD_GetGradePlan ($numeroNivel)
	AL_UpdateArrays (xALP_PlanNivel;Size of array:C274(aSubject))
End if 
SELECT LIST ITEMS BY POSITION:C381(Self:C308->;1)