  // [TMT_Horario].Horario.lbHorario()
  //
  //
  // creado por: Alberto Bachler Klein: 19-07-16, 09:36:23
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_AsignacionModificada;$b_salaLiberada)
C_LONGINT:C283($i;$i_fila;$l_abajo;$l_arriba;$l_asignarSala;$l_campo;$l_columna;$l_columnaHorario;$l_derecha;$l_elementoArrastre)
C_LONGINT:C283($l_fila;$l_filaHorario;$l_filaOrigen;$l_idAsignatura;$l_itemSeleccionado;$l_izquierda;$l_NumeroAlumnos;$l_numeroDia;$l_numeroFilas;$l_proceso)
C_LONGINT:C283($l_recnumCelda;$l_recnumCeldaHorario;$l_recnumCeldaSeleccionada;$l_tabla)
C_POINTER:C301($y_asignaturas;$y_diaHorario_al;$y_diaHorario_at;$y_diaOrigen_al;$y_diaSeleccionado_al;$y_diaSeleccionado_at;$y_horario;$y_listbox;$y_origen;$y_salas)
C_TEXT:C284($t_Asignaciones;$t_asignatura;$t_itemsPopUpMenu;$t_mensaje;$t_nombreObjeto;$t_Nombreprofesor;$t_nombreSala;$t_refCelda;$t_textoAsignacion1;$t_TextoAsignacion2)
C_TEXT:C284($t_textoError;$t_variable)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY LONGINT:C221($al_columnasResalte;0)
ARRAY INTEGER:C220($al_dia;0)
ARRAY LONGINT:C221($al_filasResalte;0)
ARRAY INTEGER:C220($al_hora;0)
ARRAY POINTER:C280($ay_Columnas;0)
ARRAY POINTER:C280($ay_Encabezados;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)

$y_salas:=OBJECT Get pointer:C1124(Object named:K67:5;"lbSalas")
$y_asignaturas:=OBJECT Get pointer:C1124(Object named:K67:5;"lbasignaturas")
$y_horario:=OBJECT Get pointer:C1124(Object named:K67:5;"lbHorario")
LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila)
LISTBOX GET ARRAYS:C832(*;"lbHorario";$at_nombreColumnas;$at_nombreEncabezados;$ay_Columnas;$ay_Encabezados;$ab_visibles;$ay_estilos)
$l_numeroFilas:=LISTBOX Get number of rows:C915(*;OBJECT Get name:C1087)

If ($l_fila>0) & ($l_fila<=$l_numeroFilas)
	$t_nombreObjeto:=$at_nombreColumnas{$l_columna}
End if 

