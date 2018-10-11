//%attributes = {}
  //ACTdte_EnvioPDFXMail


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
		C_TEXT:C284(vtACTdte_Asunto;vtACTdte_ResponderA;vtACTdte_CopiaOculta)
		  //Listbox palabras
		ARRAY TEXT:C222(atACTdte_Palabra;0)
		ARRAY TEXT:C222(atACTdte_Descripción;0)
		ARRAY POINTER:C280(ayACTdte_PunterosAp;0)
		ARRAY POINTER:C280(ayACTdte_PunterosTer;0)
		
		C_TEXT:C284(vtACTdte_Cuerpo)
		
		
		
		C_REAL:C285(cs_ACTdte_RegistrarObs)
		  //Listbox envio correos
		ARRAY TEXT:C222(atACTdte_Nombre;0)
		ARRAY TEXT:C222(atACTdte_Tipo;0)
		ARRAY LONGINT:C221(alACTdte_Folio;0)
		ARRAY LONGINT:C221(alACTdte_ID;0)
		ARRAY LONGINT:C221(alACTdte_Colores;0)
		ARRAY BOOLEAN:C223(abACTdte_Enviar;0)
		
		  //ids apoderados a enviar
		ARRAY LONGINT:C221(alACTdte_ApoderadoID2Enviar;0)
		
	: ($t_accion="InicializaVariables")
		ACTdte_EnvioPDFXMail ("DeclaraVariables")
		
		  //textos por defecto
		  //vtACTdte_AsuntoOrg:="Envio DTE "+<>atXS_MonthNames{Month of([ACT_Boletas]FechaEmision)}+" "+String(Year of([ACT_Boletas]FechaEmision))+" No"+String([ACT_Boletas]Numero)
		vtACTdte_AsuntoOrg:="Envio DTE "+"DTE_nombre_mes_emision"+" "+"DTE_nombre_año_emision"+" No"+"DTE_folio"
		vtACTdte_Asunto:=vtACTdte_AsuntoOrg
		vtACTdte_ResponderA:=""
		vtACTdte_CopiaOculta:=""
		
		  //Listbox palabras
		  //ARRAY TEXT(atACTdte_Palabra;0)
		  //ARRAY TEXT(atACTdte_Descripción;0)
		  //ARRAY POINTER(ayACTdte_PunterosAp;0)
		
		APPEND TO ARRAY:C911(atACTdte_Palabra;"Razon_Social")
		APPEND TO ARRAY:C911(atACTdte_Descripción;"Razón Social emisora del documento")
		APPEND TO ARRAY:C911(ayACTdte_PunterosAp;->[ACT_RazonesSociales:279]razon_social:2)
		APPEND TO ARRAY:C911(ayACTdte_PunterosTer;->[ACT_RazonesSociales:279]razon_social:2)
		
		APPEND TO ARRAY:C911(atACTdte_Palabra;"Apellidos_y_nombres")
		APPEND TO ARRAY:C911(atACTdte_Descripción;"Apellidos y nombres")
		APPEND TO ARRAY:C911(ayACTdte_PunterosAp;->[Personas:7]Apellidos_y_nombres:30)
		APPEND TO ARRAY:C911(ayACTdte_PunterosTer;->[ACT_Terceros:138]Nombre_Completo:9)
		
		APPEND TO ARRAY:C911(atACTdte_Palabra;"Apellido_paterno")
		APPEND TO ARRAY:C911(atACTdte_Descripción;"Apellido paterno")
		APPEND TO ARRAY:C911(ayACTdte_PunterosAp;->[Personas:7]Apellido_paterno:3)
		APPEND TO ARRAY:C911(ayACTdte_PunterosTer;->[ACT_Terceros:138]Apellido_Paterno:16)
		
		APPEND TO ARRAY:C911(atACTdte_Palabra;"Apellido_materno")
		APPEND TO ARRAY:C911(atACTdte_Descripción;"Apellido materno")
		APPEND TO ARRAY:C911(ayACTdte_PunterosAp;->[Personas:7]Apellido_materno:4)
		APPEND TO ARRAY:C911(ayACTdte_PunterosTer;->[ACT_Terceros:138]Apellido_Materno:17)
		
		APPEND TO ARRAY:C911(atACTdte_Palabra;"Nombres")
		APPEND TO ARRAY:C911(atACTdte_Descripción;"Nombres")
		APPEND TO ARRAY:C911(ayACTdte_PunterosAp;->[Personas:7]Nombres:2)
		APPEND TO ARRAY:C911(ayACTdte_PunterosTer;->[ACT_Terceros:138]Nombres:18)
		
		APPEND TO ARRAY:C911(atACTdte_Palabra;"DTE_nombre_mes_emision")
		APPEND TO ARRAY:C911(atACTdte_Descripción;"Nombre del mes del documento")
		APPEND TO ARRAY:C911(ayACTdte_PunterosAp;->[ACT_Boletas:181]FechaEmision:3)
		APPEND TO ARRAY:C911(ayACTdte_PunterosTer;->[ACT_Boletas:181]FechaEmision:3)
		
		APPEND TO ARRAY:C911(atACTdte_Palabra;"DTE_nombre_año_emision")
		APPEND TO ARRAY:C911(atACTdte_Descripción;"Año del documento")
		APPEND TO ARRAY:C911(ayACTdte_PunterosAp;->[ACT_Boletas:181]FechaEmision:3)
		APPEND TO ARRAY:C911(ayACTdte_PunterosTer;->[ACT_Boletas:181]FechaEmision:3)
		
		APPEND TO ARRAY:C911(atACTdte_Palabra;"DTE_folio")
		APPEND TO ARRAY:C911(atACTdte_Descripción;"Folio del documento")
		APPEND TO ARRAY:C911(ayACTdte_PunterosAp;->[ACT_Boletas:181]Numero:11)
		APPEND TO ARRAY:C911(ayACTdte_PunterosTer;->[ACT_Boletas:181]Numero:11)
		
		  //vtACTdte_Cuerpo:="Estimado(a): Apellidos_y_nombres,"+<>cr+<>cr
		  //vtACTdte_Cuerpo:=vtACTdte_Cuerpo+"Según la información contable del colegio, hay cargos aún no pagados asociados a su familia."+<>cr+<>cr
		  //vtACTdte_Cuerpo:=vtACTdte_Cuerpo+"Adjuntamos el detalle de los mismos para que pueda regularizar su situación."+<>cr+<>cr
		  //vtACTdte_Cuerpo:=vtACTdte_Cuerpo+"Si al momento de recibir este correo ha regularizado esta situación, le rogamos dejar sin efecto esta información."+<>cr+<>cr
		  //vtACTdte_Cuerpo:=vtACTdte_Cuerpo+"Atentamente,"+<>cr+<>cr
		  //vtACTdte_Cuerpo:=vtACTdte_Cuerpo+"Colegio_nombre"
		
		vtACTdte_Cuerpo:="Estimados(as) "+"Apellidos_y_nombres"+","+"\r\r"
		vtACTdte_Cuerpo:=vtACTdte_Cuerpo+"Adjuntamos el Documento Tributario del mes."+"\r\r"
		vtACTdte_Cuerpo:=vtACTdte_Cuerpo+"Atte."+"\r\r"
		vtACTdte_Cuerpo:=vtACTdte_Cuerpo+"Razon_Social"+"\r\r"
		
		
		cs_ACTdte_RegistrarObs:=1
		
		  //envio manual
		
		  //lee lo ya configurado
		ACTdte_EnvioPDFXMail ("ArmaBlob";->$xBlob)
		$xBlob:=PREF_fGetBlob (0;"ACT_EnvioPDFDtes";$xBlob)
		ACTdte_EnvioPDFXMail ("DesarmaBlob";->$xBlob)
		
	: ($t_accion="ArmaBlob")
		$l_offSet:=BLOB_Variables2Blob ($vy_pointer1;0;->vtACTdte_Asunto;->vtACTdte_ResponderA;->vtACTdte_CopiaOculta;->vtACTdte_Cuerpo;->cs_ACTdte_RegistrarObs)
		
	: ($t_accion="DesarmaBlob")
		$l_offSet:=BLOB_Blob2Vars ($vy_pointer1;0;->vtACTdte_Asunto;->vtACTdte_ResponderA;->vtACTdte_CopiaOculta;->vtACTdte_Cuerpo;->cs_ACTdte_RegistrarObs)
		
	: ($t_accion="GuardaBlob")
		C_BLOB:C604($xBlob)
		ACTdte_EnvioPDFXMail ("ArmaBlob";->$xBlob)
		PREF_SetBlob (0;"ACT_EnvioPDFDtes";$xBlob)
		
	: ($t_accion="SetEstadoObjetos")
		  //ACTdte_EnvioPDFXMail("SetEstadoObjetos")
		
		If (vtACTdte_Asunto="")
			vtACTdte_Asunto:=vtACTdte_AsuntoOrg
		End if 
		
	: ($t_accion="ProcesaTexto")
		C_LONGINT:C283($l_indice;$l_indiceReemplazo)
		C_LONGINT:C283($l_idBol)
		
		$l_idBol:=$vy_pointer2->
		
		If ($l_idBol#0)
			READ ONLY:C145([ACT_Boletas:181])
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_Terceros:138])
			READ ONLY:C145([ACT_RazonesSociales:279])
			KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBol)
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
			KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21)
			KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25)
			
			  //ARRAY POINTER($ay_punterosCampos;0)
			  //APPEND TO ARRAY($ay_punterosCampos;->vtACTdte_Cuerpo)
			  //APPEND TO ARRAY($ay_punterosCampos;->vtACTdte_Asunto)
			  //
			  //For ($l_indicePalabras;1;Size of array($ay_punterosCampos->))
			  //$vy_pointer1->:=vtACTdte_Cuerpo
			  //$vy_pointer1->:=$ay_punterosCampos{$l_indicePalabras}
			For ($l_indiceReemplazo;1;Size of array:C274(atACTdte_Palabra))
				If ([ACT_Boletas:181]ID_Apoderado:14#0)
					RESOLVE POINTER:C394(ayACTdte_PunterosAp{$l_indiceReemplazo};$t_nomVar;$l_numTabla;$l_numCampo)
				Else 
					RESOLVE POINTER:C394(ayACTdte_PunterosTer{$l_indiceReemplazo};$t_nomVar;$l_numTabla;$l_numCampo)
				End if 
				If ($t_nomVar#"")
					If ([ACT_Boletas:181]ID_Apoderado:14#0)
						$t_valor:=ayACTdte_PunterosAp{$l_indiceReemplazo}->
					Else 
						$t_valor:=ayACTdte_PunterosTer{$l_indiceReemplazo}->
					End if 
				Else 
					$y_pointer:=Field:C253($l_numTabla;$l_numCampo)
					Case of 
						: (atACTdte_Palabra{$l_indiceReemplazo}="DTE_nombre_mes_emision")
							$t_valor:=<>atXS_MonthNames{Month of:C24([ACT_Boletas:181]FechaEmision:3)}
						: (atACTdte_Palabra{$l_indiceReemplazo}="DTE_nombre_año_emision")
							$t_valor:=String:C10(Year of:C25([ACT_Boletas:181]FechaEmision:3))
						Else 
							$t_valor:=ST_Coerce_to_Text ($y_pointer;False:C215)
					End case 
				End if 
				$vy_pointer1->:=Replace string:C233($vy_pointer1->;atACTdte_Palabra{$l_indiceReemplazo};$t_valor)
			End for 
			  //End for 
		End if 
		
End case 

$0:=$t_retorno
