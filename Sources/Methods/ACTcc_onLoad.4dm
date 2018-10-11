//%attributes = {}
  //ACTcc_onLoad

C_TEXT:C284(vt_TransDesde;vt_TransHasta;vt_ObsDesde;vt_ObsHasta)
C_DATE:C307(vd_TransDesde;vd_TransHasta;vd_ObsDesde;vd_ObsHasta)
ARRAY TEXT:C222(aUFItmName;0)
ARRAY TEXT:C222(aUFItmVal;0)
xALSet_AreasCamposUsuario (xAL_ccUF)
ACTcc_FormArraysDeclarations 
xALSet_AL_AreasFamilia 
xALSet_CC_ACT_AreaTransacciones 
xALSet_CC_ACT_AreasCargos 
xALSet_ACT_IngresoPagos 
xALSet_CC_ACT_AreasPagos 
xALSet_CC_ACT_AreaObs 
xALSet_CC_ACT_AreaTerceros 
atACT_TipoTransacciones:=5
vt_TransDesde:=""
vt_TransHasta:=""
vd_TransDesde:=!00-00-00!
vd_TransHasta:=!00-00-00!
vt_ObsDesde:=""
vt_ObsHasta:=""
vd_ObsDesde:=!00-00-00!
vd_ObsHasta:=!00-00-00!
If (Is new record:C668([ACT_CuentasCorrientes:175]))
	SET WINDOW TITLE:C213(__ ("Nueva Cuenta Corriente"))
Else 
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	SET WINDOW TITLE:C213(__ ("Cuentas Corrientes: ")+[Alumnos:2]apellidos_y_nombres:40)
End if 


ARRAY TEXT:C222(atACTcc_MatrixName;0)
COPY ARRAY:C226(<>atACT_MatrixName;atACTcc_MatrixName)
AT_Insert (1;1;->atACTcc_MatrixName)
atACTcc_MatrixName{1}:="Ninguna"

ACTcfg_LeeBlob ("ACT_DescuentosFamilia")
OBJECT SET VISIBLE:C603(*;"cb_MaxDescuento";(cbConsiderarDctoMaximo=1))

OBJECT SET VISIBLE:C603(*;"xALP_ACTcc_Terceros";False:C215)
OBJECT SET VISIBLE:C603(*;"Variable238";True:C214)

ACTcfg_OpcionesGenABancarios ("LeeBlob")
ACTcfgfdp_OpcionesGenerales ("CargaArreglosFormaDePagoXDef")


C_TEXT:C284(vtACT_NumTC;vtACT_ModoPago;vtACTcc_IdentTC;vtACTcc_IdentPAC)
C_BOOLEAN:C305(vbACT_CambioModoPago)

SET LIST ITEM PROPERTIES:C386(hlTab_ACT_CuentaCorriente;2;(csACTcfg_ModosPagoXCuenta=1);1;0)

  //20160730 RCH
ACTcfg_OpcionesDescuentos ("CargaConfDctoMaximo")

  //20160802 RCH
SELECT LIST ITEMS BY POSITION:C381(hlTab_ACT_Transacciones;5)
SELECT LIST ITEMS BY POSITION:C381(HLTAB_ACTcc_Asociados;1)
ACTcfg_OpcionesDescuentos ("CargaConf")

ACTcc_OpcionesDctos ("VisualizacionArea")
SELECT LIST ITEMS BY POSITION:C381(HLTAB_ACTcc_Dctos;vlACT_paginaSelDcto)

OBJECT SET VISIBLE:C603(*;"bAddPct";cb_SepararCargosXPct=1)

  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
C_BOOLEAN:C305(vb_guardarCambios)
