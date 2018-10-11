//%attributes = {}
  //XML_CreateSaxElements

C_TIME:C306($1;$docRef)
C_TEXT:C284($2;$mainElement)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($varPointer)
$docRef:=$1
$mainElement:=$2
ARRAY POINTER:C280($valuesPointers;0)
ARRAY TEXT:C222($aNames;0)
COPY ARRAY:C226($3->;$aNames)
COPY ARRAY:C226($4->;$valuesPointers)
$numElements:=Size of array:C274($aNames)
$numRecords:=Size of array:C274($valuesPointers{1}->)


If ($numElements>0)
	If ($numRecords>0)
		
		For ($i_Records;1;$numRecords)
			  //ARRAY TEXT($aNames;$numElements)
			  //ARRAY TEXT($aValues;$numElements)
			SAX OPEN XML ELEMENT:C853($docRef;$mainElement)
			For ($i_XMLelements;1;$numElements)
				  //$aNames{$i_XMLelements}:=$namesPointer{$i_XMLelements}
				$pointer:=$valuesPointers{$i_XMLelements}
				$type:=Type:C295($pointer->)
				$value:=""
				Case of 
					: (($type=Is alpha field:K8:1) | ($type=Is string var:K8:2) | ($type=Is text:K8:3) | ($type=String array:K8:15) | ($type=Text array:K8:16))
						$value:=$valuesPointers{$i_XMLelements}->{$i_Records}
					: (($type=Is real:K8:4) | ($type=Is longint:K8:6) | ($type=Is integer:K8:5) | ($type=Real array:K8:17) | ($type=Integer array:K8:18) | ($type=LongInt array:K8:19))
						$value:=String:C10($valuesPointers{$i_XMLelements}->{$i_Records})
					: (($type=Is date:K8:7) | ($type=Date array:K8:20))
						$value:=String:C10($valuesPointers{$i_XMLelements}->{$i_Records};7)
					: ($type=Is time:K8:8)
						$value:=String:C10($valuesPointers{$i_XMLelements}->{$i_Records};1)
					: (($type=Is boolean:K8:9) | ($type=Boolean array:K8:21))
						$value:=String:C10(Num:C11($valuesPointers{$i_XMLelements}->{$i_Records});"Verdadero;;Falso")
					Else 
						$value:=""
				End case 
				SAX OPEN XML ELEMENT:C853($DocRef;$aNames{$i_XMLelements})
				SAX ADD XML ELEMENT VALUE:C855($DocRef;$value)
				SAX CLOSE XML ELEMENT:C854($DocRef)
				
			End for 
			SAX CLOSE XML ELEMENT:C854($docRef)
		End for 
	End if 
End if 


