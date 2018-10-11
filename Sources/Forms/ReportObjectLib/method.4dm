  // Método: Método de Formulario: ReportObjectLib
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 15/02/10, 19:35:41
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

Case of 
	: (Form event:C388=On Load:K2:1)
		hlSRop_VarTypes:=LOC_LoadList ("VarTypes SuperReport")
		
		If (viSRop_VariableType=0)
			viSRop_VariableType:=1
		End if 
		For ($i;0;Size of array:C274(aySRop_OptionsVariables)-1)
			aySRop_OptionsVariables{$i+1}->:=Num:C11(vlSRop_options ?? $i)
		End for 
		
		Case of 
			: (viSRop_CalcType=SR Calculation Type None)
				cbSRop_PrintCalcValue:=0
				r3SRop_CalcMean:=0
				r5SRop_CalcTotal:=0
				r2SRop_CalcMin:=0
				r4SRop_CalcMax:=0
				
			: (viSRop_CalcType=SR Calculation Type Average)
				cbSRop_PrintCalcValue:=1
				r3SRop_CalcMean:=1
				r5SRop_CalcTotal:=0
				r2SRop_CalcMin:=0
				r4SRop_CalcMax:=0
				
				
			: (viSRop_CalcType=SR Calculation Type Max)
				cbSRop_PrintCalcValue:=1
				r3SRop_CalcMean:=0
				r5SRop_CalcTotal:=0
				r2SRop_CalcMin:=0
				r4SRop_CalcMax:=1
				
			: (viSRop_CalcType=SR Calculation Type Min)
				cbSRop_PrintCalcValue:=1
				r3SRop_CalcMean:=0
				r5SRop_CalcTotal:=0
				r2SRop_CalcMin:=1
				r4SRop_CalcMax:=0
				
			: (viSRop_CalcType=SR Calculation Type Total)
				cbSRop_PrintCalcValue:=1
				r3SRop_CalcMean:=0
				r5SRop_CalcTotal:=1
				r2SRop_CalcMin:=0
				r4SRop_CalcMax:=0
				
		End case 
		
		SELECT LIST ITEMS BY REFERENCE:C630(hlSRop_VarTypes;viSRop_VariableType)
		OBJECT SET VISIBLE:C603(*;"elementoArreglo@";(viSRop_VariableType=SR Variable Type Array Element))
		vtSRPop_VariableAlias:=""
		
		If (vtSRop_VariableName#"")
			$pos:=Find in array:C230(atSRPop_ObjectNames;Replace string:C233(vtSRop_VariableName;"◊";"<>"))
			If ($pos>0)
				$objectID:=atSRPop_ObjectIDs{$pos}
				SELECT LIST ITEMS BY REFERENCE:C630(hl_ReportObjLib;-atSRPop_ClassIds{$pos})
				GET LIST ITEM:C378(hl_ReportObjLib;*;$classId;$className;$subList)
				SET LIST ITEM:C385(hl_ReportObjLib;$classId;$className;$classId;$subList;True:C214)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_ReportObjLib;$objectID)
				$absClassID:=Abs:C99($classId)
				vtSRPop_VariableAlias:=KRL_GetTextFieldData (->[XShell_ReportObjLib_Clases:274]ID_Class:1;->$absClassID;->[XShell_ReportObjLib_Clases:274]ClassName:2)+"."+KRL_GetTextFieldData (->[XShell_ReportObjLib_Objects:275]ID_Object:1;->$objectID;->[XShell_ReportObjLib_Objects:275]UI_Name:6)
			End if 
		End if 
		
		
		Case of 
			: (viSRop_VariableType=SR Variable Type Variable)
				OBJECT SET VISIBLE:C603(*;"elementoArreglo@";False:C215)
				OBJECT SET ENTERABLE:C238(*;"repeating@";False:C215)
				_O_DISABLE BUTTON:C193(*;"repeating@")
				
			: (viSRop_VariableType=SR Variable Type Array Element)
				OBJECT SET VISIBLE:C603(*;"elementoArreglo@";True:C214)
				OBJECT SET ENTERABLE:C238(*;"repeating@";False:C215)
				_O_DISABLE BUTTON:C193(*;"repeating@")
				
			: (viSRop_VariableType=SR Variable Type Array Auto)
				
				OBJECT SET VISIBLE:C603(*;"elementoArreglo@";False:C215)
				OBJECT SET ENTERABLE:C238(*;"repeating@";True:C214)
				_O_ENABLE BUTTON:C192(*;"repeating@")
		End case 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		
		
		
	: (Form event:C388=On Drop:K2:12)
		
		C_LONGINT:C283($srcElement;$srcProcess;$tableNum;$fielNum)
		C_TEXT:C284($varName;$itemText)
		C_POINTER:C301($srcObject)
		DRAG AND DROP PROPERTIES:C607($srcObject;$srcElement;$srcProcess)
		RESOLVE POINTER:C394($srcObject;$varName;$tableNum;$fielNum)
		
		
		If ($varName="hl_ReportObjLib")
			GET LIST ITEM:C378($srcObject->;$srcElement;$objectID;$objectName)
			KRL_FindAndLoadRecordByIndex (->[XShell_ReportObjLib_Objects:275]ID_Object:1;->$objectID)
			vtSRop_VariableName:=[XShell_ReportObjLib_Objects:275]ObjectName:7
			Case of 
				: ([XShell_ReportObjLib_Objects:275]SR_ObjectType:3=SR Object Type Variable)
					$objType:=SR Object Type Variable
					viSRop_VariableType:=[XShell_ReportObjLib_Objects:275]SR_VariableType:8
					Case of 
						: (viSRPop_VariableType=SR Variable Type Variable)
							vtSRop_VariableType:="Variable"
						: (viSRPop_VariableType=SR Variable Type Array Auto)
							vtSRop_VariableType:="Arreglo"
						: (viSRPop_VariableType=SR Variable Type Array Element)
							vtSRop_VariableType:="Elemento de arreglo"
					End case 
			End case 
			OBJECT SET VISIBLE:C603(*;"elementoArreglo@";(viSRop_VariableType=SR Variable Type Array Element))
			SELECT LIST ITEMS BY REFERENCE:C630(hlSRop_VarTypes;viSRop_VariableType)
			vtSRPop_VariableAlias:=KRL_GetTextFieldData (->[XShell_ReportObjLib_Clases:274]ID_Class:1;->[XShell_ReportObjLib_Objects:275]ID_Class:2;->[XShell_ReportObjLib_Clases:274]ClassName:2)+"."+[XShell_ReportObjLib_Objects:275]UI_Name:6
		End if 
		
		
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hl_ReportObjLib)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 
OBJECT SET RGB COLORS:C628(*;"objectname";0;0)
