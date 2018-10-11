//%attributes = {}
  //XS_SetConfigInterface
C_BOOLEAN:C305($1)

C_BOOLEAN:C305($b_condicion)
C_LONGINT:C283($l_refImagen)


If (False:C215)
	C_BOOLEAN:C305(XS_SetConfigInterface ;$1)
End if 

If (Count parameters:C259=1)
	$b_condicion:=$1
Else 
	$b_condicion:=True:C214
End if 
XS_SetInterface ($b_condicion)

  // barra de titulo
$l_refImagen:=Choose:C955(<>vlXS_CurrentModuleRef-1;26331;26332;26333;26334)
OBJECT SET FORMAT:C236(*;"imagen2";"?"+String:C10($l_refImagen))

  // fondo
$l_refImagen:=Choose:C955(<>vlXS_CurrentModuleRef-1;26326;26325;26323;26324)
GET PICTURE FROM LIBRARY:C565($l_refImagen;vp_FondoConfig)

