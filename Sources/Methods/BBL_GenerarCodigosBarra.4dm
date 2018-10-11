//%attributes = {}
  // BBL_GeneracionCodigosBarra()
  // Por: Alberto Bachler: 23/11/13, 15:44:34
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($y_nil)
C_LONGINT:C283($l_estado;$l_IdProceso;$l_numeroTabla;$l_opcionUsuario;$l_Tabla;$l_tiempo)
C_TEXT:C284($t_Mensaje;$t_nombreConjuntoActual;$t_nombreProceso;$t_titulo)

If (False:C215)
	C_LONGINT:C283(BBL_GenerarCodigosBarra ;$1)
End if 



If (USR_GetMethodAcces (Current method name:C684))
	PROCESS PROPERTIES:C336(Current process:C322;$t_nombreProceso;$l_estado;$l_tiempo)
	If ($t_nombreProceso#"Generación de Códigos de Barra")
		UNLOAD RECORD:C212(yBWR_currentTable->)
		$t_nombreConjuntoActual:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		COPY SET:C600($t_nombreConjuntoActual;"<>RegeneracionBarcodes")
		$l_Tabla:=Table:C252(yBWR_currentTable)
		$l_IdProceso:=New process:C317(Current method name:C684;Pila_512K;"Generación de Códigos de Barra";$l_Tabla)
	Else 
		BBL_LeePrefsCodigosBarra 
		
		$l_numeroTabla:=$1
		yBWR_currentTable:=Table:C252($l_numeroTabla)
		READ WRITE:C146([xxBBL_Preferencias:65])
		ALL RECORDS:C47([xxBBL_Preferencias:65])
		FIRST RECORD:C50([xxBBL_Preferencias:65])
		WDW_OpenFormWindow (->[xxBBL_Preferencias:65];"GeneracionCodigosBarra";-1;Movable dialog box:K34:7)
		DIALOG:C40([xxBBL_Preferencias:65];"GeneracionCodigosBarra")
		CLOSE WINDOW:C154
		If (OK=1)
			Case of 
				: ($l_numeroTabla=Table:C252(->[BBL_Lectores:72]))
					START TRANSACTION:C239
					SET QUERY AND LOCK:C661(True:C214)
					USE SET:C118("<>RegeneracionBarcodes")
					QUERY SELECTION:C341([BBL_Lectores:72];[BBL_Lectores:72]ID:1>0)
					If (Records in set:C195("LockedSet")>0)
						USE SET:C118("<>RegeneracionBarcodes")
						$t_titulo:=__ ("Generación de códigos de barra para ^0 lectores")
						$t_Mensaje:=__ ("^0 registro(s) de lectores están siendo editados en este momento.\rNo será posible generar códigos de barra para esos lectores.\r\r¿Desea omitirlos  y generar los códigos de barra para los demás lectores?")
						$t_titulo:=Replace string:C233($t_titulo;"^0";String:C10(Records in selection:C76([BBL_Lectores:72])))
						$t_Mensaje:=Replace string:C233($t_Mensaje;"^0";String:C10(Records in set:C195("LockedSet")))
						DIFFERENCE:C122("<>RegeneracionBarcodes";"LockedSet";"<>RegeneracionBarcodes")
						$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_Mensaje;__ ("Omitir y generar códigos de barra");__ ("Intentar más tarde"))
						If ($l_opcionUsuario=1)
							USE SET:C118("<>RegeneracionBarcodes")
							BBLpat_RegenerarCodigosDeBarra (vbBBL_incluirBarcodeProtegidos)
							SET QUERY AND LOCK:C661(False:C215)
							VALIDATE TRANSACTION:C240
						Else 
							SET QUERY AND LOCK:C661(False:C215)
							CANCEL TRANSACTION:C241
						End if 
					Else 
						USE SET:C118("<>RegeneracionBarcodes")
						BBLpat_RegenerarCodigosDeBarra (vbBBL_incluirBarcodeProtegidos)
						SET QUERY AND LOCK:C661(False:C215)
						VALIDATE TRANSACTION:C240
					End if 
					
				: (($l_numeroTabla=Table:C252(->[BBL_Items:61])) | ($l_numeroTabla=Table:C252(->[BBL_Subscripciones:117])))
					START TRANSACTION:C239
					SET QUERY AND LOCK:C661(True:C214)
					USE SET:C118("<>RegeneracionBarcodes")
					QUERY SELECTION:C341([BBL_Registros:66];[BBL_Registros:66]ID:3>0)
					If (Records in set:C195("LockedSet")>0)
						USE SET:C118("<>RegeneracionBarcodes")
						$t_titulo:=__ ("Generación de códigos de barra para ^0 documentos")
						$t_Mensaje:=__ ("^0 registro(s) de documentos están siendo editados en este momento.\rNo será posible generar códigos de barra para esos documentos.\r\r¿Desea omitirlos y generar los códigos de barra para los demás documentos?")
						$t_titulo:=Replace string:C233($t_titulo;"^0";String:C10(Records in selection:C76([BBL_Registros:66])))
						$t_Mensaje:=Replace string:C233($t_Mensaje;"^0";String:C10(Records in set:C195("LockedSet")))
						DIFFERENCE:C122("<>RegeneracionBarcodes";"LockedSet";"<>RegeneracionBarcodes")
						$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_Mensaje;__ ("Omitir y generar códigos de barra");__ ("Intentar más tarde"))
						If ($l_opcionUsuario=1)
							USE SET:C118("<>RegeneracionBarcodes")
							BBLreg_RegenerarCodigosDeBarra (vbBBL_incluirBarcodeProtegidos)
							SET QUERY AND LOCK:C661(False:C215)
							VALIDATE TRANSACTION:C240
						Else 
							SET QUERY AND LOCK:C661(False:C215)
							CANCEL TRANSACTION:C241
						End if 
					Else 
						USE SET:C118("<>RegeneracionBarcodes")
						BBLreg_RegenerarCodigosDeBarra (vbBBL_incluirBarcodeProtegidos)
						SET QUERY AND LOCK:C661(False:C215)
						VALIDATE TRANSACTION:C240
					End if 
					
			End case 
		End if 
	End if 
End if 
