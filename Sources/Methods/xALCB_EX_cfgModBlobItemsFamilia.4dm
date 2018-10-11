//%attributes = {}
  //xALCB_EX_cfgModBlobItemsFamilia

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)
$0:=True:C214
If (AL_GetCellMod (xALP_DesctosFamilia)=1)
	AL_GetCurrCell (xALP_DesctosFamilia;$col;$line)
	If (arACT_DesctoPorHijo{$line}>100)
		CD_Dlog (0;__ ("El porcentaje de descuento no puede ser mayor a 100%."))
		arACT_DesctoPorHijo{$line}:=Round:C94(arACT_DesctoPorHijo{0};4)
	Else 
		arACT_DesctoPorHijo{$line}:=Round:C94(arACT_DesctoPorHijo{$line};4)
		ACTcfg_ModBlob:=True:C214
	End if 
End if 
