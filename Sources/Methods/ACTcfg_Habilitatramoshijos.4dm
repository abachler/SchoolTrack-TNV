//%attributes = {}
  //ACTcfg_Habilitatramoshijos

$habilitahijos:=$1
$habilitatramos:=$2
$habilitafamilia:=$3

If ($habilitahijos)
	AL_SetEnterable (xALP_DesctosHijos;2;1)
Else 
	AL_SetEnterable (xALP_DesctosHijos;2;0)
	For ($i;1;16)
		$hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
		arACT_DesctoPorHijo{$i}:=0
	End for 
End if 
AL_UpdateArrays (xALP_DesctosHijos;-1)
If ($habilitatramos)
	AL_SetEnterable (xalp_desctostramos;2;1)
Else 
	AL_SetEnterable (xalp_desctostramos;2;0)
	For ($i;1;16)
		$tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
		arACT_DesctoTramo{$i}:=0
	End for 
End if 
AL_UpdateArrays (xalp_desctostramos;-1)
If ($habilitafamilia)
	AL_SetEnterable (xALP_DesctosFamilia;2;1)
Else 
	AL_SetEnterable (xALP_DesctosFamilia;2;0)
	For ($i;1;16)
		$hijo:=Get pointer:C304("vr_Familia"+String:C10($i+1))
		arACT_DesctoPorFamilia{$i}:=0
	End for 
End if 
AL_UpdateArrays (xALP_DesctosFamilia;-1)