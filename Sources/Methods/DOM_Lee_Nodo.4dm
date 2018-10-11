//%attributes = {}
_O_C_STRING:C293(16;$ref_xml;$next_node;$ini_node)
C_BOOLEAN:C305($vb_append2array)
C_BLOB:C604($vx_text)
C_TEXT:C284($childName;$childValue)

$ref_xml:=$1
$ptr_tag:=$2
$ptr_value:=$3
$continue:=$4
$ok:=1

If ((Type:C295($ptr_tag->)=18) & (Type:C295($ptr_value->)=18))
	$vb_append2array:=True:C214
End if 

$ini_node:=DOM Get first child XML element:C723($ref_xml;$childName;$childValue)
$nombre_nodo:=$childName

While (OK=1)
	$count:=0
	
	While (OK=1)
		If ($count=0)
			$next_node:=DOM Get first child XML element:C723($ini_node;$childName;$childValue)
			If (($vb_append2array) & (OK=1))
				SET BLOB SIZE:C606($vx_text;0)
				CONVERT FROM TEXT:C1011($childValue;"ISO-8859-1";$vx_text)
				$childValue:=Convert to text:C1012($vx_text;"UTF-8")
				APPEND TO ARRAY:C911($ptr_tag->;$nombre_nodo+":"+$childName)
				APPEND TO ARRAY:C911($ptr_value->;$childValue)
			End if 
		Else 
			$next_node:=DOM Get next sibling XML element:C724($next_node;$childName;$childValue)
			If (($vb_append2array) & (OK=1))
				SET BLOB SIZE:C606($vx_text;0)
				CONVERT FROM TEXT:C1011($childValue;"ISO-8859-1";$vx_text)
				$childValue:=Convert to text:C1012($vx_text;"UTF-8")
				APPEND TO ARRAY:C911($ptr_tag->;$nombre_nodo+":"+$childName)
				APPEND TO ARRAY:C911($ptr_value->;$childValue)
			End if 
			
		End if 
		
		$count:=$count+1
		
	End while 
	
	$ini_node:=DOM Get next sibling XML element:C724($ini_node;$childName;$childValue)
End while 

OK:=$continue