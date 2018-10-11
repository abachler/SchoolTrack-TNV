//%attributes = {}
  //ACTDOM_2XML2Arrays 
  //C_TEXT($vt_param5)
_O_C_STRING:C293(16;$xmlRef)
C_LONGINT:C283($datas;$i)
_O_C_STRING:C293(16;$xml_Parent_Ref)
_O_C_STRING:C293(16;$xml_Parent_Ref2)
C_TEXT:C284($childName;$childValue)
C_LONGINT:C283($vl_proximoArreglo;$vl_index;$vl_elemento;$pos;$i)

QR_DeclareGenericArrays 
QR_DeclareGenericVariables 

$vl_proximoArreglo:=2
$vl_index:=0

$ptr1:=$1

$xmlRef:=DOM Parse XML variable:C720($ptr1->)
If (OK=1)
	$xml_Parent_Ref:=DOM Get first child XML element:C723($xmlRef;$childName;$childValue)
	While (OK=1)
		$xml_Parent_Ref2:=DOM Get first child XML element:C723($xml_Parent_Ref;$childName;$childValue)
		If (OK=1)
			$vl_elemento:=Size of array:C274(aQR_Text2)+1
			$pos:=Find in array:C230(aQR_Text1;$childName)
			If ($pos=-1)
				APPEND TO ARRAY:C911(aQR_Text1;$childName)
				$vl_index:=$vl_proximoArreglo
				$vl_proximoArreglo:=$vl_proximoArreglo+1
			Else 
				$vl_index:=$pos+1
			End if 
			For ($i;2;$vl_proximoArreglo-1)
				vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($i))
				AT_RedimArrays ($vl_elemento;vQR_Pointer1)
			End for 
			vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($vl_index))
			vQR_Pointer1->{$vl_elemento}:=$childValue
		End if 
		While (OK=1)
			$xml_Parent_Ref2:=DOM Get next sibling XML element:C724($xml_Parent_Ref2;$childName;$childValue)
			If (OK=1)
				$pos:=Find in array:C230(aQR_Text1;$childName)
				If ($pos=-1)
					APPEND TO ARRAY:C911(aQR_Text1;$childName)
					$vl_index:=$vl_proximoArreglo
					$vl_proximoArreglo:=$vl_proximoArreglo+1
				Else 
					$vl_index:=$pos+1
				End if 
				For ($i;2;$vl_proximoArreglo-1)
					vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($i))
					AT_RedimArrays (Size of array:C274(aQR_Text2);vQR_Pointer1)
				End for 
				
				vQR_Pointer1:=Get pointer:C304("aQR_Text"+String:C10($vl_index))
				vQR_Pointer1->{$vl_elemento}:=$childValue
			End if 
		End while 
		$xml_Parent_Ref:=DOM Get next sibling XML element:C724($xml_Parent_Ref;$childName;$childValue)
	End while 
	DOM CLOSE XML:C722($xmlRef)
Else 
	CD_Dlog (0;__ ("El XML devuelto no es válido."))
End if 
