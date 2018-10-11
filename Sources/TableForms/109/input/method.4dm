Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		btAlumnos:=1
		
		  //*************************************** REGISTROS DE VIAJES **********************************************
		
		  //Configuration commands for ALP object 'xALP_BUAsistentes'
		  //You can paste this into an ALP object's method, rather than
		  //use the Advanced Properties dialog to control the configuration.
		  //Commands always have priority over the settings in the dialog.
		
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;1;"atBU_Nombre";__ ("Nombre");170)
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;2;"ap_Asistencia";__ ("Asistencia");80;"1")
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;3;"atBU_LugarSalida";__ ("Lugar Salida");100)
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;4;"alBU_HoraSalida";__ ("Hora Salida");45;"&/2")
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;5;"atBU_PersonaDeja";__ ("Persona que Deja");104)
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;6;"atBU_LugarLlegada";__ ("Lugar Llegada");100)
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;7;"alBU_HoraLlegada";__ ("Hora Llegada");45;"&/2")
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;8;"atBU_PersonaRecibe";__ ("Persona que Recibe");104)
		
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;9;"alBU_IDAlumno")
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;10;"alBU_IDProfesor")
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;11;"alBU_IDViaje")
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;12;"alBU_IDRegistro")
		$err:=ALP_DefaultColSettings (xALP_BUAsistentes;13;"abBU_Asiste")
		
		
		  //general options
		ALP_SetDefaultAppareance (xALP_BUAsistentes)
		AL_SetColOpts (xALP_BUAsistentes;1;1;1;5;0)
		AL_SetRowOpts (xALP_BUAsistentes;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_BUAsistentes;0;1;1)
		AL_SetMiscOpts (xALP_BUAsistentes;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_BUAsistentes;"";"")
		AL_SetScroll (xALP_BUAsistentes;0;0)
		AL_SetEntryOpts (xALP_BUAsistentes;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_BUAsistentes;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_BUAsistentes;1;"";"";"")
		AL_SetDrgSrc (xALP_BUAsistentes;2;"";"";"")
		AL_SetDrgSrc (xALP_BUAsistentes;3;"";"";"")
		AL_SetDrgDst (xALP_BUAsistentes;1;"";"";"")
		AL_SetDrgDst (xALP_BUAsistentes;1;"";"";"")
		AL_SetDrgDst (xALP_BUAsistentes;1;"";"";"")
		
		
		$err:=ALP_DefaultColSettings (xALP_BURecorridos;1;"atBU_RecNombre";__ ("Nombre");156)
		$err:=ALP_DefaultColSettings (xALP_BURecorridos;2;"atBU_RecJornada";__ ("Jornada");120)
		$err:=ALP_DefaultColSettings (xALP_BURecorridos;3;"atBU_RecDia";__ ("Día");80)
		
		$err:=ALP_DefaultColSettings (xALP_BURecorridos;4;"alBU_RecID")
		$err:=ALP_DefaultColSettings (xALP_BURecorridos;5;"alBU_RecIDRuta")
		
		  //general options
		ALP_SetDefaultAppareance (xALP_BURecorridos)
		AL_SetColOpts (xALP_BURecorridos;1;1;1;2;0)
		AL_SetRowOpts (xALP_BURecorridos;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_BURecorridos;0;1;1)
		AL_SetMiscOpts (xALP_BURecorridos;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_BURecorridos;"";"")
		AL_SetScroll (xALP_BURecorridos;0;0)
		AL_SetEntryOpts (xALP_BURecorridos;1;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_BURecorridos;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_BURecorridos;1;"";"";"")
		AL_SetDrgSrc (xALP_BURecorridos;2;"";"";"")
		AL_SetDrgSrc (xALP_BURecorridos;3;"";"";"")
		AL_SetDrgDst (xALP_BURecorridos;1;"";"";"")
		AL_SetDrgDst (xALP_BURecorridos;1;"";"";"")
		AL_SetDrgDst (xALP_BURecorridos;1;"";"";"")
		
		  //AL_SetLine (xALP_BURecorridos;0)
		AL_SetLine (xALP_BUAsistentes;0)
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		ACCEPT:C269
		BU_SaveViajesPersonas 
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 