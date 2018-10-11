//%attributes = {}
  // QR_ImprimeFormulario()
  //
  //
  // creado por: Alberto Bachler Klein: 23-03-16, 20:09:55
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_LONGINT:C283($l_recNumInforme)
C_POINTER:C301($y_Tabla)
C_TEXT:C284($specialConfig;$t_destinoImpresion;$t_expresionNombreDocumento;$t_nombreFormulario;$t_nombreInforme;$t_rutaCarpetaDestino)


If (False:C215)
	C_LONGINT:C283(QR_ImprimeFormulario ;$1)
	C_TEXT:C284(QR_ImprimeFormulario ;$2)
	C_TEXT:C284(QR_ImprimeFormulario ;$3)
	C_TEXT:C284(QR_ImprimeFormulario ;$4)
End if 

C_TEXT:C284(vt_rutaCarpetaPDF)

$l_recNumInforme:=$1
Case of 
	: (Count parameters:C259=2)
		$t_destinoImpresion:=$2
	: (Count parameters:C259=3)
		$t_destinoImpresion:=$2
		$t_rutaCarpetaDestino:=$3
	: (Count parameters:C259=4)
		$t_destinoImpresion:=$2
		$t_rutaCarpetaDestino:=$3
		$t_expresionNombreDocumento:=$4
	: (Count parameters:C259=6)  //MONO 205131 - llamado desde QR_ImprimeGrupo
		$t_destinoImpresion:=$2
		$t_rutaCarpetaDestino:=$3
		$t_expresionNombreArchivo:=$4
		  //estos parámetros no son utlizados en este método pero son pasados por QR_ImprimeGrupo
		  //originalmente los formularios no son publicables en SN3
		$y_informes_at:=$5
		$b_destinoSNT:=$6
End case 

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)


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
		  //$t_expresionNombreDocumento:=vt_rutaCarpetaPDF+QR_EvaluaNombreDocumento ($t_expresionNombreDocumento;$t_destinoImpresion)
End case 


C_TEXT:C284(vsBWR_CurrentModule)
  // asigno nuevamente el modulo, al mandar a imprimir se pierde el valor debido a que es un nuevo proceso
  //20161003 JVP
vsBWR_CurrentModule:=[xShell_Reports:54]Modulo:41



  // variables fecha para usar en formularios
vtQR_DateTime:=String:C10(Current date:C33(*);7)+", "+String:C10(Current time:C178(*);2)
vdQR_Date:=Current date:C33(*)
vhQR_Time:=Current time:C178(*)

PERIODOS_Init 
EVS_LoadStyles 


READ ONLY:C145(*)
USE NAMED SELECTION:C332("◊Editions")
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)

If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
	EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
End if 

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
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
  //CLEAR NAMED SELECTION("◊Editions") //20170315 RCH La selección se crea con CUT