Case of 
	: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
		LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila)
		If (($l_columna>4) & ($l_fila>0))  //MONO TICKET 202510
			If ((USR_checkRights ("D";->[TMT_Horario:166])) & ($l_columna>4))  //MONO TICKET 202510
				$l_numeroDia:=$l_columna-4  //MONO TICKET 202510
				$y_diaSeleccionado_al:=Get pointer:C304("alSTK_Day"+String:C10($l_numeroDia))
				$y_diaSeleccionado_at:=Get pointer:C304("atSTK_Day"+String:C10($l_numeroDia))
				$l_recnumCeldaSeleccionada:=$y_diaSeleccionado_al->{$l_fila}
				If ($l_recnumCeldaSeleccionada>=0)
					KRL_GotoRecord (->[TMT_Horario:166];$l_recnumCeldaSeleccionada;False:C215)
					$t_asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]denominacion_interna:16)
					$t_textoAsignacion1:=$t_asignatura+", "+DT_DayNameFromISODayNumber ($l_numeroDia)+", "+String:C10(aiSTK_Hora{$l_fila})+"ª hora"
					$t_TextoAsignacion2:=$t_asignatura+" de los días "+DT_DayNameFromISODayNumber ($l_numeroDia)+" en la "+String:C10(aiSTK_Hora{$l_fila})+"ª hora"
					$t_nombreSala:=KRL_GetTextFieldData (->[TMT_Salas:167]ID_Sala:1;->[TMT_Horario:166]ID_Sala:6;->[TMT_Salas:167]NombreSala:2)
				End if 
			End if 
			If ($t_TextoAsignacion1#"")
				$t_itemsPopUpMenu:=Char:C90(1)+__ ("Editar ^1")+"..."
				$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";"
				$t_itemsPopUpMenu:=$t_itemsPopUpMenu+Char:C90(1)+__ ("Resaltar horario de ^0")+"..."
				$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";(-;"+Char:C90(1)+__ ("Retirar ^2")+"..."
				If ($t_NombreSala#"")
					$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";(-;"+Char:C90(1)+__ ("Liberar sala ^3 en este horario")+"..."
				Else 
					$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";(-;("+__ ("Liberar sala ^3 en este horario")+"..."
				End if 
			Else 
				$t_itemsPopUpMenu:="("+__ ("Editar^1")+"..."
				$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";("+__ ("Resaltar otras asignaciones ^0")+"..."
				$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";(-"
				$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";("+__ ("Retirar^2")+"..."
				$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";(-;("+__ ("Liberar sala^2")+"..."
			End if 
			$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"^0";$t_asignatura)
			$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"^1";$t_textoAsignacion1)
			$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"^2";$t_TextoAsignacion2)
			$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"^3";$t_nombreSala)
			
			$l_itemSeleccionado:=Pop up menu:C542($t_itemsPopUpMenu)
			Case of 
				: ($l_itemSeleccionado=1)  // info
					$b_AsignacionModificada:=TMT_InfoAsignacion ($l_recnumCeldaSeleccionada)
					If ($b_AsignacionModificada)
						TMT_CargaSalas 
						TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
					End if 
					
				: ($l_itemSeleccionado=2)  // resaltar
					LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila)
					TMT_FijaAparienciaCeldas 
					KRL_GotoRecord (->[TMT_Horario:166];$l_recnumCeldaSeleccionada;False:C215)
					$l_idAsignatura:=[TMT_Horario:166]ID_Asignatura:5
					TMT_ResaltaHorario ($l_idAsignatura)
					
					
				: ($l_itemSeleccionado=4)  // retirar
					$t_textoError:=TMT_RetiraAsignacion ($l_recnumCeldaSeleccionada)
					If ($t_textoError="")
						TMT_CargaSalas 
						TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
					Else 
						CD_Dlog (0;__ ("No fue posible retirar la asignación de horario.\rPor favor intente nuevamente más tarde."))
					End if 
					
				: ($l_itemSeleccionado=6)  // desasignar sala en este horario
					$b_salaLiberada:=TMT_LiberarSala ($l_recnumCeldaSeleccionada)
					If ($b_salaLiberada)
						$t_Nombreprofesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_numero:4;->[Profesores:4]Nombre_comun:21)
						$y_diaSeleccionado_at->{$l_fila}:=[Asignaturas:18]Abreviación:26+"/"+[Asignaturas:18]Curso:5+"\r"+$t_Nombreprofesor
					End if 
			End case 
		End if 
		
		
	: (Form event:C388=On Clicked:K2:4)
		If (($l_columna>4) & ($l_fila>0))  //MONO TICKET 202510
			$y_diaOrigen_al:=Get pointer:C304("alSTK_Day"+String:C10($l_columna-4))  //MONO TICKET 202510
			$l_recnumCelda:=$y_diaOrigen_al->{$l_fila}
			If (alSTK_RefTipoHora{$l_fila}=1)  //& ($l_recnumCelda>No current record))
				LISTBOX GET CELL COORDINATES:C1330(*;"lbHorario";$l_columna;$l_fila;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
				OBJECT SET COORDINATES:C1248(*;"rectanguloSeleccion";$l_izquierda;$l_arriba-1;$l_derecha;$l_abajo-1)
				OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";True:C214)
				LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila)
				LB_SelectCell 
			End if 
		End if 
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila)
		If ($l_columna>4)  //MONO TICKET 202510
			$l_numeroDia:=$l_columna-4  //MONO TICKET 202510
			$y_diaSeleccionado_al:=Get pointer:C304("alSTK_Day"+String:C10($l_columna-4))  //MONO TICKET 202510
			$y_diaSeleccionado_at:=Get pointer:C304("atSTK_Day"+String:C10($l_columna-4))  //MONO TICKET 202510
			$l_recnumCeldaSeleccionada:=$y_diaSeleccionado_al->{$l_fila}
			If ($l_recnumCeldaSeleccionada>=0)
				$b_AsignacionModificada:=TMT_InfoAsignacion ($l_recnumCeldaSeleccionada)
				If ($b_AsignacionModificada)
					TMT_CargaSalas 
					TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
				End if 
			End if 
			LB_SelectCell 
		End if 
		
		
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($y_origen;$l_elementoArrastre;$l_proceso)
		RESOLVE POINTER:C394($y_origen;$t_variable;$l_tabla;$l_campo)
		$t_refCelda:=LB_GetCellMouseOver (->$l_columna;->$l_fila)
		$t_mensaje:=$t_refCelda
		  //BEEP
		
		If ($l_columna<5)  //MONO TICKET 202510
			$0:=-1
			
		Else 
			If ($l_fila>0)
				$y_diaOrigen_al:=Get pointer:C304("alSTK_Day"+String:C10($l_columna-4))  //MONO TICKET 202510
				$l_recnumCelda:=$y_diaOrigen_al->{$l_fila}
			End if 
			If (alSTK_RefTipoHora{$l_fila}=1)
				
			End if 
			
			Case of 
				: ($y_origen=$y_horario)
					If (alSTK_RefTipoHora{$l_fila}=1)
						$0:=0
					Else 
						$0:=-1
					End if 
					
				: ($y_origen=$y_asignaturas)
					If (alSTK_RefTipoHora{$l_fila}=1)
						$0:=0
					Else 
						$0:=-1
					End if 
					
				: ($y_origen=$y_salas)
					If ((alSTK_RefTipoHora{$l_fila}=1) & ($l_recnumCelda>No current record:K29:2))
						$0:=0
					Else 
						$0:=-1
					End if 
				Else 
					$0:=-1
			End case 
			
			If (($0=0) & (alSTK_RefTipoHora{$l_fila}=1))
				LISTBOX GET CELL COORDINATES:C1330(*;"lbHorario";$l_columna;$l_fila;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
				OBJECT SET COORDINATES:C1248(*;"rectanguloSeleccion";$l_izquierda;$l_arriba-1;$l_derecha;$l_abajo-1)
				OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";True:C214)
			End if 
			OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)
			
		End if 
		
	: (Form event:C388=On Drop:K2:12)
		TMT_ManejaArrastrarSoltar 
		OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)
		
		
	: (Form event:C388=On Scroll:K2:57)
		OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)
		
	: (Form event:C388=On Mouse Move:K2:35)
		$t_refCelda:=LB_GetCellMouseOver (->$l_columna;->$l_fila)
		$t_mensaje:=$t_refCelda
		If (($l_columna>4) & ($l_fila>0))  //MONO TICKET 202510
			$t_mensaje:=$t_refCelda
			$y_diaOrigen_al:=Get pointer:C304("alSTK_Day"+String:C10($l_columna-4))  //MONO TICKET 202510
			$l_recnumCelda:=$y_diaOrigen_al->{$l_fila}
			If (alSTK_RefTipoHora{$l_fila}=1)
				LISTBOX GET CELL COORDINATES:C1330(*;"lbHorario";$l_columna;$l_fila;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
				OBJECT SET COORDINATES:C1248(*;"rectanguloSeleccion";$l_izquierda;$l_arriba-1;$l_derecha;$l_abajo-1)
				OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";True:C214)
			End if 
		End if 
		  //
		  //
	: (Form event:C388=On Mouse Leave:K2:34)
		OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)
End case 



