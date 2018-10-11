//%attributes = {}
  // AL_CalculaPorcentajeAsistencia()
  // Por: Alberto Bachler K.: 16-06-14, 11:31:00
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_periodo)
C_LONGINT:C283($l_diasHabiles;$l_diashastaHoy;$l_diasHastaRetiro;$l_diasPeriodo;$l_modoRegistroAsistencia)
C_POINTER:C301($y_DiasHabiles;$y_FaltasRetardoJornada;$y_FaltasRetardoSesiones;$y_HorasEfectivas;$y_horasInasistencia;$y_numeroInasistenciasDiarias;$y_PorcentajeAsistencia)


PERIODOS_LoadData ([Alumnos_SintesisAnual:210]NumeroNivel:6)
[Alumnos_SintesisAnual:210]TotalDiasHabiles:60:=viSTR_Periodos_DiasAgno
$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)

[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97:=[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116+[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117
[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126:=[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145+[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146
[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155:=[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174+[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175
[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184:=[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203+[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204
[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213:=[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232+[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233
If ($l_modoRegistroAsistencia#3)
	[Alumnos_SintesisAnual:210]Inasistencias_Dias:30:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97+[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126+[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155+[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184+[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213
End if 
[Alumnos_SintesisAnual:210]InasistenciasJustif_Dias:49:=[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116+[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145+[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174+[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203+[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232
[Alumnos_SintesisAnual:210]InasistenciasInjustif_Dias:50:=[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117+[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146+[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175+[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204+[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233
[Alumnos_SintesisAnual:210]Inasistencias_Horas:31:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98+[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127+[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156+[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185+[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214
[Alumnos_SintesisAnual:210]HorasEfectivas:32:=[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99+[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128+[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157+[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186+[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215

  // Calculo del promedio de asistencia periódico
For ($i_periodo;1;viSTR_Periodos_NumeroPeriodos)
	Case of 
		: ($i_periodo=1)
			$y_PorcentajeAsistencia:=->[Alumnos_SintesisAnual:210]P01_PorcentajeAsistencia:100
			$y_numeroInasistenciasDiarias:=->[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97
			$y_FaltasRetardoJornada:=->[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112
			$y_FaltasRetardoSesiones:=->[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113
			$y_horasInasistencia:=->[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98
			$y_HorasEfectivas:=->[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99
			$y_DiasHabiles:=->[Alumnos_SintesisAnual:210]P01_DiasHabiles:118
		: ($i_periodo=2)
			$y_PorcentajeAsistencia:=->[Alumnos_SintesisAnual:210]P02_PorcentajeAsistencia:129
			$y_numeroInasistenciasDiarias:=->[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126
			$y_FaltasRetardoJornada:=->[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141
			$y_FaltasRetardoSesiones:=->[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142
			$y_horasInasistencia:=->[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127
			$y_HorasEfectivas:=->[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128
			$y_DiasHabiles:=->[Alumnos_SintesisAnual:210]P02_DiasHabiles:147
		: ($i_periodo=3)
			$y_PorcentajeAsistencia:=->[Alumnos_SintesisAnual:210]P03_PorcentajeAsistencia:158
			$y_numeroInasistenciasDiarias:=->[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155
			$y_FaltasRetardoJornada:=->[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170
			$y_FaltasRetardoSesiones:=->[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171
			$y_horasInasistencia:=->[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156
			$y_HorasEfectivas:=->[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157
			$y_DiasHabiles:=->[Alumnos_SintesisAnual:210]P03_DiasHabiles:176
		: ($i_periodo=4)
			$y_PorcentajeAsistencia:=->[Alumnos_SintesisAnual:210]P04_PorcentajeAsistencia:187
			$y_numeroInasistenciasDiarias:=->[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184
			$y_FaltasRetardoJornada:=->[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199
			$y_FaltasRetardoSesiones:=->[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200
			$y_horasInasistencia:=->[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185
			$y_HorasEfectivas:=->[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186
			$y_DiasHabiles:=->[Alumnos_SintesisAnual:210]P04_DiasHabiles:205
		: ($i_periodo=5)
			$y_PorcentajeAsistencia:=->[Alumnos_SintesisAnual:210]P05_PorcentajeAsistencia:216
			$y_numeroInasistenciasDiarias:=->[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213
			$y_FaltasRetardoJornada:=->[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228
			$y_FaltasRetardoSesiones:=->[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229
			$y_horasInasistencia:=->[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214
			$y_HorasEfectivas:=->[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215
			$y_DiasHabiles:=->[Alumnos_SintesisAnual:210]P05_DiasHabiles:234
	End case 
	
	$y_DiasHabiles->:=aiSTR_Periodos_Dias{$i_periodo}
	
	Case of 
		: (([Alumnos:2]Fecha_de_retiro:42<adSTR_Periodos_Desde{$i_periodo}) & (([Alumnos:2]Status:50="Retirado@") | ([Alumnos:2]Status:50="Promovido anticipadamente")))
			$y_PorcentajeAsistencia->:=0
			
		: ($l_modoRegistroAsistencia=1) | ($l_modoRegistroAsistencia=3)  //asistencia diaria o registro anual único
			$l_diasPeriodo:=DT_GetWorkingDays (adSTR_Periodos_Desde{$i_periodo};adSTR_Periodos_Hasta{$i_periodo})
			Case of 
				: (Current date:C33(*)<adSTR_Periodos_Desde{$i_periodo})
					$y_PorcentajeAsistencia->:=100
					
				: ((Current date:C33(*)>[Alumnos:2]Fecha_de_retiro:42) & ([Alumnos:2]Status:50="Retirado@") & ([Alumnos:2]Fecha_de_retiro:42>=adSTR_Periodos_Desde{$i_periodo}) & ([Alumnos:2]Fecha_de_retiro:42<=adSTR_Periodos_Hasta{$i_periodo}))
					$l_diasHastaRetiro:=DT_GetWorkingDays (adSTR_Periodos_Desde{$i_periodo};[Alumnos:2]Fecha_de_retiro:42)
					[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=Round:C94(($l_diasHastaRetiro-[Alumnos_SintesisAnual:210]Inasistencias_Dias:30-[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45-[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46)/$l_diasHastaRetiro*100;1)
					
				: ((Current date:C33(*)>[Alumnos:2]Fecha_de_retiro:42) & ([Alumnos:2]Status:50="Promovido anticipadamente") & ([Alumnos:2]Fecha_de_retiro:42>=adSTR_Periodos_Desde{$i_periodo}) & ([Alumnos:2]Fecha_de_retiro:42<=adSTR_Periodos_Hasta{$i_periodo}))
					$l_diasHastaRetiro:=DT_GetWorkingDays (adSTR_Periodos_Desde{$i_periodo};[Alumnos:2]Fecha_de_retiro:42)
					[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=Round:C94(($l_diasHastaRetiro-[Alumnos_SintesisAnual:210]Inasistencias_Dias:30-[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45-[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46)/$l_diasHastaRetiro*100;1)
					
				: ((Current date:C33(*)>=adSTR_Periodos_Desde{$i_periodo}) & (Current date:C33(*)<=adSTR_Periodos_Hasta{$i_periodo}))
					$l_diashastaHoy:=DT_GetWorkingDays (adSTR_Periodos_Desde{$i_periodo};Current date:C33(*))
					Case of 
						: ($l_diashastaHoy=0)
							$y_PorcentajeAsistencia->:=100
						Else 
							$y_PorcentajeAsistencia->:=Round:C94(($l_diashastaHoy-$y_numeroInasistenciasDiarias->-$y_FaltasRetardoJornada->-$y_FaltasRetardoSesiones->)/$l_diashastaHoy*100;1)
					End case 
					
				: (Current date:C33(*)>adSTR_Periodos_Hasta{$i_periodo})
					If ($l_diasPeriodo=0)
						$y_PorcentajeAsistencia->:=100
					Else 
						$y_PorcentajeAsistencia->:=Round:C94(($l_diasPeriodo-$y_numeroInasistenciasDiarias->-$y_FaltasRetardoJornada->-$y_FaltasRetardoSesiones->)/$l_diasPeriodo*100;1)
					End if 
			End case 
			
		: (($l_modoRegistroAsistencia=2) | ($l_modoRegistroAsistencia=4))  //asistencia por hora
			If ($y_HorasEfectivas->>0)
				Case of 
						
					Else 
						$y_PorcentajeAsistencia->:=Round:C94(($y_HorasEfectivas->-$y_horasInasistencia->)/$y_HorasEfectivas->*100;1)
				End case 
			End if 
	End case 
	
End for 

  //calculo del porcentaje de asistencia anual
Case of 
	: ($l_modoRegistroAsistencia=1) | ($l_modoRegistroAsistencia=3)  //asistencia diaria o registro anual único
		Case of 
			: (([Alumnos:2]Fecha_de_retiro:42<vdSTR_Periodos_InicioEjercicio) & (([Alumnos:2]Status:50="Retirado@") | ([Alumnos:2]Status:50="Promovido anticipadamente")))
				$y_PorcentajeAsistencia->:=0
				
			: (Current date:C33(*)<vdSTR_Periodos_InicioEjercicio)
				[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=100
				
			: ((Current date:C33(*)>[Alumnos:2]Fecha_de_retiro:42) & ([Alumnos:2]Status:50="Retirado@") & ([Alumnos:2]Fecha_de_retiro:42>=vdSTR_Periodos_InicioEjercicio) & ([Alumnos:2]Fecha_de_retiro:42<=vdSTR_Periodos_FinEjercicio))
				$l_diasHabiles:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;[Alumnos:2]Fecha_de_retiro:42)
				[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=Round:C94(($l_diasHabiles-[Alumnos_SintesisAnual:210]Inasistencias_Dias:30-[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45-[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46)/$l_diasHabiles*100;1)
				
			: ((Current date:C33(*)>[Alumnos:2]Fecha_de_retiro:42) & ([Alumnos:2]Status:50="Promovido anticipadamente") & ([Alumnos:2]Fecha_de_retiro:42>=vdSTR_Periodos_InicioEjercicio) & ([Alumnos:2]Fecha_de_retiro:42<=vdSTR_Periodos_FinEjercicio))
				$l_diasHabiles:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;[Alumnos:2]Fecha_de_retiro:42)
				[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=Round:C94(($l_diasHabiles-[Alumnos_SintesisAnual:210]Inasistencias_Dias:30-[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45-[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46)/$l_diasHabiles*100;1)
				
			: (Current date:C33(*)<=vdSTR_Periodos_FinEjercicio)
				Case of 
					: (viSTR_Calendario_DiasAHoy=0)
						[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=100
						
					Else 
						[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=Round:C94((viSTR_Calendario_DiasAHoy-[Alumnos_SintesisAnual:210]Inasistencias_Dias:30-[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45-[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46)/viSTR_Calendario_DiasAHoy*100;1)
				End case 
				
			: (Current date:C33(*)>vdSTR_Periodos_FinEjercicio)
				Case of 
					: (viSTR_Calendario_DiasAHoy=0)
						[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=100
						
					: (([Alumnos:2]Status:50="Retirado@") & ([Alumnos:2]Fecha_de_retiro:42>=vdSTR_Periodos_InicioEjercicio) & ([Alumnos:2]Fecha_de_retiro:42<=vdSTR_Periodos_FinEjercicio))
						$l_diasHabiles:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;[Alumnos:2]Fecha_de_retiro:42)
						[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=Round:C94(($l_diasHabiles-[Alumnos_SintesisAnual:210]Inasistencias_Dias:30-[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45-[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46)/$l_diasHabiles*100;1)
						
					: (([Alumnos:2]Status:50="Promovido anticipadamente") & ([Alumnos:2]Fecha_de_retiro:42>=vdSTR_Periodos_InicioEjercicio) & ([Alumnos:2]Fecha_de_retiro:42<=vdSTR_Periodos_FinEjercicio))
						$l_diasHabiles:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;[Alumnos:2]Fecha_de_retiro:42)
						[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=Round:C94(($l_diasHabiles-[Alumnos_SintesisAnual:210]Inasistencias_Dias:30-[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45-[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46)/$l_diasHabiles*100;1)
						
					Else 
						[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=Round:C94((viSTR_Periodos_DiasAgno-[Alumnos_SintesisAnual:210]Inasistencias_Dias:30-[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45-[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46)/viSTR_Calendario_DiasAHoy*100;1)
				End case 
		End case 
		
	: (($l_modoRegistroAsistencia=2) | ($l_modoRegistroAsistencia=4))  //asistencia por hora
		
		If ([Alumnos_SintesisAnual:210]HorasEfectivas:32>0)
			Case of 
				: (([Alumnos:2]Fecha_de_retiro:42<vdSTR_Periodos_InicioEjercicio) & (([Alumnos:2]Status:50="Retirado@") | ([Alumnos:2]Status:50="Promovido anticipadamente")))
					[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=0
				Else 
					[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=Round:C94(([Alumnos_SintesisAnual:210]HorasEfectivas:32-[Alumnos_SintesisAnual:210]Inasistencias_Horas:31-[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46)/[Alumnos_SintesisAnual:210]HorasEfectivas:32*100;1)
			End case 
			
		End if 
End case 
