//%attributes = {}
  // Método: XS_ReportObjectsManager_OM


  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 27/07/10, 12:03:40
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal


  // Código principal
C_TEXT:C284($method;$1;$parameters;$3)
C_POINTER:C301($objectPointer;$2;$noTable)
C_LONGINT:C283($tableNum;$fieldNum)
_O_C_STRING:C293(255;$varName)


Case of 
	: (Count parameters:C259=1)
		$method:=$1
	: (Count parameters:C259=2)
		$method:=$1
		$ObjectPointer:=$2
	: (Count parameters:C259=3)
		$method:=$1
		$ObjectPointer:=$2
		$parameters:=$3
End case 

If (Not:C34(Is nil pointer:C315($objectPointer)))
	RESOLVE POINTER:C394($objectPointer;$varName;$tableNum;$fieldNum)
	If ($tableNum>0) & ($fieldNum>0)
		$fieldName:="["+Table name:C256($tableNum)+"]"+Field name:C257($tableNum;$fieldNum)
	End if 
End if 


C_LONGINT:C283(hl_ReportObjClasses;hl_Objects)

Case of 
	: ($method="")
		
		
	: ($method="FormMethod")
		Case of 
			: (Form event:C388=On Load:K2:1)
				r1:=1
				r2:=0
				vt_Code:=""
				ALL RECORDS:C47([XShell_ReportObjLib_Clases:274])
				HL_ClearList (hl_ReportObjClasses;hl_Objects)
				hl_ReportObjClasses:=New list:C375
				hl_ReportObjClasses:=HL_Selection2List (->[XShell_ReportObjLib_Clases:274]ClassName:2;->[XShell_ReportObjLib_Clases:274]ID_Class:1)
				hl_Objects:=New list:C375
				vt_ClassName:=""
				vt_Restricciones:=""
				vt_description:=""
				vSintaxCheckResult:=""
				OBJECT SET ENTERABLE:C238(*;"UniqueClassFields@";False:C215)
				_O_DISABLE BUTTON:C193(r1_Modulo)
				_O_DISABLE BUTTON:C193(r2_Modulo)
				_O_DISABLE BUTTON:C193(bScripts)
				_O_DISABLE BUTTON:C193(hl_modules1)
				OBJECT SET VISIBLE:C603(bSaveNewObject;False:C215)
				OBJECT SET VISIBLE:C603(bSaveNew;False:C215)
				
				
			: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
				
			: (Form event:C388=On Close Box:K2:21)
				CANCEL:C270
			: (Form event:C388=On Unload:K2:2)
				
			: (Form event:C388=On Outside Call:K2:11)
				
			: (Form event:C388=On Resize:K2:27)
				
		End case 
		
		
		
	: ($method="LoadClasses")
		ARRAY LONGINT:C221($aSelectedItems;0)
		$selectedItem:=Selected list items:C379(hl_ReportObjClasses;$aSelectedItems;*)
		
		If (Size of array:C274($aSelectedItems)=1)
			GET LIST ITEM:C378(hl_ReportObjClasses;*;$classId;$className)
			KRL_FindAndLoadRecordByIndex (->[XShell_ReportObjLib_Clases:274]ID_Class:1;->$classId;True:C214)
			If ([XShell_ReportObjLib_Clases:274]Module:4=0)
				_O_DISABLE BUTTON:C193(*;"hl_modules1")
				r1_modulo:=1
				r2_Modulo:=0
			Else 
				SELECT LIST ITEMS BY REFERENCE:C630(hl_modules1;[XShell_ReportObjLib_Clases:274]Module:4)
				_O_ENABLE BUTTON:C192(*;"hl_modules1")
				r1_modulo:=0
				r2_Modulo:=1
			End if 
			vt_ClassName:=[XShell_ReportObjLib_Clases:274]ClassName:2
			vt_Restricciones:=[XShell_ReportObjLib_Clases:274]CondicionesRestrictivas:5
			vt_description:=[XShell_ReportObjLib_Clases:274]Description:3
			
			
			If (vt_Restricciones#"")
				error:=0
				$currentOnErrCall:=Method called on error:C704
				ON ERR CALL:C155("ERR_GenericOnError")
				EXECUTE FORMULA:C63("vb_testVariable:="+vt_Restricciones)
				ON ERR CALL:C155($currentOnErrCall)
				If (error=0)
					If (vb_testVariable)
						vSintaxCheckResult:="Verificación de sintáxis exitosa. Resultado: TRUE"
					Else 
						vSintaxCheckResult:="Verificación de sintáxis exitosa. Resultado: FALSE"
					End if 
					OBJECT SET COLOR:C271(vSintaxCheckResult;-9)
				Else 
					vSintaxCheckResult:="Verificación de sintáxis fallida"
					OBJECT SET COLOR:C271(vSintaxCheckResult;-3)
				End if 
			Else 
				vSintaxCheckResult:=""
			End if 
			
		Else 
			
			GET LIST ITEM:C378(hl_ReportObjClasses;*;$classId;$className)
			KRL_FindAndLoadRecordByIndex (->[XShell_ReportObjLib_Clases:274]ID_Class:1;->$classId;True:C214)
			vt_ClassName:=""
			vt_Restricciones:=""
			vt_description:=""
			HL_ClearList (hl_ExplorerPanes)
			OBJECT SET ENTERABLE:C238(vt_className;False:C215)
			SELECT LIST ITEMS BY POSITION:C381(hl_modules1;0)
			SELECT LIST ITEMS BY POSITION:C381(hl_ExplorerPanes;0)
		End if 
		
		
		
		ARRAY LONGINT:C221($aSelectedItems;0)
		$selectedItem:=Selected list items:C379(hl_ReportObjClasses;$aSelectedItems;*)
		
		If (Size of array:C274($aSelectedItems)=1)
			XS_ReportObjectsManager_OM ("LoadSelectedClass")
			OBJECT SET ENTERABLE:C238(*;"UniqueClassFields@";True:C214)
		Else 
			GET LIST ITEM:C378(hl_ReportObjClasses;*;$classId;$className)
			KRL_FindAndLoadRecordByIndex (->[XShell_ReportObjLib_Clases:274]ID_Class:1;->$classId;True:C214)
			vt_ClassName:=""
			vt_Restricciones:=""
			vt_description:=""
			OBJECT SET ENTERABLE:C238(*;"UniqueClassFields@";False:C215)
			
			HL_ClearList (hl_ExplorerPanes)
			OBJECT SET ENTERABLE:C238(vt_className;False:C215)
			SELECT LIST ITEMS BY POSITION:C381(hl_modules1;0)
			SELECT LIST ITEMS BY POSITION:C381(hl_ExplorerPanes;0)
		End if 
		
		
		
		
	: ($method="LoadSelectedClass")
		
		_O_DISABLE BUTTON:C193(r1_Modulo)
		_O_DISABLE BUTTON:C193(r2_Modulo)
		_O_DISABLE BUTTON:C193(bScripts)
		_O_DISABLE BUTTON:C193(hl_modules1)
		
		ARRAY LONGINT:C221($aSelectedItems;0)
		$selectedItem:=Selected list items:C379(hl_ReportObjClasses;$aSelectedItems;*)
		
		Case of 
			: (Size of array:C274($aSelectedItems)=1)
				OBJECT SET ENTERABLE:C238(*;"UniqueClassFields@";True:C214)
				GET LIST ITEM:C378(hl_ReportObjClasses;*;$classId;$className)
				KRL_FindAndLoadRecordByIndex (->[XShell_ReportObjLib_Clases:274]ID_Class:1;->$classId;True:C214)
				If ([XShell_ReportObjLib_Clases:274]Module:4=0)
					_O_DISABLE BUTTON:C193(*;"hl_modules1")
					r1_modulo:=1
					r2_Modulo:=0
				Else 
					SELECT LIST ITEMS BY REFERENCE:C630(hl_modules1;[XShell_ReportObjLib_Clases:274]Module:4)
					_O_ENABLE BUTTON:C192(*;"hl_modules1")
					r1_modulo:=0
					r2_Modulo:=1
				End if 
				vt_ClassName:=[XShell_ReportObjLib_Clases:274]ClassName:2
				vt_Restricciones:=[XShell_ReportObjLib_Clases:274]CondicionesRestrictivas:5
				vt_description:=[XShell_ReportObjLib_Clases:274]Description:3
				
				
				If (vt_Restricciones#"")
					error:=0
					$currentOnErrCall:=Method called on error:C704
					ON ERR CALL:C155("ERR_GenericOnError")
					EXECUTE FORMULA:C63("vb_testVariable:="+vt_Restricciones)
					ON ERR CALL:C155($currentOnErrCall)
					If (error=0)
						If (vb_testVariable)
							vSintaxCheckResult:="Verificación de sintáxis exitosa. Resultado: TRUE"
						Else 
							vSintaxCheckResult:="Verificación de sintáxis exitosa. Resultado: FALSE"
						End if 
						OBJECT SET COLOR:C271(vSintaxCheckResult;-9)
					Else 
						vSintaxCheckResult:="Verificación de sintáxis fallida"
						OBJECT SET COLOR:C271(vSintaxCheckResult;-3)
					End if 
				Else 
					vSintaxCheckResult:=""
				End if 
				XS_ReportObjectsManager_OM ("ModulePanels")
				XS_ReportObjectsManager_OM ("LoadObjects")
				FORM GOTO PAGE:C247(1)
				_O_ENABLE BUTTON:C192(r1_Modulo)
				_O_ENABLE BUTTON:C192(r2_Modulo)
				_O_ENABLE BUTTON:C192(bScripts)
				_O_ENABLE BUTTON:C192(hl_modules1)
				OBJECT SET ENTERABLE:C238(*;"UniqueClassFields@";True:C214)
				
			: (Size of array:C274($aSelectedItems)>1)
				vt_ClassName:=""
				vt_Restricciones:=""
				vt_description:=""
				OBJECT SET ENTERABLE:C238(*;"UniqueClassFields@";False:C215)
				_O_DISABLE BUTTON:C193(bScripts)
				
				
				HL_ClearList (hl_ExplorerPanes)
				SELECT LIST ITEMS BY POSITION:C381(hl_modules1;0)
				SELECT LIST ITEMS BY POSITION:C381(hl_ExplorerPanes;0)
				
				_O_ENABLE BUTTON:C192(r1_Modulo)
				_O_ENABLE BUTTON:C192(r2_Modulo)
				_O_ENABLE BUTTON:C192(bScripts)
				_O_ENABLE BUTTON:C192(hl_modules1)
				FORM GOTO PAGE:C247(1)
				
			: (Size of array:C274($aSelectedItems)=0)
				_O_DISABLE BUTTON:C193(r1_Modulo)
				_O_DISABLE BUTTON:C193(r2_Modulo)
				_O_DISABLE BUTTON:C193(bScripts)
				_O_DISABLE BUTTON:C193(hl_modules1)
				OBJECT SET ENTERABLE:C238(*;"UniqueClassFields@";False:C215)
				FORM GOTO PAGE:C247(1)
		End case 
		
		
		
		
		
		
		
		
	: ($method="LoadObjects")
		GET LIST ITEM:C378(hl_ReportObjClasses;*;$classId;$className)
		READ ONLY:C145([XShell_ReportObjLib_Objects:275])
		QUERY:C277([XShell_ReportObjLib_Objects:275];[XShell_ReportObjLib_Objects:275]ID_Class:2=$classId)
		HL_ClearList (hl_Objects)
		hl_Objects:=HL_Selection2List (->[XShell_ReportObjLib_Objects:275]UI_Name:6;->[XShell_ReportObjLib_Objects:275]ID_Object:1)
		SORT LIST:C391(hl_Objects;>)
		_O_REDRAW LIST:C382(hl_Objects)
		
		
		
	: ($method="ProcessSRPMethod")
		
		
		C_LONGINT:C283($wordCount;$records;$classID;$objectID;$recNum;hl_ReportObjClasses;hl_Objects)
		C_TEXT:C284($text;$object;$class;$objectName;$varName)
		dhSR_InitVariables 
		SRcust_InitEvaluationVariables 
		ARRAY TEXT:C222($aObjects;0)
		
		EXECUTE FORMULA:C63(vtCode)
		
		AT_CopyArrayElements (->asSRVariables;->$aObjects)
		
		HL_ClearList (hl_ReportObjClasses)
		hl_ReportObjClasses:=New list:C375
		
		
		HL_ClearList (hl_Objects)
		hl_Objects:=New list:C375
		If (r1=1)
			$moduleRef:=0
		Else 
			GET LIST ITEM:C378(hl_modules;*;$moduleRef;$moduleName)
		End if 
		
		For ($i;1;Size of array:C274($aObjects))
			$object:=$aObjects{$i}
			If ($object#"")
				$wordCount:=ST_CountWords ($object;0;";")
				If ($wordCount=2)
					$class:=ST_GetWord ($object;2;";")
					QUERY:C277([XShell_ReportObjLib_Clases:274];[XShell_ReportObjLib_Clases:274]ClassName:2=$class;*)
					QUERY:C277([XShell_ReportObjLib_Clases:274]; & ;[XShell_ReportObjLib_Clases:274]Module:4=$moduleRef)
					If (cb_DeleteClasses=1)
						QUERY:C277([XShell_ReportObjLib_Objects:275];[XShell_ReportObjLib_Objects:275]ID_Class:2;=;[XShell_ReportObjLib_Clases:274]ID_Class:1)
						KRL_DeleteSelection (->[XShell_ReportObjLib_Objects:275])
						KRL_DeleteSelection (->[XShell_ReportObjLib_Clases:274])
						CREATE RECORD:C68([XShell_ReportObjLib_Clases:274])
						[XShell_ReportObjLib_Clases:274]ID_Class:1:=SQ_SeqNumber (->[XShell_ReportObjLib_Clases:274]ID_Class:1)
						[XShell_ReportObjLib_Clases:274]Auto_UUID:6:=Generate UUID:C1066
						[XShell_ReportObjLib_Clases:274]ClassName:2:=Replace string:C233($class;"\"";"")
						[XShell_ReportObjLib_Clases:274]Description:3:=""
						[XShell_ReportObjLib_Clases:274]Module:4:=$moduleRef
						SAVE RECORD:C53([XShell_ReportObjLib_Clases:274])
						APPEND TO LIST:C376(hl_ReportObjClasses;[XShell_ReportObjLib_Clases:274]ClassName:2;[XShell_ReportObjLib_Clases:274]ID_Class:1)
						SET LIST ITEM PROPERTIES:C386(hl_ReportObjClasses;[XShell_ReportObjLib_Clases:274]ID_Class:1;False:C215;2;0)
					Else 
						If (Records in selection:C76([XShell_ReportObjLib_Clases:274])=0)
							CREATE RECORD:C68([XShell_ReportObjLib_Clases:274])
							[XShell_ReportObjLib_Clases:274]ID_Class:1:=SQ_SeqNumber (->[XShell_ReportObjLib_Clases:274]ID_Class:1)
							[XShell_ReportObjLib_Clases:274]Auto_UUID:6:=Generate UUID:C1066
							[XShell_ReportObjLib_Clases:274]ClassName:2:=Replace string:C233($class;"\"";"")
							[XShell_ReportObjLib_Clases:274]Description:3:=""
							[XShell_ReportObjLib_Clases:274]Module:4:=$moduleRef
							SAVE RECORD:C53([XShell_ReportObjLib_Clases:274])
							APPEND TO LIST:C376(hl_ReportObjClasses;[XShell_ReportObjLib_Clases:274]ClassName:2;[XShell_ReportObjLib_Clases:274]ID_Class:1)
							SET LIST ITEM PROPERTIES:C386(hl_ReportObjClasses;[XShell_ReportObjLib_Clases:274]ID_Class:1;False:C215;2;0)
						End if 
					End if 
					$classID:=[XShell_ReportObjLib_Clases:274]ID_Class:1
					$classUUID:=[XShell_ReportObjLib_Clases:274]Auto_UUID:6
				Else 
					$objectName:=ST_GetWord ($object;2;";")
					$varName:=ST_GetWord ($object;3;";")
					SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
					QUERY:C277([XShell_ReportObjLib_Objects:275];[XShell_ReportObjLib_Objects:275]ID_Class:2;=;$classID;*)
					QUERY:C277([XShell_ReportObjLib_Objects:275]; & ;[XShell_ReportObjLib_Objects:275]ObjectName:7;=;$varName)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($records=0)
						CREATE RECORD:C68([XShell_ReportObjLib_Objects:275])
						[XShell_ReportObjLib_Objects:275]ID_Object:1:=SQ_SeqNumber (->[XShell_ReportObjLib_Objects:275]ID_Object:1)
						[XShell_ReportObjLib_Objects:275]Auto_UUID:11:=Generate UUID:C1066
						[XShell_ReportObjLib_Objects:275]UUID_Class:12:=$classUUID
						[XShell_ReportObjLib_Objects:275]ID_Class:2:=$classID
						[XShell_ReportObjLib_Objects:275]FieldNumber:5:=-1
						[XShell_ReportObjLib_Objects:275]TableNumber:4:=-1
						$pointer:=Get pointer:C304($varName)
						If (Not:C34(Is nil pointer:C315($pointer)))
							$type:=Type:C295($pointer->)
							Case of 
								: (($type=Is string var:K8:2) | ($type=Is text:K8:3) | ($type=Is longint:K8:6) | ($type=Is real:K8:4) | ($type=Is integer:K8:5) | ($type=Is date:K8:7) | ($type=Is time:K8:8) | ($type=Is boolean:K8:9) | ($type=Is picture:K8:10))
									$SRobjectType:=SR Object Type Variable
									$SRvariableType:=SR Variable Type Variable
								: (($type=String array:K8:15) | ($type=Text array:K8:16) | ($type=LongInt array:K8:19) | ($type=Real array:K8:17) | ($type=Integer array:K8:18) | ($type=Date array:K8:20) | ($type=Is time:K8:8) | ($type=Boolean array:K8:21) | ($type=Picture array:K8:22))
									$SRobjectType:=SR Object Type Variable
									$SRvariableType:=SR Variable Type Array Auto
							End case 
							[XShell_ReportObjLib_Objects:275]SR_ObjectType:3:=$SRobjectType
							[XShell_ReportObjLib_Objects:275]SR_VariableType:8:=$SRvariableType
							[XShell_ReportObjLib_Objects:275]Type4D:10:=$type
							[XShell_ReportObjLib_Objects:275]UI_Name:6:=$objectName
							[XShell_ReportObjLib_Objects:275]ObjectName:7:=$varName
							SAVE RECORD:C53([XShell_ReportObjLib_Objects:275])
						End if 
					End if 
				End if 
			End if 
		End for 
		_O_REDRAW LIST:C382(hl_ReportObjClasses)
		If (Count list items:C380(hl_ReportObjClasses)>0)
			SORT LIST:C391(hl_ReportObjClasses;>)
			SELECT LIST ITEMS BY POSITION:C381(hl_ReportObjClasses;1)
			GET LIST ITEM:C378(hl_ReportObjClasses;*;$classId;$className)
			QUERY:C277([XShell_ReportObjLib_Objects:275];[XShell_ReportObjLib_Objects:275]ID_Class:2=$classId)
			HL_ClearList (hl_Objects)
			hl_Objects:=HL_Selection2List (->[XShell_ReportObjLib_Objects:275]UI_Name:6;->[XShell_ReportObjLib_Objects:275]ID_Object:1)
			SORT LIST:C391(hl_Objects;>)
			_O_REDRAW LIST:C382(hl_Objects)
		End if 
		
		
		
		
		
	: ($method="ModulePanels")
		If (r2_Modulo=1)
			GET LIST ITEM:C378(hl_modules1;*;$moduleRef;$moduleName)
			$modulePrefRef:=XS_GetBlobName ("browser";$moduleRef;<>vtXS_CountryCode;<>vtXS_langage)
			$blob:=PREF_fGetBlob (0;$modulePrefRef;$blob)
			If (BLOB size:C605($blob)>0)
				HL_ClearList (hl_ExplorerPanes)
				hl_ExplorerPanes:=BLOB to list:C557($blob)
				SET LIST PROPERTIES:C387(hl_ExplorerPanes;_o_Ala Macintosh:K28:1;_o_Macintosh node:K28:5;16;0;1;0)
				ARRAY LONGINT:C221($aTableNums;0)
				
				
				ARRAY LONGINT:C221($aSelectedItems;0)
				$selectedItem:=Selected list items:C379(hl_ReportObjClasses;$aSelectedItems;*)
				
				If (Size of array:C274($aSelectedItems)=1)
					QUERY:C277([XShell_ReportObjLib_TableRefs:276];[XShell_ReportObjLib_TableRefs:276]ID_Class:1;=;[XShell_ReportObjLib_Clases:274]ID_Class:1)
					If (Records in selection:C76([XShell_ReportObjLib_TableRefs:276])>0)
						SELECTION TO ARRAY:C260([XShell_ReportObjLib_TableRefs:276]ID_Table:2;$aTableNums)
						SELECT LIST ITEMS BY REFERENCE:C630(hl_ExplorerPanes;0;$aTableNums)
						_O_REDRAW LIST:C382(hl_ExplorerPanes)
					End if 
				Else 
					SELECT LIST ITEMS BY POSITION:C381(hl_ExplorerPanes;0)
				End if 
			Else 
				HL_ClearList (hl_ExplorerPanes)
			End if 
		Else 
			HL_ClearList (hl_ExplorerPanes)
		End if 
		GOTO OBJECT:C206(hl_ExplorerPanes)
		OBJECT SET ENABLED:C1123(hl_Modules1;r2_Modulo=1)
		
		
	: ($method="SetObjectTableRefs")
		XS_ReportObjectsManager_OM ("SaveClass")
		
		
		
		
	: ($method="TestSintaxRestrictions")
		C_BOOLEAN:C305(vb_testVariable)
		If (vt_Restricciones#"")
			error:=0
			$currentOnErrCall:=Method called on error:C704
			ON ERR CALL:C155("ERR_GenericOnError")
			EXECUTE FORMULA:C63("vb_testVariable:="+vt_Restricciones)
			ON ERR CALL:C155($currentOnErrCall)
			If (error=0)
				If (vb_testVariable)
					vSintaxCheckResult:="Verificación de sintáxis exitosa. Resultado: TRUE"
				Else 
					vSintaxCheckResult:="Verificación de sintáxis exitosa. Resultado: FALSE"
				End if 
				OBJECT SET COLOR:C271(vSintaxCheckResult;-9)
			Else 
				vSintaxCheckResult:="Verificación de sintáxis fallida"
				OBJECT SET COLOR:C271(vSintaxCheckResult;-3)
			End if 
		Else 
			vSintaxCheckResult:=""
		End if 
		XS_ReportObjectsManager_OM ("SaveClass")
		
		
		
		
	: ($method="SaveClass")
		ARRAY LONGINT:C221($aItems;0)
		$item:=Selected list items:C379(hl_ExplorerPanes;$aItems)
		ARRAY LONGINT:C221($aSelectedClassesIds;0)
		$selectedItem:=Selected list items:C379(hl_ReportObjClasses;$aSelectedClassesIds;*)
		
		Case of 
			: (Size of array:C274($aSelectedClassesIds)>1)
				For ($iClasses;1;Size of array:C274($aSelectedClassesIds))
					$classID:=$aSelectedClassesIds{$iClasses}
					KRL_FindAndLoadRecordByIndex (->[XShell_ReportObjLib_Clases:274]ID_Class:1;->$classID;True:C214)
					If (r1_modulo=1)
						[XShell_ReportObjLib_Clases:274]Module:4:=0
					Else 
						GET LIST ITEM:C378(hl_modules1;*;$moduleRef;$moduleName)
						[XShell_ReportObjLib_Clases:274]Module:4:=$moduleRef
					End if 
					SAVE RECORD:C53([XShell_ReportObjLib_Clases:274])
					QUERY:C277([XShell_ReportObjLib_TableRefs:276];[XShell_ReportObjLib_TableRefs:276]ID_Class:1;=;$classID)
					KRL_DeleteSelection (->[XShell_ReportObjLib_TableRefs:276])
					For ($i;1;Size of array:C274($aItems))
						GET LIST ITEM:C378(hl_ExplorerPanes;$aItems{$i};$tableNum;$tableName)
						CREATE RECORD:C68([XShell_ReportObjLib_TableRefs:276])
						[XShell_ReportObjLib_TableRefs:276]ID_Class:1:=$classID
						[XShell_ReportObjLib_TableRefs:276]ID_Table:2:=$tableNum
						SAVE RECORD:C53([XShell_ReportObjLib_TableRefs:276])
					End for 
				End for 
				
			: (Size of array:C274($aSelectedClassesIds)=1)
				$classID:=$aSelectedClassesIds{1}
				KRL_FindAndLoadRecordByIndex (->[XShell_ReportObjLib_Clases:274]ID_Class:1;->$classID;True:C214)
				[XShell_ReportObjLib_Clases:274]CondicionesRestrictivas:5:=vt_Restricciones
				[XShell_ReportObjLib_Clases:274]Description:3:=vt_description
				If (r1_modulo=1)
					[XShell_ReportObjLib_Clases:274]Module:4:=0
				Else 
					GET LIST ITEM:C378(hl_modules1;*;$moduleRef;$moduleName)
					[XShell_ReportObjLib_Clases:274]Module:4:=$moduleRef
				End if 
				SAVE RECORD:C53([XShell_ReportObjLib_Clases:274])
				QUERY:C277([XShell_ReportObjLib_TableRefs:276];[XShell_ReportObjLib_TableRefs:276]ID_Class:1;=;$classID)
				KRL_DeleteSelection (->[XShell_ReportObjLib_TableRefs:276])
				For ($i;1;Size of array:C274($aItems))
					GET LIST ITEM:C378(hl_ExplorerPanes;$aItems{$i};$tableNum;$tableName)
					CREATE RECORD:C68([XShell_ReportObjLib_TableRefs:276])
					[XShell_ReportObjLib_TableRefs:276]ID_Class:1:=$classID
					[XShell_ReportObjLib_TableRefs:276]ID_Table:2:=$tableNum
					SAVE RECORD:C53([XShell_ReportObjLib_TableRefs:276])
				End for 
		End case 
		
		
		
	: ($method="EditObject")
		GET LIST ITEM:C378(hl_Objects;*;$objectID;$objectAlias)
		KRL_FindAndLoadRecordByIndex (->[XShell_ReportObjLib_Objects:275]ID_Object:1;->$objectID;True:C214)
		If (OK=1)
			vt_ObjectDescription:=[XShell_ReportObjLib_Objects:275]Description:9
			vt_ObjectAlias:=[XShell_ReportObjLib_Objects:275]UI_Name:6
			vt_ObjectName:=[XShell_ReportObjLib_Objects:275]ObjectName:7
			vt_objectScript:=[XShell_ReportObjLib_Objects:275]Script_Objeto:13
			FORM GOTO PAGE:C247(2)
			
		Else 
			CD_Dlog (0;__ ("No es posible editar el script del objeto. Por favor intenta más tarde."))
		End if 
		
		
	: ($method="CheckObjectNames")
		
		
		
		
	: ($method="SaveObject")
		
		
		
	: ($method="ShowClassScriptEditor")
		GET LIST ITEM:C378(hl_ReportObjClasses;*;$classId;$className)
		KRL_FindAndLoadRecordByIndex (->[XShell_ReportObjLib_Clases:274]ID_Class:1;->$classId;True:C214)
		If (OK=1)
			START TRANSACTION:C239
			$wRef:=WDW_OpenFormWindow (->[XShell_ReportObjLib_Clases:274];"ScriptEditor";8;-1;__ ("Scripts para ")+$className)
			DIALOG:C40([XShell_ReportObjLib_Clases:274];"ScriptEditor")
			CLOSE WINDOW:C154
			If (OK=1)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
		Else 
			CD_Dlog (0;__ ("No es posible editar los script del objeto. Por favor intenta más tarde."))
		End if 
End case 

