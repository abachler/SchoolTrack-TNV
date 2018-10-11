//%attributes = {}
  // Método: XS_SaveExecutableObjects
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 12/07/10, 11:53:02
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
QRY_SaveStandardQueries 



If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373(Current method name:C684;Pila_256K;"Guardando librería de objetos executables")
Else 
	
	
	
	  //DECLARATIONS
	C_TEXT:C284($file)
	_O_C_STRING:C293(15;fileHeader)
	C_LONGINT:C283(nbRecords)
	C_PICTURE:C286($pict)
	C_LONGINT:C283(nbRecords)
	
	  //INITIALIZATION
	
	
	  //MAIN CODE
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"ExecObjects.txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		ALL RECORDS:C47([XShell_ExecutableObjects:280])
		nbRecords:=Records in selection:C76([XShell_ExecutableObjects:280])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([XShell_ExecutableObjects:280])
		While (Not:C34(End selection:C36([XShell_ExecutableObjects:280])))
			SEND RECORD:C78([XShell_ExecutableObjects:280])
			NEXT RECORD:C51([XShell_ExecutableObjects:280])
		End while 
		SET CHANNEL:C77(11)
	End if 
End if 