//%attributes = {}
  //IN_ACT_CargaTablaBancos

C_BLOB:C604($blob)
C_LONGINT:C283($index)
ARRAY TEXT:C222($at_numConvenio;0)
ARRAY TEXT:C222($al_idsBancos;0)
ARRAY TEXT:C222($at_Paises;0)



If (Application type:C494=4D Remote mode:K5:5)
	$proc:=Execute on server:C373(Current method name:C684;Pila_256K;"Cargando lista de bancos")
Else 
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Bancos.txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		READ WRITE:C146([xxACT_Bancos:129])
		QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]mx_NumeroConvenio:5#"")
		SELECTION TO ARRAY:C260([xxACT_Bancos:129]mx_NumeroConvenio:5;$at_numConvenio;[xxACT_Bancos:129]Codigo:2;$al_idsBancos;[xxACT_Bancos:129]Pais:3;$at_Paises)
		QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Estandar:4=True:C214)
		DELETE SELECTION:C66([xxACT_Bancos:129])
		RECEIVE VARIABLE:C81(nbRecords)
		For ($i;1;nbRecords)
			KRL_ReceiveRecord (->[xxACT_Bancos:129];True:C214)
			$index:=Find in array:C230($al_idsBancos;[xxACT_Bancos:129]Codigo:2)
			If ($index#-1)
				If ([xxACT_Bancos:129]Pais:3=$at_Paises{$index})
					[xxACT_Bancos:129]mx_NumeroConvenio:5:=$at_numConvenio{Find in array:C230($al_idsBancos;[xxACT_Bancos:129]Codigo:2)}
				End if 
			End if 
			SAVE RECORD:C53([xxACT_Bancos:129])
		End for 
		KRL_UnloadReadOnly (->[xxACT_Bancos:129])
	End if 
	SET CHANNEL:C77(11)
	
	ACTcfgban_ValidaDuplicados 
End if 

  //C_BLOB($blob)
  //
  //If (Application type=4D Client )
  //$proc:=Execute on server(Current method name;Pila_256K;"Cargando lista de bancos")
  //Else 
  //$file:=<>syT_ConfigFilesPath+"Bancos.txt"
  //SET CHANNEL(10;$file)
  //If (ok=1)
  //READ WRITE([xxACT_Bancos])
  //QUERY([xxACT_Bancos];[xxACT_Bancos]Estandar=True)
  //DELETE SELECTION([xxACT_Bancos])
  //RECEIVE VARIABLE(nbRecords)
  //For ($i;1;nbRecords)
  //CREATE RECORD([xxACT_Bancos])
  //RECEIVE VARIABLE($blob)
  //$err:=API Blob To Record (Table(->[xxACT_Bancos]);$blob)
  //SAVE RECORD([xxACT_Bancos])
  //End for 
  //KRL_UnloadReadOnly (->[xxACT_Bancos])
  //End if 
  //SET CHANNEL(11)
  //End if 