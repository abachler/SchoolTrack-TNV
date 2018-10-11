//%attributes = {}
  //KRL_VerifyIndexes

C_LONGINT:C283($iTable;$iField;$fieldType;$fieldLength;$errorCount;$records;$tableNumber)
C_BOOLEAN:C305($indexed)
C_TIME:C306($time)
C_POINTER:C301($1;$4;$2)
ARRAY REAL:C219($aRealValues;0)
ARRAY INTEGER:C220($aIntegerValues;0)
ARRAY TEXT:C222($aTextValues;0)
ARRAY DATE:C224($aDateValues;0)
ARRAY LONGINT:C221($aLongintValues;0)
ARRAY BOOLEAN:C223($aBooleanValues;0)
C_BOOLEAN:C305($showResults)
ARRAY POINTER:C280($aTablePointers;0)

$errorsArrayPointers:=$1
$badIndexesArrayPointers:=$2

Case of 
	: (Count parameters:C259=4)
		$showResults:=$3
		$tableArrayPointer:=$4
		COPY ARRAY:C226($tableArrayPointer->;$aTablePointers)
		If (Size of array:C274($aTablePointers)=0)
			ARRAY POINTER:C280($aTablePointers;0)
			For ($i;1;Get last table number:C254)
				If (Is table number valid:C999($i))
					APPEND TO ARRAY:C911($aTablePointers;Table:C252($i))
				End if 
			End for 
		End if 
		
	: (Count parameters:C259=3)
		$showResults:=$3
		ARRAY POINTER:C280($aTablePointers;0)
		For ($i;1;Get last table number:C254)
			If (Is table number valid:C999($i))
				APPEND TO ARRAY:C911($aTablePointers;Table:C252($i))
			End if 
		End for 
		
	Else 
		ARRAY POINTER:C280($aTablePointers;0)
		For ($i;1;Get last table number:C254)
			If (Is table number valid:C999($i))
				APPEND TO ARRAY:C911($aTablePointers;Table:C252($i))
			End if 
		End for 
		
End case 



SET QUERY DESTINATION:C396(Into variable:K19:4;$records)

  //EM_ErrorManager ("Install")
  //EM_ErrorManager ("SetMode";"")
