//%attributes = {}
  // STWA2_AJAX_SendObservaciones()
  //
  //
  // modificado por: Alberto Bachler Klein: 14-12-15, 10:28:22
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1;$2;$3)

C_BOOLEAN:C305($b_editable)
C_LONGINT:C283($i;$l_periodo;$l_periodoActual)
C_TEXT:C284($t_conCategorias)
C_OBJECT:C1216($ob_json;$ob_nivel;$ob_nodoEstiloEv;$ob_nodoParametros;$ob_nodoPeriodos)

ARRAY BOOLEAN:C223($ab_notaReprobada;0)
ARRAY INTEGER:C220($al_NtaRegEximicion;0)
ARRAY INTEGER:C220($al_orden;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_nombreAlumnos;0)
ARRAY TEXT:C222($at_Objetivos;0)
ARRAY TEXT:C222($at_Observaciones;0)
ARRAY TEXT:C222($at_Promedios;0)
ARRAY TEXT:C222($at_status;0)
ARRAY OBJECT:C1221($ao_Categorias;0)
ARRAY OBJECT:C1221($ao_Children;0)
ARRAY BOOLEAN:C223($ab_condicional;0)


If (False:C215)
	C_TEXT:C284(STWA2_AJAX_SendObservaciones ;$0)
	C_LONGINT:C283(STWA2_AJAX_SendObservaciones ;$1)
	C_LONGINT:C283(STWA2_AJAX_SendObservaciones ;$2)
	C_LONGINT:C283(STWA2_AJAX_SendObservaciones ;$3)
End if 

$l_periodo:=$1
$profID:=$2
$userID:=$3
$uuid:=$4

PERIODOS_Init 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
  //If (($l_periodo=0) | ($l_periodo>aiSTR_Periodos_Numero{Size of array(aiSTR_Periodos_Numero)}))
  //$l_periodo:=PERIODOS_PeriodosActuales (Current date(*);True)
  //End if
If ($l_periodo=0)
	$l_periodo:=viSTR_PeriodoActual_Numero
End if 
If ($l_periodo>aiSTR_Periodos_Numero{Size of array:C274(aiSTR_Periodos_Numero)})
	$l_periodo:=Size of array:C274(aiSTR_Periodos_Numero)
End if 
EVS_initialize 
EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)

ARRAY REAL:C219(aRealNtaF;0)


EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
Case of 
	: ($l_periodo=-1)
		$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]Final_objetivos:105
	: ($l_periodo=1)
		$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]P01_Final_Literal:116
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]P01_Objetivos:100
	: ($l_periodo=2)
		$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]P02_Final_Literal:191
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]P02_Objetivos:101
	: ($l_periodo=3)
		$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]P03_Final_Literal:266
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]P03_Objetivos:102
	: ($l_periodo=4)
		$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]P04_Final_Literal:341
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]P04_Objetivos:103
	: ($l_periodo=5)
		$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
		$stringFieldPointer:=->[Alumnos_Calificaciones:208]P05_Final_Literal:416
		$objPtr:=->[Alumnos_ComplementoEvaluacion:209]P05_Objetivos:104
End case 

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
READ ONLY:C145([Alumnos_Calificaciones:208])
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$al_recNums;[Alumnos_Calificaciones:208]Reprobada:9;$ab_notaReprobada;[Alumnos_Calificaciones:208]NoDeLista:10;$al_orden;[Alumnos:2]apellidos_y_nombres:40;$at_nombreAlumnos;[Alumnos:2]Status:50;$at_status;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;$al_NtaRegEximicion;$stringFieldPointer->;$at_Promedios)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

For ($i;1;Size of array:C274($al_recNums))
	GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_recNums{$i})
	EV2_CargaRegistro ([Alumnos_Calificaciones:208]ID_Asignatura:5;[Alumnos_Calificaciones:208]ID_Alumno:6;False:C215)
	APPEND TO ARRAY:C911($at_Objetivos;$objPtr->)
	APPEND TO ARRAY:C911($at_Observaciones;$obsPointer->)
