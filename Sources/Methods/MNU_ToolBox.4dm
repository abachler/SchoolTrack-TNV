//%attributes = {}
  //MNU_ToolBox


  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 01/10/09, 19:04:49
  // ----------------------------------------------------
  // Método: MNU_ToolBox (sólo para v11)
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------




MNU_GotoDesignMode 

If (SYS_IsMacintosh )
	POST KEY:C465(Character code:C91("T");Command key mask:K16:1+Shift key mask:K16:3)
Else 
	POST KEY:C465(Character code:C91("T");Control key mask:K16:9+Shift key mask:K16:3)
End if 