//%attributes = {}
  // QR_ImprimeInforme()
  //
  //
  // creado por: Alberto Bachler Klein: 23-03-16, 18:02:31
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_LONGINT:C283($l_idProceso;$l_proceso;$l_recNum;$l_recNumInforme)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_expresion;$t_expresionNombreDocumento;$t_nombreProceso;$t_rutaCarpetaPDF;$t_rutaCarpetaPDFs)

If (False:C215)
	C_LONGINT:C283(QR_ImprimeInforme ;$0)
	C_LONGINT:C283(QR_ImprimeInforme ;$1)
	C_TEXT:C284(QR_ImprimeInforme ;$2)
	C_TEXT:C284(QR_ImprimeInforme ;$3)
	C_TEXT:C284(QR_ImprimeInforme ;$4)
End if 

$l_recNumInforme:=$1
$t_destinoImpresion:=$2

Case of 
	: (Count parameters:C259=4)
		$t_rutaCarpetaPDFs:=$3
		$t_expresionNombreDocumento:=$4
	: (Count parameters:C259=3)
		$t_rutaCarpetaPDFs:=$3
End case 

If (Test path name:C476($t_rutaCarpetaPDFs)#Is a folder:K24:2)
	$t_rutaCarpetaPDFs:=""
End if 

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)


READ ONLY:C145(*)
GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)
$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)

  //20180925 RCH Recupero registro de eventos de usuario. Ticket 217123.
If ($t_destinoImpresion="preview")
	USR_RegisterUserEvent (UE_PreviewReport;vlBWR_SelectedTableRef;[xShell_Reports:54]ReportName:26+";"+[xShell_Reports:54]ReportType:2)
Else 
	USR_RegisterUserEvent (UE_PrintReport;vlBWR_SelectedTableRef;[xShell_Reports:54]ReportName:26+";"+[xShell_Reports:54]ReportType:2+";"+$t_destinoImpresion)
End if 

  //COPY NAMED SELECTION(vyQR_TablePointer->;"<>Editions")
CREATE SET:C116(vyQR_TablePointer->;"$setRegistrosActuales")  //20170325 RCH. Con cut se perdía la selección de registros actuales
CUT NAMED SELECTION:C334(vyQR_TablePointer->;"<>Editions")  //20170315 RCH
$t_nombreProceso:="Impresión de: "+[xShell_Reports:54]ReportName:26

Case of 
	: ([xShell_Reports:54]ReportType:2="4DFO")
		$l_idProceso:=New process:C317("QR_ImprimeFormulario";Pila_256K;$t_nombreProceso;$l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento)
		
	: ([xShell_Reports:54]ReportType:2="4DSE")
		$l_idProceso:=New process:C317("QR_ImprimeInformeColumnas";Pila_256K;$t_nombreProceso;$l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento)
		
	: ([xShell_Reports:54]ReportType:2="4DET")
		$l_idProceso:=New process:C317("QR_ImprimeEtiquetas";Pila_256K;$t_nombreProceso;$l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento)
		
	: ([xShell_Reports:54]ReportType:2="4DWR")
		$l_idProceso:=New process:C317("QR_ImprimeDocumento4DWrite";Pila_256K;$t_nombreProceso;$l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento)
		
	: ([xShell_Reports:54]ReportType:2="gSR2")
		$l_proceso:=New process:C317("QR_ImprimeInformeSRP";Pila_512K;$t_nombreProceso;$l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento)
End case 
USE SET:C118("$setRegistrosActuales")
SET_ClearSets ("$setRegistrosActuales")
$0:=$l_proceso