End for 

$enterableInList:=True:C214
If ($l_periodo=-1)
	$isOpen:=((adSTR_Periodos_Cierre{Size of array:C274(adSTR_Periodos_Cierre)}>Current date:C33(*)) | (adSTR_Periodos_Cierre{Size of array:C274(adSTR_Periodos_Cierre)}=!00-00-00!))
Else 
	$isOpen:=((adSTR_Periodos_Cierre{$l_periodo}>Current date:C33(*)) | (adSTR_Periodos_Cierre{$l_periodo}=!00-00-00!))
End if 
  //Para verificar el reeemplazo
C_BOOLEAN:C305($b_reemplazoOK)
STWA2_ReemplazaUsuario ("verificaUsuarioReemplazo";$uuid;->$b_reemplazoOK)
  //MONO TICKET 213946
$b_editable:=((((<>viSTR_FirmantesAutorizados=1) & ($profID=[Asignaturas:18]profesor_firmante_numero:33)) | ($profID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208])) | ($b_reemplazoOK)) & (($isOpen) & ($enterableInList))) | (USR_IsGroupMember_by_GrpID (-15001;$userID))


Case of 
	: (<>gOrdenNta=0)
		SORT ARRAY:C229($at_nombreAlumnos;$al_orden;$at_Promedios;$at_Observaciones;$at_status;$al_NtaRegEximicion;$at_Objetivos;$al_recNums;$ab_notaReprobada;>)
	: (<>gOrdenNta=1)
		SORT ARRAY:C229($al_orden;$at_nombreAlumnos;$at_Promedios;$at_Observaciones;$at_status;$al_NtaRegEximicion;$at_Objetivos;$al_recNums;$ab_notaReprobada;>)
	: (<>gOrdenNta=2)
		SORT ARRAY:C229($at_nombreAlumnos;$al_orden;$at_Promedios;$at_Observaciones;$at_status;$al_NtaRegEximicion;$at_Objetivos;$al_recNums;$ab_notaReprobada;>)
End case 


For ($i;1;Size of array:C274($al_recNums))
	GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_recNums{$i})
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Calificaciones:208]ID_Alumno:6)
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1)
	APPEND TO ARRAY:C911($ab_condicional;[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57)
End for 
$ob_json:=OB_Create 
OB_SET ($ob_json;->$b_editable;"ingresopermitido")
OB_SET ($ob_json;->$al_orden;"ordenes")
OB_SET ($ob_json;->$at_nombreAlumnos;"alumnos")
OB_SET ($ob_json;->$at_Observaciones;"observaciones")
OB_SET ($ob_json;->$at_Promedios;"promedios")
OB_SET ($ob_json;->$al_recNums;"recnums")
OB_SET ($ob_json;->$at_status;"status")
OB_SET ($ob_json;->$al_NtaRegEximicion;"regeximicion")
OB_SET ($ob_json;->$ab_notaReprobada;"reprobada")
OB_SET ($ob_json;->$ab_condicional;"cond")
If ([Asignaturas:18]ObjetivosxAlumno:112)
	OB_SET ($ob_json;->$at_Objetivos;"objetivos")
End if 


$t_conCategorias:="0"
If (<>viSTR_UtilizarObservaciones=1)
	READ ONLY:C145([xxSTR_Materias:20])
	QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=[Asignaturas:18]Asignatura:3)
	$ob_Raiz:=[xxSTR_Materias:20]ob_Observaciones:7
	OB_GET ($ob_Raiz;->$ob_nivel;String:C10([Asignaturas:18]Numero_del_Nivel:6))
	OB_GET ($ob_nivel;->$ao_Categorias;"categorias")
	For ($i;1;Size of array:C274($ao_Categorias))
		OB_GET ($ao_Categorias{$i};->$ao_Children;"children")
		If (Size of array:C274($ao_Children)>0)
			$i:=Size of array:C274($ao_Categorias)
			$t_conCategorias:="1"
		End if 
	End for 
	If ($t_conCategorias="1")
		OB_SET ($ob_json;->$ao_Categorias;"categorias")
	End if 
