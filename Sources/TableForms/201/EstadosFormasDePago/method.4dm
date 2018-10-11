Case of 
	: (Form event:C388=On Load:K2:1)
		ACTcfg_OpcionesEstadosPagos ("DeclaraArreglos")
		C_BOOLEAN:C305(vbACT_mostrarEstadoXDef)
		
		
		  //xALP_ACT_Set_DesctoFamilia
		
		C_LONGINT:C283($Error)
		AT_Inc (0)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"atACT_estados";__ ("Estado");140;"";0;0;1)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"atACT_estadosCI";__ ("Código");50;"";0;0;1)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"atACT_estadosCta";__ ("Plan de Cuentas");70;"";0;0;1)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"atACT_estadosCtaCA";__ ("Código Auxiliar Cuenta");70;"";0;0;1)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"atACT_estadosCentro";__ ("Centro de Costos");70;"";0;0;1)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"atACT_estadosCCta";__ ("Plan de Contra Cuenta");70;"";0;0;1)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"atACT_estadosCCtaCA";__ ("Código Auxiliar Contra");70;"";0;0;1)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"atACT_estadosCCentro";__ ("Centro de Costos Contra");70;"";0;0;1)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"abACT_generaMovimientoCont";__ ("Gen Mov Contable");70;"Sí;No";0;0;1)
		
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"alACT_estadosID";"id";0;"";0;0;0)  // id
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"alACT_estadosIDFDP";"id forma";0;"";0;0;0)  // id fdp
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"alACT_estadosIDCta";"id cuenta";0;"";0;0;0)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"alACT_estadosIDCentro";"id centro";0;"";0;0;0)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"alACT_estadosIDCCta";"id cuenta contra";0;"";0;0;0)
		$error:=ALP_DefaultColSettings (xALP_EstadosFDP;AT_Inc ;"alACT_estadosIDCCentro";"id centro contra";0;"";0;0;0)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_EstadosFDP;0;1;8;3;8)
		AL_SetColOpts (xALP_EstadosFDP;1;1;1;6;0)
		AL_SetRowOpts (xALP_EstadosFDP;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_EstadosFDP;0;1;1)
		AL_SetMiscOpts (xALP_EstadosFDP;0;0;"\\";0;1)
		AL_SetCallbacks (xALP_EstadosFDP;"";"")
		AL_SetMainCalls (xALP_EstadosFDP;"";"")
		AL_SetScroll (xALP_EstadosFDP;0;-3)
		AL_SetEntryOpts (xALP_EstadosFDP;5;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_EstadosFDP;0;30;0)
		AL_SetSortOpts (xALP_EstadosFDP;0;0;0;"Seleccione las columnas a ordenar:";0;1)
		
		AL_UpdateArrays (xALP_EstadosFDP;0)
		ACTcfg_OpcionesEstadosPagos ("CargaArreglos";->vlACT_idFormaDePago)
		AL_UpdateArrays (xALP_EstadosFDP;-2)
		
		ACTcfg_OpcionesEstadosPagos ("ColorFormasDePagoXDefecto")
		
		ACTcfg_OpcionesEstadosPagos ("EstadoXDefecto")
		
		
		$vl_line:=AL_GetLine (xALP_EstadosFDP)
		IT_SetButtonState ((($vl_line>0) & (alACT_estadosID{$vl_line}>0));->bDelEFP)
		
	: (Form event:C388=On Clicked:K2:4)
		$vl_line:=AL_GetLine (xALP_EstadosFDP)
		If ($vl_line<=Size of array:C274(alACT_estadosID))
			IT_SetButtonState ((($vl_line>0) & (alACT_estadosID{$vl_line}>0));->bDelEFP)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		ACTcfg_OpcionesEstadosPagos ("GuardaArreglos")
		vbACT_mostrarEstadoXDef:=False:C215
		CANCEL:C270
		
End case 