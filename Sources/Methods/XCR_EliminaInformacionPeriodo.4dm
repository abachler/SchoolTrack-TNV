//%attributes = {}
  // XCR_EliminaInformacionPeriodo()
  // Por: Alberto Bachler K.: 03-07-14, 15:04:40
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_IdActividad;$l_Idalumno;$l_periodo)
If (False:C215)
	C_LONGINT:C283(XCR_EliminaInformacionPeriodo ;$0)
	C_LONGINT:C283(XCR_EliminaInformacionPeriodo ;$1)
	C_LONGINT:C283(XCR_EliminaInformacionPeriodo ;$2)
End if 
$l_IdActividad:=$1
$l_Idalumno:=$2
$l_periodo:=$3

If (($l_IdActividad#[Alumnos_Actividades:28]Actividad_numero:2) | ($l_Idalumno#[Alumnos_Actividades:28]Alumno_Numero:1))
	QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2;=;$l_IdActividad;*)
	QUERY:C277([Alumnos_Actividades:28]; & [Alumnos_Actividades:28]Alumno_Numero:1;=;$l_Idalumno)
End if 

KRL_ReloadInReadWriteMode (->[Alumnos_Actividades:28])
If (Not:C34(Locked:C147([Alumnos_Actividades:28])))
	Case of 
		: ($l_periodo=1)
			[Alumnos_Actividades:28]Comentarios_P1:6:=""
			[Alumnos_Actividades:28]Inasistencia_P1:10:=0
			[Alumnos_Actividades:28]Evaluación_Final_P1:7:=""
			[Alumnos_Actividades:28]Periodo1_Evaluación1:15:=""
			[Alumnos_Actividades:28]Periodo1_Evaluación2:16:=""
			[Alumnos_Actividades:28]Periodo1_Evaluación3:17:=""
			[Alumnos_Actividades:28]Periodo1_Evaluación4:18:=""
			[Alumnos_Actividades:28]Periodo1_Evaluación5:19:=""
			[Alumnos_Actividades:28]Periodo1_Evaluación6:20:=""
			
		: ($l_periodo=2)
			[Alumnos_Actividades:28]Comentarios_P2:13:=""
			[Alumnos_Actividades:28]Inasistencia_P2:11:=0
			[Alumnos_Actividades:28]Evaluación_Final_P2:8:=""
			[Alumnos_Actividades:28]Periodo2_Evaluación1:21:=""
			[Alumnos_Actividades:28]Periodo2_Evaluación2:22:=""
			[Alumnos_Actividades:28]Periodo2_Evaluación3:23:=""
			[Alumnos_Actividades:28]Periodo2_Evaluación4:24:=""
			[Alumnos_Actividades:28]Periodo2_Evaluación5:25:=""
			[Alumnos_Actividades:28]Periodo2_Evaluación6:26:=""
			
		: ($l_periodo=3)
			[Alumnos_Actividades:28]Comentarios_P3:14:=""
			[Alumnos_Actividades:28]Inasistencia_P3:12:=0
			[Alumnos_Actividades:28]Evaluación_Final_P3:9:=""
			[Alumnos_Actividades:28]Periodo3_Evaluación1:27:=""
			[Alumnos_Actividades:28]Periodo3_Evaluación2:28:=""
			[Alumnos_Actividades:28]Periodo3_Evaluación3:29:=""
			[Alumnos_Actividades:28]Periodo3_Evaluación4:30:=""
			[Alumnos_Actividades:28]Periodo3_Evaluación5:31:=""
			[Alumnos_Actividades:28]Periodo3_Evaluación6:32:=""
			
		: ($l_periodo=4)
			[Alumnos_Actividades:28]Comentarios_P4:41:=""
			[Alumnos_Actividades:28]Inasistencia_P4:42:=0
			[Alumnos_Actividades:28]Evaluación_Final_P4:39:=""
			[Alumnos_Actividades:28]Periodo4_Evaluación1:33:=""
			[Alumnos_Actividades:28]Periodo4_Evaluación2:34:=""
			[Alumnos_Actividades:28]Periodo4_Evaluación3:35:=""
			[Alumnos_Actividades:28]Periodo4_Evaluación4:36:=""
			[Alumnos_Actividades:28]Periodo4_Evaluación5:37:=""
			[Alumnos_Actividades:28]Periodo4_Evaluación6:38:=""
			
		: ($l_periodo=5)
			[Alumnos_Actividades:28]Comentarios_P5:53:=""
			[Alumnos_Actividades:28]Inasistencia_P5:52:=0
			[Alumnos_Actividades:28]Evaluacion_Final_P5:51:=""
			[Alumnos_Actividades:28]Periodo5_Evaluacion1:45:=""
			[Alumnos_Actividades:28]Periodo5_Evaluacion2:46:=""
			[Alumnos_Actividades:28]Periodo5_Evaluacion3:47:=""
			[Alumnos_Actividades:28]Periodo5_Evaluacion4:48:=""
			[Alumnos_Actividades:28]Periodo5_Evaluacion5:49:=""
			[Alumnos_Actividades:28]Periodo5_Evaluacion6:50:=""
			
	End case 
	SAVE RECORD:C53([Alumnos_Actividades:28])
	$0:=1
End if 

