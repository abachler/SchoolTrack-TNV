//%attributes = {}
C_LONGINT:C283($mode;$nivel;$1;$2)

$mode:=$1
If (Count parameters:C259=2)
	$nivel:=$2
End if 

ARRAY TEXT:C222(SN3_DataReceptionConfs;0)
ARRAY LONGINT:C221(SN3_DataReceptionLevels;0)
C_TEXT:C284(SN3_DataReceptionGeneralConf)

Case of 
	: ($mode=0)
		SN3_LoadDataReceptionSettings 
		$conf:=SN3_DataReceptionConf2XML (0)
		CLEAR PASTEBOARD:C402
		SET TEXT TO PASTEBOARD:C523($conf)
		SN3_DataReceptionGeneralConf:=$conf
		vb_ConfigModificado:=False:C215
	: ($mode=1)
		SN3_LoadDataReceptionSettings ($nivel)
		$conf:=SN3_DataReceptionConf2XML (1)
		APPEND TO ARRAY:C911(SN3_DataReceptionConfs;$conf)
		CLEAR PASTEBOARD:C402
		SET TEXT TO PASTEBOARD:C523($conf)
		APPEND TO ARRAY:C911(SN3_DataReceptionLevels;$nivel)
		ab_NivelModificado{aiADT_NivNo}:=False:C215
	: ($mode=2)
		For ($i;1;Size of array:C274(aiADT_NivNo))
			SN3_LoadDataReceptionSettings (aiADT_NivNo{$i})
			$conf:=SN3_DataReceptionConf2XML (1)
			APPEND TO ARRAY:C911(SN3_DataReceptionConfs;$conf)
			APPEND TO ARRAY:C911(SN3_DataReceptionLevels;aiADT_NivNo{$i})
			ab_NivelModificado{$i}:=False:C215
		End for 
	: ($mode=3)
		For ($i;1;Size of array:C274(aiADT_NivNo))
			If (ab_NivelModificado{$i})
				SN3_LoadDataReceptionSettings (aiADT_NivNo{$i})
				$conf:=SN3_DataReceptionConf2XML (1)
				APPEND TO ARRAY:C911(SN3_DataReceptionConfs;$conf)
				APPEND TO ARRAY:C911(SN3_DataReceptionLevels;aiADT_NivNo{$i})
				ab_NivelModificado{$i}:=False:C215
			End if 
		End for 
End case 

$go:=False:C215
If (SN3_CheckNotColegium )
	$go:=True:C214
Else 
	$r:=CD_Dlog (0;__ ("Al parecer usted está trabajando en Colegium o la versión no está compilada. ¿Desea enviar las configuraciones al servidor de SchoolNet?");__ ("");__ ("No");__ ("Si"))
	$go:=($r=2)
End if 
If ($go)
	$ccode:=<>vtXS_CountryCode
	$rol:=<>gRolBD
	
	$p:=IT_UThermometer (1;0;__ ("Enviando configuraciones de recepción de datos  a SchoolNet..."))
	
	WEB SERVICE SET PARAMETER:C777("rolbd";$rol)
	WEB SERVICE SET PARAMETER:C777("codpais";$ccode)
	
	If ($mode=0)
		WEB SERVICE SET PARAMETER:C777("datos";SN3_DataReceptionGeneralConf)
		$ws:="sn3ws_ActualizacionDatos_proceso.configura_general"
	Else 
		WEB SERVICE SET PARAMETER:C777("niveles";SN3_DataReceptionLevels)
		WEB SERVICE SET PARAMETER:C777("datos";SN3_DataReceptionConfs)
		$ws:="sn3ws_ActualizacionDatos_proceso.configura_nivel"
	End if 
	
	$err:=SN3_CallWebService ($ws)
	
	IT_UThermometer (-2;$p)
	If ($err="")
		$error:=False:C215
		C_TEXT:C284($resultados)
		WEB SERVICE GET RESULT:C779($resultados;"resultado";*)
		
		If ($resultados#"0")
			$error:=True:C214
		End if 
		
		If ($error)
			CD_Dlog (0;__ ("Se ha producido un error al almacenar algunas de las configuraciones de recepción de datos en SchoolNet. Por favor intente otra vez más tarde."))
			SN3_RegisterLogEntry (SN3_Log_Error;"Algunas configuraciones de recepción de datos no pudieron ser almacenadas en SchoolNet.";-1)
		Else 
			SN3_RegisterLogEntry (SN3_Log_Info;"Configuraciones de recepción de datos almacenadas correctamente.")
			
			Case of 
				: ($mode=1)
					$fia:=Find in array:C230(aiADT_NivNo;$nivel)
					ab_NivelModificado{$fia}:=False:C215
				: ($mode=2)
					vb_Gral_CFG_Mod:=False:C215
				: ($mode=3)
					$cambios:=False:C215
					AT_Populate (->ab_NivelModificado;->$cambios)
					vb_Gral_CFG_Mod:=False:C215
			End case 
			
		End if 
	Else 
		CLEAR PASTEBOARD:C402
		SET TEXT TO PASTEBOARD:C523($err)
		CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
		SN3_RegisterLogEntry (SN3_Log_Error;"No se pudo establecer la conexión con SchoolNet.";-1;$err)
	End if 
End if 
  //End if 
ARRAY TEXT:C222(SN3_DataReceptionConfs;0)
ARRAY LONGINT:C221(SN3_DataReceptionLevels;0)