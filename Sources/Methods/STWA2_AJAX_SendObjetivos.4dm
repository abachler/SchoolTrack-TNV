//%attributes = {}
  // STWA2_AJAX_SendObjetivos()
  //
  //
  // modificado y normalizado por: Alberto Bachler Klein: 28-11-15, 13:47:59
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_objetivosEspecificos)
C_LONGINT:C283($l_idAsignatura;$l_idObjetivos;$l_numeroNivel;$l_periodo;$l_recNum)
C_TEXT:C284($t_json)
C_OBJECT:C1216($ob_json;$ob_nodo_Menu;$ob_nodo_Parametros;$ob_nodo_Periodos)

ARRAY LONGINT:C221($al_idObjetivos;0)
ARRAY TEXT:C222($at_cursos;0)
ARRAY TEXT:C222($at_nombresComunes;0)
ARRAY TEXT:C222($at_nombresOficiales;0)



If (False:C215)
	C_TEXT:C284(STWA2_AJAX_SendObjetivos ;$0)
	C_LONGINT:C283(STWA2_AJAX_SendObjetivos ;$1)
End if 

$l_periodo:=$1

If ([Asignaturas:18]ID_Objetivos:43#0)
	$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_Objetivos:104]ID:1;->[Asignaturas:18]ID_Objetivos:43;False:C215)
	If ($l_recNum=-1)
		CREATE RECORD:C68([Asignaturas_Objetivos:104])
		[Asignaturas_Objetivos:104]ID:1:=SQ_SeqNumber (->[Asignaturas_Objetivos:104]ID:1;False:C215)
		[Asignaturas_Objetivos:104]Nivel_numero:4:=[Asignaturas:18]Numero_del_Nivel:6
		[Asignaturas_Objetivos:104]ID_Autor:3:=[Asignaturas:18]profesor_numero:4
		[Asignaturas_Objetivos:104]Subsector:2:=[Asignaturas:18]Asignatura:3
		[Asignaturas_Objetivos:104]Objetivos_P1:6:=""
		[Asignaturas_Objetivos:104]Objetivos_P2:7:=""
		[Asignaturas_Objetivos:104]Objetivos_P3:8:=""
		[Asignaturas_Objetivos:104]Objetivos_P4:9:=""
		[Asignaturas_Objetivos:104]Objetivos_P5:10:=""
		SAVE RECORD:C53([Asignaturas_Objetivos:104])
		[Asignaturas:18]ID_Objetivos:43:=[Asignaturas_Objetivos:104]ID:1
		SAVE RECORD:C53([Asignaturas:18])
	End if 
Else 
	CREATE RECORD:C68([Asignaturas_Objetivos:104])
	[Asignaturas_Objetivos:104]ID:1:=SQ_SeqNumber (->[Asignaturas_Objetivos:104]ID:1;False:C215)
	[Asignaturas_Objetivos:104]Nivel_numero:4:=[Asignaturas:18]Numero_del_Nivel:6
	[Asignaturas_Objetivos:104]ID_Autor:3:=[Asignaturas:18]profesor_numero:4
	[Asignaturas_Objetivos:104]Subsector:2:=[Asignaturas:18]Asignatura:3
	[Asignaturas_Objetivos:104]Objetivos_P1:6:=""
	[Asignaturas_Objetivos:104]Objetivos_P2:7:=""
	[Asignaturas_Objetivos:104]Objetivos_P3:8:=""
	[Asignaturas_Objetivos:104]Objetivos_P4:9:=""
	[Asignaturas_Objetivos:104]Objetivos_P5:10:=""
	SAVE RECORD:C53([Asignaturas_Objetivos:104])
	[Asignaturas:18]ID_Objetivos:43:=[Asignaturas_Objetivos:104]ID:1
	SAVE RECORD:C53([Asignaturas:18])
End if 

