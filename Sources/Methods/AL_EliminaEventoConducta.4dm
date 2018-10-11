//%attributes = {}
  // AL_EliminaEventoConducta()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/01/13, 11:28:31
  // ---------------------------------------------
C_LONGINT:C283($l_PaginaConducta;$l_filaSeleccionada;$l_respuestaUsuario)
C_TEXT:C284($t_textoObservacion)
C_BOOLEAN:C305(vb_AsignaSituacionfinal)


  // CÓDIGO
UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
Else 
	$l_filaSeleccionada:=AL_GetLine (xALP_ConductaAlumnos)
	$l_recNumRegistro:=<>aCdtaRecNo{$l_filaSeleccionada}
	$l_PaginaConducta:=Selected list items:C379(vlTab_Conducta)
	
	
	If (($l_filaSeleccionada>0) & ((USR_checkRights ("D";->[Alumnos_Conducta:8])) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | ((<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36) & (<>lSTR_IDTutor_USR#0))))
		Case of 
			: ($l_PaginaConducta=4)
				$l_registroEliminado:=AL_EliminaAtraso ($l_recNumRegistro)
				If ($l_registroEliminado=1)
					AL_LoadLte 
				End if 
				
				
				
				
			: ($l_PaginaConducta=1)
				$l_registroEliminado:=AL_EliminaInasistencia ($l_recNumRegistro)
				If ($l_registroEliminado=1)
					AL_LoadAbs 
				End if 
				
				
				
				
			: ($l_PaginaConducta=5)
				$l_registroEliminado:=AL_EliminaAnotacion ($l_recNumRegistro)
				If ($l_registroEliminado=1)
					AL_LoadAnt 
				End if 
				
				
				
				
			: ($l_PaginaConducta=6)
				$l_registroEliminado:=AL_EliminaCastigo ($l_recNumRegistro)
				If ($l_registroEliminado=1)
					AL_LoadDtn 
				End if 
				
				
				
				
			: ($l_PaginaConducta=7)
				$l_registroEliminado:=AL_EliminaSuspension ($l_recNumRegistro)
				If ($l_registroEliminado=1)
					AL_LoadSpn 
				End if 
				
				
				
				
			: ($l_PaginaConducta=3)
				$l_registroEliminado:=AL_EliminaLicencia ($l_recNumRegistro)
				If ($l_registroEliminado=1)
					AL_LoadLic 
				End if 
		End case 
		
		
		If ($l_respuestaUsuario=2)
			AL_LeeSintesisConducta ([Alumnos:2]numero:1)
			REDRAW WINDOW:C456
		End if 
		OBJECT SET VISIBLE:C603(*;"filtroCdta@";AL_CdtaBehaviourFilter ("mostrarFiltro"))
	Else 
		USR_ALERT_UserHasNoRights (3)
	End if 
End if 



