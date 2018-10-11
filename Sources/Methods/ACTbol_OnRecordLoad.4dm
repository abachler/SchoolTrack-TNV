//%attributes = {}
  //ACTbol_OnRecordLoad

SET WINDOW TITLE:C213([ACT_Boletas:181]TipoDocumento:7+" Nº "+String:C10([ACT_Boletas:181]Numero:11))
$recNumBoleta:=Record number:C243([ACT_Boletas:181])
AL_UpdateArrays (ALP_CargosBoleta;0)

  //20111122 RCH Para que la boleta no sea alterada
  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
  //CREATE SET([ACT_Transacciones];"Transacciones")
  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
ACTbol_BuscaCargosCargaSet ("Transacciones";[ACT_Boletas:181]ID:1)

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Terceros:138])
RELATE ONE:C42([ACT_Boletas:181]ID_Apoderado:14)
RELATE ONE:C42([ACT_Boletas:181]ID_Tercero:21)
AL_UpdateArrays (xALP_AlumnosBol;0)
OBJECT SET VISIBLE:C603(*;"vn@";False:C215)
OBJECT SET VISIBLE:C603(*;"ID@";False:C215)
OBJECT SET VISIBLE:C603(*;"labelTercero@";False:C215)
If ([Personas:7]No:1>0)
	OBJECT SET VISIBLE:C603(*;"vn@";True:C214)
	OBJECT SET VISIBLE:C603(*;"ID@";True:C214)
	PP_SetIdentificadorPrincipal 
	ACT_relacionaCtasyApdos (2)
	LOAD RECORD:C52([Personas:7])
Else 
	If ([ACT_Boletas:181]ID_Tercero:21>0)
		vApellidosyNombresT:=[ACT_Terceros:138]Nombre_Completo:9
		OBJECT SET VISIBLE:C603(*;"labelTercero@";True:C214)
		ACTter_SetIdentificador (->vt_labelIdentificador;->valorIdentificador)
		If ((vt_labelIdentificador="RUT") & (Num:C11(Substring:C12(valorIdentificador;1;Length:C16(valorIdentificador)-1))>0))
			OBJECT SET FORMAT:C236(valorIdentificador;"###.###.###-#")
		End if 
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
	End if 
End if 
KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;atACT_CCAlumno;[Alumnos:2]curso:20;atACT_CCCurso)
AL_UpdateArrays (xALP_AlumnosBol;-2)
AL_SetLine (xALP_AlumnosBol;0)
ACTcfg_LoadConfigData (8)
xALSet_ACT_CargosBoleta 

  //20150915 RCH
  //$CuantosCargos:=ACTcc_LoadCargosIntoArrays (True)
C_POINTER:C301($y_dummy)
$CuantosCargos:=ACTcc_LoadCargosIntoArrays (True:C214;$y_dummy;$y_dummy;$y_dummy;$y_dummy;$y_dummy;$y_dummy;False:C215;False:C215;False:C215;ACTdte_EsEmisorColegium ([ACT_Boletas:181]ID_RazonSocial:25))

ARRAY LONGINT:C221(alACT_IDCtaCteTemp;0)
COPY ARRAY:C226(alACT_IDCtaCte;alACT_IDCtaCteTemp)
AT_DistinctsArrayValues (->alACT_IDCtaCteTemp)
If (Size of array:C274(alACT_IDCtaCteTemp)=1)
	If (Size of array:C274(alACT_RecNumsCargos)>0)
		vtACT_BolCtaNombre:=atACT_CAlumno{1}
		vtACT_BolCtaCurso:=atACT_CAlumnoCurso{1}
		OBJECT SET VISIBLE:C603(*;"DatosCta@";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"DatosCta@";False:C215)
	End if 
Else 
	OBJECT SET VISIBLE:C603(*;"DatosCta@";False:C215)
End if 
AT_Initialize (->alACT_IDCtaCteTemp)
ARRAY REAL:C219(arACT_MontoPagado;$CuantosCargos)
For ($t;1;Size of array:C274(alACT_RecNumsCargos))
	GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumsCargos{$t})
	arACT_MontoPagado{$t}:=ACTbol_GetMontoLinea ("Transacciones")
	APPEND TO ARRAY:C911(atACT_RecNumsCargosAgr;String:C10(Record number:C243([ACT_Cargos:173])))
End for 
  //20130626 RCH NF CANTIDAD
ARRAY LONGINT:C221(alACT_Cantidad;Size of array:C274(atACT_CGlosaImpresion))
  //ARRAY REAL(arACT_Cantidad;Size of array(atACT_CGlosaImpresion))//20151005 RCH Se llena en actcc_loadcargos...
ARRAY REAL:C219(arACT_Unitario;Size of array:C274(atACT_CGlosaImpresion))
If (cbAgruparBoletas=1)
	ACTac_AgrupaCargos 
