  // Método: On Server Shutdown
  // código original de: 
  // modificado por Alberto Bachler Klein, 07/03/18, 12:11:02
  // 
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305(<>b_NoEjecutarOnExit)

If (Not:C34(<>b_NoEjecutarOnExit))
	Bash_Quit 
	SQ_EscribeDatos 
	LOG_RegisterEvt ("Cierre normal de SchoolTrack Server")
	SYS_ClearResourceFile 
	OT ClearAll 
End if 

CIM_CuentaRegistros ("GuardaArchivo")
SQL_CloseExternalDatabase 
