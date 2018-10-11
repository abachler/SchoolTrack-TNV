  //C_TEXT(vsACT_OldNomApellido)
  //IT_clairvoyanceOnFields2 (Self;->[Personas]Apellidos_y_nombres;False) 
  //Case of 
  //: (Form event=On Getting Focus)
  //vsACT_OldNomApellido:=Self->
  //
  //: (Form event=On Losing Focus)
  //If (Self->#"")
  //Case of 
  //: (Records in selection([Personas])=1)
  //l_idApdoSel:=[Personas]No
  //l_idTerSel:=0
  //
  //: (Records in selection([Personas])>1)
  //CD_Dlog (0;"Existe más de un registro con ese nombre.")
  //
  //: (Records in selection([Personas])=0)
  //CD_Dlog (0;"No existe un registro con ese nombre.")
  //
  //End case 
  //Else 
  //Self->:=vsACT_OldNomApellido
  //End if 
  //End case 
C_TEXT:C284(vsACT_OldNomApellido)
C_LONGINT:C283(l_idApdoSelT;l_idTerSelT)

l_idApdoSelT:=0
l_idTerSelT:=0

IT_Clairvoyance (Self:C308;->atACTbol_ApdosNombres;"";True:C214)

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		l_idApdoSelT:=l_idApdoSel
		l_idTerSelT:=l_idTerSel
		vsACT_OldNomApellido:=Self:C308->
		
	: (Form event:C388=On Losing Focus:K2:8)
		$l_pos:=Find in array:C230(atACTbol_ApdosNombres;Self:C308->)
		If ($l_pos=-1)
			BEEP:C151
			Self:C308->:=vsACT_OldNomApellido
			l_idApdoSel:=l_idApdoSelT
		Else 
			l_idApdoSel:=alACTbol_ApdosIds{$l_pos}
		End if 
		vbSpell_StopChecking:=True:C214
		
		$b_habilitar:=True:C214
		Case of 
			: (rb_actual0=1)
			: (rb_otro1=1)
				If (t_otroApoderado="")
					$b_habilitar:=False:C215
				End if 
			: (rb_otro2=1)
				If (t_otroTercero="")
					$b_habilitar:=False:C215
				End if 
			: (rb_publicoGeneral=1)
			: (rb_noEmitir=1)
		End case 
		OBJECT SET ENABLED:C1123(btn_aceptar;$b_habilitar)
		
End case 