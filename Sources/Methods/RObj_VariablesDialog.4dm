//%attributes = {}
  // Método: `RObj_VariablesDialog
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

ARRAY POINTER:C280(aySRop_OptionsVariables;17)
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


  //hl_StandardLibrary:=New list
  //HL_ClearList (hl_StandardLibrary)

ARRAY LONGINT:C221(atSRPop_ObjectIDs;0)
ARRAY TEXT:C222(atSRPop_ObjectNames;0)
ARRAY LONGINT:C221(atSRPop_ClassIds;0)

$xBlob:=RObj_BuildObjectList (Table:C252(vyQR_TablePointer))
$otRef:=OT BLOBToObject ($xBlob)
OT GetBLOB ($otRef;"StandardLibrary";$xBlob)
OT GetArray ($otRef;"atSRPop_ObjectNames";atSRPop_ObjectNames)
OT GetArray ($otRef;"atSRPop_ObjectIDs";atSRPop_ObjectIDs)
OT GetArray ($otRef;"atSRPop_ClassIds";atSRPop_ClassIds)
OT Clear ($otRef)  //2015/08/13
hl_StandardLibrary:=BLOB to list:C557($xBlob)


  //QUERY([XShell_ReportObjLib_TableRefs];[XShell_ReportObjLib_TableRefs]ID_Table;=;Table(vyQR_TablePointer))
  //KRL_RelateSelection (->[XShell_ReportObjLib_Clases]ID_Class;->[XShell_ReportObjLib_TableRefs]ID_Class;"")
  //
  //CREATE SET([XShell_ReportObjLib_Clases];"Especificos")
  //QUERY([XShell_ReportObjLib_Clases];[XShell_ReportObjLib_Clases]Module=0)
  //CREATE SET([XShell_ReportObjLib_Clases];"Comunes")
  //UNION("Especificos";"Comunes";"Clases")
  //USE SET("Clases")
  //ORDER BY([XShell_ReportObjLib_Clases];[XShell_ReportObjLib_Clases]Module;>;[XShell_ReportObjLib_Clases]ClassName;>)
  //SET_ClearSets ("Especificos";"Comunes";"Clases")
  //
  //KRL_RelateSelection (->[XShell_ReportObjLib_Objects]ID_Class;->[XShell_ReportObjLib_Clases]ID_Class;"")
  //SELECTION TO ARRAY([XShell_ReportObjLib_Objects]ObjectName;atSRPop_ObjectNames;[XShell_ReportObjLib_Objects]ID_Object;atSRPop_ObjectIDs;[XShell_ReportObjLib_Objects]ID_Class;atSRPop_ClassIds)
  //  `For ($i;1;Size of array(atSRPop_ObjectNames))
  //  `atSRPop_ObjectNames{$i}:=Replace string(atSRPop_ObjectNames{$i};"◊";"<>")
  //  `End for 
  //
  //hl_StandardLibrary:=HL_Selection2List (->[XShell_ReportObjLib_Clases]ClassName;->[XShell_ReportObjLib_Clases]ID_Class)
  //
  //
  //For ($i;1;Count list items(hl_StandardLibrary))
  //GET LIST ITEM(hl_StandardLibrary;$i;$classID;$className)
  //QUERY([XShell_ReportObjLib_Objects];[XShell_ReportObjLib_Objects]ID_Class=$classID)
  //ORDER BY([XShell_ReportObjLib_Objects];[XShell_ReportObjLib_Objects]ObjectName;>)
  //$hl_ClassObjects:=HL_Selection2List (->[XShell_ReportObjLib_Objects]UI_Name;->[XShell_ReportObjLib_Objects]ID_Object)
  //SET LIST ITEM(hl_StandardLibrary;$classID;$className;-$classID;$hl_ClassObjects;False)
  //SET LIST ITEM PROPERTIES(hl_StandardLibrary;-$classID;False;1;0)
  //End for 


If (Size of array:C274(atSRPop_ObjectIDs)>0)
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
	OK:=1
Else 
	OK:=0
End if 