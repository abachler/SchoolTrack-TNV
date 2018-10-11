//%attributes = {}
  //MNU_4DForms


  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 01/10/09, 19:00:35
  // ----------------------------------------------------
  // Método: MNU_4DForms (solo para v11)
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



MNU_GotoDesignMode 

If (SYS_IsMacintosh )
	POST KEY:C465(Character code:C91("L");Command key mask:K16:1)
Else 
	POST KEY:C465(Character code:C91("L");Control key mask:K16:9)
End if 