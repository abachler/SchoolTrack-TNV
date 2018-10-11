//%attributes = {}
  //PREF_LoadParametersBD
  //Carga en la bd los puertos de conexion de 4D y el web además guarda la configuración de time out de los clientes 4D


If (Application type:C494=4D Server:K5:6)
	
	C_TEXT:C284($CSPort;$CSPortBase;$CTOut;$CTOutBase;$PuertoTCP;$PuertoTCPBase;$vt_valor)
	_O_C_STRING:C293(50;$vs_valor)
	C_BOOLEAN:C305($vb_Modificado)
	$vb_Modificado:=False:C215
	  //si el valor cambio anteriormente, será cargado desde este inicio
	  //PREF_Set (0;"Puerto_TCP";String(Get database parameter(Port ID;$vs_valor)))
	  //
	  //$vt_valor:=""
	  //$vt_valor:=PREF_fGet (0;"ConnectionTimeOut";$vt_valor)
	  //If ($vt_valor#"")
	  //SET DATABASE PARAMETER(4D Server Timeout;Num($vt_valor))
	  //End if
	  //
	  //$vt_valor:=""
	
	  //If ($vt_valor#"")
	  //SET DATABASE PARAMETER(Client Server Port ID;Num($vt_valor))
	  //End if  //$vt_valor:=PREF_fGet (0;"ClientServerPort";$vt_valor)
	
	  // 20120611 ASM Modifico el metodo para setear los datos en el servidor cuando sea necesario.
	$PuertoTCPBase:=PREF_fGet (0;"Puerto_TCP";$vt_valor)
	$CTOutBase:=PREF_fGet (0;"ConnectionTimeOut";$vt_valor)
	$CSPortBase:=PREF_fGet (0;"ClientServerPort";$vt_valor)
	$PuertoTCP:=String:C10(Get database parameter:C643(Port ID:K37:15;$vs_valor))
	$CTOut:=String:C10(Get database parameter:C643(4D Server timeout:K37:13;$vs_valor))
	$CSPort:=String:C10(Get database parameter:C643(Client Server port ID:K37:35;$vs_valor))
	
	  //si el valor cambio anteriormente, será cargado desde este inicio
	  //PREF_Set (0;"Puerto_TCP";String(Get database parameter(Port ID;$vs_valor)))
	
	  //Se configura desde ST, por el asunto de la conexión https
	  //If ($PuertoTCP#$PuertoTCPBase) & ($PuertoTCPBase#"")
	  //SET DATABASE PARAMETER(Port ID;Num($PuertoTCPBase))
	  //START WEB SERVER
	  //STOP WEB SERVER
	  //LOG_RegisterEvt (__ ("Modificación del puerto HTTP, por cambio en las propiedades de la base."))
	  //End if 
	If ($CTOut#$CTOutBase) & ($CTOutBase#"")
		SET DATABASE PARAMETER:C642(4D Server timeout:K37:13;Num:C11($CTOutBase))
		$vb_Modificado:=True:C214
	End if 
	If ($CSPort#$CSPortBase) & ($CSPortBase#"")
		SET DATABASE PARAMETER:C642(Client Server port ID:K37:35;Num:C11($CSPortBase))
		$vb_Modificado:=True:C214
	End if 
	If ($vb_Modificado)
		LOG_RegisterEvt (__ ("Reinicio del Servidor, por cambio en las propiedades de la base."))
		QUIT 4D:C291
	End if 
End if 