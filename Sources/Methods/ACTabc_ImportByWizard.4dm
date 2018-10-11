//%attributes = {}
  //ACTabc_ImportByWizard

  //20080502 RCH Se comparaba la descripción con lo configurado como respuesta. Ahora se compara  el cod de respuesta.
  //al modificar o agregar algo en este método acordarse de modificar para los 2 casos: "caso delimitado por algún caracter" y para el caso "Ancho fijo" 
ACTcfg_LeeBlob ("ACTcfg_GeneralesIngresoPagos")
C_TEXT:C284(vTipoUniv)
ARRAY TEXT:C222(atACT_Modo_de_Pago;0)
C_TEXT:C284($vt_valor)
C_LONGINT:C283($vl_valor)
C_POINTER:C301($ptr_id)
COPY ARRAY:C226(<>atACT_ModosdePago;atACT_Modo_de_Pago)

C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter)
C_BOOLEAN:C305($macFile)
C_BOOLEAN:C305($vb_segundaBusqueda)

ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY TEXT:C222(aDescCodigo;0)
ARRAY TEXT:C222(aCodAprobacion;0)
ARRAY TEXT:C222(aNumTarjeta;0)
ARRAY TEXT:C222(aNombre;0)
ARRAY DATE:C224(aFechaPagos;0)
ARRAY TEXT:C222(aSerieCheque;0)
ARRAY DATE:C224(aFechaDctoCheque;0)
ARRAY TEXT:C222(aCuentaCheque;0)
ARRAY TEXT:C222(aBancoCheque;0)
ARRAY TEXT:C222(aLugarDePago;0)
ARRAY TEXT:C222(aNoOperacion;0)
ARRAY REAL:C219(aMontoMora;0)
ARRAY REAL:C219(aMontoOriginal;0)
ARRAY LONGINT:C221(al_idAvisoAPagar;0)

ARRAY DATE:C224(ad_fechaVcto;0)


  //02-10-125
  // validacion ticket 150497 JVP
  //arreglo para cuando se seleccione la familia

ARRAY TEXT:C222(aCodigoFamilia;0)
  //



READ ONLY:C145([Familia:78])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Personas:7])

  //$vt_tipoArchivo:=[xxACT_ArchivosBancarios]Tipo
  //$vl_tipoArchivo:=[xxACT_ArchivosBancarios]id_forma_de_pago

C_TEXT:C284($codAprobacion;$caracterDelimitador;$relleno)
C_BOOLEAN:C305($tarjeta;$serieCheque;$rut;$nombre;$monto;$fechaPago;$fechaDctoCheque;$descRespuesta;$cuentaCheque;$codAprob;$bancoCheque;$lugarPago;$noOperacion;$aMontoMora;$fechaVcto)
C_TEXT:C284($tarjetaRelleno;$serieChequeRelleno;$rutRelleno;$nombreRelleno;$montoRelleno;$fechaPagoRelleno;$fechaDctoChequeRelleno;$descRespuestaRelleno;$cuentaChequeRelleno;$codAprobRelleno;$bancoChequeRelleno;$lugarPagoRelleno;$noOperacionRelleno)
C_LONGINT:C283($dia;$mes;$agno)
C_REAL:C285($entero;$decimal;$numero;$valorUF)
C_DATE:C307($vd_fechaPago)
C_BOOLEAN:C305(vbACT_ModOrderAvisos)
vbACT_ModOrderAvisos:=False:C215
  //20121005 RCH Recibe forma de pago
C_LONGINT:C283($vl_formadePago)

$document:=$1
vVerifier:="ColegiumTransferFile"
vType:="importer"
Case of 
	: (Count parameters:C259=2)
		$vd_fechaPago:=$2
	: (Count parameters:C259=3)
		$vd_fechaPago:=$2
		$macFile:=$3
	: (Count parameters:C259=4)
		$vd_fechaPago:=$2
		$macFile:=$3
		$vl_formadePago:=$4
	Else 
		$vd_fechaPago:=Current date:C33(*)
End case 

$text:=""
$delimiter:=ACTabc_DetectDelimiter ($document)
$montoOrgUF:=False:C215

LOC_LoadIdenNacionales 
C_TEXT:C284($vt_var1;$vt_var2;$vt_var3;$vt_var4;$vt_var5;$vt_var6)
$vt_var1:="1_"+<>at_IDNacional_Names{1}+"_apoderado"
$vt_var2:="1_"+<>at_IDNacional_Names{1}+"_alumno"
$vt_var3:="2_"+<>at_IDNacional_Names{2}+"_apoderado"
$vt_var4:="3_"+<>at_IDNacional_Names{3}+"_apoderado"
$vt_var5:="2_"+<>at_IDNacional_Names{2}+"_alumno"
$vt_var6:="3_"+<>at_IDNacional_Names{3}+"_alumno"

$vb_segundaBusqueda:=False:C215
Case of 
	: ((vIIdentificador="Rut apoderado") | (vIIdentificador=$vt_var1))
		<>vRUTField:=Field:C253(->[Personas:7]RUT:6)
		<>vRUTTable:=Table:C252(->[Personas:7])
		<>vLabelLink:="RUT"
	: (vIIdentificador="Rut titular Cuenta Corriente")
		<>vRUTField:=Field:C253(->[Personas:7]ACT_RUTTitutal_Cta:50)
		<>vRUTTable:=Table:C252(->[Personas:7])
		<>vLabelLink:="RUT"
	: (vIIdentificador="Rut titular Tarjeta de Crédito")
		<>vRUTField:=Field:C253(->[Personas:7]ACT_RUTTitular_TC:56)
		<>vRUTTable:=Table:C252(->[Personas:7])
		<>vLabelLink:="RUT"
	: (vIIdentificador="Código interno Cuenta Corriente")
		<>vRUTField:=Field:C253(->[ACT_CuentasCorrientes:175]Codigo:19)
		<>vRUTTable:=Table:C252(->[ACT_CuentasCorrientes:175])
		<>vLabelLink:="Código Cta."
	: (vIIdentificador="Código mandato PAC")
		<>vRUTField:=Field:C253(->[Personas:7]ACT_CodMandatoPAC:62)
		<>vRUTTable:=Table:C252(->[Personas:7])
		<>vLabelLink:="Código PAC"
	: (vIIdentificador="Código mandato PAT")
		<>vRUTField:=Field:C253(->[Personas:7]ACT_CodMandatoPAT:63)
		<>vRUTTable:=Table:C252(->[Personas:7])
		<>vLabelLink:="Código PAT"
	: (vIIdentificador="Código de familia")
		<>vRUTField:=Field:C253(->[Personas:7]RUT:6)
		<>vRUTTable:=Table:C252(->[Personas:7])
		  //<>vLabelLink:="RUT"
		  //02-10-125
		  // validacion ticket 150497 JVP
		  //cambio para realizar busqueda de las cuentas de la familia
		<>vLabelLink:="Código de familia"
	: ((vIIdentificador="Rut alumno") | (vIIdentificador=$vt_var2))
		If (cb_PermitePorCta=1)
			<>vRUTField:=Field:C253(->[Alumnos:2]RUT:5)
			<>vRUTTable:=Table:C252(->[Alumnos:2])
			<>vLabelLink:="RUT"
		Else 
			<>vRUTField:=Field:C253(->[Personas:7]RUT:6)
			<>vRUTTable:=Table:C252(->[Personas:7])
			<>vLabelLink:="RUT"
		End if 
	: (vIIdentificador="Número de Aviso de Cobranza")
		<>vRUTField:=Field:C253(->[Personas:7]No:1)
		<>vRUTTable:=Table:C252(->[Personas:7])
		<>vLabelLink:="ID"
		
	: (vIIdentificador=$vt_var3)
		<>vRUTField:=Field:C253(->[Personas:7]IDNacional_2:37)
		<>vRUTTable:=Table:C252(->[Personas:7])
		<>vLabelLink:="IN2"
		
	: (vIIdentificador=$vt_var4)
		<>vRUTField:=Field:C253(->[Personas:7]IDNacional_3:38)
		<>vRUTTable:=Table:C252(->[Personas:7])
		<>vLabelLink:="IN3"
		
	: (vIIdentificador="Código interno apoderado")
		<>vRUTField:=Field:C253(->[Personas:7]Codigo_interno:22)
		<>vRUTTable:=Table:C252(->[Personas:7])
		<>vLabelLink:="Codigo interno"
		
	: (vIIdentificador="pasaporte apoderado")
		<>vRUTField:=Field:C253(->[Personas:7]Pasaporte:59)
		<>vRUTTable:=Table:C252(->[Personas:7])
		<>vLabelLink:="Pasaporte"
		
	: (vIIdentificador=$vt_var5)
		<>vRUTField:=Field:C253(->[Alumnos:2]IDNacional_2:71)
		<>vRUTTable:=Table:C252(->[Alumnos:2])
		<>vLabelLink:="IN2"
		
	: (vIIdentificador=$vt_var6)
		<>vRUTField:=Field:C253(->[Alumnos:2]IDNacional_3:70)
		<>vRUTTable:=Table:C252(->[Alumnos:2])
		<>vLabelLink:="IN3"
		
	: (vIIdentificador="Código interno alumno")
		<>vRUTField:=Field:C253(->[Alumnos:2]Codigo_interno:6)
		<>vRUTTable:=Table:C252(->[Alumnos:2])
		<>vLabelLink:="Codigo interno alumno"
		$vb_segundaBusqueda:=True:C214
		
