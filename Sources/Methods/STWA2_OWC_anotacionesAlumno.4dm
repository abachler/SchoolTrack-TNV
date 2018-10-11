//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:39:05
  // ----------------------------------------------------
  // Método: STWA2_OWC_anotacionesAlumno
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

$profID:=STWA2_Session_GetProfID ($uuid)
$userID:=STWA2_Session_GetUserSTID ($uuid)
$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
  //ASM  20150317 TIcket 136294 
$agno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"agno"))
If ($agno=0)
	$agno:=<>gYear
End if 
KRL_GotoRecord (->[Alumnos:2];$rn;False:C215)
READ ONLY:C145([Alumnos_Anotaciones:11])
ARRAY LONGINT:C221($ai_agnosAnotaciones;0)
QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Anotaciones:11]; | ;[Alumnos_Anotaciones:11]Alumno_Numero:6=-[Alumnos:2]numero:1)
  //para cargar los años historicos de las anotaciones
AT_DistinctsFieldValues (->[Alumnos_Anotaciones:11]Año:11;->$ai_agnosAnotaciones)
  // ticket 156943 JVP 20160531
C_LONGINT:C283($vl_id)
$vl_id:=Find in array:C230($ai_agnosAnotaciones;<>gYear)
If ($vl_id=-1)
	APPEND TO ARRAY:C911($ai_agnosAnotaciones;<>gYear)
End if 


SORT ARRAY:C229($ai_agnosAnotaciones;<)
QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11=$agno)
  //QUERY([Alumnos_Anotaciones];[Alumnos_Anotaciones]Alumno_Numero=[Alumnos]Número;*)
  //QUERY([Alumnos_Anotaciones]; & ;[Alumnos_Anotaciones]Año=<>gYear)
ORDER BY:C49([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Fecha:1;<)
ARRAY DATE:C224($adSTRal_FechaAnotacion;0)
ARRAY TEXT:C222($afechasAnotaciones;0)
ARRAY TEXT:C222($atSTRal_NombreProfesorAnot;0)
ARRAY TEXT:C222($atSTRal_MotivoAnotacion;0)
ARRAY LONGINT:C221($alSTRal_NoProfesorAnot;0)
ARRAY TEXT:C222($atSTRal_NotasAnotacion;0)
ARRAY TEXT:C222($atSTRal_CategoriaAnotacion;0)
ARRAY INTEGER:C220($alSTRal_PuntosAnotacion;0)
ARRAY LONGINT:C221($alSTRal_NumeroAlumno;0)
ARRAY TEXT:C222($atSTRal_TipoAnotacion;0)
ARRAY LONGINT:C221($alSTRal_RecNumItemAnotacion;0)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11];$alSTRal_RecNumItemAnotacion;[Alumnos_Anotaciones:11]Fecha:1;$adSTRal_FechaAnotacion;[Alumnos_Anotaciones:11]Motivo:3;$atSTRal_MotivoAnotacion;[Alumnos_Anotaciones:11]Observaciones:4;$atSTRal_NotasAnotacion;[Profesores:4]Nombre_comun:21;$atSTRal_NombreProfesorAnot;[Alumnos_Anotaciones:11]Profesor_Numero:5;$alSTRal_NoProfesorAnot;[Alumnos_Anotaciones:11]Categoria:8;$atSTRal_CategoriaAnotacion;[Alumnos_Anotaciones:11]Puntos:9;$alSTRal_PuntosAnotacion;[Alumnos_Anotaciones:11]Signo:7;$atSTRal_TipoAnotacion)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
ARRAY TEXT:C222($afechasAnotaciones;Size of array:C274($adSTRal_FechaAnotacion))
ARRAY LONGINT:C221($apuntosAnotaciones;Size of array:C274($adSTRal_FechaAnotacion))
If (Size of array:C274($adSTRal_FechaAnotacion)>0)
	For ($i;1;Size of array:C274($adSTRal_FechaAnotacion))
		$afechasAnotaciones{$i}:=STWA2_MakeDate4JS ($adSTRal_FechaAnotacion{$i})
		$apuntosAnotaciones{$i}:=$alSTRal_PuntosAnotacion{$i}
	End for 
End if 
$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$alSTRal_RecNumItemAnotacion;"rns")
OB_SET ($ob_raiz;->$afechasAnotaciones;"fechas")
OB_SET ($ob_raiz;->$atSTRal_MotivoAnotacion;"motivos")
OB_SET ($ob_raiz;->$atSTRal_NotasAnotacion;"observaciones")
OB_SET ($ob_raiz;->$atSTRal_NombreProfesorAnot;"profnombre")
OB_SET ($ob_raiz;->$atSTRal_CategoriaAnotacion;"categorias")
OB_SET ($ob_raiz;->$apuntosAnotaciones;"puntos")
OB_SET ($ob_raiz;->$atSTRal_TipoAnotacion;"signos")
OB_SET ($ob_raiz;->$ai_agnosAnotaciones;"agnos")

If (<>vb_BloquearModifSituacionFinal)
	$puedeEliminarAnotacion:=False:C215
	$puedeEditarAnotacion:=False:C215
Else 
	If ($userID<0)
		$puedeEliminarAnotacion:=True:C214
		$puedeEditarAnotacion:=True:C214
	Else 
		$puedeEliminarAnotacion:=False:C215
		$puedeEliminarAnotacion:=$puedeEliminarAnotacion | ([Alumnos:2]Tutor_numero:36=$profID)
		$puedeEliminarAnotacion:=$puedeEliminarAnotacion | (USR_checkRights ("D";->[Alumnos_Conducta:8];$userID))
		  //ASM 20151125 Ticket 145177
		$puedeEditarAnotacion:=USR_checkRights ("M";->[Alumnos_Conducta:8];$userID)
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=$profID)
		If (Records in selection:C76([Cursos:3])>0)
			ARRAY TEXT:C222($cursos;0)
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
			For ($i;1;Size of array:C274($cursos))
				If ($cursos{$i}=[Alumnos:2]curso:20)
					$puedeEliminarAnotacion:=True:C214
					$i:=Size of array:C274($cursos)+1
				End if 
			End for 
		End if 
	End if 
End if 


OB_SET ($ob_raiz;->$puedeEliminarAnotacion;"puedeeliminar")
OB_SET ($ob_raiz;->$puedeEditarAnotacion;"puedeeditar")
OB_SET ($ob_raiz;->[Alumnos:2]apellidos_y_nombres:40;"nombre")
$json:=OB_Object2Json ($ob_raiz)

$0:=$json
