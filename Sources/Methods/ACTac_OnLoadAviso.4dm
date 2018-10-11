//%attributes = {}
  //ACTac_OnLoadAviso

If (IT_AltKeyIsDown )
	C_LONGINT:C283($vl_recNum)
	ARRAY LONGINT:C221($alACTac_idsAvisos;0)
	$vl_recNum:=Record number:C243([ACT_Avisos_de_Cobranza:124])
	APPEND TO ARRAY:C911($alACTac_idsAvisos;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	ACTcar_ValidaMontos ("ValidaDesdeIdsAvisos";->$alACTac_idsAvisos)
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$vl_recNum)
End if 

ARRAY LONGINT:C221(alACT_RecNumsAvisos;0)
C_TEXT:C284(vt_labelIdentificador;valorIdentificador)
ACTac_RecalculaAvisos ("CapturaVars";->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26)
vt_labelIdentificador:=""
valorIdentificador:=""
vApellidosyNombresT:=""
vtSTR_RUT:=""
vtSTR_Pasaporte:=""
vtSTR_IDNacional2:=""
vtSTR_IDNacional3:=""
vtSTR_CodigoInterno:=""
OBJECT SET VISIBLE:C603(*;"labelTercero@";False:C215)
OBJECT SET VISIBLE:C603(*;"Text6";True:C214)

