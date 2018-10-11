Case of 
	: ((Form event:C388=On Load:K2:1) & (Form event:C388#On Activate:K2:9))
		IT_SetButtonState ((Size of array:C274(atBU_BUSPatente)>0);->bDelBus;->bAddMantencion)
		IT_SetButtonState ((Size of array:C274(alBU_Mantencion)>0);->bDelMantencion;->bDelDoc;->bAddDoc)
		IT_SetButtonState ((Size of array:C274(alBU_DocID)>0);->bDelDoc)
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
		
		  //************** BUSES ***********************************************
		
		$err:=ALP_DefaultColSettings (xalp_Buses;1;"atBU_BUSPatente";__ ("Matrícula");100)
		$err:=ALP_DefaultColSettings (xalp_Buses;2;"alBU_BUSNumero";__ ("Número");50;"###0")
		
		  //general options
		ALP_SetDefaultAppareance (xalp_Buses)
		AL_SetColOpts (xalp_Buses;1;1;1;0;0)
		AL_SetRowOpts (xalp_Buses;0;0;0;0;1;0)
		AL_SetCellOpts (xalp_Buses;0;1;1)
		AL_SetMiscOpts (xalp_Buses;0;0;"\\";0;1)
		AL_SetMainCalls (xalp_Buses;"";"")
		AL_SetScroll (xalp_Buses;0;0)
		AL_SetEntryOpts (xalp_Buses;1;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xalp_Buses;0;30;0)
		
		  //dragging options
		AL_SetDrgSrc (xalp_Buses;1;"";"";"")
		AL_SetDrgSrc (xalp_Buses;2;"";"";"")
		AL_SetDrgSrc (xalp_Buses;3;"";"";"")
		AL_SetDrgDst (xalp_Buses;1;"";"";"")
		AL_SetDrgDst (xalp_Buses;1;"";"";"")
		AL_SetDrgDst (xalp_Buses;1;"";"";"")
		
		  //************** MANTENCIONES ********************************
		
		$err:=ALP_DefaultColSettings (xapl_Mantenciones;1;"alBU_Mantencion";__ ("Número");50;"#####")
		$err:=ALP_DefaultColSettings (xapl_Mantenciones;2;"adBU_Fecha";__ ("Fecha");50;"0")
		$err:=ALP_DefaultColSettings (xapl_Mantenciones;3;"atBU_Responsable";__ ("Responsable");200)
		$err:=ALP_DefaultColSettings (xapl_Mantenciones;4;"atBU_Tipo";__ ("Tipo");80)
		$err:=ALP_DefaultColSettings (xapl_Mantenciones;5;"arBU_Valor";__ ("Valor");50;"##########")
		$err:=ALP_DefaultColSettings (xapl_Mantenciones;6;"atBU_Patente")
		
		  //general options
		ALP_SetDefaultAppareance (xapl_Mantenciones)
		AL_SetColOpts (xapl_Mantenciones;1;1;1;1;0)
		AL_SetRowOpts (xapl_Mantenciones;0;0;0;0;1;0)
		AL_SetCellOpts (xapl_Mantenciones;0;1;1)
		AL_SetMiscOpts (xapl_Mantenciones;0;0;"\\";0;1)
		AL_SetMainCalls (xapl_Mantenciones;"";"")
		AL_SetScroll (xapl_Mantenciones;0;0)
		AL_SetEntryOpts (xapl_Mantenciones;1;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xapl_Mantenciones;0;30;0)
		
		  //dragging options
		AL_SetDrgSrc (xapl_Mantenciones;1;"";"";"")
		AL_SetDrgSrc (xapl_Mantenciones;2;"";"";"")
		AL_SetDrgSrc (xapl_Mantenciones;3;"";"";"")
		AL_SetDrgDst (xapl_Mantenciones;1;"";"";"")
		AL_SetDrgDst (xapl_Mantenciones;1;"";"";"")
		AL_SetDrgDst (xapl_Mantenciones;1;"";"";"")
		
		
		
		  //***************** DOCUMENTOS ***************************************
		
		$err:=ALP_DefaultColSettings (xalp_Documentos;1;"alBU_NumDoc";__ ("Nº");50;"######")
		$err:=ALP_DefaultColSettings (xalp_Documentos;2;"alBU_NumMant";__ ("Nº Mant.");50;"######")
		$err:=ALP_DefaultColSettings (xalp_Documentos;3;"adBU_FechaDoc";__ ("Fecha");0;"0")
		$err:=ALP_DefaultColSettings (xalp_Documentos;4;"atBU_Descrip";__ ("Descripción");220)
		$err:=ALP_DefaultColSettings (xalp_Documentos;5;"atBU_PatBus")
		$err:=ALP_DefaultColSettings (xalp_Documentos;6;"alBU_DocID")
		
		  //general options
		ALP_SetDefaultAppareance (xalp_Documentos)
		AL_SetColOpts (xalp_Documentos;1;1;1;2;0)
		AL_SetRowOpts (xalp_Documentos;0;0;0;0;1;0)
		AL_SetCellOpts (xalp_Documentos;0;1;1)
		AL_SetMiscOpts (xalp_Documentos;0;0;"\\";0;1)
		AL_SetMainCalls (xalp_Documentos;"";"")
		AL_SetScroll (xalp_Documentos;0;0)
		AL_SetEntryOpts (xalp_Documentos;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xalp_Documentos;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_Documentos;1;"";"";"")
		AL_SetDrgSrc (xalp_Documentos;2;"";"";"")
		AL_SetDrgSrc (xalp_Documentos;3;"";"";"")
		AL_SetDrgDst (xalp_Documentos;1;"";"";"")
		AL_SetDrgDst (xalp_Documentos;1;"";"";"")
		AL_SetDrgDst (xalp_Documentos;1;"";"";"")
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		bu_loadmantenciones 
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 