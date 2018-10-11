Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ARRAY TEXT:C222(at_reglasLectores;0)
		READ ONLY:C145([xxBBL_ReglasParaUsuarios:64])
		ALL RECORDS:C47([xxBBL_ReglasParaUsuarios:64])
		ORDER BY:C49([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2;>)
		SELECTION TO ARRAY:C260([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;at_reglasLectores)
		AT_Insert (1;1;->at_reglasLectores)
		at_reglasLectores{1}:="Cualquiera"
		vt_regla:=at_reglasLectores{1}
		btnAmbos:=1
		vlDiasAtraso:=1
		If (Size of array:C274(<>at_NombreNivelesRegulares)>0)
			nivelNombre1:=<>at_NombreNivelesRegulares{1}
			nivelNombre2:=<>at_NombreNivelesRegulares{1}
			vl_nivel1:=<>al_NumeroNivelRegular{1}
			vl_nivel2:=<>al_NumeroNivelRegular{1}
		Else 
			nivelNombre1:=""
			nivelNombre2:=""
			vl_nivel1:=0
			vl_nivel2:=0
		End if 
		wref:=WDW_GetWindowID 
	: (Form event:C388=On Clicked:K2:4)
		If (cb_niveles=1)
			OBJECT SET VISIBLE:C603(*;"btn_nivel@";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"btn_nivel@";True:C214)
		End if 
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
End case 