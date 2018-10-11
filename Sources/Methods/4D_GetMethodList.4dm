//%attributes = {}
  // Método: 4D_GetMethodList
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 20/01/10, 17:37:56
  // ---------------------------------------------
  // Descripción: 
  // retorna la lista de método
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
$y_nombreMetodos_at:=$1
$y_IdMetodos_al:=$2

ARRAY LONGINT:C221($al_IdMetodos;0)
ARRAY TEXT:C222($at_NombresMetodos;0)
METHOD GET NAMES:C1166($at_NombresMetodos;*)
  //hmFree_GET METHOD LIST ($at_NombresMetodos;$al_IdMetodos)
ARRAY LONGINT:C221($al_IdMetodos;Size of array:C274($at_NombresMetodos))  //20160510 RCH No se estaba obteniendo los ids de métodos.

  // la lista de metodos retornada por el plugin incluye los métodos de componentes
  // el comando de API Pack API Does Method Exist permite saber si se trata de un método la estructura
_O_C_STRING:C293(31;$t_nombreMetodo)
For ($i;Size of array:C274($at_NombresMetodos);1;-1)
	$t_nombreMetodo:=$at_NombresMetodos{$i}
	$al_IdMetodos{$i}:=API Get Method ID ($t_nombreMetodo)
	If ((API Does Method Exist ($t_nombreMetodo)=0) | ($t_nombreMetodo="(@"))
		DELETE FROM ARRAY:C228($at_NombresMetodos;$i)
		DELETE FROM ARRAY:C228($al_IdMetodos;$i)
	End if 
End for 
SORT ARRAY:C229($at_NombresMetodos;$al_IdMetodos;>)

AT_CopyArrayElements (->$at_NombresMetodos;$y_nombreMetodos_at)
AT_CopyArrayElements (->$al_IdMetodos;$y_IdMetodos_al)
