//%attributes = {}
  // LV_LeeLista()
  // Por: Alberto Bachler K.: 01-07-14, 15:57:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_POINTER:C301($3)

C_LONGINT:C283($l_posicion)
C_POINTER:C301($y_arreglo)
C_TEXT:C284($t_lenguaje;$t_nodo;$t_nombreLista;$t_refJson)

If (False:C215)
	C_TEXT:C284(LV_LeeLista ;$0)
	C_TEXT:C284(LV_LeeLista ;$1)
	C_TEXT:C284(LV_LeeLista ;$2)
	C_POINTER:C301(LV_LeeLista ;$3)
End if 

$t_nombreLista:=$1
$t_lenguaje:=$2

If (Count parameters:C259=3)
	$y_arreglo:=$3
	ARRAY TEXT:C222($y_arreglo->;0)
End if 


C_OBJECT:C1216($ob)

  // Modificado por: Alexis Bustamante (12-06-2017)
  //Ticket 179869



KRL_FindAndLoadRecordByIndex (->[xShell_List:39]Listname:1;->$t_nombreLista)

$ob:=OB_Create 
$ob:=JSON Parse:C1218([xShell_List:39]json:2)
  //$t_refJson:=JSON Parse text ([xShell_List]json)
  //$t_nodo:=JSON Get child by name ($t_refJson;$t_lenguaje;$l_posicion)
If (Not:C34(Is nil pointer:C315($y_arreglo)))
	OB_GET ($ob;$y_arreglo;$t_lenguaje)
	  //JSON GET TEXT ARRAY ($t_nodo;$y_arreglo->)
	SORT ARRAY:C229($y_arreglo->;>)
Else 
	$0:=OB_Object2Json ($ob)
	  //$0:=JSON Export to text ($t_nodo;JSON_WITHOUT_WHITE_SPACE)
End if 
  //JSON CLOSE ($t_refJson)