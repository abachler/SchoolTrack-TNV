//%attributes = {}
  //IOstr_ProcessStudentRecord

C_LONGINT:C283($tableNum;$fieldNum;$l_id_cursos)
C_LONGINT:C283($tableNumber;$fieldNumber)
C_TEXT:C284($varName;$t_Identificador)
C_BOOLEAN:C305($b_continuar)
C_BOOLEAN:C305($b_conexionWeb)
$b_continuar:=True:C214

UFLD_LoadFileTplt (->[Alumnos:2])

Case of 
	: (Count parameters:C259=1)
		$b_conexionWeb:=$1
End case 

ARRAY POINTER:C280($aKeyFieldsPointers;0)
ARRAY TEXT:C222($aKeyFieldsValues;0)

If (Not:C34($b_conexionWeb))
	For ($i;1;Size of array:C274(aRecordFieldNames))
		If (aRecordFieldNames{$i}="[Alumno@")
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
					If ((Field:C253(->[Alumnos:2]RUT:5)=$fieldNum) & (Table:C252(->[Alumnos:2]RUT:5)=$tableNum))
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
			QUERY:C277([Alumnos:2]; & ;$aKeyFieldsPointers{$i}->;=;$aKeyFieldsValues{$i};*)
		End for 
		QUERY:C277([Alumnos:2])
		$records:=Records in selection:C76([Alumnos:2])
		$recNum:=Record number:C243([Alumnos:2])
		QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=[Alumnos:2]numero:1)
		If (Records in selection:C76([Alumnos_FichaMedica:13])=1)
			$recNumFichaMedica:=Record number:C243([Alumnos_FichaMedica:13])
		End if 
		
		If ($records>1)
			$b_continuar:=False:C215
		End if 
		
	Else 
		$records:=0
	End if 
	
Else 
	$l_posUUID:=Find in array:C230(aRecordFieldNames;"[Alumno]Auto_UUID")
	If ($l_posUUID#-1)
		If ((aRecordLine{aSourceDataElement{$l_posUUID}}#"") & (aSourceDataElement{$l_posUUID}>0))
			$pointer:=aRecordFieldPointers{$l_posUUID}
			INSERT IN ARRAY:C227($aKeyFieldsValues;Size of array:C274($aKeyFieldsValues)+1)
			INSERT IN ARRAY:C227($aKeyFieldsPointers;Size of array:C274($aKeyFieldsPointers)+1)
			$aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)}:=aRecordLine{aSourceDataElement{$l_posUUID}}
			$aKeyFieldsPointers{Size of array:C274($aKeyFieldsPointers)}:=$pointer
			$type:=Type:C295($pointer->)
		End if 
		QUERY:C277([Alumnos:2];[Alumnos:2]auto_uuid:72=$aKeyFieldsValues{Size of array:C274($aKeyFieldsValues)})
		$records:=Records in selection:C76([Alumnos:2])
		$recNum:=Record number:C243([Alumnos:2])
		  //If ($recNum#-1)//20171122 RCH
		$b_continuar:=True:C214
		  //Else 
		  //$b_continuar:=False
		  //End if 
		QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=[Alumnos:2]numero:1)
		If (Records in selection:C76([Alumnos_FichaMedica:13])=1)
			$recNumFichaMedica:=Record number:C243([Alumnos_FichaMedica:13])
		End if 
		
	Else 
		$b_continuar:=False:C215
	End if 
	
End if 

