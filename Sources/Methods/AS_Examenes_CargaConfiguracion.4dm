//%attributes = {}
  // AS_Examenes_CargaConfiguracion()
  //
  //
  // creado por: Alberto Bachler Klein: 13-05-16, 15:22:14
  // -----------------------------------------------------------

  //  20181003 ASM Ticket 194524 Cambio general en el método por paso de opciones a objetos

C_LONGINT:C283($i;$l_otRef;$l_tipoItem;$l_tipoObjetoForm)
C_POINTER:C301($y_objeto;$y_ObjetoRaiz)
C_OBJECT:C1216($o_controlesYexamenes)

ARRAY LONGINT:C221($al_tipoItems;0)
ARRAY TEXT:C222($at_NombreItems;0)

$o_controlesYexamenes:=OB Get:C1224([Asignaturas:18]Opciones:57;"controles_y_examenes";Is object:K8:27)
OB GET PROPERTY NAMES:C1232($o_controlesYexamenes;$at_NombreItems)
SORT ARRAY:C229($at_NombreItems;>)


For ($i;1;Size of array:C274($at_NombreItems))
	$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;$at_NombreItems{$i})
	If (Not:C34(Is nil pointer:C315($y_objeto)))
		$y_objeto->:=OB Get:C1224($o_controlesYexamenes;$at_NombreItems{$i})
	Else 
		  //ALERT("El objeto \""+$at_NombreItems{$i}+"\" almacenado en las propiedades de examenes no existe en el formulario")
	End if 
End for 


AS_Examenes_LeeConfigPeriodo 