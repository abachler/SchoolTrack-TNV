$nivelSuperior:=[xxSTR_Niveles:6]NoNivel:5+1
vt_NivelSuperior:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelSuperior;->[xxSTR_Niveles:6]Nivel:1)
vl_Pagina_a_mostrar:=2
WDW_OpenFormWindow (->[xxSTR_Niveles:6];"InfoOpcionNivelSubAnual";0;Movable form dialog box:K39:8;__ ("Información"))
DIALOG:C40([xxSTR_Niveles:6];"InfoOpcionNivelSubAnual")
CLOSE WINDOW:C154