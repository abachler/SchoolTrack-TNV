//%attributes = {}
  //SRal_Academias

  //EMA 20/06/06
  //Para informe de Destrezas con asignaturas extracurrilares, incidente 49958
ARRAY LONGINT:C221(alIDActividad;0)
C_TEXT:C284(vEvaluacion1)
C_TEXT:C284(vEvaluacion2)
C_TEXT:C284(vEvaluacion3)
vEvaluacion1:=""
vEvaluacion2:=""
vEvaluacion3:=""
C_TEXT:C284(viFieldObs1)
C_TEXT:C284(viFieldObs2)
C_TEXT:C284(viFieldObs3)
viFieldObs1:=""
viFieldObs2:=""
viFieldObs3:=""
_O_C_INTEGER:C282(viFieldabs1)
_O_C_INTEGER:C282(viFieldabs2)
_O_C_INTEGER:C282(viFieldabs3)
viFieldabs1:=0
viFieldabs2:=0
viFieldabs3:=0

QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Alumno_Numero:1;=;[Alumnos:2]numero:1)
DISTINCT VALUES:C339([Alumnos_Actividades:28]Actividad_numero:2;alIDActividad)
QRY_QueryWithArray (->[Actividades:29]ID:1;->alIDActividad)
CREATE SET:C116([Actividades:29];"todas")
QUERY SELECTION:C341([Actividades:29];[Actividades:29]Description:10;=;"Academia1@")
If (Records in selection:C76([Actividades:29])=1)
	QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2;=;[Actividades:29]ID:1;*)
	QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Alumno_Numero:1;=;[Alumnos:2]numero:1)
	vEvaluacion1:=([Alumnos_Actividades:28]Periodo1_Evaluación1:15*Num:C11(vPeriodo=1))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo2_Evaluación1:21*Num:C11(vPeriodo=2))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo3_Evaluación1:27*Num:C11(vPeriodo=3))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo4_Evaluación1:33*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo1_Evaluación2:16*Num:C11(vPeriodo=1))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo2_Evaluación2:22*Num:C11(vPeriodo=2))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo3_Evaluación2:28*Num:C11(vPeriodo=3))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo4_Evaluación2:34*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo1_Evaluación3:17*Num:C11(vPeriodo=1))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo2_Evaluación3:23*Num:C11(vPeriodo=2))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo3_Evaluación3:29*Num:C11(vPeriodo=3))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo4_Evaluación3:35*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo1_Evaluación4:18*Num:C11(vPeriodo=1))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo2_Evaluación4:24*Num:C11(vPeriodo=2))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo3_Evaluación4:30*Num:C11(vPeriodo=3))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo4_Evaluación4:36*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo1_Evaluación5:19*Num:C11(vPeriodo=1))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo2_Evaluación5:25*Num:C11(vPeriodo=2))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo3_Evaluación5:31*Num:C11(vPeriodo=3))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo4_Evaluación5:37*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo1_Evaluación6:20*Num:C11(vPeriodo=1))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo2_Evaluación6:26*Num:C11(vPeriodo=2))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo3_Evaluación6:32*Num:C11(vPeriodo=3))
	vEvaluacion1:=vEvaluacion1+([Alumnos_Actividades:28]Periodo4_Evaluación6:38*Num:C11(vPeriodo=4))
	
	
	viFieldObs1:=(([Alumnos_Actividades:28]Comentarios_P1:6)*Num:C11(vPeriodo=1))
	viFieldObs1:=viFieldObs1+(([Alumnos_Actividades:28]Comentarios_P2:13)*Num:C11(vPeriodo=2))
	viFieldObs1:=viFieldObs1+(([Alumnos_Actividades:28]Comentarios_P3:14)*Num:C11(vPeriodo=3))
	viFieldObs1:=viFieldObs1+(([Alumnos_Actividades:28]Comentarios_P4:41)*Num:C11(vPeriodo=4))
	
	viFieldabs1:=(([Alumnos_Actividades:28]Inasistencia_P1:10)*Num:C11(vPeriodo=1))
	viFieldabs1:=viFieldabs1+(([Alumnos_Actividades:28]Inasistencia_P2:11)*Num:C11(vPeriodo=2))
	viFieldabs1:=viFieldabs1+(([Alumnos_Actividades:28]Inasistencia_P3:12)*Num:C11(vPeriodo=3))
	viFieldabs1:=viFieldabs1+(([Alumnos_Actividades:28]Inasistencia_P4:42)*Num:C11(vPeriodo=4))