$pId:=IT_UThermometer (1;0;__ ("Verificando Index..."))
$m:=Milliseconds:C459
For ($iTable;1;Size of array:C274($aTablePointers))
	$tableNumber:=Table:C252($aTablePointers{$iTable})
	$tablePointer:=$aTablePointers{$iTable}
	$tableName:=Table name:C256($tableNumber)
	
	$pId:=IT_UThermometer (0;$pID;__ ("Verificando Index...  \rTabla ")+$tableName)
	For ($iField;1;Get last field number:C255($tableNumber))
		  //20130321 RCH
		If (Is field number valid:C1000($tableNumber;$iField))
			$fieldPointer:=Field:C253($tableNumber;$iField)
			$fieldName:=Field name:C257($tableNumber;$iField)
			$sourceTableName:="["+Table name:C256($tableNumber)+"]"
			$sourceFieldName:=$sourceTableName+Field name:C257($tableNumber;$iField)
			GET FIELD PROPERTIES:C258($tableNumber;$iField;$fieldType;$fieldLength;$indexed)
			
			If ($indexed)
				$pId:=IT_UThermometer (0;$pID;__ ("Verificando Index...  \r[")+$tableName+__ ("]")+$fieldName)
				ALL RECORDS:C47($tablePointer->)
				Case of 
					: ($fieldType=Is longint:K8:6)
						DISTINCT VALUES:C339($fieldPointer->;$aLongintValues)
						
						  //elimino eventuales NAN
						$reloadValues:=False:C215
						For ($iValues;1;Size of array:C274($aLongintValues))
							If (String:C10($aLongintValues{$iValues})="")
								$pId:=IT_UThermometer (0;$pID;__ ("Reparando registros con NANs...  \r[")+$tableName+__ ("]")+$fieldName)
								KRL_FixNANs ($tablePointer;$fieldPointer)
								$reloadValues:=False:C215
								$iValues:=Size of array:C274($aLongintValues)
								$pId:=IT_UThermometer (0;$pID;__ ("Verificando Index...  \r[")+$tableName+__ ("]")+$fieldName)
							End if 
						End for 
						If ($reloadValues)
							DISTINCT VALUES:C339($fieldPointer->;$aLongintValues)
						End if 
						
						$recordsFounded:=0
						For ($iValues;1;Size of array:C274($aLongintValues))
							QUERY:C277($tablePointer->;$fieldPointer->;=;$aLongintValues{$iValues})
							$recordsFounded:=$recordsFounded+$records
						End for 
						If ($recordsFounded#Records in table:C83($tablePointer->))
							ALL RECORDS:C47(Table:C252(Table:C252($fieldPointer))->)
							SELECTION TO ARRAY:C260($fieldPointer->;$aLongintValues)
							QUERY WITH ARRAY:C644($fieldPointer->;$aLongintValues)
							$recordsFounded:=Records in selection:C76(Table:C252(Table:C252($fieldPointer))->)
							If ($recordsFounded#Records in table:C83($tablePointer->))
								$error:="["+$tableName+"]"+$fieldName+": Index dañando: El index referencia "+String:C10($recordsFounded)+" mientras en la tabla hay "+String:C10(Records in table:C83($tablePointer->))+" registros."
								APPEND TO ARRAY:C911($errorsArrayPointers->;$error)
								APPEND TO ARRAY:C911($badIndexesArrayPointers->;$fieldPointer)
								$errorCount:=$errorCount+1
							End if 
						End if 
						
					: ($fieldType=Is integer:K8:5)
						DISTINCT VALUES:C339($fieldPointer->;$aIntegerValues)
						  //elimino eventuales NAN
						$reloadValues:=False:C215
						For ($iValues;1;Size of array:C274($aIntegerValues))
							If (String:C10($aIntegerValues{$iValues})="")
								$pId:=IT_UThermometer (0;$pID;__ ("Reparando registros con NANs...  \r[")+$tableName+__ ("]")+$fieldName)
								KRL_FixNANs ($tablePointer;$fieldPointer)
								$reloadValues:=False:C215
								$iValues:=Size of array:C274($aIntegerValues)
								$pId:=IT_UThermometer (0;$pID;__ ("Verificando Index...  \r[")+$tableName+__ ("]")+$fieldName)
							End if 
						End for 
						If ($reloadValues)
							DISTINCT VALUES:C339($fieldPointer->;$aIntegerValues)
						End if 
						
						$recordsFounded:=0
						For ($iValues;1;Size of array:C274($aIntegerValues))
							QUERY:C277($tablePointer->;$fieldPointer->;=;$aIntegerValues{$iValues})
							$recordsFounded:=$recordsFounded+$records
						End for 
						If ($recordsFounded#Records in table:C83($tablePointer->))
							ALL RECORDS:C47(Table:C252(Table:C252($fieldPointer))->)
							SELECTION TO ARRAY:C260($fieldPointer->;$aIntegerValues)
							QUERY WITH ARRAY:C644($fieldPointer->;$aIntegerValues)
							$recordsFounded:=Records in selection:C76(Table:C252(Table:C252($fieldPointer))->)
							If ($recordsFounded#Records in table:C83($tablePointer->))
								$error:="["+$tableName+"]"+$fieldName+": Index dañando: El index referencia "+String:C10($recordsFounded)+" mientras en la tabla hay "+String:C10(Records in table:C83($tablePointer->))+" registros."
								APPEND TO ARRAY:C911($errorsArrayPointers->;$error)
								APPEND TO ARRAY:C911($badIndexesArrayPointers->;$fieldPointer)
								$errorCount:=$errorCount+1
							End if 
						End if 
						
					: ($fieldType=Is real:K8:4)
						DISTINCT VALUES:C339($fieldPointer->;$aRealValues)
						
						  //elimino eventuales NAN
						$reloadValues:=False:C215
						For ($iValues;1;Size of array:C274($aRealValues))
							If (String:C10($aRealValues{$iValues})="")
								$pId:=IT_UThermometer (0;$pID;__ ("Reparando registros con NANs...  \r[")+$tableName+__ ("]")+$fieldName)
								KRL_FixNANs ($tablePointer;$fieldPointer)
								$reloadValues:=False:C215
								$iValues:=Size of array:C274($aRealValues)+1
								$pId:=IT_UThermometer (0;$pID;__ ("Verificando Index...  \r[")+$tableName+__ ("]")+$fieldName)
							End if 
						End for 
						If ($reloadValues)
							DISTINCT VALUES:C339($fieldPointer->;$aRealValues)
						End if 
						
						
						$recordsFounded:=0
						For ($iValues;1;Size of array:C274($aRealValues))
							If (String:C10($aRealValues{$iValues})#"")
								QUERY:C277($tablePointer->;$fieldPointer->;=;$aRealValues{$iValues})
								$recordsFounded:=$recordsFounded+$records
							End if 
						End for 
						If ($recordsFounded#Records in table:C83($tablePointer->))
							ALL RECORDS:C47(Table:C252(Table:C252($fieldPointer))->)
							SELECTION TO ARRAY:C260($fieldPointer->;$aRealValues)
							QUERY WITH ARRAY:C644($fieldPointer->;$aRealValues)
							$recordsFounded:=Records in selection:C76(Table:C252(Table:C252($fieldPointer))->)
							If ($recordsFounded#Records in table:C83($tablePointer->))
								$error:="["+$tableName+"]"+$fieldName+": Index dañando: El index referencia "+String:C10($recordsFounded)+" mientras en la tabla hay "+String:C10(Records in table:C83($tablePointer->))+" registros."
								APPEND TO ARRAY:C911($errorsArrayPointers->;$error)
								APPEND TO ARRAY:C911($badIndexesArrayPointers->;$fieldPointer)
								$errorCount:=$errorCount+1
							End if 
						End if 
						
					: ($fieldType=Is alpha field:K8:1)
						
						  //DISTINCT VALUES($fieldPointer->;$aTextValues)`20110530 RCH Se cambia porque provocaba una caida en una bd... Ticket 99878
						AT_DistinctsFieldValues ($fieldPointer;->$aTextValues;0)
						$recordsFounded:=0
						For ($iValues;1;Size of array:C274($aTextValues))
							QUERY:C277($tablePointer->;$fieldPointer->;=;$aTextValues{$iValues})
							$recordsFounded:=$recordsFounded+$records
						End for 
						If ($recordsFounded#Records in table:C83($tablePointer->))
							ALL RECORDS:C47(Table:C252(Table:C252($fieldPointer))->)
							SELECTION TO ARRAY:C260($fieldPointer->;$aTextValues)
							QUERY WITH ARRAY:C644($fieldPointer->;$aTextValues)
							$recordsFounded:=Records in selection:C76(Table:C252(Table:C252($fieldPointer))->)
							If ($recordsFounded#Records in table:C83($tablePointer->))
								$error:="["+$tableName+"]"+$fieldName+": Index dañando: El index referencia "+String:C10($recordsFounded)+" mientras en la tabla hay "+String:C10(Records in table:C83($tablePointer->))+" registros."
								APPEND TO ARRAY:C911($errorsArrayPointers->;$error)
								APPEND TO ARRAY:C911($badIndexesArrayPointers->;$fieldPointer)
								$errorCount:=$errorCount+1
							End if 
						End if 
						
					: ($fieldType=Is date:K8:7)
						DISTINCT VALUES:C339($fieldPointer->;$aDateValues)
						$recordsFounded:=0
						For ($iValues;1;Size of array:C274($aDateValues))
							QUERY:C277($tablePointer->;$fieldPointer->;=;$aDateValues{$iValues})
							$recordsFounded:=$recordsFounded+$records
						End for 
						If ($recordsFounded#Records in table:C83($tablePointer->))
							ALL RECORDS:C47(Table:C252(Table:C252($fieldPointer))->)
							SELECTION TO ARRAY:C260($fieldPointer->;$aDateValues)
							QUERY WITH ARRAY:C644($fieldPointer->;$aDateValues)
							$recordsFounded:=Records in selection:C76(Table:C252(Table:C252($fieldPointer))->)
							If ($recordsFounded#Records in table:C83($tablePointer->))
								$error:="["+$tableName+"]"+$fieldName+": Index dañando: El index referencia "+String:C10($recordsFounded)+" mientras en la tabla hay "+String:C10(Records in table:C83($tablePointer->))+" registros."
								APPEND TO ARRAY:C911($errorsArrayPointers->;$error)
								APPEND TO ARRAY:C911($badIndexesArrayPointers->;$fieldPointer)
								$errorCount:=$errorCount+1
							End if 
						End if 
						
						
					: ($fieldType=Is time:K8:8)
						DISTINCT VALUES:C339($fieldPointer->;$aLongintValues)
						$recordsFounded:=0
						For ($iValues;1;Size of array:C274($aLongintValues))
							$time:=$aLongintValues{$iValues}
							QUERY:C277($tablePointer->;$fieldPointer->;=;$time)
							$recordsFounded:=$recordsFounded+$records
						End for 
						If ($recordsFounded#Records in table:C83($tablePointer->))
							ALL RECORDS:C47(Table:C252(Table:C252($fieldPointer))->)
							SELECTION TO ARRAY:C260($fieldPointer->;$aLongintValues)
							QUERY WITH ARRAY:C644($fieldPointer->;$aLongintValues)
							$recordsFounded:=Records in selection:C76(Table:C252(Table:C252($fieldPointer))->)
							If ($recordsFounded#Records in table:C83($tablePointer->))
								$error:="["+$tableName+"]"+$fieldName+": Index dañando: El index referencia "+String:C10($recordsFounded)+" mientras en la tabla hay "+String:C10(Records in table:C83($tablePointer->))+" registros."
								APPEND TO ARRAY:C911($errorsArrayPointers->;$error)
								$errorCount:=$errorCount+1
							End if 
						End if 
						
					: ($fieldType=Is boolean:K8:9)
						DISTINCT VALUES:C339($fieldPointer->;$aBooleanValues)
						$recordsFounded:=0
						For ($iValues;1;Size of array:C274($aBooleanValues))
							QUERY:C277($tablePointer->;$fieldPointer->;=;$aBooleanValues{$iValues})
							$recordsFounded:=$recordsFounded+$records
						End for 
						If ($recordsFounded#Records in table:C83($tablePointer->))
							ALL RECORDS:C47(Table:C252(Table:C252($fieldPointer))->)
							SELECTION TO ARRAY:C260($fieldPointer->;$aBooleanValues)
							QUERY WITH ARRAY:C644($fieldPointer->;$aBooleanValues)
							$recordsFounded:=Records in selection:C76(Table:C252(Table:C252($fieldPointer))->)
							If ($recordsFounded#Records in table:C83($tablePointer->))
								$error:="["+$tableName+"]"+$fieldName+": Index dañando: El index referencia "+String:C10($recordsFounded)+" mientras en la tabla hay "+String:C10(Records in table:C83($tablePointer->))+" registros."
								APPEND TO ARRAY:C911($errorsArrayPointers->;$error)
								APPEND TO ARRAY:C911($badIndexesArrayPointers->;$fieldPointer)
								$errorCount:=$errorCount+1
							End if 
						End if 
						
					Else 
						  //TRACE
				End case 
			End if 
			
			ARRAY REAL:C219($aRealValues;0)
			ARRAY INTEGER:C220($aIntegerValues;0)
			ARRAY TEXT:C222($aTextValues;0)
			ARRAY DATE:C224($aDateValues;0)
			ARRAY LONGINT:C221($aLongintValues;0)
			ARRAY BOOLEAN:C223($aBooleanValues;0)
		End if 
	End for 
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
IT_UThermometer (-2;$pId)
$m:=Milliseconds:C459-$m
$time:=Round:C94($m/1000;0)
  //EM_ErrorManager ("Clear")

If ($showResults)
	If ($errorCount>0)
		SET BLOB SIZE:C606($blob;0)
		For ($i;1;Size of array:C274($errorsArrayPointers->))
			TEXT TO BLOB:C554(($errorsArrayPointers->{$i}+Char:C90(Carriage return:K15:38));$blob;Mac text without length:K22:10;*)
		End for 
		CLEAR PASTEBOARD:C402
		APPEND DATA TO PASTEBOARD:C403("TEXT";$blob)
		
		ALERT:C41("Tiempo de ejecución: "+String:C10($time)+"\r\rSe detectaron "+String:C10($errorCount)+" situaciones de corrupción de Indices. \rEl detalle está en el portapeles. \rPuede "+"pe"+"g"+"arlo en cualquier doc"+"umento que soporte el formato texto.")
		
	Else 
		ALERT:C41("Tiempo de ejecución: "+String:C10($time)+"\r\rNo se detectó ningún daño en los Indices.")
	End if 
End if 

KRL_UnloadAll 