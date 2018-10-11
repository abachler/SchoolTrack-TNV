//%attributes = {}
  //SRACTbol_CargaCargos
C_LONGINT:C283($1;$bol)
C_POINTER:C301($varPtr;$varPtrTemp1;$varPtrTemp2)
C_POINTER:C301($var1;$var2;$var3;$var4;$var5;$var6;$var7;$var8;$var9;$var10;$var11;$var12;$var13;$var14)
C_REAL:C285($valorUf;$vr_TotalPagado)

C_LONGINT:C283($vl_lineas)
$vl_lineas:=Num:C11(ACTcfg_OpcionesLineasDT ("ObtieneNumLineas"))

$bol:=1
If (Count parameters:C259=1)
	$bol:=$1
End if 
If (Undefined:C82(vbACT_EmisionMasivaBoletas))
	vbACT_EmisionMasivaBoletas:=False:C215
End if 

COPY ARRAY:C226(<>atXS_MonthNames;<>atXS_MonthNamesText)

SRACTbol_EndBoleta ($bol)

$valorUf:=ACTut_fValorUF ([ACT_Boletas:181]FechaEmision:3)

$idBoleta:=[ACT_Boletas:181]ID:1
SRACTbol_CargaDatosTercero ("LlenaVars";->[ACT_Boletas:181]ID_Tercero:21;->$bol)
  //20130210 RCH
$varPtr:=Get pointer:C304("vlACT_SRbol_ID"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]ID:1
$varPtr:=Get pointer:C304("vlACT_SRbol_IDDT"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]Numero:11
$varPtr:=Get pointer:C304("vtACT_SRbol_TipoDT"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]TipoDocumento:7
$varPtr:=Get pointer:C304("vtACT_SRbol_EstadoDT"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]Estado:2
$varPtr:=Get pointer:C304("vdACT_SRbol_FechaEmision"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]FechaEmision:3
$varPtr:=Get pointer:C304("vlACT_SRbol_FechaDia"+String:C10($bol))
$varPtr->:=Day of:C23([ACT_Boletas:181]FechaEmision:3)
$varPtr:=Get pointer:C304("vtACT_SRbol_EmitidoPor"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]EmitidoPor:17
$varPtr:=Get pointer:C304("vlACT_SRbol_FechaAño"+String:C10($bol))
$varPtr->:=Year of:C25([ACT_Boletas:181]FechaEmision:3)
$varPtr:=Get pointer:C304("vlACT_SRbol_FechaMes"+String:C10($bol))
$varPtr->:=Month of:C24([ACT_Boletas:181]FechaEmision:3)
$varPtr:=Get pointer:C304("vtACT_SRbol_FechaMesText"+String:C10($bol))
$varPtr->:=<>atXS_MonthNamesText{Month of:C24([ACT_Boletas:181]FechaEmision:3)}
$varPtr:=Get pointer:C304("vrACT_SRbol_Total"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]Monto_Total:6
$varPtr:=Get pointer:C304("vrACT_SRbol_Afecto"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]Monto_Afecto:4
$varPtr:=Get pointer:C304("vrACT_SRbol_IVA"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]Monto_IVA:5
$varPtr:=Get pointer:C304("vrACT_SRbol_PorcIVA"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]TasaIVA:16
$varPtr:=Get pointer:C304("vrACT_SRbol_TotalText"+String:C10($bol))
$varPtr->:=ST_Num2Text2 ([ACT_Boletas:181]Monto_Total:6;"Spanish")

  //20130210 RCH
$varPtr:=Get pointer:C304("vrACT_SRbol_Exento"+String:C10($bol))
$varPtr->:=[ACT_Boletas:181]Monto_Exento:30

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Familia:78])
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])

  //var notas de crédito
$varPtr:=Get pointer:C304("vtACT_SRbol_DocsAsoc"+String:C10($bol))
$recNumBoleta:=Record number:C243([ACT_Boletas:181])
ARRAY LONGINT:C221($al_NumerosBoletas;0)
ARRAY LONGINT:C221($al_idBol;0)
ARRAY LONGINT:C221($al_idBol2;0)
GOTO RECORD:C242([ACT_Boletas:181];$recNumBoleta)
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=[ACT_Boletas:181]ID:1;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
DISTINCT VALUES:C339([ACT_Boletas:181]ID:1;$al_idBol)
For ($i;1;Size of array:C274($al_idBol))
	If (Find in array:C230($al_idBol2;$al_idBol{$i})=-1)
		APPEND TO ARRAY:C911($al_idBol2;$al_idBol{$i})
	End if 
End for 
GOTO RECORD:C242([ACT_Boletas:181];$recNumBoleta)
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=[ACT_Boletas:181]ID_DctoAsociado:19;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
DISTINCT VALUES:C339([ACT_Boletas:181]ID:1;$al_idBol)
For ($i;1;Size of array:C274($al_idBol))
	If (Find in array:C230($al_idBol2;$al_idBol{$i})=-1)
		APPEND TO ARRAY:C911($al_idBol2;$al_idBol{$i})
	End if 
