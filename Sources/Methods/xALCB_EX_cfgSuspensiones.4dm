//%attributes = {}
  //xALCB_EX_cfgSuspensiones

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$areaRef;$vol;$row;$modified)
$areaRef:=$1
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	$modified:=AL_GetCellMod ($areaRef)
	If ($modified=1)
		AL_GetCurrCell ($areaRef;$COL;$ROW)
		$foundAt:=Find in array:C230(atSTRal_MotivosSuspension;atSTRal_MotivosSuspension{$row})
		If ($foundAt#$row)
			$ignore:=CD_Dlog (0;__ ("Ya existe un motivo de suspensión del mismo nombre."))
			atSTRal_MotivosSuspension{$row}:=atSTRal_MotivosSuspension{0}
			AL_GotoCell ($areaRef;$col;$row)
			AL_SetCellHigh ($areaRef;1;255)
		Else 
			If (Length:C16(atSTRal_MotivosSuspension{$row})>255)
				BEEP:C151
				atSTRal_MotivosSuspension{$row}:=Substring:C12(atSTRal_MotivosSuspension{$row};1;255)
				CD_Dlog (0;__ ("El texto ingresado supera los 255 caracteres."))
			End if 
		End if 
	End if 
End if 