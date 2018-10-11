//%attributes = {}
  // QR_NewQuickReportTemplate()
  // Por: Alberto Bachler: 08/03/13, 17:54:20
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

C_POINTER:C301($y_tablaRelacionada)
C_TEXT:C284($t_TablaPrincipal;$t_tablaRelacionada)

If (False:C215)
	C_POINTER:C301(QR_NewQuickReportTemplate ;$1)
End if 

C_POINTER:C301(vyQR_startField;vyQR_endField)
C_LONGINT:C283(vlQR_manyTableNumber)

REDUCE SELECTION:C351([xShell_Reports:54];0)
If (Count parameters:C259=1)
	$y_tablaRelacionada:=$1
	vlQR_MainTable:=Table:C252($1)
	vlQR_manyTableNumber:=Table:C252($y_tablaRelacionada)
	If (vlQR_manyTableNumber#Table:C252(vyQR_TablePointer))
		$t_TablaPrincipal:=XSvs_nombreTablaLocal_puntero (vyQR_TablePointer)
		$t_tablaRelacionada:=XSvs_nombreTablaLocal_puntero ($y_tablaRelacionada)
		READ ONLY:C145([xShell_Tables_RelatedFiles:243])
		QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;=;Table:C252(vyQR_TablePointer);*)
		QUERY:C277([xShell_Tables_RelatedFiles:243]; & ;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1=vlQR_manyTableNumber)
		If (Records in selection:C76([xShell_Tables_RelatedFiles:243])=0)
			CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("Los registros de ^1 no tienen relación con la selección de ^0.\r\rPara imprimir un informe desde ^1 es necesario establecer proceduralmente una relación entre ^0 y ^1.")+__ ("\r")+__ ("\rDespués de guardar el informe abra el cuadro de diálogo Propiedades del informe y en la zona Ejecutar antes de imprimir ingrese los comandos que permiten establecer dicha relación.");__ ("^0");$t_TablaPrincipal);__ ("^1");$t_tablaRelacionada))
		Else 
			vyQR_StartField:=Field:C253(Table:C252(vyQR_TablePointer);[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4)
			vyQR_EndField:=Field:C253(vlQR_manyTableNumber;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
		End if 
		OK:=QR_SetUnivers (Table:C252(vyQR_tablePointer);vlQR_MainTable)
	End if 
Else 
	vlQR_MainTable:=Table:C252(vyQR_TablePointer)
	vlQR_manyTableNumber:=0
End if 

USE CHARACTER SET:C205("MacRoman";0)
RecDelimit:=10

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
REDUCE SELECTION:C351([xShell_Reports:54];0)
QR_Editor 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
MESSAGES OFF:C175

RecDelimit:=13
USE CHARACTER SET:C205(*;0)
