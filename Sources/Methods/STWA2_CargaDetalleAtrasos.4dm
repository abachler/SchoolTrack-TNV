//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 08-09-16, 10:49:15
  // ----------------------------------------------------
  // Método: STWA2_CargaDetalleAtrasos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$profID:=STWA2_Session_GetProfID ($uuid)
$userID:=STWA2_Session_GetUserSTID ($uuid)
$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
$agno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"agno"))
If ($agno=0)
	$agno:=<>gYear
End if 
KRL_GotoRecord (->[Alumnos:2];$rn;False:C215)
READ ONLY:C145([Alumnos_Atrasos:55])
ARRAY LONGINT:C221($ai_agnosAtrasos;0)
QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Atrasos:55]; | ;[Alumnos_Atrasos:55]Alumno_numero:1=-[Alumnos:2]numero:1)
  //para cargar los años historicos de las anotaciones
AT_DistinctsFieldValues (->[Alumnos_Atrasos:55]Año:6;->$ai_agnosAtrasos)

  // ticket 156943 JVP 20160531
C_LONGINT:C283($vl_id)
$vl_id:=Find in array:C230($ai_agnosAtrasos;<>gYear)
If ($vl_id=-1)
	APPEND TO ARRAY:C911($ai_agnosAtrasos;<>gYear)
End if 

SORT ARRAY:C229($ai_agnosAtrasos;<)
QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Año:6=$agno)
ORDER BY:C49([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2;<)

ARRAY LONGINT:C221($alSTRal_RecNumAtraso;0)
ARRAY DATE:C224($adSTRal_FechaAtraso;0)
ARRAY TEXT:C222($atSTRal_observaciones;0)
ARRAY LONGINT:C221($al_IDjustificacion;0)
ARRAY TEXT:C222($at_MotivoJustificacion;0)
ARRAY BOOLEAN:C223($ab_justificado;0)

SELECTION TO ARRAY:C260([Alumnos_Atrasos:55];$alSTRal_RecNumAtraso;[Alumnos_Atrasos:55]Fecha:2;$adSTRal_FechaAtraso;[Alumnos_Atrasos:55]Observaciones:3;$atSTRal_observaciones;[Alumnos_Atrasos:55]id_justificacion:13;$al_IDjustificacion;[Alumnos_Atrasos:55]justificado:14;$ab_justificado)
For ($i;1;Size of array:C274($al_IDjustificacion))
	QUERY:C277([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]ID:1=$al_IDjustificacion{$i})
	APPEND TO ARRAY:C911($at_MotivoJustificacion;[xxSTR_JustificacionAtrasos:227]Motivo:2)
End for 

ARRAY TEXT:C222($afechasAtrasos;Size of array:C274($adSTRal_FechaAtraso))
If (Size of array:C274($adSTRal_FechaAtraso)>0)
	For ($i;1;Size of array:C274($adSTRal_FechaAtraso))
		$afechasAtrasos{$i}:=STWA2_MakeDate4JS ($adSTRal_FechaAtraso{$i})
	End for 
End if 

C_OBJECT:C1216($ob_raiz)
$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$alSTRal_RecNumAtraso;"rns")
OB_SET ($ob_raiz;->$afechasAtrasos;"fechas")
OB_SET ($ob_raiz;->$at_MotivoJustificacion;"motivos")
OB_SET ($ob_raiz;->$atSTRal_observaciones;"observaciones")
OB_SET ($ob_raiz;->$ab_justificado;"justificado")
OB_SET ($ob_raiz;->$ai_agnosAtrasos;"agnos")

If (<>vb_BloquearModifSituacionFinal)
	$puedeEliminarAtraso:=False:C215
	$puedeEditarAnotacion:=False:C215
Else 
	If ($userID<0)
		$puedeEliminarAtraso:=True:C214
		$puedeEditarAnotacion:=True:C214
	Else 
		$puedeEliminarAtraso:=False:C215
		$puedeEliminarAtraso:=$puedeEliminarAtraso | ([Alumnos:2]Tutor_numero:36=$profID)
		$puedeEliminarAtraso:=$puedeEliminarAtraso | (USR_checkRights ("D";->[Alumnos_Atrasos:55];$userID))
		  //ASM 20151125 Ticket 145177
		$puedeEditarAnotacion:=USR_checkRights ("M";->[Alumnos_Atrasos:55];$userID)
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=$profID)
		If (Records in selection:C76([Cursos:3])>0)
			ARRAY TEXT:C222($cursos;0)
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
			For ($i;1;Size of array:C274($cursos))
				If ($cursos{$i}=[Alumnos:2]curso:20)
					$puedeEliminarAtraso:=True:C214
					$i:=Size of array:C274($cursos)+1
				End if 
			End for 
		End if 
	End if 
End if 


  //cargo los datos de la configuración de motivos de atrasos
ALL RECORDS:C47([xxSTR_JustificacionAtrasos:227])
QUERY SELECTION:C341([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]activo:5=True:C214)
ORDER BY:C49([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]ID:1;>)
SELECTION TO ARRAY:C260([xxSTR_JustificacionAtrasos:227];$al_RecNumJustificacion;[xxSTR_JustificacionAtrasos:227]Motivo:2;$at_MotivoJustificacionconf)

OB_SET ($ob_raiz;->$al_RecNumJustificacion;"confRecNum")
OB_SET ($ob_raiz;->$at_MotivoJustificacionconf;"confMotivo")
OB_SET ($ob_raiz;->$puedeEliminarAtraso;"puedeeliminar")
OB_SET ($ob_raiz;->$puedeEditarAnotacion;"puedeeditar")
OB_SET ($ob_raiz;->[Alumnos:2]apellidos_y_nombres:40;"nombre")
$json:=OB_Object2Json ($ob_raiz)

$0:=$json
