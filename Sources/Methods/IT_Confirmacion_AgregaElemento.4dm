//%attributes = {}
  // IT_Confirmacion_AgregaElemento()
  // Por: Alberto Bachler: 07/06/13, 15:50:34
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_TEXT:C284($t_TextoElemento)

If (False:C215)
	C_LONGINT:C283(IT_Confirmacion_AgregaElemento ;$0)
	C_TEXT:C284(IT_Confirmacion_AgregaElemento ;$1)
End if 

C_LONGINT:C283(vl_Confirmacion_Error)

$t_TextoElemento:=$1

Case of 
	: (vl_Confirmacion_Error#0)
		  // no se hace nada, se devuelve el último error
		
	: (Size of array:C274(at_Confirmacion_Elementos)=6)
		vl_Confirmacion_Error:=1
		
		  // el mensaje de confirmación no puede mostrar más de 6 elementos (Encabezado y hasta 5 botones, el último devuelve siempre 0)
	: (Find in array:C230(at_Confirmacion_Elementos;$t_TextoElemento)>0)
		  // el texto del elemento ya fue añadido. No puede haber dos elementos con el mismo texto en el mensaje de confirmacion
		vl_Confirmacion_Error:=2
		
	: ($t_TextoElemento="")
		  // no puede haber un elemento vacío
		vl_Confirmacion_Error:=3
		
	Else 
		APPEND TO ARRAY:C911(at_Confirmacion_Elementos;$t_TextoElemento)
End case 

$0:=vl_Confirmacion_Error