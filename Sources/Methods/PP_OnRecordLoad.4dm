//%attributes = {}
  // MÉTODO: PP_OnRecordLoad
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/03/12, 12:27:19
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // PP_OnRecordLoad()
  // ----------------------------------------------------
C_BOOLEAN:C305($b_soloLectura)
C_LONGINT:C283($l_elemento;$i;$l_HL_modosDePago;$l_modoDePago;$l_recNumAlumno;$l_recNumCuenta;$l_recNumFamilia;$l_registros;$size2)

ARRAY INTEGER:C220($al_esApoderadoDeCuenta;0)
ARRAY LONGINT:C221($al_ACTtercerosRN;0)
ARRAY LONGINT:C221($al_IdFamilia;0)
ARRAY TEXT:C222($at_cursoAlumnos;0)
ARRAY TEXT:C222($at_nombreAlumnos;0)
C_LONGINT:C283(vlACT_PagePersonas)
C_REAL:C285(vrACT_Total_Proyectado;vrACT_Total_Emitido;vrACT_Deuda_Vencida;vrACT_Total_Pagado;vrACT_Total_Saldo)

  //C_BOOLEAN(campopropio)
  //campopropio:=False
  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
vb_guardarCambios:=False:C215

  // CODIGO PRINCIPAL
If (Is new record:C668([Personas:7]))
	If (<>vlSTR_UsarSoloUnApellido=1)
		OBJECT SET ENTERABLE:C238(*;"Field21";False:C215)
	Else 
		OBJECT SET ENTERABLE:C238(*;"Field21";True:C214)
	End if 
	If (<>viSTR_AsignarComunaDefecto=1)
		[Personas:7]Comuna:16:=<>gComuna
	End if 
	SET WINDOW TITLE:C213(__ ("Nuevo apoderado"))
Else 
	OBJECT SET ENTERABLE:C238(*;"Field21";True:C214)
	SET WINDOW TITLE:C213(__ ("Apoderados: ")+[Personas:7]Apellidos_y_nombres:30)
End if 
ACTpp_FormArraysDeclarations 
AT_Initialize (->aUFItmName;->aUFItmVal)
UFLD_LoadFileTplt (->[Personas:7])
If ([Personas:7]No:1=0)
	[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
	[Personas:7]Nacionalidad:7:=LOC_GetNacionalidad 
	[Personas:7]Ciudad:17:=<>gCiudad
Else 
	GOTO OBJECT:C206([Personas:7]Nombres:2)
End if 

UFLD_LoadFields (->[Personas:7];->[Personas:7]Userfields:31;->[Personas]Userfields'Value;->xAL_PPUF)

  // relaciones con alumnos
$l_recNumFamilia:=-1
$l_recNumAlumno:=-1
$l_recNumCuenta:=-1

vbACT_CambioModoPago:=False:C215

QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)

If (Record number:C243([Familia:78])>=0)
	$l_recNumFamilia:=Record number:C243([Familia:78])
	If ([Personas:7]Direccion:14="")
		If ([Familia:78]Dirección:7#"")
			[Personas:7]Direccion:14:=[Familia:78]Dirección:7
			[Personas:7]Comuna:16:=[Familia:78]Comuna:8
			[Personas:7]Ciudad:17:=[Familia:78]Ciudad:9
			[Personas:7]Codigo_postal:15:=[Familia:78]Codigo_postal:19
		End if 
	End if 
	If ([Personas:7]Telefono_domicilio:19="")
		If ([Familia:78]Telefono:10#"")
			[Personas:7]Telefono_domicilio:19:=[Familia:78]Telefono:10
		End if 
	End if 
	If ([Personas:7]Fax:35="")
		If ([Familia:78]Fax:20#"")
			[Personas:7]Fax:35:=[Familia:78]Fax:20
		End if 
	End if 
End if 
If (Record number:C243([Alumnos:2])>=0)
	$l_recNumAlumno:=Record number:C243([Alumnos:2])
End if 
If (Record number:C243([ACT_CuentasCorrientes:175])>=0)
	$l_recNumCuenta:=Record number:C243([ACT_CuentasCorrientes:175])
	$b_soloLectura:=Read only state:C362([ACT_CuentasCorrientes:175])
End if 

QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1;*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29>=Nivel_AdmissionTrack;*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<Nivel_Egresados)
ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;atPP_NombresAlumnos;[Alumnos:2]curso:20;atPP_CursoAlumnos)
ARRAY TEXT:C222(atPP_TipoApdoAlumnos;Size of array:C274(atPP_NombresAlumnos))
For ($i;1;Size of array:C274(atPP_NombresAlumnos))
	atPP_TipoApdoAlumnos{$i}:="Académico de"
End for 

QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1;*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29>=Nivel_AdmissionTrack;*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<Nivel_Egresados)
ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_nombreAlumnos;[Alumnos:2]curso:20;$at_cursoAlumnos)

