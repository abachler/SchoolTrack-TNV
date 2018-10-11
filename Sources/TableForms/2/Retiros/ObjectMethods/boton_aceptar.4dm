  // [Alumnos].Retiros.boton_aceptar()
  // Por: Alberto Bachler K.: 23-05-14, 20:20:35
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305($b_GuardarCambios)
C_LONGINT:C283($l_recNumAlumno)
C_POINTER:C301($y_ReriradoTemporalmente)
C_TEXT:C284($t_EstadoActual;$t_NuevoEstado)


$l_recNumAlumno:=Record number:C243([Alumnos:2])
$t_NuevoEstado:=[Alumnos:2]Status:50
$t_EstadoActual:=Old:C35([Alumnos:2]Status:50)

Case of 
	: (($t_NuevoEstado="Retirado@") & ($t_EstadoActual="Retirado@"))
		If ([Alumnos:2]Fecha_de_retiro:42#!00-00-00!)
			[Alumnos:2]ocultoEnNominas:89:=(OBJECT Get pointer:C1124(Object named:K67:5;"cb_ocultarEnNominas")->=1)
			If (OBJECT Get pointer:C1124(Object named:K67:5;"cb_retiradoTemporalmente")->=1)
				[Alumnos:2]Status:50:="Retirado Temporalmente"
			Else 
				[Alumnos:2]Status:50:="Retirado"
			End if 
			$b_GuardarCambios:=True:C214
		Else 
			ModernUI_Notificacion ("La fecha de retiro no puede quedar en blanco")
		End if 
		
	: ($t_NuevoEstado="Retirado@")
		If ([Alumnos:2]Fecha_de_retiro:42#!00-00-00!)
			[Alumnos:2]ocultoEnNominas:89:=(OBJECT Get pointer:C1124(Object named:K67:5;"cb_ocultarEnNominas")->=1)
			[Alumnos:2]NoNIvel_alRetirarse:84:=[Alumnos:2]nivel_numero:29
			[Alumnos:2]Curso_alRetirarse:83:=[Alumnos:2]curso:20
			[Alumnos:2]Status:50:=$t_nuevoEstado
			[Alumnos:2]Situacion_final:33:="Y"
			[Alumnos:2]Tutor_numero:36:=0
			If (OBJECT Get pointer:C1124(Object named:K67:5;"cb_retiradoTemporalmente")->=1)
				[Alumnos:2]Status:50:="Retirado Temporalmente"
			Else 
				[Alumnos:2]Status:50:="Retirado"
			End if 
			
			If (<>viSTR_ForzarMotivoRetiro=1)
				If ([Alumnos:2]Motivo_de_retiro:43="")
					$b_GuardarCambios:=False:C215
					ModernUI_Notificacion ("Debe seleccionar un motivo de retiro.")
				Else 
					$b_GuardarCambios:=AL_EliminaInfoPostRetiro 
				End if 
			Else 
				$b_GuardarCambios:=AL_EliminaInfoPostRetiro 
			End if 
		Else 
			ModernUI_Notificacion ("La fecha de retiro no puede quedar en blanco")
		End if 
		
	: (($t_NuevoEstado="Activo") | ($t_NuevoEstado="Oyente") | ($t_NuevoEstado="En Trámite"))
		[Alumnos:2]ocultoEnNominas:89:=False:C215
		If ([Alumnos:2]nivel_numero:29=Nivel_Retirados)
			[Alumnos:2]nivel_numero:29:=[Alumnos:2]NoNIvel_alRetirarse:84
			[Alumnos:2]curso:20:=[Alumnos:2]Curso_alRetirarse:83
			[Alumnos:2]Nivel_Nombre:34:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]NoNIvel_alRetirarse:84;->[xxSTR_Niveles:6]Nivel:1)
		End if 
		[Alumnos:2]Fecha_de_retiro:42:=!00-00-00!
		[Alumnos:2]Status:50:=$t_nuevoEstado
		[Alumnos:2]Situacion_final:33:=""
		[Alumnos:2]Motivo_de_retiro:43:=""
		[Alumnos:2]Colegio_destino:102:=""
		$b_GuardarCambios:=True:C214
End case 

If ($b_GuardarCambios)
	SAVE RECORD:C53([Alumnos:2])
	KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
	[Alumnos_SintesisAnual:210]Curso:7:=[Alumnos:2]curso:20
	[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61:=False:C215
	SAVE RECORD:C53([Alumnos_SintesisAnual:210])
	KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
	AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
	
	KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
	If (($t_NuevoEstado="Activo") | ($t_NuevoEstado="Oyente") | ($t_NuevoEstado="En Trámite"))
		AL_CreateGradeRecords 
	End if 
	
	KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
	  //If (($t_NuevoEstado="Retirado@") & (($t_NuevoEstado="Activo") | ($t_NuevoEstado="Oyente") | ($t_NuevoEstado="En Trámite")))
	If (($t_NuevoEstado="Retirado@") & (($t_EstadoActual="Activo") | ($t_EstadoActual="Oyente") | ($t_EstadoActual="En Trámite")))  //20180628 ASM/JHB 
		AL_RetiroAlumno_EstadoADT ([Alumnos:2]numero:1)
		BM_CreateRequest ("co-AsignaNumerosDeFolio")  // solo se ejecuta para Colombia
	End if 
	
	
	If ($t_NuevoEstado="Retirado@")
		  // Modificado por: Saúl Ponce (17-05-2017) Ticket Nº 177176, para inactivar familias y relaciones familiares al retirar alumnos
		C_BOOLEAN:C305($vb_realizado)
		C_LONGINT:C283($vl_numFamilia;$vl_alumnoNum)
		$vl_numFamilia:=0
		$vl_recNumAlumno:=0
		
		$vl_numFamilia:=[Alumnos:2]Familia_Número:24
		$vl_alumnoNum:=[Alumnos:2]numero:1
		
		QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="activo";*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]numero:1#$vl_alumnoNum;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24=$vl_numFamilia)
		If (Records in selection:C76([Alumnos:2])=0)
			$vb_realizado:=AL_InactivaRegistroRelacionados ("InactivaFamilia";$vl_numFamilia)
			$vb_realizado:=AL_InactivaRegistroRelacionados ("InactivaPersonasRelacionadas";$vl_numFamilia)
		End if 
	End if 
	
	
	KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
	If ($t_NuevoEstado#$t_EstadoActual)
		LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_EstadoActual+" a "+$t_nuevoEstado)
	End if 
	ACCEPT:C269
End if 

