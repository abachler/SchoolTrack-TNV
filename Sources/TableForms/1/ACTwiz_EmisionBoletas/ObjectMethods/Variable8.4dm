Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (vi_PageNumber=2)
		IT_SetButtonState (True:C214;->bPrev;->bNext)
	: (vi_PageNumber=3)
		If ((vi_Selected=0) & (f1=1) & (f2=0) & (f3=0))  //si no se encuentran boletas que emitir se deshabilita el botón.
			If (Not:C34(IT_AltKeyIsDown ))
				_O_DISABLE BUTTON:C193(bNext)
			End if 
		End if 
		_O_ENABLE BUTTON:C192(bPrev)
	: (vi_PageNumber=4)
		
		  // 20160626 RCH Se marca para tercero si solo se tiene en selección avisos o pagos para terceros
		C_LONGINT:C283($l_var)
		e1:=cb_EmiteXApoderado
		e2:=cb_EmiteXCuenta
		e3:=0
		USE SET:C118("Selection")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_var)
		  //SET QUERY LIMIT(1)
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26#0)
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0)
		End case 
		If ($l_var=Records in set:C195("Selection"))
			e1:=0
			e2:=0
			e3:=1
		End if 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		  //SET QUERY LIMIT(0)
		
	: (vi_PageNumber=5)
		Case of 
			: (b1=1)
				  //$msg:="AccountTrack está listo para emitir documentos tributarios de acuerdo con la espe"+"cificación de cada apoderado de cuentas. ¿Desea continuar?"
				$r:=CD_Dlog (0;__ ("AccountTrack está listo para emitir documentos tributarios de acuerdo con la especificación de cada apoderado de cuentas. ¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
			: (b2=1)
				  //$msg:="AccountTrack está listo para emitir recibos. ¿Desea continuar?"
				$r:=CD_Dlog (0;__ ("AccountTrack está listo para emitir recibos. ¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
			: (b3=1)
				  //$msg:="AccountTrack está listo para reemplazar recibos por documentos tributarios de acu"+"erdo con la especificación de cada apoderado de cuentas. ¿Desea continuar?"
				$r:=CD_Dlog (0;__ ("AccountTrack está listo para reemplazar recibos por documentos tributarios de acuerdo con la especificación de cada apoderado de cuentas. ¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
		End case 
		  //$r:=CD_Dlog (0;$msg;"";"Si";"No")
		If ($r=1)
			
			  //20131216 RCH Generacion de CDFIs...
			  //ACTbol_ResumenDocs2Print 
			
			C_BOOLEAN:C305(vbACT_RegistrarIDSBoletas;$b_emisionOK)
			ARRAY LONGINT:C221(alACT_idsBoletasEmitidas;0)
			
			vtACT_ErrorString:=""
			vtACT_ErrorStringForm:=""
			If (bGenerarCFDI=1)
				vbACT_RegistrarIDSBoletas:=True:C214
				$b_emisionOK:=True:C214
			End if 
			
			ACTbol_ResumenDocs2Print 
			
			If (bGenerarCFDI=1)
				  //filtro por razon social para leer configuracion
				ARRAY LONGINT:C221($alACT_idsRS;0)
				READ ONLY:C145([ACT_Boletas:181])
				QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;alACT_idsBoletasEmitidas)
				CREATE SET:C116([ACT_Boletas:181];"setBoletas")
				DISTINCT VALUES:C339([ACT_Boletas:181]ID_RazonSocial:25;$alACT_idsRS)
				If (Find in array:C230($alACT_idsRS;0)#-1)
					$alACT_idsRS{Find in array:C230($alACT_idsRS;0)}:=-1
				End if 
				AT_DistinctsArrayValues (->$alACT_idsRS)
				
				For ($l_indiceRS;1;Size of array:C274($alACT_idsRS))
					vlACT_RSSel:=$alACT_idsRS{$l_indiceRS}
					ACTcfdi_OpcionesGenerales ("OnLoadConf";->vlACT_RSSel)
					
					USE SET:C118("setBoletas")
					
					If (vlACT_RSSel<=0)
						QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=-1;*)
						QUERY SELECTION:C341([ACT_Boletas:181]; | ;[ACT_Boletas:181]ID_RazonSocial:25=0)
					Else 
						QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=vlACT_RSSel)
					End if 
					
					SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;alACT_idsBoletasEmitidas)
					ACTcfdi_OpcionesGenerales ("GeneraArchivoEnCliente";->alACT_idsBoletasEmitidas)
					If (vtACT_ErrorString#"")
						$b_emisionOK:=False:C215
						LOG_RegisterEvt (vtACT_ErrorString)
					End if 
				End for 
				SET_ClearSets ("setBoletas")
				
				If ($b_emisionOK)
					vtACT_ErrorStringForm:=__ ("Generación de archivos CFDI exitosa.")
				Else 
					vtACT_ErrorStringForm:=__ ("Generación de archivos CFDI con errores. Vea el Registro de Actividades del sistema.")
				End if 
				
			End if 
			vbACT_RegistrarIDSBoletas:=False:C215
			ARRAY LONGINT:C221(alACT_idsBoletasEmitidas;0)
			
		Else 
			vi_PageNumber:=4
			FORM GOTO PAGE:C247(vi_PageNumber)
			POST KEY:C465(Character code:C91("+");256)
		End if 
End case 