For ($i;1;Size of array:C274($at_nombreAlumnos))
	$l_elemento:=Find in array:C230(atPP_NombresAlumnos;$at_nombreAlumnos{$i})
	If ($l_elemento>0)
		atPP_TipoApdoAlumnos{$l_elemento}:="General de"
	Else 
		APPEND TO ARRAY:C911(atPP_NombresAlumnos;$at_nombreAlumnos{$i})
		APPEND TO ARRAY:C911(atPP_CursoAlumnos;$at_cursoAlumnos{$i})
		APPEND TO ARRAY:C911(atPP_TipoApdoAlumnos;"De cuentas de")
	End if 
End for 
If ($l_recNumAlumno>=0)
	GOTO RECORD:C242([Alumnos:2];$l_recNumAlumno)
End if 

  // relaciones con familias
READ WRITE:C146([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Familia:78])
QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Familia:2;$al_IdFamilia;[Familia_RelacionesFamiliares:77]Parentesco:6;atPP_ParentescoFamilias)
ARRAY TEXT:C222(atPP_NombresFamilias;Size of array:C274($al_IdFamilia))
ARRAY TEXT:C222(atACT_NombreFam;Size of array:C274($al_IdFamilia))
ARRAY TEXT:C222(atACT_CodigoFam;Size of array:C274($al_IdFamilia))
For ($i;1;Size of array:C274($al_IdFamilia))
	QUERY:C277([Familia:78];[Familia:78]Numero:1=$al_IdFamilia{$i})
	If ($i=1)
		If ([Personas:7]Direccion:14="")
			If ([Familia:78]Dirección:7#"")
				[Personas:7]Direccion:14:=[Familia:78]Dirección:7
				[Personas:7]Comuna:16:=[Familia:78]Comuna:8
				[Personas:7]Ciudad:17:=[Familia:78]Ciudad:9
				[Personas:7]Codigo_postal:15:=[Familia:78]Codigo_postal:19
			End if 
		End if 
		If ([Personas:7]Telefono_domicilio:19="")
			If ([Familia:78]Telefono:10#"")
				[Personas:7]Telefono_domicilio:19:=[Familia:78]Telefono:10
			End if 
		End if 
		If ([Personas:7]Fax:35="")
			If ([Familia:78]Fax:20#"")
				[Personas:7]Fax:35:=[Familia:78]Fax:20
			End if 
		End if 
	End if 
	atPP_NombresFamilias{$i}:=[Familia:78]Nombre_de_la_familia:3
	atACT_NombreFam{$i}:=[Familia:78]Nombre_de_la_familia:3
	atACT_CodigoFam{$i}:=[Familia:78]Codigo_interno:14
End for 

If ($l_recNumFamilia>=0)
	GOTO RECORD:C242([Familia:78];$l_recNumFamilia)
End if 
OBJECT SET VISIBLE:C603(*;"muerte@";[Personas:7]Fallecido:88)
IT_SetEnterable (Not:C34([Personas:7]Fallecido:88);0;->[Personas:7]Inactivo:46)
Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		  //20140611 RCH No se cargaba correctamente la educación anterior. Quito el código de la pestaña y lo dejo acá.
		AL_UpdateArrays (xALP_EducAntSTR;0)
		ADTpp_FormArrayDeclarations (1)
		READ ONLY:C145([STR_EducacionAnterior:87])
		QUERY:C277([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]ID_Persona:6=[Personas:7]No:1;*)
		QUERY:C277([STR_EducacionAnterior:87]; & [STR_EducacionAnterior:87]Tipo_Persona:8="pe")
		SELECTION TO ARRAY:C260([STR_EducacionAnterior:87]Año:4;aiAno;[STR_EducacionAnterior:87]Nombre_Colegio:1;atInstitucion;[STR_EducacionAnterior:87]Tipo_Institucion:10;atTipoInstitucion;[STR_EducacionAnterior:87]Nivel:3;atGradoONivel;[STR_EducacionAnterior:87]País:2;atPaisEducacion;[STR_EducacionAnterior:87]ID_EducacionAnterior:9;IDEducacionAnterior)
		AL_UpdateArrays (xALP_EducAntSTR;-2)
		
	: (vsBWR_CurrentModule="AccountTrack")
		If ([Personas:7]ACT_TramoIngresos:66#"")
			<>atACT_TramosIngreso:=Find in array:C230(<>atACT_TramosIngreso;[Personas:7]ACT_TramoIngresos:66)
		Else 
			<>atACT_TramosIngreso:=0
		End if 
		AL_UpdateArrays (xALP_FamsApdo;-2)
		If (vlACT_PagePersonas=0)
			vlACT_PagePersonas:=1
		End if 
		
		SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_personas;vlACT_PagePersonas)
		FORM GOTO PAGE:C247(vlACT_PagePersonas)
		$l_HL_modosDePago:=LOC_LoadList ("ACT_Modo_de_Pago")
		If ([Personas:7]ACT_Modo_de_pago:39="")
			  //20121005 RCH
			[Personas:7]ACT_Modo_de_pago:39:=ACTcfgfdp_OpcionesGenerales ("fdpXDefecto")
			[Personas:7]ACT_id_modo_de_pago:94:=vl_FormadePagoXDef
			[Personas:7]ACT_modo_de_pago_new:95:=vt_FormadePagoXDef
		End if 
		
		  //20130322 RCH Para cuando haya un modo de pago que no este configurado. No deberia suceder pero sucede.
		If (Size of array:C274(<>atACT_FormasDePago2D{1})>0)
			If (Find in array:C230(<>atACT_FormasDePago2D{1};String:C10([Personas:7]ACT_id_modo_de_pago:94))>0)
				  //20130307 RCH se cargaba en el on load
				vt_ModoDePago:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->[Personas:7]ACT_id_modo_de_pago:94)
			Else 
				vt_ModoDePago:=""
				[Personas:7]ACT_Modo_de_pago:39:=""
				[Personas:7]ACT_id_modo_de_pago:94:=0
				[Personas:7]ACT_modo_de_pago_new:95:=""
			End if 
		End if 
		
		  //$l_modoDePago:=HL_FindElement ($l_HL_modosDePago;[Personas]ACT_Modo_de_pago)
		  //IT_SetEnterable ((($l_modoDePago=2) | ($l_modoDePago=3));0;->[Personas]ACT_DiaCargo)
		  //IT_SetEnterable ($l_modoDePago=4;0;->[Personas]ACT_NoCuotasCup)
		IT_SetEnterable ((([Personas:7]ACT_id_modo_de_pago:94=-9) | ([Personas:7]ACT_id_modo_de_pago:94=-10));0;->[Personas:7]ACT_DiaCargo:61)
		IT_SetEnterable ([Personas:7]ACT_id_modo_de_pago:94=-11;0;->[Personas:7]ACT_NoCuotasCup:80)
		If (Form event:C388=On Load:K2:1)
			SELECT LIST ITEMS BY POSITION:C381(hlTab_ACT_Transacciones;5)
			SELECT LIST ITEMS BY POSITION:C381(HLTAB_ACTpp_Asociados;1)
		End if 
		
		  //20121204 RCH Se llama a metodo...
		ACTpp_CargaCuentasAsociadas 
		
		ACTpp_OnRecordLoad (vlACT_PagePersonas)
		ACTpp_CargaDocTrib 
		
		ACT_SetTotalsColorInputForm (->[Personas:7]Saldo_Ejercicio:85;->[Personas:7]DeudaVencida_Ejercicio:83)
		If ($l_recNumCuenta>=0)
			KRL_ResetPreviousRWMode (->[ACT_CuentasCorrientes:175];$b_soloLectura)
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$l_recNumCuenta)
		End if 
		ACTpp_LabelPACPAT (->[Personas:7]Fecha_de_nacimiento:5;->vIdentPAC;->vIdentPAT)
		Case of 
			: (<>vtXS_CountryCode="cl")
				OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitutal_Cta:50;"###.###.###-#")
				OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitular_TC:56;"###.###.###-#")
			: (<>vtXS_CountryCode="co")
				OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitutal_Cta:50;"")
				OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitular_TC:56;"")
			Else 
				OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitutal_Cta:50;"")
				OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitular_TC:56;"")
		End case 
		ACTpp_CRYPTTC ("onLoad";->vt_noTarjetaC;->[Personas:7]ACT_Numero_TC:54)
		ACTpp_CRYPTTC ("onLoad";->vt_noTarjetaDebito;->[Personas:7]ACT_Numero_TD:104)  //Ticket 116401
		aYearsACT:=1
		KRL_UnloadReadOnly (->[Familia:78])
		KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
		ACTcfg_ArregloDocsTribs (->[Personas:7]ACT_DocumentoTributario:45)
		
		  //Para el area de los terceros
		USE SET:C118("ctasOrigen")
		If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
			READ ONLY:C145([ACT_Terceros_Pactado:139])
			READ ONLY:C145([ACT_Terceros:138])
			KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;->[ACT_CuentasCorrientes:175]ID:1;"")
			KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Terceros_Pactado:139]Id_Tercero:2;"")
			AT_RedimArrays (Records in selection:C76([ACT_Terceros:138]);->aACT_ApdosTercAsocRN;->aACT_ApdosTercAsocNombre;->aACT_ApdosTercAsocRUT)
			AL_UpdateArrays (xALP_TercApdo;0)
			If (Records in selection:C76([ACT_Terceros:138])>0)
				ORDER BY:C49([ACT_Terceros:138];[ACT_Terceros:138]Nombre_Completo:9)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Terceros:138];$al_ACTtercerosRN)
				For ($i;1;Size of array:C274($al_ACTtercerosRN))
					GOTO RECORD:C242([ACT_Terceros:138];$al_ACTtercerosRN{$i})
					aACT_ApdosTercAsocRN{$i}:=$al_ACTtercerosRN{$i}
					aACT_ApdosTercAsocNombre{$i}:=[ACT_Terceros:138]Nombre_Completo:9
					aACT_ApdosTercAsocRUT{$i}:=SR_FormatoRUT2 ([ACT_Terceros:138]RUT:4)
				End for 
			End if 
			If ($l_recNumCuenta>=0)
				KRL_ResetPreviousRWMode (->[ACT_CuentasCorrientes:175];$b_soloLectura)
				GOTO RECORD:C242([ACT_CuentasCorrientes:175];$l_recNumCuenta)
			End if 
			AL_UpdateArrays (xALP_TercApdo;-2)
		End if 
		CLEAR SET:C117("ctasOrigen")
		
		  //20150316 RCH
		ACTbol_ObtieneResponsableFact ("CargaVarDesdeFichaApdo")
		
		  //20171229 RCH
		C_POINTER:C301($y_persona;$y_profesional;$y_otra;$y_ec)
		C_LONGINT:C283($l_valor)
		$y_persona:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_personal")
		$y_profesional:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_profesional")
		$y_otra:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_otra")
		$y_ec:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_ec")
		
		If (OB Is defined:C1231([Personas:7]OB_ACT_Direccion_Facturacion:117;"tipo_direccion_facturacion"))
			$l_valor:=OB Get:C1224([Personas:7]OB_ACT_Direccion_Facturacion:117;"tipo_direccion_facturacion";Is longint:K8:6)
		End if 
		
		$y_persona->:=Num:C11(($l_valor=0) | ($l_valor ?? 1))
		$y_profesional->:=Num:C11($l_valor ?? 2)
		$y_ec->:=Num:C11($l_valor ?? 3)
		$y_otra->:=Num:C11($l_valor ?? 4)
End case 

If (<>viSTR_ReligionExtendida=1)
	If ([Personas:7]Religión:9#"")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=[Personas:7]Religión:9)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_registros>0)
			OBJECT SET FONT STYLE:C166(*;"religion";Underline:K14:4)
			OBJECT SET COLOR:C271(*;"religion";-6)
			_O_ENABLE BUTTON:C192(bReligionExt)
		Else 
			OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
			OBJECT SET COLOR:C271(*;"religion";-15)
			_O_DISABLE BUTTON:C193(bReligionExt)
		End if 
	Else 
		OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
		OBJECT SET COLOR:C271(*;"religion";-15)
		_O_DISABLE BUTTON:C193(bReligionExt)
	End if 
Else 
	OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
	OBJECT SET COLOR:C271(*;"religion";-15)
	_O_DISABLE BUTTON:C193(bReligionExt)
End if 

  //opciones según pais
PP_SetIdentificadorPrincipal 
xDOC_AutoLoadPictures (->[Personas:7]Fotografia:43)


