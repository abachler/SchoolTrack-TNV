//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:31:35
  // ----------------------------------------------------
  // Método: STWA2_OWC_guardadatosfichasalud
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$tabla:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tabla"))
$rnalumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnalumno"))
$edicion:=(Find in array:C230($y_ParameterNames->;"id")#-1)
$tabla:=$tabla+1
$userID:=STWA2_Session_GetUserSTID ($uuid)
  //$jsonT:=JSON New
$ob_raiz:=OB_Create 
KRL_GotoRecord (->[Alumnos:2];$rnalumno;False:C215)
If ($tabla<7)
	Case of 
		: ($tabla=1)
			$enfermedad:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"enfermedad")
			$fecha:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"fecha")
			$obs:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"obs")
			If ($edicion)
				$id:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"id"))
				KRL_GotoRecord (->[Alumnos_FichaMedica_Enfermedade:224];$id;True:C214)
			Else 
				CREATE RECORD:C68([Alumnos_FichaMedica_Enfermedade:224])
				[Alumnos_FichaMedica_Enfermedade:224]id_alumno:3:=[Alumnos:2]numero:1
			End if 
			[Alumnos_FichaMedica_Enfermedade:224]fecha:6:=Date:C102($fecha)
			[Alumnos_FichaMedica_Enfermedade:224]Enfermedad:1:=$enfermedad
			[Alumnos_FichaMedica_Enfermedade:224]observacion:5:=$obs
			Log_RegisterEvtSTW ("Alumnos - Modificación Ficha Médica (enfermedades): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
			$errL:=KRL_SaveRecord (->[Alumnos_FichaMedica_Enfermedade:224])
			$rn:=Record number:C243([Alumnos_FichaMedica_Enfermedade:224])
			KRL_UnloadReadOnly (->[Alumnos_FichaMedica_Enfermedade:224])
		: ($tabla=2)
			$diagnostico:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"diagnostico")
			$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ad"))
			$md:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"md"))
			$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dd"))
			$ah:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ah"))
			$mh:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"mh"))
			$dh:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dh"))
			$desde:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
			$hasta:=DT_GetDateFromDayMonthYear ($dh;$mh;$ah)
			If ($edicion)
				$id:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"id"))
				KRL_GotoRecord (->[Alumnos_FichaMedica_Hospitaliza:222];$id;True:C214)
			Else 
				CREATE RECORD:C68([Alumnos_FichaMedica_Hospitaliza:222])
				[Alumnos_FichaMedica_Hospitaliza:222]Id_Alumno:5:=[Alumnos:2]numero:1
			End if 
			[Alumnos_FichaMedica_Hospitaliza:222]Fecha:1:=$desde
			[Alumnos_FichaMedica_Hospitaliza:222]Hasta:3:=$hasta
			[Alumnos_FichaMedica_Hospitaliza:222]Diagnóstico:2:=$diagnostico
			Log_RegisterEvtSTW ("Alumnos - Modificación Ficha Médica (hospitalizaciones): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
			$errL:=KRL_SaveRecord (->[Alumnos_FichaMedica_Hospitaliza:222])
			$rn:=Record number:C243([Alumnos_FichaMedica_Hospitaliza:222])
			KRL_UnloadReadOnly (->[Alumnos_FichaMedica_Hospitaliza:222])
		: ($tabla=3)
			$meses:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"meses")
			$separator:=Position:C15(".";$meses)
			If ($separator=0)
				$separator:=Position:C15(",";$meses)
				If ($separator=0)
					$separator:=Position:C15(" ";$meses)
					If ($separator=0)
						$separator:=Position:C15("-";$meses)
						If ($separator=0)
							$separator:=Position:C15("/";$meses)
						End if 
					End if 
				End if 
			End if 
			If ($separator>0)
				$years:=Num:C11(Substring:C12($meses;1;$separator-1))
				$months:=Num:C11(Substring:C12($meses;$separator+1))
				$months:=($years*12)+$months
			Else 
				$months:=Num:C11($meses)
			End if 
			$enfermedad:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"enfermedad")
			$vacunado:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"vacunado")
			If ($edicion)
				$id:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"id"))
				KRL_GotoRecord (->[Alumnos_Vacunas:101];$id;True:C214)
			Else 
				CREATE RECORD:C68([Alumnos_Vacunas:101])
				[Alumnos_Vacunas:101]Numero_Alumno:1:=[Alumnos:2]numero:1
			End if 
			[Alumnos_Vacunas:101]Edad:2:=DT_Months2AgeLongString ($months)
			[Alumnos_Vacunas:101]Enfermedad:3:=$enfermedad
			[Alumnos_Vacunas:101]Meses:4:=$months
			[Alumnos_Vacunas:101]Vacunado:5:=($vacunado="true")
			Log_RegisterEvtSTW ("Alumnos - Modificación Ficha Médica (vacunas): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
			  //$node:=JSON Append text ($jsonT;"edadvacuna";[Alumnos_Vacunas]Edad)
			OB_SET ($ob_raiz;->[Alumnos_Vacunas:101]Edad:2;"edadvacuna")
			$errL:=KRL_SaveRecord (->[Alumnos_Vacunas:101])
			$rn:=Record number:C243([Alumnos_Vacunas:101])
			KRL_UnloadReadOnly (->[Alumnos_Vacunas:101])
		: ($tabla=4)
			$alergia:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"alergia")
			$alergeno:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"alergeno")
			If ($edicion)
				$id:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"id"))
				KRL_GotoRecord (->[Alumnos_FichaMedica_Alergias:223];$id;True:C214)
			Else 
				CREATE RECORD:C68([Alumnos_FichaMedica_Alergias:223])
				[Alumnos_FichaMedica_Alergias:223]id_alumno:4:=[Alumnos:2]numero:1
			End if 
			[Alumnos_FichaMedica_Alergias:223]Tipo_alergia:1:=$alergia
			[Alumnos_FichaMedica_Alergias:223]Alergeno:2:=$alergeno
			Log_RegisterEvtSTW ("Alumnos - Modificación Ficha Médica (alergias): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
			$errL:=KRL_SaveRecord (->[Alumnos_FichaMedica_Alergias:223])
			$rn:=Record number:C243([Alumnos_FichaMedica_Alergias:223])
			KRL_UnloadReadOnly (->[Alumnos_FichaMedica_Alergias:223])
		: ($tabla=5)
			C_DATE:C307($d_fecha)
			$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ad"))
			$md:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"md"))
			$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dd"))
			$d_fecha:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
			$pesotxt:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"peso")
			$tallatxt:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"talla")
			$pesotxt:=Replace string:C233($pesotxt;",";<>tXS_RS_DecimalSeparator)
			$pesotxt:=Replace string:C233($pesotxt;".";<>tXS_RS_DecimalSeparator)
			$tallatxt:=Replace string:C233($tallatxt;",";<>tXS_RS_DecimalSeparator)
			$tallatxt:=Replace string:C233($tallatxt;".";<>tXS_RS_DecimalSeparator)
			$peso:=Num:C11($pesotxt)
			$talla:=Num:C11($tallatxt)
			If ($edicion)
				$id:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"id"))
				KRL_GotoRecord (->[Alumnos_ControlesMedicos:99];$id;True:C214)
			Else 
				CREATE RECORD:C68([Alumnos_ControlesMedicos:99])
				[Alumnos_ControlesMedicos:99]Numero_Alumno:1:=[Alumnos:2]numero:1
			End if 
			$edad:=DT_ReturnAgeLongString ([Alumnos:2]Fecha_de_nacimiento:7;$d_fecha)
			[Alumnos_ControlesMedicos:99]Edad:4:=$edad
			[Alumnos_ControlesMedicos:99]Fecha:2:=$d_fecha
			[Alumnos_ControlesMedicos:99]Peso_kg:6:=$peso
			[Alumnos_ControlesMedicos:99]Talla_cm:5:=$talla
			If (<>gYear=Year of:C25($d_fecha))
				$curso:=[Alumnos:2]curso:20
			Else 
				READ ONLY:C145([Alumnos_Historico:25])
				QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Año:2=(Year of:C25($d_fecha));*)
				QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1)
				$curso:=[Alumnos_Historico:25]Curso:3
			End if 
			[Alumnos_ControlesMedicos:99]Curso:3:=$curso
			If (($peso>0) & ($talla>0))
				$size2:=($talla/100)*($talla/100)
				$imc:=Round:C94($peso/$size2;1)
				$imctext:=String:C10($imc)
			Else 
				$imctext:=""
			End if 
			[Alumnos_ControlesMedicos:99]IMC:8:=$imctext
			Log_RegisterEvtSTW ("Alumnos - Modificación Ficha Médica (controles médicos): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
			
			OB_SET ($ob_raiz;->$imctext;"imc")
			OB_SET ($ob_raiz;->$curso;"curso")
			OB_SET ($ob_raiz;->$edad;"edad")
			
			$errL:=KRL_SaveRecord (->[Alumnos_ControlesMedicos:99])
			$rn:=Record number:C243([Alumnos_ControlesMedicos:99])
			KRL_UnloadReadOnly (->[Alumnos_ControlesMedicos:99])
			QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Numero_Alumno:1=[Alumnos:2]numero:1)
			ORDER BY:C49([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Fecha:2;<)
			FIRST RECORD:C50([Alumnos_ControlesMedicos:99])
			$imctext:=[Alumnos_ControlesMedicos:99]IMC:8
			KRL_FindAndLoadRecordByIndex (->[Alumnos_FichaMedica:13]Alumno_Numero:1;->[Alumnos:2]numero:1;True:C214)
			[Alumnos_FichaMedica:13]IndiceMasaCorporal:21:=$imctext
			SAVE RECORD:C53([Alumnos_FichaMedica:13])
			KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])
			
			OB_SET ($ob_raiz;->$imctext;"currentimc")
		: ($tabla=6)
			$year:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"year"))
			$aparato:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"aparato")
			$curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")  //ASM ticket 215722
			If ($edicion)
				$id:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"id"))
				KRL_GotoRecord (->[Alumnos_FichaMedica_Aparatos_pr:226];$id;True:C214)
			Else 
				CREATE RECORD:C68([Alumnos_FichaMedica_Aparatos_pr:226])
				[Alumnos_FichaMedica_Aparatos_pr:226]Id_alumno:6:=[Alumnos:2]numero:1
			End if 
			[Alumnos_FichaMedica_Aparatos_pr:226]Año:1:=$year
			[Alumnos_FichaMedica_Aparatos_pr:226]Aparato:2:=$aparato
			[Alumnos_FichaMedica_Aparatos_pr:226]Curso:3:=$curso
			If ($year=<>gYear)
				$curso:=[Alumnos:2]curso:20
				$nivel:=[Alumnos:2]nivel_numero:29
			Else 
				QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2=$year)
				If (Records in selection:C76([Alumnos_Historico:25])>0)
					$curso:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Historico:25]Nivel:11;->[xxSTR_Niveles:6]Nivel:1)
					$nivel:=[Alumnos_Historico:25]Nivel:11
				Else 
					$curso:=""
					$nivel:=0
				End if 
			End if 
			[Alumnos_FichaMedica_Aparatos_pr:226]Curso:3:=$curso
			[Alumnos_FichaMedica_Aparatos_pr:226]NoNivel:4:=$nivel
			Log_RegisterEvtSTW ("Alumnos - Modificación Ficha Médica (aparatos): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
			  //$node:=JSON Append text ($jsonT;"curso";$curso)
			OB_SET ($ob_raiz;->$curso;"curso")
			$errL:=KRL_SaveRecord (->[Alumnos_FichaMedica_Aparatos_pr:226])
			$rn:=Record number:C243([Alumnos_FichaMedica_Aparatos_pr:226])
			KRL_UnloadReadOnly (->[Alumnos_FichaMedica_Aparatos_pr:226])
	End case 
Else 
	Case of 
		: ($tabla=7)
			$id:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"id"))
			$mod:=(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"mod")="true")
			$nombre:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"nombre")
			$esp:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"esp")
			$tels:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tels")
			$email:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"email")
			If ($id=-1)
				CREATE RECORD:C68([STR_Medicos:89])
				[STR_Medicos:89]Nombres:1:=$nombre
				[STR_Medicos:89]Especialidad:2:=$esp
				[STR_Medicos:89]Telefono_movil:4:=$tels
				[STR_Medicos:89]eMail:5:=$email
				[STR_Medicos:89]ID:3:=SQ_SeqNumber (->[STR_Medicos:89]ID:3)
				SAVE RECORD:C53([STR_Medicos:89])
				$id:=[STR_Medicos:89]ID:3
			Else 
				If ($mod)
					If (KRL_FindAndLoadRecordByIndex (->[STR_Medicos:89]ID:3;->$id;True:C214)#-1)
						[STR_Medicos:89]Nombres:1:=$nombre
						[STR_Medicos:89]Especialidad:2:=$esp
						[STR_Medicos:89]Telefono_movil:4:=$tels
						[STR_Medicos:89]eMail:5:=$email
						SAVE RECORD:C53([STR_Medicos:89])
					End if 
				End if 
			End if 
			
			  //20140711  ASM  Ticket 134693
			  //Guardo la relación del profesor
			QUERY:C277([xxSTR_Link_AlumnosMedicos:237];[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3=[STR_Medicos:89]Auto_UUID:6;*)
			QUERY:C277([xxSTR_Link_AlumnosMedicos:237]; & ;[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2=[Alumnos:2]auto_uuid:72)
			If (Records in selection:C76([xxSTR_Link_AlumnosMedicos:237])=0)
				CREATE RECORD:C68([xxSTR_Link_AlumnosMedicos:237])
				[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3:=[STR_Medicos:89]Auto_UUID:6
				[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2:=[Alumnos:2]auto_uuid:72
				SAVE RECORD:C53([xxSTR_Link_AlumnosMedicos:237])
			End if 
			KRL_UnloadReadOnly (->[xxSTR_Link_AlumnosMedicos:237])
			KRL_UnloadReadOnly (->[STR_Medicos:89])
			Log_RegisterEvtSTW ("Alumnos - Modificación Ficha Médica (médicos): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
			$errL:=1
			$rn:=$id
		: ($tabla=8)
			$nombre:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"nombre")
			$rel:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rel")
			$tels:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tels")
			ARRAY TEXT:C222(aNombreContacto;0)
			ARRAY TEXT:C222(aTelContacto;0)
			ARRAY TEXT:C222(aRelacionContacto;0)
			$ref:="contactos.ALU."+String:C10([Alumnos:2]numero:1)
			$rn:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$ref)
			If ($rn#-1)
				READ WRITE:C146([XShell_FatObjects:86])
				GOTO RECORD:C242([XShell_FatObjects:86];$rn)
				BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
			Else 
				CREATE RECORD:C68([XShell_FatObjects:86])
				[XShell_FatObjects:86]FatObjectName:1:=$ref
				BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
				SAVE RECORD:C53([XShell_FatObjects:86])
			End if 
			If ($edicion)
				$nombreold:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"nombreold")
				$relold:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"relold")
				$telsold:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"telsold")
				aNombreContacto{0}:=$nombreold
				aRelacionContacto{0}:=$relold
				aTelContacto{0}:=$telsold
				ARRAY LONGINT:C221($DA_Return;0)
				AT_MultiArraySearch (True:C214;->$DA_Return;->aNombreContacto;->aRelacionContacto;->aTelContacto)
				If (Size of array:C274($DA_Return)=1)
					$idx:=$DA_Return{1}
					aNombreContacto{$idx}:=$nombre
					aRelacionContacto{$idx}:=$rel
					aTelContacto{$idx}:=$tels
				End if 
			Else 
				APPEND TO ARRAY:C911(aNombreContacto;$nombre)
				APPEND TO ARRAY:C911(aRelacionContacto;$rel)
				APPEND TO ARRAY:C911(aTelContacto;$tels)
			End if 
			BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
			SAVE RECORD:C53([XShell_FatObjects:86])
			KRL_UnloadReadOnly (->[XShell_FatObjects:86])
			Log_RegisterEvtSTW ("Alumnos - Modificación Ficha Médica (contactos): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
			$errL:=1
	End case 
End if 
OB_SET_Text ($ob_raiz;String:C10($errL);"resultado")
OB_SET ($ob_raiz;->$rn;"recnum")
$json:=OB_Object2Json ($ob_raiz)

$0:=$json
