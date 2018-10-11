//%attributes = {}
  //MNU_4DNewMethod


  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 01/10/09, 19:01:14
  // ----------------------------------------------------
  // Método: MNU_4DNewMethod (solo para v11)
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


MNU_GotoDesignMode 

If (SYS_IsMacintosh )
	POST KEY:C465(Character code:C91("K");Command key mask:K16:1+Shift key mask:K16:3)
Else 
	POST KEY:C465(Character code:C91("K");Control key mask:K16:9+Shift key mask:K16:3)
End if 