//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:56:30
  // ----------------------------------------------------
  // Método: STWA2_OWC_nuevavisitaenfermeria
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

C_TEXT:C284($asignatura;$profesor)
C_LONGINT:C283($idProfAsig;$idProfAutoriza)
C_BOOLEAN:C305($fuera;$fueraAutomatico)
$cd:=Current date:C33(*)
$ct:=Current time:C178(*)
$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"alumno"))
If (Size of array:C274($y_ParameterNames->)>2)
	$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ad"))
	$md:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"md"))
	$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dd"))
	$hours:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"hora")
	$mins:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"mins")
	$cd:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
	$ct:=Time:C179($hours+":"+$mins)
End if 
$userID:=STWA2_Session_GetUserSTID ($uuid)
$userName:=USR_GetUserName ($userID)
If (KRL_GotoRecord (->[Alumnos:2];$rnAlumno;False:C215))
	$fueraAutomatico:=True:C214
	READ ONLY:C145([Profesores:4])
	READ ONLY:C145([TMT_Horario:166])
	READ ONLY:C145([Asignaturas:18])
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
	If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
		KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
	End if 
	If (Records in selection:C76([TMT_Horario:166])>0)
		  //busqueda de los registros de horario para la fecha de la visita e enfermeria
		QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=$cd;*)
		QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$cd)
		  //ABK en las tres lineas que siguen se busca el horario para el día y la hora
		QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=(Day number:C114($cd)-1);*)
		QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Desde:3<=$ct;*)
		QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Hasta:4>=$ct)
		  //ABK: recuperación de la información de asignatura y profesor
		If (Records in selection:C76([TMT_Horario:166])>0)
			$asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]denominacion_interna:16)
			$idProfAsig:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]profesor_numero:4)
			$idProfAutoriza:=$idProfAsig
			$profesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$idProfAsig;->[Profesores:4]Apellidos_y_nombres:28)
			$fuera:=False:C215
		Else 
			$fuera:=True:C214
		End if 
	Else 
		$fuera:=True:C214
		$fueraAutomatico:=False:C215
	End if 
	$ob_raiz:=OB_Create 
	OB_SET ($ob_raiz;->$asignatura;"asignatura")
	OB_SET ($ob_raiz;->$profesor;"profesor")
	OB_SET ($ob_raiz;->$profesor;"profautoriza")
	OB_SET ($ob_raiz;->$idProfAsig;"idprofesorasig")
	OB_SET ($ob_raiz;->$idProfAutoriza;"idprofautoriza")
	OB_SET ($ob_raiz;->$fuera;"fuerahorario")
	OB_SET ($ob_raiz;->$fueraAutomatico;"fueraautomatico")
	OB_SET ($ob_raiz;->$userName;"ingresadopor")
	OB_SET_Text ($ob_raiz;STWA2_MakeDate4JS ($cd)+" "+String:C10($ct;HH MM SS:K7:1);"fechaactual")
	$json:=OB_Object2Json ($ob_raiz)
End if 

$0:=$json