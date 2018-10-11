//%attributes = {}
  //PP_OnLoad

ARRAY TEXT:C222(aUFItmName;0)
ARRAY TEXT:C222(aUFItmVal;0)
C_BOOLEAN:C305(vbACT_CambioModoPago)
xALSet_AreasCamposUsuario (xAL_ppUF)
ADTpp_FormArrayDeclarations 
If (vsBWR_CurrentModule="AccountTrack")
	ACTpp_FormArraysDeclarations 
	xAlSet_PP_ACT_AreaAlumnos 
	xALSet_PP_ACT_AreaTransacciones 
	XALSet_PP_ACT_AreasDocumentos 
	xALSet_ACT_IngresoPagos 
	XALSet_PP_ACT_AreaPagos 
	XALSet_PP_ACT_AreaCartera 
	XAlSet_PP_ACT_Depositos 
	xALSet_PP_ACT_AreaObs 
	xALSet_PP_AreaFamsAPdo 
	xALSet_PP_ACT_DTributarios 
	ACTpp_OpcionesPagares ("SetAreas")
	xALSet_PP_ACT_AreaTerceros 
	ACTcfg_OpcionesGenABancarios ("LeeBlob")
	ACTcfgfdp_OpcionesGenerales ("CargaArreglosFormaDePagoXDef")
	vt_TransDesde:=""
	vt_TransHasta:=""
	vd_TransDesde:=!00-00-00!
	vd_TransHasta:=!00-00-00!
	atACT_TipoTransacciones:=5
	vt_ObsDesde:=""
	vt_ObsHasta:=""
	vd_ObsDesde:=!00-00-00!
	vd_ObsHasta:=!00-00-00!
	vt_noTarjetaC:=""
	  //20130307 RCH se paso al onrecord load
	  //vt_ModoDePago:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->[Personas]ACT_id_modo_de_pago)
	OBJECT SET VISIBLE:C603(*;"Área de plug-in2";False:C215)
	OBJECT SET VISIBLE:C603(*;"Área de plug-in1";True:C214)
	
	If (<>vtXS_CountryCode#"cl")
		OBJECT SET FILTER:C235([Personas:7]ACT_RUTTitular_TC:56;"")
		OBJECT SET FILTER:C235([Personas:7]ACT_RUTTitutal_Cta:50;"")
		OBJECT SET FILTER:C235([Personas:7]ACT_RUTTitular_TD:105;"")
	End if 
	
	  //20140711 RCH para mostrar o no el envio por mail
	C_LONGINT:C283($l_registros)
	READ ONLY:C145([ACT_RazonesSociales:279])
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
	QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]emisor_electronico:30=True:C214)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, habilitación de envío de boletas para UY (objetos ACTdte_enviaMail y ACTdte_EnviaMailCuenta)
	  // OBJECT SET VISIBLE(*;"ACTdte_@";$l_registros>0)
	If (<>vtXS_CountryCode="uy")
		OBJECT SET VISIBLE:C603(*;"ACTdte_@";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"ACTdte_@";$l_registros>0)
	End if 
	
	ACTbol_ObtieneResponsableFact ("DeclaraVars")
	
Else 
	xALP_SET_EducAntSTR 
	SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_personas;1)
	FORM GOTO PAGE:C247(1)
	  //ADTcdd_LoadEducacionAnterior ([Personas]No;"pe")
End if 
If (Is new record:C668([Personas:7]))
	SET WINDOW TITLE:C213(__ ("Nuevo apoderado"))
Else 
	SET WINDOW TITLE:C213(__ ("Apoderados: ")+[Personas:7]Apellidos_y_nombres:30)
End if 

  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
C_BOOLEAN:C305(vb_guardarCambios)