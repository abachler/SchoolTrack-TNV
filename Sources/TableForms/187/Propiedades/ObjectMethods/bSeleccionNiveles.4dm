vl_TipoObjeto:=Logro_Aprendizaje
vl_NivelesEnEje:=KRL_GetNumericFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]BitsNiveles:20)
vl_NivelesEnDimension:=KRL_GetNumericFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionDimensiones:188]BitsNiveles:21)


vl_AplicaEnNiveles:=[MPA_DefinicionCompetencias:187]BitNiveles:28

  //MPA_Comp_AlGuardar 
  //If (MPA_Comp_EsValida )
  //20130122 ASM Se ocasionaba un problema con el cd_log
  //WDW_OpenPopupWindow (Self;->[MPA_DefinicionAreas];"SelecciónNiveles";32;__ ("Niveles en que aplica");"wdw_ClosePalette")
WDW_OpenFormWindow (->[MPA_DefinicionAreas:186];"SelecciónNiveles";7;0;__ ("Niveles en que aplica"))
DIALOG:C40([MPA_DefinicionAreas:186];"SelecciónNiveles")
CLOSE WINDOW:C154

[MPA_DefinicionCompetencias:187]BitNiveles:28:=vl_AplicaEnNiveles

If (Not:C34(Is new record:C668([MPA_DefinicionCompetencias:187])))
	MPAcfg_Comp_AlGuardar 
	If ((MPAcfg_Comp_EsValida ) & (Not:C34(Is new record:C668([MPA_DefinicionCompetencias:187]))))
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
	End if 
End if 
