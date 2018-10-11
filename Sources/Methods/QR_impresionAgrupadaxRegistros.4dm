//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 05-06-18, 15:36:29
  // ----------------------------------------------------
  // Método: QR_impresionAgrupadaxRegistros
  // Descripción Imprimir una Carpeta con ditintos reprotes de diversos tipos (SR, Columnas, 4DWirte, etc)
  // , agrupados por registro de impresión (alumnos, personas, profesores, etc).
  //
  // Parámetros
  //1) Tipo de impresión: "printer", "preview", "pdf", "xml", "file", "html", "pict", "txt" 
  //NOTA(actualmente sólo hay llamados de printer y preview  así queda pendiente la implementación de los demas tipos)
  //2) puntero con los record number de los registros de los informes
  //3) puntero con los record number de los registros seleccionados del panel o selección a imprimir
  //4) puntero a la tabla de origen de los registros a imprimir
  // ----------------------------------------------------
  //20180903 ACTUALIZACION PARAMETROS DE MANEJO PARA SESION DE IMPRESION PARA SRP 

C_TEXT:C284($1;$t_TipoImpresion;$t_rutaImpDigital)
C_POINTER:C301($2;$y_recnumsInformes;$3;$y_recnumsRegistros;$4;$y_table)

C_LONGINT:C283($l_ProgressProcID;$i_regTabla;$l_numeroTabla;$l_sessionID)
C_TEXT:C284($t_carpetaArchivos;$t_impresora)
C_POINTER:C301($y_tablaReport)
C_TEXT:C284($t_Progress1;$t_Progress2)
C_REAL:C285($r_Progress1;$r_Progress2)
C_BOOLEAN:C305($b_ejecutarProp;$b_continuar;$b_displayPrintOptions;$b_closeSesion)
C_OBJECT:C1216($ob_resp)

$t_TipoImpresion:=$1
$y_recnumsInformes:=$2
$y_recnumsRegistros:=$3
$y_table:=$4

  //Array para controlar la ejecución de los scripts de las propiedades de los reportes.
ARRAY BOOLEAN:C223($ab_EjecutarPropInforme;0)
ARRAY BOOLEAN:C223($ab_EjecutarPropInforme;Size of array:C274($y_recnumsInformes->))
ARRAY TEXT:C222($at_ReportType;0)

$b_ejecutarProp:=True:C214
AT_Populate (->$ab_EjecutarPropInforme;->$b_ejecutarProp)

READ ONLY:C145($y_table->)
READ ONLY:C145([xShell_Reports:54])
CREATE SELECTION FROM ARRAY:C640([xShell_Reports:54];$y_recnumsInformes->)
SELECTION TO ARRAY:C260([xShell_Reports:54]ReportType:2;$at_ReportType)


$t_TipoImpresion:=Choose:C955($t_TipoImpresion="";"printer";$t_TipoImpresion)

$l_ProgressProcID:=IT_Progress (1;0;0;"QR_impresionAgrupadaxRegistros...")

  //Si no es impresión o preview en mac, es generación de archivos:
  //necesitamos saber si hay impresora pdf  
  //carpeta de destino de los archivos   
If ($t_TipoImpresion#"printer")
	If (Not:C34(($t_TipoImpresion="preview") & (SYS_IsMacintosh )))
		PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->$t_carpetaArchivos;0)
		$b_impresionPDF_OK:=UTIL_ImpresoraPDF (->$t_impresora)
		$t_carpetaArchivos:=$t_carpetaArchivos+"Preview"+Folder separator:K24:12
		CREATE FOLDER:C475($t_carpetaArchivos;*)
	End if 
End if 

  //Ciclo Registros del Panel (Alumnos, Cursos, Relaciones Familiares, etc...)
