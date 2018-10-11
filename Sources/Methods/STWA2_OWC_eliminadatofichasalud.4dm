//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:32:07
  // ----------------------------------------------------
  // Método: STWA2_OWC_eliminadatofichasalud
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
$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
$tabla:=$tabla+1
$userID:=STWA2_Session_GetUserSTID ($uuid)
ARRAY POINTER:C280($tables;6)
$tables{0}:=->[Alumnos_EventosEnfermeria:14]
$tables{1}:=->[Alumnos_FichaMedica_Enfermedade:224]
$tables{2}:=->[Alumnos_FichaMedica_Hospitaliza:222]
$tables{3}:=->[Alumnos_Vacunas:101]
$tables{4}:=->[Alumnos_FichaMedica_Alergias:223]
$tables{5}:=->[Alumnos_ControlesMedicos:99]
$tables{6}:=->[Alumnos_FichaMedica_Aparatos_pr:226]
  //$jsonT:=JSON New 
$ob_raiz:=OB_Create 

If ($tabla<7)
	KRL_GotoRecord ($tables{$tabla};$rn;False:C215)
	Case of 
		: ($tabla=0)
			$nombreAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;->[Alumnos:2]apellidos_y_nombres:40)
			$cursoAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;->[Alumnos:2]curso:20)
			Log_RegisterEvtSTW ("Alumnos - Eliminación en Ficha Médica (visitas enfermería): "+$nombreAl+", "+$cursoAl;$userID)
		: ($tabla=1)
			$nombreAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_FichaMedica_Enfermedade:224]id_alumno:3;->[Alumnos:2]apellidos_y_nombres:40)
			$cursoAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_FichaMedica_Enfermedade:224]id_alumno:3;->[Alumnos:2]curso:20)
			Log_RegisterEvtSTW ("Alumnos - Eliminación en Ficha Médica (enfermedades): "+$nombreAl+", "+$cursoAl;$userID)
		: ($tabla=2)
			$nombreAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_FichaMedica_Hospitaliza:222]Id_Alumno:5;->[Alumnos:2]apellidos_y_nombres:40)
			$cursoAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_FichaMedica_Hospitaliza:222]Id_Alumno:5;->[Alumnos:2]curso:20)
			Log_RegisterEvtSTW ("Alumnos - Eliminación en Ficha Médica (hospitalizaciones): "+$nombreAl+", "+$cursoAl;$userID)
		: ($tabla=3)
			$nombreAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Vacunas:101]Numero_Alumno:1;->[Alumnos:2]apellidos_y_nombres:40)
			$cursoAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Vacunas:101]Numero_Alumno:1;->[Alumnos:2]curso:20)
			Log_RegisterEvtSTW ("Alumnos - Eliminación en Ficha Médica (vacunas): "+$nombreAl+", "+$cursoAl;$userID)
		: ($tabla=4)
			$nombreAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_FichaMedica_Alergias:223]id_alumno:4;->[Alumnos:2]apellidos_y_nombres:40)
			$cursoAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_FichaMedica_Alergias:223]id_alumno:4;->[Alumnos:2]curso:20)
			Log_RegisterEvtSTW ("Alumnos - Eliminación en Ficha Médica (alergias): "+$nombreAl+", "+$cursoAl;$userID)
		: ($tabla=5)
			$nombreAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_ControlesMedicos:99]Numero_Alumno:1;->[Alumnos:2]apellidos_y_nombres:40)
			$cursoAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_ControlesMedicos:99]Numero_Alumno:1;->[Alumnos:2]curso:20)
			Log_RegisterEvtSTW ("Alumnos - Eliminación en Ficha Médica (controles médicos): "+$nombreAl+", "+$cursoAl;$userID)
			$idAlumno:=[Alumnos_ControlesMedicos:99]Numero_Alumno:1
		: ($tabla=6)
			$nombreAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_FichaMedica_Aparatos_pr:226]Id_alumno:6;->[Alumnos:2]apellidos_y_nombres:40)
			$cursoAl:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_FichaMedica_Aparatos_pr:226]Id_alumno:6;->[Alumnos:2]curso:20)
			Log_RegisterEvtSTW ("Alumnos - Eliminación en Ficha Médica (aparatos): "+$nombreAl+", "+$cursoAl;$userID)
	End case 
	$errL:=KRL_DeleteRecord ($tables{$tabla};$rn)
	If ($tabla=5)  //CONTROLES
		READ ONLY:C145([Alumnos_ControlesMedicos:99])
		QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Numero_Alumno:1=$idAlumno)
		ORDER BY:C49([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Fecha:2;<)
		FIRST RECORD:C50([Alumnos_ControlesMedicos:99])
		$imctext:=[Alumnos_ControlesMedicos:99]IMC:8
		KRL_FindAndLoadRecordByIndex (->[Alumnos_FichaMedica:13]Alumno_Numero:1;->$idAlumno;True:C214)
		[Alumnos_FichaMedica:13]IndiceMasaCorporal:21:=$imctext
		SAVE RECORD:C53([Alumnos_FichaMedica:13])
		KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])
		  //$node:=JSON Append text ($jsonT;"currentimc";$imctext)
		OB_SET ($ob_raiz;->$imctext;"currentimc")
	End if 
