//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 13-06-18, 18:48:55
  // ----------------------------------------------------
  // Método: QR_PrintInfFormulario
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($1)
C_TEXT:C284($2;$3)

C_LONGINT:C283($l_recNumInforme)
C_POINTER:C301($y_Tabla)
C_TEXT:C284($specialConfig;$t_destinoImpresion;$t_expresionNombreDocumento;$t_nombreFormulario;$t_nombreInforme;$t_rutaCarpetaDestino)

$l_recNumInforme:=$1
$t_destinoImpresion:=$2
$t_rutaArchivoImpresion:=$3

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)

READ ONLY:C145([xShell_Reports:54])
GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)
$t_nombreFormulario:=[xShell_Reports:54]FormName:17
$t_nombreInforme:=[xShell_Reports:54]ReportName:26
vt_PLConfigMessage:=[xShell_Reports:54]SpecialParameter:18
$y_Tabla:=Table:C252([xShell_Reports:54]MainTable:3)
yBWR_currentTable:=$y_Tabla

QR_InitGenericObjects 

Case of 
	: ($t_destinoImpresion="preview")
		SET PRINT PREVIEW:C364(True:C214)
		
	: ($t_destinoImpresion="pdf")
		PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->vt_rutaCarpetaPDF)
		
End case 

  // variables fecha para usar en formularios
  //vtQR_DateTime:=String(Current date(*);7)+", "+String(Current time(*);2)
  //vdQR_Date:=Current date(*)
  //vhQR_Time:=Current time(*)

PERIODOS_Init 
EVS_LoadStyles 

Case of 
	: ($t_nombreFormulario="Libreta2")
		prLibreta2 ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="Informe Jefatura")
		prInfJefatura ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="PlanillaP")
		prPlanillas ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="Impresión certificados")
		prCertificado ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="Concentración")
		prConcentración ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="Ficha del alumno@")
		prFichas ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="Ficha profesores")
		prFichasPRF ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="Actas")
		prActa ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="Nómina de inscritos")
		prNominaXCR ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: (($t_nombreFormulario="Inasistencias") | ($t_nombreFormulario="SintesisInasist"))
		prClassAbs ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="SintesisAnual")
		prSintesisAnual ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="Conducta")
		prConducta ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="CdctaPers")
		prCdctaPers ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="prFrecuenciaCalificaciones")
		prFrecuenciaCalificaciones ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="prPlanillaMultiPage")
		prPlanillaMultiPage ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="prPlanillaOnePage")
		prPlanillaOnePage ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="prPlanillaPeriodo")
		prPlanillaPeriodo ($t_destinoImpresion;$t_expresionNombreDocumento)  // revisado v12 (pdf e impresora) √
		
	: ($t_nombreFormulario="VisitasEnfermeria")  // revisado v12 (pdf e impresora) √
		prVisitasEnf ($t_destinoImpresion;$t_expresionNombreDocumento)
		
	: ($t_nombreFormulario="rep_plpform")  // revisado v12 (pdf e impresora) √
		prObservacionesAsignaturas ($t_destinoImpresion;$t_expresionNombreDocumento)
		
	: ($t_nombreFormulario="Postulaciones")
		$t_expresionNombreDocumento:="\"Postulaciones -\"+"
		$t_expresionNombreDocumento:=$t_expresionNombreDocumento+"[xShell_Reports]ReportName"
		pr_AdmissionsList ($t_destinoImpresion;$t_expresionNombreDocumento)
		
	: ($t_nombreFormulario="Horario")
		Case of 
			: ($y_tabla=->[Cursos:3])
				$t_expresionNombreDocumento:="[xShell_Reports]ReportName +\" - \"+[Cursos]Curso"
			: ($y_tabla=->[Alumnos:2])
				$t_expresionNombreDocumento:="[xShell_Reports]ReportName +\" - \"+[Alumnos]Curso+\". \"+[Alumnos]Apellidos_y_Nombres"
			: ($y_tabla=->[Profesores:4])
				$t_expresionNombreDocumento:="[xShell_Reports]ReportName +\" - \"+[Profesores]Apellidos_y_nombres"
		End case 
		pr_Horario ($t_destinoImpresion;$t_expresionNombreDocumento)
		
	Else 
		prSelection ($y_Tabla;$t_nombreFormulario;$specialConfig)
End case 