End if 

$l_periodoActual:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
$ob_nodoParametros:=OB_AppendNode ($ob_json;"parametros")
$l_objetivosPorAlumno:=Num:C11([Asignaturas:18]ObjetivosxAlumno:112)
OB_SET ($ob_json;->$l_objetivosPorAlumno;"parametros.conobjetivos")
OB_SET ($ob_json;->$l_periodo;"parametros.periodo")
OB_SET ($ob_json;->$l_periodoActual;"parametros.periodoactual")
OB_SET ($ob_json;->$t_conCategorias;"parametros.predefinidas")


$ob_nodoEstiloEv:=OB_AppendNode ($ob_json;"estiloEV")
Case of 
	: (iPrintMode=Notas)
		rMinimo:=EV2_Real_a_Nota (rPctMinimum;0;iGradesDec)
		vr_MinEscalaNota:=EV2_Real_a_Nota (vrNTA_MinimoEscalaReferencia;0;iGradesDec)
		$t_modo:="notas"
		OB_SET ($ob_json;->$t_modo;"estiloEV.evaluationmode")
		OB_SET ($ob_json;->rMinimo;"estiloEV.minimo")
		OB_SET ($ob_json;->vr_MinEscalaNota;"estiloEV.minimoescala")
	: (iPrintMode=Puntos)
		rMinimo:=EV2_Real_a_Puntos (rPctMinimum;0;iPointsDec)
		vr_MinEscalaNota:=EV2_Real_a_Puntos (vrNTA_MinimoEscalaReferencia;0;iPointsDec)
		$t_modo:="puntos"
		OB_SET ($ob_json;->$t_modo;"estiloEV.evaluationmode")
		OB_SET ($ob_json;->rMinimo;"estiloEV.minimo")
		OB_SET ($ob_json;->vr_MinEscalaNota;"estiloEV.minimoescala")
	: (iPrintMode=Simbolos)
		rMinSimbolo:=EV2_Real_a_Simbolo (rPctMinimum)
		vt_MinEscalaNotaSim:=EV2_Real_a_Simbolo (vrNTA_MinimoEscalaReferencia)
		$t_modo:="simbolos"
		OB_SET ($ob_json;->$t_modo;"estiloEV.evaluationmode")
		OB_SET ($ob_json;->aSymbol;"estiloEV.simbolos")
		OB_SET ($ob_json;->rMinSimbolo;"estiloEV.minimo")
		OB_SET ($ob_json;->vt_MinEscalaNotaSim;"estiloEV.minescala")
	: (iPrintMode=Porcentaje)
		rMinimo:=rPctMinimum
		vr_MinEscalaNota:=vrNTA_MinimoEscalaReferencia
		$t_modo:="porcentaje"
		OB_SET ($ob_json;->$t_modo;"estiloEV.evaluationmode")
		OB_SET ($ob_json;->rMinimo;"estiloEV.minimo")
		OB_SET ($ob_json;->vr_MinEscalaNota;"estiloEV.minimoescala")
End case 

$ob_nodoPeriodos:=OB_AppendNode ($ob_json;"periodos")
OB_SET ($ob_json;->atSTR_Periodos_Nombre;"periodos.nombres")
OB_SET ($ob_json;->aiSTR_Periodos_Numero;"periodos.numeros")
OB_SET ($ob_json;->adSTR_Periodos_Desde;"periodos.desde";"MM/DD/YYYY")
OB_SET ($ob_json;->adSTR_Periodos_Hasta;"periodos.hasta";"MM/DD/YYYY")
OB_SET ($ob_json;->adSTR_Periodos_Cierre;"periodos.cierre";"MM/DD/YYYY")
$0:=OB_Object2Json ($ob_json)


