//%attributes = {}
  //xALP_ACT_Set_DatosPresentados

For ($i;1;Size of array:C274(alACT_ArreglosUsados))
	RESOLVE POINTER:C394(apACT_ArreglosImportacion{alACT_ArreglosUsados{$i}};varName;tableNum;fieldNum)
	$Error:=AL_SetArraysNam (xALP_DatosImportados;$i;1;varName)
	AL_SetHeaders (xALP_DatosImportados;$i;1;atACT_Descripcion{CamposRegistro{$i}})
	AL_SetWidths (xALP_DatosImportados;$i;1;0)
	
	If (atACT_Tipo{CamposRegistro{$i}}#"AN")
		AL_SetFormat (xALP_DatosImportados;$i;"#########0";3;2;0;0)
	Else 
		AL_SetFormat (xALP_DatosImportados;$i;"";3;2;0;0)
	End if 
	AL_SetHdrStyle (xALP_DatosImportados;$i;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_DatosImportados;$i;"Tahoma";9;0)
	AL_SetStyle (xALP_DatosImportados;$i;"Tahoma";9;0)
	AL_SetBackColor (xALP_DatosImportados;$i;"White";0;"White";0;"White";0)
	AL_SetForeColor (xALP_DatosImportados;$i;"Black";0;"Black";0;"Black";0)
End for 
ALP_SetDefaultAppareance (xALP_DatosImportados;9;1;6;1;8)
AL_SetColOpts (xALP_DatosImportados;1;1;1;0;0)
AL_SetRowOpts (xALP_DatosImportados;0;0;0;0;1;0)
AL_SetCellOpts (xALP_DatosImportados;0;1;1)
AL_SetMainCalls (xALP_DatosImportados;"";"")
AL_SetCallbacks (xALP_DatosImportados;"";"")
AL_SetEntryOpts (xALP_DatosImportados;0;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_DatosImportados;0;30;0)