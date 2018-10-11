//%attributes = {}
C_LONGINT:C283($regs)

$anteriores:=$1
$profID:=$2
$userID:=$3

PERIODOS_Init 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)

SET QUERY DESTINATION:C396(Into variable:K19:4;$regs)
QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($anteriores=1)
	QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
	QUERY:C277([Asignaturas_PlanesDeClases:169]; & ;[Asignaturas_PlanesDeClases:169]Desde:3<vdSTR_Periodos_InicioEjercicio)
Else 
	QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Asignatura:2=[Asignaturas:18]Numero:1)
	QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=vdSTR_Periodos_InicioEjercicio;*)
	QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169]; | [Asignaturas_PlanesDeClases:169]Desde:3=!00-00-00!)
End if 

ARRAY DATE:C224($aSesionesDesde;0)
ARRAY DATE:C224($aSesionesHasta;0)
If (Size of array:C274(adSTR_Periodos_Desde)>0)
	READ ONLY:C145([TMT_Horario:166])
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]SesionesDesde:12>=adSTR_Periodos_Desde{1};*)
	QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]SesionesHasta:13<=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)})
	SELECTION TO ARRAY:C260([TMT_Horario:166]SesionesDesde:12;$aSesionesDesde;[TMT_Horario:166]SesionesHasta:13;$aSesionesHasta)
	SORT ARRAY:C229($aSesionesDesde;>)
	SORT ARRAY:C229($aSesionesHasta;<)
End if 
ARRAY TEXT:C222($aSesionesDesdeT;Size of array:C274($aSesionesDesde))
ARRAY TEXT:C222($aSesionesHastaT;Size of array:C274($aSesionesHasta))
For ($i;1;Size of array:C274($aSesionesDesde))
	$aSesionesDesdeT{$i}:=STWA2_MakeDate4JS ($aSesionesDesde{$i})
	$aSesionesHastaT{$i}:=STWA2_MakeDate4JS ($aSesionesHasta{$i})
End for 
SORT ARRAY:C229($aSesionesDesdeT;>)
SORT ARRAY:C229($aSesionesHastaT;<)

ARRAY DATE:C224($desde;0)
ARRAY DATE:C224($hasta;0)
ARRAY TEXT:C222($atSTRas_Planes_Desde;0)
ARRAY TEXT:C222($atSTRas_Planes_Hasta;0)

ARRAY TEXT:C222($atSTRas_Contenido;0)
ARRAY INTEGER:C220($aiSTRas_Planes_Horas;0)
ARRAY LONGINT:C221($alSTRas_Planes_RNS;0)
ARRAY TEXT:C222(atXDOC_AttachedDocs;0)
ARRAY LONGINT:C221(alXDOC_AttachedRecNum;0)
ARRAY TEXT:C222(atXDOC_AttachedURL;0)
ARRAY TEXT:C222($atXDOC_AttachedURLURL;0)
ARRAY LONGINT:C221(alXDOC_AttachedURLRecNum;0)

LONGINT ARRAY FROM SELECTION:C647([Asignaturas_PlanesDeClases:169];$alSTRas_Planes_RNS)
SELECTION TO ARRAY:C260([Asignaturas_PlanesDeClases:169]Desde:3;$desde;[Asignaturas_PlanesDeClases:169]Contenidos:8;$atSTRas_Contenido;\
[Asignaturas_PlanesDeClases:169]Hasta:4;$hasta;[Asignaturas_PlanesDeClases:169]NumeroHoras:5;$aiSTRas_Planes_Horas)
SORT ARRAY:C229($desde;$hasta;$aiSTRas_Planes_Horas;$atSTRas_Contenido;$alSTRas_Planes_RNS;<)

ARRAY TEXT:C222($atSTRas_Planes_Desde;Size of array:C274($desde))
ARRAY TEXT:C222($atSTRas_Planes_Hasta;Size of array:C274($desde))
ARRAY LONGINT:C221($horas;Size of array:C274($aiSTRas_Planes_Horas))
For ($i;1;Size of array:C274($desde))
	$atSTRas_Planes_Desde{$i}:=STWA2_MakeDate4JS ($desde{$i})
	$atSTRas_Planes_Hasta{$i}:=STWA2_MakeDate4JS ($hasta{$i})
	$horas{$i}:=$aiSTRas_Planes_Horas{$i}
End for 

$nombre:=""
$nota:=""
$objetivos:=""
$contenidos:=""
$actividades:=""
$tareas:=""
$evaluacion:=""
$referencias:=""

