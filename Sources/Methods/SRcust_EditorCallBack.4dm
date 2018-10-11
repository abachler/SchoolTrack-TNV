//%attributes = {}
  //Metodo: SRcust_EditorCallBack
  //Por abachler
  //Creada el 04/03/2008, 23:03:57
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //  //DECLARACIONES & INICIALIZACIONES
  //C_BOOLEAN($setScripts;$showOptions)
  //C_LONGINT($1;$2;$3;$4;$0)
  //
  //C_LONGINT(hl_ReportObjLib;hl_StandardLibrary)
  //C_LONGINT(cbSRop_flagLeftLine;cbSRop_flagTopLine;cbSRop_flagRightLine;cbSRop_flagBottomLine;cbSRop_flagAllLine;cbSRop_FixHorPos;cbSRop_FixVertPos;cbSRopExpandH;cbSRop_ExpandV;cbSRop_VarWidth;cbSRop_VarHeight;cbSRop_RepIfEmpty;cbSRop_StoreValue;cbSRop_PrintCalcValue;cbSRop_Repeating;cbSRop_RepeatHor;cbSRop_RepeatVert;cbSRop_RepWholeLine)
  //C_LONGINT(vlSRop_options;viSRop_ArrayIndex;viSRop_VerOffset;viSRop_VariableType)
  //C_TEXT($vs_BreakVarName;vtSRop_VariableName;vtSRop_CalcValueVariable;vtSRop_format)
  //
  //ARRAY POINTER(aySRop_OptionsVariables;17)
  //aySRop_OptionsVariables{1}:=->cbSRop_flagLeftLine
  //aySRop_OptionsVariables{2}:=->cbSRop_flagTopLine
  //aySRop_OptionsVariables{3}:=->cbSRop_flagRightLine
  //aySRop_OptionsVariables{4}:=->cbSRop_flagBottomLine
  //  //aySRop_OptionsVariables{5}:=->cbSRop_flagAllLine
  //aySRop_OptionsVariables{5}:=->cbSRop_FixHorPos
  //aySRop_OptionsVariables{6}:=->cbSRop_FixVertPos
  //aySRop_OptionsVariables{7}:=->cbSRopExpandH
  //aySRop_OptionsVariables{8}:=->cbSRop_ExpandV
  //aySRop_OptionsVariables{9}:=->cbSRop_VarWidth
  //aySRop_OptionsVariables{10}:=->cbSRop_VarHeight
  //aySRop_OptionsVariables{11}:=->cbSRop_RepIfEmpty
  //aySRop_OptionsVariables{12}:=->cbSRop_StoreValue
  //aySRop_OptionsVariables{13}:=->cbSRop_PrintCalcValue
  //aySRop_OptionsVariables{14}:=->cbSRop_Repeating
  //aySRop_OptionsVariables{15}:=->cbSRop_RepeatVert
  //aySRop_OptionsVariables{16}:=->cbSRop_RepeatHor
  //aySRop_OptionsVariables{17}:=->cbSRop_RepWholeLine
  //
  //
  //
  //
  //C_LONGINT($vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo)
  //C_LONGINT($objId;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;vlSRop_options;$order;$selected;$tableNo;$fieldNo;$varType;viSRop_ArrayIndex;$calcType;$rows;$cols;viSRop_HorOffset;viSRop_VerOffset)
  //C_TEXT($vs_BreakVarName;vtSRop_VariableName;vtSRop_CalcValueVariable)
  //C_POINTER($pointer)
  //$area:=$1
  //$action:=$2
  //$itemRef:=$3
  //$objectType:=$4
  //$0:=1
  //ARRAY TEXT(aScriptLines;0)
  //
  //
  //  //CUERPO
  //Case of 
  //  //: (($action>0) & (vlQR_MainTable=Table(->[Alumnos_EvaluacionAprendizajes])))
  //  //$0:=SRcb_EvaluacionAprendizajes ($area;$action;$itemRef;$objectType)
  //
  //: ($action=SR Editor Selection Changed)
  //ARRAY LONGINT(aObjectsIDs;0)
  //$err:=SR Get Object IDs (srArea;SR All Objects;aObjectsIDs)
  //
  //
  //: ($action=SR Editor Control Click Object)
  //$r:=Pop up menu("Id_objeto; linea 2; linea 3";0)
  //If ($r=1)
  //CD_Dlog (0;__ ("El ID del objeto es: ")+String($itemRef))
  //End if 
  //
  //  //20120201 AS. existian problemas con las variables y el editor (Ticket 90641). se comenta codigo por indicaciones de Alberto 
  //  //: (($action=SR Editor Create Object) & ($objectType=SR Object Type Variable))
  //  //
  //  //$0:=0
  //  //POST KEY(Character code("M");256)
  //  //
  //  //: (($action=SR Editor Modify Object) & ($objectType=SR Object Type Variable))
  //  //For ($i;1;Size of array(aySRop_OptionsVariables))
  //  //aySRop_OptionsVariables{$i}->:=0
  //  //End for 
  //  //SR Get Object Properties (xReportData;$itemRef;vtSRop_VariableName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;vlSRop_options;$order;$selected;$tableNo;$fieldNo;viSRop_VariableType;viSRop_ArrayIndex;viSRop_CalcType;vtSRop_CalcValueVariable;$rows;$cols;viSRop_HorOffset;viSRop_VerOffset)
  //  //For ($i;0;Size of array(aySRop_OptionsVariables)-1)
  //  //aySRop_OptionsVariables{$i+1}->:=Num(vlSRop_options ?? $i)
  //  //End for 
  //  //SR Get Object Scripts (xReportData;$itemRef;vtSRop_Script;$html1;$html2)
  //  //SR Get Object Format (xReportData;$itemRef;$fontName;$fontSize;$fontStyle;$justification;vtSRop_format;$foreRed;$foreGreen;$foreBlue;$backRed;$backGreen;$backBlue;$forePattern;$backPattern;$lineThickness;$foreColor;$backColor)
  //  //
  //  //If (Not(IT_AltKeyIsDown ))
  //  //RObj_VariablesDialog 
  //  //If (OK=1)
  //  //
  //  //  //$objType:=[XShell_ReportObjLib_Objects]SR_ObjectType
  //  //  //$varType:=[XShell_ReportObjLib_Objects]SR_VariableType
  //  //$varType:=viSRop_VariableType
  //  //Case of 
  //  //: (viSRop_VariableType=SR Variable Type Variable)
  //  //$objType:=SR Object Type Variable
  //  //
  //  //: (viSRop_VariableType=SR Variable Type Array Auto)
  //  //$objType:=SR Object Type Variable
  //  //
  //  //: (viSRop_VariableType=SR Variable Type Array Element)
  //  //$objType:=SR Object Type Variable
  //  //End case 
  //  //
  //  //
  //  //For ($i;0;Size of array(aySRop_OptionsVariables)-1)
  //  //If (aySRop_OptionsVariables{$i+1}->=1)
  //  //vlSRop_options:=vlSRop_options ?+ $i
  //  //Else 
  //  //vlSRop_options:=vlSRop_options ?- $i
  //  //End if 
  //  //End for 
  //  //
  //  //Case of 
  //  //
  //  //: (r3SRop_CalcMean=1)
  //  //viSRop_CalcType:=SR Calculation Type Average
  //  //cbSRop_PrintCalcValue:=1
  //  //
  //  //: (r5SRop_CalcTotal=1)
  //  //viSRop_CalcType:=SR Calculation Type Total
  //  //cbSRop_PrintCalcValue:=1
  //  //
  //  //: (r2SRop_CalcMin=1)
  //  //viSRop_CalcType:=SR Calculation Type Min
  //  //cbSRop_PrintCalcValue:=1
  //  //
  //  //: (r4SRop_CalcMax=1)
  //  //viSRop_CalcType:=SR Calculation Type Max
  //  //cbSRop_PrintCalcValue:=1
  //  //
  //  //Else 
  //  //viSRop_CalcType:=0
  //  //cbSRop_PrintCalcValue:=1
  //  //
  //  //End case 
  //  //
  //  //  //vtSRop_VariableName:=[XShell_ReportObjLib_Objects]ObjectName
  //  //
  //  //$err:=SR Set Object Properties (xReportData;$itemRef;SR Property Name;vtSRop_VariableName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;vlSRop_options;$order;$selected;$tableNo;$fieldNo;viSRop_VariableType;viSRop_ArrayIndex;viSRop_CalcType;vtSRop_CalcValueVariable;$rows;$cols;viSRop_HorOffset;viSRop_VerOffset)
  //  //$err:=SR Set Object Properties (xReportData;$itemRef;SR Property Options;vtSRop_VariableName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;vlSRop_options;$order;$selected;$tableNo;$fieldNo;viSRop_VariableType;viSRop_ArrayIndex;viSRop_CalcType;vtSRop_CalcValueVariable;$rows;$cols;viSRop_HorOffset;viSRop_VerOffset)
  //  //$err:=SR Set Object Properties (xReportData;$itemRef;SR Property Type;vtSRop_VariableName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;vlSRop_options;$order;$selected;$tableNo;$fieldNo;viSRop_VariableType;viSRop_ArrayIndex;viSRop_CalcType;vtSRop_CalcValueVariable;$rows;$cols;viSRop_HorOffset;viSRop_VerOffset)
  //  //$err:=SR Set Object Properties (xReportData;$itemRef;SR Property Variable Type;vtSRop_VariableName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;vlSRop_options;$order;$selected;$tableNo;$fieldNo;viSRop_VariableType;viSRop_ArrayIndex;viSRop_CalcType;vtSRop_CalcValueVariable;$rows;$cols;viSRop_HorOffset;viSRop_VerOffset)
  //  //$err:=SR Set Object Properties (xReportData;$itemRef;SR Property Calculation;vtSRop_VariableName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;vlSRop_options;$order;$selected;$tableNo;$fieldNo;viSRop_VariableType;viSRop_ArrayIndex;viSRop_CalcType;vtSRop_CalcValueVariable;$rows;$cols;viSRop_HorOffset;viSRop_VerOffset)
  //  //$err:=SR Set Object Properties (xReportData;$itemRef;SR Property Repeat Offsets;vtSRop_VariableName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;vlSRop_options;$order;$selected;$tableNo;$fieldNo;viSRop_VariableType;viSRop_ArrayIndex;viSRop_CalcType;vtSRop_CalcValueVariable;$rows;$cols;viSRop_HorOffset;viSRop_VerOffset)
  //  //
  //  //$err:=SR Set Object Format (xReportData;$itemRef;SR Attribute Format;$fontName;$fontSize;$fontStyle;$justification;vtSRop_format;$foreRed;$foreGreen;$foreBlue;$backRed;$backGreen;$backBlue;$forePattern;$backPattern;$lineThickness;$foreColor;$backColor)
  //  //SR Set Object Scripts (xReportData;$itemRef;vtSRop_Script;$html1;$html2)
  //  //
  //  //  //SR Get Object Properties (xReportData;$itemRef;vtSRop_VariableName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;vlSRop_options;$order;$selected;$tableNo;$fieldNo;$varType;viSRop_ArrayIndex;viSRop_CalcType;vtSRop_CalcValueVariable;$rows;$cols;viSRop_HorOffset;viSRop_VerOffset)
  //  //End if 
  //  //$0:=0
  //  //End if 
  //  //
  //  //: ($action=SR Editor Modify Section)
  //  //$sectionRef:=$3
  //  //RObj_SectionProperties ($sectionRef)
  //  //$0:=0
  //
  //End case 



$0:=1


