//%attributes = {}

AL_UpdateArrays (xALP_ObjxAlu;0)
ALP_RemoveAllArrays (xALP_ObjxAlu)
EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)

Case of 
	: (vlSTR_PeriodoObservaciones>Size of array:C274(atSTR_Periodos_nombre))
		$realFieldPointer:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]Final_objetivos:105
	: ((vlSTR_PeriodoSeleccionado=1) | (vlSTR_PeriodoSeleccionado=0))
		$realFieldPointer:=->[Alumnos_Calificaciones:208]P01_Final_Real:112
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]P01_Final_Literal:116
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]P01_Objetivos:100
	: (vlSTR_PeriodoSeleccionado=2)
		$realFieldPointer:=->[Alumnos_Calificaciones:208]P02_Final_Real:187
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]P02_Final_Literal:191
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]P02_Objetivos:101
	: (vlSTR_PeriodoSeleccionado=3)
		$realFieldPointer:=->[Alumnos_Calificaciones:208]P03_Final_Real:262
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]P03_Final_Literal:266
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]P03_Objetivos:102
	: (vlSTR_PeriodoSeleccionado=4)
		$realFieldPointer:=->[Alumnos_Calificaciones:208]P04_Final_Real:337
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]P04_Final_Literal:341
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]P04_Objetivos:103
	: (vlSTR_PeriodoSeleccionado=5)
		$realFieldPointer:=->[Alumnos_Calificaciones:208]P05_Final_Real:412
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]P05_Final_Literal:416
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]P05_Objetivos:104
End case 

READ ONLY:C145([Alumnos_Calificaciones:208])

If (bc_MostrarFotografías=1)
	$pID:=IT_UThermometer (1;0;__ ("Procesando fotografías..."))
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	ARRAY PICTURE:C279(aFotografias;0)
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]Fotografía:78;aFotografias;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;$realFieldPointer->;aRealNtaF;$stringFieldPointer->;aNtaF;[Alumnos:2]Status:50;aNtaStatus;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;aNtaRegEximicion;$objPtr->;aNtaObj)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	For ($i;1;Size of array:C274(aFotografias))
		PICTURE PROPERTIES:C457(aFotografias{$i};$width;$height)
		Case of 
			: (($height>60) & ($height>$width))
				$percent:=60/$height
				aFotografias{$i}:=aFotografias{$i}*$percent
			: (($width>60) & ($width>$height))
				$percent:=60/$width
				aFotografias{$i}:=aFotografias{$i}*$percent
		End case 
	End for 
	$pID:=IT_UThermometer (-2;$pID)
Else 
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]Fotografía:78;aFotografias;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;$realFieldPointer->;aRealNtaF;$stringFieldPointer->;aNtaF;[Alumnos:2]Status:50;aNtaStatus;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;aNtaRegEximicion;$objPtr->;aNtaObj)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	ARRAY PICTURE:C279(aFotografias;0)
	ARRAY PICTURE:C279(aFotografias;Size of array:C274(aNtaObj))
End if 

xALSet_AS_Objetivos 

  //$enterableInList:=False

  //PERIODOS_LoadData ([Asignaturas]Numero_del_Nivel)
  //$isOpen:=((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
  //$entryAllowed:=((((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas]Profesor_firmante_numero)) | (<>lUSR_RelatedTableUserID=[Asignaturas]Profesor_Numero) | (USR_checkRights ("M";->[Alumnos_Calificaciones]))) & (($isOpen) & ($enterableInList)))
  //If (($entryAllowed) | ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0)))
  //$enterableGrades:=1
  //Else 
$enterableGrades:=0
  //End if 
  //If (<>vb_BloquearModifSituacionFinal)
  //$enterableGrades:=0
  //End if 

  //If ($enterableGrades=1)
  //AL_SetEntryOpts (xALP_ObjxAlu;3;1;0;0;1;<>tXS_RS_DecimalSeparator)
  //Else 
AL_SetEntryOpts (xALP_ObjxAlu;1;1;0;0;1;<>tXS_RS_DecimalSeparator)
  //End if 

If (bc_MostrarFotografías=1)
	AL_SetEnterable (xALP_ObjxAlu;5;$enterableGrades)
Else 
	AL_SetEnterable (xALP_ObjxAlu;4;$enterableGrades)
End if 

ARRAY INTEGER:C220(aInteger2D;2;0)
AL_SetCellColor (xALP_ObjxAlu;1;1;3;Size of array:C274(aNtaOrden);aInteger2D;"Black";0;"";(16*15)+2)
Case of 
	: (<>gOrdenNta=0)
		AL_SetSort (xALP_ObjxAlu;2)
	: (<>gOrdenNta=1)
		AL_SetSort (xALP_ObjxAlu;1)
	: (<>gOrdenNta=2)
		AL_SetSort (xALP_ObjxAlu;2)
End case 

ARRAY INTEGER:C220(aSetRed;2;0)
ARRAY INTEGER:C220(aSetRed{1};0)
ARRAY INTEGER:C220(aSetRed{2};0)
ARRAY INTEGER:C220(aSetBleu;2;0)
ARRAY INTEGER:C220(aSetBleu{1};0)
ARRAY INTEGER:C220(aSetBleu{2};0)
ARRAY INTEGER:C220(aSetGreen;2;0)
ARRAY INTEGER:C220(aSetGreen{1};0)
ARRAY INTEGER:C220(aSetGreen{2};0)
ARRAY INTEGER:C220(aSetViol;2;0)
ARRAY INTEGER:C220(aSetViol{1};0)
ARRAY INTEGER:C220(aSetViol{2};0)
For ($k;1;Size of array:C274(aRealNtaF))
	NTA_SetCellClr (aRealNtaF{$k};3;$k)
End for 
AL_SetCellColor (xALP_ObjxAlu;0;0;0;0;aSetRed;"";4)
AL_SetCellColor (xALP_ObjxAlu;0;0;0;0;aSetBleu;"";7)
AL_SetCellColor (xALP_ObjxAlu;0;0;0;0;aSetGreen;"";10)
AL_SetCellColor (xALP_ObjxAlu;0;0;0;0;aSetViol;"";240)

AL_UpdateArrays (xALP_ObjxAlu;-2)