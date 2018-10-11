//%attributes = {}
  // Método: KRL_GetFieldPointerByName (fieldName:T)
  // retorna un puntero basado en fieldName
  // fieldName puede ser pasado de dos maneras
  // - nombreTabla$nombreCampo (recomendado)
  // - [nombreTabla]nombreCampo
  //
  // por Alberto Bachler Klein
  // creación 25/08/17, 15:56:28
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_POINTER:C301($0)
C_TEXT:C284($1)

C_POINTER:C301($y_puntero)
C_TEXT:C284($t_fieldName)




If (False:C215)
	C_POINTER:C301(KRL_GetFieldPointerByName ;$0)
	C_TEXT:C284(KRL_GetFieldPointerByName ;$1)
End if 

  //•••••••••••••••••••••••• NOTA IMPORTANTE ••••••••••••••••••••••••
  // Este método se mantiene solo por raxones de compatibilidad
  // Usar de preferencia el acceso directo al objeto que contiene los punteros:
  // puntero:=OB Get(<>ob_fields;nombreTabla$nombreCampo)
  // o, mejor aún (si la notación objeto esta disponible en la versión 4D en uso):
  // puntero:=<>ob_fields.nombreTabla$nombreCampo
  //••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••



C_OBJECT:C1216(<>ob_Tables;<>ob_fields)

$t_fieldName:=Lowercase:C14($1)


If (Position:C15("]";$t_fieldName)>0)
	  // el objeto <>ob_Field define las propiedades como nombreTabla$nombreCampo para cumplir con los requisitos de la notacion objeto (a contar de v16R4) que impide la utilización de corchetes
	  // si fieldName contiene "]" lo remplzo por "$"
	$t_fieldName:=Replace string:C233($t_fieldName;"[";"";*)
	$t_fieldName:=Replace string:C233($t_fieldName;"]";"$";*)
End if 

If (Not:C34(OB Is defined:C1231(<>ob_fields)))
	  // si el objeto no esta definido lo creo
	KRL_LoadTableAndFieldPointers 
End if 

If (OB Is defined:C1231(<>ob_fields;$t_fieldName))
	  //si la propiedad (nombre del campo) esta definida en el objeto obtengo el puntero
	$0:=OB Get:C1224(<>ob_fields;$t_fieldName)
Else 
	  //si la propiedad no esta definida (el campo pudo haber sido creado o su nombre modificado durante la sesion) vuelvo a crear el objeto
	KRL_LoadTableAndFieldPointers 
	If (OB Is defined:C1231(<>ob_fields;$t_fieldName))
		$0:=OB Get:C1224(<>ob_fields;$t_fieldName)
	End if 
End if 

  // $0 retorna un puntero valido si el campo esta definido en el objeto o NIL si no lo está







