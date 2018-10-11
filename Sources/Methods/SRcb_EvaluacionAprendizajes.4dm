//%attributes = {}
  //SRcb_EvaluacionAprendizajes

C_BOOLEAN:C305($setScripts;$showOptions)
C_LONGINT:C283($1;$2;$3;$4;$0)
C_LONGINT:C283($vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo)
C_TEXT:C284($vs_BreakVarName)
ARRAY LONGINT:C221($objectIDs;0)

$area:=$1

  //inicializo las variables correspondientes a los argumentos $2;$3;$4 si el llamadfo a este método no fue efectuado por un callback de SuperReport
$action:=-1
$itemRef:=-1
$objectType:=-1

If (Count parameters:C259=4)  //si se ejecuta llamado por SRcust_EditorCallBack recibe automáticamente estos parámetros. Eventualmente pueden ser pasados manualmente en otros llamados
	$action:=$2
	$itemRef:=$3
	$objectType:=$4
End if 
$0:=1

$startScriptDef:="SRal_EvaluacionAprendizajes(\"Inicio\";1;1)"
$bodyScriptDef:="SRal_EvaluacionAprendizajes(\"Cuerpo\")"
$endScriptDef:="SRal_EvaluacionAprendizajes(\"Fin\")"
Case of 
	: ($action=-1)  //Guardar, Guardar como, Preview, Print
		$err:=SR Get Scripts (SRArea;$startScript;$bodyScript;$endScript)
		If (Position:C15("SRal_EvaluacionAprendizajes(\"Inicio\"";$startScript)=0)
			$startScript:=$startScriptDef+"\r"+$startScript
		End if 
		If (Position:C15("SRal_EvaluacionAprendizajes(\"Cuerpo\"";$bodyScript)=0)
			$bodyScript:=$bodyScriptDef+"\r"+$bodyScript
		End if 
		If (Position:C15("SRal_EvaluacionAprendizajes(\"Fin\"";$endScript)=0)
			$endScript:=$endScriptDef+"\r"+$endScript
		End if 
		$err:=SR Set Scripts (SRArea;$startScript;$bodyScript;$endScript)
		
	: ($action=SR Editor Modify Report Script)
		$err:=SR Get Scripts (SRArea;$startScript;$bodyScript;$endScript)
		If (Position:C15("SRal_EvaluacionAprendizajes(\"Inicio\"";$startScript)=0)
			$startScript:=$startScriptDef+"\r"+$startScript
		End if 
		If (Position:C15("SRal_EvaluacionAprendizajes(\"Cuerpo\"";$bodyScript)=0)
			$bodyScript:=$bodyScriptDef+"\r"+$bodyScript
		End if 
		If (Position:C15("SRal_EvaluacionAprendizajes(\"Fin\"";$endScript)=0)
			$endScript:=$endScriptDef+"\r"+$endScript
		End if 
		$err:=SR Set Scripts (SRArea;$startScript;$bodyScript;$endScript)
End case 