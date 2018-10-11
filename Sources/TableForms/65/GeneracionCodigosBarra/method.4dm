  // [xxBBL_Preferencias].GeneracionCodigosBarra()
  // Por: Alberto Bachler: 23/11/13, 15:22:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_abajoB;$l_abajoV;$l_arriba;$l_arribaB;$l_arribaV;$l_codigosProtegidos;$l_derecha;$l_derechaB;$l_derechaV)
C_LONGINT:C283($l_desplazamientoV;$l_izquierda;$l_izquierdaB;$l_izquierdaV;$l_lectoresConIDNacional1;$l_lectoresConIDNacional2;$l_lectoresConIDNacional3;$l_numeroRegistros;$l_posicionBotones)
C_POINTER:C301($y_anteponerPrefijo)
C_TEXT:C284($t_avisoIDNacional;$t_etiqueta;$t_mensaje;$t_numeroRegistros)


Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;"fondo";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Fondo)
		
		vbBBL_incluirBarcodeProtegidos:=False:C215
		Case of 
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Items:61])) | (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Subscripciones:117])))
				USE SET:C118("<>RegeneracionBarcodes")
				Case of 
					: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Items:61]))
						KRL_RelateSelection (->[BBL_Registros:66]Número_de_item:1;->[BBL_Items:61]Numero:1)
					: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Subscripciones:117]))
						KRL_RelateSelection (->[BBL_Items:61]Número_de_suscripción:41;->[BBL_Subscripciones:117]ID:1)
						KRL_RelateSelection (->[BBL_Registros:66]Número_de_item:1;->[BBL_Items:61]Numero:1)
				End case 
				CREATE SET:C116([BBL_Registros:66];"<>RegeneracionBarcodes")
				$t_numeroRegistros:=String:C10(Records in selection:C76([BBL_Registros:66]))
				$t_mensaje:=OBJECT Get title:C1068(*;"mensaje.documentos")
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_numeroRegistros)
				OBJECT SET TITLE:C194(*;"mensaje.documentos";$t_mensaje)
				Case of 
					: ([xxBBL_Preferencias:65]Registro_CampoFuenteBarcode:27=Field:C253(->[BBL_Registros:66]ID:3))
						r1_IdentificadorInterno:=1
					: ([xxBBL_Preferencias:65]Registro_CampoFuenteBarcode:27=Field:C253(->[BBL_Registros:66]No_Registro:25))
						r2_NumeroRegistro:=1
				End case 
				
				$y_anteponerPrefijo:=OBJECT Get pointer:C1124(Object named:K67:5;"anteponerPrefijo.Documento")
				$y_anteponerPrefijo->:=Num:C11(<>bBBL_BarcodeRegistroConPrefijo)
				
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_codigosProtegidos)
				QUERY SELECTION:C341([BBL_Registros:66];[BBL_Registros:66]Barcode_Protegido:28=True:C214)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				
				If ($l_codigosProtegidos=0)
					OBJECT GET COORDINATES:C663(*;"anteponerPrefijo.Documento";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
					$l_posicionBotones:=$l_abajo+50
					OBJECT GET COORDINATES:C663(*;"boton@";$l_izquierdaB;$l_arribaB;$l_derechaB;$l_abajoB)
					OBJECT SET VISIBLE:C603(*;"incluirProtegidos.documentos";False:C215)
					$l_desplazamientoV:=$l_posicionBotones-$l_arribaB
					OBJECT MOVE:C664(*;"boton.@";0;$l_desplazamientoV)
				Else 
					$t_etiqueta:=OBJECT Get title:C1068(*;"incluirProtegidos.documentos")
					OBJECT SET TITLE:C194(*;"incluirProtegidos.documentos";Replace string:C233($t_etiqueta;"^0";String:C10($l_codigosProtegidos)))
					OBJECT GET COORDINATES:C663(*;"incluirProtegidos.documentos";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
					$l_posicionBotones:=$l_abajo+50
					OBJECT GET COORDINATES:C663(*;"boton@";$l_izquierdaB;$l_arribaB;$l_derechaB;$l_abajoB)
					$l_desplazamientoV:=$l_posicionBotones-$l_arribaB
					OBJECT MOVE:C664(*;"boton.@";0;$l_desplazamientoV)
				End if 
				FORM GOTO PAGE:C247(1)
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Lectores:72]))
				USE SET:C118("<>RegeneracionBarcodes")
				$l_numeroRegistros:=Records in selection:C76([BBL_Lectores:72])
				$t_mensaje:=OBJECT Get title:C1068(*;"mensaje.lectores")
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10($l_numeroRegistros))
				OBJECT SET TITLE:C194(*;"mensaje.lectores";$t_mensaje)
				
				Case of 
					: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]ID:1))
						l1_IdentificadorInterno:=1
					: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]RUT:7))
						l2_IdentificadorNacional:=1
					: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]IDNacional_2:33))
						l3_IdentificadorNacional:=1
					: ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=Field:C253(->[BBL_Lectores:72]IDNacional_3:34))
						l4_IdentificadorNacional:=1
				End case 
				
				$y_anteponerPrefijo:=OBJECT Get pointer:C1124(Object named:K67:5;"anteponerPrefijo.Lectores")
				$y_anteponerPrefijo->:=Num:C11(<>bBBL_BarcodeLectorConPrefijo)
				
				OBJECT SET ENTERABLE:C238(Mti_BarCode;False:C215)
				_O_DISABLE BUTTON:C193(bDelMedia)
				_O_DISABLE BUTTON:C193(bDelGrupoLectores)
				
				$t_avisoIDNacional:=__ ("Si no hay información en ^0 se utilizará el número secuencial interno.")
				OBJECT SET TITLE:C194(*;"l2_IdentificadorNacional.aviso";Replace string:C233($t_avisoIDNacional;"^0";<>at_IDNacional_Names{1}))
				OBJECT SET TITLE:C194(*;"l3_IdentificadorNacional.aviso";Replace string:C233($t_avisoIDNacional;"^0";<>at_IDNacional_Names{2}))
				OBJECT SET TITLE:C194(*;"l4_IdentificadorNacional.aviso";Replace string:C233($t_avisoIDNacional;"^0";<>at_IDNacional_Names{3}))
				
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_lectoresConIDNacional1)
				QUERY SELECTION:C341([BBL_Lectores:72];[BBL_Lectores:72]RUT:7#"")
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_lectoresConIDNacional2)
				QUERY SELECTION:C341([BBL_Lectores:72];[BBL_Lectores:72]IDNacional_2:33#"")
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_lectoresConIDNacional3)
				QUERY SELECTION:C341([BBL_Lectores:72];[BBL_Lectores:72]IDNacional_3:34#"")
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_codigosProtegidos)
				QUERY SELECTION:C341([BBL_Lectores:72];[BBL_Lectores:72]Barcode_Protegido:39=True:C214)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				
				OBJECT SET TITLE:C194(*;"l2_IdentificadorNacional";<>at_IDNacional_Names{1}+" - "+String:C10($l_lectoresConIDNacional1)+" "+__ ("lectore(s)"))
				OBJECT SET TITLE:C194(*;"l3_IdentificadorNacional";<>at_IDNacional_Names{2}+" - "+String:C10($l_lectoresConIDNacional2)+" "+__ ("lectore(s)"))
				OBJECT SET TITLE:C194(*;"l4_IdentificadorNacional";<>at_IDNacional_Names{3}+" - "+String:C10($l_lectoresConIDNacional3)+" "+__ ("lectore(s)"))
				
				OBJECT SET VISIBLE:C603(*;"l2_IdentificadorNacional@";$l_lectoresConIDNacional1>0)
				OBJECT SET VISIBLE:C603(*;"l3_IdentificadorNacional@";$l_lectoresConIDNacional2>0)
				OBJECT SET VISIBLE:C603(*;"l4_IdentificadorNacional@";$l_lectoresConIDNacional3>0)
				
				If ($l_lectoresConIDNacional1=0)
					OBJECT MOVE:C664(*;"l2_IdentificadorNacional@";0;-32)
					OBJECT MOVE:C664(*;"l3_IdentificadorNacional@";0;-50)
					OBJECT MOVE:C664(*;"l4_IdentificadorNacional@";0;-50)
				End if 
				
				If ($l_lectoresConIDNacional2=0)
					OBJECT MOVE:C664(*;"l3_IdentificadorNacional@";0;-50)
					OBJECT MOVE:C664(*;"l4_IdentificadorNacional@";0;-50)
				End if 
				
				If ($l_lectoresConIDNacional3=0)
					OBJECT MOVE:C664(*;"l4_IdentificadorNacional@";0;-50)
				End if 
				
				Case of 
					: ($l_lectoresConIDNacional3>0)
						OBJECT GET COORDINATES:C663(*;"l4_IdentificadorNacional.aviso";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
					: ($l_lectoresConIDNacional2>0)
						OBJECT GET COORDINATES:C663(*;"l3_IdentificadorNacional.aviso";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
					: ($l_lectoresConIDNacional1>0)
						OBJECT GET COORDINATES:C663(*;"l2_IdentificadorNacional.aviso";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
					Else 
						OBJECT GET COORDINATES:C663(*;"l1_IdentificadorInterno";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
				End case 
				
				OBJECT GET COORDINATES:C663(*;"anteponerPrefijo.Lectores";$l_izquierdaOpciones;$l_arribaOpciones;$l_derechaOpciones;$l_abajoOpciones)
				$l_desplazamiento:=($l_abajo+32)-$l_arribaOpciones
				OBJECT MOVE:C664(*;"anteponerPrefijo.Lectores";0;$l_desplazamiento)
				OBJECT MOVE:C664(*;"incluirProtegidos.lectores";0;$l_desplazamiento)
				OBJECT MOVE:C664(*;"boton.@";0;$l_desplazamiento)
				
				
				OBJECT SET VISIBLE:C603(*;"l2_IdentificadorNacional.aviso";($l_lectoresConIDNacional1#$l_numeroRegistros))
				OBJECT SET VISIBLE:C603(*;"l3_IdentificadorNacional.aviso";($l_lectoresConIDNacional1#$l_numeroRegistros))
				OBJECT SET VISIBLE:C603(*;"l4_IdentificadorNacional.aviso";($l_lectoresConIDNacional1#$l_numeroRegistros))
				
				OBJECT SET VISIBLE:C603(*;"l2_IdentificadorNacional@";$l_lectoresConIDNacional1>0)
				OBJECT SET VISIBLE:C603(*;"l3_IdentificadorNacional@";$l_lectoresConIDNacional2>0)
				OBJECT SET VISIBLE:C603(*;"l4_IdentificadorNacional@";$l_lectoresConIDNacional3>0)
				
				If ($l_codigosProtegidos=0)
					OBJECT SET VISIBLE:C603(*;"incluirProtegidos.lectores";False:C215)
					OBJECT MOVE:C664(*;"boton.@";0;-40)
				Else 
					$t_etiqueta:=OBJECT Get title:C1068(*;"incluirProtegidos.lectores")
					OBJECT SET TITLE:C194(*;"incluirProtegidos.lectores";Replace string:C233($t_etiqueta;"^0";String:C10($l_codigosProtegidos)))
				End if 
				FORM GOTO PAGE:C247(2)
		End case 
		
		GET WINDOW RECT:C443($l_izquierdaV;$l_arribaV;$l_derechaV;$l_abajoV)
		OBJECT GET COORDINATES:C663(*;"boton@";$l_izquierdaB;$l_arribaB;$l_derechaB;$l_abajoB)
		SET WINDOW RECT:C444($l_izquierdaV;$l_arribaV;$l_derechaV;$l_abajoB+20)
		
	: (Form event:C388=On Deactivate:K2:10)
		CANCEL:C270
		
	: (Form event:C388=On Validate:K2:3)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

