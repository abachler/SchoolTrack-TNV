//%attributes = {}
  //ADTweb_ProcessPostulations

C_TEXT:C284($0)
C_TEXT:C284($1;$dataList;$dato)
C_LONGINT:C283($el;$i)

$dataList:=$1

If ($dataList#"")
	START TRANSACTION:C239
	
	STR_ReadGlobals 
	NIV_LoadArrays 
	$0:=""
	
	C_BOOLEAN:C305($continuar)  //20130107 ASM Para validación del RUT
	$continuar:=True:C214
	
	ARRAY TEXT:C222($aFormData;0)
	ARRAY TEXT:C222($aLabels;0)
	ARRAY TEXT:C222($aValues;0)
	
	AT_Text2Array (->$aFormData;$dataList;"\r")
	
	ARRAY TEXT:C222($aLabels;Size of array:C274($aFormData))
	ARRAY TEXT:C222($aValues;Size of array:C274($aFormData))
	For ($i;1;Size of array:C274($aFormData))
		$aLabels{$i}:=ST_GetWord ($aFormData{$i};1;"=")
		$aValues{$i}:=ST_GetWord ($aFormData{$i};2;"=")
	End for 
	
	
	ARRAY TEXT:C222(atADT_NivName;0)
	ARRAY LONGINT:C221(aiADT_NivNo;0)
	READ ONLY:C145([xxSTR_Niveles:6])
	QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesAdmissionTrack)
	
	ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
	SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;atADT_NivName;[xxSTR_Niveles:6]NoNivel:5;aiADT_NivNo)
	
	$rut:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]RUT:5)))
	$pasaporteCand:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]NoPasaporte:87)))
	$rut:=Replace string:C233($rut;".";"")
	$rut:=Replace string:C233($rut;"-";"")
	
	$tableNum:=Table:C252(->[Personas:7])
	$NombrePadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Nombres:2);"[Padre]"))
	$ApellidoPPadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Apellido_paterno:3);"[Padre]"))
	$ApellidoMPadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Apellido_materno:4);"[Padre]"))
	$rutPadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]RUT:6);"[Padre]"))
	$pasaportePadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Pasaporte:59);"[Padre]"))
	
	$NombreMadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Nombres:2);"[Madre]"))
	$ApellidoPMadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Apellido_paterno:3);"[Madre]"))
	$ApellidoMMadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Apellido_materno:4);"[Madre]"))
	$rutMadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]RUT:6);"[Madre]"))
	$pasaporteMadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Pasaporte:59);"[Madre]"))
	
	$NombreApdo:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Nombres:2);"[Apoderado]"))
	$ApellidoPApdo:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Apellido_paterno:3);"[Apoderado]"))
	$ApellidoMApdo:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Apellido_materno:4);"[Apoderado]"))
	$rutApdo:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]RUT:6);"[Apoderado]"))
	$pasaporteApdo:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Pasaporte:59);"[Apoderado]"))
	
	  //20120627 ASM. Agrego datos para importación.
	C_BOOLEAN:C305($ExAlumnoPadre;$EsApoCuentasPadre;$EsApoAcademicoPadre;$ExAlumnoMadre;$EsApoCuentasMadre;$EsApoAcademicoMadre;$ExAlumnoApdo;$EsApoCuentasApdo;$EsApoAcademicoApdo)
	C_BOOLEAN:C305($FamMatrimonioCivil;$FamMatrimonioReligioso)
	C_LONGINT:C283($aluPostula)
	C_TEXT:C284($aluNombreNivel)
	
	  //Padre
	ST_Text2Anything (->$ExAlumnoPadre;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Es_ExAlumno:12);"[Padre]")))
	ST_Text2Anything (->$EsApoCuentasPadre;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]ES_Apoderado_de_Cuentas:42);"[Padre]")))
	ST_Text2Anything (->$EsApoAcademicoPadre;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Es_Apoderado_Academico:41);"[Padre]")))
	$EmailPadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]eMail:34);"[Padre]"))
	$EstudiosPadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Nivel_de_estudios:11);"[Padre]"))
	
	  //Madre
	ST_Text2Anything (->$ExAlumnoMadre;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Es_ExAlumno:12);"[Madre]")))
	ST_Text2Anything (->$EsApoCuentasMadre;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]ES_Apoderado_de_Cuentas:42);"[Madre]")))
	ST_Text2Anything (->$EsApoAcademicoMadre;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Es_Apoderado_Academico:41);"[Madre]")))
	$EmailMadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]eMail:34);"[Madre]"))
	$EstudiosMadre:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Nivel_de_estudios:11);"[Madre]"))
	
	  //Apoderado
	ST_Text2Anything (->$ExAlumnoApdo;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Es_ExAlumno:12);"[Apoderado]")))
	ST_Text2Anything (->$EsApoCuentasApdo;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]ES_Apoderado_de_Cuentas:42);"[Apoderado]")))
	ST_Text2Anything (->$EsApoAcademicoApdo;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Es_Apoderado_Academico:41);"[Apoderado]")))
	$EmailApdo:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]eMail:34);"[Apoderado]"))
	$EstudiosApdo:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Nivel_de_estudios:11);"[Apoderado]"))
	
	  //datos de la familia
	$FamDireccion:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Familia:78]);Field:C253(->[Familia:78]Dirección:7)))
	$FamComuna:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Familia:78]);Field:C253(->[Familia:78]Comuna:8)))
	$FamSitFamiliar:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Familia:78]);Field:C253(->[Familia:78]Sit_Familiar:11)))
	$FamTelefono:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Familia:78]);Field:C253(->[Familia:78]Telefono:10)))
	$FamRegion:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Familia:78]);Field:C253(->[Familia:78]Region_o_estado:34)))
	ST_Text2Anything (->$FamMatrimonioCivil;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Familia:78]);Field:C253(->[Familia:78]Matrimonio_Civil:36))))
	ST_Text2Anything (->$FamMatrimonioReligioso;NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Familia:78]);Field:C253(->[Familia:78]Matrimonio_Religioso:38))))
	
	  //postula a
	$aluPostula:=Num:C11(NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[ADT_Candidatos:49]);Field:C253(->[ADT_Candidatos:49]Postula_a:6))))
	$aluNombreNivel:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$aluPostula;->[xxSTR_Niveles:6]Nivel:1)
	
	
	
	$rutPadre:=Replace string:C233($rutPadre;".";"")
	$rutPadre:=Replace string:C233($rutPadre;"-";"")
	$rutMadre:=Replace string:C233($rutMadre;".";"")
	$rutMadre:=Replace string:C233($rutMadre;"-";"")
	$rutApdo:=Replace string:C233($rutApdo;".";"")
	$rutApdo:=Replace string:C233($rutApdo;"-";"")
	
	  //20120107 ASMvalidacion del RUT
	If (((CTRY_CL_VerifRUT ($rutPadre;False:C215)="") & ($pasaportePadre="")) | ((CTRY_CL_VerifRUT ($rutMadre;False:C215)="") & ($pasaporteMadre="")) | ((CTRY_CL_VerifRUT ($rut;False:C215)="") & ($pasaporteCand="")))
		$continuar:=False:C215
	Else 
		  //20140123 RCH El rut del apdo no es obligatorio
		  //If ((CTRY_CL_VerifRUT ($rutApdo;False)="") & ($pasaporteApdo=""))
		  //$continuar:=False
		  //End if 
		If ($rutApdo#"")
			$continuar:=Choose:C955(CTRY_CL_VerifRUT ($rutApdo;False:C215)="";False:C215;True:C214)
		End if 
	End if 
	
	If ((($ApellidoPPadre#"") & ($ApellidoPMadre#"")) & ($continuar))
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ADT_Candidatos:49])
		Case of 
			: ($rut#"")
				QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=$rut)
			: ($pasaporteCand#"")
				QUERY:C277([Alumnos:2];[Alumnos:2]NoPasaporte:87=$pasaporteCand)
		End case 
		
		If (Records in selection:C76([Alumnos:2])=0)
			CREATE RECORD:C68([ADT_Candidatos:49])
			CREATE RECORD:C68([Alumnos:2])
			[Alumnos:2]numero:1:=SQ_SeqNumber (->[Alumnos:2]numero:1)
			[Alumnos:2]Fecha_de_Creacion:21:=Current date:C33(*)
			[Alumnos:2]Fecha_de_modificacion:22:=Current date:C33(*)
			[Alumnos:2]Modificado_por:23:=""
			[Alumnos:2]nivel_numero:29:=Nivel_AdmissionTrack
			[Alumnos:2]Nivel_Nombre:34:="AdmissionTrack"
			[Alumnos:2]curso:20:="POST"
			[Alumnos:2]Nacionalidad:8:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Nacionalidad:8)))
			[Alumnos:2]RUT:5:=$rut
			[Alumnos:2]NoPasaporte:87:=$pasaporteCand
			[Alumnos:2]Nombres:2:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Nombres:2)))
			[Alumnos:2]Apellido_paterno:3:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Apellido_paterno:3)))
			[Alumnos:2]Apellido_materno:4:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Apellido_materno:4)))
			[Alumnos:2]Sexo:49:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Sexo:49)))
			[Alumnos:2]Religion:9:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Religion:9)))
			[Alumnos:2]Fecha_de_nacimiento:7:=Date:C102(NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]Fecha_de_nacimiento:7))))
			AL_ProcesaNombres 
			
			
			  //Color ex alumno
			$el:=Find in array:C230($aLabels;"Color_ex_alumno_1")
			If ($el#-1)
				$dato:=$aValues{$el}
				If (Find in array:C230(<>aColor;$dato)#-1)
					[ADT_Candidatos:49]Grupo:21:=$dato
					[Alumnos:2]Grupo:11:=$dato
				End if 
			End if 
			
			
			  //Conexiones
			ARRAY TEXT:C222($aLabelsCopy;0)
			ARRAY TEXT:C222($aValuesCopy;0)
			ARRAY TEXT:C222($at_conexiones;0)
			COPY ARRAY:C226($aLabels;$aLabelsCopy)
			COPY ARRAY:C226($aValues;$aValuesCopy)
			$el:=0
			While ($el#-1)
				$el:=Find in array:C230($aLabelsCopy;"@Parentesco@")
				If ($el#-1)
					APPEND TO ARRAY:C911($at_conexiones;$aValuesCopy{$el})
					DELETE FROM ARRAY:C228($aLabelsCopy;$el)
					DELETE FROM ARRAY:C228($aValuesCopy;$el)
				End if 
			End while 
			
			For ($i;1;Size of array:C274($at_conexiones))
				$el:=Find in array:C230(<>at_connectionsType;$at_conexiones{$i})
				If ($el#-1)
					  //CREATE SUBRECORD([Alumnos]Conexiones)
					  //[Alumnos]Conexiones'Conexion:=<>at_connectionsType{$el}
					  //If (<>at_connectionsType{$el}="Hermano de ex alumno")
					  //[Alumnos]Hermano_ex_alumno:=True
					  //End if 
					  //SAVE RECORD([Alumnos])
					
					  //MONO CONEXIONES
					CREATE RECORD:C68([Alumnos_Conexiones:212])
					[Alumnos_Conexiones:212]Conexion:1:=<>at_connectionsType{$el}
					If (<>at_connectionsType{$el}="Hermano de ex alumno")
						[Alumnos:2]Hermano_ex_alumno:65:=True:C214
					End if 
					[Alumnos_Conexiones:212]Alumno_AutoUUID:7:=[Alumnos:2]auto_uuid:72
					SAVE RECORD:C53([Alumnos_Conexiones:212])
					KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
				End if 
			End for 
			
			
			[ADT_Candidatos:49]Candidato_numero:1:=[Alumnos:2]numero:1
			[ADT_Candidatos:49]Fecha_de_Inscripción:2:=Current date:C33(*)
			[ADT_Candidatos:49]Inscriptor:3:="web"
			[ADT_Candidatos:49]Postula_a:6:=$aluPostula
			[ADT_Candidatos:49]Postula_a_Nombre:41:=$aluNombreNivel
			[ADT_Candidatos:49]RUT:46:=$rut
			If ([ADT_Candidatos:49]Postula_a_Nombre:41#"")
				$niv:=Find in array:C230(atADT_NivName;[ADT_Candidatos:49]Postula_a_Nombre:41)
				If ($niv#-1)
					[ADT_Candidatos:49]Postula_a:6:=aiADT_NivNo{$niv}
				Else 
					[ADT_Candidatos:49]Postula_a:6:=aiADT_NivNo{1}
					[ADT_Candidatos:49]Postula_a_Nombre:41:=atADT_NivName{1}
				End if 
			Else 
				[ADT_Candidatos:49]Postula_a:6:=aiADT_NivNo{1}
				[ADT_Candidatos:49]Postula_a_Nombre:41:=atADT_NivName{1}
			End if 
			[ADT_Candidatos:49]Idioma_Evaluacion:45:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[ADT_Candidatos:49]);Field:C253(->[ADT_Candidatos:49]Idioma_Evaluacion:45)))
			[ADT_Candidatos:49]Postulante:43:=(NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[ADT_Candidatos:49]);Field:C253(->[ADT_Candidatos:49]Postulante:43)))="1")
			[ADT_Candidatos:49]Como_Llego_al_Colegio:47:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[ADT_Candidatos:49]);Field:C253(->[ADT_Candidatos:49]Como_Llego_al_Colegio:47)))
			[ADT_Candidatos:49]Por_que_Eligio_Colegio:48:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef (Table:C252(->[ADT_Candidatos:49]);Field:C253(->[ADT_Candidatos:49]Por_que_Eligio_Colegio:48)))
			SAVE RECORD:C53([Alumnos:2])
			SAVE RECORD:C53([ADT_Candidatos:49])
			$idCandidato:=[ADT_Candidatos:49]Candidato_numero:1
			$rnCandidato:=Record number:C243([ADT_Candidatos:49])
			$rnAlumno:=Record number:C243([Alumnos:2])
			
			Case of 
				: ($rutPadre#"")
					$rnPadre:=Find in field:C653([Personas:7]RUT:6;$rutPadre)
				: ($pasaportePadre#"")
					$rnPadre:=Find in field:C653([Personas:7]Pasaporte:59;$pasaportePadre)
			End case 
			
			Case of 
				: ($rutMadre#"")
					$rnMadre:=Find in field:C653([Personas:7]RUT:6;$rutMadre)
				: ($pasaporteMadre#"")
					$rnMadre:=Find in field:C653([Personas:7]Pasaporte:59;$pasaporteMadre)
			End case 
			
			C_BOOLEAN:C305($crearApdo)
			If (($NombreApdo#"") & ($ApellidoPApdo#"") & (($rutApdo#"") | ($pasaporteApdo#"")))
				$crearApdo:=True:C214
			End if 
			
			$tagEducAntCol:=ADTcdd_FindMetaDataDef (Table:C252(->[STR_EducacionAnterior:87]);Field:C253(->[STR_EducacionAnterior:87]Nombre_Colegio:1))
			$tagEducAntNivel:=ADTcdd_FindMetaDataDef (Table:C252(->[STR_EducacionAnterior:87]);Field:C253(->[STR_EducacionAnterior:87]Nivel:3))
			$tagEducAntPais:=ADTcdd_FindMetaDataDef (Table:C252(->[STR_EducacionAnterior:87]);Field:C253(->[STR_EducacionAnterior:87]País:2))
			$tagEducAntAño:=ADTcdd_FindMetaDataDef (Table:C252(->[STR_EducacionAnterior:87]);Field:C253(->[STR_EducacionAnterior:87]Año:4))
			
			$aLabels{0}:=$tagEducAntCol
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$aLabels;">>";->$DA_Return)
			COPY ARRAY:C226($DA_Return;$aPosNombre)
			$aLabels{0}:=$tagEducAntNivel
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$aLabels;">>";->$DA_Return)
			COPY ARRAY:C226($DA_Return;$aPosNivel)
			$aLabels{0}:=$tagEducAntPais
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$aLabels;">>";->$DA_Return)
			COPY ARRAY:C226($DA_Return;$aPosPais)
			$aLabels{0}:=$tagEducAntAño
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$aLabels;">>";->$DA_Return)
			COPY ARRAY:C226($DA_Return;$aPosAño)
			$recs:=Size of array:C274($DA_Return)
			For ($i;1;$recs)
				$valueEducAntCol:=NV_GetValueFromTextArray (->$aFormData;$aLabels{$aPosNombre{$i}})
				$valueEducAntNivel:=NV_GetValueFromTextArray (->$aFormData;$aLabels{$aPosNivel{$i}})
				$valueEducAntPais:=NV_GetValueFromTextArray (->$aFormData;$aLabels{$aPosPais{$i}})
				$valueEducAntAño:=NV_GetValueFromTextArray (->$aFormData;$aLabels{$aPosAño{$i}})
				If (($valueEducAntCol#"") & ($valueEducAntNivel#"") & ($valueEducAntPais#"") & ($valueEducAntAño#""))
					CREATE RECORD:C68([STR_EducacionAnterior:87])
					[STR_EducacionAnterior:87]ID_Alumno:5:=[ADT_Candidatos:49]Candidato_numero:1
					[STR_EducacionAnterior:87]Tipo_Persona:8:="al"
					[STR_EducacionAnterior:87]Nombre_Colegio:1:=$valueEducAntCol
					[STR_EducacionAnterior:87]Nivel:3:=$valueEducAntNivel
					[STR_EducacionAnterior:87]País:2:=$valueEducAntPais
					[STR_EducacionAnterior:87]Año:4:=Num:C11($valueEducAntAño)
					SAVE RECORD:C53([STR_EducacionAnterior:87])
				End if 
			End for 
			KRL_UnloadReadOnly (->[STR_EducacionAnterior:87])
			
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([Familia:78])
			READ ONLY:C145([Familia_RelacionesFamiliares:77])
			Case of 
				: (($rnPadre#-1) & ($rnMadre#-1))
					KRL_GotoRecord (->[Personas:7];$rnPadre)
					$nombreFlia:=[Personas:7]Apellido_paterno:3
					KRL_GotoRecord (->[Personas:7];$rnMadre)
					$nombreFlia:=$nombreFlia+" "+[Personas:7]Apellido_paterno:3
					QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3=$nombreFlia)
					ARRAY LONGINT:C221($aIDsFlias;0)
					SELECTION TO ARRAY:C260([Familia:78]Numero:1;$aIDsFlias)
					$idFlia:=-1
					For ($i;1;Size of array:C274($aIDsFlias))
						QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=$aIDsFlias{$i})
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
						CREATE SET:C116([Personas:7];"rels")
						QUERY SELECTION:C341([Personas:7];[Personas:7]RUT:6=$rutPadre)
						$estaPadre:=(Records in selection:C76([Personas:7])=1)
						USE SET:C118("rels")
						QUERY SELECTION:C341([Personas:7];[Personas:7]RUT:6=$rutMadre)
						$estaMadre:=(Records in selection:C76([Personas:7])=1)
						If (($estaPadre) & ($estaMadre))
							$idFlia:=$aIDsFlias{$i}
							$i:=Size of array:C274($aIDsFlias)+1
						End if 
						CLEAR SET:C117("rels")
					End for 
					If ($idFlia#-1)
						  //encontramos la familia. Hay que poner al candidato en esta familia
						KRL_GotoRecord (->[Alumnos:2];$rnAlumno;True:C214)
						KRL_GotoRecord (->[ADT_Candidatos:49];$rnCandidato;True:C214)
						[Alumnos:2]Familia_Número:24:=$idFlia
						[ADT_Candidatos:49]Familia_numero:30:=$idFlia
						SAVE RECORD:C53([Alumnos:2])
						SAVE RECORD:C53([ADT_Candidatos:49])
						If (Not:C34($crearApdo))
							KRL_GotoRecord (->[Personas:7];$rnPadre;False:C215)
							$idPadre:=[Personas:7]No:1
							READ WRITE:C146([Familia_RelacionesFamiliares:77])
							QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=$idFlia;*)
							QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3=$idPadre)
							[Familia_RelacionesFamiliares:77]Apoderado:5:=3
							SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
							KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
							[Alumnos:2]Apoderado_académico_Número:27:=[Personas:7]No:1
							[Alumnos:2]Apoderado_Cuentas_Número:28:=[Personas:7]No:1
							SAVE RECORD:C53([Alumnos:2])
						End if 
					Else 
						  //no encontramos la familia. Hay que crear familia nueva y poner papa, mama y candidato
						KRL_GotoRecord (->[Personas:7];$rnPadre;False:C215)
						$idPadre:=[Personas:7]No:1
						KRL_GotoRecord (->[Personas:7];$rnMadre;False:C215)
						$idMadre:=[Personas:7]No:1
						CREATE RECORD:C68([Familia:78])
						[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
						[Familia:78]Nombre_de_la_familia:3:=$nombreFlia
						[Familia:78]Es_Postulante:18:=True:C214
						[Familia:78]Madre_Número:6:=$idMadre
						[Familia:78]Padre_Número:5:=$idPadre
						[Familia:78]Dirección:7:=$FamDireccion
						[Familia:78]Comuna:8:=$FamComuna
						[Familia:78]Sit_Familiar:11:=$FamSitFamiliar
						[Familia:78]Telefono:10:=$FamTelefono
						[Familia:78]Region_o_estado:34:=$FamRegion
						[Familia:78]Matrimonio_Civil:36:=$FamMatrimonioCivil
						[Familia:78]Matrimonio_Religioso:38:=$FamMatrimonioReligioso
						SAVE RECORD:C53([Familia:78])
						
						KRL_GotoRecord (->[Alumnos:2];$rnAlumno;True:C214)
						KRL_GotoRecord (->[ADT_Candidatos:49];$rnCandidato;True:C214)
						[Alumnos:2]Familia_Número:24:=$idFlia
						[ADT_Candidatos:49]Familia_numero:30:=$idFlia
						SAVE RECORD:C53([Alumnos:2])
						SAVE RECORD:C53([ADT_Candidatos:49])
						
						CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
						[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
						[Familia_RelacionesFamiliares:77]ID_Persona:3:=$idPadre
						[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
						[Familia_RelacionesFamiliares:77]Parentesco:6:=__ ("Padre")
						If (Not:C34($crearApdo))
							[Familia_RelacionesFamiliares:77]Apoderado:5:=3
							[Alumnos:2]Apoderado_académico_Número:27:=[Personas:7]No:1
							[Alumnos:2]Apoderado_Cuentas_Número:28:=[Personas:7]No:1
							SAVE RECORD:C53([Alumnos:2])
						End if 
						SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
						CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
						[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
						[Familia_RelacionesFamiliares:77]ID_Persona:3:=$idMadre
						[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
						[Familia_RelacionesFamiliares:77]Parentesco:6:=__ ("Madre")
						SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					End if 
				: (($rnPadre#-1) & ($rnMadre=-1))
					  //crear registro de madre y crear familia. Poner en nueva familia padre, madre y candidato
					CREATE RECORD:C68([Personas:7])
					[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
					$idMadre:=[Personas:7]No:1
					[Personas:7]Sexo:8:="F"
					[Personas:7]Nombres:2:=$NombreMadre
					[Personas:7]Apellido_paterno:3:=$ApellidoPMadre
					[Personas:7]Apellido_materno:4:=$ApellidoMMadre
					[Personas:7]RUT:6:=$rutMadre
					[Personas:7]Pasaporte:59:=$pasaporteMadre
					[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
					[Personas:7]Apellidos_y_nombres:30:=ST_Format (->[Personas:7]Apellidos_y_nombres:30)
					[Personas:7]Es_ExAlumno:12:=$ExAlumnoMadre
					[Personas:7]Es_Apoderado_Academico:41:=$EsApoAcademicoMadre
					[Personas:7]ES_Apoderado_de_Cuentas:42:=$EsApoCuentasMadre
					[Personas:7]eMail:34:=$EmailMadre
					[Personas:7]Nivel_de_estudios:11:=$EstudiosMadre
					SAVE RECORD:C53([Personas:7])
					
					If ([Personas:7]Es_ExAlumno:12=True:C214)
						If ([Personas:7]RUT:6#"")
							QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=[Personas:7]RUT:6)
						End if 
						If (Records in selection:C76([Alumnos:2])=1)
							[Personas:7]ID_ExAlumno:87:=[Alumnos:2]numero:1
						Else 
							[Personas:7]ID_ExAlumno:87:=0
							[Personas:7]Es_ExAlumno:12:=False:C215
						End if 
					End if 
					
					$rnMadre:=Record number:C243([Personas:7])
					
					$idMadre:=[Personas:7]No:1
					KRL_GotoRecord (->[Personas:7];$rnPadre;False:C215)
					$idPadre:=[Personas:7]No:1
					$nombreFlia:=KRL_GetTextFieldData (->[Personas:7]No:1;->$idPadre;->[Personas:7]Apellido_paterno:3)+" "+KRL_GetTextFieldData (->[Personas:7]No:1;->$idMadre;->[Personas:7]Apellido_paterno:3)  //MONO: correción 
					
					CREATE RECORD:C68([Familia:78])
					[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
					[Familia:78]Nombre_de_la_familia:3:=$nombreFlia
					[Familia:78]Es_Postulante:18:=True:C214
					[Familia:78]Madre_Número:6:=$idMadre
					[Familia:78]Padre_Número:5:=$idPadre
					[Familia:78]Dirección:7:=$FamDireccion
					[Familia:78]Comuna:8:=$FamComuna
					[Familia:78]Sit_Familiar:11:=$FamSitFamiliar
					[Familia:78]Telefono:10:=$FamTelefono
					[Familia:78]Region_o_estado:34:=$FamRegion
					[Familia:78]Matrimonio_Civil:36:=$FamMatrimonioCivil
					[Familia:78]Matrimonio_Religioso:38:=$FamMatrimonioReligioso
					SAVE RECORD:C53([Familia:78])
					
					$idFlia:=[Familia:78]Numero:1  //MONO: correción 
					
					CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
					[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
					[Familia_RelacionesFamiliares:77]ID_Persona:3:=$idPadre
					[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
					[Familia_RelacionesFamiliares:77]Parentesco:6:=__ ("Padre")
					If (Not:C34($crearApdo))
						[Familia_RelacionesFamiliares:77]Apoderado:5:=3
						[Alumnos:2]Apoderado_académico_Número:27:=[Personas:7]No:1
						[Alumnos:2]Apoderado_Cuentas_Número:28:=[Personas:7]No:1
						SAVE RECORD:C53([Alumnos:2])
					End if 
					SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
					[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
					[Familia_RelacionesFamiliares:77]ID_Persona:3:=$idMadre
					[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
					[Familia_RelacionesFamiliares:77]Parentesco:6:=__ ("Madre")
					SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					
					KRL_GotoRecord (->[Alumnos:2];$rnAlumno;True:C214)
					KRL_GotoRecord (->[ADT_Candidatos:49];$rnCandidato;True:C214)
					[Alumnos:2]Familia_Número:24:=$idFlia
					[ADT_Candidatos:49]Familia_numero:30:=$idFlia
					SAVE RECORD:C53([Alumnos:2])
					SAVE RECORD:C53([ADT_Candidatos:49])
				: (($rnPadre=-1) & ($rnMadre#-1))
					  //crear registro de padre y crear familia. Poner en nueva familia padre, madre y candidato
					CREATE RECORD:C68([Personas:7])
					[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
					$idPadre:=[Personas:7]No:1
					[Personas:7]Sexo:8:="M"
					[Personas:7]Nombres:2:=$NombrePadre
					[Personas:7]Apellido_paterno:3:=$ApellidoPPadre
					[Personas:7]Apellido_materno:4:=$ApellidoMPadre
					[Personas:7]RUT:6:=$rutPadre
					[Personas:7]Pasaporte:59:=$pasaportePadre
					[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
					[Personas:7]Apellidos_y_nombres:30:=ST_Format (->[Personas:7]Apellidos_y_nombres:30)
					[Personas:7]Es_ExAlumno:12:=$ExAlumnoMadre
					[Personas:7]Es_Apoderado_Academico:41:=$EsApoAcademicoPadre
					[Personas:7]ES_Apoderado_de_Cuentas:42:=$EsApoCuentasPadre
					[Personas:7]eMail:34:=$EmailPadre
					[Personas:7]Nivel_de_estudios:11:=$EstudiosPadre
					SAVE RECORD:C53([Personas:7])
					
					If ([Personas:7]Es_ExAlumno:12=True:C214)
						If ([Personas:7]RUT:6#"")
							QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=[Personas:7]RUT:6)
						End if 
						If (Records in selection:C76([Alumnos:2])=1)
							[Personas:7]ID_ExAlumno:87:=[Alumnos:2]numero:1
						Else 
							[Personas:7]ID_ExAlumno:87:=0
							[Personas:7]Es_ExAlumno:12:=False:C215
						End if 
					End if 
					
					$rnPadre:=Record number:C243([Personas:7])
					
					$idPadre:=[Personas:7]No:1
					KRL_GotoRecord (->[Personas:7];$rnMadre;False:C215)
					$idMadre:=[Personas:7]No:1
					$nombreFlia:=KRL_GetTextFieldData (->[Personas:7]No:1;->$idPadre;->[Personas:7]Apellido_paterno:3)+" "+KRL_GetTextFieldData (->[Personas:7]No:1;->$idMadre;->[Personas:7]Apellido_paterno:3)  //MONO: correción 
					CREATE RECORD:C68([Familia:78])
					[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
					[Familia:78]Nombre_de_la_familia:3:=$nombreFlia
					[Familia:78]Es_Postulante:18:=True:C214
					[Familia:78]Madre_Número:6:=$idMadre
					[Familia:78]Padre_Número:5:=$idPadre
					[Familia:78]Dirección:7:=$FamDireccion
					[Familia:78]Comuna:8:=$FamComuna
					[Familia:78]Sit_Familiar:11:=$FamSitFamiliar
					[Familia:78]Telefono:10:=$FamTelefono
					[Familia:78]Region_o_estado:34:=$FamRegion
					[Familia:78]Matrimonio_Civil:36:=$FamMatrimonioCivil
					[Familia:78]Matrimonio_Religioso:38:=$FamMatrimonioReligioso
					SAVE RECORD:C53([Familia:78])
					$idFlia:=[Familia:78]Numero:1  //MONO: correción 
					
					CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
					[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
					[Familia_RelacionesFamiliares:77]ID_Persona:3:=$idPadre
					[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
					[Familia_RelacionesFamiliares:77]Parentesco:6:=__ ("Padre")
					If (Not:C34($crearApdo))
						[Familia_RelacionesFamiliares:77]Apoderado:5:=3
						[Alumnos:2]Apoderado_académico_Número:27:=[Personas:7]No:1
						[Alumnos:2]Apoderado_Cuentas_Número:28:=[Personas:7]No:1
						SAVE RECORD:C53([Alumnos:2])
					End if 
					SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
					[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
					[Familia_RelacionesFamiliares:77]ID_Persona:3:=$idMadre
					[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
					[Familia_RelacionesFamiliares:77]Parentesco:6:=__ ("Madre")
					SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					
					KRL_GotoRecord (->[Alumnos:2];$rnAlumno;True:C214)
					KRL_GotoRecord (->[ADT_Candidatos:49];$rnCandidato;True:C214)
					[Alumnos:2]Familia_Número:24:=$idFlia
					[ADT_Candidatos:49]Familia_numero:30:=$idFlia
					SAVE RECORD:C53([Alumnos:2])
					SAVE RECORD:C53([ADT_Candidatos:49])
				: (($rnPadre=-1) & ($rnMadre=-1))
					  //crear padre, madre, familia. POner en nueva familia padre, madre y candidato
					CREATE RECORD:C68([Familia:78])
					[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
					[Familia:78]Nombre_de_la_familia:3:=[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4
					[Familia:78]Es_Postulante:18:=True:C214
					[Familia:78]Madre_Número:6:=SQ_SeqNumber (->[Personas:7]No:1)
					[Familia:78]Padre_Número:5:=SQ_SeqNumber (->[Personas:7]No:1)
					[Familia:78]Dirección:7:=$FamDireccion
					[Familia:78]Comuna:8:=$FamComuna
					[Familia:78]Sit_Familiar:11:=$FamSitFamiliar
					[Familia:78]Telefono:10:=$FamTelefono
					[Familia:78]Region_o_estado:34:=$FamRegion
					[Familia:78]Matrimonio_Civil:36:=$FamMatrimonioCivil
					[Familia:78]Matrimonio_Religioso:38:=$FamMatrimonioReligioso
					SAVE RECORD:C53([Familia:78])
					
					KRL_GotoRecord (->[Alumnos:2];$rnAlumno;True:C214)
					KRL_GotoRecord (->[ADT_Candidatos:49];$rnCandidato;True:C214)
					[Alumnos:2]Familia_Número:24:=[Familia:78]Numero:1
					[ADT_Candidatos:49]Familia_numero:30:=[Familia:78]Numero:1
					SAVE RECORD:C53([Alumnos:2])
					SAVE RECORD:C53([ADT_Candidatos:49])
					
					  //creating father record
					
					CREATE RECORD:C68([Personas:7])
					[Personas:7]No:1:=[Familia:78]Padre_Número:5
					[Personas:7]Sexo:8:="M"
					[Personas:7]Nombres:2:=$NombrePadre
					[Personas:7]Apellido_paterno:3:=$ApellidoPPadre
					[Personas:7]Apellido_materno:4:=$ApellidoMPadre
					[Personas:7]RUT:6:=$rutPadre
					[Personas:7]Pasaporte:59:=$pasaportePadre
					[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
					[Personas:7]Apellidos_y_nombres:30:=ST_Format (->[Personas:7]Apellidos_y_nombres:30)
					[Personas:7]Es_ExAlumno:12:=$ExAlumnoPadre
					[Personas:7]Es_Apoderado_Academico:41:=$EsApoAcademicoPadre
					[Personas:7]ES_Apoderado_de_Cuentas:42:=$EsApoCuentasPadre
					[Personas:7]eMail:34:=$EmailPadre
					[Personas:7]Nivel_de_estudios:11:=$EstudiosPadre
					SAVE RECORD:C53([Personas:7])
					$rnPadre:=Record number:C243([Personas:7])
					CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
					[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
					[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
					[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
					[Familia_RelacionesFamiliares:77]Parentesco:6:=__ ("Padre")
					
					If (Not:C34($crearApdo))
						[Familia_RelacionesFamiliares:77]Apoderado:5:=3
						[Alumnos:2]Apoderado_académico_Número:27:=[Personas:7]No:1
						[Alumnos:2]Apoderado_Cuentas_Número:28:=[Personas:7]No:1
						SAVE RECORD:C53([Alumnos:2])
					End if 
					SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
					SAVE RECORD:C53([Familia:78])
					
					  //creating mother record
					CREATE RECORD:C68([Personas:7])
					[Personas:7]No:1:=[Familia:78]Madre_Número:6
					[Personas:7]Sexo:8:="F"
					[Personas:7]Nombres:2:=$NombreMadre
					[Personas:7]Apellido_paterno:3:=$ApellidoPMadre
					[Personas:7]Apellido_materno:4:=$ApellidoMMadre
					[Personas:7]RUT:6:=$rutMadre
					[Personas:7]Pasaporte:59:=$pasaporteMadre
					[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
					[Personas:7]Apellidos_y_nombres:30:=ST_Format (->[Personas:7]Apellidos_y_nombres:30)
					[Personas:7]Es_ExAlumno:12:=$ExAlumnoMadre
					[Personas:7]Es_Apoderado_Academico:41:=$EsApoAcademicoMadre
					[Personas:7]ES_Apoderado_de_Cuentas:42:=$EsApoCuentasMadre
					[Personas:7]eMail:34:=$EmailMadre
					[Personas:7]Nivel_de_estudios:11:=$EstudiosMadre
					SAVE RECORD:C53([Personas:7])
					
					
					If ([Personas:7]Es_ExAlumno:12=True:C214)
						If ([Personas:7]RUT:6#"")
							QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=[Personas:7]RUT:6)
						End if 
						If (Records in selection:C76([Alumnos:2])=1)
							[Personas:7]ID_ExAlumno:87:=[Alumnos:2]numero:1
						Else 
							[Personas:7]ID_ExAlumno:87:=0
							[Personas:7]Es_ExAlumno:12:=False:C215
						End if 
					End if 
					
					$rnMadre:=Record number:C243([Personas:7])
					CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
					[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
					[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
					[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
					[Familia_RelacionesFamiliares:77]Parentesco:6:=__ ("Madre")
					SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
					SAVE RECORD:C53([Familia:78])
			End case 
			
			$rnApdo:=-1
			If ($crearApdo)
				$rnApdo:=Find in field:C653([Personas:7]RUT:6;$rutApdo)
				KRL_GotoRecord (->[Alumnos:2];$rnAlumno;True:C214)
				If ($rnApdo#-1)
					  //ya existe la persona. Ponerla en la familia
					KRL_GotoRecord (->[Personas:7];$rnApdo;False:C215)
					READ WRITE:C146([Familia_RelacionesFamiliares:77])
					QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
					QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
					If (Records in selection:C76([Familia_RelacionesFamiliares:77])=1)
						[Familia_RelacionesFamiliares:77]Apoderado:5:=3
						SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					Else 
						CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
						[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
						[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
						[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=0
						[Familia_RelacionesFamiliares:77]Apoderado:5:=3
						SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					End if 
					[Alumnos:2]Apoderado_académico_Número:27:=[Personas:7]No:1
					[Alumnos:2]Apoderado_Cuentas_Número:28:=[Personas:7]No:1
					SAVE RECORD:C53([Alumnos:2])
				Else 
					  //crear la persona y ponerla en la familia
					If (($rutApdo#"") | ($ApellidoPApdo#""))
						CREATE RECORD:C68([Personas:7])
						[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
						[Personas:7]Sexo:8:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Sexo:8);"[Apoderado]"))
						[Personas:7]Nombres:2:=$NombreApdo
						[Personas:7]Apellido_paterno:3:=$ApellidoPApdo
						[Personas:7]Apellido_materno:4:=$ApellidoMApdo
						[Personas:7]RUT:6:=$rutApdo
						[Personas:7]Pasaporte:59:=$pasaporteApdo
						[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
						[Personas:7]Apellidos_y_nombres:30:=ST_Format (->[Personas:7]Apellidos_y_nombres:30)
						[Personas:7]Es_ExAlumno:12:=$ExAlumnoApdo
						[Personas:7]Es_Apoderado_Academico:41:=$EsApoAcademicoApdo
						[Personas:7]ES_Apoderado_de_Cuentas:42:=$EsApoCuentasApdo
						[Personas:7]eMail:34:=$EmailApdo
						[Personas:7]Nivel_de_estudios:11:=$EstudiosApdo
						SAVE RECORD:C53([Personas:7])
						
						
						If ([Personas:7]Es_ExAlumno:12=True:C214)
							If ([Personas:7]RUT:6#"")
								QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=[Personas:7]RUT:6)
							End if 
							If (Records in selection:C76([Alumnos:2])=1)
								[Personas:7]ID_ExAlumno:87:=[Alumnos:2]numero:1
							Else 
								[Personas:7]ID_ExAlumno:87:=0
								[Personas:7]Es_ExAlumno:12:=False:C215
							End if 
						End if 
						
						$rnApdo:=Record number:C243([Personas:7])
						CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
						[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
						[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
						[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=0
						[Familia_RelacionesFamiliares:77]Apoderado:5:=3
						SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
						[Alumnos:2]Apoderado_académico_Número:27:=[Personas:7]No:1
						[Alumnos:2]Apoderado_Cuentas_Número:28:=[Personas:7]No:1
						SAVE RECORD:C53([Alumnos:2])
					End if 
				End if 
			End if 
			
			$RecNumAlumno:=Record number:C243([Alumnos:2])
			
			
			$tableNum:=Table:C252(->[Personas:7])
			If ($rnPadre#-1)
				KRL_GotoRecord (->[Personas:7];$rnPadre;True:C214)
				[Personas:7]Fecha_de_nacimiento:5:=Date:C102(NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Fecha_de_nacimiento:5);"[Padre]")))
				[Personas:7]Nacionalidad:7:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Nacionalidad:7);"[Padre]"))
				[Personas:7]Estado_civil:10:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Estado_civil:10);"[Padre]"))
				[Personas:7]Es_ExAlumno:12:=(NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Es_ExAlumno:12);"[Padre]"))="Si")
				[Personas:7]Profesion:13:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Profesion:13);"[Padre]"))
				[Personas:7]Direccion:14:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Direccion:14);"[Padre]"))
				[Personas:7]Comuna:16:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Comuna:16);"[Padre]"))
				[Personas:7]Telefono_domicilio:19:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Telefono_domicilio:19);"[Padre]"))
				[Personas:7]Empresa:20:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Empresa:20);"[Padre]"))
				[Personas:7]Cargo:21:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Cargo:21);"[Padre]"))
				[Personas:7]Direccion_Profesional:23:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Direccion_Profesional:23);"[Padre]"))
				[Personas:7]Celular:24:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Celular:24);"[Padre]"))
				[Personas:7]Telefono_profesional:29:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Telefono_profesional:29);"[Padre]"))
				SAVE RECORD:C53([Personas:7])
				KRL_UnloadReadOnly (->[Personas:7])
			End if 
			If ($rnMadre#-1)
				KRL_GotoRecord (->[Personas:7];$rnMadre;True:C214)
				[Personas:7]Fecha_de_nacimiento:5:=Date:C102(NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Fecha_de_nacimiento:5);"[Madre]")))
				[Personas:7]Nacionalidad:7:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Nacionalidad:7);"[Madre]"))
				[Personas:7]Estado_civil:10:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Estado_civil:10);"[Madre]"))
				[Personas:7]Es_ExAlumno:12:=(NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Es_ExAlumno:12);"[Madre]"))="Si")
				[Personas:7]Profesion:13:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Profesion:13);"[Madre]"))
				[Personas:7]Direccion:14:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Direccion:14);"[Madre]"))
				[Personas:7]Comuna:16:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Comuna:16);"[Madre]"))
				[Personas:7]Telefono_domicilio:19:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Telefono_domicilio:19);"[Madre]"))
				[Personas:7]Empresa:20:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Empresa:20);"[Madre]"))
				[Personas:7]Cargo:21:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Cargo:21);"[Madre]"))
				[Personas:7]Direccion_Profesional:23:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Direccion_Profesional:23);"[Madre]"))
				[Personas:7]Celular:24:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Celular:24);"[Madre]"))
				[Personas:7]Telefono_profesional:29:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Telefono_profesional:29);"[Madre]"))
				SAVE RECORD:C53([Personas:7])
				KRL_UnloadReadOnly (->[Personas:7])
			End if 
			If ($rnApdo#-1)
				KRL_GotoRecord (->[Personas:7];$rnApdo;True:C214)
				[Personas:7]Fecha_de_nacimiento:5:=Date:C102(NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Fecha_de_nacimiento:5);"[Apoderado]")))
				[Personas:7]Nacionalidad:7:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Nacionalidad:7);"[Apoderado]"))
				[Personas:7]Estado_civil:10:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Estado_civil:10);"[Apoderado]"))
				[Personas:7]Es_ExAlumno:12:=(NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Es_ExAlumno:12);"[Apoderado]"))="Si")
				[Personas:7]Profesion:13:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Profesion:13);"[Apoderado]"))
				[Personas:7]Direccion:14:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Direccion:14);"[Apoderado]"))
				[Personas:7]Comuna:16:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Comuna:16);"[Apoderado]"))
				[Personas:7]Telefono_domicilio:19:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Telefono_domicilio:19);"[Apoderado]"))
				[Personas:7]Empresa:20:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Empresa:20);"[Apoderado]"))
				[Personas:7]Cargo:21:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Cargo:21);"[Apoderado]"))
				[Personas:7]Direccion_Profesional:23:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Direccion_Profesional:23);"[Apoderado]"))
				[Personas:7]Celular:24:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Celular:24);"[Apoderado]"))
				[Personas:7]Telefono_profesional:29:=NV_GetValueFromTextArray (->$aFormData;ADTcdd_FindMetaDataDef ($tableNum;Field:C253(->[Personas:7]Telefono_profesional:29);"[Apoderado]"))
				SAVE RECORD:C53([Personas:7])
				KRL_UnloadReadOnly (->[Personas:7])
			End if 
			
			  //asignar apoderado de cuentas y academico al alumno
			GOTO RECORD:C242([Alumnos:2];$RecNumAlumno)
			KRL_ReloadInReadWriteMode (->[Alumnos:2])
			Case of 
				: ($EsApoAcademicoApdo)
					$id_persona:=KRL_GetNumericFieldData (->[Personas:7]RUT:6;->$rutApdo;->[Personas:7]No:1)
					[Alumnos:2]Apoderado_académico_Número:27:=$id_persona
				: ($EsApoAcademicoMadre)
					$id_persona:=KRL_GetNumericFieldData (->[Personas:7]RUT:6;->$rutMadre;->[Personas:7]No:1)
					[Alumnos:2]Apoderado_académico_Número:27:=$id_persona
				: ($EsApoAcademicoPadre)
					$id_persona:=KRL_GetNumericFieldData (->[Personas:7]RUT:6;->$rutPadre;->[Personas:7]No:1)
					[Alumnos:2]Apoderado_académico_Número:27:=$id_persona
			End case 
			Case of 
				: ($EsApoCuentasApdo)
					$id_persona:=KRL_GetNumericFieldData (->[Personas:7]RUT:6;->$rutApdo;->[Personas:7]No:1)
					[Alumnos:2]Apoderado_Cuentas_Número:28:=$id_persona
				: ($EsApoCuentasMadre)
					$id_persona:=KRL_GetNumericFieldData (->[Personas:7]RUT:6;->$rutMadre;->[Personas:7]No:1)
					[Alumnos:2]Apoderado_Cuentas_Número:28:=$id_persona
				: ($EsApoCuentasPadre)
					$id_persona:=KRL_GetNumericFieldData (->[Personas:7]RUT:6;->$rutPadre;->[Personas:7]No:1)
					[Alumnos:2]Apoderado_Cuentas_Número:28:=$id_persona
			End case 
			SAVE RECORD:C53([Alumnos:2])
			
			If ($rnCandidato#-1)
				READ ONLY:C145([xxADT_MetaDataDefinition:79])
				QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Category:4#1)
				FIRST RECORD:C50([xxADT_MetaDataDefinition:79])
				While (Not:C34(End selection:C36([xxADT_MetaDataDefinition:79])))
					$value:=NV_GetValueFromTextArray (->$aFormData;[xxADT_MetaDataDefinition:79]Tag:5)
					If ($value#"")
						CREATE RECORD:C68([xxADT_MetaDataValues:80])
						[xxADT_MetaDataValues:80]ID:3:=SQ_SeqNumber (->[xxADT_MetaDataValues:80]ID:3)
						[xxADT_MetaDataValues:80]ID_Candidato:4:=$idCandidato
						[xxADT_MetaDataValues:80]ID_Definition:1:=[xxADT_MetaDataDefinition:79]ID:1
						[xxADT_MetaDataValues:80]Value:2:=$value
						SAVE RECORD:C53([xxADT_MetaDataValues:80])
					End if 
					NEXT RECORD:C51([xxADT_MetaDataDefinition:79])
				End while 
			End if 
			KRL_UnloadReadOnly (->[Alumnos:2])
			KRL_UnloadReadOnly (->[ADT_Candidatos:49])
			KRL_UnloadReadOnly (->[Personas:7])
			KRL_UnloadReadOnly (->[Familia:78])
			KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
		Else 
			$0:="Alumno ya existe. Operación abortada."
		End if 
	Else 
		If (Not:C34($continuar))
			$0:="Faltan datos esenciales del padre y/o la madre. Rut invalido. Operación abortada."
		Else 
			$0:="Faltan datos esenciales del padre y/o la madre. Operación abortada."
		End if 
	End if 
	If ($0#"")
		CANCEL TRANSACTION:C241
	Else 
		VALIDATE TRANSACTION:C240
	End if 
Else 
	$0:="No hay datos para procesar. Operación abortada."
End if 
