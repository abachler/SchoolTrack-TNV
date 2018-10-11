//%attributes = {}
  //xALP_ACT_CB_ImportCargos

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_PreImport;$col;$line)
	If (aIDItem{$line}="")
		aIDItem{$line}:="0"
	End if 
	$change:=AL_GetCellMod (xALP_PreImport)
	If ($change=1)
		Case of 
			: ($col=2)
				If ((aIDItem{$line}="0") & (aIDItem{0}#"0"))
					aGlosa{$line}:=""
					aMoneda{$line}:=<>vsACT_MonedaColegio
					aMontotxt{$line}:="0"
					aAfectoIVA{$line}:=""
					aCtaContable{$line}:=""
					aCodAux{$line}:=""
					aCentro{$line}:=""
					aCCtaContable{$line}:=""
					aCCodAux{$line}:=""
					aCCentro{$line}:=""
					aNoDocTribs{$line}:=""
					aAfectoaDxCta{$line}:=""
					aAfectoaDesctos{$line}:=""
					aPctInteres{$line}:=""
					aTipoInteres{$line}:=""
					aImpUnica{$line}:=""
					aDesctoH2{$line}:=""
					aDesctoH3{$line}:=""
					aDesctoH4{$line}:=""
					aDesctoH5{$line}:=""
					aDesctoH6{$line}:=""
					aDesctoH7{$line}:=""
					aDesctoH8{$line}:=""
					aDesctoH9{$line}:=""
					aDesctoH10{$line}:=""
					aDesctoH11{$line}:=""
					aDesctoH12{$line}:=""
					aDesctoH13{$line}:=""
					aDesctoH14{$line}:=""
					aDesctoH15{$line}:=""
					aDesctoH16{$line}:=""
					aDesctoH17{$line}:=""
					aCodigo_interno{$line}:=""
					aBloqueadas{$line}:=False:C215
				End if 
			: ($col=3)
				If ((aGlosa{$line}="") & (aGlosa{$line}#""))
					aIDItem{$line}:="0"
					aMoneda{$line}:=<>vsACT_MonedaColegio
					aMontotxt{$line}:="0"
					aAfectoIVA{$line}:=""
					aCtaContable{$line}:=""
					aCodAux{$line}:=""
					aCentro{$line}:=""
					aCCtaContable{$line}:=""
					aCCodAux{$line}:=""
					aCCentro{$line}:=""
					aNoDocTribs{$line}:=""
					aAfectoaDxCta{$line}:=""
					aAfectoaDesctos{$line}:=""
					aPctInteres{$line}:=""
					aTipoInteres{$line}:=""
					aImpUnica{$line}:=""
					aDesctoH2{$line}:=""
					aDesctoH3{$line}:=""
					aDesctoH4{$line}:=""
					aDesctoH5{$line}:=""
					aDesctoH6{$line}:=""
					aDesctoH7{$line}:=""
					aDesctoH8{$line}:=""
					aDesctoH9{$line}:=""
					aDesctoH10{$line}:=""
					aDesctoH11{$line}:=""
					aDesctoH12{$line}:=""
					aDesctoH13{$line}:=""
					aDesctoH14{$line}:=""
					aDesctoH15{$line}:=""
					aDesctoH16{$line}:=""
					aDesctoH17{$line}:=""
					aCodigo_interno{$line}:=""
					aBloqueadas{$line}:=False:C215
				End if 
		End case 
		ACTimp_AnalizeData ($line)
		If (aAprobado{$line})
			AL_SetRowStyle (xALP_PreImport;$line;0;"")
			AL_SetRowColor (xALP_PreImport;$line;"Black";0;"";0)
		Else 
			AL_SetRowStyle (xALP_PreImport;$line;1;"")
			AL_SetRowColor (xALP_PreImport;$line;"Red";0;"";0)
		End if 
		ARRAY INTEGER:C220($aInteger2D;2;0)
		If (aBloqueadas{$line})
			AL_SetCellEnter (xALP_PreImport;19;$line;39;$line;$aInteger2D;0)
		Else 
			AL_SetCellEnter (xALP_PreImport;19;$line;39;$line;$aInteger2D;1)
		End if 
		_O_ENABLE BUTTON:C192(bDelLine)
		AL_UpdateArrays (xALP_PreImport;-1)
		vt_Motivo:=aMotivo{$line}
		$import:=Find in array:C230(aAprobado;True:C214)
		
		  //20170621 RCH
		  //IT_SetButtonState (($import#-1);->bImport)
		OBJECT SET ENABLED:C1123(bImport;($import#-1))
		
		vlACT_CargosImpTotal:=Size of array:C274(aAprobado)
		aAprobado{0}:=True:C214
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->aAprobado;"=";->$DA_Return)
		vlACT_CargosImpAprobado:=Size of array:C274($DA_Return)
		vlACT_CargosImpRechazado:=vlACT_CargosImpTotal-vlACT_CargosImpAprobado
		REDRAW WINDOW:C456
	End if 
End if 