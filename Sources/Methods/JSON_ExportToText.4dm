//%attributes = {}
  // JSON_ExportToText(refObjeto:Y{; prettyPrint:B{; preserveObject:B)
  // exporta un objeto o una referencia JSON (plugin OAuth) a texto.
  // prettyPrint: FALSE por defecto; si TRUE convierte el objeto en JSON con formato
  // preserveObjecvt: FALSE por defecto; si TRUE el objeto es mantenido en memoria
  //
  // creado por: Alberto Bachler Klein: 24-11-15, 11:10:19
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_BOOLEAN:C305($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($b_clearObject;$b_PreservarObjeto;$b_prettyPrint)
C_POINTER:C301($y_refObjeto)
C_TEXT:C284($t_json)


If (False:C215)
	C_TEXT:C284(JSON_ExportToText ;$0)
	C_BOOLEAN:C305(JSON_ExportToText ;$2)
	C_BOOLEAN:C305(JSON_ExportToText ;$3)
End if 


$b_PreservarObjeto:=False:C215
$b_prettyPrint:=(Not:C34(Is compiled mode:C492))
Case of 
	: (Count parameters:C259=2)
		$b_prettyPrint:=$2
		
	: (Count parameters:C259=3)
		$b_prettyPrint:=$2
		$b_PreservarObjeto:=$3
End case 


If (Application version:C493>="15@")
	C_OBJECT:C1216($1)
	C_OBJECT:C1216($ob_objeto)
	$ob_objeto:=$1
	$t_json:=OB_Object2Json ($ob_objeto;$b_prettyPrint)
Else 
	  //C_TEXT($1)
	  //C_TEXT($t_refJson)
	  //$t_refJson:=$1
	  //If ($b_prettyPrint)
	  //$t_json:=JSON Export to text ($y_RefObjeto->;JSON_WITH_WHITE_SPACE)
	  //Else 
	  //$t_json:=JSON Export to text ($y_RefObjeto->;JSON_WITHOUT_WHITE_SPACE)
	  //End if 
End if 

$0:=$t_json

If (Not:C34($b_PreservarObjeto))
	CLEAR VARIABLE:C89($y_refObjeto->)
End if 