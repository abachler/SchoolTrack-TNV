//%attributes = {}
  // MÉTODO: STR_ReadGlobals
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 12/03/12, 15:53:07
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // STR_ReadGlobals()
  // ----------------------------------------------------



  // CODIGO PRINCIPAL
MESSAGES OFF:C175



ST_LoadModuleFormatExceptions 


  // datos del colegio
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
<>gCustom:=[Colegio:31]Nombre_Colegio:1
<>gtOrganisation_Name:=[Colegio:31]Nombre_Colegio:1
<>gInstitucion:=0
<>gRector:=[Colegio:31]Director_NombreCompleto:13
<>gDireccion:=[Colegio:31]Dirección:3
<>gComuna:=[Colegio:31]Comuna:4
<>gProvincia:=[Colegio:31]Provincia:5
<>gRegion:=[Colegio:31]Region:14
<>gCiudad:=[Colegio:31]Ciudad:6
<>gPais:=[Colegio:31]Pais:21
<>gRolBD:=[Colegio:31]Rol Base Datos:9
<>gDecEval:=[Colegio:31]Dec Eval Prom:10
<>gDecCoop:=[Colegio:31]MINEDUC_NoResolReconocimiento:12+" del "+String:C10([Colegio:31]MINEDUC_FechaReconocimiento:15;7)
<>gPlanEst:=[Colegio:31]Dec Plan Estud:11
<>gRut:=[Colegio:31]RUT:2
<>gCountryCode:=[Colegio:31]Codigo_Pais:31
<>gNumEstablecimiento:=ST_GetWord ([Colegio:31]MINEDUC_CodigoEstablecimiento:33;2;"-")
<>gletraEstablecimiento:=ST_GetWord ([Colegio:31]MINEDUC_CodigoEstablecimiento:33;1;"-")
<>gDirProvincial:=[Colegio:31]MINEDUC_CodigoDirProvincial:29
<>gDerechosEscolares:=[Colegio:31]MINEDUC_DerechosEscolares:30
<>gCodigoEnseñanza:=[Colegio:31]MINEDUC_CodigoEnsenanza:32
<>gRepLegalNombre:=[Colegio:31]RepresentanteLegal_Nombre:39
<>gRepLegalRUT:=[Colegio:31]RepresentanteLegal_RUN:40
<>gGiro:=[Colegio:31]Giro:48
<>gUUID:=[Colegio:31]UUID:58
<>gMacAddressServidorOficial:=[Colegio:31]MacAddress_ServidorOficial:59


  //para ACT
<>vsACT_Direccion:=[Colegio:31]Administracion_Direccion:41
<>vsACT_Comuna:=[Colegio:31]Administracion_Comuna:42
<>vsACT_Ciudad:=[Colegio:31]Administracion_Ciudad:43
<>vsACT_CPostal:=[Colegio:31]Administracion_CPostal:44
<>vsACT_Telefono:=[Colegio:31]Administracion_Telefono:45
<>vsACT_Fax:=[Colegio:31]Administracion_Fax:46
<>vsACT_Email:=[Colegio:31]Administracion_EMail:47
<>vsACT_RepLegal:=[Colegio:31]RepresentanteLegal_Nombre:39
<>vsACT_RUTRepLegal:=[Colegio:31]RepresentanteLegal_RUN:40
<>vsACT_RazonSocial:=[Colegio:31]RazonSocial:38
<>vsACT_RUT:=[Colegio:31]RUT:2
<>vPict_Logo:=[Colegio:31]Logo:37
<>vsACT_Giro:=[Colegio:31]Giro:48

  //20121219 RCH En un colegio de MX habian 2 registros de colegio. Uno con la moneda peso mexicano y otro con moneda pedo chileno
  //20130409 ASM se descomentan para que siempre se lea la moneda configurada por el colegio
  //20160510 RCH Se lee moneda preferentemente desde tabla monedas
  //<>vsACT_MonedaColegio:=ST_GetWord ([Colegio]Moneda;1;";")
  //<>vsACT_simbMonColegio:=ST_GetWord ([Colegio]Moneda;2;";")
  //20130409 ASM se comentan estas lineas porque siempre se debe leer la moneda del colegio.
  //<>vsACT_MonedaColegio:=ST_GetWord (ACT_DivisaPais ;1;";")
  //<>vsACT_simbMonColegio:=ST_GetWord (ACT_DivisaPais ;2;";")
ACT_LeeMoneda 

LOC_LoadList2Blob ("ACT_TramosIngreso";->xBlob)  //Tramos de ingreso AccountTrack
xBlob:=PREF_fGetBlob (0;"ACT_TramosIngreso";xBlob)
hl_TramosIngreso:=BLOB to list:C557(xBlob)

viACT_ACTDecideApoderado:=Num:C11(PREF_fGet (0;"ACT_DecideApoderado";"0"))

ACTcfg_LeeDecimalMonedaPais 





  // Preferencias en tabla [xxSTR_Constants]
READ ONLY:C145([xxSTR_Constants:1])
ALL RECORDS:C47([xxSTR_Constants:1])
FIRST RECORD:C50([xxSTR_Constants:1])
<>gYear:=[xxSTR_Constants:1]Año:8
<>gNombreAgnoEscolar:=[xxSTR_Constants:1]NombreEjercicio:29
<>gGroupAL:=[xxSTR_Constants:1]Grupo AL_FL:24
<>gAutoGroup:=[xxSTR_Constants:1]AutoAsigGrupo:25
<>gAutoFormat:=(Num:C11(PREF_fGet (0;"XS_FormatNames";"1"))=1)
<>gOrdenNta:=[xxSTR_Constants:1]OrdenNtas:26
<>icrtfYear:=<>gYear

  // indicadores para evaluacion valórica
