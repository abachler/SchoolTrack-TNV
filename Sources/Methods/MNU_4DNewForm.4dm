//%attributes = {}
  //MNU_4DNewForm


  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 02/10/09, 10:30:39
  // ----------------------------------------------------
  // Método: MNU_4DNewForm
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


MNU_GotoDesignMode 

If (SYS_IsMacintosh )
	POST KEY:C465(Character code:C91("L");Command key mask:K16:1+Shift key mask:K16:3)
Else 
	POST KEY:C465(Character code:C91("L");Control key mask:K16:9+Shift key mask:K16:3)
End if 