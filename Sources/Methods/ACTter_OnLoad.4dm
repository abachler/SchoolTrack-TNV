//%attributes = {}
  //ACTter_OnLoad
ACTter_InitVariablesForm 

xALSet_AreasCamposUsuario (xAL_ACT_Terc_UF_P)
  //xALSet_AreasCamposUsuario (->xAL_ACT_Terc_UF_E)


  //
  //
  //
  //

  //20110214 RCH Se utiliza la misma lista en personas y cuentas. No se puede eliminar una posicion de esta lista!!!
  //DELETE FROM LIST(hlTab_ACT_Transacciones;3)

C_LONGINT:C283($Error)
AT_Inc (0)
$error:=ALP_DefaultColSettings (xAL_ACT_Terc_Cargas;AT_Inc ;"atACT_TerCurso";__ ("Curso");200;"";0;0;0)
$error:=ALP_DefaultColSettings (xAL_ACT_Terc_Cargas;AT_Inc ;"atACT_TerAlumno";__ ("Cuenta");500;"";0;0;0)
$error:=ALP_DefaultColSettings (xAL_ACT_Terc_Cargas;AT_Inc ;"alACT_TerIdCtaCte";"Id CtaCte")

ALP_SetDefaultAppareance (xAL_ACT_Terc_Cargas;9;1;6;2;8)
AL_SetColOpts (xAL_ACT_Terc_Cargas;1;1;1;1;0)
AL_SetRowOpts (xAL_ACT_Terc_Cargas;1;1;0;0;1;0)
AL_SetCellOpts (xAL_ACT_Terc_Cargas;0;1;1)
AL_SetMainCalls (xAL_ACT_Terc_Cargas;"";"")
AL_SetCallbacks (xAL_ACT_Terc_Cargas;"";"")
AL_SetScroll (xAL_ACT_Terc_Cargas;0;-3)
AL_SetEntryOpts (xAL_ACT_Terc_Cargas;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xAL_ACT_Terc_Cargas;0;30;0)


C_LONGINT:C283($Error)
AT_Inc (0)
$error:=ALP_DefaultColSettings (xAL_ACT_Terc_Items;AT_Inc ;"alACT_TerIdItem";__ ("id Ítem");75;"######";2;0;0)
$error:=ALP_DefaultColSettings (xAL_ACT_Terc_Items;AT_Inc ;"atACT_TerGlosaItem";__ ("Glosa Ítem");400;"";0;0;0)
$error:=ALP_DefaultColSettings (xAL_ACT_Terc_Items;AT_Inc ;"arACT_TerMontoItem";__ ("Monto Ítem");100;"|Despliegue_ACT_Pagos";0;0;0)
$error:=ALP_DefaultColSettings (xAL_ACT_Terc_Items;AT_Inc ;"atACT_TerMonedaItem";__ ("Moneda Ítem");100;"";0;0;0)

ALP_SetDefaultAppareance (xAL_ACT_Terc_Items;9;1;6;2;8)
AL_SetColOpts (xAL_ACT_Terc_Items;1;1;1;0;0)
AL_SetRowOpts (xAL_ACT_Terc_Items;1;1;0;0;1;0)
AL_SetCellOpts (xAL_ACT_Terc_Items;0;1;1)
AL_SetMainCalls (xAL_ACT_Terc_Items;"";"")
AL_SetCallbacks (xAL_ACT_Terc_Items;"";"")
AL_SetScroll (xAL_ACT_Terc_Items;0;-3)
AL_SetEntryOpts (xAL_ACT_Terc_Items;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xAL_ACT_Terc_Items;0;30;0)

C_LONGINT:C283($Error)
AT_Inc (0)
$error:=ALP_DefaultColSettings (xALP_ACT_Terc_CtasXItems;AT_Inc ;"apACT_ActivoCXI";"";20;"1")

