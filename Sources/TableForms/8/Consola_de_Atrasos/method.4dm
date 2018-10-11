Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		PERIODOS_Init 
		ARRAY TEXT:C222(at_STR_Apellidos_Nombres;0)
		ARRAY TEXT:C222(at_STR_Curso;0)
		ARRAY DATE:C224(ad_STR_Fecha;0)
		ARRAY LONGINT:C221(al_STR_Minutos_Atrasos;0)
		
		  //mono opciones de busqueda, para el IT_clairvoyanceOnFields2 en el objeto rut
		C_LONGINT:C283(vl_OptSearch)
		ARRAY TEXT:C222(at_search_opt;0)
		APPEND TO ARRAY:C911(at_search_opt;__ ("Apellidos y Nombres"))
		APPEND TO ARRAY:C911(at_search_opt;__ ("Identificador Nacional"))
		APPEND TO ARRAY:C911(at_search_opt;__ ("N° de Pasaporte"))
		APPEND TO ARRAY:C911(at_search_opt;__ ("Código interno"))
		vl_OptSearch:=Num:C11(PREF_fGet (USR_GetUserID ;"OptSearch_ConsolaAtrasos";"1"))  //por defecto apellidos y nombres
		OBJECT SET TITLE:C194(*;"OptSearchSel";at_search_opt{vl_OptSearch})
		
		$err:=ALP_DefaultColSettings (xALP_Cond_Atrasos;1;"ad_STR_Fecha";"Fecha";90;"";0;0)
		$err:=ALP_DefaultColSettings (xALP_Cond_Atrasos;2;"at_STR_Apellidos_Nombres";__ ("Nombre alumno");180;"";0;0)
		$err:=ALP_DefaultColSettings (xALP_Cond_Atrasos;3;"at_STR_Curso";__ ("Curso");60;"";0;0)
		$err:=ALP_DefaultColSettings (xALP_Cond_Atrasos;4;"al_STR_Minutos_Atrasos";__ ("Minutos de atrasos");100;"####0";0;0)
		
		ALP_SetDefaultAppareance (xALP_Cond_Atrasos;9;1;7;1;8)
		
		vRut:=""
		vFecha:=Current date:C33(*)
		vHora:=Current time:C178(*)
		SET TIMER:C645(60)
		
		READ ONLY:C145([xShell_Reports:54])
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[Alumnos:2]);*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26="Ticket de atraso@")
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11;=;True:C214)
		ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)
		ARRAY TEXT:C222(atSTR_Modelos;0)
		SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;atSTR_Modelos)
		
		cbImprimirReport:=0
		cbImprimirReport:=Num:C11(PREF_fGet (0;"ConsolaAtrasosImprimirInforme";String:C10(cbImprimirReport)))
		b_filtraretirados:=1  //siempre se inicializa marcada la opción
		IT_SetButtonState (cbImprimirReport=1;->bModReport)
		If ((cbImprimirReport=1) & (Size of array:C274(atSTR_Modelos)>0))
			atSTR_Modelos:=1
			vtSTR_ReportModel:=atSTR_Modelos{atSTR_Modelos}
		Else 
			If (Size of array:C274(atSTR_Modelos)=0)
				vtSTR_ReportModel:="No hay modelos."
			Else 
				vtSTR_ReportModel:="No hay modelo seleccionado."
			End if 
			atSTR_Modelos:=0
		End if 
		
	: (Form event:C388=On Timer:K2:25)
		vFecha:=Current date:C33(*)
		vHora:=Current time:C178(*)
		SET TIMER:C645(60)
End case 