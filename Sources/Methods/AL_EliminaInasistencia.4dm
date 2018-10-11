//%attributes = {}
  // AL_EliminaInasistencia()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/01/13, 09:49:27
  // ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_recNumInasistencia;$l_respuestaUsario;$l_registroEliminado)

If (False:C215)
	C_LONGINT:C283(AL_EliminaInasistencia ;$0)
	C_LONGINT:C283(AL_EliminaInasistencia ;$1)
End if 


  // CÓDIGO
$l_recNumInasistencia:=$1
If (USR_GetMethodAcces (Current method name:C684))
	If ($l_recNumInasistencia>-3)
		KRL_GotoRecord (->[Alumnos_Inasistencias:10];$l_recNumInasistencia;True:C214)
		If (OK=1)
			$l_respuestaUsario:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar el registro de inasistencia seleccionado?");__ ("");__ ("No");__ ("Eliminar"))
			If ($l_respuestaUsario=2)
				LOG_RegisterEvt ("Eliminación de Inasistencia ("+String:C10([Alumnos_Inasistencias:10]Fecha:1;Internal date short special:K1:4)+") para "+[Alumnos:2]apellidos_y_nombres:40)
				DELETE RECORD:C58([Alumnos_Inasistencias:10])
			End if 
			READ ONLY:C145([Alumnos_Inasistencias:10])
			vb_AsignaSituacionfinal:=True:C214
			AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
			vb_AsignaSituacionfinal:=False:C215
			$l_registroEliminado:=1
		Else 
			CD_Dlog (0;__ ("No es posible eliminar el registro de inasistencia en este momento.\r\rImposible de acceder en escritura al registro."))
		End if 
	End if 
End if 

$0:=$l_registroEliminado