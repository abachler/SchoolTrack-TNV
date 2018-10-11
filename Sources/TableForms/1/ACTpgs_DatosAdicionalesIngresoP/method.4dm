Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_TEXT:C284(vt_titleForm)
		C_LONGINT:C283(hl_listaObs)
		ACTpgs_CargaDatosAdicionales ("DeclaraVars")
		
		vt_titleForm:="Datos Adicionales para "+[Personas:7]Apellidos_y_nombres:30
		
		hl_listaObs:=New list:C375
		APPEND TO LIST:C376(hl_listaObs;"Documentos en cartera";1)
		APPEND TO LIST:C376(hl_listaObs;"Observaciones";2)
		APPEND TO LIST:C376(hl_listaObs;"Datos académicos";3)
		
		C_LONGINT:C283($Error)
		$error:=ALP_DefaultColSettings (xALP_Documentos;1;"adACT_FechaPagoProt";__ ("Fecha Pago");75;"0";2)
		$error:=ALP_DefaultColSettings (xALP_Documentos;2;"adACT_FechaDctoProt";__ ("Fecha Dcto");75;"0";2)
		$error:=ALP_DefaultColSettings (xALP_Documentos;3;"atACT_EstadoProt";__ ("Estado Dcto");190;"")
		$error:=ALP_DefaultColSettings (xALP_Documentos;4;"atACT_MotivoProt";__ ("Motivo Protesto");220)
		$error:=ALP_DefaultColSettings (xALP_Documentos;5;"atACT_ColoresProt";__ ("Motivo Protesto");240)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_Documentos;11;2;6;2;8)
		AL_SetColOpts (xALP_Documentos;1;1;1;1;0)
		AL_SetRowOpts (xALP_Documentos;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_Documentos;0;1;1)
		AL_SetMainCalls (xALP_Documentos;"";"")
		AL_SetScroll (xALP_Documentos;0;0)
		AL_SetEntryOpts (xALP_Documentos;0;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_Documentos;0;30;0)
		
		$error:=ALP_DefaultColSettings (xALP_Obs;1;"atACT_TipoObs";__ ("Tipo Observación");75)
		$error:=ALP_DefaultColSettings (xALP_Obs;2;"adACT_FechaObs";__ ("Fecha Observación");75;"0";2)
		$error:=ALP_DefaultColSettings (xALP_Obs;3;"atACT_Obs";__ ("Observación");410;"")
		$error:=ALP_DefaultColSettings (xALP_Obs;4;"atACT_ColorObs";__ ("Observación");410;"")
		
		  //general options
		ALP_SetDefaultAppareance (xALP_Obs;11;2;6;2;8)
		AL_SetColOpts (xALP_Obs;1;1;1;1;0)
		AL_SetRowOpts (xALP_Obs;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_Obs;0;1;1)
		AL_SetMainCalls (xALP_Obs;"";"")
		AL_SetScroll (xALP_Obs;0;0)
		AL_SetEntryOpts (xALP_Obs;0;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_Obs;0;30;0)
		
		
		$error:=ALP_DefaultColSettings (xALP_DatosAcad;1;"atACT_NombresAl";__ ("Alumno");200)
		$error:=ALP_DefaultColSettings (xALP_DatosAcad;2;"atACT_ObsAl";__ ("Información SchoolTrack");360)
		$error:=ALP_DefaultColSettings (xALP_DatosAcad;3;"atACT_ColorAl";__ ("Información SchoolTrack");360)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_DatosAcad;11;3;6;2;8)
		AL_SetColOpts (xALP_DatosAcad;1;1;1;1;0)
		AL_SetRowOpts (xALP_DatosAcad;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_DatosAcad;0;1;1)
		AL_SetMainCalls (xALP_DatosAcad;"";"")
		AL_SetScroll (xALP_DatosAcad;0;0)
		AL_SetEntryOpts (xALP_DatosAcad;0;0;0;0;0;<>tXS_RS_DecimalSeparator)
		
		ACTpgs_CargaDatosAdicionales ("CargaDatos")
		LOG_RegisterEvt ("Acceso a datos adicionales de "+[Personas:7]Apellidos_y_nombres:30)
End case 