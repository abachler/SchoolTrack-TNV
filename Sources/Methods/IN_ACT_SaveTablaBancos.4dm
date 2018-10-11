//%attributes = {}
  //IN_ACT_SaveTablaBancos

C_BLOB:C604($blob)

If (Application type:C494=4D Remote mode:K5:5)
	$proc:=Execute on server:C373(Current method name:C684;Pila_256K;"Guardando listas de bancos")
Else 
	READ ONLY:C145([xxACT_Bancos:129])
	$p:=IT_UThermometer (1;0;__ ("Guardando lista de bancos..."))
	QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Estandar:4=True:C214)
	If (Records in selection:C76([xxACT_Bancos:129])>0)
		$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Bancos.txt"
		If (SYS_TestPathName ($file)=Is a document:K24:1)
			DELETE DOCUMENT:C159($file)
		End if 
		SET CHANNEL:C77(10;$file)
		nbRecords:=Records in selection:C76([xxACT_Bancos:129])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xxACT_Bancos:129])
		While (Not:C34(End selection:C36([xxACT_Bancos:129])))
			KRL_SendRecord (->[xxACT_Bancos:129];True:C214)
			NEXT RECORD:C51([xxACT_Bancos:129])
		End while 
		SET CHANNEL:C77(11)
		
	End if 
	IT_UThermometer (-2;$p)
	UNLOAD RECORD:C212([xxACT_Bancos:129])
End if 