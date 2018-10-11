//%attributes = {}
  //xALCB_EX_cfgModBlobItemsTramos

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)
$0:=True:C214
If (AL_GetCellMod (xALP_DesctosTramos)=1)
	AL_GetCurrCell (xALP_DesctosTramos;$col;$line)
	If (arACT_DesctoTramo{$line}>100)
		CD_Dlog (0;__ ("El porcentaje de descuento no puede ser mayor a 100%."))
		arACT_DesctoTramo{$line}:=Round:C94(arACT_DesctoTramo{0};4)
	Else 
		arACT_DesctoTramo{$line}:=Round:C94(arACT_DesctoTramo{$line};4)
		ACTcfg_ModBlob:=True:C214
	End if 
End if 