$nivelSuperior:=[xxSTR_Niveles:6]NoNivel:5+1
vt_NivelSuperior:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelSuperior;->[xxSTR_Niveles:6]Nivel:1)

If (Self:C308->=True:C214)
	vl_Pagina_a_mostrar:=1
	WDW_OpenFormWindow (->[xxSTR_Niveles:6];"InfoOpcionNivelSubAnual";-1;Movable form dialog box:K39:8;__ ("¡Advertencia!"))
	DIALOG:C40([xxSTR_Niveles:6];"InfoOpcionNivelSubAnual")
	CLOSE WINDOW:C154
	If (bActivate=1)
		
	Else 
		Self:C308->:=False:C215
	End if 
Else 
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6=[xxSTR_Niveles:6]NoNivel:5;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]Año:2=<>gYear)
	SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]ID_Alumno:4;$aIDalumnos)
	QUERY WITH ARRAY:C644([Alumnos_SintesisAnual:210]ID_Alumno:4;$aIDalumnos)
	QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6=$nivelSuperior;*)
	QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]Año:2=<>gYear)
	vl_alumnosEnNivelSuperior:=Records in selection:C76([Alumnos_SintesisAnual:210])
	If (vl_alumnosEnNivelSuperior>0)
		vl_Pagina_a_mostrar:=3
		WDW_OpenFormWindow (->[xxSTR_Niveles:6];"InfoOpcionNivelSubAnual";-1;Movable form dialog box:K39:8;__ ("¡ Advertencia !"))
		DIALOG:C40([xxSTR_Niveles:6];"InfoOpcionNivelSubAnual")
		CLOSE WINDOW:C154
		Self:C308->:=True:C214
	Else 
		
	End if 
End if 
