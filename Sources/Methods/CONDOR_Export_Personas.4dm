//%attributes = {}
C_POINTER:C301($1;$2;$3;$4;$5)
C_POINTER:C301($y_UUIDPersonasEnviadas;$y_UUIDProfesoresEnviados;$y_UUIDAlumnosEnviados;$y_UUIDFamiliasXEnviar)
C_LONGINT:C283($vl_params;$vl_rnProfe;$vl_rnAlumno)
C_TEXT:C284($uuid)
C_BOOLEAN:C305($vb_testarray;$vb_go)

$vl_params:=Count parameters:C259
$vb_go:=True:C214

Case of 
	: ($vl_params=4)
		$y_UUIDPersonasEnviadas:=$1
		$y_UUIDProfesoresEnviados:=$2
		$y_UUIDAlumnosEnviados:=$3
		$y_UUIDFamiliasXEnviar:=$4
		ALL RECORDS:C47([Personas:7])
	: ($vl_params=5)
		$y_UUIDPersonasEnviadas:=$1
		$y_UUIDProfesoresEnviados:=$2
		$y_UUIDAlumnosEnviados:=$3
		$y_UUIDFamiliasXEnviar:=$4
		If (Not:C34(Is nil pointer:C315($5)))
			CREATE SELECTION FROM ARRAY:C640([Personas:7];$5->)
		Else 
			ALL RECORDS:C47([Personas:7])
		End if 
	Else 
		$vb_go:=False:C215
		ALERT:C41("Faltan parámetros!!!")
End case 


