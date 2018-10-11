SAVE RECORD:C53([xxSTR_Niveles:6])
READ ONLY:C145([xxSTR_HistoricoNiveles:191])
QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3;=;[xxSTR_Niveles:6]NoNivel:5;*)
QUERY:C277([xxSTR_HistoricoNiveles:191]; & [xxSTR_HistoricoNiveles:191]ID_Institucion:1;=;<>gInstitucion)
ORDER BY:C49([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2;<)

  //04/05/2011 AS. cuando no existen historico de niveles se crean para que se pueda abrir  el formulario 

If (Records in selection:C76([xxSTR_HistoricoNiveles:191])=0)
	$year:=<>gyear-1
	CREATE RECORD:C68([xxSTR_HistoricoNiveles:191])
	[xxSTR_HistoricoNiveles:191]Año:2:=$year
	[xxSTR_HistoricoNiveles:191]NumeroNivel:3:=[xxSTR_Niveles:6]NoNivel:5
	[xxSTR_HistoricoNiveles:191]NombreDeCiclo:14:=[xxSTR_Niveles:6]Sección:9
	[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Interna:12:=[xxSTR_Niveles:6]Abreviatura:19
	[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Oficial:13:=[xxSTR_Niveles:6]Abreviatura_Oficial:35
	[xxSTR_HistoricoNiveles:191]DirectorResponsable:15:=[xxSTR_Niveles:6]Director:13
	[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=[xxSTR_Niveles:6]EvStyle_oficial:23
	[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=[xxSTR_Niveles:6]EvStyle_oficial:23
	[xxSTR_HistoricoNiveles:191]ID_Institucion:1:=<>gInstitucion
	[xxSTR_HistoricoNiveles:191]NombreInterno:5:=[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21
	[xxSTR_HistoricoNiveles:191]NombreOficial:6:=[xxSTR_Niveles:6]Nivel:1
	[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=2
	[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=[xxSTR_Niveles:6]AttendanceMode:3
	SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
	
	vl_SelectedYear:=[xxSTR_HistoricoNiveles:191]Año:2
	
	  //04/05/2011 AS. Se verifica si existen datos de cierre, en caso de no existir se crean.
	QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1=$year)
	
	If (Records in selection:C76([xxSTR_DatosDeCierre:24])=0)
		READ WRITE:C146([xxSTR_DatosDeCierre:24])
		
		If (($year>1950) & ($year<=Year of:C25(Current date:C33(*))))
			CREATE RECORD:C68([xxSTR_DatosDeCierre:24])
			[xxSTR_DatosDeCierre:24]Year:1:=$year
			[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5:=String:C10($year)
		End if 
		SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
		KRL_ReloadAsReadOnly (->[xxSTR_DatosDeCierre:24])
	End if 
	
Else 
	vl_SelectedYear:=[xxSTR_HistoricoNiveles:191]Año:2
End if 

WDW_OpenFormWindow (->[xxSTR_HistoricoNiveles:191];"Propiedades";-5;8;__ ("Años anteriores: ")+[xxSTR_Niveles:6]Nivel:1)
KRL_ModifyRecord (->[xxSTR_HistoricoNiveles:191];"Propiedades")
CLOSE WINDOW:C154