If ($b_continuar)
	
	If ($records=0)
		CREATE RECORD:C68([Alumnos:2])
		[Alumnos:2]numero:1:=SQ_SeqNumber (->[Alumnos:2]numero:1)
		[Alumnos:2]Fecha_de_Creacion:21:=Current date:C33
		CREATE RECORD:C68([Alumnos_FichaMedica:13])
		[Alumnos_FichaMedica:13]Alumno_Numero:1:=[Alumnos:2]numero:1
		[Alumnos_FichaMedica:13]OB_tratamiento:23:=OB_Create 
	Else 
		READ WRITE:C146([Alumnos:2])
		GOTO RECORD:C242([Alumnos:2];$recNum)
		READ WRITE:C146([Alumnos_FichaMedica:13])
		GOTO RECORD:C242([Alumnos_FichaMedica:13];$recNumFichaMedica)
	End if 
	
	For ($i;1;Size of array:C274(aRecordFieldNames))
		If (aRecordFieldNames{$i}="[Alumno@")
			If ((aRecordLine{aSourceDataElement{$i}}#"") & (aSourceDataElement{$i}>0))
				$pointer:=aRecordFieldPointers{$i}
				RESOLVE POINTER:C394($pointer;$varName;$tableNumber;$fieldNumber)
				$isCustomField:=False:C215
				If (Not:C34(Is nil pointer:C315($pointer)))
					$type:=Type:C295($pointer->)
				Else 
					$type:=-1
					$isCustomField:=True:C214
					$pointer:=->[Alumnos:2]
				End if 
				Case of 
					: ($tableNumber=Table:C252(->[Alumnos_FichaMedica:13]))
						Case of 
							: ($type=Is boolean:K8:9)
								$text:=aRecordLine{aSourceDataElement{$i}}
								If (($text="1") | ($text="Y") | ($text="S") | ($text="Si") | ($text="Yes") | ($text="Oui") | ($text="Verdadero") | ($text="True") | ($text="Vrai") | ($text="V"))
									$pointer->:=True:C214
								Else 
									$pointer->:=False:C215
								End if 
							: (($type=2) | ($type=24) | ($type=0))
								$pointer->:=aRecordLine{aSourceDataElement{$i}}
							: ($type=Is date:K8:7)
								$pointer->:=Date:C102(aRecordLine{aSourceDataElement{$i}})
							: (($type=Is real:K8:4) | ($type=Is integer:K8:5) | ($type=Is longint:K8:6))
								$pointer->:=Num:C11(aRecordLine{aSourceDataElement{$i}})
							: ($type=Is time:K8:8)
								$pointer->:=Time:C179(aRecordLine{aSourceDataElement{$i}})
						End case 
					Else 
						Case of 
							: ($isCustomField)
								$text:=aRecordLine{aSourceDataElement{$i}}
								$recordFieldName:=Substring:C12(aRecordFieldNames{$i};Position:C15("]";aRecordFieldNames{$i})+1)
								If ($text#"")
									$el:=Find in array:C230(aUFList;$recordFieldName)
									If ($el>0)
										$code:=String:C10(aUFID{$el};"00000")+"/"
										If (aUFMulti{$el})
											_O_CREATE SUBRECORD:C72([Alumnos:2]Userfields:54)
										Else 
											_O_QUERY SUBRECORDS:C108([Alumnos:2]Userfields:54;[Alumnos]Userfields'Value=($code+"@"))
											If (_O_Records in subselection:C7([Alumnos:2]Userfields:54)=0)
												_O_CREATE SUBRECORD:C72([Alumnos:2]Userfields:54)
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
										[Alumnos]Userfields'Value:=$code+$value
									End if 
								End if 
							: ($type=24)
								$pointer->:=aRecordLine{aSourceDataElement{$i}}
							: ($type=Is boolean:K8:9)
								$text:=aRecordLine{aSourceDataElement{$i}}
								If (($text="1") | ($text="Y") | ($text="S") | ($text="Si") | ($text="Yes") | ($text="Oui") | ($text="Verdadero") | ($text="True") | ($text="Vrai") | ($text="V"))
									$pointer->:=True:C214
								Else 
									$pointer->:=False:C215
								End if 
							: (($type=2) | ($type=24) | ($type=0))
								$pointer->:=aRecordLine{aSourceDataElement{$i}}
							: ($type=Is date:K8:7)
								$pointer->:=Date:C102(aRecordLine{aSourceDataElement{$i}})
							: (($type=Is real:K8:4) | ($type=Is integer:K8:5) | ($type=Is longint:K8:6))
								$pointer->:=Num:C11(aRecordLine{aSourceDataElement{$i}})
							: ($type=Is time:K8:8)
								$pointer->:=Time:C179(aRecordLine{aSourceDataElement{$i}})
						End case 
				End case 
				If (Picture size:C356(aRecordFieldKey{$i})>0)
					INSERT IN ARRAY:C227($aKeyFieldsPointers;Size of array:C274($aKeyFieldsPointers)+1)
					$aKeyFieldsPointers{Size of array:C274($aKeyFieldsPointers)}:=$pointer
				End if 
			End if 
		Else 
			$i:=Size of array:C274(aRecordFieldNames)+1
		End if 
	End for 
	
	[Alumnos:2]RUT:5:=Replace string:C233(Replace string:C233([Alumnos:2]RUT:5;".";"");"-";"")
	AL_ProcesaNombres (False:C215)
	
	If ([Alumnos:2]nivel_numero:29=0)
		[Alumnos:2]nivel_numero:29:=Nivel_AdmisionDirecta
	End if 
	If ([Alumnos:2]Nacionalidad:8="")  //MONO TICKET 213902
		[Alumnos:2]Nacionalidad:8:=LOC_GetNacionalidad 
	End if 
	
	C_TEXT:C284($t_camposObligatorios;$t_datosNoUnicos;$t_datoNoValido)
	$b_error:=STR_ValidaCreacionRegistro ("Alumnos";->$t_camposObligatorios;->$t_datosNoUnicos;->$t_datoNoValido)
	
	If (Not:C34($b_error))
		$l_item:=Find in array:C230(<>aStatus;[Alumnos:2]Status:50)
		If ($l_item<0)
			[Alumnos:2]Status:50:="Activo"
		Else 
			[Alumnos:2]Status:50:=<>aStatus{$l_item}
		End if 
		
		[Alumnos_FichaMedica:13]Alumno_Numero:1:=[Alumnos:2]numero:1
		If ($records=0)
			APPEND TO ARRAY:C911(atIOstr_UUIDAlumnosN;[Alumnos:2]auto_uuid:72)  //20171122 RCH
			$el:=Find in array:C230(<>al_NumeroNivelesActivos;[Alumnos:2]nivel_numero:29)
			If (($el>0) & ([Alumnos:2]curso:20=""))
				[Alumnos:2]curso:20:="A"
			End if 
			Case of 
				: ([Alumnos:2]nivel_numero:29=Nivel_AdmisionDirecta)
					If ([Alumnos:2]curso:20="")
						[Alumnos:2]curso:20:="Adm"+String:C10(<>gYear)
					End if 
					[Alumnos:2]Nivel_Nombre:34:="Admisión Directa"
					[Alumnos:2]Sección:26:="Admisión"
					
				: ([Alumnos:2]nivel_numero:29=Nivel_Egresados)
					If ([Alumnos:2]curso:20="")
						[Alumnos:2]curso:20:="EGR"
					End if 
					[Alumnos:2]Nivel_Nombre:34:="Egresados"
					[Alumnos:2]Sección:26:="Egresados"
					
				: ([Alumnos:2]nivel_numero:29=Nivel_Retirados)
					If ([Alumnos:2]curso:20="")
						[Alumnos:2]curso:20:="RET"
					End if 
					
					[Alumnos:2]Nivel_Nombre:34:="Retirados"
					[Alumnos:2]Sección:26:="Retirados"
					
				: (($el>0) & ([Alumnos:2]curso:20#""))
					[Alumnos:2]curso:20:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Abreviatura:19)+"-"+[Alumnos:2]curso:20
					[Alumnos:2]Nivel_Nombre:34:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Nivel:1)
					[Alumnos:2]Sección:26:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Sección:9)
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
					If (Records in selection:C76([Cursos:3])=0)
						CREATE RECORD:C68([Cursos:3])
						[Cursos:3]Curso:1:=[Alumnos:2]curso:20
						[Cursos:3]Ciclo:5:=[Alumnos:2]Sección:26
						[Cursos:3]Letra_del_curso:9:=Substring:C12([Alumnos:2]curso:20;Position:C15("-";[Alumnos:2]curso:20)+1)
						[Cursos:3]Nivel_Nombre:10:=[Alumnos:2]Nivel_Nombre:34
						[Cursos:3]Nivel_Numero:7:=[Alumnos:2]nivel_numero:29
						  //MONO TICKET 186373
						If ([Cursos:3]Curso:1="@-ADT")  //20171122 RCH
							[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6;True:C214)
						Else 
							[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6)
						End if 
						vi_newClasses:=vi_newClasses+1
					End if 
					SAVE RECORD:C53([Cursos:3])
				Else 
					If ([Alumnos:2]curso:20="")
						[Alumnos:2]curso:20:="Adm"+String:C10(<>gYear)
					End if 
					[Alumnos:2]nivel_numero:29:=Nivel_AdmisionDirecta
					[Alumnos:2]Nivel_Nombre:34:="Admisión"
			End case 
		Else 
			APPEND TO ARRAY:C911(atIOstr_UUIDAlumnosA;[Alumnos:2]auto_uuid:72)  //20171122 RCH
		End if 
		SAVE RECORD:C53([Alumnos_FichaMedica:13])
		
		[Alumnos:2]Fecha_de_modificacion:22:=Current date:C33
		[Alumnos:2]Modificado_por:23:="Importación"
		
		If (Not:C34(Is new record:C668([Alumnos:2])))
			[Alumnos:2]curso:20:=Old:C35([Alumnos:2]curso:20)
			[Alumnos:2]nivel_numero:29:=Old:C35([Alumnos:2]nivel_numero:29)
			[Alumnos:2]Nivel_Nombre:34:=Old:C35([Alumnos:2]Nivel_Nombre:34)
			[Alumnos:2]Sección:26:=Old:C35([Alumnos:2]Sección:26)
		End if 
		
		SAVE RECORD:C53([Alumnos:2])
		ADD TO SET:C119([Alumnos:2];"Importación")
		
		vl_StudentRecNum:=Record number:C243([Alumnos:2])
		  // Modificado por: Alexis Bustamante (09-06-2017)
		$logText:="Se importaron los datos de "+[Alumnos:2]apellidos_y_nombres:40+", RUT N° "+[Alumnos:2]RUT:5+""+"\r"
		REDUCE SELECTION:C351([Alumnos:2];0)
	Else 
		Case of 
			: ($t_camposObligatorios#"")
				$logText:="No se importaron registros (alumno "+[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4+" "+[Alumnos:2]Nombres:2+") ya que viene un dato obligatorio vacío: "+$t_camposObligatorios+"\r"
			: ($t_datosNoUnicos#"")
				$logText:="No se importaron registros (alumno "+[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4+" "+[Alumnos:2]Nombres:2+") ya que viene un dato que ya existe en la base de datos "+$t_datosNoUnicos+"\r"
			: ($t_datoNoValido#"")
				$logText:="No se importaron registros (alumno "+[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4+" "+[Alumnos:2]Nombres:2+") ya que viene un dato no válido para el campo "+$t_datoNoValido+"\r"
			Else 
				$logText:=""
		End case 
		vl_StudentRecNum:=-1
	End if 
	
End if 
SEND PACKET:C103(vH_logRef;$logText)