PERIODOS_Init 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
  //
  //If (($l_periodo=0) | ($l_periodo>aiSTR_Periodos_Numero{Size of array(aiSTR_Periodos_Numero)}))
  //$l_periodo:=PERIODOS_PeriodosActuales (Current date(*);True)
  //End if
If ($l_periodo=0)
	$l_periodo:=viSTR_PeriodoActual_Numero
End if 
If ($l_periodo>aiSTR_Periodos_Numero{Size of array:C274(aiSTR_Periodos_Numero)})
	$l_periodo:=Size of array:C274(aiSTR_Periodos_Numero)
End if 

$l_idAsignatura:=[Asignaturas:18]Numero:1
$l_numeroNivel:=[Asignaturas:18]Numero_del_Nivel:6
$l_idObjetivos:=[Asignaturas:18]ID_Objetivos:43
$b_objetivosEspecificos:=[Asignaturas:18]ConObjetivosEspecificos:62

READ ONLY:C145([Asignaturas:18])
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_numeroNivel;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero:1#$l_idAsignatura;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]ID_Objetivos:43#0)


SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$at_nombresComunes;[Asignaturas:18]Asignatura:3;$at_nombresOficiales;[Asignaturas:18]ID_Objetivos:43;$al_idObjetivos;[Asignaturas:18]Curso:5;$at_cursos)
AT_MultiLevelSort (">>";->$at_nombresOficiales;->$at_cursos;->$al_idObjetivos;->$at_nombresComunes)

$ob_json:=OB_Create 

$ob_nodo_Periodos:=OB_Create 
OB_SET ($ob_json;->$ob_nodo_Periodos;"periodos")
OB_SET ($ob_json;->atSTR_Periodos_Nombre;"periodos.nombres")
OB_SET ($ob_json;->aiSTR_Periodos_Numero;"periodos.numeros")
OB_SET ($ob_json;->adSTR_Periodos_Desde;"periodos.desde";"MM/DD/YYYY")
OB_SET ($ob_json;->adSTR_Periodos_Hasta;"periodos.hasta";"MM/DD/YYYY")
OB_SET ($ob_json;->adSTR_Periodos_Cierre;"periodos.cierre";"MM/DD/YYYY")

$ob_nodo_Parametros:=OB_Create 
OB_SET ($ob_json;->$ob_nodo_Parametros;"parametros")
OB_SET ($ob_json;->$l_periodo;"parametros.periodo")

If (Size of array:C274($al_idObjetivos)>0)
	$ob_nodo_Menu:=OB_Create 
	OB_SET ($ob_nodo_Menu;->$at_nombresComunes;"internos")
	OB_SET ($ob_nodo_Menu;->$at_nombresOficiales;"oficiales")
	OB_SET ($ob_nodo_Menu;->$at_cursos;"cursos")
	OB_SET ($ob_nodo_Menu;->$al_idObjetivos;"numerosAS")
	OB_SET ($ob_json;->$ob_nodo_Menu;"menu")
End if 

OB_SET ($ob_json;->[Asignaturas_Objetivos:104]Objetivos_P1:6;"objP1")
OB_SET ($ob_json;->[Asignaturas_Objetivos:104]Objetivos_P2:7;"objP2")
OB_SET ($ob_json;->[Asignaturas_Objetivos:104]Objetivos_P3:8;"objP3")
OB_SET ($ob_json;->[Asignaturas_Objetivos:104]Objetivos_P4:9;"objP4")
OB_SET ($ob_json;->[Asignaturas_Objetivos:104]Objetivos_P5:10;"objP5")
OB_SET ($ob_json;->$l_idObjetivos;"objetivosnum")
OB_SET ($ob_json;->$b_objetivosEspecificos;"especificos")

$t_json:=OB_Object2Json ($ob_json)
$0:=$t_json


KRL_UnloadReadOnly (->[Asignaturas_Objetivos:104])
KRL_UnloadReadOnly (->[Asignaturas:18])