End for 
For ($i;1;Size of array:C274($al_idBol2))
	$index:=Find in field:C653([ACT_Boletas:181]ID:1;$al_idBol2{$i})
	If ($index#-1)
		GOTO RECORD:C242([ACT_Boletas:181];$index)
		APPEND TO ARRAY:C911($al_NumerosBoletas;[ACT_Boletas:181]Numero:11)
	End if 
End for 
$varPtr->:=AT_array2text (->$al_NumerosBoletas;"-";"#########")
GOTO RECORD:C242([ACT_Boletas:181];$recNumBoleta)

QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Boletas:181]ID_Apoderado:14)
$varPtr:=Get pointer:C304("vtACT_SRbol_ApdoNombre"+String:C10($bol))
$varPtr->:=[Personas:7]Apellidos_y_nombres:30
$varPtr:=Get pointer:C304("vtACT_SRbol_IDNacApdo"+String:C10($bol))
$varPtr->:=[Personas:7]RUT:6
$varPtr:=Get pointer:C304("vtACT_SRbol_DirCombinadaEC"+String:C10($bol))
If ([Personas:7]ACT_CodPostalEC:70#"")
	$varPtr->:=[Personas:7]ACT_DireccionEC:67+"\r"+[Personas:7]ACT_CodPostalEC:70+" "+[Personas:7]ACT_ComunaEC:68+" "+[Personas:7]ACT_CiudadEC:69
Else 
	$varPtr->:=[Personas:7]ACT_DireccionEC:67+"\r"+[Personas:7]ACT_ComunaEC:68+" "+[Personas:7]ACT_CiudadEC:69
End if 
$varPtr:=Get pointer:C304("vtACT_SRbol_DirEC"+String:C10($bol))
$varPtr->:=[Personas:7]ACT_DireccionEC:67
$varPtr:=Get pointer:C304("vtACT_SRbol_CodPosEC"+String:C10($bol))
$varPtr->:=[Personas:7]ACT_CodPostalEC:70
$varPtr:=Get pointer:C304("vtACT_SRbol_ComunaEC"+String:C10($bol))
$varPtr->:=[Personas:7]ACT_ComunaEC:68
$varPtr:=Get pointer:C304("vtACT_SRbol_CiudadEC"+String:C10($bol))
$varPtr->:=[Personas:7]ACT_CiudadEC:69
$varPtr:=Get pointer:C304("vtACT_SRbol_DirCombPersonal"+String:C10($bol))
If ([Personas:7]Codigo_postal:15#"")
	$varPtr->:=[Personas:7]Direccion:14+"\r"+[Personas:7]Codigo_postal:15+" "+[Personas:7]Comuna:16+" "+[Personas:7]Ciudad:17
Else 
	$varPtr->:=[Personas:7]Direccion:14+"\r"+[Personas:7]Comuna:16+" "+[Personas:7]Ciudad:17
End if 
$varPtr:=Get pointer:C304("vtACT_SRbol_DirPersonal"+String:C10($bol))
$varPtr->:=[Personas:7]Direccion:14
$varPtr:=Get pointer:C304("vtACT_SRbol_CodPosPersonal"+String:C10($bol))
$varPtr->:=[Personas:7]Codigo_postal:15
$varPtr:=Get pointer:C304("vtACT_SRbol_ComunaPersonal"+String:C10($bol))
$varPtr->:=[Personas:7]Comuna:16
$varPtr:=Get pointer:C304("vtACT_SRbol_CiudadPersonal"+String:C10($bol))
$varPtr->:=[Personas:7]Ciudad:17
$varPtr:=Get pointer:C304("vtACT_SRbol_DirProfesional"+String:C10($bol))
$varPtr->:=[Personas:7]Direccion_Profesional:23

If (Records in selection:C76([Personas:7])>0)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
	KRL_RelateSelection (->[Familia:78]Numero:1;->[ACT_CuentasCorrientes:175]ID_Familia:2;"")
Else 
	REDUCE SELECTION:C351([Familia:78];0)
End if 
ARRAY TEXT:C222(atACT_CodigoFamilia;0)
ARRAY TEXT:C222(atACT_Familia;0)
SELECTION TO ARRAY:C260([Familia:78]Codigo_interno:14;atACT_CodigoFamilia;[Familia:78]Nombre_de_la_familia:3;atACT_Familia)
$varPtr:=Get pointer:C304("vtACT_SRbol_CodigoFamilias"+String:C10($bol))
$varPtr->:=AT_array2text (->atACT_CodigoFamilia;" - ")
$varPtr:=Get pointer:C304("vtACT_SRbol_NombreFamilias"+String:C10($bol))
$varPtr->:=AT_array2text (->atACT_Familia;" - ")
AT_Initialize (->atACT_CodigoFamilia;->atACT_Familia)
$varPtr:=Get pointer:C304("vtACT_SRbol_MododePago"+String:C10($bol))
  //20121005 RCH
  //$varPtr->:=[Personas]ACT_Modo_de_pago
$varPtr->:=[Personas:7]ACT_modo_de_pago_new:95

If (Records in selection:C76([Personas:7])>0)
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
	QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
Else 
	REDUCE SELECTION:C351([ACT_Pagos:172];0)
End if 
$varPtr:=Get pointer:C304("vrACT_SRbol_SaldoApdo"+String:C10($bol))
$varPtr->:=Sum:C1([ACT_Pagos:172]Saldo:15)

  //receptor
REDUCE SELECTION:C351([Personas:7];0)
REDUCE SELECTION:C351([ACT_Terceros:138];0)
If (([ACT_Boletas:181]Receptor_Id_Apdo_org:44#0) | ([ACT_Boletas:181]Receptor_Id_Tercero_org:45#0))
	If ([ACT_Boletas:181]Receptor_Id_Apdo_org:44#0)
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Boletas:181]Receptor_Id_Apdo_org:44)
	Else 
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Boletas:181]Receptor_Id_Tercero_org:45)
	End if 
Else 
	If ([ACT_Boletas:181]ID_Apoderado:14#0)
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Boletas:181]ID_Apoderado:14)
	Else 
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Boletas:181]ID_Tercero:21)
	End if 
