//%attributes = {}
  // AL_ReconstruyeSintesisHistorico
  // Este método debe ser utilizado cuidadosamente
  // Reconstruye información en los registro de síntesis anual historica que están en la selección
  // Debe ser llamado después de crear dicha selección
  // basandose en en la información almacenada en  la BD
  // - Se recalculan los promedios generales del alumno
  // - Se calculan los totales de inasistencias, atrasos, anotaciones (negativas y positivas), castigos y suspensiones
  //   y el porcentaje de asistencia
  //   NO ESTA IMPLEMENTADO EL CALCULO BASADO EN ASISTENCIA A SESIONES
  // - Si el campo situación final está vacío, se calcula la situación final basándose en el registro de síntesis anual del año siguiente
  //   sin tener en cuenta promoción anticipada, en situación de recuperación (en algunos países) o calidad de oyente.
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 13/07/12, 12:30:18
  // ---------------------------------------------
C_LONGINT:C283($l_IdAlumno;$i)
C_TEXT:C284($t_llaveRegistroHistorico;$t_llaveSintesisAnualSiguiente)

ARRAY LONGINT:C221($al_recNumsSintesisAnual;0)





  // CÓDIGO
LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$al_recNumsSintesisAnual;"")
For ($i;1;Size of array:C274($al_recNumsSintesisAnual))
	READ WRITE:C146([Alumnos_SintesisAnual:210])
	KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$al_recNumsSintesisAnual{$i};True:C214)
	If ([Alumnos_SintesisAnual:210]Año:2<<>gYear)
		
		  // calculo de promedios
		AL_CalculaPromedioGeneralHist (Record number:C243([Alumnos_SintesisAnual:210]))
		
		KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$al_recNumsSintesisAnual{$i};True:C214)
		  // inasistencias
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos_SintesisAnual:210]ID_Alumno:4;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Año:8=[Alumnos_SintesisAnual:210]Año:2)
		[Alumnos_SintesisAnual:210]Inasistencias_Dias:30:=Records in selection:C76([Alumnos_Inasistencias:10])
		  // porcentaje de asistencia
		PERIODOS_LeeDatosHistoricos ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Año:2)
		If (viSTR_Periodos_DiasAgno>0)
			[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=Round:C94((viSTR_Periodos_DiasAgno-[Alumnos_SintesisAnual:210]Inasistencias_Dias:30)/viSTR_Periodos_DiasAgno*100;1)
		End if 
		
		  // atrasos
		QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos_SintesisAnual:210]ID_Alumno:4;*)
		QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Año:6=[Alumnos_SintesisAnual:210]Año:2)
		[Alumnos_SintesisAnual:210]Atrasos_Jornada:40:=Records in selection:C76([Alumnos_Atrasos:55])
		
		  //anotaciones positivas
		QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=[Alumnos_SintesisAnual:210]ID_Alumno:4;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & [Alumnos_Anotaciones:11]Año:11=[Alumnos_SintesisAnual:210]Año:2;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & [Alumnos_Anotaciones:11]Es_Positiva:2=False:C215)
		[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36:=Records in selection:C76([Alumnos_Anotaciones:11])
		
		  //anotaciones negativas
		QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=[Alumnos_SintesisAnual:210]ID_Alumno:4;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & [Alumnos_Anotaciones:11]Año:11=[Alumnos_SintesisAnual:210]Año:2;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & [Alumnos_Anotaciones:11]Es_Positiva:2=True:C214)
		[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34:=Records in selection:C76([Alumnos_Anotaciones:11])
		
		  // castigos
		QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8=[Alumnos_SintesisAnual:210]ID_Alumno:4;*)
		QUERY:C277([Alumnos_Castigos:9]; & [Alumnos_Castigos:9]Año:5=[Alumnos_SintesisAnual:210]Año:2)
		[Alumnos_SintesisAnual:210]Castigos:43:=Records in selection:C76([Alumnos_Castigos:9])
		
		  // suspensiones
		QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7=[Alumnos_SintesisAnual:210]ID_Alumno:4;*)
		QUERY:C277([Alumnos_Suspensiones:12]; & [Alumnos_Suspensiones:12]Año:1=[Alumnos_SintesisAnual:210]Año:2)
		[Alumnos_SintesisAnual:210]Suspensiones:44:=Records in selection:C76([Alumnos_Suspensiones:12])
		
		SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		
		If (([Alumnos_SintesisAnual:210]Año:2<<>gYear) & ([Alumnos_SintesisAnual:210]SituacionFinal:8=""))
			$t_llaveSintesisAnualSiguiente:="0."+String:C10([Alumnos_SintesisAnual:210]Año:2+1)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6+1)+"."+String:C10(Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4))
			$l_IdAlumno:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_IdAlumno;False:C215)
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]LlavePrincipal:5=$t_llaveRegistroHistorico)
			Case of 
				: ([Alumnos:2]Fecha_de_retiro:42<vdSTR_Periodos_FinEjercicio)
					[Alumnos_SintesisAnual:210]SituacionFinal:8:="Y"
				: ([Alumnos:2]Fecha_Deceso:98<vdSTR_Periodos_FinEjercicio)
					[Alumnos_SintesisAnual:210]SituacionFinal:8:="F"
				: (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
					KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$al_recNumsSintesisAnual{$i};True:C214)
					Case of 
						: (<>vtXS_CountryCode="cl")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
						: (<>vtXS_CountryCode="pe")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="A"
						: (<>vtXS_CountryCode="ar")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
						: (<>vtXS_CountryCode="co")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
						: (<>vtXS_CountryCode="mx")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
						: (<>vtXS_CountryCode="vz")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
						Else 
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
					End case 
				Else 
					Case of 
						: (<>vtXS_CountryCode="cl")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
						: (<>vtXS_CountryCode="pe")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="D"
						: (<>vtXS_CountryCode="ar")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
						: (<>vtXS_CountryCode="co")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
						: (<>vtXS_CountryCode="mx")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
						: (<>vtXS_CountryCode="vz")
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
						Else 
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
					End case 
			End case 
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		End if 
	End if 
End for 
KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])