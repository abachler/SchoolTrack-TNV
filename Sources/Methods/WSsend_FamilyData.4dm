//%attributes = {"publishedSoap":true}
  //WSsend_FamilyData

  //`xShell, Alberto Bachler
  //Metodo: WS_GetFamilyData
  //Por abachler
  //Creada el 05/11/2003, 16:53:03
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_TIME:C306($time)
C_TEXT:C284($1;$2;$3;$schoolID;$userName;$password;vtWS_ErrorString)
C_LONGINT:C283($4;$familyID)
C_LONGINT:C283($logged)

ARRAY TEXT:C222(atWS_FieldValues;0)
ARRAY TEXT:C222(atWS_FieldNames;0)
SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"schoolID")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"userName")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"password")
SOAP DECLARATION:C782($4;Is longint:K8:6;SOAP input:K46:1;"family_ID")


SOAP DECLARATION:C782(vtWS_ErrorString;Is text:K8:3;SOAP output:K46:2;"ERRstring")
SOAP DECLARATION:C782(atWS_FieldNames;Text array:K8:16;SOAP output:K46:2;"familias_fieldNames")
SOAP DECLARATION:C782(atWS_FieldValues;Text array:K8:16;SOAP output:K46:2;"familias_FieldValues")

  //****INICIALIZACIONES****
$tableNum:=Table:C252(->[Familia:78])
$schoolID:=$1
$userName:=$2
$password:=$3
$familyID:=$4
vtWS_ErrorString:=""

  //****CUERPO****
vtWS_ErrorString:=""
If ($schoolID=<>gRolBD)
	If (($userName="demoWS") & ($password="demoWS"))
		$logged:=1
	Else 
		$logged:=dhUG_ProcessLogin ($userName;$password)
	End if 
Else 
	vtWS_ErrorString:="Identificador de la institución incorrecto (Error -1)"
End if 

If ($logged=1)
	  //ARRAY TEXT(atWS_FieldNames;Get last field number($tableNum))
	  //ARRAY TEXT(atWS_FieldValues;Get last field number($tableNum))
	ARRAY TEXT:C222(atWS_FieldNames;0)
	ARRAY TEXT:C222(atWS_FieldValues;0)
	QUERY:C277([Familia:78];[Familia:78]Numero:1=$familyID)
	For ($i;1;Get last field number:C255(Table:C252(->[Familia:78])))
		  //20130321 RCH
		If (Is field number valid:C1000($tableNum;$i))
			$fieldName:=API Get Virtual Field Name ($tableNum;$i)
			If ($fieldName="")
				$fieldName:=Field name:C257($tableNum;$i)
			End if 
			$fieldPointer:=Field:C253($tableNum;$i)
			$type:=Type:C295($fieldPointer->)
			If (($type#Is subtable:K8:11) & ($type#Is picture:K8:10) & ($type#Is BLOB:K8:12))
				$Fieldvalue:=ST_Coerce_to_Text ($fieldPointer)
				  //atWS_FieldNames{$i}:=$fieldName
				  //atWS_FieldValues{$i}:=$fieldValue
				APPEND TO ARRAY:C911(atWS_FieldNames;$fieldName)
				APPEND TO ARRAY:C911(atWS_FieldValues;$fieldValue)
			Else 
				  //atWS_FieldNames{$i}:=$fieldName
				  //atWS_FieldValues{$i}:="N/A"
				APPEND TO ARRAY:C911(atWS_FieldNames;$fieldName)
				APPEND TO ARRAY:C911(atWS_FieldValues;"N/A")
			End if 
		End if 
	End for 
Else 
	vtWS_ErrorString:="Nombre de usuario o contraseña incorrecto (Error -2)"
End if 

  //****LIMPIEZA****