End if 
USE SET:C118("todas")
QUERY SELECTION:C341([Actividades:29];[Actividades:29]Description:10;=;"Academia2@")
If (Records in selection:C76([Actividades:29])=1)
	QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2;=;[Actividades:29]ID:1;*)
	QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Alumno_Numero:1;=;[Alumnos:2]numero:1)
	vEvaluacion2:=([Alumnos_Actividades:28]Periodo1_Evaluación1:15*Num:C11(vPeriodo=1))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo2_Evaluación1:21*Num:C11(vPeriodo=2))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo3_Evaluación1:27*Num:C11(vPeriodo=3))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo4_Evaluación1:33*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo1_Evaluación2:16*Num:C11(vPeriodo=1))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo2_Evaluación2:22*Num:C11(vPeriodo=2))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo3_Evaluación2:28*Num:C11(vPeriodo=3))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo4_Evaluación2:34*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo1_Evaluación3:17*Num:C11(vPeriodo=1))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo2_Evaluación3:23*Num:C11(vPeriodo=2))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo3_Evaluación3:29*Num:C11(vPeriodo=3))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo4_Evaluación3:35*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo1_Evaluación4:18*Num:C11(vPeriodo=1))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo2_Evaluación4:24*Num:C11(vPeriodo=2))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo3_Evaluación4:30*Num:C11(vPeriodo=3))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo4_Evaluación4:36*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo1_Evaluación5:19*Num:C11(vPeriodo=1))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo2_Evaluación5:25*Num:C11(vPeriodo=2))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo3_Evaluación5:31*Num:C11(vPeriodo=3))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo4_Evaluación5:37*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo1_Evaluación6:20*Num:C11(vPeriodo=1))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo2_Evaluación6:26*Num:C11(vPeriodo=2))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo3_Evaluación6:32*Num:C11(vPeriodo=3))
	vEvaluacion2:=vEvaluacion2+([Alumnos_Actividades:28]Periodo4_Evaluación6:38*Num:C11(vPeriodo=4))
	
	
	viFieldObs2:=(([Alumnos_Actividades:28]Comentarios_P1:6)*Num:C11(vPeriodo=1))
	viFieldObs2:=viFieldObs2+(([Alumnos_Actividades:28]Comentarios_P2:13)*Num:C11(vPeriodo=2))
	viFieldObs2:=viFieldObs2+(([Alumnos_Actividades:28]Comentarios_P3:14)*Num:C11(vPeriodo=3))
	viFieldObs2:=viFieldObs2+(([Alumnos_Actividades:28]Comentarios_P4:41)*Num:C11(vPeriodo=4))
	
	viFieldabs2:=(([Alumnos_Actividades:28]Inasistencia_P1:10)*Num:C11(vPeriodo=1))
	viFieldabs2:=viFieldabs2+(([Alumnos_Actividades:28]Inasistencia_P2:11)*Num:C11(vPeriodo=2))
	viFieldabs2:=viFieldabs2+(([Alumnos_Actividades:28]Inasistencia_P3:12)*Num:C11(vPeriodo=3))
	viFieldabs2:=viFieldabs2+(([Alumnos_Actividades:28]Inasistencia_P4:42)*Num:C11(vPeriodo=4))
