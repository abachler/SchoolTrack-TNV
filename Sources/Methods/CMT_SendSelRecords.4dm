//%attributes = {}
  //CMT_SendSelRecords

C_TEXT:C284($vt_codDB;$vt_idTipoDato;$vt_dts_creacion;$vt_nombreBusqueda;$vt_retorno;$vt_usuarioEmisor)
C_POINTER:C301($ptr2Field)
ARRAY TEXT:C222(atCMT_IdsRegistros;0)
ARRAY LONGINT:C221($al_idsRegistros;0)

C_BOOLEAN:C305($b_Commtrack;$b_Comunicaciones)

$b_Commtrack:=LICENCIA_esModuloAutorizado (1;CommTrack)
$b_Comunicaciones:=LICENCIA_VerificaModCondorAct ("Comunicaciones")

If (($b_Commtrack) | ($b_Comunicaciones))
	
	vt_Prompt:="Por favor ingrese el nombre de esta nueva selección:"
	$vt_nombreBusqueda:=CD_Request (__ ("Usted procederá a enviar los registros listados a CommTrack con el objetivo de crear una selección de destinatarios.");__ ("Aceptar");__ ("Cancelar");__ ("");__ ("Nueva selección de ")+Table name:C256(yBWR_CurrentTable))
	vt_Prompt:=""
	
	If (ok=1)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Profesores:4])
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		
		CREATE SELECTION FROM ARRAY:C640(yBWR_CurrentTable->;alBWR_recordNumber;"")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				$ptr2Field:=->[Alumnos:2]numero:1
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				$ptr2Field:=->[Profesores:4]Numero:1
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				$ptr2Field:=->[Personas:7]No:1
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
				$ptr2Field:=->[Alumnos:2]numero:1
		End case 
		
		SELECTION TO ARRAY:C260($ptr2Field->;$al_idsRegistros)
		For ($i;1;Size of array:C274($al_idsRegistros))
			APPEND TO ARRAY:C911(atCMT_IdsRegistros;String:C10($al_idsRegistros{$i}))
		End for 
		
		$vt_codDB:=<>gCountryCode+"."+<>gRolBD
		$vt_idTipoDato:=String:C10(Table:C252(yBWR_CurrentTable))
		$vt_dts_creacion:=DTS_MakeFromDateTime 
		$vt_usuarioEmisor:=String:C10(<>lUSR_RelatedTableUserID)
		
		  //MONO Ticket 185187
		Case of 
			: ($b_Commtrack)  //habiendo licencia de CT si el colegio tiene también comunicaciones irá de CT a Comunicaciones...
				$vt_retorno:=CMTws_SendSelRecords ($vt_codDB;$vt_idTipoDato;$vt_dts_creacion;$vt_nombreBusqueda;->atCMT_IdsRegistros;$vt_usuarioEmisor)
				
				If ($vt_retorno="")
					CD_Dlog (0;__ ("En este momento no fue posible establecer conexión con CommTrack. Por favor intente más tarde."))
				Else 
					If ($vt_retorno="NO MOSTRAR")
					Else 
						CD_Dlog (0;$vt_retorno)
					End if 
					LOG_RegisterEvt ("Envío de selección de registros a Commtrack realizado.")
				End if 
				
			: ($b_Comunicaciones)
				C_TEXT:C284($key;$llave;$url;$response)
				C_BLOB:C604($llave_utf8)
				ARRAY TEXT:C222($at_httpHeaderNames;0)
				ARRAY TEXT:C222($at_httpHeaderValues;0)
				C_OBJECT:C1216($o_objLlamado)
				
				$key:="f6150b819489bfe46e7da82f43e8b637c087d7ff90b7e25754e192fdd0219750"
				$llave:=$vt_dts_creacion+$key
				CONVERT FROM TEXT:C1011($llave;"utf-8";$llave_utf8)
				$hash:=SHA512 ($llave_utf8;Crypto HEX)
				$id_app:=8  //ST
				
				$o_objLlamado:=OB_Create 
				OB_SET ($o_objLlamado;-><>gCountryCode;"codigo_pais")
				OB_SET ($o_objLlamado;-><>gRolBD;"rol")
				OB_SET ($o_objLlamado;->$vt_idTipoDato;"id_tabla")
				OB_SET ($o_objLlamado;->$vt_dts_creacion;"dts_creacion")
				OB_SET ($o_objLlamado;->$vt_nombreBusqueda;"nombre_busqueda")
				OB_SET ($o_objLlamado;->atCMT_IdsRegistros;"usuarios_receptores")
				OB_SET ($o_objLlamado;->$vt_usuarioEmisor;"usuario_emisor")
				OB_SET ($o_objLlamado;->$hash;"llave")
				OB_SET ($o_objLlamado;->$id_app;"idapp")
				$body_t:=JSON Stringify:C1217($o_objLlamado)
				
				$url:="https://personas.colegium.com/servicios/busquedausuariost/"
				
				APPEND TO ARRAY:C911($at_httpHeaderNames;"content-type")
				APPEND TO ARRAY:C911($at_httpHeaderValues;"application/json")
				$httpStatus_l:=HTTP Request:C1158(HTTP POST method:K71:2;$url;$body_t;$response;$at_httpHeaderNames;$at_httpHeaderValues)
				
				
		End case 
		
		ARRAY TEXT:C222(atCMT_IdsRegistros;0)
		
	End if 
	
Else 
	CD_Dlog (0;__ ("Lo siento, su licencia no le permite ejecutar el módulo CommTrack."))
End if 