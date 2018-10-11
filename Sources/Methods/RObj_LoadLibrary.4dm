//%attributes = {}
  // Método: RObj_LoadLibrary
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/03/10, 17:38:05
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("RObj_LoadLibrary";Pila_256K;"Lectura de Objetos Reportes")
Else 
	
	$filePath:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"ReportObjLib.txt"
	$p:=IT_UThermometer (1;0;__ ("Actualizando librería de objetos de informe..."))
	  //IO_ImportRecords2Tables ($filePath)
	
	ALL RECORDS:C47([XShell_ReportObjLib_Clases:274])
	KRL_DeleteSelection (->[XShell_ReportObjLib_Clases:274];False:C215)
	
	ALL RECORDS:C47([XShell_ReportObjLib_Objects:275])
	KRL_DeleteSelection (->[XShell_ReportObjLib_Objects:275];False:C215)
	
	ALL RECORDS:C47([XShell_ReportObjLib_TableRefs:276])
	KRL_DeleteSelection (->[XShell_ReportObjLib_TableRefs:276];False:C215)
	
	
	IO_ImportRecords2Tables ($filePath)
	
	$p:=IT_UThermometer (-2;$p)
End if 