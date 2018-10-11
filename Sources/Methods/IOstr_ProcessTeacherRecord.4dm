//%attributes = {}
  //IOstr_ProcessTeacherRecord

C_LONGINT:C283($tableNum;$fieldNum)

UFLD_LoadFileTplt (->[Profesores:4])

ARRAY POINTER:C280($aKeyFieldsPointers;0)
ARRAY TEXT:C222($aKeyFieldsValues;0)
For ($i;1;Size of array:C274(aRecordFieldNames))
	If (aRecordFieldNames{$i}="[Profesor]@")
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
				If ((Field:C253(->[Profesores:4]RUT:27)=$fieldNum) & (Table:C252(->[Profesores:4]RUT:27)=$tableNum))
					$aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)}:=Replace string:C233(Replace string:C233($aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)};".";"");"-";"")
				End if 
			End if 
		End if 
	Else 
		$i:=Size of array:C274(aRecordFieldNames)+1
	End if 
End for 

If (Size of array:C274($aKeyFieldsPointers)>0)
	For ($i;1;Size of array:C274($aKeyFieldsPointers))
		QUERY:C277([Profesores:4]; & ;$aKeyFieldsPointers{$i}->;=;$aKeyFieldsValues{$i};*)
	End for 
	QUERY:C277([Profesores:4])
	$records:=Records in selection:C76([Profesores:4])
	$recNum:=Record number:C243([Profesores:4])
Else 
	$records:=0
End if 


If ($records=0)
	CREATE RECORD:C68([Profesores:4])
	[Profesores:4]Numero:1:=SQ_SeqNumber (->[Profesores:4]Numero:1)
	[Profesores:4]_CreatedBy:47:="Importación"
	[Profesores:4]_ModifiedBy:48:="Importación"
Else 
	GOTO RECORD:C242([Profesores:4];$recNum)
	[Profesores:4]_ModifiedBy:48:="Importación"
End if 

For ($i;1;Size of array:C274(aRecordFieldNames))
	If (aRecordFieldNames{$i}="[Profesor]@")
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
							$code2:=$code+"@"
							If (aUFMulti{$el})
								_O_CREATE SUBRECORD:C72([Profesores:4]Userfields:31)
							Else 
								_O_QUERY SUBRECORDS:C108([Profesores:4]Userfields:31;[Profesores]Userfields'Value=$code2)
								If (_O_Records in subselection:C7([Profesores:4]Userfields:31)=0)
									_O_CREATE SUBRECORD:C72([Profesores:4]Userfields:31)
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
							[Profesores]Userfields'Value:=$code+$value
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
		$i:=Size of array:C274(aRecordFieldNames)+1
	End if 
End for 


If (([Profesores:4]Apellido_paterno:3#"") & ([Profesores:4]Nombres:2#""))
	[Profesores:4]Apellido_paterno:3:=ST_Format (->[Profesores:4]Apellido_paterno:3)
	[Profesores:4]Apellido_materno:4:=ST_Format (->[Profesores:4]Apellido_materno:4)
	[Profesores:4]Nombres:2:=ST_Format (->[Profesores:4]Nombres:2)
	[Profesores:4]Apellidos_y_nombres:28:=Replace string:C233([Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4+" "+[Profesores:4]Nombres:2;"  ";" ")
	[Profesores:4]Apellidos_y_nombres:28:=ST_Format (->[Profesores:4]Apellidos_y_nombres:28)
	[Profesores:4]Nombres_apellidos:40:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
	[Profesores:4]Nombres_apellidos:40:=ST_Format (->[Profesores:4]Nombres_apellidos:40)
	[Profesores:4]Iniciales:29:=ST_Uppercase (Substring:C12([Profesores:4]Nombres:2;1;1)+Substring:C12([Profesores:4]Apellido_paterno:3;1;1)+Substring:C12([Profesores:4]Apellido_materno:4;1;1))
	If (([Profesores:4]Nombre_comun:21="") & ([Profesores:4]Apellido_paterno:3#"") & ([Profesores:4]Nombres:2#""))
		[Profesores:4]Nombre_comun:21:=ST_GetWord ([Profesores:4]Nombres:2;1)+" "+[Profesores:4]Apellido_paterno:3
	End if 
	If (vt_subjects#"")
		vt_subjects:=Replace string:C233(vt_subjects;Char:C90(34);"")
		ARRAY TEXT:C222(aText2;0)
		AT_Text2Array (->aText2;vt_subjects)
		For ($i;1;Size of array:C274(aText2))
			_O_QUERY SUBRECORDS:C108([Profesores:4]Asignaturas:13;[Profesores]Asignaturas'Asignatura=aText2{$i})
			If (_O_Records in subselection:C7([Profesores:4]Asignaturas:13)=0)
				_O_CREATE SUBRECORD:C72([Profesores:4]Asignaturas:13)
				[Profesores]Asignaturas'Asignatura:=aText2{$i}
			End if 
		End for 
	End if 
	
	SAVE RECORD:C53([Profesores:4])
	ADD TO SET:C119([Profesores:4];"Importación")
	vl_TeacherRecNum:=Record number:C243([Profesores:4])
	vi_newTeachers:=vi_newTeachers+1  //20171124 RCH
Else 
	vl_TeacherRecNum:=-1
End if 

$logText:="Se actualizaron los datos de "+[Profesores:4]Apellidos_y_nombres:28+", RUT N° "+[Profesores:4]RUT:27+" ya existe. Los datos del alumno no fueron integrados."+"\r"
SEND PACKET:C103(vH_logRef;ST_ConvertText ($logText))
vl_TeacherRecNum:=Record number:C243([Profesores:4])
