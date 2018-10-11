//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saúl Ponce
  // Fecha y hora: 23/12/17, 09:32:47
  // ----------------------------------------------------
  // Método: UD_v20171223_FixARCodeSII
  // Descripción
  // En el Ticket Nº 196102, encontramos un problema al intentar emitir una Nota de Crédito para una Boleta que fuese de tipo exenta impresa. 
  // Este tipo de documento, estaba quedando con un "32" en el campo [ACT_Boletas]codigo_SII, provocando que no se pudiera obtener el CAE,
  // ya que no es un texto válido para AR. Los tipos de documentos válidos son: 11 para factura, 12 para NC, 13 para NC y 15 para recibos.
  // 
  // El error implicó cambiar el método ACTbol_AsignaCodigoSII()
  //
  // Parámetros
  // ----------------------------------------------------

If (<>gCountryCode="AR")
	If (ACT_AccountTrackInicializado )
		
		READ WRITE:C146([ACT_Boletas:181])
		
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33="32")
		If (Records in selection:C76([ACT_Boletas:181])>0)
			
			C_TEXT:C284($t_mensaje)
			C_BOOLEAN:C305($b_estadoTemp)
			C_LONGINT:C283($l_barra;$xyz)
			ARRAY LONGINT:C221($al_recNumBoletas;0)
			ARRAY LONGINT:C221($al_idUpdates;0)
			ARRAY LONGINT:C221($al_idNoUpdate;0)
			
			
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;>)
			$l_barra:=IT_Progress (1;0;0;"Verificando códigos de documentos tributarios...")
			SELECTION TO ARRAY:C260([ACT_Boletas:181];$al_recNumBoletas)
			
			For ($xyz;1;Size of array:C274($al_recNumBoletas))
				
				GOTO RECORD:C242([ACT_Boletas:181];$al_recNumBoletas{$xyz})
				
				If (Not:C34(Locked:C147([ACT_Boletas:181])))
					$b_estadoTemp:=[ACT_Boletas:181]documento_electronico:29
					[ACT_Boletas:181]documento_electronico:29:=True:C214
					[ACT_Boletas:181]codigo_SII:33:=""
					ACTbol_AsignaCodigoSII 
					[ACT_Boletas:181]documento_electronico:29:=$b_estadoTemp
					SAVE RECORD:C53([ACT_Boletas:181])
					APPEND TO ARRAY:C911($al_idUpdates;[ACT_Boletas:181]ID:1)
				Else 
					APPEND TO ARRAY:C911($al_idNoUpdate;[ACT_Boletas:181]ID:1)
				End if 
				
				IT_Progress (0;$l_barra;$xyz/Size of array:C274($al_recNumBoletas))
			End for 
			$l_barra:=IT_Progress (-1;$l_barra)
			
			If (Size of array:C274($al_idUpdates)>0)
				LOG_RegisterEvt ("Actualización de campo "+ST_Qte ("codigo_SII")+" en la tabla "+ST_Qte ("Boletas")+" para los siguientes registros: "+AT_array2text (->$al_idUpdates;"; "))
			End if 
			If (Size of array:C274($al_idNoUpdate)>0)
				LOG_RegisterEvt ("No se logró actualizar el campo "+ST_Qte ("codigo_SII")+" en la tabla "+ST_Qte ("Boletas")+" para los siguientes registros: "+AT_array2text (->$al_idNoUpdate;"; "))
			End if 
			
		Else 
			LOG_RegisterEvt ("No existen documentos tributarios que requieran ser corregidos en el campo "+ST_Qte ("codigo_SII")+".")
		End if 
		KRL_UnloadReadOnly (->[ACT_Boletas:181])
	End if 
End if 