End if 
$varPtr:=Get pointer:C304("vtACT_SRbol_RecNombre"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]Apellidos_y_nombres:30;[ACT_Terceros:138]Nombre_Completo:9)
$varPtr:=Get pointer:C304("vtACT_SRbol_IDNacRec"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]RUT:6;[ACT_Terceros:138]RUT:4)
$varPtr:=Get pointer:C304("vtACT_SRbol_DirCombinadaECRec"+String:C10($bol))
If (([Personas:7]ACT_CodPostalEC:70#"") & (Records in selection:C76([Personas:7])>0))
	$varPtr->:=[Personas:7]ACT_DireccionEC:67+"\r"+[Personas:7]ACT_CodPostalEC:70+" "+[Personas:7]ACT_ComunaEC:68+" "+[Personas:7]ACT_CiudadEC:69
Else 
	If (([ACT_Terceros:138]Codigo_Postal:15#"") & ([ACT_Boletas:181]Receptor_Id_Tercero_org:45#0))
		$varPtr->:=[ACT_Terceros:138]Direccion:5+"\r"+[ACT_Terceros:138]Codigo_Postal:15+" "+[ACT_Terceros:138]Comuna:6+" "+[ACT_Terceros:138]Ciudad:7
	Else 
		$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]ACT_DireccionEC:67+"\r"+[Personas:7]ACT_ComunaEC:68+" "+[Personas:7]ACT_CiudadEC:69;[ACT_Terceros:138]Direccion:5+"\r"+[ACT_Terceros:138]Comuna:6+" "+[ACT_Terceros:138]Ciudad:7)
	End if 
End if 
$varPtr:=Get pointer:C304("vtACT_SRbol_DirECRec"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]ACT_DireccionEC:67;[ACT_Terceros:138]Direccion:5)
$varPtr:=Get pointer:C304("vtACT_SRbol_CodPosECRec"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]ACT_CodPostalEC:70;[ACT_Terceros:138]Codigo_Postal:15)
$varPtr:=Get pointer:C304("vtACT_SRbol_ComunaECRec"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]ACT_ComunaEC:68;[ACT_Terceros:138]Comuna:6)
$varPtr:=Get pointer:C304("vtACT_SRbol_CiudadECRec"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]ACT_CiudadEC:69;[ACT_Terceros:138]Ciudad:7)
$varPtr:=Get pointer:C304("vtACT_SRbol_DirCombPersonalRec"+String:C10($bol))
If (([Personas:7]Codigo_postal:15#"") & (Records in selection:C76([Personas:7])>0))
	$varPtr->:=[Personas:7]Direccion:14+"\r"+[Personas:7]Codigo_postal:15+" "+[Personas:7]Comuna:16+" "+[Personas:7]Ciudad:17
Else 
	If (([ACT_Terceros:138]Codigo_Postal:15#"") & ([ACT_Boletas:181]Receptor_Id_Tercero_org:45#0))
		$varPtr->:=[ACT_Terceros:138]Direccion:5+"\r"+[ACT_Terceros:138]Codigo_Postal:15+" "+[ACT_Terceros:138]Comuna:6+" "+[ACT_Terceros:138]Ciudad:7
	Else 
		$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]Direccion:14+"\r"+[Personas:7]Comuna:16+" "+[Personas:7]Ciudad:17;[ACT_Terceros:138]Direccion:5+"\r"+[ACT_Terceros:138]Comuna:6+" "+[ACT_Terceros:138]Ciudad:7)
	End if 
End if 
$varPtr:=Get pointer:C304("vtACT_SRbol_DirPersonalRec"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]Direccion:14;[ACT_Terceros:138]Direccion:5)
$varPtr:=Get pointer:C304("vtACT_SRbol_CodPosPersonalRec"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]Codigo_postal:15;[ACT_Terceros:138]Codigo_Postal:15)
$varPtr:=Get pointer:C304("vtACT_SRbol_ComunaPersonalRec"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]Comuna:16;[ACT_Terceros:138]Comuna:6)
$varPtr:=Get pointer:C304("vtACT_SRbol_CiudadPersonalRec"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]Ciudad:17;[ACT_Terceros:138]Ciudad:7)
$varPtr:=Get pointer:C304("vtACT_SRbol_DirProfesionalRec"+String:C10($bol))
$varPtr->:=Choose:C955(Records in selection:C76([Personas:7])>0;[Personas:7]Direccion_Profesional:23;[ACT_Terceros:138]Direccion:5)

  // 20111122 RCH Para que la boleta no sea alterada
  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
  //CREATE SET([ACT_Transacciones];"Transacciones")
  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
ACTbol_BuscaCargosCargaSet ("Transacciones";[ACT_Boletas:181]ID:1)

  //$CuantosCargos:=ACTcc_LoadCargosIntoArrays (True)
C_POINTER:C301($y_dummy)
$CuantosCargos:=ACTcc_LoadCargosIntoArrays (True:C214;$y_dummy;$y_dummy;$y_dummy;$y_dummy;$y_dummy;$y_dummy;False:C215;False:C215;False:C215;ACTdte_EsEmisorColegium ([ACT_Boletas:181]ID_RazonSocial:25))
ACTcfg_OpcionesRazonesSociales ("CargaRazonDesdeInforme";->alACT_RecNumsCargos)
ARRAY DATE:C224(adACT_fechaVencimiento;0)
COPY ARRAY:C226(adACT_CFechaVencimiento;adACT_fechaVencimiento)
SORT ARRAY:C229(adACT_fechaVencimiento;>)
ARRAY LONGINT:C221(alACT_IDCtaCteTemp;0)
COPY ARRAY:C226(alACT_IDCtaCte;alACT_IDCtaCteTemp)
AT_DistinctsArrayValues (->alACT_IDCtaCteTemp)
For ($i;1;Size of array:C274(alACT_IDCtaCteTemp))
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=alACT_IDCtaCteTemp{$i})
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	If (Records in selection:C76([Alumnos:2])>0)
		$varPtr:=Get pointer:C304("vtACT_SRBol_CtaNombre"+String:C10($bol))
		AT_Insert (0;1;$varPtr)
		$varPtr->{Size of array:C274($varPtr->)}:=[Alumnos:2]apellidos_y_nombres:40
		$varPtr:=Get pointer:C304("vtACT_SRbol_CtaCurso"+String:C10($bol))
		AT_Insert (0;1;$varPtr)
		$varPtr->{Size of array:C274($varPtr->)}:=[Alumnos:2]curso:20
		$varPtr:=Get pointer:C304("vtACT_SRBol_CtaMatricula"+String:C10($bol))
		AT_Insert (0;1;$varPtr)
		$varPtr->{Size of array:C274($varPtr->)}:=[Alumnos:2]numero_de_matricula:51
		$varPtr:=Get pointer:C304("vtACT_SRbol_RUTCta"+String:C10($bol))
		AT_Insert (0;1;$varPtr)
		$varPtr->{Size of array:C274($varPtr->)}:=SR_FormatoRUT2 ([Alumnos:2]RUT:5)
		$varPtr:=Get pointer:C304("vtACT_SRBol_CtaPCurso"+String:C10($bol))
		AT_Insert (0;1;$varPtr)
		Case of 
			: ([Alumnos:2]nivel_numero:29=Nivel_AdmisionDirecta)
				$varPtr->{Size of array:C274($varPtr->)}:=[Alumnos:2]Nivel_al_que_ingreso:35
			: ([Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)-1})
				C_LONGINT:C283($nivelNumero)
				$el:=Find in array:C230(<>al_NumeroNivelRegular;[Alumnos:2]nivel_numero:29)
				If (($el>0) & ($el<Size of array:C274(<>al_NumeroNivelRegular)))
					$nivelNumero:=<>al_NumeroNivelRegular{$el+1}
					$varPtr->{Size of array:C274($varPtr->)}:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelNumero;->[xxSTR_Niveles:6]Abreviatura:19)+Substring:C12([Alumnos:2]curso:20;Position:C15("-";[Alumnos:2]curso:20))
				Else 
					$varPtr->{Size of array:C274($varPtr->)}:=""
				End if 
			Else 
				$varPtr->{Size of array:C274($varPtr->)}:=""
		End case 
		$varPtr:=Get pointer:C304("alACT_SRbol_NoNivel"+String:C10($bol))
		AT_Insert (0;1;$varPtr)
		$varPtr->{Size of array:C274($varPtr->)}:=[Alumnos:2]nivel_numero:29
		$varPtr:=Get pointer:C304("atACT_SRbol_NumTrans"+String:C10($bol))
		AT_Insert (0;1;$varPtr)
		$varPtr->{Size of array:C274($varPtr->)}:=String:C10(KRL_GetNumericFieldData (->[Buses_escolares:57]Patente:1;->[Alumnos:2]Patente_bus_escolar:37;->[Buses_escolares:57]Numero:10))
		$varPtr:=Get pointer:C304("atACT_SRbol_Sede"+String:C10($bol))
		AT_Insert (0;1;$varPtr)
		$varPtr->{Size of array:C274($varPtr->)}:=KRL_GetTextFieldData (->[Cursos:3]Curso:1;->[Alumnos:2]curso:20;->[Cursos:3]Sede:19)
	End if 
