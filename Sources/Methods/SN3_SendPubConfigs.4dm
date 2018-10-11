//%attributes = {}
  //SN3_SendPubConfigs
C_REAL:C285($queEnviar;$1)
C_LONGINT:C283($nivel;$2)
C_BLOB:C604($x_data)
READ ONLY:C145([SN3_PublicationPrefs:161])

Case of 
	: (Count parameters:C259=1)
		$queEnviar:=$1
	: (Count parameters:C259=2)
		$queEnviar:=$1
		$nivel:=$2
	Else 
		$queEnviar:=0
End case 

ARRAY TEXT:C222(SN3_NivelesConfig2Send;0)
ARRAY TEXT:C222(SN3_Configs2Send;0)
ARRAY LONGINT:C221($aRNConfigs;0)

Case of 
	: ($queEnviar=0)
		ALL RECORDS:C47([SN3_PublicationPrefs:161])
	: ($queEnviar=1)
		ALL RECORDS:C47([SN3_PublicationPrefs:161])
		QUERY SELECTION:C341([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]DTS_Modificacion:3>[SN3_PublicationPrefs:161]DTS_Envio:4;*)
		QUERY SELECTION:C341([SN3_PublicationPrefs:161]; | ;[SN3_PublicationPrefs:161]DTS_Envio:4="")
	: ($queEnviar=2)
		QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=$nivel)
End case 

LONGINT ARRAY FROM SELECTION:C647([SN3_PublicationPrefs:161];$aRNConfigs;"")

If (Size of array:C274($aRNConfigs)>0)
	
	$go:=False:C215
	If (SN3_CheckNotColegium )
		$go:=True:C214
	Else 
		$r:=CD_Dlog (0;__ ("Al parecer usted está trabajando en Colegium o la versión no está compilada. ¿Desea enviar las configuraciones al servidor de SchoolNet?");__ ("");__ ("No");__ ("Si"))
		$go:=($r=2)
	End if 
	
	If ($go)
		For ($i;1;Size of array:C274($aRNConfigs))
			GOTO RECORD:C242([SN3_PublicationPrefs:161];$aRNConfigs{$i})
			APPEND TO ARRAY:C911(SN3_NivelesConfig2Send;String:C10([SN3_PublicationPrefs:161]Nivel:1))
			BLOB_ExpandBlob_byPointer (->[SN3_PublicationPrefs:161]xData:2)
			
			  //MONO: COMPATIBILIDAD TICKET 209421
			$xmlRef:=DOM Parse XML variable:C720([SN3_PublicationPrefs:161]xData:2)
			
			$i_pubAsist:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/publicar"))
			If ($i_pubAsist=1)
				$i_PubInasistencias:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/inasistencias/publicar"))
				$i_PubAtrasos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/atrasos/publicar"))
				$i_PubAtrasosObs:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/atrasos/observaciones"))
				$i_PubAtrasosInter:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/atrasos/intersesiones"))
				$i_PubPorcentajeAsistencia:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/porcasistencia/publicar"))
				$i_PubFaltasPorAtrasos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/inasistencias/inasistenciaporatrasos"))
			Else 
				$i_PubInasistencias:=0
				$i_PubAtrasos:=0
				$i_PubAtrasosObs:=0
				$i_PubAtrasosInter:=0
				$i_PubPorcentajeAsistencia:=0
				$i_PubFaltasPorAtrasos:=0
			End if 
			
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/inasistencias/publicar";String:C10($i_PubInasistencias))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/atrasos/publicar";String:C10($i_PubAtrasos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/atrasos/observaciones";String:C10($i_PubAtrasosObs))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/atrasos/intersesiones";String:C10($i_PubAtrasosInter))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/porcasistencia/publicar";String:C10($i_PubPorcentajeAsistencia))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/inasistencias/inasistenciaporatrasos";String:C10($i_PubFaltasPorAtrasos))
			
			SET BLOB SIZE:C606($x_data;0)
			DOM EXPORT TO VAR:C863($xmlRef;$x_data)
			DOM CLOSE XML:C722($xmlRef)
			[SN3_PublicationPrefs:161]xData:2:=$x_data
			SET BLOB SIZE:C606($x_data;0)
			  //FIN COMPATIBILIDAD (cuando SN3 lea el nodo de Asistencia hay que eliminar esto)
			
			$xml2text:=BLOB to text:C555([SN3_PublicationPrefs:161]xData:2;Mac text without length:K22:10)
			  //SET TEXT TO PASTEBOARD($xml2text)
			APPEND TO ARRAY:C911(SN3_Configs2Send;$xml2text)
		End for 
		
		  //LLAMADO AL WEBSERVICE
		WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
		WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
		WEB SERVICE SET PARAMETER:C777("niveles";SN3_NivelesConfig2Send)
		WEB SERVICE SET PARAMETER:C777("datos";SN3_Configs2Send)
		$p:=IT_UThermometer (1;0;__ ("Enviando configuraciones de publicación a SchoolNet..."))
		$err:=SN3_CallWebService ("sn3ws_configuracionesPub_proceso.configura")
		IT_UThermometer (-2;$p)
		If ($err="")
			$error:=False:C215
			ARRAY TEXT:C222($resultados;0)
			WEB SERVICE GET RESULT:C779($resultados;"resultados";*)
			For ($i;1;Size of array:C274($resultados))
				If ($resultados{$i}="0")
					READ WRITE:C146([SN3_PublicationPrefs:161])
					QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=Num:C11(SN3_NivelesConfig2Send{$i}))
					[SN3_PublicationPrefs:161]DTS_Envio:4:=DTS_MakeFromDateTime 
					SAVE RECORD:C53([SN3_PublicationPrefs:161])
					KRL_UnloadReadOnly (->[SN3_PublicationPrefs:161])
				Else 
					$error:=True:C214
				End if 
			End for 
			If ($error)
				CD_Dlog (0;__ ("Se ha producido un error al almacenar algunas de las configuraciones de publicación en SchoolNet. Por favor intente otra vez más tarde."))
				SN3_RegisterLogEntry (SN3_Log_Error;"Algunas configuraciones de publicación no pudieron ser almacenadas en SchoolNet.";-1)
			Else 
				SN3_RegisterLogEntry (SN3_Log_Info;"Configuraciones de publicacón almacenadas correctamente.")
			End if 
		Else 
			CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
			SN3_RegisterLogEntry (SN3_Log_Error;"No se pudo establecer la conexión con SchoolNet.";-1;$err)
		End if 
	End if 
	
	ARRAY TEXT:C222(SN3_NivelesConfig2Send;0)
	ARRAY TEXT:C222(SN3_Configs2Send;0)
	ARRAY LONGINT:C221($aRNConfigs;0)
	
End if 
