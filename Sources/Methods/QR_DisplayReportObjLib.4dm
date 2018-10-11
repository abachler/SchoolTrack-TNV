//%attributes = {}
  // Método: QR_DisplayReportObjLib
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 16/02/10, 11:21:30
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283(hl_ReportObjLib;hl_StandardLibrary)
C_POINTER:C301($nilPointer)
C_LONGINT:C283(cbSRop_flagLeftLine;cbSRop_flagTopLine;cbSRop_flagRightLine;cbSRop_flagBottomLine;cbSRop_flagAllLine;cbSRop_FixHorPos;cbSRop_FixVertPos;cbSRopExpandH;cbSRop_ExpandV;cbSRop_VarWidth;cbSRop_VarHeight;cbSRop_RepIfEmpty;cbSRop_StoreValue;cbSRop_PrintCalcValue;cbSRop_Repeating;cbSRop_RepeatHor;cbSRop_RepeatVert;cbSRop_RepWholeLine)
C_LONGINT:C283(vlSRop_options;viSRop_ArrayIndex;viSRop_VerOffset;viSRop_VariableType)
C_TEXT:C284($vs_BreakVarName;vtSRop_VariableName;vtSRop_CalcValueVariable)

ARRAY POINTER:C280(aySRop_OptionsVariables;18)
aySRop_OptionsVariables{1}:=->cbSRop_flagLeftLine
aySRop_OptionsVariables{2}:=->cbSRop_flagTopLine
aySRop_OptionsVariables{3}:=->cbSRop_flagRightLine
aySRop_OptionsVariables{4}:=->cbSRop_flagBottomLine
  //aySRop_OptionsVariables{5}:=->cbSRop_flagAllLine
aySRop_OptionsVariables{5}:=->cbSRop_FixHorPos
aySRop_OptionsVariables{6}:=->cbSRop_FixVertPos
aySRop_OptionsVariables{7}:=->cbSRopExpandH
aySRop_OptionsVariables{8}:=->cbSRop_ExpandV
aySRop_OptionsVariables{9}:=->cbSRop_VarWidth
aySRop_OptionsVariables{10}:=->cbSRop_VarHeight
aySRop_OptionsVariables{11}:=->cbSRop_RepIfEmpty
aySRop_OptionsVariables{12}:=->cbSRop_StoreValue
aySRop_OptionsVariables{13}:=->cbSRop_PrintCalcValue
aySRop_OptionsVariables{14}:=->cbSRop_Repeating
aySRop_OptionsVariables{15}:=->cbSRop_RepeatVert
aySRop_OptionsVariables{16}:=->cbSRop_RepeatHor
aySRop_OptionsVariables{17}:=->cbSRop_RepWholeLine

viSRPop_VariableType:=0


hl_StandardLibrary:=New list:C375
HL_ClearList (hl_StandardLibrary)
QUERY:C277([XShell_ReportObjLib_Clases:274];[XShell_ReportObjLib_Clases:274]ID_Class:1>0)
hl_StandardLibrary:=HL_Selection2List (->[XShell_ReportObjLib_Clases:274]ClassName:2;->[XShell_ReportObjLib_Clases:274]ID_Class:1)

HL_ClearList (hl_ReportObjLib)
hl_ReportObjLib:=New list:C375
APPEND TO LIST:C376(hl_ReportObjLib;"ESTANDAR";-999999999;hl_StandardLibrary;True:C214)
SET LIST ITEM PROPERTIES:C386(hl_ReportObjLib;-999999999;False:C215;Bold:K14:2;0;0x00808285)

  // Código principal
WDW_OpenFormWindow ($nilPointer;"ReportObjectLib";8;-1)
DIALOG:C40("ReportObjectLib")
CLOSE WINDOW:C154


HL_ClearList (hl_ReportObjLib)
HL_ClearList (hl_StandardLibrary)