End for 
  //$command:="SORT ARRAY(alACT_SRbol_NoNivel"+String($bol)+";vtACT_SRbol_CtaCurso"+String($bol)+";vtACT_SRbol_CtaNombre"+String($bol)+";vtACT_SRBol_CtaMatricula"+String($bol)+";vtACT_SRBol_CtaPCurso"+String($bol)+";vtACT_SRbol_RUTCta"+String($bol)+";>)"
$command:="SORT ARRAY(alACT_SRbol_NoNivel"+String:C10($bol)+";vtACT_SRbol_CtaCurso"+String:C10($bol)+";vtACT_SRbol_CtaNombre"+String:C10($bol)+";vtACT_SRBol_CtaMatricula"+String:C10($bol)+";vtACT_SRBol_CtaPCurso"+String:C10($bol)+";vtACT_SRbol_RUTCta"+String:C10($bol)+";atACT_SRbol_NumTrans"+String:C10($bol)+";atACT_SRbol_Sede"+String:C10($bol)+";>)"
EXECUTE FORMULA:C63($command)
AT_Initialize (->alACT_IDCtaCteTemp)
  // meses asociados a la boleta desde acá
ARRAY TEXT:C222(<>atXS_MonthNames;12)
ARRAY LONGINT:C221(alACT_MesCargoT;0)
COPY ARRAY:C226(alACT_MesCargo;alACT_MesCargoT)
AT_DistinctsArrayValues (->alACT_MesCargoT)
ARRAY TEXT:C222(atACT_MesCargoT;Size of array:C274(alACT_MesCargoT))
SORT ARRAY:C229(alACT_MesCargoT;>)

For ($i;1;Size of array:C274(alACT_MesCargoT))
	atACT_MesCargoT{$i}:=<>atXS_MonthNames{alACT_MesCargoT{$i}}
End for 
$varPtr:=Get pointer:C304("vtACT_SRbol_ATMesCargo"+String:C10($bol))
$varPtr->:=AT_array2text (->atACT_MesCargoT;" - ")
$varPtr:=Get pointer:C304("vtACT_SRbol_ANMesCargo"+String:C10($bol))
$varPtr->:=AT_array2text (->alACT_MesCargoT;" - ")
AT_Initialize (->atACT_MesCargoT;->alACT_MesCargoT)
  //hasta acá

  //20130626 RCH NF CANTIDAD
ARRAY LONGINT:C221(alACT_Cantidad;$CuantosCargos)
ARRAY REAL:C219(arACT_Cantidad;$CuantosCargos)
ARRAY REAL:C219(arACT_Unitario;$CuantosCargos)

  //20150912 RCH
ARRAY TEXT:C222(atACT_unidadCargo;$CuantosCargos)

ARRAY REAL:C219(arACT_MontoPagado;$CuantosCargos)
For ($t;1;Size of array:C274(alACT_RecNumsCargos))
	GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumsCargos{$t})
	arACT_MontoPagado{$t}:=ACTbol_GetMontoLinea ("Transacciones")
	
	If ([ACT_Cargos:173]cantidad:65=0)
		arACT_Cantidad{$t}:=1
	Else 
		arACT_Cantidad{$t}:=[ACT_Cargos:173]cantidad:65
	End if 
	arACT_Unitario{$t}:=arACT_MontoPagado{$t}
	
	atACT_unidadCargo{$t}:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;->[xxACT_Items:179]Unidad_de_Medida:46)
	
End for 
  //ACTcfg_LoadConfigData (8)
ACTcfg_LeeBlob ("ACT_DocsTributarios")
If (cbUsarCategorias=1)
	ACTbol_AgruparXCategoria 
End if 
If (Size of array:C274(atACT_RecNumsCargosCat)=0)
	abACT_RecNumsCargosCat:=False:C215
	AT_RedimArrays ($CuantosCargos;->atACT_RecNumsCargosCat)
Else 
	abACT_RecNumsCargosCat:=True:C214
End if 
ACTpgs_LoadInteresRecord 
If ([xxACT_Items:179]AgruparInteresesDT:34)
	ACTac_AgruparIntereses 
