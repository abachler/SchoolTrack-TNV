//%attributes = {}
  // JSON_Seleccion_a_json()
  // Por: Alberto Bachler K.: 18-02-15, 18:30:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

C_LONGINT:C283($i_campos;$i_registros;$l_recNum;$l_tipo)
C_POINTER:C301($y_campo;$y_Columnas;$y_tabla)
C_TEXT:C284($t_json;$t_nodoRegistro;$t_nombreCampo;$t_raizJson)
C_OBJECT:C1216($ob_raiz)



If (False:C215)
	C_TEXT:C284(Json_Seleccion_a_jSon ;$0)
	C_POINTER:C301(Json_Seleccion_a_jSon ;$1)
	C_POINTER:C301(Json_Seleccion_a_jSon ;$2)
End if 

$y_tabla:=$1
$y_Columnas:=$2


If (Records in selection:C76($y_tabla->)>0)
	  //$t_raizJson:=JSON New 
	$ob_raiz:=OB_Create 
	FIRST RECORD:C50($y_tabla->)
	For ($i_registros;1;Records in selection:C76($y_tabla->))
		$l_recNum:=Record number:C243($y_tabla->)
		If (Size of array:C274($y_columnas->)>0)
			C_OBJECT:C1216($ob_nodoregistro)
			$ob_nodoregistro:=OB_Create 
			  //$t_nodoRegistro:=JSON Append node ($t_raizJson;"")
			For ($i_campos;1;Size of array:C274($y_Columnas->))
				$y_campo:=$y_Columnas->{$i_campos}
				$l_tipo:=Type:C295($y_campo->)
				$t_nombreCampo:=Field name:C257($y_campo)
				  //JSON_AgregaElemento ($t_nodoRegistro;$y_campo;$t_nombreCampo)
				OB_SET ($ob_nodoregistro;$y_campo;$t_nombreCampo)
			End for 
			OB_SET ($ob_raiz;->$ob_nodoregistro;"")
		End if 
		NEXT RECORD:C51($y_tabla->)
	End for 
	$0:=OB_Object2Json ($ob_raiz)
	  //$0:=JSON Export to text ($t_raizJson;JSON_WITH_WHITE_SPACE)
	  //JSON CLOSE ($t_raizJson)
	
End if 

