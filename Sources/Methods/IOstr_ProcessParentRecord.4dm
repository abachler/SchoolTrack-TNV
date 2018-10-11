//%attributes = {}
  //IOstr_ProcessParentRecord

C_LONGINT:C283($tableNum;$fieldNum)
C_BOOLEAN:C305($b_continuar)
C_BOOLEAN:C305($b_conexionWeb)

$b_continuar:=True:C214

$PeopleType:=$1+"@"

Case of 
	: (Count parameters:C259>=2)
		$b_conexionWeb:=$2
End case 
UFLD_LoadFileTplt (->[Personas:7])


$startAt:=Find in array:C230(aRecordFieldNames;$peopleType)
ARRAY POINTER:C280($aKeyFieldsPointers;0)
ARRAY TEXT:C222($aKeyFieldsValues;0)
If (Not:C34($b_conexionWeb))
	For ($i;$startAt;Size of array:C274(aRecordFieldNames))
		If (aRecordFieldNames{$i}=$peopleType)
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
					If ((Field:C253(->[Personas:7]RUT:6)=$fieldNum) & (Table:C252(->[Personas:7]RUT:6)=$tableNum))
						$aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)}:=Replace string:C233(Replace string:C233($aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)};".";"");"-";"")
					End if 
				End if 
			End if 
		Else 
			$i:=Size of array:C274(aRecordFieldNames)+1
		End if 
	End for 
	
	READ WRITE:C146([Personas:7])
	If (Size of array:C274($aKeyFieldsPointers)>0)
		For ($i;1;Size of array:C274($aKeyFieldsPointers))
			  //MONO Ticket 143160, el rut no viene bien formateado en el archivo se busca así pero se crea formateado asi que formatearemos para buscarlo también.
			If ((<>vtXS_CountryCode="cl") & (KRL_isSameField ($aKeyFieldsPointers{$i};->[Personas:7]RUT:6)))
				$aKeyFieldsValues{$i}:=CTRY_CL_VerifRUT ($aKeyFieldsValues{$i};False:C215)
			End if 
			QUERY:C277([Personas:7]; & ;$aKeyFieldsPointers{$i}->;=;$aKeyFieldsValues{$i};*)
		End for 
		QUERY:C277([Personas:7])
		$records:=Records in selection:C76([Personas:7])
		$recNum:=Record number:C243([Personas:7])
		If ($records>1)
			$b_continuar:=False:C215
		End if 
	Else 
		$records:=0
	End if 
	
Else 
	$l_posUUID:=Find in array:C230(aRecordFieldNames;$PeopleType+"Auto_UUID")
	If ($l_posUUID#-1)
		If ((aRecordLine{aSourceDataElement{$l_posUUID}}#"") & (aSourceDataElement{$l_posUUID}>0))
			$pointer:=aRecordFieldPointers{$l_posUUID}
			INSERT IN ARRAY:C227($aKeyFieldsValues;Size of array:C274($aKeyFieldsValues)+1)
			INSERT IN ARRAY:C227($aKeyFieldsPointers;Size of array:C274($aKeyFieldsPointers)+1)
			$aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)}:=aRecordLine{aSourceDataElement{$l_posUUID}}  //20171122 RCH
			$aKeyFieldsPointers{Size of array:C274($aKeyFieldsPointers)}:=$pointer
			$type:=Type:C295($pointer->)
		End if 
		QUERY:C277([Personas:7];[Personas:7]Auto_UUID:36=$aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)})
		$records:=Records in selection:C76([Personas:7])
		$recNum:=Record number:C243([Personas:7])
		  //If ($recNum#-1) //20171122 RCH
		$b_continuar:=True:C214
		  //Else 
		  //$b_continuar:=False
		  //End if 
	Else 
		$b_continuar:=False:C215
	End if 
End if 

