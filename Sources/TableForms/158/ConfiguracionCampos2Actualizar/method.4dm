Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		CMT_Transferencia ("DeclaraArreglosInterfaz")
		
		ARRAY TEXT:C222(aTableNames;0)
		  // Modificado por: Saúl Ponce (01-03-2017) Ticket 175827, ya no existe el comando Count Tables para el FOR
		  // For ($i;1;Count tables)
		  // APPEND TO ARRAY(aTableNames;Table name($i))
		  // End for 
		For ($i;1;Get last table number:C254)
			If (Is table number valid:C999($i))
				APPEND TO ARRAY:C911(aTableNames;Table name:C256($i))
			End if 
		End for 
		aTableNames:=1
		
		vtCM_Aplicacion:=""
		
		AT_Inc (0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"alCM_id";__ ("ID");20;"#############";1;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"atCM_Aplicacion";__ ("Aplicacion");60;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"atCM_Tabla";__ ("Tabla");70;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"atCM_Campo";__ ("Campo");130;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"atCM_Alias";__ ("Alias Campo");100;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"atCM_TablaBase";__ ("Tabla Destino");90;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"atCM_TextAliasCampo";__ ("Alias XML Campo");120;"";0;2;1)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"atCM_Formula";__ ("Formula");120;"";0;2;1)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"abCM_GuardaModificaciones";__ ("Testear Modificaciones");60;"Si;No";2;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"abCM_EnviarCampoSiempre";__ ("Enviar siempre");60;__ ("Si;No");2;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"alCM_Tabla";"Numero tabla";90;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"alCM_Campo";"Numero campo";90;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"alCM_idVSAlias";"Numero Alias";90;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferencia;AT_Inc ;"alCM_TablaBase";"Tabla Base";70;"";0;2;0)
		
		
		  //general options
		ALP_SetDefaultAppareance (xALP_AreaTransferencia;9;2;6;2;6)
		AL_SetColOpts (xALP_AreaTransferencia;1;1;1;4;0)
		AL_SetRowOpts (xALP_AreaTransferencia;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_AreaTransferencia;0;1;1)
		AL_SetMainCalls (xALP_AreaTransferencia;"";"")
		AL_SetCallbacks (xALP_AreaTransferencia;"";"xAL_CMT_CBExit_CamposTransf")
		AL_SetScroll (xALP_AreaTransferencia;0;0)
		AL_SetEntryOpts (xALP_AreaTransferencia;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_AreaTransferencia;0;30;0)
		
		AL_SetEnterable (xALP_AreaTransferencia;6;2;aTableNames)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_AreaTransferencia;1;"";"";"")
		AL_SetDrgSrc (xALP_AreaTransferencia;2;"";"";"")
		AL_SetDrgSrc (xALP_AreaTransferencia;3;"";"";"")
		AL_SetDrgDst (xALP_AreaTransferencia;1;"";"";"")
		AL_SetDrgDst (xALP_AreaTransferencia;1;"";"";"")
		
		ARRAY TEXT:C222(atCMT_NombreCampos;0)
		APPEND TO ARRAY:C911(atCMT_NombreCampos;"Formato1")
		APPEND TO ARRAY:C911(atCMT_NombreCampos;"Formato2")
		
		AT_Inc (0)
		ALP_DefaultColSettings (xALP_AreaTransferenciaTablas;AT_Inc ;"atCMTabla_Tabla";__ ("Tabla");60;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferenciaTablas;AT_Inc ;"atCMTabla_AliasRaiz";__ ("Raiz");100;"";0;2;1)
		ALP_DefaultColSettings (xALP_AreaTransferenciaTablas;AT_Inc ;"atCMTabla_AliasElemento";__ ("Elemento");100;"";0;2;1)
		ALP_DefaultColSettings (xALP_AreaTransferenciaTablas;AT_Inc ;"atCMTabla_Formula";__ ("Script a ejecutar");200;"";0;2;1)
		ALP_DefaultColSettings (xALP_AreaTransferenciaTablas;AT_Inc ;"atCMTabla_IDCampo";__ ("Identificador Tabla");100;"";0;2;1)
		ALP_DefaultColSettings (xALP_AreaTransferenciaTablas;AT_Inc ;"alCMTabla_IDCampo";__ ("Identificador Tabla");100;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferenciaTablas;AT_Inc ;"alCMTabla_idTabla";__ ("Tabla");60;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferenciaTablas;AT_Inc ;"atCMTabla_Aplicacion";__ ("App");60;"";0;2;0)
		ALP_DefaultColSettings (xALP_AreaTransferenciaTablas;AT_Inc ;"alCMTabla_ID";"App";60;"";0;2;0)
		
		  //general options
		AL_SetEnterable (xALP_AreaTransferenciaTablas;5;2;atCMT_NombreCampos)
		ALP_SetDefaultAppareance (xALP_AreaTransferenciaTablas;9;1;6;2;6)
		AL_SetColOpts (xALP_AreaTransferenciaTablas;1;1;1;4;0)
		AL_SetRowOpts (xALP_AreaTransferenciaTablas;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_AreaTransferenciaTablas;0;1;1)
		AL_SetMainCalls (xALP_AreaTransferenciaTablas;"";"")
		AL_SetCallbacks (xALP_AreaTransferenciaTablas;"xAL_CMT_CBEntry_Tabla";"")
		AL_SetScroll (xALP_AreaTransferenciaTablas;0;0)
		AL_SetEntryOpts (xALP_AreaTransferenciaTablas;3;0;0;1;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_AreaTransferenciaTablas;0;30;0)
		
		
		  //dragging options
		AL_SetDrgSrc (xALP_AreaTransferenciaTablas;1;"";"";"")
		AL_SetDrgSrc (xALP_AreaTransferenciaTablas;2;"";"";"")
		AL_SetDrgSrc (xALP_AreaTransferenciaTablas;3;"";"";"")
		AL_SetDrgDst (xALP_AreaTransferenciaTablas;1;"";"";"")
		AL_SetDrgDst (xALP_AreaTransferenciaTablas;1;"";"";"")
		
		
		CMT_Transferencia ("OnLoad")
		
End case 