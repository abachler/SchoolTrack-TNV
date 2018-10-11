  // [TMT_Horario].Horario.bEliminar Sala_o_Asignacion()
  // Por: Alberto Bachler: 22/05/13, 17:58:27
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_asignacionRetirada;$b_salaEliminada)
C_LONGINT:C283($l_columna;$l_columnaSeleccionada2;$l_errorALP;$l_filaSeleccionada;$l_fila;$l_filaSeleccionada2;$l_IdSala;$l_recnumCeldaSeleccionada)
C_POINTER:C301($y_diaSeleccionado_al;$y_ObjetoEnFoco)
C_TEXT:C284($t_nombreSala;$t_textoError)

ARRAY LONGINT:C221($al_CeldasSeleccionadas_2D;0)

$y_ObjetoEnFoco:=Focus object:C278
$t_objeto:=OBJECT Get name:C1087(Object with focus:K67:3)
Case of 
	: ($t_objeto="lbSalas")
		LISTBOX GET CELL POSITION:C971(*;$t_objeto;$l_columna;$l_fila)
		TMT_EliminaSala (alTMT_Salas_ID{$l_fila})
		
	: ($t_objeto="lbHorario")
		LISTBOX GET CELL POSITION:C971(*;$t_objeto;$l_columna;$l_fila)
		  //$l_columna:=(OBJECT Get pointer(Object named;"columna"))->
		  //$l_fila:=(OBJECT Get pointer(Object named;"fila"))->
		If ($l_columna>3) & ($l_fila>0) & (USR_checkRights ("D";->[TMT_Horario:166]))
			$y_diaSeleccionado_al:=Get pointer:C304("alSTK_Day"+String:C10($l_columna-3))
			$l_recnumCeldaSeleccionada:=$y_diaSeleccionado_al->{$l_fila}
			If ($l_recnumCeldaSeleccionada>-1)
				$t_textoError:=TMT_RetiraAsignacion ($l_recnumCeldaSeleccionada)
				If ($t_textoError="")
					TMT_CargaSalas 
					TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
				End if 
				
			Else 
				CD_Dlog (0;__ ("No fue posible retirar la asignación de horario.\rPor favor intente nuevamente más tarde."))
			End if 
		End if 
End case 

