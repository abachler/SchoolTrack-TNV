//%attributes = {}
  //CU_PgConducta
C_LONGINT:C283($i)
C_BOOLEAN:C305(CUv_mCdta)
MESSAGES OFF:C175

READ ONLY:C145([Alumnos:2])
QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
End if 
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;<>aStdId;[Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]no_de_lista:53;<>aStdNo)
QRY_QueryWithArray (->[Alumnos_SintesisAnual:210]ID_Alumno:4;-><>aStdID)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Institucion:1=<>gInstitucion;*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]Año:2=<>gYear;*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Curso:7=[Cursos:3]Curso:1)

SET FIELD RELATION:C919([Alumnos:2]LlaveRegistroCicloActual:76;Automatic:K51:4;Automatic:K51:4)  //Mono ticket 203044
ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;>)
MESSAGES ON:C181
SELECTION TO ARRAY:C260([Alumnos:2]no_de_lista:53;aStdNoLista;[Alumnos:2]apellidos_y_nombres:40;aStdName;[Alumnos_SintesisAnual:210]ID_Alumno:4;aIDAlumno;[Alumnos_SintesisAnual:210]Inasistencias_Dias:30;aInasist;[Alumnos_SintesisAnual:210]Atrasos_Jornada:40;aAtrasos;[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41;aAtrasosInter;[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34;aAntP;[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36;aAntN;[Alumnos_SintesisAnual:210]Castigos:43;aCastigos;[Alumnos_SintesisAnual:210]Suspensiones:44;aSusp;[Alumnos_SintesisAnual:210]Anotaciones_Neutras:35;aAntNeutras;[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;aPctAsist)  //Mono ticket 158247
SET FIELD RELATION:C919([Alumnos:2]LlaveRegistroCicloActual:76;Structure configuration:K51:2;Structure configuration:K51:2)  //Mono ticket 203044

COPY NAMED SELECTION:C331([Alumnos_SintesisAnual:210];"$Conducta")
ARRAY REAL:C219(aPctAsist;Size of array:C274(aInasist))

xALSet_CU_AreaConducta 

$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]AttendanceMode:3)
$modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]Lates_Mode:16)

If (<>vb_BloquearModifSituacionFinal)
	$enterable:=0
Else 
	If (((USR_checkRights ("M";->[Alumnos_Conducta:8])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2)) & ($modoRegistroAsistencia=3))
		$enterable:=1
	Else 
		$enterable:=0
	End if 
End if 
AL_SetEntryOpts (xALP_Conducta_y_asistencia;2;0;0;1;2;<>tXS_RS_DecimalSeparator)
AL_SetEnterable (xALP_Conducta_y_asistencia;3;$enterable)
AL_SetCallbacks (xALP_Conducta_y_asistencia;"";"xALCB_EX_CumuloInasistencias")
AL_SetFilter (xALP_Conducta_y_asistencia;3;"&9")


If (<>vb_BloquearModifSituacionFinal)
	$enterable:=0
Else 
	If (((USR_checkRights ("M";->[Alumnos_Conducta:8])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2)) & ($modoRegistroAtrasos=3))
		$enterable:=1
	Else 
		$enterable:=0
	End if 
End if 
AL_SetEntryOpts (xALP_Conducta_y_asistencia;2;0;0;1;2)
AL_SetEnterable (xALP_Conducta_y_asistencia;5;$enterable)
AL_SetCallbacks (xALP_Conducta_y_asistencia;"";"xALCB_EX_CumuloInasistencias")
AL_SetFilter (xALP_Conducta_y_asistencia;3;"&9")

Case of 
	: (<>gOrdenNta=0)
		AL_SetSort (xALP_Conducta_y_asistencia;2)  //nombre y surso
	: (<>gOrdenNta=1)
		AL_SetSort (xALP_Conducta_y_asistencia;1)  //no lista
	: (<>gOrdenNta=2)
		AL_SetSort (xALP_Conducta_y_asistencia;2)  //nombre
End case 

FORM GOTO PAGE:C247(2)
modCdt:=False:C215
IT_SetButtonState (USR_checkRights ("M";->[Alumnos_Conducta:8]);->bBWR_SaveRecord)
MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos_Conducta:8]);1;5)