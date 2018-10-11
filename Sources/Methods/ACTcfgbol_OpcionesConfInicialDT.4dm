//%attributes = {}
C_TEXT:C284($1;$vt_accion;$0;$vt_retorno)
C_POINTER:C301($vy_pointer1)
C_POINTER:C301(${2})
C_LONGINT:C283($vl_etapa)
C_POINTER:C301($vy_ptrObs)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 

Case of 
	: ($vt_accion="OnLoad")
		C_TEXT:C284(vtACT_RS)
		C_TEXT:C284(vtACT_Obs1;vtACT_Obs2;vtACT_Obs3;vtACT_Obs4;vtACT_Obs5;vtACT_Obs6;vtACT_Obs7)
		C_POINTER:C301($vy_ptrVar)
		C_LONGINT:C283(vlACT_Etapa)
		
		vtACT_RS:=atACTcfg_Razones{atACTcfg_Razones}
		vlACT_Etapa:=0
		
		ACTcfgbol_OpcionesConfInicialDT ("SetIconosConf")
		
	: ($vt_accion="SetIconosConf")
		If (Not:C34(Is nil pointer:C315($vy_pointer1)))
			$vl_etapa:=$vy_pointer1->
			$vl_inicio:=$vl_etapa
		Else 
			$vl_etapa:=7
			$vl_inicio:=1
		End if 
		For ($i;$vl_inicio;$vl_etapa)  //son 7 etapas
			If (vlACT_Etapa=0)
				$vy_ptrVar:=Get pointer:C304("vtACT_Obs"+String:C10($i))
				$vy_ptrVar->:=""
			End if 
			OBJECT SET VISIBLE:C603(*;"Imagen0_"+String:C10($i)+"_1";([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? $i))
			OBJECT SET VISIBLE:C603(*;"Imagen0_"+String:C10($i)+"_2";Not:C34(([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? $i)))
		End for 
		
	: ($vt_accion="Enrolar")
		vlACT_Etapa:=1
		$vy_ptrObs:=Get pointer:C304("vtACT_Obs"+String:C10(vlACT_Etapa))
		$vt_retorno:=ACTcfgbol_OpcionesConfInicialDT ("ValidaEtapaEnrolar")
		If ($vt_retorno="")
			$l_rs:=[ACT_RazonesSociales:279]id:1
			$vb_continuar:=WSact_GetRazonesSociales ("WSsend_RazonesSociales")
			KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->$l_rs;True:C214)  //20161006 RCH
			If ($vb_continuar)
				If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? 1)
					$vy_ptrObs->:="Número Res: "+String:C10([ACT_RazonesSociales:279]numero_resolucion:21)+". Fecha: "+String:C10([ACT_RazonesSociales:279]fecha_resolucion:20)
				Else 
					If ([ACT_RazonesSociales:279]fecha_resolucion:20=!00-00-00!)
						$vy_ptrObs->:=__ ("Fecha resolución no especificada en Colegium.")
					Else 
						$vy_ptrObs->:=__ ("ERROR")
					End if 
				End if 
			Else 
				$vy_ptrObs->:=__ ("ERROR ^0";vtWS_ResultString)
			End if 
		Else 
			$vy_ptrObs->:=$vt_retorno
		End if 
		ACTcfgbol_OpcionesConfInicialDT ("SetIconosConf";->vlACT_Etapa)
		
	: ($vt_accion="ValidaEtapaEnrolar")
		Case of 
			: ([ACT_RazonesSociales:279]giro:18="")  //20160504 RCH
				$vt_retorno:=__ ("Falta ingresar el Giro en los Datos de la Institución.")
			: ([ACT_RazonesSociales:279]codigo_actividad_economica:6="")  //20160504 RCH
				$vt_retorno:=__ ("Falta ingresar el o los Códigos de Actividad Económica en los Datos de la Institución.")
			: ((<>gRolBD="") | (<>gCountryCode=""))
				$vt_retorno:=__ ("Falta indicar RBD y Código país.")
			: (<>gRolBD="")
				$vt_retorno:=__ ("Falta indicar RBD.")
			: (<>gCountryCode="")
				$vt_retorno:=__ ("Falta indicar Código país.")
			: ([ACT_RazonesSociales:279]encargadoDTE_id:31=0)
				$vt_retorno:=__ ("Especifique antes los datos del encargado.")
			: ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? vlACT_Etapa)
				$vt_retorno:=__ ("Ya enrolado.")+"Número Res: "+String:C10([ACT_RazonesSociales:279]numero_resolucion:21)+". Fecha: "+String:C10([ACT_RazonesSociales:279]fecha_resolucion:20)
				If (Not:C34([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? 2))
					$l_resp:=CD_Dlog (0;$vt_retorno+"\r\r"+"¿Desea volver a cargar el número de resolución?";"";"Si";"No")
					If ($l_resp=1)
						$vt_retorno:=""
					End if 
				End if 
			Else 
				$vt_retorno:=""
		End case 
		
	: ($vt_accion="AgregarContribuyente")
		vlACT_Etapa:=2
		$vy_ptrObs:=Get pointer:C304("vtACT_Obs"+String:C10(vlACT_Etapa))
		$vt_retorno:=ACTcfgbol_OpcionesConfInicialDT ("ValidaEtapaAContribuyente")
		If ($vt_retorno="")
			$vt_rut:=ACTcfg_opcionesDTE ("GetFormatoRUT";->[ACT_RazonesSociales:279]RUT:3)
			$ok:=WSactdte_InsertaContribuyente ($vt_rut;[ACT_RazonesSociales:279]razon_social:2;ACTcfg_opcionesDTE ("GetFormatoFechaWS";->[ACT_RazonesSociales:279]fecha_resolucion:20);[ACT_RazonesSociales:279]numero_resolucion:21)
			If ($ok#1)
				$vy_ptrObs->:=__ ("El contribuyente no pudo ser insertado.")
				ACTcfgbol_OpcionesConfInicialDT ("SetIconosConf";->vlACT_Etapa)
			Else 
				$vy_ptrObs->:=__ ("Contribuyente agregado.")
				[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?+ vlACT_Etapa  //contribuyente insertado
				SAVE RECORD:C53([ACT_RazonesSociales:279])
				ACTcfgbol_OpcionesConfInicialDT ("SetIconosConf";->vlACT_Etapa)
				
				
				  //20141015 RCH se inserta la sucursal automaticamente en dtenet
				vlACT_Etapa:=3
				$vy_ptrObs:=Get pointer:C304("vtACT_Obs"+String:C10(vlACT_Etapa))
				C_LONGINT:C283($vl_id;$vl_records)
				$vl_id:=999999999
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
				  //QUERY([ACT_RazonesSociales];[ACT_RazonesSociales]signatario_sucursal_id=$vl_id)
				QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]signatario_sucursal_id:25=$vl_id;*)  //20161006 RCH
				QUERY:C277([ACT_RazonesSociales:279]; & ;[ACT_RazonesSociales:279]id:1=[ACT_RazonesSociales:279]id:1)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($vl_records=0)
					[ACT_RazonesSociales:279]signatario_sucursal_id:25:=$vl_id
					[ACT_RazonesSociales:279]signatario_sucursal_nombre:29:="Casa Matriz"
					SAVE RECORD:C53([ACT_RazonesSociales:279])
					$vt_retorno:=""
				Else 
					$vt_retorno:=__ ("Código ya existe en la base de datos.")
				End if 
				If ($vt_retorno="")
					$vy_ptrObs->:=__ ("Sucursal insertada.")
					[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?+ vlACT_Etapa  //sucursal agregada
					SAVE RECORD:C53([ACT_RazonesSociales:279])
				Else 
					$vy_ptrObs->:=$vt_retorno
				End if 
				ACTcfgbol_OpcionesConfInicialDT ("SetIconosConf";->vlACT_Etapa)
				
				
			End if 
		Else 
			$vy_ptrObs->:=$vt_retorno
		End if 
		
		
	: ($vt_accion="ValidaEtapaAContribuyente")
		
		If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? (vlACT_Etapa-1))
			Case of 
				: ([ACT_RazonesSociales:279]RUT:3="")
					$vt_retorno:=__ ("El RUT de la razón social no ha sido ingresado.")
				: ([ACT_RazonesSociales:279]razon_social:2="")
					$vt_retorno:=__ ("El nombre de la razón social no ha sido ingresado.")
				: ([ACT_RazonesSociales:279]fecha_resolucion:20=!00-00-00!)
					$vt_retorno:=__ ("La fecha de resolución no ha sido ingresada en Colegium.")
				: ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? vlACT_Etapa)
					$vt_retorno:=__ ("Contribuyente ya agregado.")
				Else 
					$vt_retorno:=""
			End case 
		Else 
			$vt_retorno:=__ ("Se debe realizar la etapa anterior.")
		End if 
		
	: ($vt_accion="AgregarSucursal")
		vlACT_Etapa:=3
		$vy_ptrObs:=Get pointer:C304("vtACT_Obs"+String:C10(vlACT_Etapa))
		$vt_retorno:=ACTcfgbol_OpcionesConfInicialDT ("ValidaEtapaASucursal")
		If ($vt_retorno="")
			$vt_nombre:=[ACT_RazonesSociales:279]signatario_sucursal_nombre:29
			$vt_contacto:="Señor"
			$vt_codSucursal:=String:C10([ACT_RazonesSociales:279]signatario_sucursal_id:25)
			$vt_rut:=ACTcfg_opcionesDTE ("GetFormatoRUT";->[ACT_RazonesSociales:279]RUT:3)
			$ok:=WSactdte_InsertaSucursal ($vt_rut;$vt_nombre;$vt_contacto;$vt_codSucursal)
			If ($ok#1)
				$vy_ptrObs->:=__ ("La sucursal no pudo ser insertada.")
			Else 
				$vy_ptrObs->:=__ ("Sucursal insertada.")
				[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?+ vlACT_Etapa  //sucursal agregada
				SAVE RECORD:C53([ACT_RazonesSociales:279])
			End if 
		Else 
			$vy_ptrObs->:=$vt_retorno
		End if 
		ACTcfgbol_OpcionesConfInicialDT ("SetIconosConf";->vlACT_Etapa)
		
	: ($vt_accion="ValidaEtapaASucursal")
		If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? (vlACT_Etapa-1))
			Case of 
				: ([ACT_RazonesSociales:279]RUT:3="")
					$vt_retorno:=__ ("El RUT de la razón social no ha sido ingresado.")
				: ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? vlACT_Etapa)
					$vt_retorno:=__ ("La sucursal ya había sido agregada.")
				Else 
					C_LONGINT:C283($vl_id;$vl_records)
					$vl_id:=Num:C11(CD_Request ("Ingrese código de sucursal";"Aceptar";"Cancelar";"";"0"))
					If (ok=1)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
						QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]signatario_sucursal_id:25=$vl_id)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						
						If ($vl_records=0)
							[ACT_RazonesSociales:279]signatario_sucursal_id:25:=$vl_id
							[ACT_RazonesSociales:279]signatario_sucursal_nombre:29:="Casa Matriz"
							SAVE RECORD:C53([ACT_RazonesSociales:279])
							$vt_retorno:=""
						Else 
							$vt_retorno:=__ ("Código ya existe en la base de datos.")
						End if 
					Else 
						$vt_retorno:=__ ("Cancelado.")
					End if 
			End case 
		Else 
			$vt_retorno:=__ ("Se debe realizar la etapa anterior.")
		End if 
		
	: ($vt_accion="CargarFirma")
		vlACT_Etapa:=4
		$vy_ptrObs:=Get pointer:C304("vtACT_Obs"+String:C10(vlACT_Etapa))
		$vt_retorno:=ACTcfgbol_OpcionesConfInicialDT ("ValidaCargaFirma")
		If ($vt_retorno="")
			$vt_document:=xfGetFileName 
			If ($vt_document#"")
				  //$vt_clave:=CD_Request (__ ("Ingrese la clave del certificado.");__ ("Aceptar");__ ("Cancelar");__ ("");"")
				$vt_clave:=CD_Request (__ ("Ingrese la clave del certificado.");__ ("Aceptar");__ ("Cancelar");__ ("");"";True:C214)
				If (ok=1)
					C_TEXT:C284($vt_rut)
					$vt_rut:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[ACT_RazonesSociales:279]encargadoDTE_id:31;->[Profesores:4]RUT:27)
					$vt_rut:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$vt_rut)
					$vl_resp:=CD_Dlog (0;"La firma digital deberá estar asociada al RUT "+$vt_rut+"\r\r"+"¿Desea continuar?";"";"Si";"No")
					If ($vl_resp=1)
						C_TEXT:C284($text)
						DOCUMENT TO BLOB:C525($vt_document;$xBlob)
						BASE64 ENCODE:C895($xBlob;$text)
						$text:=Replace string:C233($text;Char:C90(10);"")
						SET BLOB SIZE:C606($xBlob;0)
						TEXT TO BLOB:C554($text;$xBlob;Mac text without length:K22:10)
						$ok:=WSact_sendFirma ($vt_rut;$xBlob;$vt_clave)
						If ($ok=1)
							[ACT_RazonesSociales:279]firma_fecha_vencimiento:23:=vdrs_fechaVencimiento
							[ACT_RazonesSociales:279]signatario_rut:24:=Replace string:C233($vt_rut;"-";"")
							[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?+ vlACT_Etapa  //firma cargada
							SAVE RECORD:C53([ACT_RazonesSociales:279])
							$vy_ptrObs->:=__ ("Firma Cargada.")
							ACTcfgbol_OpcionesConfInicialDT ("SetIconosConf";->vlACT_Etapa)
							
							If (Not:C34([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? 5))
								ACTcfgbol_OpcionesConfInicialDT ("AsociaSignatario")
							End if 
						Else 
							$vy_ptrObs->:=__ ("El certificado no pudo ser cargado.")
						End if 
					Else 
						$vy_ptrObs->:=__ ("Operación cancelada")
					End if 
				Else 
					$vy_ptrObs->:=__ ("Operación cancelada")
				End if 
			Else 
				$vy_ptrObs->:=__ ("Operación cancelada")
			End if 
		Else 
			$vy_ptrObs->:=$vt_retorno
		End if 
		
	: ($vt_accion="ValidaCargaFirma")
		If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? (vlACT_Etapa-1))
			KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[ACT_RazonesSociales:279]encargadoDTE_id:31)
			Case of 
				: (Records in selection:C76([Profesores:4])=0)
					$vt_retorno:=__ ("No se ha definido un encargado.")
				: (CTRY_CL_VerifRUT ([Profesores:4]RUT:27;False:C215)="")
					$vt_retorno:=__ ("El encargado debe tener RUT ingresado.")
					
				: ([ACT_RazonesSociales:279]firma_fecha_vencimiento:23#!00-00-00!)
					$resp:=CD_Dlog (0;__ ("Ya existe una firma cargada valida hasta el "+String:C10([ACT_RazonesSociales:279]firma_fecha_vencimiento:23)+".")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
					If ($resp=1)
						$vt_retorno:=""
					Else 
						$vt_retorno:=__ ("Ya existe una firma cargada.")
					End if 
				Else 
					$vt_retorno:=""
			End case 
		Else 
			$vt_retorno:=__ ("Se debe realizar la etapa anterior.")
		End if 
		
	: ($vt_accion="AsociaSignatario")
		vlACT_Etapa:=5
		$vy_ptrObs:=Get pointer:C304("vtACT_Obs"+String:C10(vlACT_Etapa))
		$vt_retorno:=ACTcfgbol_OpcionesConfInicialDT ("ValidaAsociaSignatario")
		If ($vt_retorno="")
			$ok:=WSact_AsociaSignatario (ACTcfg_opcionesDTE ("GetFormatoRUT";->[ACT_RazonesSociales:279]RUT:3);[ACT_RazonesSociales:279]signatario_sucursal_id:25;ACTcfg_opcionesDTE ("GetFormatoRUT";->[ACT_RazonesSociales:279]signatario_rut:24))
			If ($ok#1)
				$vy_ptrObs->:=__ ("El signatario no pudo ser asociado a la sucursal.")
			Else 
				$vy_ptrObs->:=__ ("Signatario asociado.")
				[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?+ vlACT_Etapa  //signatario asociado a sucursal
				SAVE RECORD:C53([ACT_RazonesSociales:279])
			End if 
		Else 
			$vy_ptrObs->:=$vt_retorno
		End if 
		ACTcfgbol_OpcionesConfInicialDT ("SetIconosConf";->vlACT_Etapa)
		
	: ($vt_accion="ValidaAsociaSignatario")
		If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? (vlACT_Etapa-1))
			Case of 
				: ([ACT_RazonesSociales:279]RUT:3="")
					$vt_retorno:=__ ("El RUT de la razón social no ha sido ingresado.")
				: ([ACT_RazonesSociales:279]signatario_sucursal_id:25=0)
					$vt_retorno:=__ ("No se ha definido el código de sucursal.")
				: ([ACT_RazonesSociales:279]signatario_rut:24="")
					$vt_retorno:=__ ("No ha sido cargada la firma.")
				Else 
					$vt_retorno:=""
			End case 
		Else 
			$vt_retorno:=__ ("Se debe realizar la etapa anterior.")
		End if 
		
	: ($vt_accion="CargaPropiedades")
		vlACT_Etapa:=6
		$vy_ptrObs:=Get pointer:C304("vtACT_Obs"+String:C10(vlACT_Etapa))
		$vt_retorno:=ACTcfgbol_OpcionesConfInicialDT ("ValidaCargaPropiedades")
		If ($vt_retorno="")
			WDW_OpenPopupWindow (Self:C308;->[ACT_RazonesSociales:279];"Propiedades";2)
			DIALOG:C40([ACT_RazonesSociales:279];"Propiedades")
			CLOSE WINDOW:C154
		Else 
			$vy_ptrObs->:=$vt_retorno
		End if 
		ACTcfgbol_OpcionesConfInicialDT ("SetIconosConf";->vlACT_Etapa)
		
	: ($vt_accion="ValidaCargaPropiedades")
		If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? (vlACT_Etapa-1))
			Case of 
				: ([ACT_RazonesSociales:279]RUT:3="")
					$vt_retorno:=__ ("El RUT de la razón social no ha sido ingresado.")
				Else 
					$vt_retorno:=""
			End case 
		Else 
			$vt_retorno:=__ ("Se debe realizar la etapa anterior.")
		End if 
		
	: ($vt_accion="CargaACTECO")
		vlACT_Etapa:=7
		$vy_ptrObs:=Get pointer:C304("vtACT_Obs"+String:C10(vlACT_Etapa))
		$vt_retorno:=ACTcfgbol_OpcionesConfInicialDT ("ValidaCargaACTECO")
		If ($vt_retorno="")
			ARRAY TEXT:C222($at_actecos;0)
			AT_Text2Array (->$at_actecos;[ACT_RazonesSociales:279]codigo_actividad_economica:6;";")
			
			For ($l_indice;1;Size of array:C274($at_actecos))
				$ok:=WSact_CargaActeco (ACTcfg_opcionesDTE ("GetFormatoRUT";->[ACT_RazonesSociales:279]RUT:3);$at_actecos{$l_indice})
				If ($ok=0)
					$l_indice:=Size of array:C274($at_actecos)
				End if 
			End for 
			  //$ok:=WSact_CargaActeco (ACTcfg_opcionesDTE ("GetFormatoRUT";->[ACT_RazonesSociales]RUT);[ACT_RazonesSociales]codigo_actividad_economica)
			If ($ok#1)
				$vy_ptrObs->:=__ ("El acteco no pudo ser cargado.")
			Else 
				[ACT_RazonesSociales:279]acteco_enviado:26:=[ACT_RazonesSociales:279]codigo_actividad_economica:6
				[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?+ vlACT_Etapa  //acteco cargado
				SAVE RECORD:C53([ACT_RazonesSociales:279])
				$vy_ptrObs->:=__ ("Código de actividad económica.")
			End if 
		Else 
			$vy_ptrObs->:=$vt_retorno
		End if 
		ACTcfgbol_OpcionesConfInicialDT ("SetIconosConf";->vlACT_Etapa)
		
	: ($vt_accion="ValidaCargaACTECO")
		If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? (vlACT_Etapa-1))
			Case of 
				: ([ACT_RazonesSociales:279]RUT:3="")
					$vt_retorno:=__ ("El RUT de la razón social no ha sido ingresado.")
				: ([ACT_RazonesSociales:279]codigo_actividad_economica:6="")
					$vt_retorno:=__ ("No ha sido agregado el código de actividad económica en la configuración.")
				: ([ACT_RazonesSociales:279]giro:18="")  //20141014 RCH 
					$vt_retorno:=__ ("No ha sido agregado el Giro en la configuración.")
				: ([ACT_RazonesSociales:279]acteco_enviado:26#"")
					If ([ACT_RazonesSociales:279]codigo_actividad_economica:6#[ACT_RazonesSociales:279]acteco_enviado:26)
						$resp:=CD_Dlog (0;__ ("Ya existe un código de actividad económica asociado a este rut.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
						If ($resp=1)
							$vt_retorno:=""
						Else 
							$vt_retorno:=__ ("Operación cancelada")
						End if 
					Else 
						$vt_retorno:=__ ("Código de actividad económica ya enviado.")
					End if 
				Else 
					$vt_retorno:=""
			End case 
		Else 
			$vt_retorno:=__ ("Se debe realizar la etapa anterior.")
		End if 
		
End case 

$0:=$vt_retorno