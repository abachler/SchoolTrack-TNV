//%attributes = {}
  // JSON_CuentaItems()
  // Por: Alberto Bachler K.: 18-02-15, 16:49:22
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_REAL:C285($0)
  //C_TEXT($1)
C_OBJECT:C1216($1)
C_TEXT:C284($t_refNodo)
C_OBJECT:C1216($ob_nodo)
ARRAY LONGINT:C221($al_tipoElementos;0)
ARRAY LONGINT:C221($at_nombreElementos;0)
ARRAY TEXT:C222($at_refNodos;0)

If (False:C215)
	C_REAL:C285(JSON_CuentaItems ;$0)
	  //C_TEXT(JSON_CuentaItems ;$1)
End if 

  //$t_refNodo:=$1
  //JSON GET CHILD NODES ($t_refNodo;$at_refNodos;$al_tipoElementos;$at_nombreElementos)
$ob_nodo:=$1
If (OB Is empty:C1297($ob_nodo))
	$0:=0
Else 
	$l_nodos:=OB_GetChildNodes ($ob_nodo;->$at_nombreElementos)
	$0:=Size of array:C274($at_nombreElementos)
End if 
  //$0:=Size of array($at_refNodos)
