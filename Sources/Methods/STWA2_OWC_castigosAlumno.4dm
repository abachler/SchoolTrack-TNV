//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:38:06
  // ----------------------------------------------------
  // Método: STWA2_OWC_castigosAlumno
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
  //ASM 20150317 Ticket 136294 
$agno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"agno"))
If ($agno=0)
	$agno:=<>gYear
End if 
KRL_GotoRecord (->[Alumnos:2];$rn;False:C215)
READ ONLY:C145([Alumnos_Castigos:9])
  //QUERY([Alumnos_Castigos];[Alumnos_Castigos]Alumno_Numero=[Alumnos]Número;*)
  //QUERY([Alumnos_Castigos]; & ;[Alumnos_Castigos]Año=<>gYear)
QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_Castigos:9]; | ;[Alumnos_Castigos:9]Alumno_Numero:8=-[Alumnos:2]numero:1)
ARRAY LONGINT:C221($al_agnoscastigo;0)
AT_DistinctsFieldValues (->[Alumnos_Castigos:9]Año:5;->$al_agnoscastigo)
$l_pos:=Find in array:C230($al_agnoscastigo;<>gYear)
If ($l_pos=-1)
	APPEND TO ARRAY:C911($al_agnoscastigo;<>gYear)
End if 
SORT ARRAY:C229($al_agnoscastigo;<)
QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Año:5=$agno)
ORDER BY:C49([Alumnos_Castigos:9];[Alumnos_Castigos:9]Fecha:9;<)
ARRAY LONGINT:C221($aCastigosRecNum;0)
ARRAY DATE:C224($aCastigosFecha;0)
ARRAY TEXT:C222($aCastigosMotivo;0)
ARRAY TEXT:C222($aCastigosObservaciones;0)
ARRAY TEXT:C222($aCastigosProfesor;0)
ARRAY INTEGER:C220($aCastigosHoras;0)
ARRAY BOOLEAN:C223($aCastigosCumplido;0)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Castigos:9];$aCastigosRecNum;[Alumnos_Castigos:9]Fecha:9;$aCastigosFecha;[Alumnos_Castigos:9]Motivo:2;$aCastigosMotivo;[Alumnos_Castigos:9]Observaciones:3;$aCastigosObservaciones;[Profesores:4]Nombre_comun:21;$aCastigosProfesor;[Alumnos_Castigos:9]Horas_de_castigo:7;$aCastigosHoras;[Alumnos_Castigos:9]Castigo_cumplido:4;$aCastigosCumplido)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
ARRAY TEXT:C222($aCastigoFechaTxt;Size of array:C274($aCastigosFecha))
ARRAY LONGINT:C221($aCastigosHorasLONG;Size of array:C274($aCastigosFecha))
For ($i;1;Size of array:C274($aCastigosFecha))
	$aCastigoFechaTxt{$i}:=STWA2_MakeDate4JS ($aCastigosFecha{$i})
	$aCastigosHorasLONG{$i}:=$aCastigosHoras{$i}
End for 
$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$aCastigosRecNum;"rns")
OB_SET ($ob_raiz;->$aCastigoFechaTxt;"fechas")
OB_SET ($ob_raiz;->$aCastigosMotivo;"motivos")
OB_SET ($ob_raiz;->$aCastigosObservaciones;"observaciones")
OB_SET ($ob_raiz;->$aCastigosProfesor;"profnombre")
OB_SET ($ob_raiz;->$aCastigosHorasLONG;"horas")
OB_SET ($ob_raiz;->$aCastigosCumplido;"cumplido")
OB_SET ($ob_raiz;->$al_agnoscastigo;"agnos")

If (<>vb_BloquearModifSituacionFinal)
	$puedeEliminarCastigo:=False:C215
	$puedeEditarCastigo:=False:C215
Else 
	If ($userID<0)
		$puedeEliminarCastigo:=True:C214
		$puedeEditarCastigo:=True:C214
	Else 
		$puedeEliminarCastigo:=False:C215
		$puedeEliminarCastigo:=$puedeEliminarCastigo | ([Alumnos:2]Tutor_numero:36=$profID)
		$puedeEliminarCastigo:=$puedeEliminarCastigo | (USR_checkRights ("D";->[Alumnos_Conducta:8];$userID))
		
		$puedeEditarCastigo:=$puedeEliminarCastigo | ([Alumnos:2]Tutor_numero:36=$profID)
		$puedeEditarCastigo:=$puedeEditarCastigo | (USR_checkRights ("M";->[Alumnos_Conducta:8];$userID))
		
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=$profID)
		If (Records in selection:C76([Cursos:3])>0)
			ARRAY TEXT:C222($cursos;0)
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
			For ($i;1;Size of array:C274($cursos))
				If ($cursos{$i}=[Alumnos:2]curso:20)
					$puedeEliminarCastigo:=True:C214
					$i:=Size of array:C274($cursos)+1
				End if 
			End for 
		End if 
	End if 
End if 

OB_SET_Boolean ($ob_raiz;$puedeEliminarCastigo;"puedeeliminar")
OB_SET_Boolean ($ob_raiz;$puedeEditarCastigo;"puedeeditar")
$json:=OB_Object2Json ($ob_raiz)
$0:=$json