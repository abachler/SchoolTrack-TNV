//%attributes = {}
  // AL_EliminaSuspension()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/01/13, 10:24:45
  // ---------------------------------------------


  // CODIGO
C_LONGINT:C283($l_recNumSuspension;$l_recNumInasistencia;$l_respuestaUsuario;$l_registroEliminado)

If (False:C215)
	C_LONGINT:C283(AL_EliminaSuspension ;$0)
	C_LONGINT:C283(AL_EliminaSuspension ;$1)
End if 

  // CODIGO
$l_recNumSuspension:=$1
KRL_GotoRecord (->[Alumnos_Suspensiones:12];$l_recNumSuspension;True:C214)
If (OK=1)
	$l_respuestaUsuario:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar la Suspension seleccionada?");__ ("");__ ("No");__ ("Eliminar"))
	If ($l_respuestaUsuario=2)
		LOG_RegisterEvt ("Eliminación de Suspensión válida desde "+String:C10([Alumnos_Suspensiones:12]Desde:5;Internal date short special:K1:4)+" a "+String:C10([Alumnos_Suspensiones:12]Hasta:6;Internal date short special:K1:4)+" para "+[Alumnos:2]apellidos_y_nombres:40)
		DELETE RECORD:C58([Alumnos_Suspensiones:12])
		$l_registroEliminado:=1
	End if 
	READ ONLY:C145([Alumnos_Suspensiones:12])
Else 
	CD_Dlog (0;__ ("No es posible eliminar el registro de Suspensión en este momento.\r\rImposible de acceder en escritura al registro."))
End if 

$0:=$l_registroEliminado