$modificable:=(($profID=[Asignaturas:18]profesor_numero:4) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))
If (Size of array:C274($atSTRas_Planes_Desde)>0)
	KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$alSTRas_Planes_RNS{1};False:C215)
	$nombre:=[Asignaturas_PlanesDeClases:169]Nombre:14
	$nota:=[Asignaturas_PlanesDeClases:169]Nota_al_Alumno:6
	$objetivos:=[Asignaturas_PlanesDeClases:169]Objetivos:7
	$contenidos:=[Asignaturas_PlanesDeClases:169]Contenidos:8
	$actividades:=[Asignaturas_PlanesDeClases:169]Actividades:9
	$tareas:=[Asignaturas_PlanesDeClases:169]Tareas:12
	$evaluacion:=[Asignaturas_PlanesDeClases:169]Intrumentos_evaluacion:11
	$referencias:=[Asignaturas_PlanesDeClases:169]Referencias:10
	READ ONLY:C145([xShell_Documents:91])
	XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1)
	XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1;"URL")
	QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1=Table:C252(->[Asignaturas_PlanesDeClases:169]);*)
	QUERY:C277([xShell_Documents:91]; & [xShell_Documents:91]RefType:10="URL";*)
	QUERY:C277([xShell_Documents:91]; & [xShell_Documents:91]RelatedID:2=[Asignaturas_PlanesDeClases:169]ID_Plan:1)
	SELECTION TO ARRAY:C260([xShell_Documents:91]URL:11;$atXDOC_AttachedURLURL)
	If ($desde{1}>vdSTR_Periodos_InicioEjercicio)
		$botonAgregar:=$modificable
		$botonEliminar:=$modificable
		$fechas:=$modificable
		$horasPriv:=($regs<=0)
		$statusButtonsDOC:=(((($profID=[Asignaturas:18]profesor_numero:4) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))))
		$attachButtonDOC:=(($profID=[Asignaturas:18]profesor_numero:4) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))
		$statusButtonsURL:=(((($profID=[Asignaturas:18]profesor_numero:4) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))))
		$attachButtonURL:=(($profID=[Asignaturas:18]profesor_numero:4) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))
	Else 
		$botonAgregar:=$modificable
		$botonEliminar:=False:C215
		$fechas:=False:C215
		$horasPriv:=False:C215
		$statusButtonsDOC:=(((($profID=[Asignaturas:18]profesor_numero:4) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))))
		$attachButtonDOC:=(($profID=[Asignaturas:18]profesor_numero:4) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))
		$statusButtonsURL:=(((($profID=[Asignaturas:18]profesor_numero:4) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))))
		$attachButtonURL:=(($profID=[Asignaturas:18]profesor_numero:4) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169];$userID)))
	End if 
Else 
	$botonAgregar:=$modificable
	$botonEliminar:=False:C215
	$fechas:=False:C215
	$horasPriv:=False:C215
	$statusButtonsDOC:=False:C215
	$attachButtonDOC:=False:C215
	$statusButtonsURL:=False:C215
	$attachButtonURL:=False:C215
End if 

$administrador:=USR_IsGroupMember_by_GrpID (-15001;$userID)

$inicioEjercicio:=STWA2_MakeDate4JS (vdSTR_Periodos_InicioEjercicio)
$finEjercicio:=STWA2_MakeDate4JS (vdSTR_Periodos_FinEjercicio)

  //cambio en los planes
C_OBJECT:C1216($ob_raiz)
$ob_raiz:=OB_Create 
OB_SET_Boolean ($ob_raiz;$administrador;"administrador")
OB_SET ($ob_raiz;->$atSTRas_Planes_Desde;"desde")
OB_SET ($ob_raiz;->$atSTRas_Planes_Hasta;"hasta")
OB_SET ($ob_raiz;->$horas;"horas")
OB_SET ($ob_raiz;->$alSTRas_Planes_RNS;"rns")

OB_SET_Long ($ob_raiz;Size of array:C274($aSesionesDesdeT);"cuantassesiones")
If (Size of array:C274($aSesionesDesdeT)>0)
	OB_SET_Text ($ob_raiz;$aSesionesDesdeT{1};"primerasesiondesde")
	OB_SET_Text ($ob_raiz;$aSesionesHastaT{1};"primerasesionhasta")
End if 
OB_SET ($ob_raiz;->$inicioEjercicio;"inicioejercicio")
OB_SET ($ob_raiz;->$finEjercicio;"finejercicio")


  //$jsonT:=JSON New 
  //$node:=JSON Append bool ($jsonT;"administrador";Num($administrador))
  //$node:=JSON Append text array ($jsonT;"desde";$atSTRas_Planes_Desde)
  //$node:=JSON Append text array ($jsonT;"hasta";$atSTRas_Planes_Hasta)
  //$node:=JSON Append long array ($jsonT;"horas";$horas)
  //$node:=JSON Append long array ($jsonT;"rns";$alSTRas_Planes_RNS)
  //$node:=JSON Append long ($jsonT;"cuantassesiones";Size of array($aSesionesDesdeT))
  //If (Size of array($aSesionesDesdeT)>0)
  //$node:=JSON Append text ($jsonT;"primerasesiondesde";$aSesionesDesdeT{1})
  //$node:=JSON Append text ($jsonT;"primerasesionhasta";$aSesionesHastaT{1})
  //End if 
  //$node:=JSON Append text ($jsonT;"inicioejercicio";$inicioEjercicio)
  //$node:=JSON Append text ($jsonT;"finejercicio";$finEjercicio)

