//%attributes = {}
  //ACTcae_CierreACT

C_BLOB:C604(xBlob)


If (USR_GetMethodAcces (Current method name:C684))
	  //If (<>lUSR_CurrentUserID<0)
	FLUSH CACHE:C297
	$onServer:=<>onServer
	<>onServer:=False:C215
	<>NoBatchProcessor:=True:C214
	<>NoLog:=True:C214
	<>writeOK:=True:C214
	READ ONLY:C145([xxSTR_Niveles:6])
	
	ARRAY TEXT:C222($aUsers;0)
	ARRAY LONGINT:C221($aMethods;0)
	GET REGISTERED CLIENTS:C650($aUsers;$aMethods)
	If (Application type:C494=4D Remote mode:K5:5)
		CD_Dlog (0;__ ("El cierre de AccountTrack no puede ser ejecutado desde un cliente. Por favor ejecute el cierre en mono usuario"))
	Else 
		DISABLE MENU ITEM:C150(1;5)
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"Cierre";0;4;__ ("Cierre de AccountTrack"))
		DIALOG:C40([xxSTR_Constants:1];"Cierre")
		CLOSE WINDOW:C154
		UNLOAD RECORD:C212([xxSTR_Constants:1])
		If (ok=1)
			  //20110302 RCH Este codigo estaba en la linea 16, fue movido para aca...
			READ WRITE:C146([xShell_BatchRequests:48])
			ALL RECORDS:C47([xShell_BatchRequests:48])
			DELETE SELECTION:C66([xShell_BatchRequests:48])
			READ ONLY:C145([xShell_BatchRequests:48])
			OK:=1
			  //20110302 RCH
			
			READ WRITE:C146([xxACT_Datos_de_Cierre:116])
			QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=vl_Año;*)
			QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=vl_Mes)
			If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=0)
				CREATE RECORD:C68([xxACT_Datos_de_Cierre:116])
				[xxACT_Datos_de_Cierre:116]Year:1:=vl_Año
				[xxACT_Datos_de_Cierre:116]Month:3:=vl_Mes
			End if 
			BLOB_Variables2Blob (->[xxACT_Datos_de_Cierre:116]xPreferences:2;0;->vi_AgnosAvisos;->vi_AgnosPagos;->vi_AgnosDocDep;->vi_AgnosDocTrib;->cb_EliminaHAvisos;->cb_EliminaHPagos;->cb_EliminaHDocDep;->cb_EliminaHDocTrib;->cb_InactivaEgresados;->cb_InactivaRetirados;->cb_LimpiaMatrices;->cb_LimpiaDesctoXCta;->vt_backupFolder;->vt_backupFile;->vl_Mes;->vl_Año;->cb_inicializaUFields;->cb_eliminaDocCarNulos)
			SAVE RECORD:C53([xxACT_Datos_de_Cierre:116])
			xBlob:=[xxACT_Datos_de_Cierre:116]xPreferences:2
			KRL_UnloadReadOnly (->[xxACT_Datos_de_Cierre:116])
			If (Application type:C494=4D Remote mode:K5:5)
				OK:=CD_Dlog (0;__ ("El proceso de cierre se ejecutará en el servidor.\rUna vez iniciado esta estación cliente se cerrará y ningún usuario podrá acceder al sistema hasta el término del proceso.\r¿Desea iniciar el cierre ahora y cerrar este programa ahora?");"";__ ("Si");__ ("No"))
				If (OK=1)
					LOG_RegisterEvt ("Cierre de AccountTrack"+String:C10(vl_Año)+String:C10(vl_Mes))
					ACTcae_RegisterEvent (vl_Año;vl_Mes;"Cierre de ACT en Monousuario iniciado por: "+<>tUSR_CurrentUser+". Pagos con problemas: "+String:C10(Size of array:C274(aQR_Longint1))+" (ids: "+AT_array2text (->aQR_Longint1;" - ";"######")+").")
					$process:=Execute on server:C373("ACTcae_CierreACTProcess";512000;"Cierre del año escolar";xBlob)
					USR_UserQuit 
				End if 
			Else 
				If (Size of array:C274(aQR_Longint1)>0)
					  //$msg:="¿Desea Ud. realmente cerrar AccountTrack ahora a pesar de los problemas con "+String(Size of array(aQR_Longint1))+" pagos.?"
					ok:=CD_Dlog (0;__ ("¿Desea Ud. realmente cerrar AccountTrack ahora a pesar de los problemas con ")+String:C10(Size of array:C274(aQR_Longint1))+__ (" pagos.?");"";__ ("Si");__ ("No"))
				Else 
					  //$msg:="¿Desea Ud. realmente cerrar AccountTrack ahora?"
					ok:=CD_Dlog (0;__ ("¿Desea Ud. realmente cerrar AccountTrack ahora?");"";__ ("Si");__ ("No"))
				End if 
				  //ok:=CD_Dlog (0;$msg;"";"Si";"No")
				If (ok=1)
					LOG_RegisterEvt ("Cierre de AccountTrack"+String:C10(vl_Año)+String:C10(vl_Mes))
					ACTcae_RegisterEvent (vl_Año;vl_Mes;"Cierre de ACT en Monousuario iniciado por: "+<>tUSR_CurrentUser+". Pagos con problemas: "+String:C10(Size of array:C274(aQR_Longint1))+" (ids: "+AT_array2text (->aQR_Longint1;" - ";"######")+").")
					$p:=IT_UThermometer (1;0;__ ("Cerrando AccountTrack..."))
					$wait:=True:C214
					$process:=New process:C317("ACTcae_CierreACTProcess";512000;"Cierre del año escolar";xBlob)
					While ($wait)
						DELAY PROCESS:C323(Current process:C322;5)
						GET PROCESS VARIABLE:C371($process;vbACTcae_Wait;$wait)
						DELAY PROCESS:C323(Current process:C322;5)
					End while 
					SET PROCESS VARIABLE:C370($process;vbACTcae_WaitStop;False:C215)
					IT_UThermometer (-2;$p)
				End if 
			End if 
		End if 
	End if 
	  //Else 
	  //CD_Dlog (0;"Por el momento esta funcionalidad esta reservada para el personal de Colegium S.A"+".")
End if 