Else 
	Case of 
		: ($tabla=7)
			$rnalumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ida"))
			KRL_GotoRecord (->[Alumnos:2];$rnalumno;False:C215)
			  //20140711  ASM  Ticket 134693
			$errL:=0
			QUERY:C277([STR_Medicos:89];[STR_Medicos:89]ID:3=$rn)
			If (Records in selection:C76([STR_Medicos:89])>0)
				QUERY:C277([xxSTR_Link_AlumnosMedicos:237];[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3=[STR_Medicos:89]Auto_UUID:6)
				$errL:=KRL_DeleteRecord (->[xxSTR_Link_AlumnosMedicos:237])
			End if 
			
		: ($tabla=8)
			TRACE:C157
			$rnalumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ida"))
			KRL_GotoRecord (->[Alumnos:2];$rnalumno;False:C215)
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
			aNombreContacto{0}:=$nombre
			aRelacionContacto{0}:=$rel
			aTelContacto{0}:=$tels
			ARRAY LONGINT:C221($DA_Return;0)
			AT_MultiArraySearch (True:C214;->$DA_Return;->aNombreContacto;->aRelacionContacto;->aTelContacto)
			If (Size of array:C274($DA_Return)>0)
				For ($i;Size of array:C274($DA_Return);1;-1)
					AT_Delete ($DA_Return{$i};1;->aNombreContacto;->aRelacionContacto;->aTelContacto)
				End for 
				Log_RegisterEvtSTW ("Alumnos - Eliminación en Ficha Médica (contactos): "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
			End if 
			BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
			SAVE RECORD:C53([XShell_FatObjects:86])
			KRL_UnloadReadOnly (->[XShell_FatObjects:86])
			$errL:=1
			
		: ($tabla=9)  //Agrego la tabla 9 para tratamientos.
			C_TEXT:C284($t_texto)
			$t_texto:=String:C10($rn)+".tratID"
			READ WRITE:C146([Alumnos_FichaMedica:13])
			QUERY BY ATTRIBUTE:C1331([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]OB_tratamiento:23;$t_texto;=;$rn)
			OB REMOVE:C1226([Alumnos_FichaMedica:13]OB_tratamiento:23;String:C10($rn))
			SAVE RECORD:C53([Alumnos_FichaMedica:13])
			KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])
			$errL:=1
	End case 
End if 
OB_SET_Text ($ob_raiz;String:C10($errL);"resultado")
$json:=OB_Object2Json ($ob_raiz)
  //$node:=JSON Append text ($jsonT;"resultado";String($errL))
  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
$0:=$json
