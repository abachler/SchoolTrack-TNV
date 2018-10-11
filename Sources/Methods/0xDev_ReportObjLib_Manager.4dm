//%attributes = {}
  // Método: 0xDev_ReportObjLib_Manager
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 25/02/10, 15:23:49
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283(hl_ReportObjClasses;hl_Objects;hl_modules1;hl_modules;hl_ExplorerPanes)
C_TEXT:C284(vt_ClassName;vt_Restricciones;vt_description;vSintaxCheckResult)


  // Código principal
WDW_OpenFormWindow (->[XShell_ReportObjLib_Clases:274];"Manager";8;-1)
DIALOG:C40([XShell_ReportObjLib_Clases:274];"Manager")
CLOSE WINDOW:C154

HL_ClearList (hl_ReportObjClasses;hl_Objects;hl_modules1;hl_modules;hl_ExplorerPanes)

