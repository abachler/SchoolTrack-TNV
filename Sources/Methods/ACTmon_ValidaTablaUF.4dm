//%attributes = {}
  // Método: ACTmon_ValidaTablaUF
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 10-03-10, 19:13:38
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal



  //ACTmon_ValidaTablaUF

  //crea tabla de UF para el año actual si esta no existe
C_DATE:C307($vd_fecha)
C_TEXT:C284($key)
C_LONGINT:C283($recNum)
C_BOOLEAN:C305($vb_noActualizarTabla)
C_REAL:C285($vr_nuevoValor)

If (<>gCountryCode="cl")
	$vd_fecha:=Add to date:C393(Current date:C33(*);0;1;0)
	$key:="ACT_UF/"+String:C10(Year of:C25($vd_fecha))+"/"+String:C10(Month of:C24($vd_fecha);"00")
	$recNum:=Find in field:C653([xShell_Prefs:46]Reference:1;$key)
	If ($recNum=-1)
		  //ACTcfg_OpenYear (Year of($vd_fecha))
		ACTinit_CreateUFTables 
		LOG_RegisterEvt ("Apertura de año para UF terminado.")
		FLUSH CACHE:C297
	End if 
End if 

  //Guarda en tabla Monedas posibles valores de xxact monedas
$vd_fecha:=Current date:C33(*)
ARRAY LONGINT:C221($al_RecNumMonedas;0)
READ ONLY:C145([xxACT_Monedas:146])
QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Genera_Tabla_Diaria:7=True:C214;*)
QUERY:C277([xxACT_Monedas:146]; & ;[xxACT_Monedas:146]Codigo_Pais:6=<>gCountryCode)
LONGINT ARRAY FROM SELECTION:C647([xxACT_Monedas:146];$al_RecNumMonedas;"")
For ($i;1;Size of array:C274($al_RecNumMonedas))
	GOTO RECORD:C242([xxACT_Monedas:146];$al_RecNumMonedas{$i})
	$vr_nuevoValor:=ACTut_fValorDivisa ([xxACT_Monedas:146]Nombre_Moneda:2;$vd_fecha)
	$vb_noActualizarTabla:=True:C214
	ACTcfgmyt_OpcionesGenerales ("ModificaValor";->[xxACT_Monedas:146]Id_Moneda:1;->$vr_nuevoValor;->$vb_noActualizarTabla)
End for 
LOG_RegisterEvt ("Actualización valor moneda de referencia terminado.")