If ($b_continuar)
	If ($records=0)
		CREATE RECORD:C68([Personas:7])
		[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
		[Personas:7]Modificado_por:28:="Importación"
		[Personas:7]Fecha_de_Creacion:26:=Current date:C33(*)
		[Personas:7]Fecha_de_Modificacion:27:=[Personas:7]Fecha_de_Creacion:26
	Else 
		GOTO RECORD:C242([Personas:7];$recNum)
		[Personas:7]Modificado_por:28:="Importación"
		[Personas:7]Fecha_de_Modificacion:27:=Current date:C33(*)
	End if 
	
	For ($i;$startAt;Size of array:C274(aRecordFieldNames))
		If (aRecordFieldNames{$i}=$peopleType)
			If ((aRecordLine{aSourceDataElement{$i}}#"") & (aSourceDataElement{$i}>0))
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
									_O_CREATE SUBRECORD:C72([Personas:7]Userfields:31)
								Else 
									_O_QUERY SUBRECORDS:C108([Personas:7]Userfields:31;[Personas]Userfields'Value=$code)
									If (_O_Records in subselection:C7([Personas:7]Userfields:31)=0)
										_O_CREATE SUBRECORD:C72([Personas:7]Userfields:31)
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
								[Personas]Userfields'Value:=$code+$value
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
			End if 
		Else 
		End if 
	End for 
	  //20180404 RCH Ticket 203523
	C_TEXT:C284($t_camposObligatorios;$t_datosNoUnicos;$t_datoNoValido)
	C_BOOLEAN:C305($b_error)
	$b_error:=STR_ValidaCreacionRegistro ("Personas";->$t_camposObligatorios;->$t_datosNoUnicos;->$t_datoNoValido)
	
	If (Not:C34($b_error))
		Case of 
			: ($peopleType="[Madre]@")
				[Personas:7]Sexo:8:="F"
			: ($peopleType="[Padre]@")
				[Personas:7]Sexo:8:="M"
		End case 
		[Personas:7]Apellido_paterno:3:=ST_Format (->[Personas:7]Apellido_paterno:3)
		[Personas:7]Apellido_materno:4:=ST_Format (->[Personas:7]Apellido_materno:4)
		[Personas:7]Nombres:2:=ST_Format (->[Personas:7]Nombres:2)
		[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
		[Personas:7]Apellidos_y_nombres:30:=ST_Format (->[Personas:7]Apellidos_y_nombres:30)
		[Personas:7]Direccion_Profesional:23:=ST_Format (->[Personas:7]Direccion_Profesional:23)
		[Personas:7]Cargo:21:=ST_Format (->[Personas:7]Cargo:21)
		[Personas:7]Empresa:20:=ST_Format (->[Personas:7]Empresa:20)
		If (Record number:C243([Personas:7])=-3)
			SAVE RECORD:C53([Personas:7])
			APPEND TO ARRAY:C911(atIOstr_UUIDApdosN;[Personas:7]Auto_UUID:36)  //20171122 RCH
		Else 
			SAVE RECORD:C53([Personas:7])
			If ((Find in array:C230(atIOstr_UUIDApdosN;[Personas:7]Auto_UUID:36)=-1) & (Find in array:C230(atIOstr_UUIDApdosA;[Personas:7]Auto_UUID:36)=-1))
				APPEND TO ARRAY:C911(atIOstr_UUIDApdosA;[Personas:7]Auto_UUID:36)  //20171122 RCH
			End if 
			$logText:="Se actualizó el registro del padre o apoderado "+[Personas:7]Apellidos_y_nombres:30+"\r"
			SEND PACKET:C103(vh_logRef;ST_ConvertText ($logText))
		End if 
		Case of 
			: ($peopleType="[Madre]@")
				vl_MotherRecNum:=Record number:C243([Personas:7])
				If (([Alumnos:2]Apellido_materno:4="") & (vl_StudentRecNum>=0))
					[Alumnos:2]Apellido_materno:4:=[Personas:7]Apellido_materno:4
					SAVE RECORD:C53([Alumnos:2])
				End if 
			: ($peopleType="[Padre]@")
				vl_FatherRecNum:=Record number:C243([Personas:7])
			: ($peopleType="[Apoderado de cuenta]@")
				vl_apCuentasRecNum:=Record number:C243([Personas:7])
			: ($peopleType="[Apoderado académico]@")
				vl_apAcademicoRecNum:=Record number:C243([Personas:7])
		End case 
		
	Else 
		
		  // Modificado por: Alexis Bustamante (09-06-2017)
		C_TEXT:C284($t_people)
		Case of 
			: ($peopleType="[Madre]@")
				$t_people:="de la Madre"
				vl_MotherRecNum:=-1
				
			: ($peopleType="[Padre]@")
				$t_people:="del Padre"
				vl_FatherRecNum:=-1
				
			: ($peopleType="[Apoderado de cuenta]@")
				$t_people:="del Apoderado de cuenta"
				vl_apCuentasRecNum:=-1
				
			: ($peopleType="[Apoderado académico]@")
				$t_people:="del Apoderado  académico"
				vl_apAcademicoRecNum:=-1
		End case 
		
		Case of 
			: ($t_camposObligatorios#"")
				$logText:="Registro no importado ("+$t_people+") debido a que viene un dato obligatorio vacío ("+$t_camposObligatorios+").\r"
			: ($t_datosNoUnicos#"")
				$logText:="Registro no importado ("+$t_people+") ya que viene un dato que ya existe en la base de datos ("+$t_datosNoUnicos+").\r"
			: ($t_datoNoValido#"")
				$logText:="Registro no importado ("+$t_people+") ya que viene un dato no válido para un campo ("+$t_datoNoValido+")\r"
			Else 
				$logText:=""
		End case 
		
		SEND PACKET:C103(vh_logRef;ST_ConvertText ($logText))
	End if 
	
End if 

