$row:=AL_GetLine (Self:C308->)
$col:=AL_GetColumn (Self:C308->)
If ($row>0)
	cb_EsEstandar:=Num:C11(abACT_ModelosEsSt{$row})
Else 
	cb_EsEstandar:=0
End if 
Case of 
	: (alProEvt=1)
		IT_SetButtonState (($row>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo;->cb_EsEstandar)
	: (alProEvt=AL Single Control Click)
		IT_SetButtonState (($row>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo;->cb_EsEstandar)
		ARRAY TEXT:C222(aMenuArray;9)
		aMenuArray{1}:=__ ("Nuevo Modelo...")
		aMenuArray{2}:=__ ("Editar Modelo...")
		aMenuArray{3}:="(-"
		aMenuArray{4}:=__ ("Duplicar Modelo")
		aMenuArray{5}:="(-"
		aMenuArray{6}:=__ ("Eliminar Modelo")
		aMenuArray{7}:="(-"
		aMenuArray{8}:=__ ("Guardar...")
		aMenuArray{9}:=__ ("Cargar...")
		$menuText:=AT_array2text (->aMenuArray)
		$choice:=Pop up menu:C542($menuText)
		ACTcfg_ManageDTModelPopUp ($choice)
	: (alProEvt=AL Empty Area Control Click)
		IT_SetButtonState (($row>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo;->cb_EsEstandar)
		ARRAY TEXT:C222(aMenuArray;9)
		aMenuArray{1}:=__ ("Nuevo Modelo...")
		aMenuArray{2}:="("+__ ("Editar Modelo...")
		aMenuArray{3}:="(-"
		aMenuArray{4}:="("+__ ("Duplicar Modelo")
		aMenuArray{5}:="(-"
		aMenuArray{6}:="("+__ ("Eliminar Modelo")
		aMenuArray{7}:="(-"
		aMenuArray{8}:="("+__ ("Guardar...")
		aMenuArray{9}:=__ ("Cargar...")
		
		$menuText:=AT_array2text (->aMenuArray)
		$choice:=Pop up menu:C542($menuText)
		ACTcfg_ManageDTModelPopUp ($choice)
	: (alproevt=AL Empty Area Single click)
		IT_SetButtonState (($row>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo;->cb_EsEstandar)
End case 