End if 
If (cbAgruparBoletas=1)
	ACTac_AgrupaCargos 
	vb_HideColsCtas:=True:C214
End if 
If (cbUsarCategorias=1)
	ARRAY TEXT:C222(atACT_GlosaImpTemp;0)
	ARRAY REAL:C219(arACT_MontosTemp;0)
	
	  //arreglos temporales alumnos
	ARRAY TEXT:C222($atACT_Alumnos;0)
	ARRAY TEXT:C222($atACT_mes;0)
	ARRAY TEXT:C222($atACT_curso;0)
	ARRAY TEXT:C222($atACT_rut;0)
	ARRAY TEXT:C222($atACT_year;0)
	ARRAY TEXT:C222($atACT_nivel;0)
	
	  //20150912 RCH 
	ARRAY TEXT:C222($atACT_unidadCargo;0)
	ARRAY REAL:C219($arACT_TasaIVA;0)
	
	$nombresCat:=AT_array2text (->atACT_NombreCategoria;";")
	$glosas:=AT_array2text (->atACT_CGlosaImpresion;";")
	AT_AppendItems2TextArray (->atACT_GlosaImpTemp;$nombresCat)
	ARRAY LONGINT:C221(alACT_CantidadTemp;0)  //RCH
	  //20130626 RCH NF CANTIDAD
	ARRAY REAL:C219(arACT_CantidadTemp;0)  //RCH
	
	  // Modificado por: Saúl Ponce (23-02-2017) Ticket Nº 175401
	  // Aparecía error en el método SRACTbol_CargaCargos cuando se tenía configurado el check para utilizar categorías y éstas no existían.
	If (Size of array:C274(arACT_MontoCategoria)>0)
		
		For ($i;1;Size of array:C274(arACT_MontoCategoria))
			AT_Insert (0;1;->arACT_MontosTemp)
			arACT_MontosTemp{Size of array:C274(arACT_MontosTemp)}:=arACT_MontoCategoria{$i}
			AT_Insert (0;1;->arACT_CantidadTemp)  //RCH
			  //20151005 RCH
			  //arACT_CantidadTemp{Size of array(arACT_CantidadTemp)}:=arACT_CIDCtaCteTemp2{$i}  //RCH
			arACT_CantidadTemp{Size of array:C274(arACT_CantidadTemp)}:=arACTcat_cantidadCargo{$i}  //RCH
			
			  //AT_Insert (0;1;->$atACT_Alumnos;->$atACT_mes;->$atACT_curso;->$atACT_rut;->$atACT_year;->$atACT_nivel)
			AT_Insert (0;1;->$atACT_Alumnos;->$atACT_mes;->$atACT_curso;->$atACT_rut;->$atACT_year;->$atACT_nivel;->$atACT_unidadCargo;->$arACT_TasaIVA)
			$atACT_Alumnos{Size of array:C274($atACT_Alumnos)}:=atACTcat_Alumnos{$i}
			$atACT_mes{Size of array:C274($atACT_mes)}:=atACTcat_mes{$i}
			$atACT_curso{Size of array:C274($atACT_curso)}:=atACTcat_curso{$i}
			$atACT_rut{Size of array:C274($atACT_rut)}:=atACTcat_rut{$i}
			$atACT_year{Size of array:C274($atACT_year)}:=atACTcat_year{$i}
			$atACT_nivel{Size of array:C274($atACT_nivel)}:=atACTcat_nivel{$i}
			
			  //20150912 RCH 
			$atACT_unidadCargo{Size of array:C274($atACT_unidadCargo)}:=atACTcat_unidadCargo{$i}
			$arACT_TasaIVA{Size of array:C274($arACT_TasaIVA)}:=arACTcat_TasaIVA{$i}
			
		End for 
		
		AT_AppendItems2TextArray (->atACT_GlosaImpTemp;$glosas)
		For ($i;1;Size of array:C274(arACT_MontoPagado))
			AT_Insert (0;1;->arACT_MontosTemp)
			arACT_MontosTemp{Size of array:C274(arACT_MontosTemp)}:=arACT_MontoPagado{$i}
			AT_Insert (0;1;->arACT_CantidadTemp)  //RCH
			arACT_CantidadTemp{Size of array:C274(arACT_CantidadTemp)}:=arACT_Cantidad{$i}  //RCH
			
			  //AT_Insert (0;1;->$atACT_Alumnos;->$atACT_mes;->$atACT_curso;->$atACT_rut;->$atACT_year;->$atACT_nivel)
			AT_Insert (0;1;->$atACT_Alumnos;->$atACT_mes;->$atACT_curso;->$atACT_rut;->$atACT_year;->$atACT_nivel;->$atACT_unidadCargo;->$arACT_TasaIVA)
			
			$atACT_Alumnos{Size of array:C274($atACT_Alumnos)}:=atACT_CAlumno{$i}
			$atACT_mes{Size of array:C274($atACT_mes)}:=atACT_MesCargo{$i}
			$atACT_curso{Size of array:C274($atACT_curso)}:=atACT_CAlumnoCurso{$i}
			$atACT_rut{Size of array:C274($atACT_rut)}:=atACT_CAlumnoRUT{$i}
			$atACT_year{Size of array:C274($atACT_year)}:=atACT_AñoCargo{$i}
			$atACT_nivel{Size of array:C274($atACT_nivel)}:=atACT_CAlumnoNivelNombre{$i}
			
			  //20150912 RCH 
			$atACT_unidadCargo{Size of array:C274($atACT_unidadCargo)}:=atACT_unidadCargo{$i}
			$arACT_TasaIVA{Size of array:C274($arACT_TasaIVA)}:=arACT_TasaIVA{$i}
			
		End for 
		
		  //AT_Insert (1;ST_CountWords ($nombresCat;0;";");->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->atACT_MesCargo;->alACT_AñoCargo;->atACT_CAlumnoRUT;->atACT_AñoCargo)
		AT_Insert (1;ST_CountWords ($nombresCat;0;";");->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoPagado;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->atACT_MesCargo;->alACT_AñoCargo;->atACT_CAlumnoRUT;->atACT_AñoCargo;->atACT_unidadCargo)
		
		COPY ARRAY:C226(atACT_GlosaImpTemp;atACT_CGlosaImpresion)
		COPY ARRAY:C226(arACT_MontosTemp;arACT_MontoPagado)
		COPY ARRAY:C226(arACT_CantidadTemp;arACT_Cantidad)  //RCH
		
		COPY ARRAY:C226($atACT_Alumnos;atACT_CAlumno)
		COPY ARRAY:C226($atACT_mes;atACT_MesCargo)
		COPY ARRAY:C226($atACT_curso;atACT_CAlumnoCurso)
		COPY ARRAY:C226($atACT_rut;atACT_CAlumnoRUT)
		COPY ARRAY:C226($atACT_year;atACT_AñoCargo)
		COPY ARRAY:C226($atACT_nivel;atACT_CAlumnoNivelNombre)
		
		  //20150912 RCH 
		COPY ARRAY:C226($atACT_unidadCargo;atACT_unidadCargo)
		COPY ARRAY:C226($arACT_TasaIVA;arACT_TasaIVA)
		
		ARRAY TEXT:C222(atACT_GlosaImpTemp;0)
		ARRAY REAL:C219(arACT_MontosTemp;0)
	End if 
