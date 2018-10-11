//%attributes = {}
  // Método: STWA2_OWC_getqueries
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:50:22
  // ----------------------------------------------------
  // Modificado por: Alberto Bachler Klein: 21-11-15, 12:58:47
  // Uso de Objeto 4D para generar json en reemplazo de plugin OAuth o componente JSON
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($i;$l_finBloqueStandard;$userID)
C_POINTER:C301($y_ParameterNames;$y_ParameterValues;$y_tabla)
C_TEXT:C284($t_json;$t_llave;$t_uuid;$t_tipo)

ARRAY TEXT:C222($at_consultas;0)
ARRAY TEXT:C222($at_ListaConsultas;0)

If (False:C215)
	C_TEXT:C284(STWA2_OWC_getqueries ;$0)
	C_TEXT:C284(STWA2_OWC_getqueries ;$1)
	C_POINTER:C301(STWA2_OWC_getqueries ;$2)
	C_POINTER:C301(STWA2_OWC_getqueries ;$3)
End if 

$t_uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$t_tipo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tipo")
$userID:=STWA2_Session_GetUserSTID ($t_uuid)
Case of 
	: ($t_tipo="asignaturas")
		$y_tabla:=->[Asignaturas:18]
End case 
If (Not:C34(Is nil pointer:C315($y_tabla)))
	$t_llave:=String:C10(Table:C252($y_tabla);"000")+"/"+USR_GetUserName ($userID;1)
	QUERY:C277([xShell_Queries:53];[xShell_Queries:53]InMenu:7=$t_llave;*)
	QUERY:C277([xShell_Queries:53]; | [xShell_Queries:53]InMenu:7=String:C10(Table:C252($y_tabla);"000"))
	CREATE SET:C116([xShell_Queries:53];"set")
	QUERY SELECTION:C341([xShell_Queries:53];[xShell_Queries:53]No:1<0)
	SELECTION TO ARRAY:C260([xShell_Queries:53]Name:2;$at_ListaConsultas)
	SORT ARRAY:C229($at_ListaConsultas)
	$l_finBloqueStandard:=Size of array:C274($at_ListaConsultas)
	USE SET:C118("set")
	CLEAR SET:C117("set")
	QUERY SELECTION:C341([xShell_Queries:53];[xShell_Queries:53]No:1>0)
	SELECTION TO ARRAY:C260([xShell_Queries:53]Name:2;$at_consultas)
	SORT ARRAY:C229($at_consultas;>)
	If (Size of array:C274($at_consultas)>0)
		If ($l_finBloqueStandard>0)
			INSERT IN ARRAY:C227($at_ListaConsultas;$l_finBloqueStandard+1;1)
			$at_ListaConsultas{$l_finBloqueStandard+1}:="-"
		Else 
			$l_finBloqueStandard:=-1
		End if 
		AT_Insert ($l_finBloqueStandard+2;Size of array:C274($at_consultas);->$at_ListaConsultas)
		For ($i;1;Size of array:C274($at_consultas))
			$at_ListaConsultas{$i+$l_finBloqueStandard+1}:=$at_consultas{$i}
		End for 
	End if 
End if 

If (Application version:C493>="15@")
	C_OBJECT:C1216($ob_json)
	OB SET ARRAY:C1227($ob_json;"busquedas";$at_ListaConsultas)
	$t_json:=JSON Stringify:C1217($ob_json;*)
	
Else 
	  //$t_jsonT:=JSON New
	  //$t_refNodo:=JSON Append text array ($t_jsonT;"busquedas";$at_ListaConsultas)
	  //$t_json:=JSON Export to text ($t_jsonT;JSON_WITHOUT_WHITE_SPACE)
	  //JSON CLOSE ($t_jsonT)  //20150421 RCH Se agrega cierre
End if 

$0:=$t_json