//%attributes = {}
  //xALCB_EX_IndicadoresLogros

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;$Row)
$areaRef:=$1
$0:=True:C214
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	If (AL_GetCellMod ($areaRef)=1)
		AL_GetCurrCell ($areaRef;$Col;$Row)
		If ($col=2)
			COPY ARRAY:C226(aiEVLG_Indicadores_Valor;$aValues)
			SORT ARRAY:C229($aValues;<)
			[MPA_DefinicionCompetencias:187]Maximo_Indicadores:9:=$aValues{1}
			REDRAW:C174([MPA_DefinicionCompetencias:187]Maximo_Indicadores:9)
			POST OUTSIDE CALL:C329(Current process:C322)
		End if 
	End if 
End if 
