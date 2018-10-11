//%attributes = {}
  // Método: AL_LeeSintesisConducta
  //
  //
  // por Alberto Bachler Klein
  // creación 18/05/17, 16:23:38
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_BOOLEAN:C305($condicionalidadActivada)
C_DATE:C307($condicionalidadHasta)
C_LONGINT:C283($l_idAlumno;$modoRegistroAsistencia;$l_nivel;$l_periodo;$recNum;$l_año)
C_TEXT:C284($condicionalidadMotivo;$t_llave)


If (False:C215)
	C_LONGINT:C283(AL_LeeSintesisConducta ;$1)
	C_LONGINT:C283(AL_LeeSintesisConducta ;$2)
	C_LONGINT:C283(AL_LeeSintesisConducta ;$3)
	C_LONGINT:C283(AL_LeeSintesisConducta ;$4)
End if 

C_LONGINT:C283(lastCdcta;vJustified)
C_LONGINT:C283(vl_AnotacionesNegativas;vl_AnotacionesPositivas;vl_PuntosNegativos;vl_PuntosPositivos;vl_Castigos;vl_suspensiones;vl_AnotacionesNeutras;vl_TotalRetardoAcumulado)
C_LONGINT:C283(vl_inasistencias;vl_InasistenciasJustificadas;vl_HorasInasistencia;vl_AtrasosJornada;vl_AtrasosSesion)
C_REAL:C285(vr_FaltasPorAtrasosJornada;vr_FaltasPorAtrasosSesion;vr_PorcentajeAsistencia)
vl_AnotacionesNegativas:=0
vl_AnotacionesPositivas:=0
vl_PuntosNegativos:=0
vl_PuntosPositivos:=0
vl_Castigos:=0
vl_suspensiones:=0
vl_AnotacionesNeutras:=0
vl_TotalRetardoAcumulado:=0
vl_inasistencias:=0
vl_InasistenciasJustificadas:=0
vl_HorasInasistencia:=0
vl_AtrasosJornada:=0
vl_AtrasosSesion:=0
vr_FaltasPorAtrasosJornada:=0
vr_FaltasPorAtrasosSesion:=0
vr_PorcentajeAsistencia:=0

$l_idAlumno:=$1
$l_año:=<>gYear
$l_nivel:=[Alumnos:2]nivel_numero:29
$l_periodo:=0
Case of 
	: (Count parameters:C259=4)
		$l_año:=$2
		$l_nivel:=$3
		$l_periodo:=$4
		
	: (Count parameters:C259=3)
		$l_año:=$2
		$l_nivel:=$3
		
	: (Count parameters:C259=2)
		$l_año:=$2
End case 

$l_año:=Choose:C955($l_año=0;<>gYear;$l_año)
$l_Nivel:=Choose:C955($l_Nivel=0;[Alumnos:2]nivel_numero:29;$l_Nivel)


$t_llave:=String:C10(<>gInstitucion)+"."+String:C10($l_año)+"."+String:C10($l_nivel)+"."+String:C10($l_idAlumno)

If (($l_nivel>Nivel_AdmisionDirecta) & ($l_nivel<Nivel_Egresados))
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llave)
	If ($recNum<0)
		AL_CreaRegistrosSintesis ($l_idAlumno;$l_año;$l_nivel;<>gInstitucion)
	End if 
Else 
	REDUCE SELECTION:C351([Alumnos_SintesisAnual:210];0)
End if 