$error:=ALP_DefaultColSettings (xALP_ACT_Terc_CtasXItems;AT_Inc ;"atACT_CtaCXI";__ ("Cuenta - Curso");165;"";0;0;0)
$error:=ALP_DefaultColSettings (xALP_ACT_Terc_CtasXItems;AT_Inc ;"atACT_CtaCursoCXI";__ ("Curso");137;"";2;0;0)
$error:=ALP_DefaultColSettings (xALP_ACT_Terc_CtasXItems;AT_Inc ;"atACT_GlosaCXI";__ ("Id - Glosa Ítem");225;"";0;0;0)
$error:=ALP_DefaultColSettings (xALP_ACT_Terc_CtasXItems;AT_Inc ;"arACT_MontoFijoCXI";__ ("Monto Pactado Fijo");75;"|Despliegue_ACT_Pagos";0;0;1)
$error:=ALP_DefaultColSettings (xALP_ACT_Terc_CtasXItems;AT_Inc ;"arACT_MontoPctCXI";__ ("Monto Pactado %");75;"##0 ";0;0;1)
$error:=ALP_DefaultColSettings (xALP_ACT_Terc_CtasXItems;AT_Inc ;"alACT_IdCXI";"id";300;"";0;0;0)
$error:=ALP_DefaultColSettings (xALP_ACT_Terc_CtasXItems;AT_Inc ;"abACT_RelativoCXI";"";175;"";0;0;0)
$error:=ALP_DefaultColSettings (xALP_ACT_Terc_CtasXItems;AT_Inc ;"abACT_ActivoCXI";"";175;"";0;0;0)


ALP_SetDefaultAppareance (xALP_ACT_Terc_CtasXItems;9;1;6;2;8)
AL_SetColOpts (xALP_ACT_Terc_CtasXItems;1;1;1;3;0)
AL_SetRowOpts (xALP_ACT_Terc_CtasXItems;1;1;0;0;1;0)
AL_SetCellOpts (xALP_ACT_Terc_CtasXItems;0;1;1)
AL_SetMainCalls (xALP_ACT_Terc_CtasXItems;"";"")
AL_SetCallbacks (xALP_ACT_Terc_CtasXItems;"";"xALP_ACT_CB_TerModMontos")
AL_SetScroll (xALP_ACT_Terc_CtasXItems;0;-3)
AL_SetEntryOpts (xALP_ACT_Terc_CtasXItems;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_ACT_Terc_CtasXItems;0;30;0)


  //--- transaciones
C_LONGINT:C283($Error)
AT_Inc (0)

$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"asACT_TipoTransaccion";__ ("Tipo");40;"";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"adACT_TerTFecha";__ ("Fecha");60;"";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"asACT_TerTPeriodo";__ ("Periodo");60;"";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"asACT_TerTGlosa";__ ("Glosa");260;"";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"arACT_TerTDebito";__ ("Debito");72;"|Despliegue_ACT";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"arACT_TerTCredito";__ ("Credito");72;"|Despliegue_ACT";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"atACT_TerTMoneda";__ ("Moneda");70;"";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"apACT_TerTAfecta";__ ("Afecta IVA");70;"";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"alACT_TerTBoleta";__ ("Doc. Trib.");115;"";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"alACT_TerTRefItem";__ ("Ref");100;"#####";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_Transacciones;AT_Inc ;"alACT_ItemIDs";__ ("ID Item");100;"#####";0;0;0)

ALP_SetDefaultAppareance (xALP_Transacciones;9;1;6;2;8)
AL_SetColOpts (xALP_Transacciones;1;1;1;3;0)
AL_SetRowOpts (xALP_Transacciones;1;1;0;0;1;0)
AL_SetCellOpts (xALP_Transacciones;0;1;1)
AL_SetMainCalls (xALP_Transacciones;"";"")
  //AL_SetCallbacks (xALP_Transacciones;"";"xALP_ACT_CB_TerModMontos")
AL_SetScroll (xALP_Transacciones;0;-3)
AL_SetEntryOpts (xALP_Transacciones;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Transacciones;0;30;0)


  //2010-08-20    FRC:  Ocupo los mismos arreglos para ALP que se utilizan en Apoderados.
XALSet_PP_ACT_AreasDocumentos 
xALPSet_ACT_CargosAviso 
XALSet_PP_ACT_AreaPagos 
xALSet_PP_ACT_DTributarios 
XALSet_PP_ACT_AreaCartera 
XAlSet_PP_ACT_Depositos 
  //Descomentar la siguiente linea cuando se habiliten las observaciones en tercerso
  //xALSet_PP_ACT_AreaObs  

If (<>vtXS_CountryCode#"cl")
	OBJECT SET FILTER:C235([ACT_Terceros:138]PAT_Identificador:34;"")
	OBJECT SET FILTER:C235([ACT_Terceros:138]PAC_Identificador:46;"")
End if 

ACTbol_ObtieneResponsableFact ("DeclaraVars")

  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
C_BOOLEAN:C305(vb_guardarCambios)