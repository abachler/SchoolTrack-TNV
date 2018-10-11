//%attributes = {}
  //MNU_4DExplorer


  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 01/10/09, 18:53:28
  // ----------------------------------------------------
  // Método: MNU_4DExplorer (solo para v11)
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


MNU_GotoDesignMode 

If (SYS_IsMacintosh )
	POST KEY:C465(Character code:C91("E");Command key mask:K16:1+Shift key mask:K16:3+Option key mask:K16:7)
Else 
	POST KEY:C465(Character code:C91("E");Control key mask:K16:9+Shift key mask:K16:3+Option key mask:K16:7)
End if 