bCondicional:=Num:C11([Alumnos_SintesisAnual:210]Condicionalidad_Activada:57)
vd_fechaCondicionalidad:=[Alumnos_SintesisAnual:210]Condicionalidad_Hasta:58
vt_motivoCondicionalidad:=[Alumnos_SintesisAnual:210]Condicionalidad_Motivo:59
Case of 
	: ($l_periodo=0)
		vl_inasistencias:=[Alumnos_SintesisAnual:210]Inasistencias_Dias:30
		vl_InasistenciasJustificadas:=[Alumnos_SintesisAnual:210]InasistenciasJustif_Dias:49
		vl_HorasInasistencia:=[Alumnos_SintesisAnual:210]Inasistencias_Horas:31
		vl_AtrasosJornada:=[Alumnos_SintesisAnual:210]Atrasos_Jornada:40
		vl_AtrasosSesion:=[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41
		vr_FaltasPorAtrasosJornada:=[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45
		vr_FaltasPorAtrasosSesion:=[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46
		vr_PorcentajeAsistencia:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
		vl_AnotacionesNegativas:=[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36
		vl_AnotacionesPositivas:=[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34
		vl_PuntosNegativos:=[Alumnos_SintesisAnual:210]PuntajeConductual_Negativo:38
		vl_PuntosPositivos:=[Alumnos_SintesisAnual:210]PuntajeConductual_Positivo:37
		vl_Castigos:=[Alumnos_SintesisAnual:210]Castigos:43
		vl_suspensiones:=[Alumnos_SintesisAnual:210]Suspensiones:44
		vl_AnotacionesNeutras:=[Alumnos_SintesisAnual:210]Anotaciones_Neutras:35
		vl_TotalRetardoAcumulado:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51
		vl_TotalAtrasos:=vl_AtrasosJornada+vl_AtrasosSesion
		  //If ($l_año=<>gYear)
		  //vr_PorcentajeAsistenciaAnual:=Round((viSTR_Periodos_DiasAgno-vl_inasistencias)/viSTR_Periodos_DiasAgno*100;1)
		  //End if
		
	: ($l_periodo=1)
		vl_inasistencias:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97
		vl_InasistenciasJustificadas:=[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116
		vl_HorasInasistencia:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98
		vl_AtrasosJornada:=[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107
		vl_AtrasosSesion:=[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108
		vr_FaltasPorAtrasosJornada:=[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112
		vr_FaltasPorAtrasosSesion:=[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113
		vr_PorcentajeAsistencia:=[Alumnos_SintesisAnual:210]P01_PorcentajeAsistencia:100
		vl_AnotacionesNegativas:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103
		vl_AnotacionesPositivas:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101
		vl_PuntosNegativos:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Negativo:105
		vl_PuntosPositivos:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Positivo:104
		vl_Castigos:=[Alumnos_SintesisAnual:210]P01_Castigos:110
		vl_suspensiones:=[Alumnos_SintesisAnual:210]P01_Suspensiones:111
		vl_AnotacionesNeutras:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Neutras:102
		vl_TotalRetardoAcumulado:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51
		vl_TotalAtrasos:=vl_AtrasosJornada+vl_AtrasosSesion
		
	: ($l_periodo=2)
		vl_inasistencias:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126
		vl_InasistenciasJustificadas:=[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145
		vl_HorasInasistencia:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127
		vl_AtrasosJornada:=[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136
		vl_AtrasosSesion:=[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137
		vr_FaltasPorAtrasosJornada:=[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141
		vr_FaltasPorAtrasosSesion:=[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142
		vr_PorcentajeAsistencia:=[Alumnos_SintesisAnual:210]P02_PorcentajeAsistencia:129
		vl_AnotacionesNegativas:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132
		vl_AnotacionesPositivas:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130
		vl_PuntosNegativos:=[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Negativo:134
		vl_PuntosPositivos:=[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Positivo:133
		vl_Castigos:=[Alumnos_SintesisAnual:210]P02_Castigos:139
		vl_suspensiones:=[Alumnos_SintesisAnual:210]P02_Suspensiones:140
		vl_AnotacionesNeutras:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Neutras:131
		vl_TotalRetardoAcumulado:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51
		vl_TotalAtrasos:=vl_AtrasosJornada+vl_AtrasosSesion
		
	: ($l_periodo=3)
		vl_inasistencias:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155
		vl_InasistenciasJustificadas:=[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174
		vl_HorasInasistencia:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156
		vl_AtrasosJornada:=[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165
		vl_AtrasosSesion:=[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166
		vr_FaltasPorAtrasosJornada:=[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170
		vr_FaltasPorAtrasosSesion:=[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171
		vr_PorcentajeAsistencia:=[Alumnos_SintesisAnual:210]P03_PorcentajeAsistencia:158
		vl_AnotacionesNegativas:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161
		vl_AnotacionesPositivas:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159
		vl_PuntosNegativos:=[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Negativo:163
		vl_PuntosPositivos:=[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Positivo:162
		vl_Castigos:=[Alumnos_SintesisAnual:210]P03_Castigos:168
		vl_suspensiones:=[Alumnos_SintesisAnual:210]P03_Suspensiones:169
		vl_AnotacionesNeutras:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Neutras:160
		vl_TotalRetardoAcumulado:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51
		vl_TotalAtrasos:=vl_AtrasosJornada+vl_AtrasosSesion
		
	: ($l_periodo=4)
		vl_inasistencias:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184
		vl_InasistenciasJustificadas:=[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203
		vl_HorasInasistencia:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185
		vl_AtrasosJornada:=[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194
		vl_AtrasosSesion:=[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195
		vr_FaltasPorAtrasosJornada:=[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199
		vr_FaltasPorAtrasosSesion:=[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200
		vr_PorcentajeAsistencia:=[Alumnos_SintesisAnual:210]P04_PorcentajeAsistencia:187
		vl_AnotacionesNegativas:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190
		vl_AnotacionesPositivas:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188
		vl_PuntosNegativos:=[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Negativo:192
		vl_PuntosPositivos:=[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Positivo:191
		vl_Castigos:=[Alumnos_SintesisAnual:210]P04_Castigos:197
		vl_suspensiones:=[Alumnos_SintesisAnual:210]P04_Suspensiones:198
		vl_AnotacionesNeutras:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Neutras:189
		vl_TotalRetardoAcumulado:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51
		vl_TotalAtrasos:=vl_AtrasosJornada+vl_AtrasosSesion
		
	: ($l_periodo=5)
		vl_inasistencias:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213
		vl_InasistenciasJustificadas:=[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232
		vl_HorasInasistencia:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214
		vl_AtrasosJornada:=[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223
		vl_AtrasosSesion:=[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224
		vr_FaltasPorAtrasosJornada:=[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228
		vr_FaltasPorAtrasosSesion:=[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229
		vr_PorcentajeAsistencia:=[Alumnos_SintesisAnual:210]P05_PorcentajeAsistencia:216
		vl_AnotacionesNegativas:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219
		vl_AnotacionesPositivas:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217
		vl_PuntosNegativos:=[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Negativo:221
		vl_PuntosPositivos:=[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Positivo:220
		vl_Castigos:=[Alumnos_SintesisAnual:210]P05_Castigos:226
		vl_suspensiones:=[Alumnos_SintesisAnual:210]P05_Suspensiones:227
		vl_AnotacionesNeutras:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Neutras:218
		vl_TotalRetardoAcumulado:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51
		vl_TotalAtrasos:=vl_AtrasosJornada+vl_AtrasosSesion
		
End case 

$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
Case of 
	: (($modoRegistroAsistencia=2) | ($modoRegistroAsistencia=4))
		If (<>vr_InasistenciasXatrasos>0)
			vs_FaltasPorAtrasos:=String:C10(vr_FaltasPorAtrasosSesion)+" horas"
		Else 
			vs_FaltasPorAtrasos:=""
		End if 
		
	: ($modoRegistroAsistencia=1)
		If (<>vr_InasistenciasXatrasos>0)
			vs_FaltasPorAtrasos:=String:C10(vr_FaltasPorAtrasosJornada+vr_FaltasPorAtrasosSesion)+" días"
		Else 
			vs_FaltasPorAtrasos:=""
		End if 
		
	Else 
		vs_FaltasPorAtrasos:=""
End case 



  //LIMPIEZA





