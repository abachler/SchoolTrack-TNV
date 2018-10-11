vl_TipoObjeto:=Eje_Aprendizaje
vl_NivelesEnEje:=0

vl_AplicaEnNiveles:=[MPA_DefinicionEjes:185]BitsNiveles:20
  //20130122 ASM Se ocasionaba un problema con el cd_log
  //WDW_OpenPopupWindow (Self;->[MPA_DefinicionAreas];"SelecciónNiveles";32;__ ("Niveles en que aplica");"wdw_ClosePalette")
WDW_OpenFormWindow (->[MPA_DefinicionAreas:186];"SelecciónNiveles";7;0;__ ("Niveles en que aplica"))
DIALOG:C40([MPA_DefinicionAreas:186];"SelecciónNiveles")
CLOSE WINDOW:C154

[MPA_DefinicionEjes:185]BitsNiveles:20:=vl_AplicaEnNiveles
MPAcfg_Eje_AlGuardar 
If ((MPAcfg_Eje_EsValido ) & (Not:C34(Is new record:C668([MPA_DefinicionEjes:185]))))
	SAVE RECORD:C53([MPA_DefinicionEjes:185])
End if 