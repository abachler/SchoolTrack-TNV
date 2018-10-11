//%attributes = {}
  //ACT_LeeConfiguracion

$accountTrackIsIntialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsIntialized=1)
	Compiler_ACT 
	ACTcc_InitVariables 
	ACTinit_LoadPrefs 
	ACTinit_FormArraysDeclarations 
	ADTcdd_LoadEstados2Arrays   //para poder buscar cuentas por situacion final en ADT
End if 