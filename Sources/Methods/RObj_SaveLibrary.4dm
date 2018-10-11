//%attributes = {}
  // Método: RObj_SaveLibrary
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/03/10, 17:37:45
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($filePath)
C_LONGINT:C283($p)
C_PICTURE:C286($pict)

  // Código principal
If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("RObj_SaveLibrary";Pila_256K;"RObj_SaveLibrary")
Else 
	
	$p:=IT_UThermometer (1;0;__ ("Guardando librería de objetos de informe..."))
	$filePath:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"ReportObjLib.txt"
	ARRAY POINTER:C280($aTablesToExport;0)
	APPEND TO ARRAY:C911($aTablesToExport;->[XShell_ReportObjLib_TableRefs:276])
	APPEND TO ARRAY:C911($aTablesToExport;->[XShell_ReportObjLib_Objects:275])
	APPEND TO ARRAY:C911($aTablesToExport;->[XShell_ReportObjLib_Clases:274])
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"ReportObjLib.txt"
	
	IO_ExportRecordsFromTables (->$aTablesToExport;$file)
	$p:=IT_UThermometer (-2;$p)
	
End if 



