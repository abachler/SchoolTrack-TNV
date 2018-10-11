//%attributes = {}
  // QR_NewLabelTemplate()
  // Por: Alberto Bachler: 08/03/13, 17:51:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

C_BOOLEAN:C305($b_reconstruirLista)
C_POINTER:C301($y_tablaRelacionada)
C_TEXT:C284($t_mensaje)

If (False:C215)
	C_POINTER:C301(QR_NewLabelTemplate ;$1)
End if 


C_POINTER:C301(vyQR_startField;vyQR_endField)
C_LONGINT:C283(vlQR_manyTableNumber)

If (Count parameters:C259=1)
	$y_tablaRelacionada:=$1
	vlQR_manyTableNumber:=Table:C252($y_tablaRelacionada)
	If (vlQR_manyTableNumber#Table:C252(vyQR_TablePointer))
		READ ONLY:C145([xShell_Tables_RelatedFiles:243])
		QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;=;Table:C252(vyQR_TablePointer);*)
		QUERY:C277([xShell_Tables_RelatedFiles:243]; & ;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1=vlQR_manyTableNumber)
		vyQR_StartField:=Field:C253(Table:C252(vyQR_TablePointer);[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4)
		vyQR_EndField:=Field:C253(vlQR_manyTableNumber;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
	Else 
		vlQR_manyTableNumber:=0
	End if 
Else 
	vlQR_manyTableNumber:=0
End if 

If (vlQR_manyTableNumber>0)
	OK:=QR_SetUnivers (Table:C252(vyQR_tablePointer);vlQR_manyTableNumber)
	If (OK=1)
		CREATE SET:C116(yBWR_currentTable->;"◊printing")
	End if 
End if 

$t_rutaEtiquetas:=SYS_CarpetaAplicacion (CLG_DocumentosLocal)+"Modelos Etiquetas"+Folder separator:K24:12
CREATE FOLDER:C475($t_rutaEtiquetas;*)


$t_mensaje:=Replace string:C233(__ ("Para conservar los informes que usted cree en la base de datos  debe guardarlos en la carpeta:\r\rˆ0.\r\rAsí serán accesibles en el Explorador de Informes.\r\rSi prefiere conservarlos externamente guardelos en cualquier otro lugar");"ˆ0";$t_rutaEtiquetas)
CD_AutoCloseAlert ($t_mensaje)

document:=""
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
If (vlQR_manyTableNumber>0)
	ORDER BY:C49($y_tablaRelacionada->)
	PRINT LABEL:C39($y_tablaRelacionada->;Char:C90(1))
Else 
	ORDER BY:C49(vyQR_TablePointer->)
	PRINT LABEL:C39(vyQR_TablePointer->;Char:C90(1))
End if 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)


$b_reconstruirLista:=QR_UpdateTemplatesFromFolder ($t_rutaEtiquetas;-3;0)
If ($b_reconstruirLista)
	QR_BuildReportHList 
	REDUCE SELECTION:C351([xShell_Reports:54];0)
	If (vlQR_ReportRecNum>=0)
		QR_SelectReportInList (vlQR_ReportRecNum)
		QR_AjustesMenu 
	End if 
End if 