If ((Records in selection:C76([Personas:7])>0) & $vb_go)
	$refXMLDoc:=CONDOR_ExportDataGenArchivo ("personas";->$vt_FileName)
	
	ARRAY LONGINT:C221($recNums;0)
	ARRAY TEXT:C222($at_UUIDs;0)
	LONGINT ARRAY FROM SELECTION:C647([Personas:7];$recNums)
	SELECTION TO ARRAY:C260([Personas:7]Auto_UUID:36;$at_UUIDs)
	$size:=Size of array:C274($recNums)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de personas..."))
	For ($indice;1;$size)
		$vb_go:=False:C215
		If (Find in array:C230($y_UUIDPersonasEnviadas->;$at_UUIDs{$indice})=-1)
			APPEND TO ARRAY:C911($y_UUIDPersonasEnviadas->;$at_UUIDs{$indice})
			$vb_go:=True:C214
		End if 
		If ($vb_go)
			KRL_GotoRecord (->[Personas:7];$recNums{$indice};False:C215)
			$vt_Name:=ST_GetCleanString ([Personas:7]Nombres:2+[Personas:7]Apellido_paterno:3+[Personas:7]Apellido_materno:4)
			If ($vt_Name#"")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"persona")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"activo";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Inactivo:46);False:C215;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombres";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Nombres:2);True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"appaterno";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Apellido_paterno:3);True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"apmaterno";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Apellido_materno:4);True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"pasaporte";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Pasaporte:59);True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"idnacional";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]RUT:6);True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"idnacional_2";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]IDNacional_2:37);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"idnacional_3";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]IDNacional_3:38);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"fechanacimiento";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Fecha_de_nacimiento:5);False:C215;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"fechamuerte";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Fecha_Deceso:89);False:C215;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nacionalidad";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Nacionalidad:7);True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"estadocivil";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Estado_civil:10);True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"sexo";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Sexo:8);False:C215;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"religion";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Religión:9);True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel_estudios";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Nivel_de_estudios:11);True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"exalumno";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Es_ExAlumno:12);False:C215;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"profesion";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Profesion:13);True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"empresa";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Empresa:20);True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"cargo";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Cargo:21);True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Codigo_interno:22);True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"prefijo";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Prefijo:90);True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_persona";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Auto_UUID:36);False:C215;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"observaciones";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Observaciones:32);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True:C214;String:C10([Personas:7]No:1);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True:C214;"1";False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_st_formadepago";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_id_modo_de_pago:94);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"formapago";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_modo_de_pago_new:95);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"foto";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Fotografia:43);False:C215;False:C215)
				
				If ([Personas:7]RUT:6#"")
					If (KRL_FindAndLoadRecordByIndex (->[Profesores:4]RUT:27;->[Personas:7]RUT:6)>No current record:K29:2)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"firma";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Firma:15);False:C215;False:C215)
					End if 
				End if 
				
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefonos")
				If ([Personas:7]Telefono_domicilio:19#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Telefono_domicilio:19);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"domicilio";False:C215;False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				If ([Personas:7]Telefono_profesional:29#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Telefono_profesional:29);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215;False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				If ([Personas:7]Celular:24#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Celular:24);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"celular personal";False:C215;False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"emails")
				If ([Personas:7]eMail:34#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]eMail:34);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"personal";False:C215;False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				If ([Personas:7]ACT_DTE_Enviar_Mail_Cuenta:111#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_DTE_Enviar_Mail_Cuenta:111);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"destino dte";False:C215;False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"direcciones")
				If ([Personas:7]Direccion:14+[Personas:7]Comuna:16+[Personas:7]Codigo_postal:15+[Personas:7]Sector_Domicilio:92#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Direccion:14);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Comuna:16);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Codigo_postal:15);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"sector";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Sector_Domicilio:92);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"region";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Region_o_Estado:18);True:C214;False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"domicilio";False:C215;False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				If ([Personas:7]Direccion_Profesional:23+[Personas:7]Sector_Dom_Profesional:93#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Direccion_Profesional:23);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"sector";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Sector_Dom_Profesional:93);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215;False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				If ([Personas:7]ACT_DireccionEC:67+[Personas:7]ACT_ComunaEC:68+[Personas:7]ACT_CodPostalEC:70#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_DireccionEC:67);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_ComunaEC:68);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_CodPostalEC:70);True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"envio correspondencia";False:C215;False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_apo_academico";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Es_Apoderado_Academico:41);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_apo_cuentas";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ES_Apoderado_de_Cuentas:42);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_profesor_activo";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Es_ProfesorActivo:77);False:C215;False:C215)
				
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_documentotributario";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_DocumentoTributario:45);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_banco_cta";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Banco_Cta:47);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_titular_cta";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Titular_Cta:49);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_nombres_cta";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Nombres_Cta:76);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_apaterno_cta";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Apellido_Paterno_Cta:74);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_amaterno_cta";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Apellido_Materno_Cta:75);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_rut_cta";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_RUTTitutal_Cta:50);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_numero_cta";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Numero_Cta:51);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_tipo_tc";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Tipo_TC:52);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_banco_tc";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Banco_TC:53);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_numero_tc";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Numero_TC:54);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_titular_tc";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Titular_TC:55);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_nombres_tc";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Nombres_TC:73);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_apaterno_tc";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Apellido_Paterno_TC:71);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_amaterno_tc";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Apellido_Materno_TC:72);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_mes_tc";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_MesVenc_TC:57);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_year_tc";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_AñoVenc_TC:58);False:C215;False:C215)
				  //aca hay que meter xpass
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_esinternacional_tc";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_TCEsInternacional:86);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_tipo_td";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Tipo_TD:106);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_banco_td";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Banco_TD:101);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_numero_td";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Numero_TD:104);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_titular_td";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Titular_TD:107);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_nombres_td";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Nombres_TD:103);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_apaterno_td";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Apellido_Paterno_TD:99);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_amaterno_td";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_Apellido_Materno_TD:98);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_mes_td";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_MesVenc_TD:102);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_year_td";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_AñoVenc_TD:100);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_esinternacional_td";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_TDesInternacional:108);False:C215;False:C215)
				  //aca hay que meter xpass_td
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_diacargo";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_DiaCargo:61);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_codigo_pac";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_CodMandatoPAC:62);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_codigo_pat";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_CodMandatoPAT:63);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_afectointereses";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_AfectoIntereses:64);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_numerocargas";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_NumCargas:65);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_cuotas_cup";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_NoCuotasCup:80);False:C215;False:C215)
				
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_monto_protestado_no_reemplazado";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_mon_prot_no_reemp:96);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_monto_a_fecha";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_monto_a_fecha:97);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_enviarmail_dte";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_DTE_Enviar_Mail:110);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_tiporeceptor_dte";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_ReceptorDT_Tipo:112);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_uuidapdoreceptor_dte";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_ReceptorDT_id_Apdo:113);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_uuidterreceptor_dte";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]ACT_ReceptorDT_id_Ter:114);False:C215;False:C215)
				
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_montos_proyectados_ejercicio";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]MontosProyectados_Ejercicio:81);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_montos_emitidos_ejercicio";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]MontosEmitidos_Ejercicio:82);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_montos_pagados_ejercicio";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]MontosPagados_Ejercicio:84);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_deuda_vencida_ejercicio";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]DeudaVencida_Ejercicio:83);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"act_saldo_ejercicio";True:C214;CONDOR_ExportDataTransformer (->[Personas:7]Saldo_Ejercicio:85);False:C215;False:C215)
				
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2#0)
				If (Records in selection:C76([Familia_RelacionesFamiliares:77])>0)
					ARRAY LONGINT:C221($al_relacionesfamiliares;0)
					LONGINT ARRAY FROM SELECTION:C647([Familia_RelacionesFamiliares:77];$al_relacionesfamiliares)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"familias")
					For ($x;1;Size of array:C274($al_relacionesfamiliares))
						KRL_GotoRecord (->[Familia_RelacionesFamiliares:77];$al_relacionesfamiliares{$x})
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"familia")
						If (Not:C34(Is nil pointer:C315($y_UUIDFamiliasXEnviar)))
							$uuid:=KRL_GetTextFieldData (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Auto_UUID:23)
							If (($uuid#"") & (Find in array:C230($y_UUIDFamiliasXEnviar->;$uuid)=-1))
								APPEND TO ARRAY:C911($y_UUIDFamiliasXEnviar->;$uuid)
							End if 
						End if 
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_familia";True:C214;CONDOR_ExportDataTransformer (->[Familia_RelacionesFamiliares:77]ID_Familia:2);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"tiporelacion";True:C214;CONDOR_ExportDataTransformer (->[Familia_RelacionesFamiliares:77]Tipo_Relación:4);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_relacion";True:C214;CONDOR_ExportDataTransformer (->[Familia_RelacionesFamiliares:77]Auto_UUID:7);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"parentesco";True:C214;CONDOR_ExportDataTransformer (->[Familia_RelacionesFamiliares:77]Parentesco:6);True:C214;False:C215)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					End for 
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				
				If ([Personas:7]RUT:6#"")
					$vl_rnProfe:=KRL_FindAndLoadRecordByIndex (->[Profesores:4]RUT:27;->[Personas:7]RUT:6)
					If ($vl_rnProfe>No current record:K29:2)
						APPEND TO ARRAY:C911($y_UUIDProfesoresEnviados->;[Profesores:4]Auto_UUID:41)
						If (KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]NoEmployee:7;->[Profesores:4]Numero:1;False:C215)>No current record:K29:2)
							CONDOR_ExportSAXCreateNode ($refXMLDoc;"identificacion";True:C214;CONDOR_ExportDataTransformer (->[xShell_Users:47]login:9);True:C214;False:C215)  //usuario
							CONDOR_ExportSAXCreateNode ($refXMLDoc;"clave";True:C214;CONDOR_ExportDataTransformer (->[xShell_Users:47]xPass:13);False:C215;False:C215)  //usuario
							CONDOR_ExportSAXCreateNode ($refXMLDoc;"email";True:C214;CONDOR_ExportDataTransformer (->[xShell_Users:47]email:20);True:C214;False:C215)  //usuario
						End if 
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"profesor")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"activo";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Inactivo:62);False:C215;False:C215)  //20150126 RCH
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"departamento";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Departamento:14);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"cargofuncionario";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Cargo:19);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"oficina";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Oficina:22);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"anexo";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Anexo:23);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"habilitacion";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Habilitacion_MinEduc:26);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"iniciales";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Iniciales:29);True:C214;False:C215)  //usuario
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_tutor";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Es_Tutor:34);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_entrevistador";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Es_Entrevistador_Admisiones:35);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_examinador";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Es_Examinador_Admisiones:63);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_presentador";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Es_Presentador_Admisiones:74);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_clase";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Horas_de_Clase:50);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_permanencia";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Horas_de_Permanencia:51);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_jefatura";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Horas_de_Jefatura:52);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_administrativas";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Horas_administrativas:53);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_semanales";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Total_Horas_semanales:54);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_docente";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Es_docente:76);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Codigo_interno:30);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Numero:1);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True:C214;"3";False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_profesor";True:C214;CONDOR_ExportDataTransformer (->[Profesores:4]Auto_UUID:41);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"emails")
						If ([Profesores:4]eMail_profesional:38#"")
							CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
							CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Profesores:4]eMail_profesional:38;True:C214;False:C215)
							CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215)
							SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						End if 
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					End if 
					$vl_rnAlumno:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]RUT:5;->[Personas:7]RUT:6)
					If ($vl_rnAlumno>No current record:K29:2)
						APPEND TO ARRAY:C911($y_UUIDAlumnosEnviados->;[Alumnos:2]auto_uuid:72)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"alumno")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Codigo_interno:6);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"grupo";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Grupo:11);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"curso";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]curso:20);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_ingreso";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Fecha_de_Ingreso:41);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_retiro";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Fecha_de_retiro:42);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"motivo_retiro";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Motivo_de_retiro:43);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"estatus";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Status:50);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero_matricula";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]numero_de_matricula:51);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero_lista";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]no_de_lista:53);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero_folio";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]NumeroDeFolio:103);True:C214;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"hijo_funcionario";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Hijo_funcionario:67);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"vive_con";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Vive_con:81);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"nacido_en";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Nacido_en:10);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel_ingreso";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Nivel_al_que_ingreso:35);True:C214;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"observaciones";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Observaciones_generales:39);True:C214;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_primera_matricula";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Fecha_PrimeraMatricula:86);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_matricula_actual";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Fecha_Matricula:108);False:C215;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_apoacademico";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Apoderado_académico_Número:27);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_apocuentas";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Apoderado_Cuentas_Número:28);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_familia";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Familia_Número:24);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True:C214;String:C10([Alumnos:2]numero:1);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True:C214;"2";False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_alumno";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]auto_uuid:72);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_creacion";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Fecha_de_Creacion:21);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_modificacion";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Fecha_de_modificacion:22);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"colegio_origen";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Colegio_de_origen:25);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"seccion";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Sección:26);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_nivel";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]nivel_numero:29);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_tutor";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Tutor_numero:36);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"patente_bus";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Patente_bus_escolar:37);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"colacion";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Colación:52);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_promedioemedia";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Chile_PromedioEMedia:73);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_sumanotasemedia";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Chile_SumaNotasEMedia:74);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_totalasinaturasemedia";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Chile_TotalAsignaturasEMedia:75);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_puntajepromedioemedia";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Chile_PuntajePromedioEM:92);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_repitente";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Es_Repitente:77);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"interno";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Alumno_Internado:82);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"curso_al_retirarse";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Curso_alRetirarse:83);True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_nivel_al_retirarse";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]NoNIvel_alRetirarse:84);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"oculto_en_nominas";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]ocultoEnNominas:89);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"exalumno";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Es_ExAlumno:90);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"year_egreso";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]AgnoEgreso:91);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"ranking_en_curso";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]RankingEnCurso:93);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"ranking_en_nivel";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]RankingEnNivel:94);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_custodio";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]ID_Custodio:99);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"va_a_colegio_corporacion";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Va_a_colegio_del_grupo:101);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"colegio_destino";True:C214;CONDOR_ExportDataTransformer (->[Alumnos:2]Colegio_destino:102);True:C214;False:C215)
						CONDOR_SendStudentHData ($refXMLDoc)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						If (Not:C34(Is nil pointer:C315($y_UUIDFamiliasXEnviar)))
							$uuid:=KRL_GetTextFieldData (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;->[Familia:78]Auto_UUID:23)
							If (($uuid#"") & (Find in array:C230($y_UUIDFamiliasXEnviar->;$uuid)=-1))
								APPEND TO ARRAY:C911($y_UUIDFamiliasXEnviar->;$uuid)
							End if 
						End if 
					End if 
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre persona
			End if 
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size;__ ("Exportando persona ")+[Personas:7]Apellidos_y_nombres:30+", "+String:C10($indice)+__ (" de ")+String:C10($size)+"...")
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
End if 


