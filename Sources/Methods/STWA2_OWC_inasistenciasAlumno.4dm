//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:35:56
  // ----------------------------------------------------
  // Método: STWA2_OWC_inasistenciasAlumno
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
KRL_GotoRecord (->[Alumnos:2];$rn;False:C215)
READ ONLY:C145([Alumnos_Inasistencias:10])
QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Año:8=<>gYear)
ORDER BY:C49([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1;<)
ARRAY LONGINT:C221($aInasistenciasRecNum;0)
ARRAY DATE:C224($aInasistenciasFecha;0)
ARRAY TEXT:C222($aInasistenciasJustificacion;0)
ARRAY TEXT:C222($aInasistenciasObservaciones;0)
ARRAY LONGINT:C221($aInasistenciasLicencia;0)
SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10];$aInasistenciasRecNum;[Alumnos_Inasistencias:10]Fecha:1;$aInasistenciasFecha;[Alumnos_Inasistencias:10]Justificación:2;$aInasistenciasJustificacion;[Alumnos_Inasistencias:10]Observaciones:3;$aInasistenciasObservaciones;[Alumnos_Inasistencias:10]Licencia:5;$aInasistenciasLicencia)
ARRAY TEXT:C222($aInasistenciasFechaTxt;Size of array:C274($aInasistenciasFecha))
For ($i;1;Size of array:C274($aInasistenciasFecha))
	$aInasistenciasFechaTxt{$i}:=STWA2_MakeDate4JS ($aInasistenciasFecha{$i})
End for 
$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$aInasistenciasRecNum;"rns")
OB_SET ($ob_raiz;->$aInasistenciasFechaTxt;"fecha")
OB_SET ($ob_raiz;->$aInasistenciasJustificacion;"justificacion")
OB_SET ($ob_raiz;->$aInasistenciasObservaciones;"observaciones")

If (<>vb_BloquearModifSituacionFinal)
	$puedeEliminarInasistencia:=False:C215
	$puedeEditarInasistencia:=False:C215
Else 
	If ($userID<0)
		$puedeEliminarInasistencia:=True:C214
		$puedeEditarInasistencia:=True:C214
	Else 
		$puedeEliminarInasistencia:=False:C215
		$puedeEliminarInasistencia:=$puedeEliminarInasistencia | ([Alumnos:2]Tutor_numero:36=$profID)
		$puedeEliminarInasistencia:=$puedeEliminarInasistencia | (USR_checkRights ("D";->[Alumnos_Conducta:8];$userID))
		  //ASM 20151125 Ticket 145177
		$puedeEditarInasistencia:=USR_checkRights ("M";->[Alumnos_Conducta:8];$userID)
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=$profID)
		If (Records in selection:C76([Cursos:3])>0)
			ARRAY TEXT:C222($cursos;0)
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
			For ($i;1;Size of array:C274($cursos))
				If ($cursos{$i}=[Alumnos:2]curso:20)
					$puedeEliminarInasistencia:=True:C214
					$i:=Size of array:C274($cursos)+1
				End if 
			End for 
		End if 
	End if 
End if 
OB_SET_Boolean ($ob_raiz;$puedeEliminarInasistencia;"puedeeliminar")
OB_SET_Boolean ($ob_raiz;$puedeEditarInasistencia;"puedeeditar")
$json:=OB_Object2Json ($ob_raiz)
$0:=$json
