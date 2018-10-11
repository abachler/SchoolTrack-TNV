//%attributes = {}
  //IOstr_ProcessFamilyRecord

C_LONGINT:C283($tableNum;$fieldNum)
C_BOOLEAN:C305($b_conexionWeb)
C_LONGINT:C283($0)
$b_continuar:=True:C214

UFLD_LoadFileTplt (->[Familia:78])

If (Count parameters:C259>=1)
	$b_conexionWeb:=$1
End if 

$startAt:=Find in array:C230(aRecordFieldNames;"[Familia]@")
ARRAY POINTER:C280($aKeyFieldsPointers;0)
ARRAY TEXT:C222($aKeyFieldsValues;0)

If (Not:C34($b_conexionWeb))
	For ($i;$startAt;Size of array:C274(aRecordFieldNames))
		If (aRecordFieldNames{$i}="[Familia]@")
			If ((aRecordLine{aSourceDataElement{$i}}#"") & (aSourceDataElement{$i}>0))
				$pointer:=aRecordFieldPointers{$i}
				If (Picture size:C356(aRecordFieldKey{$i})>0)
					INSERT IN ARRAY:C227($aKeyFieldsPointers;Size of array:C274($aKeyFieldsPointers)+1)
					$aKeyFieldsPointers{Size of array:C274($aKeyFieldsPointers)}:=$pointer
					$type:=Type:C295($pointer->)
					INSERT IN ARRAY:C227($aKeyFieldsValues;Size of array:C274($aKeyFieldsValues)+1)
					$aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)}:=aRecordLine{aSourceDataElement{$i}}
					$tableNum:=Table:C252($pointer)
					$fieldNum:=Field:C253($pointer)
				End if 
			End if 
		Else 
			$i:=Size of array:C274(aRecordFieldNames)+1
		End if 
	End for 
	
	REDUCE SELECTION:C351([Familia:78];0)
	READ WRITE:C146([Familia:78])
	If (Size of array:C274($aKeyFieldsPointers)>0)
		For ($i;1;Size of array:C274($aKeyFieldsPointers))
			QUERY:C277([Familia:78]; & ;$aKeyFieldsPointers{$i}->;=;$aKeyFieldsValues{$i};*)
		End for 
		QUERY:C277([Familia:78])
		
		  //20180404 RCH Ticket 203523
		If ((Records in selection:C76([Familia:78])>1) & (vl_StudentRecNum#-1))
			GOTO RECORD:C242([Alumnos:2];vl_StudentRecNum)
			If ([Alumnos:2]Familia_Número:24#0)
				QUERY SELECTION:C341([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
			Else 
				QUERY SELECTION:C341([Familia:78];[Familia:78]Dirección:7=[Alumnos:2]Direccion:12)
			End if 
			REDUCE SELECTION:C351([Alumnos:2];0)
		End if 
		
		$records:=Records in selection:C76([Familia:78])
		$recNum:=Record number:C243([Familia:78])
		
	Else 
		  //20180404 RCH Ticket 203523
		If ((Records in selection:C76([Familia:78])=0) & (vl_StudentRecNum#-1))
			GOTO RECORD:C242([Alumnos:2];vl_StudentRecNum)
			If ([Alumnos:2]Familia_Número:24#0)
				QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
			Else 
				QUERY:C277([Familia:78];[Familia:78]Dirección:7=[Alumnos:2]Direccion:12)
			End if 
			REDUCE SELECTION:C351([Alumnos:2];0)
		End if 
		
		
		$records:=Records in selection:C76([Familia:78])
		$recNum:=Record number:C243([Familia:78])
	End if 
Else 
	
	$l_posUUID:=Find in array:C230(aRecordFieldNames;"[Familia]Auto_UUID")
	If ($l_posUUID#-1)
		If ((aRecordLine{aSourceDataElement{$l_posUUID}}#"") & (aSourceDataElement{$l_posUUID}>0))
			$pointer:=aRecordFieldPointers{$l_posUUID}
			INSERT IN ARRAY:C227($aKeyFieldsValues;Size of array:C274($aKeyFieldsValues)+1)
			INSERT IN ARRAY:C227($aKeyFieldsPointers;Size of array:C274($aKeyFieldsPointers)+1)
			$aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)}:=aRecordLine{aSourceDataElement{$l_posUUID}}
			$aKeyFieldsPointers{Size of array:C274($aKeyFieldsPointers)}:=$pointer
			$type:=Type:C295($pointer->)
		End if 
		QUERY:C277([Familia:78];[Familia:78]Auto_UUID:23=$aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)})
		$records:=Records in selection:C76([Familia:78])
		$recNum:=Record number:C243([Familia:78])
		$b_continuar:=True:C214
		
	Else 
		$b_continuar:=False:C215
	End if 
	
End if 

If ($b_continuar)
	
	If ($records=0)
		CREATE RECORD:C68([Familia:78])
		[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
		[Familia:78]Fecha_de_creación:27:=Current date:C33(*)
		[Familia:78]Fecha_de_Modificacion:28:=[Personas:7]Fecha_de_Creacion:26
	Else 
		READ WRITE:C146([Familia:78])
		GOTO RECORD:C242([Familia:78];$recNum)
		[Familia:78]Fecha_de_Modificacion:28:=Current date:C33(*)
	End if 
	
	
	
	
	
	
	
	
	
	
	For ($i;$startAt;Size of array:C274(aRecordFieldNames))
		If ((aRecordFieldNames{$i}="[Familia]@") & (aRecordLine{aSourceDataElement{$i}}#"") & (aSourceDataElement{$i}>0))
			$pointer:=aRecordFieldPointers{$i}
			If (Not:C34(Is nil pointer:C315($pointer)))
				$type:=Type:C295($pointer->)
			Else 
				$type:=0
			End if 
			Case of 
				: (Is nil pointer:C315($pointer))
					$text:=aRecordLine{aSourceDataElement{$i}}
					$recordFieldName:=Substring:C12(aRecordFieldNames{$i};Position:C15("]";aRecordFieldNames{$i})+1)
					If ($text#"")
						$el:=Find in array:C230(aUFList;$recordFieldName)
						If ($el>0)
							$code:=String:C10(aUFID{$el};"00000")+"/"
							If (aUFMulti{$el})
								_O_CREATE SUBRECORD:C72([Familia:78]Userfields:13)
							Else 
								_O_QUERY SUBRECORDS:C108([Familia:78]Userfields:13;[Familia]Userfields'Value=$code)
								If (_O_Records in subselection:C7([Familia:78]Userfields:13)=0)
									_O_CREATE SUBRECORD:C72([Familia:78]Userfields:13)
								End if 
							End if 
							Case of 
								: (aUFType{$el}=0)
									$value:=$text
								: (aUFType{$el}=1)
									$n:=Num:C11($text)
									$value:=String:C10($n;"### ### ##0,00")
								: (aUFType{$el}=4)
									$d:=Date:C102($text)
									$text:=String:C10($d;7)
									$value:=String:C10(DT_Date2Num (Date:C102($text));"0000000000")
								: (aUFType{$el}=9)
									$n:=Num:C11($text)
									$value:=String:C10($n;"### ### ##0")
							End case 
							[Familia]Userfields'Value:=$code+$value
						End if 
					End if 
				: ($type=Is boolean:K8:9)
					$text:=aRecordLine{aSourceDataElement{$i}}
					If (($text="1") | ($text="Y") | ($text="S") | ($text="Si") | ($text="Yes") | ($text="Oui") | ($text="Verdadero") | ($text="True") | ($text="Vrai") | ($text="V"))
						$pointer->:=True:C214
					Else 
						$pointer->:=False:C215
					End if 
				: (($type=Is text:K8:3) | ($type=Is string var:K8:2) | ($type=Is alpha field:K8:1))
					$pointer->:=aRecordLine{aSourceDataElement{$i}}
				: ($type=Is date:K8:7)
					$pointer->:=Date:C102(aRecordLine{aSourceDataElement{$i}})
				: (($type=Is real:K8:4) | ($type=Is integer:K8:5) | ($type=Is longint:K8:6))
					$pointer->:=Num:C11(aRecordLine{aSourceDataElement{$i}})
				: ($type=Is time:K8:8)
					$pointer->:=Time:C179(aRecordLine{aSourceDataElement{$i}})
			End case 
			  //Else 
			  //$i:=Size of array(aRecordFieldNames)+1
		End if 
	End for 
	
	  //20180404 RCH Ticket 203523
	C_TEXT:C284($t_camposObligatorios;$t_datosNoUnicos;$t_datoNoValido)
	C_BOOLEAN:C305($b_error;$b_agregaUUID)
	$b_error:=STR_ValidaCreacionRegistro ("Familias";->$t_camposObligatorios;->$t_datosNoUnicos;->$t_datoNoValido)
	If (Not:C34($b_error))
		[Familia:78]Nombre_de_la_familia:3:=ST_Format (->[Familia:78]Nombre_de_la_familia:3)
		If (Record number:C243([Familia:78])=-3)
			If ($b_conexionWeb)
				If (Find in array:C230(atIOstr_UUIDFamiliasN;[Familia:78]Auto_UUID:23)=-1)
					APPEND TO ARRAY:C911(atIOstr_UUIDFamiliasN;[Familia:78]Auto_UUID:23)  //20171122 RCH
				End if 
			Else 
				$b_agregaUUID:=True:C214
			End if 
		Else 
			$logText:="Se actualizó el registro de la familia "+[Familia:78]Nombre_de_la_familia:3+" con los datos del registro de importación."+"\r"
			
			
			If ((Find in array:C230(atIOstr_UUIDFamiliasN;[Familia:78]Auto_UUID:23)=-1) & (Find in array:C230(atIOstr_UUIDFamiliasA;[Familia:78]Auto_UUID:23)=-1))
				APPEND TO ARRAY:C911(atIOstr_UUIDFamiliasA;[Familia:78]Auto_UUID:23)  //20171122 RCH
			End if 
			SEND PACKET:C103(vH_logRef;$logText)
		End if 
		SAVE RECORD:C53([Familia:78])
		If ($b_agregaUUID)
			APPEND TO ARRAY:C911(atIOstr_UUIDFamiliasN;[Familia:78]Auto_UUID:23)
		End if 
		$0:=Record number:C243([Familia:78])
	Else 
		$0:=-1
	End if 
Else 
	$0:=-1
End if 