End if 
If (cb_ImprimirCeros=0)
	arACT_MontoPagado{0}:=0
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->arACT_MontoPagado;"=";->$DA_Return)
	For ($u;Size of array:C274($DA_Return);1;-1)
		AT_Delete ($DA_Return{$u};1;->atACT_CGlosaImpresion;->arACT_MontoPagado;->atACT_CAlumno;->arACT_Cantidad;->arACT_Unitario;->arACT_CTotalDesctos;->atACT_RecNumsCargosAgr)
	End for 
End if 
AL_UpdateArrays (ALP_CargosBoleta;-2)
AL_SetLine (ALP_CargosBoleta;0)
USE SET:C118("Transacciones")
AL_UpdateArrays (xALP_DocsInvolved;0)
KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
ARRAY LONGINT:C221($aIDDocPago;0)
ARRAY TEXT:C222(atACT_PagoEstadoDocBol;0)
SELECTION TO ARRAY:C260([ACT_Pagos:172]forma_de_pago_new:31;atACT_PagoFormaBol;[ACT_Pagos:172]Monto_Pagado:5;arACT_PagoMontoBol;[ACT_Pagos:172]ID:1;alACT_PagoIDBol;[ACT_Pagos:172]ID_DocumentodePago:6;$aIDDocPago;[ACT_Pagos:172]Saldo:15;arACT_PagoSaldoBol)
For ($i;1;Size of array:C274($aIDDocPago))
	QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=$aIDDocPago{$i})
	INSERT IN ARRAY:C227(atACT_PagoEstadoDocBol;Size of array:C274(atACT_PagoEstadoDocBol)+1;1)
	atACT_PagoEstadoDocBol{Size of array:C274(atACT_PagoEstadoDocBol)}:=[ACT_Documentos_de_Pago:176]Estado:14
End for 
SORT ARRAY:C229(atACT_PagoFormaBol;arACT_PagoMontoBol;arACT_PagoSaldoBol;alACT_PagoIDBol;atACT_PagoEstadoDocBol;<)
AL_UpdateArrays (xALP_DocsInvolved;-2)
AL_SetLine (xALP_DocsInvolved;0)

