//%attributes = {}
  // QR_ImprimeGrupo()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 19:49:22
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_TEXT:C284($3)
C_POINTER:C301($4)

C_BOOLEAN:C305($b_display_print_options;$b_ExecuteBeforePrinting;$b_destinoSNT;$b_openPdfFolder)
C_LONGINT:C283($i;$l_idProceso;$l_proceso;$l_ProgressProcID;$l_recNumInforme;$state;$x)
C_POINTER:C301($y_campo;$y_informes_at;$y_recnumsInformes_al)
C_REAL:C285($r_progress1;$r_progress2)
C_TEXT:C284($t_destinoImpresion;$t_expresion;$t_expresionNombreDoc;$t_expresionNombreDoc;$t_nombreDocPDF;$t_NombreProceso;$t_Progress1;$t_Progress2;$t_rutaCarpetaPdf)
C_TEXT:C284($t_rutaCarpetaPdf)

ARRAY LONGINT:C221($al_IdInformes;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_nombreInformes;0)
ARRAY TEXT:C222($at_rutadocumentosPDF;0)

If (False:C215)
	C_TEXT:C284(QR_ImprimeGrupo ;$1)
	C_POINTER:C301(QR_ImprimeGrupo ;$2)
	C_TEXT:C284(QR_ImprimeGrupo ;$3)
	C_POINTER:C301(QR_ImprimeGrupo ;$4)
End if 

$t_destinoImpresion:=$1
$y_recnumsInformes_al:=$2
  //$y_informes_at:=->$at_rutadocumentosPDF

Case of 
	: (Count parameters:C259=5)
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
CREATE SET:C116(vyQR_TablePointer->;"$registros2Imprimir")  //20170315 RCH

  //agrego una variable y un arreglo
  //<>choiceIdx_inf  <>aLinesSelected_inf para el uso en algunos reportes
  //JVP 17-08-15
C_LONGINT:C283(<>periodo_inf;<>choiceIdx_inf)
ARRAY LONGINT:C221(<>aLinesSelected_inf;0)
C_DATE:C307(<>date_inf1;<>date_inf2)
<>periodo_inf:=0
<>choiceIdx_inf:=0
<>date_inf1:=!00-00-00!
<>date_inf2:=!00-00-00!


If (OK=1)
	$l_ProgressProcID:=IT_Progress (1;0;0;"Impresión de Carpeta de Informes...")
	
	$t_nombreDocPDF:=$t_rutaCarpetaPdf+"inf_"+DTS_MakeFromDateTime 
	$r_progress1:=$i/Size of array:C274($al_recNums)
	$t_Progress1:=String:C10($i)+" de "+String:C10(Size of array:C274($al_recNums))
	
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
		$t_expresionNombreDoc:=""
		
	Else 
		Case of 
			: (vyQR_TablePointer=->[Alumnos:2])
				$t_expresionNombreDoc:="\"inf_\"+DTS_MakeFromDateTime+\".\"+String([Alumnos]Número)"
		End case 
	End if 
	
	  //COPY NAMED SELECTION(vyQR_TablePointer->;"<>Editions")
	For ($x;1;Size of array:C274($y_recnumsInformes_al->))
		GOTO RECORD:C242([xShell_Reports:54];$y_recnumsInformes_al->{$x})
		$l_recNumInforme:=Record number:C243([xShell_Reports:54])
		
		$t_NombreProceso:="Impresión de: "+[xShell_Reports:54]ReportName:26
		$l_recNumInforme:=Record number:C243([xShell_Reports:54])
		$r_progress2:=$x/Size of array:C274($al_IdInformes)
		$t_Progress2:=$t_NombreProceso
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r_progress1;$t_Progress1;$r_progress2;$t_Progress2)
		
		  //COPY NAMED SELECTION(vyQR_TablePointer->;"<>Editions")
		
		  //20170315 RCH
		USE SET:C118("$registros2Imprimir")
		CUT NAMED SELECTION:C334(vyQR_TablePointer->;"<>Editions")
		
		$t_nombreProceso:="Impresión de: "+[xShell_Reports:54]ReportName:26
		
		ARRAY TEXT:C222($at_rutadocumentosPDF;0)
		
		Case of 
			: ([xShell_Reports:54]ReportType:2="4DFO")
				QR_ImprimeFormulario ($l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPdf;$t_expresionNombreDoc;$y_informes_at;$b_destinoSNT)
				
			: ([xShell_Reports:54]ReportType:2="4DSE")
				QR_ImprimeInformeColumnas ($l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPdf;$t_expresionNombreDoc;$y_informes_at;$b_destinoSNT)
				
			: ([xShell_Reports:54]ReportType:2="4DET")
				QR_ImprimeEtiquetas ($l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPdf;$t_expresionNombreDoc;$y_informes_at;$b_destinoSNT)
				
			: ([xShell_Reports:54]ReportType:2="4DWR")
				QR_ImprimeDocumento4DWrite ($l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPdf;$t_expresionNombreDoc;$y_informes_at;$b_destinoSNT)
				
			: ([xShell_Reports:54]ReportType:2="gSR2")
				QR_ImprimeInformeSRP ($l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPdf;$t_expresionNombreDoc;$y_informes_at;$b_destinoSNT)
		End case 
		  //USE NAMED SELECTION("<>Editions")
	End for 
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 

SET_ClearSets ("$registros2Imprimir")

  //MONO TICKET 197245 - 205131
If ($t_destinoImpresion="pdf")
	$resp:=ModernUI_Notificacion (__ ("Impresión de documentos en archivos");__ ("La impresión de documentos concluyó exitosamente\r\r¿Desea abrir la carpeta donde fueron almacenados?");__ ("Abrir carpeta");__ ("No"))
	If ($resp=1)
		If (vt_rutaCarpetaPDF="")
			PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->vt_rutaCarpetaPDF)
		End if 
		$t_rutaCarpetaPdf:=Choose:C955($t_rutaCarpetaPdf#"";$t_rutaCarpetaPdf;vt_rutaCarpetaPDF)
		SHOW ON DISK:C922($t_rutaCarpetaPdf;*)
	End if 
End if 
