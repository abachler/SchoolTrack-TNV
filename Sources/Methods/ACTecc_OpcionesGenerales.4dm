//%attributes = {}
  //ACTecc_OpcionesGenerales

C_TEXT:C284($t_accion;$1;$t_retorno;$0)
C_POINTER:C301($vy_pointer1;${2})
C_BLOB:C604($xBlob)
C_LONGINT:C283($l_offSet)

$t_accion:=$1

If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 

If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($t_accion="DeclaraVariables")
		C_TEXT:C284(vtACTecc_Asunto;vtACTecc_ResponderA;vtACTecc_CopiaOculta)
		  //Listbox palabras
		ARRAY TEXT:C222(atACTecc_Palabra;0)
		ARRAY TEXT:C222(atACTecc_Descripción;0)
		ARRAY POINTER:C280(ayACTecc_Punteros;0)
		
		C_TEXT:C284(vtACTecc_Cuerpo)
		
		ARRAY TEXT:C222(atACTecc_Informes;0)
		ARRAY LONGINT:C221(alACTecc_Informes;0)
		C_REAL:C285(vr_idInformeSeleccionado)
		
		C_REAL:C285(cs_ACTecc_RegistrarObs;cs_ACTecc_PublicarSN)
		  //Listbox envio correos
		ARRAY TEXT:C222(atACTecc_ApoderadoNombre;0)
		ARRAY TEXT:C222(atACTecc_ApoderadoModoPago;0)
		ARRAY REAL:C219(arACTecc_ApoderadoMontoVencido;0)
		ARRAY LONGINT:C221(alACTecc_ApoderadoID;0)
		ARRAY LONGINT:C221(alACTecc_Colores;0)
		ARRAY BOOLEAN:C223(abACTecc_Enviar;0)
		
		  //envio automatico
		C_REAL:C285(cs_ACTecc_EnvioAutomatico)
		C_TEXT:C284(vtACTecc_Consulta)
		C_LONGINT:C283(vlACTecc_Dia)
		ARRAY TEXT:C222(atACTecc_Consultas;0)
		C_REAL:C285(cs_ACTecc_EnvioAutomaticoOrg)
		
		  //ids apoderados a enviar
		ARRAY LONGINT:C221(alACTecc_ApoderadoID2Enviar;0)
		
	: ($t_accion="InicializaVariables")
		ACTecc_OpcionesGenerales ("DeclaraVariables")
		
		  //textos por defecto
		vtACTecc_AsuntoOrg:="Carta de Cobranza"
		vtACTecc_Asunto:=vtACTecc_AsuntoOrg
		vtACTecc_ResponderA:=""
		vtACTecc_CopiaOculta:=""
		
		  //Listbox palabras
		  //ARRAY TEXT(atACTecc_Palabra;0)
		  //ARRAY TEXT(atACTecc_Descripción;0)
		  //ARRAY POINTER(ayACTecc_Punteros;0)
		
		APPEND TO ARRAY:C911(atACTecc_Palabra;"Colegio_nombre")
		APPEND TO ARRAY:C911(atACTecc_Descripción;"Nombre del Colegio")
		APPEND TO ARRAY:C911(ayACTecc_Punteros;-><>gCustom)
		
		APPEND TO ARRAY:C911(atACTecc_Palabra;"Apoderado_apellidos_y_nombres")
		APPEND TO ARRAY:C911(atACTecc_Descripción;"Apellidos y nombre del apoderado")
		APPEND TO ARRAY:C911(ayACTecc_Punteros;->[Personas:7]Apellidos_y_nombres:30)
		
		APPEND TO ARRAY:C911(atACTecc_Palabra;"Apoderado_apellido_paterno")
		APPEND TO ARRAY:C911(atACTecc_Descripción;"Apellido paterno del apoderado")
		APPEND TO ARRAY:C911(ayACTecc_Punteros;->[Personas:7]Apellido_paterno:3)
		
		APPEND TO ARRAY:C911(atACTecc_Palabra;"Apoderado_apellido_materno")
		APPEND TO ARRAY:C911(atACTecc_Descripción;"Apellido materno del apoderado")
		APPEND TO ARRAY:C911(ayACTecc_Punteros;->[Personas:7]Apellido_materno:4)
		
		APPEND TO ARRAY:C911(atACTecc_Palabra;"Apoderado_nombres")
		APPEND TO ARRAY:C911(atACTecc_Descripción;"Nombres del apoderado")
		APPEND TO ARRAY:C911(ayACTecc_Punteros;->[Personas:7]Nombres:2)
		
		APPEND TO ARRAY:C911(atACTecc_Palabra;"Apoderado_nombre_comun")
		APPEND TO ARRAY:C911(atACTecc_Descripción;"Nombre común del apoderado")
		APPEND TO ARRAY:C911(ayACTecc_Punteros;->[Personas:7]Nombre_Comun:60)
		
		APPEND TO ARRAY:C911(atACTecc_Palabra;"Apoderado_prefijo")
		APPEND TO ARRAY:C911(atACTecc_Descripción;"Prefijo del apoderado ("+AT_array2text (-><>at_Prefijos)+")")
		APPEND TO ARRAY:C911(ayACTecc_Punteros;->[Personas:7]Prefijo:90)
		
		APPEND TO ARRAY:C911(atACTecc_Palabra;"Apoderado_modoPago")
		APPEND TO ARRAY:C911(atACTecc_Descripción;"Modo de pago del Apoderado")
		APPEND TO ARRAY:C911(ayACTecc_Punteros;->[Personas:7]ACT_modo_de_pago_new:95)
		
		vtACTecc_Cuerpo:="Estimado(a): Apoderado_apellidos_y_nombres,"+"\r\r"
		vtACTecc_Cuerpo:=vtACTecc_Cuerpo+"Según la información contable del colegio, hay cargos aún no pagados asociados a su familia."+"\r\r"
		vtACTecc_Cuerpo:=vtACTecc_Cuerpo+"Adjuntamos el detalle de los mismos para que pueda regularizar su situación."+"\r\r"
		vtACTecc_Cuerpo:=vtACTecc_Cuerpo+"Si al momento de recibir este correo ha regularizado esta situación, le rogamos dejar sin efecto esta información."+"\r\r"
		vtACTecc_Cuerpo:=vtACTecc_Cuerpo+"Atentamente,"+"\r\r"
		vtACTecc_Cuerpo:=vtACTecc_Cuerpo+"Colegio_nombre"
		
		  //busca reportes carta de cobranza
		  //ARRAY TEXT(atACTecc_Informes;0)
		READ ONLY:C145([xShell_Reports:54])
		
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=(Table:C252(->[Personas:7]));*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]Modulo:41="AccountTrack";*)
		QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]ReportType:2="gSR2";*)
		QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]ReportName:26="Carta Cobranza@")
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11;=;True:C214)
		ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)
		SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;atACTecc_Informes;[xShell_Reports:54]ID:7;alACTecc_Informes)
		If (Size of array:C274(atACTecc_Informes)=0)
			APPEND TO ARRAY:C911(atACTecc_Informes;"No hay modelos llamados "+ST_Qte ("Carta de Cobranza@")+".")
			APPEND TO ARRAY:C911(alACTecc_Informes;-1)
		End if 
		atACTecc_Informes:=1
		vr_idInformeSeleccionado:=alACTecc_Informes{atACTecc_Informes}
		
		cs_ACTecc_RegistrarObs:=1
		cs_ACTecc_PublicarSN:=0
		
		  //envio manual
		
		
		  //envio automatico
		cs_ACTecc_EnvioAutomatico:=0
		vtACTecc_Consulta:=""
		vlACTecc_Dia:=0
		
		  //atACTecc_Consultas
		COPY ARRAY:C226(aQueryArray;atACTecc_Consultas)
		AT_Delete (Size of array:C274(atACTecc_Consultas)-1;2;->atACTecc_Consultas)
		
		  //lee lo ya configurado
		ACTecc_OpcionesGenerales ("ArmaBlob";->$xBlob)
		$xBlob:=PREF_fGetBlob (0;"ACT_EnvioEmailCartaCobranza";$xBlob)
		ACTecc_OpcionesGenerales ("DesarmaBlob";->$xBlob)
		
		cs_ACTecc_EnvioAutomaticoOrg:=cs_ACTecc_EnvioAutomatico
		
	: ($t_accion="ArmaBlob")
		$l_offSet:=BLOB_Variables2Blob ($vy_pointer1;0;->vtACTecc_Asunto;->vtACTecc_ResponderA;->vtACTecc_CopiaOculta;->vtACTecc_Cuerpo;->cs_ACTecc_RegistrarObs;->cs_ACTecc_PublicarSN;->vr_idInformeSeleccionado;->cs_ACTecc_EnvioAutomatico;->vtACTecc_Consulta;->vlACTecc_Dia)
		
	: ($t_accion="DesarmaBlob")
		$l_offSet:=BLOB_Blob2Vars ($vy_pointer1;0;->vtACTecc_Asunto;->vtACTecc_ResponderA;->vtACTecc_CopiaOculta;->vtACTecc_Cuerpo;->cs_ACTecc_RegistrarObs;->cs_ACTecc_PublicarSN;->vr_idInformeSeleccionado;->cs_ACTecc_EnvioAutomatico;->vtACTecc_Consulta;->vlACTecc_Dia)
		
	: ($t_accion="GuardaBlob")
		C_BLOB:C604($xBlob)
		ACTecc_OpcionesGenerales ("ArmaBlob";->$xBlob)
		PREF_SetBlob (0;"ACT_EnvioEmailCartaCobranza";$xBlob)
		
	: ($t_accion="SetEstadoObjetos")
		  //ACTecc_OpcionesGenerales("SetEstadoObjetos")
		OBJECT SET ENABLED:C1123(btn_programar;cs_ACTecc_EnvioAutomatico=1)
		
		If (cs_ACTecc_EnvioAutomatico=1)
			Case of 
				: (vlACTecc_Dia<=0)
					vlACTecc_Dia:=1
				: (vlACTecc_Dia>28)
					vlACTecc_Dia:=28
			End case 
		Else 
			vlACTecc_Dia:=0
			vtACTecc_Consulta:=""
		End if 
		
		If (vtACTecc_Asunto="")
			vtACTecc_Asunto:=vtACTecc_AsuntoOrg
		End if 
		
	: ($t_accion="ValidaProgramacion")
		C_BOOLEAN:C305($b_continuar)
		
		If (cs_ACTecc_EnvioAutomatico=1)
			$b_continuar:=False:C215
			vtACTecc_Consulta:=atACTecc_Consultas{atACTecc_Consultas}
			
			Case of 
				: (vtACTecc_Consulta="")
					CD_Dlog (0;"Antes de programar el envío se debe seleccionar una consulta asociada.")
					
				: (vr_idInformeSeleccionado=-1)
					CD_Dlog (0;"Antes de programar el envío se debe seleccionar una consulta asociada.")
					
				Else 
					$b_continuar:=True:C214
			End case 
			
			If ($b_continuar)
				$t_retorno:="1"
				  //ACTecc_OpcionesGenerales ("GuardaBlob")
				  //CANCEL
			End if 
		Else 
			  //BEEP
		End if 
		
	: ($t_accion="ProcesaTextoCuerpo")
		C_LONGINT:C283($l_indice;$l_indiceReemplazo)
		
		$l_idApdo:=$vy_pointer2->
		
		  //APPEND TO ARRAY(atACTecc_Palabra;"Colegio_nombre")
		  //APPEND TO ARRAY(atACTecc_Descripción;"Nombre del Colegio")
		  //APPEND TO ARRAY(ayACTecc_Punteros;-><>gCustom)
		If ($l_idApdo#0)
			READ ONLY:C145([Personas:7])
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo)
			$vy_pointer1->:=vtACTecc_Cuerpo
			For ($l_indiceReemplazo;1;Size of array:C274(atACTecc_Palabra))
				RESOLVE POINTER:C394(ayACTecc_Punteros{$l_indiceReemplazo};$t_nomVar;$l_numTabla;$l_numCampo)
				If ($t_nomVar#"")
					$t_valor:=ayACTecc_Punteros{$l_indiceReemplazo}->
				Else 
					$y_pointer:=Field:C253($l_numTabla;$l_numCampo)
					$t_valor:=ST_Coerce_to_Text ($y_pointer;False:C215)
				End if 
				$vy_pointer1->:=Replace string:C233($vy_pointer1->;atACTecc_Palabra{$l_indiceReemplazo};$t_valor)
			End for 
		End if 
		
End case 

$0:=$t_retorno