AL_UpdateArrays (xALP_DocsAsociados;0)
ACTbol_FormArraysDeclarations ("DctosAsociados")
ARRAY LONGINT:C221($al_idBol;0)
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_DctoRelacionado:15=[ACT_Boletas:181]ID:1)
DISTINCT VALUES:C339([ACT_Transacciones:178]No_Boleta:9;$al_idBol)
For ($i;1;Size of array:C274($al_idBol))
	$index:=Find in field:C653([ACT_Boletas:181]ID:1;$al_idBol{$i})
	If ($index#-1)
		GOTO RECORD:C242([ACT_Boletas:181];$index)
		APPEND TO ARRAY:C911(alACT_NumDctoAsoc;[ACT_Boletas:181]Numero:11)
		APPEND TO ARRAY:C911(atACT_TipoDctoAsoc;[ACT_Boletas:181]TipoDocumento:7)
		APPEND TO ARRAY:C911(arACT_MontoDctoAsoc;[ACT_Boletas:181]Monto_Total:6)
		APPEND TO ARRAY:C911(abACT_Nulo;[ACT_Boletas:181]Nula:15)
	End if 
End for 

GOTO RECORD:C242([ACT_Boletas:181];$recNumBoleta)
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=[ACT_Boletas:181]ID:1)
DISTINCT VALUES:C339([ACT_Boletas:181]ID:1;$al_idBol)
For ($i;1;Size of array:C274($al_idBol))
	$index:=Find in field:C653([ACT_Boletas:181]ID:1;$al_idBol{$i})
	If ($index#-1)
		GOTO RECORD:C242([ACT_Boletas:181];$index)
		APPEND TO ARRAY:C911(alACT_NumDctoAsoc;[ACT_Boletas:181]Numero:11)
		APPEND TO ARRAY:C911(atACT_TipoDctoAsoc;[ACT_Boletas:181]TipoDocumento:7)
		APPEND TO ARRAY:C911(arACT_MontoDctoAsoc;[ACT_Boletas:181]Monto_Total:6)
		APPEND TO ARRAY:C911(abACT_Nulo;[ACT_Boletas:181]Nula:15)
	End if 
End for 

GOTO RECORD:C242([ACT_Boletas:181];$recNumBoleta)
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=[ACT_Boletas:181]ID_DctoAsociado:19)
DISTINCT VALUES:C339([ACT_Boletas:181]ID:1;$al_idBol)
For ($i;1;Size of array:C274($al_idBol))
	$index:=Find in field:C653([ACT_Boletas:181]ID:1;$al_idBol{$i})
	If ($index#-1)
		GOTO RECORD:C242([ACT_Boletas:181];$index)
		APPEND TO ARRAY:C911(alACT_NumDctoAsoc;[ACT_Boletas:181]Numero:11)
		APPEND TO ARRAY:C911(atACT_TipoDctoAsoc;[ACT_Boletas:181]TipoDocumento:7)
		APPEND TO ARRAY:C911(arACT_MontoDctoAsoc;[ACT_Boletas:181]Monto_Total:6)
		APPEND TO ARRAY:C911(abACT_Nulo;[ACT_Boletas:181]Nula:15)
	End if 
End for 

SORT ARRAY:C229(abACT_Nulo;alACT_NumDctoAsoc;atACT_TipoDctoAsoc;arACT_MontoDctoAsoc;>)

AL_UpdateArrays (xALP_DocsAsociados;-2)
For ($i;1;Size of array:C274(abACT_Nulo))
	If (abACT_Nulo{$i})
		AL_SetRowColor (xALP_DocsAsociados;$i;"";15*16+8)
		AL_SetRowStyle (xALP_DocsAsociados;$i;2)
	Else 
		AL_SetRowColor (xALP_DocsAsociados;$i;"";16)
		AL_SetRowStyle (xALP_DocsAsociados;$i;0)
	End if 
End for 

GOTO RECORD:C242([ACT_Boletas:181];$recNumBoleta)

OBJECT SET VISIBLE:C603(*;"nulo@";([ACT_Boletas:181]Nula:15))
OBJECT SET VISIBLE:C603(*;"todos@";(Not:C34([ACT_Boletas:181]Nula:15)))

OBJECT SET VISIBLE:C603(*;"vt_histReemp";[ACT_Documentos_de_Pago:176]ID_Dcto_Reemplazado:55#0)
OBJECT SET ENTERABLE:C238(*;"reemplazo";[ACT_Documentos_de_Pago:176]ID_Dcto_Reemplazado:55#0)

REDRAW WINDOW:C456
UNLOAD RECORD:C212([ACT_Transacciones:178])
UNLOAD RECORD:C212([ACT_Cargos:173])
UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
UNLOAD RECORD:C212([Alumnos:2])
UNLOAD RECORD:C212([ACT_Pagos:172])
UNLOAD RECORD:C212([ACT_Documentos_de_Pago:176])
UNLOAD RECORD:C212([ACT_Documentos_de_Pago:176])
  //_o_DISABLE BUTTON(bBWR_Delete)
OBJECT SET ENABLED:C1123(bBWR_Delete;False:C215)
CLEAR SET:C117("Transacciones")

C_LONGINT:C283(hl_DatosBol)
SELECT LIST ITEMS BY POSITION:C381(hl_DatosBol;1)
OBJECT SET VISIBLE:C603(*;"todosPagos@";True:C214)
OBJECT SET VISIBLE:C603(*;"todosDctosAsoc@";False:C215)

  //muestra/oculta link para ubicar documento generado
OBJECT SET VISIBLE:C603(*;"btn_abrirDcto@";[ACT_Boletas:181]MX_pathFile:32#"")
  //muestra/oculta log
  //OBJECT SET VISIBLE(*;"btn_log@";(([ACT_Boletas]DTE_log#"") | ([ACT_Boletas]AR_respuestaWS#"")))
  //20150623 RCH FE AR
OBJECT SET VISIBLE:C603(*;"btn_log@";(([ACT_Boletas:181]DTE_log:26#"") | ([ACT_Boletas:181]AR_RespuestaWS:50#"")))

  //muestra u oculta opciones AR
OBJECT SET VISIBLE:C603(*;"AR_cae@";(<>gCountryCode="ar"))
If (<>gCountryCode="ar")
	OBJECT SET TITLE:C194(*;"btn_log0";"Respuesta WS")
End if 

  //habilita ingreso de numero de documento
If (IT_AltKeyIsDown )
	OBJECT SET ENTERABLE:C238([ACT_Boletas:181]Numero:11;[ACT_Boletas:181]documento_electronico:29)
Else 
	  //20150311 RCH
	  //OBJECT SET ENTERABLE([ACT_Boletas]Numero;(([ACT_Boletas]documento_electronico) & ([ACT_Boletas]Numero=0)))
	OBJECT SET ENTERABLE:C238([ACT_Boletas:181]Numero:11;(([ACT_Boletas:181]documento_electronico:29) & ([ACT_Boletas:181]Numero:11=0) & (<>gCountryCode="mx")))
End if 

  //201150408 RCH
C_REAL:C285($r_idRS)
$r_idRS:=Choose:C955([ACT_Boletas:181]ID_RazonSocial:25#0;[ACT_Boletas:181]ID_RazonSocial:25;-1)
t_razonSocialNombre:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$r_idRS;->[ACT_RazonesSociales:279]razon_social:2)

RELATE ONE:C42([ACT_Boletas:181]ID_CategoriaItems:52)  //20160815 RCH 