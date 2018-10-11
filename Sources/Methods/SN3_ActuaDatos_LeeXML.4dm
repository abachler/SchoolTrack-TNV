//%attributes = {}
C_TEXT:C284($ruta_xml;$1)
C_BLOB:C604($vx_text)
$ruta_xml:=$1

ARRAY TEXT:C222(at_alu_tags_identidad;0)
ARRAY TEXT:C222(at_alu_values_identidad;0)

ARRAY TEXT:C222(at_per_tags_identidad;0)
ARRAY TEXT:C222(at_per_values_identidad;0)

ARRAY TEXT:C222(at_alu_tags_modificados;0)
ARRAY TEXT:C222(at_alu_values_modificados;0)

ARRAY TEXT:C222(at_per_tags_modificados;0)
ARRAY TEXT:C222(at_per_values_modificados;0)

C_LONGINT:C283($vl_proximoArreglo;$ok;$count_alu;$ok;$count_nodo_padre;$count_instancia)
C_POINTER:C301($vp_array_tag;$vp_array_value)
C_TEXT:C284($childName;$childValue;$xmlRef)

$ok:=1
$xmlRef:=DOM Parse XML source:C719($ruta_xml)
$count:=0
$count_nodo_padre:=0
$xml_Parent_Ref1:=DOM Get first child XML element:C723($xmlRef;$childName;$childValue)
$last_ref:=$xml_Parent_Ref1
$count_instancia:=0
$instancia_2:=0

While (OK=1)
	
	If (($childName="identidad") | ($childName="datosmodificados"))
		$instancia:=$childName
	End if 
	
	Case of 
		: ($childName="relacionfamiliar")
			
			Case of 
				: ($instancia="identidad")
					$vp_array_tag:=->at_per_tags_identidad
					$vp_array_value:=->at_per_values_identidad
				: ($instancia="datosmodificados")
					$vp_array_tag:=->at_per_tags_modificados
					$vp_array_value:=->at_per_values_modificados
			End case 
			
			$xml_Parent_Ref3:=DOM Get first child XML element:C723($xml_Parent_Ref2;$childName;$childValue)
			
			If (OK=1)
				SET BLOB SIZE:C606($vx_text;0)
				If ($childValue#"")
					CONVERT FROM TEXT:C1011($childValue;"ISO-8859-1";$vx_text)
					$childValue:=Convert to text:C1012($vx_text;"UTF-8")
				End if 
				APPEND TO ARRAY:C911($vp_array_tag->;$childName)
				APPEND TO ARRAY:C911($vp_array_value->;$childValue)
				
				While (OK=1)
					$xml_Parent_Ref3:=DOM Get next sibling XML element:C724($xml_Parent_Ref3;$childName;$childValue)
					If (OK=1)
						SET BLOB SIZE:C606($vx_text;0)
						If ($childValue#"")
							CONVERT FROM TEXT:C1011($childValue;"ISO-8859-1";$vx_text)
							$childValue:=Convert to text:C1012($vx_text;"UTF-8")
						End if 
						APPEND TO ARRAY:C911($vp_array_tag->;$childName)
						APPEND TO ARRAY:C911($vp_array_value->;$childValue)
					End if 
				End while 
				
			End if 
			
			OK:=1
			
		: ($childName="alumnos")
			
			Case of 
				: ($instancia="identidad")
					$vp_array_tag:=->at_alu_tags_identidad
					$vp_array_value:=->at_alu_values_identidad
				: ($instancia="datosmodificados")
					$vp_array_tag:=->at_alu_tags_modificados
					$vp_array_value:=->at_alu_values_modificados
			End case 
			
			$xml_Parent_Ref4:=DOM Get first child XML element:C723($xml_Parent_Ref3;$childName;$childValue)
			$ok:=OK
			$count_alu:=0
			While ($ok=1)
				If ($count_alu=0)
					$xml_Parent_Ref5:=DOM Get first child XML element:C723($xml_Parent_Ref4;$childName;$childValue)
				Else 
					$xml_Parent_Ref4:=DOM Get next sibling XML element:C724($xml_Parent_Ref4;$childName;$childValue)
					If (OK=1)
						$xml_Parent_Ref5:=DOM Get first child XML element:C723($xml_Parent_Ref4;$childName;$childValue)
					End if 
				End if 
				$ok:=OK
				If ($ok=1)
					SET BLOB SIZE:C606($vx_text;0)
					If ($childValue#"")
						CONVERT FROM TEXT:C1011($childValue;"ISO-8859-1";$vx_text)
						$childValue:=Convert to text:C1012($vx_text;"UTF-8")
					End if 
					APPEND TO ARRAY:C911($vp_array_tag->;$childName)
					APPEND TO ARRAY:C911($vp_array_value->;$childValue)
				End if 
				While (OK=1)
					$xml_Parent_Ref5:=DOM Get next sibling XML element:C724($xml_Parent_Ref5;$childName;$childValue)
					If (OK=1)
						If (($childName="alergias") | ($childName="enfermedades") | ($childName="vacunas") | ($childName="urgenciacontactos"))  //MONO: ACTUA DATOS FATOBJECTS
							DOM_Lee_Nodo ($xml_Parent_Ref5;$vp_array_tag;$vp_array_value;OK)
						Else 
							SET BLOB SIZE:C606($vx_text;0)
							If ($childValue#"")
								CONVERT FROM TEXT:C1011($childValue;"ISO-8859-1";$vx_text)
								$childValue:=Convert to text:C1012($vx_text;"UTF-8")
							End if 
							APPEND TO ARRAY:C911($vp_array_tag->;$childName)
							APPEND TO ARRAY:C911($vp_array_value->;$childValue)
						End if 
						
					End if 
				End while 
				$count_alu:=$count_alu+1
			End while 
			
			OK:=1
			$count_nodo_padre:=1
		Else 
			
			If ($count=0)
				$xml_Parent_Ref2:=DOM Get first child XML element:C723($last_ref;$childName;$childValue)
				$count:=$count+1
			Else 
				If ($count_nodo_padre=0)
					$xml_Parent_Ref3:=DOM Get next sibling XML element:C724($xml_Parent_Ref2;$childName;$childValue)
				Else 
					$xml_Parent_Ref2:=DOM Get next sibling XML element:C724($xml_Parent_Ref1;$childName;$childValue)
					$last_ref:=$xml_Parent_Ref2
					$count_nodo_padre:=0
					$count:=0
					$count_instancia:=$count_instancia+1
				End if 
			End if 
			
	End case 
	
	If ($count_instancia>1)
		  //para salir después de terminar con los elementos de datos modificados
		OK:=0
	Else 
		
		If (OK=0)
			$xml_Parent_Ref1:=DOM Get next sibling XML element:C724($xml_Parent_Ref1;$childName;$childValue)
			$last_ref:=$xml_Parent_Ref1
			$count:=0
		End if 
		
	End if 
	
End while 

DOM CLOSE XML:C722($xmlRef)