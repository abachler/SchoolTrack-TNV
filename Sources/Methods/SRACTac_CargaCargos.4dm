//%attributes = {}
  //SRACTac_CargaCargos

C_LONGINT:C283($1;$aviso)
C_POINTER:C301($varPtr;$arrPtr1;$arrPtr2;$arrPtr3;$arrPtr4;$arrPtr5;$arrPtr6;$arrPtr7;$arrPtr8)

ARRAY TEXT:C222(aMeses;12)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)

$aviso:=1

If (Count parameters:C259=1)
	$aviso:=$1
End if 

$recNum:=Record number:C243([ACT_Avisos_de_Cobranza:124])

SRACTac_EndAviso ($aviso)

SRACTacmx_LoadVarsPagosRef ("CargaVars";->$aviso)

$varPtr:=Get pointer:C304("vlACT_SRac_IDAviso"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
$varPtr:=Get pointer:C304("vlACT_SRac_MesNum"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Mes:6
$varPtr:=Get pointer:C304("vtACT_SRac_MesText"+String:C10($aviso))
$varPtr->:=aMeses{[ACT_Avisos_de_Cobranza:124]Mes:6}
$varPtr:=Get pointer:C304("vlACT_SRac_AñoAviso"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Agno:7
$varPtr:=Get pointer:C304("vdACT_SRac_FechaAviso"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4
$varPtr:=Get pointer:C304("vdACT_SRac_FechaVencimiento"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
$varPtr:=Get pointer:C304("vdACT_SRac_2FechaPago"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18
$varPtr:=Get pointer:C304("vdACT_SRac_3FechaPago"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Fecha_Pago3:19
$varPtr:=Get pointer:C304("vdACT_SRac_4FechaPago"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Fecha_Pago4:20
$varPtr:=Get pointer:C304("vtACT_SRac_Observaciones"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Observaciones:15
$varPtr:=Get pointer:C304("vrACT_SRac_SaldoAnterior"+String:C10($aviso))
$varPtr->:=Abs:C99([ACT_Avisos_de_Cobranza:124]Saldo_anterior:12)
$varPtr:=Get pointer:C304("vrACT_SRac_InteresesAnteriores"+String:C10($aviso))
$varPtr->:=Abs:C99([ACT_Avisos_de_Cobranza:124]Intereses_Anteriores:21)
$varPtr:=Get pointer:C304("vrACT_SRac_CargosAnteriores"+String:C10($aviso))
$varPtr->:=Abs:C99([ACT_Avisos_de_Cobranza:124]Cargos_Anteriores:22)
$varPtr:=Get pointer:C304("vrACT_SRac_Total"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11+[ACT_Avisos_de_Cobranza:124]Intereses:13
$varPtr:=Get pointer:C304("vrACT_SRac_MontoAPagar"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14
$varPtr:=Get pointer:C304("vtACT_SRac_TotalText"+String:C10($aviso))
$varPtr->:=ST_Num2Text2 ([ACT_Avisos_de_Cobranza:124]Monto_Neto:11+[ACT_Avisos_de_Cobranza:124]Intereses:13;"Spanish")
$varPtr:=Get pointer:C304("vtACT_SRac_MontoAPagarText"+String:C10($aviso))
$varPtr->:=ST_Num2Text2 ([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;"Spanish")
$varPtr:=Get pointer:C304("vrACT_SRac_MontoNeto"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11
$varPtr:=Get pointer:C304("vrACT_SRac_Intereses"+String:C10($aviso))
$varPtr->:=[ACT_Avisos_de_Cobranza:124]Intereses:13
$varPtr:=Get pointer:C304("vrACT_SRac_MontoPagado"+String:C10($aviso))
QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
$varPtr->:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
If ($varPtr->=0)
	$varPtr->:=Sum:C1([ACT_Cargos:173]MontosPagados:8)
End if 
GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$recNum)

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([ACT_Transacciones:178])
QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
$varPtr:=Get pointer:C304("vtACT_SRac_ApdoNombre"+String:C10($aviso))
$varPtr->:=[Personas:7]Apellidos_y_nombres:30
$varPtr:=Get pointer:C304("vtACT_SRac_IDNacApdo"+String:C10($aviso))
$varPtr->:=[Personas:7]RUT:6
  // 20120503 AS. se cargan indentificadores 2 y 3.
$varPtr:=Get pointer:C304("vtACT_SRac_IDNac2Apdo"+String:C10($aviso))
$varPtr->:=[Personas:7]IDNacional_2:37
$varPtr:=Get pointer:C304("vtACT_SRac_IDNac3Apdo"+String:C10($aviso))
$varPtr->:=[Personas:7]IDNacional_3:38
$varPtr:=Get pointer:C304("vtACT_SRac_DirEC"+String:C10($aviso))
If ([Personas:7]ACT_CodPostalEC:70#"")
	$varPtr->:=[Personas:7]ACT_DireccionEC:67+"\r"+[Personas:7]ACT_CodPostalEC:70+" "+[Personas:7]ACT_ComunaEC:68
Else 
	$varPtr->:=[Personas:7]ACT_DireccionEC:67+"\r"+[Personas:7]ACT_ComunaEC:68
End if 
$varPtr:=Get pointer:C304("vtACT_SRac_DirPersonal"+String:C10($aviso))
If ([Personas:7]Codigo_postal:15#"")
	$varPtr->:=[Personas:7]Direccion:14+"\r"+[Personas:7]Codigo_postal:15+" "+[Personas:7]Comuna:16
Else 
	$varPtr->:=[Personas:7]Direccion:14+"\r"+[Personas:7]Comuna:16
End if 
$varPtr:=Get pointer:C304("vtACT_SRac_DirProfesional"+String:C10($aviso))
$varPtr->:=[Personas:7]Direccion_Profesional:23
$varPtr:=Get pointer:C304("vtACT_SRac_ComunaEC"+String:C10($aviso))
$varPtr->:=[Personas:7]ACT_ComunaEC:68
$varPtr:=Get pointer:C304("vtACT_SRac_CiudadEC"+String:C10($aviso))
$varPtr->:=[Personas:7]ACT_CiudadEC:69
$varPtr:=Get pointer:C304("vtACT_SRac_CodPostalEC"+String:C10($aviso))
$varPtr->:=[Personas:7]ACT_CodPostalEC:70
$varPtr:=Get pointer:C304("vtACT_SRac_EmailPersonal"+String:C10($aviso))
$varPtr->:=[Personas:7]eMail:34
QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
KRL_RelateSelection (->[Familia:78]Numero:1;->[ACT_CuentasCorrientes:175]ID_Familia:2;"")
ARRAY TEXT:C222(atACT_CodigoFamilia;0)
ARRAY TEXT:C222(atACT_Familia;0)
SELECTION TO ARRAY:C260([Familia:78]Codigo_interno:14;atACT_CodigoFamilia;[Familia:78]Nombre_de_la_familia:3;atACT_Familia)
$varPtr:=Get pointer:C304("vtACT_SRac_CodigoFamilias"+String:C10($aviso))
$varPtr->:=AT_array2text (->atACT_CodigoFamilia;" - ")
$varPtr:=Get pointer:C304("vtACT_SRac_NombreFamilias"+String:C10($aviso))
$varPtr->:=AT_array2text (->atACT_Familia;" - ")
AT_Initialize (->atACT_CodigoFamilia;->atACT_Familia)
$varPtr:=Get pointer:C304("vtACT_SRac_MododePago"+String:C10($aviso))
  //20121005 RCH
  //$varPtr->:=[Personas]ACT_Modo_de_pago
$varPtr->:=[Personas:7]ACT_modo_de_pago_new:95
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
$varPtr:=Get pointer:C304("vrACT_SRac_SaldoApdo"+String:C10($aviso))
$varPtr->:=Sum:C1([ACT_Pagos:172]Saldo:15)

If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	$varPtr:=Get pointer:C304("vtACT_SRac_NombreCta"+String:C10($aviso))
	$varPtr->:=[Alumnos:2]apellidos_y_nombres:40
	$varPtr:=Get pointer:C304("vtACT_SRac_IDNacCta"+String:C10($aviso))
	$varPtr->:=[Alumnos:2]RUT:5
	$varPtr:=Get pointer:C304("vtACT_SRac_CursoCta"+String:C10($aviso))
	$varPtr->:=[Alumnos:2]curso:20
	$varPtr:=Get pointer:C304("vtACT_SRac_NivelCta"+String:C10($aviso))
	$varPtr->:=[Alumnos:2]Nivel_Nombre:34
	$varPtr:=Get pointer:C304("vtACT_SRac_CodigoCta"+String:C10($aviso))
	$varPtr->:=[ACT_CuentasCorrientes:175]Codigo:19
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_CtaCte:21=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
	$varPtr:=Get pointer:C304("vrACT_SRac_SaldoCta"+String:C10($aviso))
	$varPtr->:=Sum:C1([ACT_Pagos:172]Saldo:15)
Else 
	  //' mismas variables pero para alumno mayor incidente 60680
	KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo")
	If (Records in selection:C76([Alumnos:2])>0)
		ARRAY LONGINT:C221($al_rnAlumnos;0)
		ARRAY LONGINT:C221($al_numeroNivelAlu;0)
		C_LONGINT:C283($maximo)
		SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnos;[Alumnos:2]nivel_numero:29;$al_numeroNivelAlu)
		SORT ARRAY:C229($al_numeroNivelAlu;$al_rnAlumnos;<)
		GOTO RECORD:C242([Alumnos:2];$al_rnAlumnos{1})
		$varPtr:=Get pointer:C304("vtACT_SRac_NombreCta"+String:C10($aviso))
		$varPtr->:=[Alumnos:2]apellidos_y_nombres:40
		$varPtr:=Get pointer:C304("vtACT_SRac_IDNacCta"+String:C10($aviso))
		$varPtr->:=[Alumnos:2]RUT:5
		$varPtr:=Get pointer:C304("vtACT_SRac_CursoCta"+String:C10($aviso))
		$varPtr->:=[Alumnos:2]curso:20
		$varPtr:=Get pointer:C304("vtACT_SRac_NivelCta"+String:C10($aviso))
		$varPtr->:=[Alumnos:2]Nivel_Nombre:34
		$varPtr:=Get pointer:C304("vtACT_SRac_CodigoCta"+String:C10($aviso))
		$varPtr->:=[ACT_CuentasCorrientes:175]Codigo:19
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_CtaCte:21=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
		$varPtr:=Get pointer:C304("vrACT_SRac_SaldoCta"+String:C10($aviso))
		$varPtr->:=Sum:C1([ACT_Pagos:172]Saldo:15)
	End if 
End if 

KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
FIRST RECORD:C50([ACT_Boletas:181])
If (Records in selection:C76([ACT_Boletas:181])>0)
	If (Records in selection:C76([ACT_Boletas:181])=1)
		$varPtr:=Get pointer:C304("vtACT_SRac_IDDT"+String:C10($aviso))
		$varPtr->:=String:C10([ACT_Boletas:181]Numero:11)
		$varPtr:=Get pointer:C304("vtACT_SRac_EstadoDT"+String:C10($aviso))
		$varPtr->:=[ACT_Boletas:181]Estado:2
		$varPtr:=Get pointer:C304("vtACT_SRac_FechaEmisionDT"+String:C10($aviso))
		$varPtr->:=String:C10([ACT_Boletas:181]FechaEmision:3;7)
		$varPtr:=Get pointer:C304("vtACT_SRac_EmitidoPor"+String:C10($aviso))
		$varPtr->:=[ACT_Boletas:181]EmitidoPor:17
		$varPtr:=Get pointer:C304("vtACT_SRac_TotalDT"+String:C10($aviso))
		$varPtr->:=String:C10([ACT_Boletas:181]Monto_Total:6;"|Despliegue_ACT")
		$varPtr:=Get pointer:C304("vtACT_SRac_Afecto"+String:C10($aviso))
		$varPtr->:=String:C10([ACT_Boletas:181]Monto_Afecto:4;"|Despliegue_ACT")
		$varPtr:=Get pointer:C304("vtACT_SRac_IVA"+String:C10($aviso))
		$varPtr->:=String:C10([ACT_Boletas:181]Monto_IVA:5;"|Despliegue_ACT")
		$varPtr:=Get pointer:C304("vtACT_SRac_TotalTextDT"+String:C10($aviso))
		$varPtr->:=ST_Num2Text2 ([ACT_Boletas:181]Monto_Total:6;"Spanish")
	Else 
		ARRAY LONGINT:C221($al_idsDT;0)
		ARRAY LONGINT:C221($al_numerosDT;0)
		ARRAY TEXT:C222($at_numerosDT;0)
		ARRAY TEXT:C222($at_statusDT;0)
		ARRAY DATE:C224($ad_fEmisionDT;0)
		ARRAY TEXT:C222($at_emitidoPorDT;0)
		ARRAY REAL:C219($ar_montoTotalDT;0)
		ARRAY TEXT:C222($at_montoTotalDT;0)
		ARRAY REAL:C219($ar_montoAfecto;0)
		ARRAY TEXT:C222($at_montoAfecto;0)
		ARRAY REAL:C219($ar_montoIva;0)
		ARRAY TEXT:C222($at_montoIva;0)
		ARRAY TEXT:C222($at_fechasDT;0)
		DISTINCT VALUES:C339([ACT_Boletas:181]ID:1;$al_idsDT)
		QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;$al_idsDT)
		SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;$al_numerosDT;[ACT_Boletas:181]Estado:2;$at_statusDT;[ACT_Boletas:181]FechaEmision:3;$ad_fEmisionDT)
		SELECTION TO ARRAY:C260([ACT_Boletas:181]EmitidoPor:17;$at_emitidoPorDT;[ACT_Boletas:181]Monto_Total:6;$ar_montoTotalDT;[ACT_Boletas:181]Monto_Afecto:4;$ar_montoAfecto;[ACT_Boletas:181]Monto_IVA:5;$ar_montoIva)
		For ($i;1;Size of array:C274($al_numerosDT))
			AT_Insert (0;1;->$at_numerosDT)
			$at_numerosDT{Size of array:C274($at_numerosDT)}:=String:C10($al_numerosDT{$i})
		End for 
		For ($i;1;Size of array:C274($ar_montoTotalDT))
			AT_Insert (0;1;->$at_montoTotalDT)
			$at_montoTotalDT{Size of array:C274($at_montoTotalDT)}:=String:C10($ar_montoTotalDT{$i};"|Despliegue_ACT")
		End for 
		For ($i;1;Size of array:C274($ar_montoAfecto))
			AT_Insert (0;1;->$at_montoAfecto)
			$at_montoAfecto{Size of array:C274($at_montoAfecto)}:=String:C10($ar_montoAfecto{$i};"|Despliegue_ACT")
		End for 
		For ($i;1;Size of array:C274($ar_montoIva))
			AT_Insert (0;1;->$at_montoIva)
			$at_montoIva{Size of array:C274($at_montoIva)}:=String:C10($ar_montoIva{$i};"|Despliegue_ACT")
		End for 
		For ($i;1;Size of array:C274($ad_fEmisionDT))
			AT_Insert (0;1;->$at_fechasDT)
			$at_fechasDT{Size of array:C274($at_fechasDT)}:=String:C10($ad_fEmisionDT{$i})
		End for 
		$varPtr:=Get pointer:C304("vtACT_SRac_IDDT"+String:C10($aviso))
		$varPtr->:=AT_array2text (->$at_numerosDT;" - ")
		$varPtr:=Get pointer:C304("vtACT_SRac_EstadoDT"+String:C10($aviso))
		$varPtr->:=AT_array2text (->$at_statusDT;" - ")
		$varPtr:=Get pointer:C304("vtACT_SRac_FechaEmisionDT"+String:C10($aviso))
		$varPtr->:=AT_array2text (->$at_fechasDT;" - ")
		$varPtr:=Get pointer:C304("vtACT_SRac_EmitidoPor"+String:C10($aviso))
		$varPtr->:=AT_array2text (->$at_emitidoPorDT;" - ")
		$varPtr:=Get pointer:C304("vtACT_SRac_TotalDT"+String:C10($aviso))
		$varPtr->:=AT_array2text (->$at_montoTotalDT;" - ")
		$varPtr:=Get pointer:C304("vtACT_SRac_Afecto"+String:C10($aviso))
		$varPtr->:=AT_array2text (->$at_montoAfecto;" - ")
		$varPtr:=Get pointer:C304("vtACT_SRac_IVA"+String:C10($aviso))
		$varPtr->:=AT_array2text (->$at_montoIva;" - ")
	End if 
End if 

ACTav_FormArrayDeclarations 
QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")

If (cb_SepararCargosXPct=1)
	COPY NAMED SELECTION:C331([ACT_Cargos:173];"$setCargos1")
	ARRAY LONGINT:C221($al_idsApdos;0)
	ACTcc_DividirEmision ("ObtieneIdsResponsablesDesdeCargo";->$al_idsApdos)
	QUERY WITH ARRAY:C644([Personas:7]No:1;$al_idsApdos)
	Case of 
		: ($aviso=1)
			SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;atACT_SRac_RespNombre1;[Personas:7]RUT:6;atACT_SRac_IDNacResp1;[Personas:7]IDNacional_2:37;atACT_SRac_IDNac2Resp1;[Personas:7]IDNacional_3:38;atACT_SRac_IDNac3Resp1;[Personas:7]ACT_ComunaEC:68;atACT_SRac_ComunaECResp1;[Personas:7]ACT_CiudadEC:69;atACT_SRac_CiudadECResp1;[Personas:7]ACT_CodPostalEC:70;atACT_SRac_CodPostalECResp1;[Personas:7]ACT_DireccionEC:67;atACT_SRac_DirECResp1;[Personas:7]Direccion:14;atACT_SRac_DirPersonalResp1;[Personas:7]Direccion_Profesional:23;atACT_SRac_DirProfesionalResp1;[Personas:7]eMail:34;atACT_SRac_EmailPersonalResp1)
		: ($aviso=2)
			SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;atACT_SRac_RespNombre2;[Personas:7]RUT:6;atACT_SRac_IDNacResp2;[Personas:7]IDNacional_2:37;atACT_SRac_IDNac2Resp2;[Personas:7]IDNacional_3:38;atACT_SRac_IDNac3Resp2;[Personas:7]ACT_ComunaEC:68;atACT_SRac_ComunaECResp2;[Personas:7]ACT_CiudadEC:69;atACT_SRac_CiudadECResp2;[Personas:7]ACT_CodPostalEC:70;atACT_SRac_CodPostalECResp2;[Personas:7]ACT_DireccionEC:67;atACT_SRac_DirECResp2;[Personas:7]Direccion:14;atACT_SRac_DirPersonalResp2;[Personas:7]Direccion_Profesional:23;atACT_SRac_DirProfesionalResp2;[Personas:7]eMail:34;atACT_SRac_EmailPersonalResp2)
		: ($aviso=3)
			SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;atACT_SRac_RespNombre3;[Personas:7]RUT:6;atACT_SRac_IDNacResp3;[Personas:7]IDNacional_2:37;atACT_SRac_IDNac2Resp3;[Personas:7]IDNacional_3:38;atACT_SRac_IDNac3Resp3;[Personas:7]ACT_ComunaEC:68;atACT_SRac_ComunaECResp3;[Personas:7]ACT_CiudadEC:69;atACT_SRac_CiudadECResp3;[Personas:7]ACT_CodPostalEC:70;atACT_SRac_CodPostalECResp3;[Personas:7]ACT_DireccionEC:67;atACT_SRac_DirECResp3;[Personas:7]Direccion:14;atACT_SRac_DirPersonalResp3;[Personas:7]Direccion_Profesional:23;atACT_SRac_DirProfesionalResp3;[Personas:7]eMail:34;atACT_SRac_EmailPersonalResp3)
		: ($aviso=4)
			SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;atACT_SRac_RespNombre4;[Personas:7]RUT:6;atACT_SRac_IDNacResp4;[Personas:7]IDNacional_2:37;atACT_SRac_IDNac2Resp4;[Personas:7]IDNacional_3:38;atACT_SRac_IDNac3Resp4;[Personas:7]ACT_ComunaEC:68;atACT_SRac_ComunaECResp4;[Personas:7]ACT_CiudadEC:69;atACT_SRac_CiudadECResp4;[Personas:7]ACT_CodPostalEC:70;atACT_SRac_CodPostalECResp4;[Personas:7]ACT_DireccionEC:67;atACT_SRac_DirECResp4;[Personas:7]Direccion:14;atACT_SRac_DirPersonalResp4;[Personas:7]Direccion_Profesional:23;atACT_SRac_DirProfesionalResp4;[Personas:7]eMail:34;atACT_SRac_EmailPersonalResp4)
	End case 
	USE NAMED SELECTION:C332("$setCargos1")
	CLEAR NAMED SELECTION:C333("$setCargos1")
End if 

$varPtr1:=Get pointer:C304("vrACT_SRac_MontoExento"+String:C10($aviso))
$varPtr2:=Get pointer:C304("vrACT_SRac_MontoAfecto"+String:C10($aviso))
$varPtr3:=Get pointer:C304("vrACT_SRac_Tot2Fecha"+String:C10($aviso))
$varPtr4:=Get pointer:C304("vrACT_SRac_Tot3Fecha"+String:C10($aviso))
$varPtr5:=Get pointer:C304("vrACT_SRac_Tot4Fecha"+String:C10($aviso))
$varPtr6:=Get pointer:C304("vrACT_SRac_MontoIVA"+String:C10($aviso))
ACTcc_LoadCargosIntoArrays (True:C214;$varPtr2;$varPtr1;$varPtr3;$varPtr4;$varPtr5;$varPtr6)
$varPtr3->:=$varPtr3->+Abs:C99([ACT_Avisos_de_Cobranza:124]Saldo_anterior:12)
$varPtr4->:=$varPtr4->+Abs:C99([ACT_Avisos_de_Cobranza:124]Saldo_anterior:12)
$varPtr5->:=$varPtr5->+Abs:C99([ACT_Avisos_de_Cobranza:124]Saldo_anterior:12)

ACTcfg_LoadConfigData (1)
  //20130626 RCH NF CANTIDAD
ARRAY LONGINT:C221(alACT_Cantidad;Size of array:C274(arACT_CMontoNeto))  //RCH
ARRAY REAL:C219(arACT_Cantidad;Size of array:C274(arACT_CMontoNeto))  //RCH
ARRAY REAL:C219(arACT_Unitario;Size of array:C274(arACT_CMontoNeto))  //RCH
For ($i;1;Size of array:C274(arACT_CMontoNeto))  //por si no agrupan pero ocupan estos datos`RCH
	arACT_Cantidad{$i}:=1  //RCH
	arACT_Unitario{$i}:=arACT_MontoPagado{$i}  //RCH
End for   //RCH

If (vlSR_RegXPagina>1)  //si queremos imprimir mas de un aviso por pagina necesariamente debemos usar categorias...
	cb_UsarCategorias:=1
End if 
If (cb_UsarCategorias=1)
	ACTac_AgruparXCategoria (String:C10($aviso))
End if 
ACTpgs_LoadInteresRecord 
If ([xxACT_Items:179]AgruparInteresesAC:33)
	ACTac_AgruparIntereses 
End if 
If (cbAgrupar=1)
	ACTac_AgrupaCargos 
	vb_HideColsCtas:=True:C214
Else 
	  //20121019 RCH nueva opcion para agrupar
	If (cbAgruparXAlumnoItem=1)
		ACTac_AgrupaPorAlumnoItem 
	End if 
End if 
If (cb_UsarCategorias=1)
	ARRAY TEXT:C222(atACT_GlosaImpTemp;0)
	ARRAY REAL:C219(arACT_MontosTemp;0)
	$nombresCat:=AT_array2text (->atACT_NombreCategoria;";")
	$glosas:=AT_array2text (->atACT_CGlosaImpresion;";")
	AT_AppendItems2TextArray (->atACT_GlosaImpTemp;$nombresCat)
	$arrPtrMonto:=Get pointer:C304("arACT_MontoCategoria"+String:C10($aviso))
	  //ARRAY LONGINT(arACT_CantidadTemp;0)  //RCH
	ARRAY REAL:C219(arACT_CantidadTemp;0)  //20130730 RCH
	For ($i;1;Size of array:C274($arrPtrMonto->))
		AT_Insert (0;1;->arACT_MontosTemp)
		arACT_MontosTemp{Size of array:C274(arACT_MontosTemp)}:=$arrPtrMonto->{$i}
		AT_Insert (0;1;->arACT_CantidadTemp)  //RCH
		arACT_CantidadTemp{Size of array:C274(arACT_CantidadTemp)}:=arACT_CIDCtaCteTemp2{$i}  //RCH
	End for 
	AT_AppendItems2TextArray (->atACT_GlosaImpTemp;$glosas)
	For ($i;1;Size of array:C274(arACT_CMontoNeto))
		AT_Insert (0;1;->arACT_MontosTemp)
		arACT_MontosTemp{Size of array:C274(arACT_MontosTemp)}:=arACT_CMontoNeto{$i}
		AT_Insert (0;1;->arACT_CantidadTemp)  //RCH
		arACT_CantidadTemp{Size of array:C274(arACT_CantidadTemp)}:=arACT_Cantidad{$i}  //RCH
	End for 
	AT_Insert (1;ST_CountWords ($nombresCat;0;";");->atACT_CAlumno;->asACT_Afecto)
	COPY ARRAY:C226(atACT_GlosaImpTemp;atACT_CGlosaImpresion)
	COPY ARRAY:C226(arACT_MontosTemp;arACT_CMontoNeto)
	COPY ARRAY:C226(arACT_CantidadTemp;arACT_Cantidad)  //RCH
	ARRAY TEXT:C222(atACT_GlosaImpTemp;0)
	ARRAY REAL:C219(arACT_MontosTemp;0)
End if 
If (cb_ImprimirCerosAviso=0)
	arACT_CMontoNeto{0}:=0
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->arACT_CMontoNeto;"=";->$DA_Return)
	For ($u;Size of array:C274($DA_Return);1;-1)
		AT_Delete ($DA_Return{$u};1;->atACT_CGlosaImpresion;->arACT_CMontoNeto;->atACT_CAlumno;->asACT_Afecto;->arACT_Cantidad;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_MonedaSimbolo)
	End for 
End if 
$arrPtr1:=Get pointer:C304("atACT_CGlosaImpresion"+String:C10($aviso))
$arrPtr2:=Get pointer:C304("arACT_CMontoNeto"+String:C10($aviso))
$arrPtr3:=Get pointer:C304("atACT_CAlumno"+String:C10($aviso))
$arrPtr4:=Get pointer:C304("asACT_Afecto"+String:C10($aviso))
$arrPtr5:=Get pointer:C304("atACT_CAlumnoCurso"+String:C10($aviso))
$arrPtr6:=Get pointer:C304("atACT_CAlumnoNivelNombre"+String:C10($aviso))
$arrPtr7:=Get pointer:C304("arACT_Cantidad"+String:C10($aviso))  //RCH
$arrPtr8:=Get pointer:C304("atACT_MonedaSimbolo"+String:C10($aviso))
COPY ARRAY:C226(atACT_CGlosaImpresion;$arrPtr1->)
COPY ARRAY:C226(arACT_CMontoNeto;$arrPtr2->)
COPY ARRAY:C226(atACT_CAlumno;$arrPtr3->)
COPY ARRAY:C226(asACT_Afecto;$arrPtr4->)
COPY ARRAY:C226(atACT_CAlumnoCurso;$arrPtr5->)
COPY ARRAY:C226(atACT_CAlumnoNivelNombre;$arrPtr6->)
COPY ARRAY:C226(arACT_Cantidad;$arrPtr7->)
COPY ARRAY:C226(atACT_MonedaSimbolo;$arrPtr8->)

vEtiquetaColGlosa:="Glosa"
vEtiquetaColCta:="Cuenta Corriente"
vEtiquetaColCurso:="Curso"
vEtiquetaColNivel:="Nivel"
vEtiquetaColMonto:="Monto"
vEtiquetaColAfecto:="Afecto a IVA"