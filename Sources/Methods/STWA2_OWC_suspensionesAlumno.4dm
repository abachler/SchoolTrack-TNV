//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:37:08
  // ----------------------------------------------------
  // Método: STWA2_OWC_suspensionesAlumno
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
$agno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"agno"))
If ($agno=0)
	$agno:=<>gYear
End if 
KRL_GotoRecord (->[Alumnos:2];$rn;False:C215)

READ ONLY:C145([Alumnos_Suspensiones:12])
  //QUERY([Alumnos_Suspensiones];[Alumnos_Suspensiones]Alumno_Numero=[Alumnos]Número;*)
  //QUERY([Alumnos_Suspensiones]; & ;[Alumnos_Suspensiones]Año=<>gYear)
QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Suspensiones:12]; | ;[Alumnos_Suspensiones:12]Alumno_Numero:7=-[Alumnos:2]numero:1)
ARRAY LONGINT:C221($al_SuspensionesAgno;0)
AT_DistinctsFieldValues (->[Alumnos_Suspensiones:12]Año:1;->$al_SuspensionesAgno)
$l_pos:=Find in array:C230($al_SuspensionesAgno;<>gYear)
If ($l_pos=-1)
	APPEND TO ARRAY:C911($al_SuspensionesAgno;<>gYear)
End if 
SORT ARRAY:C229($al_SuspensionesAgno;<)
QUERY SELECTION:C341([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Año:1=$agno)
ORDER BY:C49([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Desde:5;<)
ARRAY LONGINT:C221($aSuspensionesRecNum;0)
ARRAY DATE:C224($aSuspensionesDesde;0)
ARRAY DATE:C224($aSuspensionesHasta;0)
ARRAY TEXT:C222($aSuspensionesMotivo;0)
ARRAY TEXT:C222($aSuspensionesObservaciones;0)
ARRAY TEXT:C222($aSuspensionesProfesor;0)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Suspensiones:12];$aSuspensionesRecNum;[Alumnos_Suspensiones:12]Desde:5;$aSuspensionesDesde;[Alumnos_Suspensiones:12]Hasta:6;$aSuspensionesHasta;[Alumnos_Suspensiones:12]Motivo:2;$aSuspensionesMotivo;[Alumnos_Suspensiones:12]Observaciones:8;$aSuspensionesObservaciones;[Profesores:4]Nombre_comun:21;$aSuspensionesProfesor)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
ARRAY TEXT:C222($aSuspensionesDesdeTxt;Size of array:C274($aSuspensionesDesde))
ARRAY TEXT:C222($aSuspensionesHastaTxt;Size of array:C274($aSuspensionesDesde))
For ($i;1;Size of array:C274($aSuspensionesDesdeTxt))
	$aSuspensionesDesdeTxt{$i}:=STWA2_MakeDate4JS ($aSuspensionesDesde{$i})
	$aSuspensionesHastaTxt{$i}:=STWA2_MakeDate4JS ($aSuspensionesHasta{$i})
End for 
$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$aSuspensionesRecNum;"rns")
OB_SET ($ob_raiz;->$aSuspensionesDesdeTxt;"desde")
OB_SET ($ob_raiz;->$aSuspensionesHastaTxt;"hasta")
OB_SET ($ob_raiz;->$aSuspensionesMotivo;"motivos")
OB_SET ($ob_raiz;->$aSuspensionesObservaciones;"observaciones")
OB_SET ($ob_raiz;->$aSuspensionesProfesor;"profnombre")
OB_SET ($ob_raiz;->$al_SuspensionesAgno;"agnos")
  //$suspensiones:=JSON New 
  //$node:=JSON Append long array ($suspensiones;"rns";$aSuspensionesRecNum)
  //$node:=JSON Append text array ($suspensiones;"desde";$aSuspensionesDesdeTxt)
  //$node:=JSON Append text array ($suspensiones;"hasta";$aSuspensionesHastaTxt)
  //$node:=JSON Append text array ($suspensiones;"motivos";$aSuspensionesMotivo)
  //$node:=JSON Append text array ($suspensiones;"observaciones";$aSuspensionesObservaciones)
  //$node:=JSON Append text array ($suspensiones;"profnombre";$aSuspensionesProfesor)
  //$node:=JSON Append long array ($suspensiones;"agnos";$al_SuspensionesAgno)
If (<>vb_BloquearModifSituacionFinal)
	$puedeEliminarSuspension:=False:C215
	$puedeEditarSuspension:=False:C215
Else 
	If ($userID<0)
		$puedeEliminarSuspension:=True:C214
		$puedeEditarSuspension:=True:C214
	Else 
		$puedeEliminarSuspension:=False:C215
		$puedeEliminarSuspension:=$puedeEliminarSuspension | ([Alumnos:2]Tutor_numero:36=$profID)
		$puedeEliminarSuspension:=$puedeEliminarSuspension | (USR_checkRights ("D";->[Alumnos_Conducta:8];$userID))
		
		$puedeEditarSuspension:=$puedeEliminarSuspension | ([Alumnos:2]Tutor_numero:36=$profID)
		$puedeEditarSuspension:=$puedeEditarSuspension | (USR_checkRights ("M";->[Alumnos_Conducta:8];$userID))
		
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=$profID)
		If (Records in selection:C76([Cursos:3])>0)
			ARRAY TEXT:C222($cursos;0)
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
			For ($i;1;Size of array:C274($cursos))
				If ($cursos{$i}=[Alumnos:2]curso:20)
					$puedeEliminarSuspension:=True:C214
					$puedeEditarSuspension:=True:C214
					$i:=Size of array:C274($cursos)+1
				End if 
			End for 
		End if 
	End if 
End if 
OB_SET_Boolean ($ob_raiz;$puedeEliminarSuspension;"puedeeliminar")
OB_SET_Boolean ($ob_raiz;$puedeEditarSuspension;"puedeeditar")
$json:=OB_Object2Json ($ob_raiz)
  //$node:=JSON Append bool ($suspensiones;"puedeeliminar";Num($puedeEliminarSuspension))
  //$node:=JSON Append bool ($suspensiones;"puedeeditar";Num($puedeEditarSuspension))
  //$json:=JSON Export to text ($suspensiones;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($suspensiones)  //20150421 RCH Se agrega cierre

$0:=$json
