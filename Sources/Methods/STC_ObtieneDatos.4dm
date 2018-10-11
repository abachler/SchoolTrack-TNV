//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 25-09-18, 14:16:05
  // ----------------------------------------------------
  // Método: STC_ObtieneDatos
  // Descripción
  // Método para centralizar los llamados y conectar luego con STC
  // Servirá para llevar un control de los módulos asociados a los componentes
  //
  // Parámetros
  // ----------------------------------------------------

C_OBJECT:C1216($o_objeto;$0)

$o_objeto:=$1

Case of 
	: (OB Get:C1224($o_objeto;"modulo")=41)  //xShell
		STC_ObtieneDatosXS ($o_objeto)
		
	: (OB Get:C1224($o_objeto;"modulo")=SchoolTrack Web Access)
		STC_ObtieneDatosSTWA ($o_objeto)
		
	: (OB Get:C1224($o_objeto;"modulo")=SchoolTrack)
		
	Else 
		
		TRACE:C157
		
End case 

$0:=$o_objeto