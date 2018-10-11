//%attributes = {}
  // Método: MNU_GotoUserMode
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 13/10/09, 09:44:10
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
MNU_GotoDesignMode 
If (SYS_IsMacintosh )
	POST KEY:C465(Character code:C91("U");Command key mask:K16:1+Shift key mask:K16:3)
Else 
	POST KEY:C465(Character code:C91("U");Control key mask:K16:9+Shift key mask:K16:3)
End if 

$l_proceso:=New process:C317("4D_ShowUserModeWindow";Pila_128K)