C_OBJECT:C1216($ob_plan)
$ob_plan:=OB_Create 
OB_SET ($ob_plan;->$nombre;"nombre")
OB_SET ($ob_plan;->$nota;"nota")
OB_SET ($ob_plan;->$objetivos;"objetivos")
OB_SET ($ob_plan;->$contenidos;"contenidos")
OB_SET ($ob_plan;->$actividades;"actividades")
OB_SET ($ob_plan;->$tareas;"tareas")
OB_SET ($ob_plan;->$evaluacion;"evaluacion")
OB_SET ($ob_plan;->$referencias;"referencias")


  //$jsonPlan:=JSON Append node ($jsonT;"plan")
  //$node:=JSON Append text ($jsonPlan;"nombre";$nombre)
  //$node:=JSON Append text ($jsonPlan;"nota";$nota)
  //$node:=JSON Append text ($jsonPlan;"objetivos";$objetivos)
  //$node:=JSON Append text ($jsonPlan;"contenidos";$contenidos)
  //$node:=JSON Append text ($jsonPlan;"actividades";$actividades)
  //$node:=JSON Append text ($jsonPlan;"tareas";$tareas)
  //$node:=JSON Append text ($jsonPlan;"evaluacion";$evaluacion)
  //$node:=JSON Append text ($jsonPlan;"referencias";$referencias)

C_OBJECT:C1216($ob_adjuntos)
$ob_adjuntos:=OB_Create 
OB_SET ($ob_adjuntos;->atXDOC_AttachedDocs;"nombresDOC")
OB_SET ($ob_adjuntos;->alXDOC_AttachedRecNum;"rnDOC")
OB_SET ($ob_adjuntos;->atXDOC_AttachedURL;"nombresURL")
OB_SET ($ob_adjuntos;->alXDOC_AttachedURLRecNum;"rnURL")
OB_SET ($ob_adjuntos;->$atXDOC_AttachedURLURL;"urlURL")
OB_SET ($ob_plan;->$ob_adjuntos;"adjuntos")


  //$jsonAdjuntos:=JSON Append node ($jsonPlan;"adjuntos")
  //$node:=JSON Append text array ($jsonAdjuntos;"nombresDOC";atXDOC_AttachedDocs)
  //$node:=JSON Append long array ($jsonAdjuntos;"rnDOC";alXDOC_AttachedRecNum)
  //$node:=JSON Append text array ($jsonAdjuntos;"nombresURL";atXDOC_AttachedURL)
  //$node:=JSON Append long array ($jsonAdjuntos;"rnURL";alXDOC_AttachedURLRecNum)
  //$node:=JSON Append text array ($jsonAdjuntos;"urlURL";$atXDOC_AttachedURLURL)

C_OBJECT:C1216($ob_privilegios)
$ob_privilegios:=OB_Create 
OB_SET ($ob_privilegios;->$modificable;"modificable")
OB_SET ($ob_privilegios;->$botonAgregar;"botonAgregar")
OB_SET ($ob_privilegios;->$botonEliminar;"botonEliminar")
OB_SET ($ob_privilegios;->$fechas;"fechas")
OB_SET ($ob_privilegios;->$horasPriv;"horas")
OB_SET ($ob_privilegios;->$attachButtonDOC;"attachDOC")
OB_SET ($ob_privilegios;->$statusButtonsDOC;"statusDOC")
OB_SET ($ob_privilegios;->$attachButtonURL;"attachURL")
OB_SET ($ob_privilegios;->$statusButtonsURL;"statusURL")
OB_SET ($ob_plan;->$ob_privilegios;"privilegios")

OB_SET ($ob_raiz;->$ob_plan;"plan")
$text:=OB_Object2Json ($ob_raiz)
SET TEXT TO PASTEBOARD:C523($text)
$0:=$text
  //$jsonPrivilegios:=JSON Append node ($jsonPlan;"privilegios")
  //$node:=JSON Append bool ($jsonPrivilegios;"modificable";Num($modificable))
  //$node:=JSON Append bool ($jsonPrivilegios;"botonAgregar";Num($botonAgregar))
  //$node:=JSON Append bool ($jsonPrivilegios;"botonEliminar";Num($botonEliminar))
  //$node:=JSON Append bool ($jsonPrivilegios;"fechas";Num($fechas))
  //$node:=JSON Append bool ($jsonPrivilegios;"horas";Num($horasPriv))
  //$node:=JSON Append bool ($jsonPrivilegios;"attachDOC";Num($attachButtonDOC))
  //$node:=JSON Append bool ($jsonPrivilegios;"statusDOC";Num($statusButtonsDOC))
  //$node:=JSON Append bool ($jsonPrivilegios;"attachURL";Num($attachButtonURL))
  //$node:=JSON Append bool ($jsonPrivilegios;"statusURL";Num($statusButtonsURL))
  //$text:=JSON Export to text ($jsonT;1)
  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
  //$0:=$text

