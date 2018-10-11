//%attributes = {"publishedSoap":true}
  //WSscripts_ListaScript

C_TEXT:C284(vtws_ErrorString;t_json)
C_TEXT:C284($1;$t_llave)
C_TEXT:C284($2;$t_dts;$t_desc)
C_OBJECT:C1216($ob_estado;$ob_raiz;$ob_temp)
ARRAY OBJECT:C1221($ao_script;0)

C_TEXT:C284($t_principal;$t_err;$node;$temporal;$t_ac)

vtws_ErrorString:=""

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"llave")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"dts")
SOAP DECLARATION:C782(vtws_ErrorString;Is text:K8:3;SOAP output:K46:2;"result")
SOAP DECLARATION:C782(t_json;Is text:K8:3;SOAP output:K46:2;"json")

$t_llave:=$1
$t_dts:=$2

If (ACTwp_GeneraKey ($t_dts)=$t_llave)
	READ ONLY:C145([CORP_Scripts:197])
	ALL RECORDS:C47([CORP_Scripts:197])
	FIRST RECORD:C50([CORP_Scripts:197])
	
	
	$ob_raiz:=OB_Create 
	$ob_estado:=OB_Create 
	
	$vl_error:=0
	$vt_descripcion:=""
	
	  // Modificado por: Alexis Bustamante (10-06-2017)
	  //TICKET 179869
	  //cambio de plugin a comando nativo
	
	
	OB_SET ($ob_estado;->$vl_error;"codigo")
	OB_SET ($ob_estado;->$vt_descripcion;"descripcion")
	  //$t_principal:=JSON New
	  //$t_err:=JSON Append node ($t_principal;"estado")
	  //$node:=JSON Append real ($t_err;"codigo";0)
	  //$node:=JSON Append text ($t_err;"descripcion";"")
	OB_SET ($ob_raiz;->$ob_estado;"estado")
	
	While (Not:C34(End selection:C36([CORP_Scripts:197])))
		$ob_temp:=OB_Create 
		OB_SET ($ob_temp;->[CORP_Scripts:197]ID_Script:1;"idscript")
		OB_SET ($ob_temp;->[CORP_Scripts:197]Descripcion:10;"descripcion")
		OB_SET ($ob_temp;->[CORP_Scripts:197]Auto_UUID:9;"uuid")
		  //$t_ac:=JSON Append node ($temporal;"script")
		  //$node:=JSON Append real ($t_ac;"idscript";[CORP_Scripts]ID_Script)
		  //$node:=JSON Append text ($t_ac;"descripcion";[CORP_Scripts]Descripcion)
		  //$node:=JSON Append text ($t_ac;"uuid";[CORP_Scripts]Auto_UUID)
		APPEND TO ARRAY:C911($ao_script;$ob_temp)
		CLEAR VARIABLE:C89($ob_temp)
		NEXT RECORD:C51([CORP_Scripts:197])
	End while 
	
	OB_SET ($ob_raiz;->$ao_script;"scripts")
	t_json:=OB_Object2Json ($ob_raiz)
	$t_json:=OB_Object2Json ($ob_raiz)
	  //JSON SET TYPE ($temporal;JSON_ARRAY)
	  //t_json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
	  //$t_json:=JSON Export to text ($t_principal;JSON_WITH_WHITE_SPACE)
	  //JSON CLOSE ($t_principal)
	vtws_ErrorString:=""
	
Else 
	vtws_ErrorString:="Llave no válida."
End if 