If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=0)
	READ ONLY:C145([Personas:7])
	QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	vApellidosyNombres:=[Personas:7]Apellidos_y_nombres:30
	vRUT:=[Personas:7]RUT:6
	vPasaporte:=[Personas:7]Pasaporte:59
	vIdent2:=[Personas:7]IDNacional_2:37
	vIdent3:=[Personas:7]IDNacional_3:38
	$nacionalidad:=[Personas:7]Nacionalidad:7
	If ([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#0)
		OBJECT SET VISIBLE:C603(*;"labelAlumno";False:C215)
		OBJECT SET VISIBLE:C603(*;"labelApdo";True:C214)
		OBJECT SET VISIBLE:C603(*;"Codigo@";False:C215)
		PP_SetIdentificadorPrincipal 
	Else 
		OBJECT SET VISIBLE:C603(*;"labelAlumno";False:C215)
		OBJECT SET VISIBLE:C603(*;"labelApdo";False:C215)
		OBJECT SET VISIBLE:C603(*;"Codigo@";False:C215)
		OBJECT SET VISIBLE:C603(*;"Text6";False:C215)
		OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
		OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
		OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
		OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
	End if 
Else 
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	vApellidosyNombres:=[Alumnos:2]apellidos_y_nombres:40
	vRUT:=[Alumnos:2]RUT:5
	vPasaporte:=[Alumnos:2]NoPasaporte:87
	vIdent2:=[Alumnos:2]IDNacional_2:71
	vIdent3:=[Alumnos:2]IDNacional_3:70
	vCodigo:=[ACT_CuentasCorrientes:175]Codigo:19
	$nacionalidad:=[Alumnos:2]Nacionalidad:8
	OBJECT SET VISIBLE:C603(*;"labelAlumno";True:C214)
	OBJECT SET VISIBLE:C603(*;"labelApdo";False:C215)
	OBJECT SET VISIBLE:C603(*;"Codigo@";True:C214)
	AL_SetIdentificadorPrincipal 
End if 

  //If ([ACT_Avisos_de_Cobranza]ID_Tercero#0)
If (([ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0) | ([ACT_Avisos_de_Cobranza:124]ID_Responsable:33#0))
	If ([ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0)
		READ ONLY:C145([ACT_Terceros:138])
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26)
		vApellidosyNombresT:=[ACT_Terceros:138]Nombre_Completo:9
		vtSTR_RUT:=[ACT_Terceros:138]RUT:4
		vtSTR_Pasaporte:=[ACT_Terceros:138]Pasaporte:25
		vtSTR_IDNacional2:=[ACT_Terceros:138]Identificador_Nacional2:20
		vtSTR_IDNacional3:=[ACT_Terceros:138]Identificador_Nacional3:21
		vtSTR_CodigoInterno:=[ACT_Terceros:138]Codigo_Interno:29
		$nacionalidad:=[ACT_Terceros:138]Nacionalidad:27
		ACTter_SetIdentificador (->vt_labelIdentificador;->valorIdentificador)
		OBJECT SET TITLE:C194(*;"labelTercero";__ ("Tercero"))
	Else 
		READ ONLY:C145([Personas:7])
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Responsable:33)
		vApellidosyNombresT:=[Personas:7]Apellidos_y_nombres:30
		vt_labelIdentificador:=<>vt_IDNacional1_name
		valorIdentificador:=[Personas:7]RUT:6
		
		OBJECT SET TITLE:C194(*;"labelTercero";__ ("Responsable"))
	End if 
	OBJECT SET VISIBLE:C603(*;"labelTercero@";True:C214)
	If ((vt_labelIdentificador="RUT") & (Num:C11(Substring:C12(valorIdentificador;1;Length:C16(valorIdentificador)-1))>0))
		OBJECT SET FORMAT:C236(valorIdentificador;"###.###.###-#")
	End if 
End if 

  //opciones según pais
Case of 
	: (<>vtXS_CountryCode="cl")
		If ((vRUT="") & ($nacionalidad#"Chilen@"))
			OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDd@";True:C214)
		End if 
		If (Num:C11(Substring:C12(vRUT;1;Length:C16(vRUT)-1))>0)
			OBJECT SET FORMAT:C236(vRUT;"###.###.###-#")
		Else 
			OBJECT SET FORMAT:C236(vRUT;"")
		End if 
End case 

If (Record number:C243([ACT_Avisos_de_Cobranza:124])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo Aviso de Cobranza"))
Else 
	If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=0)
		SET WINDOW TITLE:C213(__ ("Aviso de Cobranza N° ")+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+": "+[Personas:7]Apellidos_y_nombres:30)
	Else 
		SET WINDOW TITLE:C213(__ ("Aviso de Cobranza N° ")+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+": "+[Alumnos:2]apellidos_y_nombres:40)
	End if 
End if 
$idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
AL_UpdateArrays (ALP_CargosXPagar;0)
$vb_cargoEnUF:=ACTac_OpcionesGenerales ("SoloCargosEnMonedaPais";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
If (Not:C34((ST_GetWord (ACT_DivisaPais ;1;";")=<>vsACT_MonedaColegio) & (<>vsACT_MonedaColegio=[ACT_Avisos_de_Cobranza:124]Moneda:17)) | Not:C34($vb_cargoEnUF))
	If (cb_IncluirSaldosAnteriores=1)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos;"")
		ACTmnu_RecalcularSaldosAvisos (->alACT_RecNumsAvisos;Current date:C33(*);True:C214)
	Else 
		ACTac_Recalcular (Record number:C243([ACT_Avisos_de_Cobranza:124]);Current date:C33(*);True:C214)
	End if 
	KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$idAviso;True:C214)
End if 
If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])#0)
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	vPagado:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
	If (vPagado=0)
		vPagado:=Round:C94(Sum:C1([ACT_Cargos:173]MontosPagados:8);4)
	End if 
	ACTcc_LoadCargosIntoArrays 
	
	AL_UpdateArrays (ALP_CargosXPagar;-2)
	vSaldo:=[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12*-1
	If (ST_GetWord (ACT_DivisaPais ;1;";")=<>vsACT_MonedaColegio) & ([ACT_Avisos_de_Cobranza:124]Moneda:17=<>vsACT_MonedaColegio)
		IT_SetFormat ("|Despliegue_ACT_Pagos";->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11;->[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12;->[ACT_Avisos_de_Cobranza:124]Intereses:13;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14)
	End if 
	AL_SetLine (ALP_CargosXPagar;0)
	_O_DISABLE BUTTON:C193(bDelCargos)
Else 
	BWR_AfterDeleteOnLoading 
End if 
AT_Initialize (->alACT_RecNumsAvisos)