//%attributes = {}
  // MNU_PopupMenuDinamico()
  // Por: Alberto Bachler: 10/10/13, 12:56:08
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($l_abajo;$l_Arriba;$l_derecha;$l_ItemSeleccionado;$l_izquierda;$l_boton)
C_TEXT:C284($t_refMenu)

If (False:C215)
	C_LONGINT:C283(MNU_PopupMenuDinamico ;$0)
	C_TEXT:C284(MNU_PopupMenuDinamico ;$1)
End if 

$t_refMenu:=$1
Case of 
	: (Count parameters:C259=3)
		$l_izquierda:=$2
		$l_arriba:=$3
	: (Count parameters:C259=2)
		GET MOUSE:C468($l_izquierda;$l_Arriba;$l_boton)
	Else 
		OBJECT GET COORDINATES:C663(*;OBJECT Get name:C1087(Object current:K67:2);$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
		$l_arriba:=$l_abajo+5
End case 
If (($l_izquierda+$l_arriba)=0)
	GET MOUSE:C468($l_izquierda;$l_Arriba;$l_boton)
End if 
  //OBJECT GET COORDINATES(*;OBJECT Get name(Object current);$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
$l_ItemSeleccionado:=Num:C11(Dynamic pop up menu:C1006($t_refMenu;"0";$l_izquierda;$l_Arriba))

$0:=$l_ItemSeleccionado

