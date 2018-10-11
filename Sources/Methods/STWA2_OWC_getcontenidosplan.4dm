//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:54:34
  // ----------------------------------------------------
  // Método: STWA2_OWC_getcontenidosplan
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

$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
$profID:=STWA2_Session_GetProfID ($uuid)
$userID:=STWA2_Session_GetUserSTID ($uuid)
If (KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$rn;False:C215))
	PERIODOS_Init 
	$profAsig:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]profesor_numero:4)
	$nivel:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Numero_del_Nivel:6)
	PERIODOS_LoadData ($nivel)
	$nombre:=""
	$nota:=""
	$objetivos:=""
	$contenidos:=""
	$actividades:=""
	$tareas:=""
	$evaluacion:=""
	$referencias:=""
	$modificable:=(($profID=$profAsig) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))
	$nombre:=[Asignaturas_PlanesDeClases:169]Nombre:14
	$nota:=[Asignaturas_PlanesDeClases:169]Nota_al_Alumno:6
	$objetivos:=[Asignaturas_PlanesDeClases:169]Objetivos:7
	$contenidos:=[Asignaturas_PlanesDeClases:169]Contenidos:8
	$actividades:=[Asignaturas_PlanesDeClases:169]Actividades:9
	$tareas:=[Asignaturas_PlanesDeClases:169]Tareas:12
	$evaluacion:=[Asignaturas_PlanesDeClases:169]Intrumentos_evaluacion:11
	$referencias:=[Asignaturas_PlanesDeClases:169]Referencias:10
	READ ONLY:C145([xShell_Documents:91])
	ARRAY TEXT:C222(atXDOC_AttachedDocs;0)
	ARRAY LONGINT:C221(alXDOC_AttachedRecNum;0)
	ARRAY TEXT:C222(atXDOC_AttachedURL;0)
	ARRAY TEXT:C222($atXDOC_AttachedURLURL;0)
	ARRAY LONGINT:C221(alXDOC_AttachedURLRecNum;0)
	XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1)
	XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1;"URL")
	QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1=Table:C252(->[Asignaturas_PlanesDeClases:169]);*)
	QUERY:C277([xShell_Documents:91]; & [xShell_Documents:91]RefType:10="URL";*)
	QUERY:C277([xShell_Documents:91]; & [xShell_Documents:91]RelatedID:2=[Asignaturas_PlanesDeClases:169]ID_Plan:1)
	SELECTION TO ARRAY:C260([xShell_Documents:91]URL:11;$atXDOC_AttachedURLURL)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$regs)
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas_PlanesDeClases:169]ID_Asignatura:2)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ([Asignaturas_PlanesDeClases:169]Desde:3>vdSTR_Periodos_InicioEjercicio)
		$botonAgregar:=$modificable
		$botonEliminar:=$modificable
		$fechas:=$modificable
		$horas:=($regs<=0)
		$statusButtonsDOC:=(((($profID=$profAsig) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))))
		$attachButtonDOC:=(($profID=$profAsig) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))
		$statusButtonsURL:=(((($profID=$profAsig) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))))
		$attachButtonURL:=(($profID=$profAsig) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))
	Else 
		$botonAgregar:=$modificable
		$botonEliminar:=False:C215
		$fechas:=False:C215
		$horas:=False:C215
		$statusButtonsDOC:=(((($profID=$profAsig) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))))
		$attachButtonDOC:=(($profID=$profAsig) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))
		$statusButtonsURL:=(((($profID=$profAsig) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))))
		$attachButtonURL:=(($profID=$profAsig) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))
	End if 
	$ob_raiz:=OB_Create 
	OB_SET ($ob_raiz;->$nombre;"nombre")
	OB_SET ($ob_raiz;->$nota;"nota")
	OB_SET ($ob_raiz;->$objetivos;"objetivos")
	OB_SET ($ob_raiz;->$contenidos;"contenidos")
	OB_SET ($ob_raiz;->$actividades;"actividades")
	OB_SET ($ob_raiz;->$tareas;"tareas")
	OB_SET ($ob_raiz;->$evaluacion;"evaluacion")
	OB_SET ($ob_raiz;->$referencias;"referencias")
	
	C_OBJECT:C1216($ob_adjuntos)
	$ob_adjuntos:=OB_Create 
	OB_SET ($ob_adjuntos;->atXDOC_AttachedDocs;"nombresDOC")
	OB_SET ($ob_adjuntos;->alXDOC_AttachedRecNum;"rnDOC")
	OB_SET ($ob_adjuntos;->atXDOC_AttachedURL;"nombresURL")
	OB_SET ($ob_adjuntos;->alXDOC_AttachedURLRecNum;"rnURL")
	OB_SET ($ob_adjuntos;->$atXDOC_AttachedURLURL;"urlURL")
	OB_SET ($ob_raiz;->$ob_adjuntos;"adjuntos")
	
	C_OBJECT:C1216($ob_privilegios)
	$ob_privilegios:=OB_Create 
	OB_SET ($ob_privilegios;->$modificable;"modificable")
	OB_SET ($ob_privilegios;->$botonAgregar;"botonAgregar")
	OB_SET ($ob_privilegios;->$botonEliminar;"botonEliminar")
	OB_SET ($ob_privilegios;->$fechas;"fechas")
	OB_SET ($ob_privilegios;->$horas;"horas")
	OB_SET ($ob_privilegios;->$attachButtonDOC;"attachDOC")
	OB_SET ($ob_privilegios;->$statusButtonsDOC;"statusDOC")
	OB_SET ($ob_privilegios;->$attachButtonURL;"attachURL")
	OB_SET ($ob_privilegios;->$statusButtonsURL;"statusURL")
	OB_SET ($ob_raiz;->$ob_privilegios;"privilegios")
	$json:=OB_Object2Json ($ob_raiz)
	
Else 
	$json:=STWA2_JSON_SendError (-60003)
End if 


$0:=$json
