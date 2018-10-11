//%attributes = {}
  //SN3_BuildObsoletosXML

$tipoDatos:=$1
$xmlRef:=$2
$label:=$3

ARRAY LONGINT:C221($idArray;0)

SN3_ManejaReferencias ("buscar";$tipoDatos;0;SNT_Accion_Eliminar;->$idArray)
If (Size of array:C274($idArray)>0)
	SAX_CreateNode ($xmlRef;$label)
	For ($i;1;Size of array:C274($idArray))
		SAX_CreateNode ($xmlRef;"id";True:C214;String:C10($idArray{$i}))
	End for 
	SAX CLOSE XML ELEMENT:C854($xmlRef)
	  //SN3_ManejaReferencias ("eliminar";$tipoDatos;0;SNT_Accion_Eliminar )
End if 