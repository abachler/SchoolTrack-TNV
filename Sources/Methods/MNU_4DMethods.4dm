//%attributes = {}
  //MNU_4DMethods


  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 01/10/09, 19:00:51
  // ----------------------------------------------------
  // Método: MNU_4DMethods (solo para v11)
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

MNU_GotoDesignMode 

If (SYS_IsMacintosh )
	POST KEY:C465(Character code:C91("K");Command key mask:K16:1)
Else 
	POST KEY:C465(Character code:C91("K");Control key mask:K16:9)
End if 