End if 
USE SET:C118("todas")
QUERY SELECTION:C341([Actividades:29];[Actividades:29]Description:10;=;"Academia3@")
If (Records in selection:C76([Actividades:29])=1)
	QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2;=;[Actividades:29]ID:1;*)
	QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Alumno_Numero:1;=;[Alumnos:2]numero:1)
	vEvaluacion3:=([Alumnos_Actividades:28]Periodo1_Evaluación1:15*Num:C11(vPeriodo=1))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo2_Evaluación1:21*Num:C11(vPeriodo=2))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo3_Evaluación1:27*Num:C11(vPeriodo=3))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo4_Evaluación1:33*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo1_Evaluación2:16*Num:C11(vPeriodo=1))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo2_Evaluación2:22*Num:C11(vPeriodo=2))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo3_Evaluación2:28*Num:C11(vPeriodo=3))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo4_Evaluación2:34*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo1_Evaluación3:17*Num:C11(vPeriodo=1))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo2_Evaluación3:23*Num:C11(vPeriodo=2))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo3_Evaluación3:29*Num:C11(vPeriodo=3))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo4_Evaluación3:35*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo1_Evaluación4:18*Num:C11(vPeriodo=1))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo2_Evaluación4:24*Num:C11(vPeriodo=2))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo3_Evaluación4:30*Num:C11(vPeriodo=3))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo4_Evaluación4:36*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo1_Evaluación5:19*Num:C11(vPeriodo=1))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo2_Evaluación5:25*Num:C11(vPeriodo=2))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo3_Evaluación5:31*Num:C11(vPeriodo=3))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo4_Evaluación5:37*Num:C11(vPeriodo=4))+"\r"
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo1_Evaluación6:20*Num:C11(vPeriodo=1))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo2_Evaluación6:26*Num:C11(vPeriodo=2))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo3_Evaluación6:32*Num:C11(vPeriodo=3))
	vEvaluacion3:=vEvaluacion3+([Alumnos_Actividades:28]Periodo4_Evaluación6:38*Num:C11(vPeriodo=4))
	
	viFieldObs3:=(([Alumnos_Actividades:28]Comentarios_P1:6)*Num:C11(vPeriodo=1))
	viFieldObs3:=viFieldObs3+(([Alumnos_Actividades:28]Comentarios_P2:13)*Num:C11(vPeriodo=2))
	viFieldObs3:=viFieldObs3+(([Alumnos_Actividades:28]Comentarios_P3:14)*Num:C11(vPeriodo=3))
	viFieldObs3:=viFieldObs3+(([Alumnos_Actividades:28]Comentarios_P4:41)*Num:C11(vPeriodo=4))
	
	viFieldabs3:=(([Alumnos_Actividades:28]Inasistencia_P1:10)*Num:C11(vPeriodo=1))
	viFieldabs3:=viFieldabs3+(([Alumnos_Actividades:28]Inasistencia_P2:11)*Num:C11(vPeriodo=2))
	viFieldabs3:=viFieldabs3+(([Alumnos_Actividades:28]Inasistencia_P3:12)*Num:C11(vPeriodo=3))
	viFieldabs3:=viFieldabs3+(([Alumnos_Actividades:28]Inasistencia_P4:42)*Num:C11(vPeriodo=4))
End if 
CLEAR SET:C117("todas")

ARRAY TEXT:C222(aXObservaciones1;0)
ARRAY TEXT:C222(aXObservaciones1;3)
ARRAY INTEGER:C220(aXAsistencia1;0)
ARRAY INTEGER:C220(aXAsistencia1;3)
ARRAY TEXT:C222(aXActividad1;0)
ARRAY TEXT:C222(aXActividad1;3)

aXActividad1{1}:="Academia 1ª:"
aXActividad1{2}:="Academia 2ª:"
aXActividad1{3}:="Academia 3ª:"

aXObservaciones1{1}:=viFieldObs1
aXObservaciones1{2}:=viFieldObs2
aXObservaciones1{3}:=viFieldObs3

aXAsistencia1{1}:=viFieldabs1
aXAsistencia1{2}:=viFieldabs2
aXAsistencia1{3}:=viFieldabs3