_O_ARRAY STRING:C218(60;<>aValores;6)
_O_ARRAY STRING:C218(2;<>aEscalaV;4)
_O_ARRAY STRING:C218(60;<>aVIndic;4)
_O_ARRAY STRING:C218(3;<>aAbrevVal;6)
C_TEXT:C284(<>sEvalExpl;<>sEvalExpl1)
BLOB_Blob2Vars (->[xxSTR_Constants:1]xIndicadoresEvValorica:37;0;-><>aValores;-><>aEscalaV;-><>aVIndic;-><>aAbrevVal;-><>sEvalExpl;-><>sEvalExpl1;-><>cb_EvalLibre)

  // indicadores para evaluacion de actividades extra programáticas
C_TEXT:C284(<>sXcrExpl1)
C_TEXT:C284(<>sXcrExpl2)
_O_ARRAY STRING:C218(60;<>aXCRCcept;6)
_O_ARRAY STRING:C218(3;<>aXCRAbrv;6)
_O_ARRAY STRING:C218(60;<>aXCRInd;4)
_O_ARRAY STRING:C218(2;<>aXCRAbrvInd;4)
BLOB_Blob2Vars (->[xxSTR_Constants:1]xIndicadoresEvExtra:39;0;-><>aXCRCcept;-><>aXCRAbrv;-><>aXCRInd;-><>aXCRAbrvInd;-><>sXCRExpl1;-><>sXCRExpl2)

UNLOAD RECORD:C212([xxSTR_Constants:1])
READ ONLY:C145([xxSTR_Constants:1])




  // años cerrados
ARRAY INTEGER:C220(<>aYears;0)
ALL RECORDS:C47([xxSTR_DatosDeCierre:24])
SELECTION TO ARRAY:C260([xxSTR_DatosDeCierre:24]Year:1;<>aYears)
SORT ARRAY:C229(<>aYears;>)
APPEND TO ARRAY:C911(<>aYears;<>gYear)



  //lectura de períodos y calendario
If (Records in table:C83([xxSTR_Periodos:100])>0)
	PERIODOS_Init 
	PERIODOS_LoadData (0;-1)
	<>lXS_DiasHabiles_a_la_Fecha:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;Current date:C33(*))
	<>lXS_DiasHabiles_Agno:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
	If (Current date:C33(*)>vdSTR_Periodos_FinEjercicio)
		<>lXS_DiasHabiles_a_la_Fecha:=viSTR_Periodos_DiasAgno
	End if 
Else 
	<>lXS_DiasHabiles_a_la_Fecha:=0
	<>lXS_DiasHabiles_Agno:=0
End if 







<>gAllowMultipleLates:=Num:C11(PREF_fGet (0;"AllowMultipleLates";"0"))
<>viSTR_AsignarComunaDefecto:=Num:C11(PREF_fGet (0;"ComunaPorDefecto";"1"))
<>vlSTR_UsarSoloUnApellido:=Num:C11(PREF_fGet (0;"Family1Lastname";"0"))
<>viSTR_NoModificarNotas:=Num:C11(PREF_fGet (0;"NoModificarNotas";"0"))
<>viSTR_UtilizarObservaciones:=Num:C11(PREF_fGet (0;"UtilizarListasObservaciones";"0"))
<>viSTR_AutorizarPropEval:=Num:C11(PREF_fGet (0;"PermitirConfigPropEval";"0"))
<>viSTR_FirmantesAutorizados:=Num:C11(PREF_fGet (0;"FirmantesAutorizados";"1"))
<>viSTR_AutoLoadPictures:=Num:C11(PREF_fGet (0;"AutoLoadPictures";"0"))
<>viSTR_ReligionExtendida:=Num:C11(PREF_fGet (0;"ReligionExtendida";"0"))
  //<>viSTR_AgruparPorSexo:=Num(PREF_fGet (0;"◊viSTR_AgruparPorSexo";"0")) // 20181008 Patricio Aliaga Ticket N° 204363
<>viSTR_UD_NombresComun_Oficial:=Num:C11(PREF_fGet (0;"creaNombreAlumnoAutomatico";"0"))
  //mono reemplaza inasistencia con atraso
<>viSTR_CambiaInasistenciaxAtraso:=Num:C11(PREF_fGet (0;"CambiaInasistenciaPorAtraso";"0"))
<>viSTR_puedeBloquearDiasCalendar:=Num:C11(PREF_fGet (0;"bloquearDiasCalendarioCurso";"0"))
<>viSTR_ColegioUsaDiap:=Num:C11(PREF_fGet (0;"ColegioUsaDiap";"0"))
<>viSTR_ForzarMotivoRetiro:=Num:C11(PREF_fGet (0;"forzarMotivoRetiro";"0"))

  //MONO Ticket 171875
<>d_FechaLimiteParaEventosAsig:=Date:C102(PREF_fGet (0;"BloquearEventosAsigHasta";"00-00-00"))

ARRAY TEXT:C222(<>aT_ParametrosReplicas;0)