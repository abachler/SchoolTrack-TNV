ARRAY LONGINT:C221($al_Lines;0)
$err:=AL_GetSelect (ALP_Pagares;$al_Lines)
ARRAY LONGINT:C221($alACT_PagaresNoAnulados;0)
For ($i;Size of array:C274($al_Lines);1;-1)
	If (alACTp_Estado{$al_Lines{$i}}=-1)
		AT_Delete ($i;1;->$al_Lines)
	End if 
End for 
If (Size of array:C274($al_Lines)>0)
	$resp:=CD_Dlog (0;"¿Está seguro de anular el/los pagaré(s) seleccionado(s)?."+"\r\r"+"Esta acción no se puede deshacer.";"";"Si";"No")
	If ($resp=1)
		AL_UpdateArrays (ALP_Pagares;0)
		ACTcfg_OpcionesPagares ("AnularPagares";->$al_Lines)
		AL_UpdateArrays (ALP_Pagares;-2)
		ACTcfg_OpcionesPagares ("SetEstilos")
	End if 
End if 