//%attributes = {}
  // AL_EliminaAnotacion()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/01/13, 10:00:59
  // ---------------------------------------------
C_LONGINT:C283($l_recNumAnotacion;$l_recNumInasistencia;$l_respuestaUsuario;$l_registroEliminado)

If (False:C215)
	C_LONGINT:C283(AL_EliminaAnotacion ;$0)
	C_LONGINT:C283(AL_EliminaAnotacion ;$1)
End if 

  // CODIGO
$l_recNumAnotacion:=$1
KRL_GotoRecord (->[Alumnos_Anotaciones:11];$l_recNumAnotacion;True:C214)
If (OK=1)
	$l_respuestaUsuario:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar la anotación seleccionada?");__ ("");__ ("No");__ ("Eliminar"))
	If ($l_respuestaUsuario=2)
		LOG_RegisterEvt ("Eliminación de Anotación ("+String:C10([Alumnos_Anotaciones:11]Fecha:1;Internal date short special:K1:4)+") para "+[Alumnos:2]apellidos_y_nombres:40)
		DELETE RECORD:C58([Alumnos_Anotaciones:11])
		$l_registroEliminado:=1
	End if 
	READ ONLY:C145([Alumnos_Anotaciones:11])
Else 
	CD_Dlog (0;__ ("No es posible eliminar el registro de Anotación en este momento.\r\rImposible de acceder en escritura al registro."))
End if 

$0:=$l_registroEliminado
