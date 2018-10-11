//%attributes = {}
  // AL_TotalizaInasistencias()
  // Por: Alberto Bachler: 09/08/13, 09:40:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_recargarRegistro)
C_LONGINT:C283($l_modoRegistroAsistencia;$l_numeroNivel;$l_recNum;$l_valorCampo;$l_IdAlumno)
C_REAL:C285($r_porcentajeAsistencia)
C_TEXT:C284($t_llaveSintesisAnual)
If (False:C215)
	C_BOOLEAN:C305(AL_TotalizaInasistencias ;$0)
	C_LONGINT:C283(AL_TotalizaInasistencias ;$1)
End if 
$0:=True:C214


If (Not:C34(<>vb_BloquearModifSituacionFinal))
	$l_IdAlumno:=$1
	$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_IdAlumno;True:C214)
	
	If (Count parameters:C259=2)
		$l_numeroNivel:=$2
	End if 
	
	If ($l_numeroNivel=0)
		$l_numeroNivel:=[Alumnos:2]nivel_numero:29
	End if 
	
	If ($l_recNum>=0)
		PERIODOS_LoadData ($l_numeroNivel)
		  //conservo el porcentaje de asistencia actual en variable para compararlos con el nuevo resultado y decidir si es necesario recalcular la situación final
		$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($l_numeroNivel)+"."+String:C10($l_IdAlumno)
		$r_porcentajeAsistencia:=0
		AL_LeeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;->$r_porcentajeAsistencia)
		
		If ($l_numeroNivel=[Alumnos:2]nivel_numero:29)
			[Alumnos:2]Porcentaje_asistencia:56:=100
			SAVE RECORD:C53([Alumnos:2])
			KRL_ReloadAsReadOnly (->[Alumnos:2])
		End if 
		
		$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_numeroNivel;->[xxSTR_Niveles:6]AttendanceMode:3)
		If ($l_modoRegistroAsistencia=2)
			QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$l_IdAlumno;*)
			QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1>=vdSTR_Periodos_InicioEjercicio;*)
			QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1<=vdSTR_Periodos_FinEjercicio)
			KRL_DeleteSelection (->[Alumnos_Inasistencias:10];False:C215)
		End if 
		
		  //inicialización de los campos de sintesis relacionados con inasistencias
		$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($l_numeroNivel)+"."+String:C10($l_IdAlumno)
		$l_valorCampo:=100
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;->$l_valorCampo;False:C215)
		$l_valorCampo:=0
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]InasistenciasInjustif_Dias:50;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]InasistenciasJustif_Dias:49;->$l_valorCampo;False:C215)
		If ($l_modoRegistroAsistencia#3)  //si el registro es anual el número de inasistencias es registrado directamente, no se inicializan los valores
			AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]Inasistencias_Dias:30;->$l_valorCampo;False:C215)
		End if 
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213;->$l_valorCampo;False:C215)  //
		
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]HorasEfectivas:32;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]Inasistencias_Horas:31;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215;->$l_valorCampo;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214;->$l_valorCampo;True:C214)
		AL_EscribeSintesisAnual 
		
		Case of 
			: ($l_modoRegistroAsistencia=1)
				AL_TotalizaDiasInasistencia ($l_IdAlumno;$l_numeroNivel)
				AL_ConectaLicencias ($l_IdAlumno)
				
			: (($l_modoRegistroAsistencia=2) | ($l_modoRegistroAsistencia=4))
				AL_TotalizaHorasDeClase ($l_IdAlumno;$l_numeroNivel)
				AL_ConectaLicencias ($l_IdAlumno)
				
		End case 
		
		$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_IdAlumno;True:C214)
		$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($l_numeroNivel)+"."+String:C10($l_IdAlumno)
		
		If (Application type:C494=4D Remote mode:K5:5)
			$b_recargarRegistro:=False:C215
		Else 
			$b_recargarRegistro:=True:C214
		End if 
		AL_LeeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;->[Alumnos:2]Porcentaje_asistencia:56;$b_recargarRegistro)
		SAVE RECORD:C53([Alumnos:2])
		KRL_ReloadAsReadOnly (->[Alumnos:2])
		
	Else 
		$0:=False:C215
	End if 
Else 
	$0:=True:C214
End if 