End case 

$ref:=Open document:C264($document;"";Read mode:K24:5)
If (cs_IEncabezado=1)  //el archivo tiene encabezado
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	RECEIVE PACKET:C104($ref;$text;$delimiter)
Else 
	RECEIVE PACKET:C104($ref;$text;$delimiter)
End if 

$vt_formato:=ACTutl_GetDecimalFormat ("Despliegue_ACT")
$vl_decimalesPago:=<>vlACT_Decimales

If (vt_ICodApr="")  //cod aprobación
	$codAprobacion:=""
Else 
	$codAprobacion:=vt_ICodApr
End if 

While ($text#"")
	$diffProcess:=False:C215
	$decimal:=0
	If (Not:C34($macFile))
		$text:=_O_Win to Mac:C464($text)
	End if 
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aFechaPagos;->aSerieCheque;->aFechaDctoCheque;->aCuentaCheque;->aBancoCheque;->aLugarDePago;->aNoOperacion;->aMontoMora;->aMontoOriginal;->ad_fechaVcto;->al_idAvisoAPagar;->aCodigoFamilia)
	Case of 
		: (PWTrf_h2=1)  //ancho fjo
			C_LONGINT:C283($largo)
			  //$existeCampo:=Find in array(at_Descripcion;"Monto")
			$existeCampo:=Find in array:C230(at_idsTextos;"1")  //monto
			If ($existeCampo#-1)  //monto
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					$monto:=True:C214
					If (<>gCountryCode="cl")
						$largo:=al_Largo{$existeCampo}-al_Decimales{$existeCampo}
						If ($largo<0)  //largo del campo menos decimales es menor a 0
							$largo:=0
						End if 
						aMonto{Size of array:C274(aMonto)}:=Num:C11(ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};$largo;at_Relleno{$existeCampo};""))
					Else 
						$vt_monto:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
						$separador1:=Position:C15(".";$vt_monto)
						$separador2:=Position:C15(",";$vt_monto)
						If (($separador1>0) | ($separador2>0))
							$vt_monto:=Replace string:C233($vt_monto;".";<>tXS_RS_DecimalSeparator)
							$vt_monto:=Replace string:C233($vt_monto;",";<>tXS_RS_DecimalSeparator)
							aMonto{Size of array:C274(aMonto)}:=Round:C94(Num:C11($vt_monto);al_Decimales{$existeCampo})
						Else 
							aMonto{Size of array:C274(aMonto)}:=Round:C94(Num:C11(Substring:C12($vt_monto;1;Length:C16($vt_monto)-al_Decimales{$existeCampo})+<>tXS_RS_DecimalSeparator+Substring:C12($vt_monto;(Length:C16($vt_monto)-al_Decimales{$existeCampo})+1;al_Decimales{$existeCampo}));al_Decimales{$existeCampo})
						End if 
						aMonto{Size of array:C274(aMonto)}:=Round:C94(aMonto{Size of array:C274(aMonto)};$vl_decimalesPago)
					End if 
				Else 
					$monto:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Código respuesta")  `para pat y por lo que revisé siempre es 0 para los aprobados
			$existeCampo:=Find in array:C230(at_idsTextos;"2")  //Código respuesta `para pat y por lo que revisé siempre es 0 para los aprobados
			$l_existeCodigoResp:=$existeCampo
			If ($existeCampo#-1)  //descripción código
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aCodAprobacion{Size of array:C274(aCodAprobacion)}:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					$codAprob:=True:C214
				Else 
					aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
					$codAprob:=False:C215
				End if 
				If ($codAprobacion#"")
					  //If (<>gCountryCode="mx")
					If (cs_usarComoTexto=1)  //20180816 RCH
						If (aCodAprobacion{Size of array:C274(aCodAprobacion)}=$codAprobacion)
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
						Else 
							  //ticket 157568 JVP Mantengo el codigo que viene en el archivo
							  //aCodAprobacion{Size of array(aCodAprobacion)}:=$codAprobacion
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"  //20160610 RCH Este codigo es interno para importar o no un pago. No se debe alterar.
						End if 
					Else 
						If (Num:C11(aCodAprobacion{Size of array:C274(aCodAprobacion)})=Num:C11($codAprobacion))
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
						Else 
							  //ticket 157568 JVP Mantengo el codigo que viene en el archivo
							  //aCodAprobacion{Size of array(aCodAprobacion)}:=$codAprobacion
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"  //20160610 RCH Este codigo es interno para importar o no un pago. No se debe alterar.
						End if 
					End if 
				End if 
			Else 
				  //ticket 157568 JVP Mantengo el codigo que viene en el archivo
				aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Número tarjeta de crédito")
			$existeCampo:=Find in array:C230(at_idsTextos;"3")  //Número tarjeta de crédito
			If ($existeCampo#-1)  //no tarjeta
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aNumTarjeta{Size of array:C274(aNumTarjeta)}:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					$tarjeta:=True:C214
				Else 
					$tarjeta:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Nombre")
			$existeCampo:=Find in array:C230(at_idsTextos;"4")  //Nombre
			If ($existeCampo#-1)  //nombre
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aNombre{Size of array:C274(aNombre)}:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					$nombre:=True:C214
				Else 
					$nombre:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Descripción respuesta")
			$existeCampo:=Find in array:C230(at_idsTextos;"5")  //Descripción respuesta
			If ($existeCampo#-1)  //descripción código
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aDescCodigo{Size of array:C274(aDescCodigo)}:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					$descRespuesta:=True:C214
					  //If ([xxACT_ArchivosBancarios]Tipo="PAC")
					If ($vl_formadePago=-10)
						C_BOOLEAN:C305($b_entra)  //20160610 RCH Se hace cambio porque fue agregada la captura del codigo de respuesta. Para verificar si el registro está aprobado o no
						If ($l_existeCodigoResp=-1)  //20160610 RCH Se hace cambio porque fue agregada la captura del codigo de respuesta. Si no hay tipo 2 configurado, se entra
							$b_entra:=True:C214
						Else 
							If (al_PosIni{$l_existeCodigoResp}=0)  // //20160610 RCH Se hace cambio porque fue agregada la captura del codigo de respuesta. Si existe pero no está configurado, se entra
								$b_entra:=True:C214
							End if 
						End if 
						If ($b_entra)
							If ($codAprobacion#"")
								  //If (<>gCountryCode="mx")
								If (cs_usarComoTexto=1)  //20180816 RCH
									If (aDescCodigo{Size of array:C274(aDescCodigo)}=$codAprobacion)
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
									Else 
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									End if 
								Else 
									If (Num:C11(aDescCodigo{Size of array:C274(aDescCodigo)})=Num:C11($codAprobacion))
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
									Else 
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									End if 
								End if 
							End if 
						End if 
					End if 
				Else 
					$descRespuesta:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Identificador único")
			$existeCampo:=Find in array:C230(at_idsTextos;"6")  //Identificador único
			If ($existeCampo#-1)  //rut
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aRUT{Size of array:C274(aRUT)}:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233(ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"");" ";"");".";"");",";"");"-";"")
					If (cb_PermitePorCta=0)
						Case of 
							: (vIIdentificador="Código de familia")
								REDUCE SELECTION:C351([Personas:7];0)
								REDUCE SELECTION:C351([Familia:78];0)
								REDUCE SELECTION:C351([Familia_RelacionesFamiliares:77];0)
								QUERY:C277([Familia:78];[Familia:78]Codigo_interno:14=aRUT{Size of array:C274(aRUT)})
								If (Records in selection:C76([Familia:78])>0)
									QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
									If (Records in selection:C76([Familia_RelacionesFamiliares:77])>0)
										KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
										QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214;*)
										QUERY SELECTION:C341([Personas:7]; & ;[Personas:7]ACT_NumCargas:65>0)
										If (vTipoUniv="Universo")  //import archivo universo
											  //20121005 RCH Se utiliza id
											  //QUERY SELECTION([Personas];[Personas]ACT_Modo_de_pago=atACT_Modo_de_Pago{2})
											QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_id_modo_de_pago:94=$vl_formadePago)
										End if 
										  //09-10-2015 JVP se realiza este filtro en caso de que ambos padres sean apoderados de cuenta pero de diferentes familias 
										QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
										ARRAY LONGINT:C221(aL_apo_alumnos;0)
										SELECTION TO ARRAY:C260([Alumnos:2]Apoderado_Cuentas_Número:28;aL_apo_alumnos)
										QUERY SELECTION WITH ARRAY:C1050([Personas:7]No:1;aL_apo_alumnos)
										If (Records in selection:C76([Personas:7])=1)
											  //02-10-125
											  // validacion ticket 150497 JVP
											  //agrego valor del codigo de familia al arreglo creado
											aCodigoFamilia{Size of array:C274(aCodigoFamilia)}:=aRUT{Size of array:C274(aRUT)}
											aRUT{Size of array:C274(aRUT)}:=[Personas:7]RUT:6
										End if 
									End if 
								End if 
							: ((vIIdentificador="Rut alumno") | (vIIdentificador=$vt_var2))
								REDUCE SELECTION:C351([Alumnos:2];0)
								REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
								REDUCE SELECTION:C351([Personas:7];0)
								QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=aRUT{Size of array:C274(aRUT)})
								QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
								QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
								If (Records in selection:C76([Personas:7])>0)
									aRUT{Size of array:C274(aRUT)}:=[Personas:7]RUT:6
								End if 
							: (vIIdentificador="Número de Aviso de Cobranza")
								REDUCE SELECTION:C351([Personas:7];0)
								REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)
								QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=Num:C11(aRUT{Size of array:C274(aRUT)}))
								QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
								If (Records in selection:C76([Personas:7])>0)
									aRUT{Size of array:C274(aRUT)}:=String:C10([Personas:7]No:1)
									al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
								Else 
									aRUT{Size of array:C274(aRUT)}:=aRUT{Size of array:C274(aRUT)}+"-N/E"
									aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso no encontrado"
								End if 
								
						End case 
					Else 
						Case of 
							: ($vb_segundaBusqueda)
								READ ONLY:C145([Alumnos:2])
								QUERY:C277([Alumnos:2];[Alumnos:2]Codigo_interno:6;=;aRUT{Size of array:C274(aRUT)})
								If (Records in selection:C76([Alumnos:2])=0)
									$vt_rut:=aRUT{Size of array:C274(aRUT)}
									aRUT{Size of array:C274(aRUT)}:=ACTabc_GetFieldWithFormat (aRUT{Size of array:C274(aRUT)};"N";al_Largo{$existeCampo})
									QUERY:C277([Alumnos:2];[Alumnos:2]Codigo_interno:6;=;aRUT{Size of array:C274(aRUT)})
									If (Records in selection:C76([Alumnos:2])=0)
										aRUT{Size of array:C274(aRUT)}:=$vt_rut
									End if 
								End if 
								  //: ((vIIdentificador="Rut alumno") | (vIIdentificador=$vt_var2))
								  //TICKET 87308. Se comenta todo el codigo de este caso porque cuando se importa por rut alumno y se paga por cuenta el metodo importprocess...
								  // se encarga de buscar la cuenta. Cambiando los punteros sobre la tabla y campo, hace que se importe el pago por apoderado y no por cuenta.
								  //<>vRUTField:=Field(->[Personas]RUT)
								  //<>vRUTTable:=Table(->[Personas])
								  //<>vLabelLink:="RUT"
								  //REDUCE SELECTION([Alumnos];0)
								  //REDUCE SELECTION([ACT_CuentasCorrientes];0)
								  //REDUCE SELECTION([Personas];0)
								  //QUERY([Alumnos];[Alumnos]RUT=aRUT{Size of array(aRUT)})
								  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID_Alumno=[Alumnos]Número)
								  //QUERY([Personas];[Personas]No=[ACT_CuentasCorrientes]ID_Apoderado)
								  //If (Records in selection([Personas])>0)
								  //aRUT{Size of array(aRUT)}:=[Personas]RUT
								  //End if 
							: (vIIdentificador="Número de Aviso de Cobranza")
								REDUCE SELECTION:C351([Personas:7];0)
								REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)
								QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=Num:C11(aRUT{Size of array:C274(aRUT)}))
								QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
								If (Records in selection:C76([Personas:7])>0)
									aRUT{Size of array:C274(aRUT)}:=String:C10([Personas:7]No:1)
									al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
								Else 
									aRUT{Size of array:C274(aRUT)}:=aRUT{Size of array:C274(aRUT)}+"-N/E"
									aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso no encontrado"
								End if 
								
								  //: (vIIdentificador="Código de familia")
								  //REDUCE SELECTION([Personas];0)
								  //REDUCE SELECTION([Familia];0)
								  //REDUCE SELECTION([Familia_RelacionesFamiliares];0)
								  //QUERY([Familia];[Familia]Codigo_interno=aRUT{Size of array(aRUT)})
								  //If (Records in selection([Familia])>0)
								  //QUERY([Familia_RelacionesFamiliares];[Familia_RelacionesFamiliares]ID_Familia=[Familia]Numero)
								  //If (Records in selection([Familia_RelacionesFamiliares])>0)
								  //KRL_RelateSelection (->[Personas]No;->[Familia_RelacionesFamiliares]ID_Persona;"")
								  //QUERY SELECTION([Personas];[Personas]ES_Apoderado_de_Cuentas=True;*)
								  //QUERY SELECTION([Personas]; & ;[Personas]ACT_NumCargas>0)
								  //If (vTipoUniv="Universo")  `import archivo universo
								  //QUERY SELECTION([Personas];[Personas]ACT_Modo_de_pago=atACT_Modo_de_Pago{2})
								  //End if 
								  //If (Records in selection([Personas])=1)
								  //aRUT{Size of array(aRUT)}:=[Personas]RUT
								  //End if 
								  //End if 
								  //End if 
								
						End case 
					End if 
					$rut:=True:C214
				Else 
					$rut:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Fecha de pago")
			$existeCampo:=Find in array:C230(at_idsTextos;"7")  //Fecha de pago
			If ($existeCampo#-1)  //rut
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					  //aFechaPagos{Size of array(aFechaPagos)}:=Date(ACTimp_ExtractInfoFromText (True;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};""))
					$t_fecha:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					aFechaPagos{Size of array:C274(aFechaPagos)}:=DTS_GetDate (ACTabc_OpcionesWizard ("ObtieneDTSFechaParaFormato";->at_Relleno{$existeCampo};->$t_fecha))  //20180822 RCH Ticket 214674
					$fechaPago:=True:C214
				Else 
					$fechaPago:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Cod. Banco")
			$existeCampo:=Find in array:C230(at_idsTextos;"8")  //Cod. Banco
			If ($existeCampo#-1)  //rut
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aBancoCheque{Size of array:C274(aBancoCheque)}:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					If (Length:C16(aBancoCheque{Size of array:C274(aBancoCheque)})>3)  //CÓDIGO BANCARIO DEBE SER DE LARGO 3
						aBancoCheque{Size of array:C274(aBancoCheque)}:=""
					Else 
						If (Length:C16(aBancoCheque{Size of array:C274(aBancoCheque)})<3)
							aBancoCheque{Size of array:C274(aBancoCheque)}:=ST_RigthChars ("000"+aBancoCheque{Size of array:C274(aBancoCheque)};3)
						End if 
					End if 
					$bancoCheque:=True:C214
				Else 
					$bancoCheque:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Serie")
			$existeCampo:=Find in array:C230(at_idsTextos;"9")  //Serie
			If ($existeCampo#-1)  //rut
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aSerieCheque{Size of array:C274(aSerieCheque)}:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					$serieCheque:=True:C214
				Else 
					$serieCheque:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Cuenta")
			$existeCampo:=Find in array:C230(at_idsTextos;"10")  //Cuenta
			If ($existeCampo#-1)  //rut
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aCuentaCheque{Size of array:C274(aCuentaCheque)}:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					$cuentaCheque:=True:C214
				Else 
					$cuentaCheque:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Fecha documento")
			$existeCampo:=Find in array:C230(at_idsTextos;"11")  //Fecha documento
			If ($existeCampo#-1)  //rut
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aFechaDctoCheque{Size of array:C274(aFechaDctoCheque)}:=Date:C102(ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};""))
					$fechaDctoCheque:=True:C214
				Else 
					$fechaDctoCheque:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Número tarjeta")
			$existeCampo:=Find in array:C230(at_idsTextos;"12")  //Número tarjeta
			If ($existeCampo#-1)  //rut
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aNumTarjeta{Size of array:C274(aNumTarjeta)}:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					$tarjeta:=True:C214
				Else 
					$tarjeta:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Lugar de pago")
			$existeCampo:=Find in array:C230(at_idsTextos;"13")  //Lugar de pago
			If ($existeCampo#-1)  //rut
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aLugarDePago{Size of array:C274(aLugarDePago)}:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					$lugarPago:=True:C214
				Else 
					$lugarPago:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Número de operación")
			$existeCampo:=Find in array:C230(at_idsTextos;"14")  //Número de operación
			If ($existeCampo#-1)  //rut
				  //If (al_Numero{$existeCampo}>0)
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					aNoOperacion{Size of array:C274(aNoOperacion)}:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
					$noOperacion:=True:C214
				Else 
					$noOperacion:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Monto original")
			$existeCampo:=Find in array:C230(at_idsTextos;"15")  //Monto original
			If ($existeCampo#-1)
				  //If (al_Numero{$existeCampo}>0)
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					If (<>gCountryCode="cl")
						$largo:=al_Largo{$existeCampo}-al_Decimales{$existeCampo}
						If ($largo<0)  //largo del campo menos decimales es menor a 0
							$largo:=0
						End if 
						aMontoOriginal{Size of array:C274(aMontoOriginal)}:=Num:C11(ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};$largo;at_Relleno{$existeCampo};""))
					Else 
						$vt_monto:=ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};"")
						$separador1:=Position:C15(".";$vt_monto)
						$separador2:=Position:C15(",";$vt_monto)
						If (($separador1>0) | ($separador2>0))
							$vt_monto:=Replace string:C233($vt_monto;".";<>tXS_RS_DecimalSeparator)
							$vt_monto:=Replace string:C233($vt_monto;",";<>tXS_RS_DecimalSeparator)
							aMontoOriginal{Size of array:C274(aMontoOriginal)}:=Round:C94(Num:C11($vt_monto);al_Decimales{$existeCampo})
						Else 
							aMontoOriginal{Size of array:C274(aMontoOriginal)}:=Round:C94(Num:C11(Substring:C12($vt_monto;1;Length:C16($vt_monto)-al_Decimales{$existeCampo})+<>tXS_RS_DecimalSeparator+Substring:C12($vt_monto;(Length:C16($vt_monto)-al_Decimales{$existeCampo})+1;al_Decimales{$existeCampo}));al_Decimales{$existeCampo})
						End if 
					End if 
					aMontoMora{Size of array:C274(aMontoMora)}:=Round:C94(aMonto{Size of array:C274(aMonto)}-aMontoOriginal{Size of array:C274(aMontoOriginal)};$vl_decimalesPago)
					If (aMontoMora{Size of array:C274(aMontoMora)}<0)
						aMontoMora{Size of array:C274(aMontoMora)}:=0
					End if 
					$aMontoMora:=True:C214
				Else 
					  //$aMontoMora:=False
				End if 
			End if 
			
			$existeCampo:=Find in array:C230(at_idsTextos;"17")  //día vencimiento 
			If ($existeCampo#-1)
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					$dia:=Num:C11(ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};""))
				End if 
			End if 
			
			$existeCampo:=Find in array:C230(at_idsTextos;"18")  //mes vencimiento 
			If ($existeCampo#-1)
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					$mes:=Num:C11(ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};""))
				End if 
			End if 
			
			$existeCampo:=Find in array:C230(at_idsTextos;"19")  //año vencimiento 
			If ($existeCampo#-1)
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					$agno:=Num:C11(ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};""))
				End if 
			End if 
			
			If (($dia#0) & ($mes#0) & ($agno#0))
				If ($agno<2000)
					$agno:=$agno+2000
				End if 
				ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear ($dia;$mes;$agno)
				$fechaVcto:=True:C214
			End if 
			
			$existeCampo:=Find in array:C230(at_idsTextos;"20")  //monto original en UF
			If ($existeCampo#-1)
				If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
					$numero:=Num:C11(ACTimp_ExtractInfoFromText (True:C214;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};""))
					If (al_Decimales{$existeCampo}>0)
						$decimal:=al_Decimales{$existeCampo}
					Else 
						$decimal:=0
					End if 
					$aMontoMora:=True:C214
				End if 
			End if 
			  //$dia:=0
			  //$mes:=0
			  //$agno:=0
			  //
			  //$existeCampo:=Find in array(at_idsTextos;"22")  `día pago
			  //If ($existeCampo#-1)
			  //If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
			  //$dia:=Num(ACTimp_ExtractInfoFromText (True;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};""))
			  //End if 
			  //End if 
			  //
			  //$existeCampo:=Find in array(at_idsTextos;"23")  `mes pago
			  //If ($existeCampo#-1)
			  //If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
			  //$mes:=Num(ACTimp_ExtractInfoFromText (True;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};""))
			  //End if 
			  //End if 
			  //
			  //$existeCampo:=Find in array(at_idsTextos;"24")  `año `pago
			  //If ($existeCampo#-1)
			  //If ((al_PosIni{$existeCampo}>0) & (al_Largo{$existeCampo}>0))
			  //$agno:=Num(ACTimp_ExtractInfoFromText (True;$text;at_Alineado{$existeCampo};al_PosIni{$existeCampo};al_Largo{$existeCampo};at_Relleno{$existeCampo};""))
			  //End if 
			  //End if 
			  //
			  //If (($dia#0) & ($mes#0) & ($agno#0))
			  //If ($agno<2000)
			  //$agno:=$agno+2000
			  //End if 
			  //aFechaPagos{Size of array(aFechaPagos)}:=DT_GetDateFromDayMonthYear ($dia;$mes;$agno)
			  //$fechaPago:=True
			  //End if 
			  //
		: (PWTrf_h1=1)  //delimitado por algún caracter
			Case of 
				: (WTrf_s1=1)
					$caracterDelimitador:="\t"
				: (WTrf_s2=1)
					$caracterDelimitador:=";"
				: (WTrf_s3=1)
					$caracterDelimitador:=","
				: (WTrf_s4=1)
					$caracterDelimitador:=WTrf_s4_CaracterOtro
			End case 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Monto")
			$existeCampo:=Find in array:C230(at_idsTextos;"1")  //monto
			If ($existeCampo#-1)  //monto
				If (al_Numero{$existeCampo}>0)
					$monto:=True:C214
					If (<>gCountryCode="cl")
						aMonto{Size of array:C274(aMonto)}:=Num:C11(Replace string:C233(Replace string:C233(ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador);".";"");",";""))
						If (al_Decimales{$existeCampo}>0)  // PARA QUITAR DECIMALES
							aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12(String:C10(aMonto{Size of array:C274(aMonto)});1;Length:C16(String:C10(aMonto{Size of array:C274(aMonto)}))-al_Decimales{$existeCampo}))
						End if 
					Else 
						$vt_monto:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
						$separador1:=Position:C15(".";$vt_monto)
						$separador2:=Position:C15(",";$vt_monto)
						If (($separador1>0) | ($separador2>0))
							$vt_monto:=Replace string:C233($vt_monto;".";<>tXS_RS_DecimalSeparator)
							$vt_monto:=Replace string:C233($vt_monto;",";<>tXS_RS_DecimalSeparator)
							aMonto{Size of array:C274(aMonto)}:=Round:C94(Num:C11($vt_monto);al_Decimales{$existeCampo})
						Else 
							aMonto{Size of array:C274(aMonto)}:=Round:C94(Num:C11(Substring:C12($vt_monto;1;Length:C16($vt_monto)-al_Decimales{$existeCampo})+<>tXS_RS_DecimalSeparator+Substring:C12($vt_monto;(Length:C16($vt_monto)-al_Decimales{$existeCampo})+1;al_Decimales{$existeCampo}));al_Decimales{$existeCampo})
						End if 
						aMonto{Size of array:C274(aMonto)}:=Round:C94(Num:C11(String:C10(aMonto{Size of array:C274(aMonto)}));$vl_decimalesPago)
					End if 
				Else 
					$monto:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Código respuesta")
			$existeCampo:=Find in array:C230(at_idsTextos;"2")  //Código respuesta `para pat y por lo que revisé siempre es 0 para los aprobados
			$l_existeCodigoResp:=$existeCampo
			If ($existeCampo#-1)  //descripción código
				If (al_Numero{$existeCampo}>0)
					  //$codAprob:=True
					aCodAprobacion{Size of array:C274(aCodAprobacion)}:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
				Else 
					aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
					$codAprob:=False:C215
				End if 
				
				If ($codAprobacion#"")
					  //If (<>gCountryCode="mx")
					If (cs_usarComoTexto=1)  //20180816 RCH
						If (aCodAprobacion{Size of array:C274(aCodAprobacion)}=$codAprobacion)
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
						Else 
							  //aCodAprobacion{Size of array(aCodAprobacion)}:=$codAprobacion
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"  //20160610 RCH Este codigo es interno para importar o no un pago. No se debe alterar.
						End if 
					Else 
						If (Num:C11(aCodAprobacion{Size of array:C274(aCodAprobacion)})=Num:C11($codAprobacion))
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
						Else 
							  //ticket 157568 JVP Mantengo el codigo que viene en el archivo
							  //aCodAprobacion{Size of array(aCodAprobacion)}:=$codAprobacion
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"  //20160610 RCH Este codigo es interno para importar o no un pago. No se debe alterar.
						End if 
					End if 
				End if 
				
			Else 
				aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Número tarjeta de crédito")
			$existeCampo:=Find in array:C230(at_idsTextos;"3")  //Número tarjeta de crédito
			If ($existeCampo#-1)  //no tarjeta
				If (al_Numero{$existeCampo}>0)
					$tarjeta:=True:C214
					aNumTarjeta{Size of array:C274(aNumTarjeta)}:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
				Else 
					$tarjeta:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Nombre")
			$existeCampo:=Find in array:C230(at_idsTextos;"4")  //Nombre
			If ($existeCampo#-1)  //nombre
				If (al_Numero{$existeCampo}>0)
					$nombre:=True:C214
					aNombre{Size of array:C274(aNombre)}:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
				Else 
					$nombre:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Descripción respuesta")
			$existeCampo:=Find in array:C230(at_idsTextos;"5")  //Descripción respuesta
			If ($existeCampo#-1)  //descripción código
				If (al_Numero{$existeCampo}>0)
					$descRespuesta:=True:C214
					If (at_Relleno{$existeCampo}="Espacio")
						$descRespuestaRelleno:=" "
					Else 
						If (at_Relleno{$existeCampo}="Cero")
							$descRespuestaRelleno:="0"
						End if 
					End if 
					If (at_Alineado{$existeCampo}="Der")
						  //aDescCodigo{Size of array(aDescCodigo)}:=ST_DeleteCharsLeft (ST_GetWord ($text;al_Numero{$existeCampo};$caracterDelimitador);$descRespuestaRelleno)
						aDescCodigo{Size of array:C274(aDescCodigo)}:=ST_GetWord ($text;al_Numero{$existeCampo};$caracterDelimitador)
					Else 
						aDescCodigo{Size of array:C274(aDescCodigo)}:=ST_ClearSpaces (ST_GetWord ($text;al_Numero{$existeCampo};$caracterDelimitador))
					End if 
					$descRespuesta:=True:C214
					  //If ([xxACT_ArchivosBancarios]Tipo="PAC")
					If ($vl_formadePago=-10)
						C_BOOLEAN:C305($b_entra)  //20160610 RCH Se hace cambio porque fue agregada la captura del codigo de respuesta. Para verificar si el registro está aprobado o no
						If ($l_existeCodigoResp=-1)  //20160610 RCH Se hace cambio porque fue agregada la captura del codigo de respuesta. Si no hay tipo 2 configurado, se entra
							$b_entra:=True:C214
						Else 
							If (al_Numero{$l_existeCodigoResp}=0)  // //20160610 RCH Se hace cambio porque fue agregada la captura del codigo de respuesta. Si existe pero no está configurado, se entra
								$b_entra:=True:C214
							End if 
						End if 
						If ($b_entra)
							If ($codAprobacion#"")
								  //If (<>gCountryCode="mx")
								If (cs_usarComoTexto=1)  //20180816 RCH
									If (aDescCodigo{Size of array:C274(aDescCodigo)}=$codAprobacion)
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
									Else 
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									End if 
								Else 
									If (Num:C11(aDescCodigo{Size of array:C274(aDescCodigo)})=Num:C11($codAprobacion))
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
									Else 
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									End if 
								End if 
							End if 
						End if 
					End if 
				Else 
					$descRespuesta:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Identificador único")
			$existeCampo:=Find in array:C230(at_idsTextos;"6")  //Identificador único
			If ($existeCampo#-1)  //rut
				If (al_Numero{$existeCampo}>0)
					$rut:=True:C214
					aRUT{Size of array:C274(aRUT)}:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233(ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador);" ";"");".";"");",";"");"-";"")
					If (cb_PermitePorCta=0)
						Case of 
							: (vIIdentificador="Código de familia")
								REDUCE SELECTION:C351([Personas:7];0)
								REDUCE SELECTION:C351([Familia:78];0)
								REDUCE SELECTION:C351([Familia_RelacionesFamiliares:77];0)
								QUERY:C277([Familia:78];[Familia:78]Codigo_interno:14=aRUT{Size of array:C274(aRUT)})
								If (Records in selection:C76([Familia:78])>0)
									QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
									If (Records in selection:C76([Familia_RelacionesFamiliares:77])>0)
										KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
										QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214;*)
										QUERY SELECTION:C341([Personas:7]; & ;[Personas:7]ACT_NumCargas:65>0)
										If (vTipoUniv="Universo")
											  //20121005 RCH Se utiliza id
											  //QUERY SELECTION([Personas];[Personas]ACT_Modo_de_pago=atACT_Modo_de_Pago{2})
											QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_id_modo_de_pago:94=$vl_formadePago)
										End if 
										  //09-10-2015 JVP se realiza este filtro en caso de que ambos padres sean apoderados de cuenta pero de diferentes familias 
										QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
										ARRAY LONGINT:C221(aL_apo_alumnos;0)
										SELECTION TO ARRAY:C260([Alumnos:2]Apoderado_Cuentas_Número:28;aL_apo_alumnos)
										QUERY SELECTION WITH ARRAY:C1050([Personas:7]No:1;aL_apo_alumnos)
										If (Records in selection:C76([Personas:7])=1)
											  //02-10-125
											  // validacion ticket 150497 JVP
											  //agrego valor del codigo de familia al arreglo creado
											aCodigoFamilia{Size of array:C274(aCodigoFamilia)}:=aRUT{Size of array:C274(aRUT)}
											aRUT{Size of array:C274(aRUT)}:=[Personas:7]RUT:6
										End if 
									End if 
								End if 
							: ((vIIdentificador="Rut alumno") | (vIIdentificador=$vt_var2))
								REDUCE SELECTION:C351([Alumnos:2];0)
								REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
								REDUCE SELECTION:C351([Personas:7];0)
								QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=aRUT{Size of array:C274(aRUT)})
								QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
								QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
								If (Records in selection:C76([Personas:7])>0)
									aRUT{Size of array:C274(aRUT)}:=[Personas:7]RUT:6
								End if 
							: (vIIdentificador="Número de Aviso de Cobranza")
								REDUCE SELECTION:C351([Personas:7];0)
								REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)
								QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=Num:C11(aRUT{Size of array:C274(aRUT)}))
								QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
								If (Records in selection:C76([Personas:7])>0)
									aRUT{Size of array:C274(aRUT)}:=String:C10([Personas:7]No:1)
									al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
								Else 
									aRUT{Size of array:C274(aRUT)}:=aRUT{Size of array:C274(aRUT)}+"-N/E"
									aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso no encontrado"
								End if 
						End case 
					Else 
						Case of 
								  //: ((vIIdentificador="Rut alumno") | (vIIdentificador=$vt_var2))
								  //TICKET 87308. Se comenta todo el codigo de este caso porque cuando se importa por rut alumno y se paga por cuenta el metodo importprocess...
								  // se encarga de buscar la cuenta. Cambiando los punteros sobre la tabla y campo, hace que se importe el pago por apoderado y no por cuenta.
								  //<>vRUTField:=Field(->[Personas]RUT)
								  //<>vRUTTable:=Table(->[Personas])
								  //<>vLabelLink:="RUT"
								  //REDUCE SELECTION([Alumnos];0)
								  //REDUCE SELECTION([ACT_CuentasCorrientes];0)
								  //REDUCE SELECTION([Personas];0)
								  //QUERY([Alumnos];[Alumnos]RUT=aRUT{Size of array(aRUT)})
								  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID_Alumno=[Alumnos]Número)
								  //QUERY([Personas];[Personas]No=[ACT_CuentasCorrientes]ID_Apoderado)
								  //If (Records in selection([Personas])>0)
								  //aRUT{Size of array(aRUT)}:=[Personas]RUT
								  //End if 
								
							: (vIIdentificador="Número de Aviso de Cobranza")
								REDUCE SELECTION:C351([Personas:7];0)
								REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)
								QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=Num:C11(aRUT{Size of array:C274(aRUT)}))
								QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
								If (Records in selection:C76([Personas:7])>0)
									aRUT{Size of array:C274(aRUT)}:=String:C10([Personas:7]No:1)
									al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
								Else 
									aRUT{Size of array:C274(aRUT)}:=aRUT{Size of array:C274(aRUT)}+"-N/E"
									aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso no encontrado"
								End if 
								
								  //: (vIIdentificador="Código de familia")
								  //REDUCE SELECTION([Personas];0)
								  //REDUCE SELECTION([Familia];0)
								  //REDUCE SELECTION([Familia_RelacionesFamiliares];0)
								  //QUERY([Familia];[Familia]Codigo_interno=aRUT{Size of array(aRUT)})
								  //If (Records in selection([Familia])>0)
								  //QUERY([Familia_RelacionesFamiliares];[Familia_RelacionesFamiliares]ID_Familia=[Familia]Numero)
								  //If (Records in selection([Familia_RelacionesFamiliares])>0)
								  //KRL_RelateSelection (->[Personas]No;->[Familia_RelacionesFamiliares]ID_Persona;"")
								  //QUERY SELECTION([Personas];[Personas]ES_Apoderado_de_Cuentas=True;*)
								  //QUERY SELECTION([Personas]; & ;[Personas]ACT_NumCargas>0)
								  //If (vTipoUniv="Universo")  `import archivo universo
								  //QUERY SELECTION([Personas];[Personas]ACT_Modo_de_pago=atACT_Modo_de_Pago{2})
								  //End if 
								  //If (Records in selection([Personas])=1)
								  //aRUT{Size of array(aRUT)}:=[Personas]RUT
								  //End if 
								  //End if 
								  //End if 
								
						End case 
					End if 
				Else 
					$rut:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Fecha de pago")
			$existeCampo:=Find in array:C230(at_idsTextos;"7")  //Fecha de pago
			If ($existeCampo#-1)  //rut
				If (al_Numero{$existeCampo}>0)
					$fechaPago:=True:C214
					  //aFechaPagos{Size of array(aFechaPagos)}:=Date(ACTimp_ExtractInfoFromText (False;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador))
					$t_fecha:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
					aFechaPagos{Size of array:C274(aFechaPagos)}:=DTS_GetDate (ACTabc_OpcionesWizard ("ObtieneDTSFechaParaFormato";->at_Relleno{$existeCampo};->$t_fecha))  //20180822 RCH Ticket 214674
				Else 
					$fechaPago:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Cod. Banco")
			$existeCampo:=Find in array:C230(at_idsTextos;"8")  //Cod. Banco
			If ($existeCampo#-1)  //rut
				If (al_Numero{$existeCampo}>0)
					$bancoCheque:=True:C214
					aBancoCheque{Size of array:C274(aBancoCheque)}:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
					
					If (Length:C16(aBancoCheque{Size of array:C274(aBancoCheque)})>3)  //CÓDIGO BANCARIO DEBE SER DE LARGO 3
						aBancoCheque{Size of array:C274(aBancoCheque)}:=""
					Else 
						If (Length:C16(aBancoCheque{Size of array:C274(aBancoCheque)})<3)
							aBancoCheque{Size of array:C274(aBancoCheque)}:=ST_RigthChars ("000"+aBancoCheque{Size of array:C274(aBancoCheque)};3)
						End if 
					End if 
					
				Else 
					$bancoCheque:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Serie")
			$existeCampo:=Find in array:C230(at_idsTextos;"9")  //Serie
			If ($existeCampo#-1)  //rut
				If (al_Numero{$existeCampo}>0)
					$serieCheque:=True:C214
					aSerieCheque{Size of array:C274(aSerieCheque)}:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
				Else 
					$serieCheque:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Cuenta")
			$existeCampo:=Find in array:C230(at_idsTextos;"10")  //Cuenta
			If ($existeCampo#-1)  //rut
				If (al_Numero{$existeCampo}>0)
					$cuentaCheque:=True:C214
					aCuentaCheque{Size of array:C274(aCuentaCheque)}:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
				Else 
					$cuentaCheque:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Fecha documento")
			$existeCampo:=Find in array:C230(at_idsTextos;"11")  //Fecha documento
			If ($existeCampo#-1)  //rut
				If (al_Numero{$existeCampo}>0)
					$fechaDctoCheque:=True:C214
					aFechaDctoCheque{Size of array:C274(aFechaDctoCheque)}:=Date:C102(ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador))
				Else 
					$fechaDctoCheque:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Número tarjeta")
			$existeCampo:=Find in array:C230(at_idsTextos;"12")  //Número tarjeta
			If ($existeCampo#-1)  //rut
				If (al_Numero{$existeCampo}>0)
					$tarjeta:=True:C214
					aNumTarjeta{Size of array:C274(aNumTarjeta)}:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
				Else 
					$tarjeta:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Lugar de pago")
			$existeCampo:=Find in array:C230(at_idsTextos;"13")  //Lugar de pago
			If ($existeCampo#-1)  //rut
				If (al_Numero{$existeCampo}>0)
					aLugarDePago{Size of array:C274(aLugarDePago)}:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
					$lugarPago:=True:C214
				Else 
					$lugarPago:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Número de operación")
			$existeCampo:=Find in array:C230(at_idsTextos;"14")  //Número de operación
			If ($existeCampo#-1)  //rut
				If (al_Numero{$existeCampo}>0)
					aNoOperacion{Size of array:C274(aNoOperacion)}:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
					$noOperacion:=True:C214
				Else 
					$noOperacion:=False:C215
				End if 
			End if 
			
			  //$existeCampo:=Find in array(at_Descripcion;"Monto original")
			$existeCampo:=Find in array:C230(at_idsTextos;"15")  //Monto original
			If ($existeCampo#-1)  //rut
				If (al_Numero{$existeCampo}>0)
					aMontoOriginal{Size of array:C274(aMontoOriginal)}:=Num:C11(ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador))
					If (<>gCountryCode="cl")
						If (al_Decimales{$existeCampo}>0)  // PARA QUITAR DECIMALES
							aMontoOriginal{Size of array:C274(aMontoOriginal)}:=Num:C11(Substring:C12(String:C10(aMontoOriginal{Size of array:C274(aMontoOriginal)});1;Length:C16(String:C10(aMontoOriginal{Size of array:C274(aMontoOriginal)}))-al_Decimales{$existeCampo}))
						End if 
					Else 
						$vt_monto:=ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador)
						$separador1:=Position:C15(".";$vt_monto)
						$separador2:=Position:C15(",";$vt_monto)
						If (($separador1>0) | ($separador2>0))
							$vt_monto:=Replace string:C233($vt_monto;".";<>tXS_RS_DecimalSeparator)
							$vt_monto:=Replace string:C233($vt_monto;",";<>tXS_RS_DecimalSeparator)
							aMontoOriginal{Size of array:C274(aMontoOriginal)}:=Round:C94(Num:C11($vt_monto);al_Decimales{$existeCampo})
						Else 
							aMontoOriginal{Size of array:C274(aMontoOriginal)}:=Round:C94(Num:C11(Substring:C12($vt_monto;1;Length:C16($vt_monto)-al_Decimales{$existeCampo})+<>tXS_RS_DecimalSeparator+Substring:C12($vt_monto;(Length:C16($vt_monto)-al_Decimales{$existeCampo})+1;al_Decimales{$existeCampo}));al_Decimales{$existeCampo})
						End if 
						aMontoOriginal{Size of array:C274(aMontoOriginal)}:=Round:C94(Num:C11(String:C10(aMontoOriginal{Size of array:C274(aMontoOriginal)}));$vl_decimalesPago)
					End if 
					aMontoMora{Size of array:C274(aMontoMora)}:=aMonto{Size of array:C274(aMonto)}-aMontoOriginal{Size of array:C274(aMontoOriginal)}
					If (aMontoMora{Size of array:C274(aMontoMora)}<0)
						aMontoMora{Size of array:C274(aMontoMora)}:=0
					End if 
					$aMontoMora:=True:C214
				Else 
					  //$aMontoMora:=False
				End if 
			End if 
			
			$existeCampo:=Find in array:C230(at_idsTextos;"17")  //día vencimiento 
			If ($existeCampo#-1)
				If (al_Numero{$existeCampo}>0)
					$dia:=Num:C11(ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador))
				End if 
			End if 
			
			$existeCampo:=Find in array:C230(at_idsTextos;"18")  //mes vencimiento 
			If ($existeCampo#-1)
				If (al_Numero{$existeCampo}>0)
					$mes:=Num:C11(ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador))
				End if 
			End if 
			
			$existeCampo:=Find in array:C230(at_idsTextos;"19")  //año vencimiento 
			If ($existeCampo#-1)
				If (al_Numero{$existeCampo}>0)
					$agno:=Num:C11(ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador))
				End if 
			End if 
			
			If (($dia#0) & ($mes#0) & ($agno#0))
				If ($agno<2000)
					$agno:=$agno+2000
				End if 
				ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear ($dia;$mes;$agno)
				$fechaVcto:=True:C214
			Else 
				  //$fechaVcto:=False
			End if 
			
			$existeCampo:=Find in array:C230(at_idsTextos;"20")  //monto orig en UF
			If ($existeCampo#-1)
				If (al_Numero{$existeCampo}>0)
					$numero:=Num:C11(ACTimp_ExtractInfoFromText (False:C215;$text;at_Alineado{$existeCampo};al_Numero{$existeCampo};0;at_Relleno{$existeCampo};$caracterDelimitador))
					If (al_Decimales{$existeCampo}>0)
						$decimal:=al_Decimales{$existeCampo}
					Else 
						$decimal:=0
					End if 
					$aMontoMora:=True:C214
				Else 
					  //$aMontoMora:=False
				End if 
			End if 
	End case 
	
	If (ad_fechaVcto{Size of array:C274(ad_fechaVcto)}#!00-00-00!)
		$diffProcess:=True:C214
	Else 
		$diffProcess:=False:C215
	End if 
	
	  //If (($diffProcess) & ($vt_tipoArchivo=atACT_Modo_de_Pago{4}) & (<>vtXS_CountryCode="cl"))
	  //If (($diffProcess) & ($vl_tipoArchivo=-11) & (<>vtXS_CountryCode="cl"))
	If (($diffProcess) & ($vl_formadePago=-11) & (<>vtXS_CountryCode="cl"))  //20160610 RCH
		If ($decimal>0)
			$entero:=Num:C11(Substring:C12(String:C10($numero);1;Length:C16(String:C10($numero))-$decimal))
			$decimal:=Num:C11(Substring:C12(String:C10($numero);Length:C16(String:C10($numero))-$decimal+1))
			$numero:=Num:C11(String:C10($entero)+<>tXS_RS_DecimalSeparator+String:C10($decimal))
		End if 
		  //If ($vd_fechaPago>ad_fechaVcto{Size of array(ad_fechaVcto)})
		  //$vd_fechaPago:=ad_fechaVcto{Size of array(ad_fechaVcto)}
		  //End if 
		
		aRUT{Size of array:C274(aRUT)}:=ST_GetCleanString (aRUT{Size of array:C274(aRUT)})
		If (<>vLabelLink="RUT")
			$rutSTR:=CTRY_CL_VerifRUT (aRUT{Size of array:C274(aRUT)};False:C215)
		Else 
			$rutSTR:=aRUT{Size of array:C274(aRUT)}
		End if 
		If (<>vLabelLink="ID")
			If (Num:C11(aCodAprobacion{Size of array:C274(aCodAprobacion)})=0)
				$vl_valor:=Num:C11(aRUT{Size of array:C274(aRUT)})
			Else 
				$vl_valor:=-1
			End if 
			$ptr_id:=->$vl_valor
		Else 
			$vt_valor:=aRUT{Size of array:C274(aRUT)}
			$ptr_id:=->$vt_valor
		End if 
		
		vLinkingField:=Field:C253(<>vRUTTable;<>vRUTField)
		vLinkingTable:=Table:C252(<>vRUTTable)
		QUERY:C277(vLinkingTable->;vLinkingField->=$ptr_id->)
		If (Records in selection:C76(vLinkingTable->)=1)
			RNApdo:=-1
			RNCta:=-1
			RNTercero:=-1
			Case of 
				: (((vIIdentificador="Rut apoderado") | (vIIdentificador=$vt_var1)) | (vIIdentificador="Rut titular Cuenta Corriente") | (vIIdentificador="Rut titular Tarjeta de Crédito") | (vIIdentificador="Código mandato PAC") | (vIIdentificador="Código mandato PAT") | (vIIdentificador="Código de familia") | (vIIdentificador="Número de Aviso de Cobranza"))
					RNApdo:=Record number:C243([Personas:7])
					ACTpgs_CargaDatosPagoApdo (False:C215;$vd_fechaPago;0)
				: ((vIIdentificador="Código interno Cuenta Corriente") | ((vIIdentificador="Rut alumno") | (vIIdentificador=$vt_var2)))
					If ((Table:C252(vLinkingTable))=(Table:C252(->[Alumnos:2])))
						KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
					End if 
					RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
					ACTpgs_CargaDatosPagoCta (False:C215;$vd_fechaPago;0)
			End case 
			$deudaTotal:=ACTpgs_retornaMontoAPagar (ad_fechaVcto{Size of array:C274(ad_fechaVcto)};$vd_fechaPago;al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)})
			If ($deudaTotal#-1)
				aMontoMora{Size of array:C274(aMontoMora)}:=aMonto{Size of array:C274(aMonto)}-$deudaTotal
			End if 
			$montoOrgUF:=True:C214
		End if 
	Else 
		  //$aMontoMora:=False
	End if 
	
	RECEIVE PACKET:C104($ref;$text;$delimiter)
End while 
CLOSE DOCUMENT:C267($ref)

If (($monto) | ($rut) | ($descRespuesta) | ($codAprob) | ($tarjeta) | ($nombre) | ($fechaPago) | ($serieCheque) | ($fechaDctoCheque) | ($cuentaCheque) | ($bancoCheque) | ($lugarPago) | ($noOperacion) | ($aMontoMora) | ($fechaVcto))  //valido que haya info
	If (cs_IPie=1)  //el archivo tiene pie
		AT_Delete (Size of array:C274(aMonto);1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aFechaPagos;->aSerieCheque;->aFechaDctoCheque;->aCuentaCheque;->aBancoCheque;->aLugarDePago;->aNoOperacion;->aMontoMora;->aMontoOriginal;->ad_fechaVcto;->al_idAvisoAPagar)
	End if 
	
	C_POINTER:C301($ptr)
	ARRAY TEXT:C222(at_arreglos2Import;0)
	ARRAY TEXT:C222(at_headers2Import;0)
	C_REAL:C285(monto2Import;montoTotal2Import)
	C_LONGINT:C283(noRegistrosTotal2Import;noRegistros2Import)
	
	If (Not:C34($nombre))  //sino viene el nombre del apoderado se busca
		$nombre:=True:C214
		ARRAY TEXT:C222(aNombre;0)
		C_TEXT:C284($vt_rut)
		vLinkingField:=Field:C253(<>vRUTTable;<>vRUTField)
		vLinkingTable:=Table:C252(<>vRUTTable)
		
		For ($i;1;Size of array:C274(aRUT))
			REDUCE SELECTION:C351([Personas:7];0)
			REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
			REDUCE SELECTION:C351([Alumnos:2];0)
			REDUCE SELECTION:C351([ACT_Terceros:138];0)
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([ACT_Terceros:138])
			If (<>vLabelLink="ID")
				If (Num:C11(aCodAprobacion{$i})=0)
					$vl_valor:=Num:C11(aRut{$i})
				Else 
					$vl_valor:=-1
				End if 
				$ptr_id:=->$vl_valor
			Else 
				$vt_valor:=aRut{$i}
				$ptr_id:=->$vt_valor
			End if 
			C_POINTER:C301($y_nombre)
			If (Table:C252(->[ACT_CuentasCorrientes:175])=<>vRUTTable)
				QUERY:C277(vLinkingTable->;vLinkingField->=$ptr_id->)
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
				APPEND TO ARRAY:C911(aNombre;[Alumnos:2]apellidos_y_nombres:40)
			Else 
				Case of 
					: (Table:C252(->[Alumnos:2])=<>vRUTTable)
						$y_nombre:=->[Alumnos:2]apellidos_y_nombres:40
					: (Table:C252(->[Personas:7])=<>vRUTTable)
						$y_nombre:=->[Personas:7]Apellidos_y_nombres:30
					Else 
						$y_nombre:=->[Personas:7]Apellidos_y_nombres:30
				End case 
				APPEND TO ARRAY:C911(aNombre;KRL_GetTextFieldData (vLinkingField;$ptr_id;$y_nombre))
			End if 
		End for 
	End if 
	
	If ($monto)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aMonto"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Monto"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"1";<>vtXS_CountryCode)
		montoTotal2Import:=AT_GetSumArray (->aMonto)
		monto2Import:=0
		noRegistros2Import:=0
		aCodAprobacion{0}:="0"
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->aCodAprobacion;"=";->$DA_Return)
		For ($r;1;Size of array:C274($DA_Return))
			monto2Import:=monto2Import+aMonto{$DA_Return{$r}}
		End for 
		noRegistros2Import:=Size of array:C274($DA_Return)
	End if 
	If ($rut)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		If (<>vLabelLink="ID")
			at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="al_idAvisoAPagar"
			at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"22";<>vtXS_CountryCode)
		Else 
			at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aRUT"
			at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"6";<>vtXS_CountryCode)
		End if 
		  //at_headers2Import{Size of array(at_headers2Import)}:="Identificador"
	End if 
	If ($descRespuesta)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aDescCodigo"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Descripción Código"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"5";<>vtXS_CountryCode)
	End if 
	If ($codAprob)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aCodAprobacion"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Código Aprobación"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"2";<>vtXS_CountryCode)
	End if 
	If ($tarjeta)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aNumTarjeta"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Número Tarjeta"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"12";<>vtXS_CountryCode)
	End if 
	If ($nombre)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aNombre"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Nombre"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"4";<>vtXS_CountryCode)
	End if 
	If ($fechaPago)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aFechaPagos"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Fecha Pago"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"7";<>vtXS_CountryCode)
	End if 
	If ($serieCheque)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aSerieCheque"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Serie Cheque"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"9";<>vtXS_CountryCode)
	End if 
	If ($fechaDctoCheque)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aFechaDctoCheque"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Fecha Cheque"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"11";<>vtXS_CountryCode)
	End if 
	If ($cuentaCheque)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aCuentaCheque"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Nº Cuenta Cheque"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"10";<>vtXS_CountryCode)
	End if 
	If ($bancoCheque)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aBancoCheque"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Cod. Banco Cheque"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"8";<>vtXS_CountryCode)
	End if 
	If ($lugarPago)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aLugarDePago"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Lugar de Pago"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"13";<>vtXS_CountryCode)
	End if 
	
	If ($noOperacion)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aNoOperacion"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Número de operación"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ACTtf_OpcionesTextosImp (2;"14";<>vtXS_CountryCode)
	End if 
	
	If ($aMontoMora)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="aMontoMora"
		  //at_headers2Import{Size of array(at_headers2Import)}:="Monto mora"
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ST_Boolean2Str ($montoOrgUF;ACTtf_OpcionesTextosImp (2;"21";<>vtXS_CountryCode);ACTtf_OpcionesTextosImp (2;"16";<>vtXS_CountryCode))
	End if 
	
	If ($fechaVcto)
		INSERT IN ARRAY:C227(at_arreglos2Import;Size of array:C274(at_arreglos2Import)+1;1)
		INSERT IN ARRAY:C227(at_headers2Import;Size of array:C274(at_headers2Import)+1;1)
		at_arreglos2Import{Size of array:C274(at_arreglos2Import)}:="ad_fechaVcto"
		$title:=ACTtf_OpcionesTextosImp (2;"17";<>vtXS_CountryCode)
		$tempStr:=ST_Lowercase (Substring:C12($title;Position:C15(" ";$title)+1))
		at_headers2Import{Size of array:C274(at_headers2Import)}:=ST_Uppercase ($tempStr[[1]])+Substring:C12($tempStr;2)
	End if 
	
	$0:=0
Else 
	$0:=1
End if 