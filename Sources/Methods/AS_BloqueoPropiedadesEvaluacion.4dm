//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket 175179
  // Fecha y hora: 08-05-17, 10:37:35
  // ----------------------------------------------------
  // Método: AS_BloqueoPropiedadesEvaluacion
  // Descripción: Inhabilita los controles de la ventana "Propiedades de evaluación" cuando el usuario no tiene permisos para modificar
  // El permiso es establecido en un proceso autorizado llamado "Propiedades de evaluación: Bloqueos" 
  // MONO Ticket 175179 Cambio el parámetro del los permisos para editar o no, para que el método lo utilice

C_BOOLEAN:C305($1)
C_BOOLEAN:C305($vb_editar)

C_OBJECT:C1216($o_opciones)
C_BOOLEAN:C305($b_blockPropEva)

$vb_editar:=$1

ARRAY TEXT:C222($at_nombresObjeto;0)
ARRAY POINTER:C280($ay_camposAsociado;0)
ARRAY LONGINT:C221($al_numPagina;0)

FORM GET OBJECTS:C898($at_nombresObjetos;$ay_camposAsociados;$al_numPagina)
For ($z;1;Size of array:C274($at_nombresObjetos))
	If ($al_numPagina{$z}=1)
		OBJECT SET ENABLED:C1123(*;$at_nombresObjetos{$z};$vb_editar)
	End if 
End for 

If ($vb_editar)
	AL_SetEnterable (xALP_CsdList2;2;1)
Else 
	AL_SetEnterable (xALP_CsdList2;0;0)
End if 

  //MONO poder bloquear o desbloquear las propiedades de evaluación si el usuario tiene el proceso autorizado.
OBJECT SET ENABLED:C1123(*;"cb_bloqueoPropDeEval";USR_GetMethodAcces (Current method name:C684;0))