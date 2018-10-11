//%attributes = {}
  //ACTepr_OpcionesGenerales

C_BLOB:C604($xBlob)
C_POINTER:C301($y_puntero;$y_puntero2)
C_TEXT:C284($t_accion)
$t_accion:=$1
Case of 
	: (Count parameters:C259=2)
		$y_puntero:=$2
	: (Count parameters:C259=3)
		$y_puntero:=$2
		$y_puntero2:=$3
	: (Count parameters:C259=4)
		$y_puntero:=$2
		$y_puntero2:=$3
		vr_MontoRechazado:=$4->
End case 

Case of 
	: ($t_accion="DeclaraVariables")
		C_TEXT:C284(vtACTepr_Asunto;vtACTepr_ResponderA;vtACTepr_CopiaOculta;vtACTepr_Cuerpo)
		C_REAL:C285(vr_MontoRechazado)
		ARRAY TEXT:C222(atACTepr_Palabra;0)
		ARRAY TEXT:C222(atACTepr_Descripción;0)
		ARRAY TEXT:C222(atACTepr_ApoderadoNombre;0)
		ARRAY TEXT:C222(atACTepr_ApoderadoModoPago;0)
		ARRAY TEXT:C222(atACTepr_EmailApoderado;0)
		ARRAY REAL:C219(arACTepr_ApoderadoMontoRechaza;0)
		ARRAY POINTER:C280(ayACTepr_Punteros;0)
		ARRAY BOOLEAN:C223(abACTepr_Enviar;0)
		ARRAY LONGINT:C221(alACTepr_ApoderadoID;0)
		vtACTepr_Cuerpo:=""
		vtACTepr_CopiaOculta:=""
		vtACTepr_ResponderA:=""
		vtACTepr_Asunto:=""
		vr_MontoRechazado:=0
		
	: ($t_accion="InicializaVariables")
		
		vtACTepr_Asunto:="Pago automático rechazado"
		
		APPEND TO ARRAY:C911(atACTepr_Palabra;"Colegio_nombre")
		APPEND TO ARRAY:C911(atACTepr_Descripción;"Nombre del Colegio")
		APPEND TO ARRAY:C911(ayACTepr_Punteros;-><>gCustom)
		
		APPEND TO ARRAY:C911(atACTepr_Palabra;"Apoderado_Apellidos_y_Nombres")
		APPEND TO ARRAY:C911(atACTepr_Descripción;"Apellidos y Nombres del Apoderado")
		APPEND TO ARRAY:C911(ayACTepr_Punteros;->[Personas:7]Apellidos_y_nombres:30)
		
		APPEND TO ARRAY:C911(atACTepr_Palabra;"Apoderado_apellido_paterno")
		APPEND TO ARRAY:C911(atACTepr_Descripción;"Apellido Paterno del Apoderado")
		APPEND TO ARRAY:C911(ayACTepr_Punteros;->[Personas:7]Apellido_paterno:3)
		
		APPEND TO ARRAY:C911(atACTepr_Palabra;"Apoderado_apellido_materno")
		APPEND TO ARRAY:C911(atACTepr_Descripción;"Apellido Materno del Apoderado")
		APPEND TO ARRAY:C911(ayACTepr_Punteros;->[Personas:7]Apellido_materno:4)
		
		APPEND TO ARRAY:C911(atACTepr_Palabra;"Apoderado_nombres")
		APPEND TO ARRAY:C911(atACTepr_Descripción;"Nombres del Apoderado")
		APPEND TO ARRAY:C911(ayACTepr_Punteros;->[Personas:7]Nombres:2)
		
		APPEND TO ARRAY:C911(atACTepr_Palabra;"Apoderado_prefijo")
		APPEND TO ARRAY:C911(atACTepr_Descripción;"Prefijo del apoderado ("+AT_array2text (-><>at_Prefijos)+")")
		APPEND TO ARRAY:C911(ayACTepr_Punteros;->[Personas:7]Prefijo:90)
		
		APPEND TO ARRAY:C911(atACTepr_Palabra;"Apoderado_modoPago")
		APPEND TO ARRAY:C911(atACTepr_Descripción;"Modo de pago del Apoderado")
		APPEND TO ARRAY:C911(ayACTepr_Punteros;->[Personas:7]ACT_modo_de_pago_new:95)
		
		APPEND TO ARRAY:C911(atACTepr_Palabra;"Monto_Rechazado")
		APPEND TO ARRAY:C911(atACTepr_Descripción;"Monto Rechazado")
		APPEND TO ARRAY:C911(ayACTepr_Punteros;->vr_MontoRechazado)
		
		vtACTepr_Cuerpo:="Estimado(a): Apoderado_apellidos_y_nombres,"+"\r\r"
		vtACTepr_Cuerpo:=vtACTepr_Cuerpo+"Le informamos que ha sido rechazado un pago por Monto_Rechazado."+"\r\r"
		vtACTepr_Cuerpo:=vtACTepr_Cuerpo+"Para no generar cargos extras y poder regularizar la situación, le solicitamos que se ponga en contacto con el colegio."+"\r\r"
		vtACTepr_Cuerpo:=vtACTepr_Cuerpo+"Atentamente,"+"\r\r"
		vtACTepr_Cuerpo:=vtACTepr_Cuerpo+"Colegio_nombre"
		
		  //Leo lo que ya se ha configurado
		
		ACTepr_OpcionesGenerales ("CargaBlob";->$xBlob)
		$xBlob:=PREF_fGetBlob (0;"ACT_EnvioPagosRechazados";$xBlob)
		ACTepr_OpcionesGenerales ("DesarmaBlob";->$xBlob)
		
	: ($t_accion="ProcesaTextoCuerpo")
		
		C_TEXT:C284($t_nomVar)
		C_LONGINT:C283($l_numTabla;$l_numCampo)
		
		For ($i;1;Size of array:C274(atACTepr_Palabra))
			RESOLVE POINTER:C394(ayACTepr_Punteros{$i};$t_nomVar;$l_numTabla;$l_numCampo)
			$l_pos:=Position:C15(atACTepr_Palabra{$i};$y_puntero->)
			If ($l_pos>0)
				If ($l_numTabla#-1)
					$y_valorReemplazo:=Field:C253($l_numTabla;$l_numCampo)
					$t_valor:=ST_Coerce_to_Text ($y_valorReemplazo;False:C215)
					$y_puntero->:=Replace string:C233($y_puntero->;atACTepr_Palabra{$i};$y_valorReemplazo->)
				Else 
					$t_valor:=ST_Coerce_to_Text (ayACTepr_Punteros{$i};False:C215)
					$y_puntero->:=Replace string:C233($y_puntero->;atACTepr_Palabra{$i};$t_valor)
				End if 
				
			End if 
			
		End for 
		
	: ($t_accion="CargaBlob")
		$l_offSet:=BLOB_Variables2Blob ($y_puntero;0;->vtACTepr_Asunto;->vtACTepr_CopiaOculta;->vtACTepr_ResponderA;->vtACTepr_Cuerpo)
	: ($t_accion="DesarmaBlob")
		$l_offSet:=BLOB_Blob2Vars ($y_puntero;0;->vtACTepr_Asunto;->vtACTepr_CopiaOculta;->vtACTepr_ResponderA;->vtACTepr_Cuerpo)
	: ($t_accion="GuardaBlob")
		ACTepr_OpcionesGenerales ("CargaBlob";->$xBlob)
		PREF_SetBlob (0;"ACT_EnvioPagosRechazados";$xBlob)
	: ($t_accion="CargaDatosApoderado")
		For ($i;1;Size of array:C274($y_puntero->))
			vr_MontoRechazado:=0
			QUERY:C277([Personas:7];[Personas:7]RUT:6=$y_puntero->{$i})
			If (Records in selection:C76([Personas:7])=0)
				QUERY:C277([Personas:7];[Personas:7]IDNacional_2:37=$y_puntero->{$i})
				If (Records in selection:C76([Personas:7])=0)
					QUERY:C277([Personas:7];[Personas:7]IDNacional_3:38=$y_puntero->{$i})
				End if 
			End if 
			APPEND TO ARRAY:C911(alACTepr_ApoderadoID;[Personas:7]No:1)
			APPEND TO ARRAY:C911(atACTepr_ApoderadoNombre;[Personas:7]Apellidos_y_nombres:30)
			APPEND TO ARRAY:C911(atACTepr_ApoderadoModoPago;[Personas:7]ACT_modo_de_pago_new:95)
			APPEND TO ARRAY:C911(arACTepr_ApoderadoMontoRechaza;aMontoRechazo{$i})
			APPEND TO ARRAY:C911(atACTepr_EmailApoderado;[Personas:7]eMail:34)
			
			If (SMTP_VerifyEmailAddress ([Personas:7]eMail:34;False:C215)="")
				APPEND TO ARRAY:C911(abACTepr_Enviar;False:C215)
			Else 
				APPEND TO ARRAY:C911(abACTepr_Enviar;True:C214)
			End if 
		End for 
		
End case 