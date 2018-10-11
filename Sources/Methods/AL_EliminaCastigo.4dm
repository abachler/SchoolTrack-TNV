//%attributes = {}
  // AL_EliminaCastigo()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/01/13, 10:20:15
  // ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_recNumCastigo;$l_registroEliminado;$l_respuestaUsuario)

If (False:C215)
	C_LONGINT:C283(AL_EliminaCastigo ;$0)
	C_LONGINT:C283(AL_EliminaCastigo ;$1)
End if 

  // CODIGO
$l_recNumCastigo:=$1
KRL_GotoRecord (->[Alumnos_Castigos:9];$l_recNumCastigo;True:C214)
If (OK=1)
	$l_respuestaUsuario:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar la Castigo seleccionada?");__ ("");__ ("No");__ ("Eliminar"))
	If ($l_respuestaUsuario=2)
		LOG_RegisterEvt ("Eliminación de Castigo ("+String:C10([Alumnos_Castigos:9]Fecha:9;Internal date short special:K1:4)+") para "+[Alumnos:2]apellidos_y_nombres:40)
		DELETE RECORD:C58([Alumnos_Castigos:9])
		$l_registroEliminado:=1
	End if 
	READ ONLY:C145([Alumnos_Castigos:9])
Else 
	CD_Dlog (0;__ ("No es posible eliminar el registro de Castigo en este momento.\r\rImposible de acceder en escritura al registro."))
End if 

$0:=$l_registroEliminado
