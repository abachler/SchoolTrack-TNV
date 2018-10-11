  // Método: Método de Formulario: [xxSTR_Constants]ACTpgs_VentasRapidas
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-03-10, 12:39:26
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
Case of 
	: (Form event:C388=On Load:K2:1)
		C_DATE:C307(vdACT_FechaE;vdACT_FechaPagoIni;vdACT_FechaPago)
		C_TEXT:C284(vtACT_FechaE)
		C_BOOLEAN:C305(vbACT_PagoVD)
		C_TEXT:C284(vtACTpgs_VRAviso1)
		
		C_LONGINT:C283(btn_apdo;btn_tercero)
		  //PARA VALIDACION DE BUSQUEDA A TRAVES DEL CODIGO DE BARRA
		vl_validacion:=1
		
		C_TEXT:C284(vtACT_LabelUltimoPago)
		C_LONGINT:C283(vlACT_IDUltimoPago)
		
		XS_SetInterface 
		ACTcfg_LoadConfigData (1)
		ACTcfg_LoadBancos 
		ACTpgs_OpcionesVR ("LimpiaVarsForm")
		ACTutl_GetDecimalFormat 
		ACTusr_AllowChange ("onLoad";->vdACT_FechaPago)
		
		vdACT_FechaPago:=Current date:C33(*)
		vdACT_FechaPagoIni:=vdACT_FechaPago
		vdACT_FechaE:=vdACT_FechaPago
		vtACT_FechaE:=String:C10(vdACT_FechaE)
		
		vtACTpgs_VRAviso1:=__ ("Los cargos serán emitidos en la moneda ")+ST_GetWord (ACT_DivisaPais ;1;";")
		
		ACTpgs_OpcionesVR ("SetALP")
		ACTcfg_LeeBlob ("ACTcfg_MonedasYTasas")
		ACTcfg_LeeBlob ("ACTcfg_GeneralesIngresoPagos")
		ACTcfg_ItemsMatricula ("InicializaYLee")
		cb_soloCuotasVencidas:=0
		
		ACTpgs_OpcionesVR ("CargaRegistro")
		ACTpgs_OpcionesVR ("TextoImputacionUnica")
		
		ACTpgs_DeclareArraysCargos 
		ACTpgs_DeclareArraysAvisos 
		ARRAY TEXT:C222(aCtasApdo;0)
		ARRAY TEXT:C222(aCtasCurso;0)
		ARRAY LONGINT:C221(alACT_IdsAlumnos;0)
		
		If (Size of array:C274(alACTvd_IdsItems)=0)
			CD_Dlog (0;__ ("No hay ítems definidos como venta directa."))
		End if 
		vbACT_PagoVD:=True:C214
	: (Form event:C388=On Outside Call:K2:11)
		
		If (Not:C34(<>bAccountTrackIsRunning))
			CANCEL:C270
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 


