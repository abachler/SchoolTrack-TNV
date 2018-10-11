//%attributes = {}
  // QR_imprimeSRP_PDFfolder
  // Daniel Ledezma Chimaja, 12-11-2016
  // Desarrollado para imprimir una carpeta con informes en super report en pdf agrupados por alumno (tal como los solicita SN3)
  // -----------------------------------------------------------

C_TEXT:C284($1)
C_POINTER:C301($2)
C_TEXT:C284($3)
C_POINTER:C301($4)
C_BOOLEAN:C305($5;$6)

C_BOOLEAN:C305($b_destinoSNT;$b_showPath)
C_LONGINT:C283($i_regTable;$l_ProgressProcID;$x;$session)
C_POINTER:C301($y_campo;$y_informes_at;$y_recnumsInformes_al)
C_REAL:C285($r_progress1;$r_progress2)
C_TEXT:C284($t_destinoImpresion;$t_expresion;$t_expresionNombreDoc;$t_expresionNombreDoc;$t_nombreDocPDF;$t_NombreProceso;$t_rutaCarpetaPdf;$t_dts)
C_TEXT:C284($t_Progress1;$t_Progress2;$t_NombreDoc)

ARRAY LONGINT:C221($al_IdInformes;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_nombreInformes;0)
ARRAY TEXT:C222($at_rutadocumentosPDF;0)

$t_destinoImpresion:=$1
$y_recnumsInformes_al:=$2
PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->$t_rutaCarpetaPdf)
$b_showPath:=True:C214

Case of 
	: (Count parameters:C259=6)
		$b_showPath:=$6
		$b_destinoSNT:=$5
		$y_informes_at:=$4
		$t_rutaCarpetaPdf:=$3
		
	: (Count parameters:C259=4)
		$y_informes_at:=$4
		$t_rutaCarpetaPdf:=$3
		
	: (Count parameters:C259=3)
		$t_rutaCarpetaPdf:=$3
End case 

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)

LONGINT ARRAY FROM SELECTION:C647(vyQR_TablePointer->;$al_recNums;"")

  //JVP 17-08-15
C_LONGINT:C283(<>periodo_inf;<>choiceIdx_inf)
ARRAY LONGINT:C221(<>aLinesSelected_inf;0)
C_DATE:C307(<>date_inf1;<>date_inf2)
<>periodo_inf:=0
<>choiceIdx_inf:=0
<>date_inf1:=!00-00-00!
<>date_inf2:=!00-00-00!

If (OK=1)
	$l_ProgressProcID:=IT_Progress (1;0;0;"Impresión de Carpeta de Informes Super Report...")
	
	If (Not:C34($b_destinoSNT))
		
		Case of 
			: (vyQR_TablePointer=->[Alumnos:2])
				$t_expresionNombreDoc:="String([Alumnos]Número)+\"_\"+[Alumnos]Curso+\"_\"+[Alumnos]Apellidos_y_Nombres"
				
			: (vyQR_TablePointer=->[Personas:7])
				$t_expresionNombreDoc:="String([Personas]No)"
				
			: (vyQR_TablePointer=->[Cursos:3])
				$t_expresionNombreDoc:="String([Cursos]Numero_del_curso)"
				
			: (vyQR_TablePointer=->[ACT_CuentasCorrientes:175])
				$t_expresionNombreDoc:="String([ACT_CuentasCorrientes]ID)"
				$y_campo:=->[ACT_CuentasCorrientes:175]ID:1
				
			: (vyQR_TablePointer=->[Asignaturas:18])
				$t_expresionNombreDoc:="String([Asignaturas]Numero)"
		End case 
		
	Else 
		
		Case of 
			: (vyQR_TablePointer=->[Alumnos:2])
				$t_dts:=DTS_MakeFromDateTime 
				$t_expresionNombreDoc:="\"inf_"+$t_dts+".\"+String([Alumnos]Número)"
		End case 
		
	End if 
	
	For ($i_regTable;1;Size of array:C274($al_recNums))  //Registros de impresión (ALumno, Personas, Profesores, etc.)
		
		GOTO RECORD:C242(vyQR_TablePointer->;$al_recNums{$i_regTable})
		
		$t_NombreDoc:=QR_EvaluaNombreDocumento ($t_expresionNombreDoc;"")+".pdf"
		$r_progress1:=$i_regTable/Size of array:C274($al_recNums)
		$t_Progress1:=$t_NombreDoc
		
		For ($x;1;Size of array:C274($y_recnumsInformes_al->))
			
			GOTO RECORD:C242([xShell_Reports:54];$y_recnumsInformes_al->{$x})
			
			$r_progress2:=$x/Size of array:C274($y_recnumsInformes_al->)
			$t_Progress2:="Impresión de: "+[xShell_Reports:54]ReportName:26
			
			$l_error:=SR_ConvertReportToXML ([xShell_Reports:54]xReportData_:29;$t_informeXML;[xShell_Reports:54]ReportName:26;"SRdh_ExecuteScript")
			
			If ($x=1)
				$t_rutaDocumento:=$t_rutaCarpetaPdf+$t_NombreDoc
				$error:=SR_OpenSession ($session;SRP_Print_DestinationPDF+SRP_Print_NoProgress;$t_rutaDocumento;$t_informeXML;$t_NombreDoc;"")
			End if 
			
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r_progress1;$t_Progress1;$r_progress2;$t_Progress2)
			
			If ([xShell_Reports:54]ReportType:2="gSR2")
				If ($i_regTable=1)  //si es el primer registro de impresión ejecutamos las propiedades del informe (por ejemplo para no pedir el numero de periodo para todos los alumnos)
					If (SR_ValidaScripts )
						QR_PreProcesamiento (vyQR_TablePointer;$y_recnumsInformes_al->{$x})
						If (Not:C34([xShell_Reports:54]NoRequiereSeleccion:40))
							If ([xShell_Reports:54]isOneRecordReport:11)
								If (([xShell_Reports:54]ExecuteBeforeEachDocument:31) & ([xShell_Reports:54]ExecuteBeforePrinting:4#""))
									SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
									EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
									SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
								Else 
									If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
										SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
										EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
										SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
									End if 
								End if 
							End if 
						End if 
					End if 
				End if 
				
				If (OK=1)
					$l_error:=SR_Print ($t_informeXML;0;SRP_Print_NoProgress;"";$session)
				End if 
				
			End if 
			
			If ($x=Size of array:C274($y_recnumsInformes_al->))
				$error:=SR_CloseSession ($session)
				If ((Not:C34(Is nil pointer:C315($y_informes_at))) & ($error=0))
					APPEND TO ARRAY:C911($y_informes_at->;$t_NombreDoc)
				End if 
			End if 
			
		End for 
		
	End for 
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	If ($b_showPath)
		ACTcd_DlogWithShowOnDisk ($t_rutaCarpetaPdf;0;" El (Los)  archivo(s)  se generó correctamente. Lo puede encontrar en: "+$t_rutaCarpetaPdf)
	End if 
End if 