For ($i_regTabla;1;Size of array:C274($y_recnumsRegistros->))
	
	GOTO RECORD:C242($y_table->;$y_recnumsRegistros->{$i_regTabla})
	$t_Progress1:=__ ("Impresión para tabla ^0, Record Number: ^1";Table name:C256($y_table);String:C10($y_recnumsRegistros->{$i_regTabla}))
	$r_Progress1:=$i_regTabla/Size of array:C274($y_recnumsRegistros->)
	
	  //Nombre para impresión digital o generación de archivo:
	If ($t_TipoImpresion#"printer")
		If (Not:C34(($t_TipoImpresion="preview") & (SYS_IsMacintosh )))
			$t_nombreArchivo:=QR_EvaluaNombreInf ($y_table)+"_"+DTS_MakeFromDateTime 
			$t_rutaImprDigital:=$t_carpetaArchivos+$t_nombreArchivo
		End if 
	End if 
	
	  //Ciclo Reportes
	For ($i_regReport;1;Size of array:C274($y_recnumsInformes->))
		GOTO RECORD:C242([xShell_Reports:54];$y_recnumsInformes->{$i_regReport})
		$t_Progress2:=__ ("Informe: ^0";[xShell_Reports:54]ReportName:26)
		$r_Progress2:=$i_regTabla/Size of array:C274($y_recnumsRegistros->)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r_Progress1;$t_Progress1;$r_Progress2;$t_Progress2)
		
		  //Script de propiedades del informe
		If ($ab_EjecutarPropInforme{$i_regReport})
			dhQR_PrePrintInstructions ($y_table)
			
			If ([xShell_Reports:54]ReportType:2="gSR2")
				SRP_ValidaAjustesImpresion ($y_recnumsInformes->{$i_regReport})
			End if 
			
			$l_numeroTabla:=Choose:C955([xShell_Reports:54]RelatedTable:14=0;[xShell_Reports:54]MainTable:3;[xShell_Reports:54]RelatedTable:14)
			$y_tablaReport:=Table:C252($l_numeroTabla)
			
			If (([xShell_Reports:54]RelatedTable:14#0) & (Table:C252(->[xShell_Reports:54]RelatedTable:14)#Table:C252($y_tablaReport)))
				If ([xShell_Reports:54]SourceField:13#0)
					vyQR_StartField:=Field:C253([xShell_Reports:54]MainTable:3;[xShell_Reports:54]SourceField:13)
				End if 
				If ([xShell_Reports:54]RelatedField:15#0)
					vyQR_EndField:=Field:C253([xShell_Reports:54]RelatedTable:14;[xShell_Reports:54]RelatedField:15)
				End if 
			End if 
			
			QR_SetUnivers (Abs:C99([xShell_Reports:54]MainTable:3);[xShell_Reports:54]RelatedTable:14)
			
			If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			End if 
			
			$ab_EjecutarPropInforme{$i_regReport}:=([xShell_Reports:54]ExecuteAfterEachRecord:32 & ([xShell_Reports:54]ExecuteBeforePrinting:4#""))
		End if 
		
		  //Impresión por tipo de informe
		Case of 
			: ([xShell_Reports:54]ReportType:2="4DFO")  //FORMULARIO
				QR_PrintInfFormulario ($y_recnumsInformes->{$i_regReport};$t_TipoImpresion;$t_rutaImprDigital;$b_displayPrintOptions)
				
			: ([xShell_Reports:54]ReportType:2="4DSE")  //COLUMNAS
				QR_PrintInfColumna ($y_recnumsInformes->{$i_regReport};$t_TipoImpresion;$t_rutaImprDigital;$b_displayPrintOptions)
				
			: ([xShell_Reports:54]ReportType:2="4DET")  //ETIQUETAS
				QR_PrintInfEtiquetas ($y_recnumsInformes->{$i_regReport};$t_TipoImpresion;$t_rutaImprDigital;$b_displayPrintOptions)
				
			: ([xShell_Reports:54]ReportType:2="4DWR")  //4D Write
				QR_PrintInf4DWR ($y_recnumsInformes->{$i_regReport};$t_TipoImpresion;$t_rutaImprDigital;$b_displayPrintOptions)
				
			: ([xShell_Reports:54]ReportType:2="gSR2")  // SUPER REPORT
				  //Manejo de la sesión de impresión de SRP
				If (Not:C34(OB Is defined:C1231($ob_resp;"printSessionID")))
					$l_sessionID:=0
				Else 
					$l_sessionID:=OB Get:C1224($ob_resp;"printSessionID")
				End if 
				
				$l_siguienteSRP:=Find in array:C230($at_ReportType;"gSR2";$i_regReport+1)
				
				  //Mantenemos la sesion abierta si sabemos que el próximo informe que viene en la impresión es otro super Report
				$b_closeSesion:=True:C214
				If (($l_siguienteSRP>0) & ($l_siguienteSRP=($i_regReport+1)))
					$b_closeSesion:=False:C215
				End if 
				
				$ob_resp:=QR_PrintInfSuperReport ($y_recnumsInformes->{$i_regReport};$t_TipoImpresion;$t_rutaImprDigital;$b_displayPrintOptions;$l_sessionID;$b_closeSesion)
				
		End case 
		
	End for 
	
	CLEAR VARIABLE:C89($ob_resp)
	
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
