//%attributes = {}
  //xALP_Set_CC_CuentasCbl

For ($i;1;39)
	$err:=AL_SetArraysNam (xALP_CuentasCbl;$i;1;"acampo"+String:C10($i))
End for 
$err:=AL_SetArraysNam (xALP_CuentasCbl;40;1;"aenccuenta")
$err:=AL_SetArraysNam (xALP_CuentasCbl;41;1;"aID")
For ($i;1;39)
	AL_SetHeaders (xALP_CuentasCbl;$i;1;aHeadersCbl{$i})
	AL_SetFormat (xALP_CuentasCbl;$i;"";0;0;0;0)
	AL_SetHdrStyle (xALP_CuentasCbl;$i;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_CuentasCbl;$i;"Tahoma";9;0)
	AL_SetStyle (xALP_CuentasCbl;$i;"Tahoma";9;0)
	AL_SetForeColor (xALP_CuentasCbl;$i;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_CuentasCbl;$i;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_CuentasCbl;$i;1)
	AL_SetEntryCtls (xALP_CuentasCbl;$i;0)
End for 
AL_SetEnterable (xALP_CuentasCbl;1;0)
AL_SetEnterable (xALP_CuentasCbl;4;3;atACT_CtasEspecialesGlosa)
AL_SetEnterable (xALP_CuentasCbl;16;0)
AL_SetEnterable (xALP_CuentasCbl;2;0)
AL_SetEnterable (xALP_CuentasCbl;3;0)
AL_SetFormat (xALP_CuentasCbl;2;"|Despliegue_ACT")
AL_SetFormat (xALP_CuentasCbl;3;"|Despliegue_ACT")
AL_SetFormat (xALP_CuentasCbl;5;"|Despliegue_ACT")
AL_SetFormat (xALP_CuentasCbl;6;"|Despliegue_ACT")
AL_SetFormat (xALP_CuentasCbl;7;"|Despliegue_ACT")
AL_SetFormat (xALP_CuentasCbl;13;"|Despliegue_ACT")
AL_SetFormat (xALP_CuentasCbl;15;"|Despliegue_ACT")
AL_SetFormat (xALP_CuentasCbl;18;"|Despliegue_ACT")
AL_SetFormat (xALP_CuentasCbl;21;"|Despliegue_ACT")
AL_SetFormat (xALP_CuentasCbl;25;"|Despliegue_ACT")
For ($i;27;38)
	AL_SetFormat (xALP_CuentasCbl;$i;"|Despliegue_ACT")
End for 

  //general options
ALP_SetDefaultAppareance (xALP_CuentasCbl;9;1;6;1;8;2;2)
AL_SetColOpts (xALP_CuentasCbl;1;1;1;2;0)
AL_SetRowOpts (xALP_CuentasCbl;1;1;0;0;1;0)
AL_SetCellOpts (xALP_CuentasCbl;0;1;1)
AL_SetMiscOpts (xALP_CuentasCbl;0;0;"\\";1;1)
AL_SetMainCalls (xALP_CuentasCbl;"";"")
AL_SetCallbacks (xALP_CuentasCbl;"";"xALP_ACT_CB_CuentasCbl")
AL_SetEntryOpts (xALP_CuentasCbl;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_CuentasCbl;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_CuentasCbl;1;"";"";"")
AL_SetDrgSrc (xALP_CuentasCbl;2;"";"";"")
AL_SetDrgSrc (xALP_CuentasCbl;3;"";"";"")
AL_SetDrgDst (xALP_CuentasCbl;1;"";"";"")
AL_SetDrgDst (xALP_CuentasCbl;1;"";"";"")
AL_SetDrgDst (xALP_CuentasCbl;1;"";"";"")

For ($i;1;39)
	$err:=AL_SetArraysNam (xALP_ContraCuentasCbl;$i;1;"acampocc"+String:C10($i))
End for 
$err:=AL_SetArraysNam (xALP_ContraCuentasCbl;$i;1;"aCCID")
For ($i;1;39)
	AL_SetHeaders (xALP_ContraCuentasCbl;$i;1;aHeadersCbl{$i})
	AL_SetFormat (xALP_ContraCuentasCbl;$i;"";0;0;0;0)
	AL_SetHdrStyle (xALP_ContraCuentasCbl;$i;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_ContraCuentasCbl;$i;"Tahoma";9;0)
	AL_SetStyle (xALP_ContraCuentasCbl;$i;"Tahoma";9;0)
	AL_SetForeColor (xALP_ContraCuentasCbl;$i;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_ContraCuentasCbl;$i;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_ContraCuentasCbl;$i;1)
	AL_SetEntryCtls (xALP_ContraCuentasCbl;$i;0)
End for 
AL_SetEnterable (xALP_ContraCuentasCbl;1;0)
AL_SetEnterable (xALP_ContraCuentasCbl;4;3;atACT_CtasEspecialesGlosa)
AL_SetEnterable (xALP_ContraCuentasCbl;16;0)
AL_SetFormat (xALP_ContraCuentasCbl;2;"|Despliegue_ACT")
AL_SetFormat (xALP_ContraCuentasCbl;3;"|Despliegue_ACT")
AL_SetFormat (xALP_ContraCuentasCbl;5;"|Despliegue_ACT")
AL_SetFormat (xALP_ContraCuentasCbl;6;"|Despliegue_ACT")
AL_SetFormat (xALP_ContraCuentasCbl;7;"|Despliegue_ACT")
AL_SetFormat (xALP_ContraCuentasCbl;13;"|Despliegue_ACT")
AL_SetFormat (xALP_ContraCuentasCbl;15;"|Despliegue_ACT")
AL_SetFormat (xALP_ContraCuentasCbl;18;"|Despliegue_ACT")
AL_SetFormat (xALP_ContraCuentasCbl;21;"|Despliegue_ACT")
AL_SetFormat (xALP_ContraCuentasCbl;25;"|Despliegue_ACT")
For ($i;27;38)
	AL_SetFormat (xALP_ContraCuentasCbl;$i;"|Despliegue_ACT")
End for 

  //general options
ALP_SetDefaultAppareance (xALP_ContraCuentasCbl;9;1;6;1;8;1;2)
AL_SetColOpts (xALP_ContraCuentasCbl;1;1;1;1;0)
AL_SetRowOpts (xALP_ContraCuentasCbl;0;1;0;0;1;0)
AL_SetCellOpts (xALP_ContraCuentasCbl;0;1;1)
AL_SetMiscOpts (xALP_ContraCuentasCbl;0;0;"\\";1;1)
AL_SetMainCalls (xALP_ContraCuentasCbl;"";"")
AL_SetCallbacks (xALP_ContraCuentasCbl;"";"xALP_ACT_CB_CCuentasCbl")
AL_SetEntryOpts (xALP_ContraCuentasCbl;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_ContraCuentasCbl;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_ContraCuentasCbl;1;"";"";"")
AL_SetDrgSrc (xALP_ContraCuentasCbl;2;"";"";"")
AL_SetDrgSrc (xALP_ContraCuentasCbl;3;"";"";"")
AL_SetDrgDst (xALP_ContraCuentasCbl;1;"";"";"")
AL_SetDrgDst (xALP_ContraCuentasCbl;1;"";"";"")
AL_SetDrgDst (xALP_ContraCuentasCbl;1;"";"";"")