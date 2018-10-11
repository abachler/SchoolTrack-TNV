//%attributes = {}
  //ACTpgs_CargaDatos

ACTcfg_OpcionesArraysItemsM ("InitArrays")
ACTpgs_OpcionesVR ("ACT_initArrays")
ACTpgs_DeclarationsFormasPago 

C_BOOLEAN:C305(vb_multaGenerada)  //variable que se utiliza para generar sólo 1 multa al momento de documentar deuda...
C_REAL:C285(vrACT_OtrosSaldosDisp)
vb_multaGenerada:=False:C215

cb_OcupaSaldos:=0
If (RNTercero#-1)
	$ptr_ApYNom:=->[ACT_Terceros:138]Nombre_Completo:9
	$ptr_TipoTC:=->[ACT_Terceros:138]PAT_TipoTC:35
	$ptr_CtaCBanco:=->[ACT_Terceros:138]PAC_Banco_Nombre:44
	$ptr_titularTC:=->[ACT_Terceros:138]PAT_TitularTC:56
	$ptr_rutTitularTC:=->[ACT_Terceros:138]PAT_Identificador:34
	$ptr_bancoTC:=->[ACT_Terceros:138]PAT_Banco_Emisor:39
	$ptr_numTC:=->[ACT_Terceros:138]PAT_NumTC:36
	$ptr_mesTC:=->[ACT_Terceros:138]PAT_VencMesTC:38
	$ptr_yearTC:=->[ACT_Terceros:138]PAT_VencAgnoTC:37
	$ptr_titularCta:=->[ACT_Terceros:138]PAC_TitularCta:57
	$ptr_rutTitularCta:=->[ACT_Terceros:138]PAC_Identificador:46
	$ptr_idBancoCta:=->[ACT_Terceros:138]PAC_Banco_ID:45
	$ptr_numCta:=->[ACT_Terceros:138]PAC_NumCta:47
	
	  //20131128 ASM Ticket 127351
	$ptr_TipoTD:=->[ACT_Terceros:138]RC_TipoTarjetaTD:68
	$ptr_titularTD:=->[ACT_Terceros:138]RC_TitularTD:69
	$ptr_rutTitularTD:=->[ACT_Terceros:138]RC_IdentificadorTD:64
	$ptr_bancoTD:=->[ACT_Terceros:138]RC_Banco_Emisor_TD:63
	$ptr_numTD:=->[ACT_Terceros:138]RC_NumTD:66
	$ptr_mesTD:=->[ACT_Terceros:138]RC_VencMesTD:71
	$ptr_yearTD:=->[ACT_Terceros:138]RC_VencAgnoTD:70
	
Else 
	$ptr_ApYNom:=->[Personas:7]Apellidos_y_nombres:30
	$ptr_TipoTC:=->[Personas:7]ACT_Tipo_TC:52
	$ptr_CtaCBanco:=->[Personas:7]ACT_Banco_Cta:47
	$ptr_titularTC:=->[Personas:7]ACT_Titular_TC:55
	$ptr_rutTitularTC:=->[Personas:7]ACT_RUTTitular_TC:56
	$ptr_bancoTC:=->[Personas:7]ACT_Banco_TC:53
	$ptr_numTC:=->[Personas:7]ACT_Numero_TC:54
	$ptr_mesTC:=->[Personas:7]ACT_MesVenc_TC:57
	$ptr_yearTC:=->[Personas:7]ACT_AñoVenc_TC:58
	$ptr_titularCta:=->[Personas:7]ACT_Titular_Cta:49
	$ptr_rutTitularCta:=->[Personas:7]ACT_RUTTitutal_Cta:50
	$ptr_idBancoCta:=->[Personas:7]ACT_ID_Banco_Cta:48
	$ptr_numCta:=->[Personas:7]ACT_Numero_Cta:51
	
	  //Ticket 116401
	$ptr_TipoTD:=->[Personas:7]ACT_Tipo_TD:106
	$ptr_titularTD:=->[Personas:7]ACT_Titular_TD:107
	$ptr_rutTitularTD:=->[Personas:7]ACT_RUTTitular_TD:105
	$ptr_bancoTD:=->[Personas:7]ACT_Banco_TD:101
	$ptr_numTD:=->[Personas:7]ACT_Numero_TD:104
	$ptr_mesTD:=->[Personas:7]ACT_MesVenc_TD:102
	$ptr_yearTD:=->[Personas:7]ACT_AñoVenc_TD:100
	
End if 
vtACT_NombreApoderado:=$ptr_ApYNom->
  //$tarjeta:=Find in array(<>atACT_TarjetasCredito;$ptr_TipoTC->)
  // Ticket 116401
$tarjetaCredito:=Find in array:C230(<>atACT_TarjetasCredito;$ptr_TipoTC->)
$tarjetaDebito:=Find in array:C230(<>atACT_TarjetasCredito;$ptr_TipoTD->)
$banco:=Find in array:C230(atACT_BankName;$ptr_CtaCBanco->)
  //If ($tarjeta<0)
  //<>atACT_TarjetasCredito:=0
  //vtACT_TCBancoEmisor:=""
  //vtACT_TCTipo:=""
  //vtACT_TCNumero:=""
  //vtACT_TCTitular:=$ptr_titularTC->
  //vtACT_TCRUTTitular:=$ptr_rutTitularTC->
  //vtACT_TCMesVencimiento:=""
  //vtACT_TCAgnoVencimiento:=""
  //Else 
  //<>atACT_TarjetasCredito:=$tarjeta
  //vtACT_TCBancoEmisor:=$ptr_bancoTC->
  //vtACT_TCTipo:=$ptr_tipoTC->
  //ACTpp_CRYPTTC ("onLoadPagos";->vtACT_TCNumero;$ptr_numTC)
  //vtACT_TCTitular:=$ptr_titularTC->
  //vtACT_TCRUTTitular:=$ptr_rutTitularTC->
  //vtACT_TCMesVencimiento:=$ptr_mesTC->
  //vtACT_TCAgnoVencimiento:=$ptr_yearTC->
  //End if 

If ($tarjetaCredito<0)
	<>atACT_TarjetasCredito:=0
	vtACT_TCBancoEmisor:=""
	vtACT_TCTipo:=""
	vtACT_TCNumero:=""
	vtACT_TCTitular:=$ptr_titularTC->
	vtACT_TCRUTTitular:=$ptr_rutTitularTC->
	vtACT_TCMesVencimiento:=""
	vtACT_TCAgnoVencimiento:=""
Else 
	<>atACT_TarjetasCredito:=$tarjetaCredito
	vtACT_TCBancoEmisor:=$ptr_bancoTC->
	vtACT_TCTipo:=$ptr_tipoTC->
	ACTpp_CRYPTTC ("onLoadPagos";->vtACT_TCNumero;$ptr_numTC)
	vtACT_TCTitular:=$ptr_titularTC->
	vtACT_TCRUTTitular:=$ptr_rutTitularTC->
	vtACT_TCMesVencimiento:=$ptr_mesTC->
	vtACT_TCAgnoVencimiento:=$ptr_yearTC->
End if 

If ($tarjetaDebito<0)
	<>atACT_TarjetasCredito:=0
	vtACT_TDBancoEmisor:=""
	vtACT_TDTipo:=""
	vtACT_TDNumero:=""
	vtACT_TDTitular:=$ptr_titularTD->
	vtACT_TDRUTTitular:=$ptr_rutTitularTD->
	vtACT_TDMesVencimiento:=""
	vtACT_TDAgnoVencimiento:=""
Else 
	<>atACT_TarjetasCredito:=$tarjetaDebito
	vtACT_TDBancoEmisor:=$ptr_bancoTD->
	vtACT_TDTipo:=$ptr_tipoTC->
	ACTpp_CRYPTTC ("onLoadPagos";->vtACT_TDNumero;$ptr_numTD)
	vtACT_TDTitular:=$ptr_titularTD->
	vtACT_TDRUTTitular:=$ptr_rutTitularTD->
	vtACT_TDMesVencimiento:=$ptr_mesTD->
	vtACT_TDAgnoVencimiento:=$ptr_yearTD->
End if 

If ($banco<0)
	atACT_BankName:=0
	vtACT_BancoNombre:=""
	vtACT_BancoCodigo:=""
	vtACT_BancoID:=vtACT_BancoCodigo
	vtACT_BancoCuenta:=""
	vtACT_BancoTitular:=$ptr_titularCta->
	vtACT_BancoRUTTitular:=$ptr_rutTitularCta->
	atACT_BankID:=0
Else 
	atACT_BankName:=$banco
	vtACT_BancoNombre:=$ptr_CtaCBanco->
	If (($ptr_idBancoCta->="") & ($ptr_CtaCBanco->#""))
		$id:=Find in array:C230(atACT_BankName;$ptr_CtaCBanco->)
		If ($id#-1)
			$ptr_idBancoCta->:=atACT_BankID{$id}
		Else 
			$ptr_CtaCBanco->:=""
		End if 
		SAVE RECORD:C53([Personas:7])
	End if 
	vtACT_BancoCodigo:=$ptr_idBancoCta->
	vtACT_BancoID:=vtACT_BancoCodigo
	vtACT_BancoCuenta:=$ptr_numCta->
	vtACT_BancoTitular:=$ptr_titularCta->
	vtACT_BancoRUTTitular:=$ptr_rutTitularCta->
	atACT_BankID:=$banco
	atACT_BankName:=atACT_BankID
End if 

ARRAY TEXT:C222(aCtasApdo;0)
ARRAY TEXT:C222(aCtasCurso;0)
ARRAY LONGINT:C221(alACT_IdsAlumnos;0)

Case of 
	: (RNApdo#-1)
		READ ONLY:C145([Alumnos:2])
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aCtasApdo;[Alumnos:2]curso:20;aCtasCurso;[Alumnos:2]numero:1;alACT_IdsAlumnos)
		$text:=AT_Arrays2Text (";";"\t";->aCtasApdo;->aCtasCurso)
		AT_Text2Array (->aCtasApdo;$text)
		
		vsACT_NomApellido:=[Personas:7]Apellidos_y_nombres:30
		SET QUERY DESTINATION:C396(Into variable:K19:4;$ctas)
		SET QUERY LIMIT:C395(1)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY LIMIT:C395(0)
		vbACT_EsApdoCta:=($ctas#0)
		
	: (RNCta#-1)
		$RNumCta:=Record number:C243([ACT_CuentasCorrientes:175])
		$RNumAlumno:=Record number:C243([Alumnos:2])
		READ ONLY:C145([Alumnos:2])
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aCtasApdo;[Alumnos:2]curso:20;aCtasCurso;[Alumnos:2]numero:1;alACT_IdsAlumnos)
		$text:=AT_Arrays2Text (";";"\t";->aCtasApdo;->aCtasCurso)
		AT_Text2Array (->aCtasApdo;$text)
		
		GOTO RECORD:C242([ACT_CuentasCorrientes:175];$RNumCta)
		If ($RNumAlumno#-1)
			GOTO RECORD:C242([Alumnos:2];$RNumAlumno)
		End if 
		
		vsACT_NomApellidoCta:=[Alumnos:2]apellidos_y_nombres:40
		
		vbACT_EsApdoCta:=True:C214
		
	: (RNTercero#-1)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_Terceros_Pactado:139])
		QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=[ACT_Terceros:138]Id:1)
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aCtasApdo;[Alumnos:2]curso:20;aCtasCurso;[Alumnos:2]numero:1;alACT_IdsAlumnos)
		$text:=AT_Arrays2Text (";";"\t";->aCtasApdo;->aCtasCurso)
		AT_Text2Array (->aCtasApdo;$text)
		
		vsACT_NomApellidoTer:=[ACT_Terceros:138]Nombre_Completo:9
		SET QUERY DESTINATION:C396(Into variable:K19:4;$ctas)
		SET QUERY LIMIT:C395(1)
		QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=[ACT_Terceros:138]Id:1)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY LIMIT:C395(0)
		vbACT_EsApdoCta:=($ctas#0)
		
End case 

ACTcfgmyt_OpcionesGenerales ("InicializaVars")