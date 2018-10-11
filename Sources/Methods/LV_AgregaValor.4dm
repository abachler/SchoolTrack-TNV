//%attributes = {}
  // LV_AgregaValor()
  // Por: Alberto Bachler K.: 01-07-14, 17:33:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($l_posicion)
C_TEXT:C284($t_lenguaje;$t_nodo;$t_nombreLista;$t_refJson;$t_valor)

If (False:C215)
	C_TEXT:C284(LV_AgregaValor ;$1)
	C_TEXT:C284(LV_AgregaValor ;$2)
	C_TEXT:C284(LV_AgregaValor ;$3)
End if 
$t_nombreLista:=$1
$t_lenguaje:=$2
$t_valor:=$3

KRL_FindAndLoadRecordByIndex (->[xShell_List:39]Listname:1;->$t_nombreLista;True:C214)
If (OK=1)
	  //$t_refJson:=JSON Parse text ([xShell_List]json)
	  //$t_nodo:=JSON Get child by name ($t_refJson;$t_lenguaje;$l_posicion)
	  //JSON GET TEXT ARRAY ($t_nodo;LV_elementosLista_at)
	
	
	  // Modificado por: Alexis Bustamante (12-06-2017)
	  //Ticket 179869
	
	  //obtengo el Arreglo de lista enriquecible
	$ob_raiz:=OB_JsonToObject ([xShell_List:39]json:2)
	OB_GET ($ob_raiz;->LV_elementosLista_at;$t_lenguaje)
	
	If (Find in array:C230(LV_elementosLista_at;$t_valor)<0)
		APPEND TO ARRAY:C911(LV_elementosLista_at;$t_valor)
		SORT ARRAY:C229(LV_elementosLista_at;>)
		
		  //$t_refJson:=JSON New 
		  //$t_nodo:=JSON Append text array ($t_refJson;$t_lenguaje;LV_elementosLista_at)
		  //[xShell_List]json:=JSON Export to text ($t_refJson;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($t_refJson)
		CLEAR VARIABLE:C89($ob_raiz)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->LV_elementosLista_at;$t_lenguaje)
		[xShell_List:39]json:2:=OB_Object2Json ($ob_raiz)
		
		BLOB_Variables2Blob (->[xShell_List:39]Contents:9;0;->LV_elementosLista_at)
		SAVE RECORD:C53([xShell_List:39])
		KRL_UnloadReadOnly (->[xShell_List:39])
	End if 
End if 