End if 
If (Size of array:C274(atACT_RecNumsCargosAgr)=0)
	abACT_RecNumsCargosAgr:=False:C215
	AT_RedimArrays (Size of array:C274(arACT_MontoPagado);->atACT_RecNumsCargosAgr)
Else 
	abACT_RecNumsCargosAgr:=True:C214
End if 
If (cb_ImprimirCeros=0)
	arACT_MontoPagado{0}:=0
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->arACT_MontoPagado;"=";->$DA_Return)
	For ($u;Size of array:C274($DA_Return);1;-1)
		  //AT_Delete (DA_Return{$u};1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->arACT_MontoPagado;->atACT_MesCargo;->alACT_AñoCargo)
		  //AT_Delete ($DA_Return{$u};1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->arACT_MontoPagado;->atACT_MesCargo;->alACT_AñoCargo;->atACT_RecNumsCargosCat;->atACT_RecNumsCargosAgr)
		  //AT_Delete ($DA_Return{$u};1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->arACT_MontoPagado;->atACT_MesCargo;->atACT_AñoCargo;->atACT_RecNumsCargosCat;->atACT_RecNumsCargosAgr;->atACT_CAlumnoRUT)
		  //AT_Delete ($DA_Return{$u};1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->arACT_MontoPagado;->atACT_MesCargo;->alACT_AñoCargo;->atACT_RecNumsCargosCat;->atACT_RecNumsCargosAgr;->atACT_CAlumnoRUT;->atACT_AñoCargo)
		AT_Delete ($DA_Return{$u};1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->arACT_MontoPagado;->atACT_MesCargo;->alACT_AñoCargo;->atACT_RecNumsCargosCat;->atACT_RecNumsCargosAgr;->atACT_CAlumnoRUT;->atACT_AñoCargo;->atACT_unidadCargo)
	End for 
End if 

  //If (<>gCountryCode="mx")
Case of 
	: (Not:C34(abACT_RecNumsCargosCat) & (Not:C34(abACT_RecNumsCargosAgr)))
		  //: (Size of array(atACT_RecNumsCargosCat)=0) & (Size of array(atACT_RecNumsCargosAgr)=0)
		  //se utiliza el arreglo atACT_RecNumsCargosT tal como viene
	: ((abACT_RecNumsCargosCat) & (abACT_RecNumsCargosAgr))
		  //: (Size of array(atACT_RecNumsCargosCat)>0) & (Size of array(atACT_RecNumsCargosAgr)>0)
		AT_Initialize (->atACT_RecNumsCargosT)
		COPY ARRAY:C226(atACT_RecNumsCargosCat;atACT_RecNumsCargosT)
		For ($i;1;Size of array:C274(atACT_RecNumsCargosAgr))
			APPEND TO ARRAY:C911(atACT_RecNumsCargosT;atACT_RecNumsCargosAgr{$i})
		End for 
		
	: ((abACT_RecNumsCargosCat) & (Not:C34(abACT_RecNumsCargosAgr)))
		  //: (Size of array(atACT_RecNumsCargosCat)>0) & (Size of array(atACT_RecNumsCargosAgr)=0)
		AT_Initialize (->atACT_RecNumsCargosT)
		For ($i;Size of array:C274(atACT_RecNumsCargosCat);1;-1)
			AT_Insert (1;1;->atACT_RecNumsCargosT)
			atACT_RecNumsCargosT{1}:=atACT_RecNumsCargosCat{$i}
		End for 
		For ($i;1;Size of array:C274(alACT_RecNumsCargosT))
			APPEND TO ARRAY:C911(atACT_RecNumsCargosT;String:C10(alACT_RecNumsCargosT{$i}))
		End for 
		
	: (Not:C34(abACT_RecNumsCargosCat) & (abACT_RecNumsCargosAgr))
		  //: (Size of array(atACT_RecNumsCargosCat)=0) & (Size of array(atACT_RecNumsCargosAgr)>0)
		AT_Initialize (->atACT_RecNumsCargosT)
		COPY ARRAY:C226(atACT_RecNumsCargosAgr;atACT_RecNumsCargosT)
		
End case 
  //End if 
$ptrIVA:=Get pointer:C304("arACTmx_MontoIVA"+String:C10($bol))
AT_RedimArrays (Size of array:C274(atACT_CGlosaImpresion);$ptrIVA)

  //20130210 RCH
  //If (<>gCountryCode="mx")
