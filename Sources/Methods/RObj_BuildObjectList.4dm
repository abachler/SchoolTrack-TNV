//%attributes = {"executedOnServer":true}
  // Método: RObj_BuildObjectList
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/10/10, 13:16:32
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283($hl_StandardLibrary;$1;$tableNum)
C_BLOB:C604($xBlob)
$tableNum:=$1

  // Código principal

$hl_StandardLibrary:=New list:C375
HL_ClearList ($hl_StandardLibrary)

ARRAY LONGINT:C221($atSRPop_ObjectIDs;0)
ARRAY TEXT:C222($atSRPop_ObjectNames;0)
ARRAY LONGINT:C221($atSRPop_ClassIds;0)

QUERY:C277([XShell_ReportObjLib_TableRefs:276];[XShell_ReportObjLib_TableRefs:276]ID_Table:2;=;$tableNum)
KRL_RelateSelection (->[XShell_ReportObjLib_Clases:274]ID_Class:1;->[XShell_ReportObjLib_TableRefs:276]ID_Class:1;"")

CREATE SET:C116([XShell_ReportObjLib_Clases:274];"Especificos")
QUERY:C277([XShell_ReportObjLib_Clases:274];[XShell_ReportObjLib_Clases:274]Module:4=0)
CREATE SET:C116([XShell_ReportObjLib_Clases:274];"Comunes")
UNION:C120("Especificos";"Comunes";"Clases")
USE SET:C118("Clases")
ORDER BY:C49([XShell_ReportObjLib_Clases:274];[XShell_ReportObjLib_Clases:274]Module:4;>;[XShell_ReportObjLib_Clases:274]ClassName:2;>)
SET_ClearSets ("Especificos";"Comunes";"Clases")

KRL_RelateSelection (->[XShell_ReportObjLib_Objects:275]ID_Class:2;->[XShell_ReportObjLib_Clases:274]ID_Class:1;"")
SELECTION TO ARRAY:C260([XShell_ReportObjLib_Objects:275]ObjectName:7;$atSRPop_ObjectNames;[XShell_ReportObjLib_Objects:275]ID_Object:1;$atSRPop_ObjectIDs;[XShell_ReportObjLib_Objects:275]ID_Class:2;$atSRPop_ClassIds)
  //For ($i;1;Size of array(atSRPop_ObjectNames))
  //atSRPop_ObjectNames{$i}:=Replace string(atSRPop_ObjectNames{$i};"◊";"<>")
  //End for 

$hl_StandardLibrary:=HL_Selection2List (->[XShell_ReportObjLib_Clases:274]ClassName:2;->[XShell_ReportObjLib_Clases:274]ID_Class:1)


For ($i;1;Count list items:C380($hl_StandardLibrary))
	GET LIST ITEM:C378($hl_StandardLibrary;$i;$classID;$className)
	QUERY:C277([XShell_ReportObjLib_Objects:275];[XShell_ReportObjLib_Objects:275]ID_Class:2=$classID)
	ORDER BY:C49([XShell_ReportObjLib_Objects:275];[XShell_ReportObjLib_Objects:275]ObjectName:7;>)
	$hl_ClassObjects:=HL_Selection2List (->[XShell_ReportObjLib_Objects:275]UI_Name:6;->[XShell_ReportObjLib_Objects:275]ID_Object:1)
	SET LIST ITEM:C385($hl_StandardLibrary;$classID;$className;-$classID;$hl_ClassObjects;False:C215)
	SET LIST ITEM PROPERTIES:C386($hl_StandardLibrary;-$classID;False:C215;1;0)
End for 

LIST TO BLOB:C556($hl_StandardLibrary;$xBlob)
$otRef:=OT New 
OT PutBLOB ($otRef;"StandardLibrary";$xBlob)
OT PutArray ($otRef;"atSRPop_ObjectNames";$atSRPop_ObjectNames)
OT PutArray ($otRef;"atSRPop_ObjectIDs";$atSRPop_ObjectIDs)
OT PutArray ($otRef;"atSRPop_ClassIds";$atSRPop_ClassIds)
$xBlob:=OT ObjectToNewBLOB ($otRef)
OT Clear ($otRef)  //2015/08/13
$0:=$xBlob

CLEAR LIST:C377($hl_StandardLibrary)