If ((<>gCountryCode="mx") | (abACT_EmiteAfectoExento{Find in array:C230(alACT_IDsCats;[ACT_Boletas:181]ID_Categoria:12)}) & (Not:C34(ACTdte_EsEmisorColegium ([ACT_Boletas:181]ID_RazonSocial:25))))
	$vl_hasta:=Size of array:C274(atACT_CGlosaImpresion)
	$i:=0
	While ($i<$vl_hasta)
		$i:=$i+1
		$vr_montoIVA:=0
		ARRAY LONGINT:C221($al_RecNums;0)
		AT_Text2Array (->$al_RecNums;atACT_RecNumsCargosT{$i};";")
		For ($x;Size of array:C274($al_RecNums);1;-1)
			If ($al_RecNums{$x}=0)
				AT_Delete ($x;1;->$al_RecNums)
			End if 
		End for 
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_RecNums;"")
		If (Sum:C1([ACT_Cargos:173]TasaIVA:21)#0)
			ARRAY REAL:C219($ar_TasaIVA;0)
			AT_DistinctsFieldValues (->[ACT_Cargos:173]TasaIVA:21;->$ar_TasaIVA)
			For ($x;Size of array:C274($ar_TasaIVA);1;-1)
				If ($ar_TasaIVA{$x}=0)
					AT_Delete ($x;1;->$ar_TasaIVA)
				End if 
			End for 
			If (Size of array:C274($ar_TasaIVA)>0)
				$vl_factorIva:=1+($ar_TasaIVA{1}/100)
				$vr_TotalPagado:=arACT_MontoPagado{$i}
				$vl_decimales:=<>vlACT_NoDecimalesDespl
				arACT_MontoPagado{$i}:=Round:C94($vr_TotalPagado/$vl_factorIva;$vl_decimales)
				$vr_montoIVA:=$vr_TotalPagado-arACT_MontoPagado{$i}
			End if 
		End if 
		If ($vr_montoIVA#0)
			$pos:=$i+1
			  //AT_Insert ($pos;1;$ptrIVA;->atACT_RecNumsCargosT;->atACT_CGlosaImpresion;->arACT_MontoPagado;->atACT_CAlumno;->arACT_Cantidad;->arACT_Unitario;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_MesCargo;->alACT_AñoCargo;->atACT_MonedaSimbolo;->arACT_CTotalDesctos)
			  //20150915 RCH 
			  //AT_Insert ($pos;1;$ptrIVA;->atACT_RecNumsCargosT;->atACT_CGlosaImpresion;->arACT_MontoPagado;->atACT_CAlumno;->arACT_Cantidad;->arACT_Unitario;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_MesCargo;->alACT_AñoCargo;->atACT_MonedaSimbolo;->arACT_CTotalDesctos;->atACT_CAlumnoRUT;->atACT_AñoCargo)
			  //AT_Insert ($pos;1;$ptrIVA;->atACT_RecNumsCargosT;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->arACT_MontoPagado;->atACT_MesCargo;->alACT_AñoCargo;->atACT_RecNumsCargosCat;->atACT_RecNumsCargosAgr;->atACT_CAlumnoRUT;->atACT_AñoCargo)
			AT_Insert ($pos;1;$ptrIVA;->atACT_RecNumsCargosT;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->atACT_CGlosaImpresion;->asACT_Afecto;->arACT_TasaIVA;->arACT_MontoIVA;->arACT_CTotalDesctos;->aIDCta;->arACT_Cantidad;->arACT_Unitario;->arACT_MontoPagado;->atACT_MesCargo;->alACT_AñoCargo;->atACT_RecNumsCargosCat;->atACT_RecNumsCargosAgr;->atACT_CAlumnoRUT;->atACT_AñoCargo;->atACT_unidadCargo)
			
			If (Size of array:C274($ar_TasaIVA)>0)
				atACT_CGlosaImpresion{$pos}:="\t"+"\t"+"I.V.A. "+AT_array2text (->$ar_TasaIVA;" - ";"##0")+"% "+atACT_CGlosaImpresion{$i}
			End if 
			$ptrIVA->{$pos}:=$vr_montoIVA
			arACT_MontoPagado{$pos}:=$vr_montoIVA
			atACT_CAlumno{$pos}:=atACT_CAlumno{$i}
			arACT_Cantidad{$pos}:=arACT_Cantidad{$i}
			arACT_Unitario{$pos}:=arACT_Unitario{$i}
			atACT_CAlumnoCurso{$pos}:=atACT_CAlumnoCurso{$i}
			atACT_CAlumnoNivelNombre{$pos}:=atACT_CAlumnoNivelNombre{$i}
			atACT_CAlumnoPCurso{$pos}:=atACT_CAlumnoPCurso{$i}
			atACT_CAlumnoPNivelNombre{$pos}:=atACT_CAlumnoPNivelNombre{$i}
			atACT_MesCargo{$pos}:=atACT_MesCargo{$i}
			atACT_AñoCargo{$pos}:=atACT_AñoCargo{$i}
			atACT_MonedaSimbolo{$pos}:=atACT_MonedaSimbolo{$i}
			arACT_CTotalDesctos{$pos}:=arACT_CTotalDesctos{$i}
			
			atACT_CAlumnoRUT{$pos}:=atACT_CAlumnoRUT{$i}
			
			  //20150915 RCH
			arACT_TasaIVA{$pos}:=arACT_TasaIVA{$i}
			
			  //20150915 RCH
			atACT_unidadCargo{$pos}:=atACT_unidadCargo{$i}
			
			$i:=$i+1
			$vl_hasta:=$vl_hasta+1
		End if 
	End while 
End if 

If (Size of array:C274(atACT_CGlosaImpresion)<=$vl_lineas)
	$NumVars:=Size of array:C274(atACT_CGlosaImpresion)
Else 
	$NumVars:=$vl_lineas
End if 

$pos:=1
$t:=1
For ($i;1;$NumVars)
	$var1:=Get pointer:C304("vtACT_SRbol_DetalleCargo"+String:C10($t)+String:C10($bol))
	$var2:=Get pointer:C304("vrACT_SRbol_MontoCargo"+String:C10($t)+String:C10($bol))
	$var3:=Get pointer:C304("vtACT_SRbol_CuentaCargo"+String:C10($t)+String:C10($bol))
	$var4:=Get pointer:C304("vrACT_SRbol_CantidadCargo"+String:C10($t)+String:C10($bol))
	$var5:=Get pointer:C304("vrACT_SRbol_UnitarioCargo"+String:C10($t)+String:C10($bol))
	$var6:=Get pointer:C304("vbACT_HideMonto"+String:C10($t)+String:C10($bol))
	$var7:=Get pointer:C304("vtACT_SRbol_CuentaCurCargo"+String:C10($t)+String:C10($bol))
	$var8:=Get pointer:C304("vtACT_SRbol_CuentaNivCargo"+String:C10($t)+String:C10($bol))
	$var9:=Get pointer:C304("vtACT_SRbol_CuentaPCurCargo"+String:C10($t)+String:C10($bol))
	$var10:=Get pointer:C304("vtACT_SRbol_CuentaPNivCargo"+String:C10($t)+String:C10($bol))
	$var11:=Get pointer:C304("vtACT_SRbol_MesCargo"+String:C10($t)+String:C10($bol))
	$var12:=Get pointer:C304("vlACT_SRbol_AñoCargo"+String:C10($t)+String:C10($bol))
	$var13:=Get pointer:C304("vtACT_SRbol_MontoMoneda"+String:C10($t)+String:C10($bol))
	$var14:=Get pointer:C304("vrACT_SRbol_MontoEnUF"+String:C10($t)+String:C10($bol))
	$var15:=Get pointer:C304("vrACT_SRbol_MontoDcto"+String:C10($t)+String:C10($bol))
	$var16:=Get pointer:C304("vtACT_SRbol_CuentaRUT"+String:C10($t)+String:C10($bol))
	$var17:=Get pointer:C304("vtACT_SRbol_AñoCargo"+String:C10($t)+String:C10($bol))
	
	$var18:=Get pointer:C304("vbACT_SRbol_Afecto"+String:C10($t)+String:C10($bol))
	$var20:=Get pointer:C304("vtACT_SRbol_unidadCargo"+String:C10($t)+String:C10($bol))
	
	$var1->:=atACT_CGlosaImpresion{$pos}
	$var2->:=arACT_MontoPagado{$pos}
	$var3->:=atACT_CAlumno{$pos}
	$var4->:=arACT_Cantidad{$pos}
	$var5->:=arACT_Unitario{$pos}
	$var6->:=False:C215
	$var7->:=atACT_CAlumnoCurso{$pos}
	$var8->:=atACT_CAlumnoNivelNombre{$pos}
	$var9->:=atACT_CAlumnoPCurso{$pos}
	$var10->:=atACT_CAlumnoPNivelNombre{$pos}
	$var11->:=atACT_MesCargo{$pos}
	$var12->:=alACT_AñoCargo{$pos}
	$var13->:=atACT_MonedaSimbolo{$pos}
	If ($valorUf>0)
		$var14->:=Round:C94(arACT_MontoPagado{$pos}/$valorUf;2)
	Else 
		$var14->:=0
	End if 
	$var15->:=arACT_CTotalDesctos{$pos}
	$var16->:=atACT_CAlumnoRUT{$pos}
	$var17->:=atACT_AñoCargo{$pos}
	
	$var18->:=(arACT_TasaIVA{$pos}>0)
	
	  //$var19->:=
	$var20->:=atACT_unidadCargo{$i}
	
	$pos:=$pos+1
	$t:=$t+1
End for 
If (Size of array:C274(atACT_CGlosaImpresion)>$vl_lineas)
	$var1:=Get pointer:C304("vtACT_SRbol_DetalleCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var2:=Get pointer:C304("vrACT_SRbol_MontoCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var3:=Get pointer:C304("vtACT_SRbol_CuentaCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var4:=Get pointer:C304("vrACT_SRbol_CantidadCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var5:=Get pointer:C304("vrACT_SRbol_UnitarioCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var6:=Get pointer:C304("vbACT_HideMonto"+String:C10($vl_lineas)+String:C10($bol))
	$var7:=Get pointer:C304("vtACT_SRbol_CuentaCurCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var8:=Get pointer:C304("vtACT_SRbol_CuentaNivCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var9:=Get pointer:C304("vtACT_SRbol_CuentaPCurCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var10:=Get pointer:C304("vtACT_SRbol_CuentaPNivCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var11:=Get pointer:C304("vtACT_SRbol_MesCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var12:=Get pointer:C304("vlACT_SRbol_AñoCargo"+String:C10($vl_lineas)+String:C10($bol))
	$var13:=Get pointer:C304("vtACT_SRbol_MontoMoneda"+String:C10($vl_lineas)+String:C10($bol))
	$var14:=Get pointer:C304("vrACT_SRbol_MontoEnUF"+String:C10($vl_lineas)+String:C10($bol))
	$var15:=Get pointer:C304("vrACT_SRbol_MontoDcto"+String:C10($vl_lineas)+String:C10($bol))
	$var16:=Get pointer:C304("vtACT_SRbol_CuentaRUT"+String:C10($vl_lineas)+String:C10($bol))
	$var17:=Get pointer:C304("vtACT_SRbol_AñoCargo"+String:C10($vl_lineas)+String:C10($bol))
	
	$var1->:="Otros"
	$var2->:=arACT_MontoPagado{$vl_lineas}
	$var3->:=""
	$var4->:=0
	$var5->:=0
	$var6->:=False:C215
	$var7->:=""
	$var8->:=""
	$var9->:=""
	$var10->:=""
	$var11->:=""
	$var12->:=0
	$var13->:=""
	
	$var15->:=0
	$var16->:=""
	$var17->:=""
	
	
	
	For ($t;$pos;Size of array:C274(atACT_CGlosaImpresion))
		$var2->:=$var2->+arACT_MontoPagado{$t}
	End for 
	If ($valorUf>0)
		$var14->:=Round:C94($var2->/$valorUf;2)
	Else 
		$var14->:=0
	End if 
End if 

SRACTbol_CargaPagos ($idBoleta;$bol)

  //AT_Initialize (->alACT_RecNumsCargosT;->atACT_RecNumsCargosCat;->atACT_RecNumsCargosAgr;->atACT_RecNumsCargosT)
AT_Initialize (->alACT_RecNumsCargosT;->atACT_RecNumsCargosCat;->atACT_RecNumsCargosAgr)
CLEAR SET:C117("Transacciones")
