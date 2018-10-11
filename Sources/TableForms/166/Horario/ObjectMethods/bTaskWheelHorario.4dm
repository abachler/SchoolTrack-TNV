  // [TMT_Horario].Horario.bTaskWheelHorario()
  // Por: Alberto Bachler: 22/05/13, 08:38:16
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_asignacionRetirada;$b_SalaEliminada;$b_AsignacionModificada)
C_LONGINT:C283($l_columnaSeleccionada1;$l_columnaSeleccionada2;$l_errorALP;$l_filaSeleccionada;$l_filaSeleccionada1;$l_filaSeleccionada2;$l_IdSala;$l_itemSeleccionado;$l_recnumCeldaSeleccionada)
C_POINTER:C301($y_diaSeleccionado_al)
C_TEXT:C284($t_textoError;$t_asignatura;$t_itemsPopUpMenu;$t_nombreSala;$t_textoAsignacion1;$t_TextoAsignacion2)

ARRAY LONGINT:C221($al_CeldasSeleccionadas_2D;0)

  // items de menú rueda de tareas relacionados con las salas
$t_itemsPopUpMenu:=""
If (USR_checkRights ("A";->[TMT_Horario:166]))
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+__ ("Nueva Sala de clases...")
Else 
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+"("+__ ("Nueva Sala de clases...")
End if 
LISTBOX GET CELL POSITION:C971(*;"lbSalas";$l_columna;$l_filaSeleccionada)
  //$l_filaSeleccionada:=AL_GetLine (xALP_Salas)
If ($l_filaSeleccionada>0) & (USR_checkRights ("D";->[TMT_Horario:166]))
	$l_IdSala:=alTMT_Salas_ID{$l_filaSeleccionada}
	$t_nombreSala:=" "+atTMT_Salas_Nombre{$l_filaSeleccionada}
End if 
$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";"
If ($t_nombreSala#"")
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+__ ("Editar sala^0")+";"+__ ("Eliminar Sala^0")
Else 
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+"("+__ ("Editar sala^0")+";("+__ ("Eliminar Sala^0")
End if 
$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"^0";$t_nombreSala+"...")
  //

$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";(-;"


  // items de menu rueda de tareas relacionados con las asignaturas
  //$l_filaSeleccionada:=AL_GetLine (xALP_Subsectores)
LISTBOX GET CELL POSITION:C971(*;"lbAsignaturas";$l_columna;$l_filaSeleccionada)
If ($l_filaSeleccionada>0)
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=alSTK_IDSubsectores{$l_filaSeleccionada})
	If (Records in selection:C76([TMT_Horario:166])>0)
		$t_itemsPopUpMenu:=$t_itemsPopUpMenu+__ ("Horario y Sesiones de ")+atSTK_Subsectores_LongName{$l_filaSeleccionada}+"...;"+__ ("Resaltar horario de ^3")
	Else 
		$t_itemsPopUpMenu:=$t_itemsPopUpMenu+"("+__ ("Horario y Sesiones de ")+atSTK_Subsectores_LongName{$l_filaSeleccionada}+"...;"+"("+__ ("Resaltar horario de...")
	End if 
Else 
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+"("+__ ("Horario y Sesiones de ")+atSTK_Subsectores_LongName{$l_filaSeleccionada}+"...;"+"("+__ ("Resaltar horario de...")
End if 
$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";(-;"
$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"^3";atSTK_Subsectores_LongName{$l_filaSeleccionada})
  // 


  // items de menu rueda de tareas relacionados con el horario
LISTBOX GET CELL POSITION:C971(*;"lbHorario";$l_columna;$l_filaSeleccionada)
  //$l_errorALP:=AL_GetCellSel (xALP_Horario;$l_columnaSeleccionada1;$l_filaSeleccionada1;$l_columnaSeleccionada2;$l_filaSeleccionada2;$al_CeldasSeleccionadas_2D)
  //If ((Size of array($al_CeldasSeleccionadas_2D)=0) & (USR_checkRights ("D";->[TMT_Horario])) & ($l_columna>3))
If ((USR_checkRights ("D";->[TMT_Horario:166])) & ($l_columna>3))
	$l_diaSeleccionado:=$l_columna-3
	$y_diaSeleccionado_al:=Get pointer:C304("alSTK_Day"+String:C10($l_diaSeleccionado))
	$y_diaSeleccionado_at:=Get pointer:C304("atSTK_Day"+String:C10($l_diaSeleccionado))
	$l_recnumCeldaSeleccionada:=$y_diaSeleccionado_al->{$l_filaSeleccionada}
	If ($l_recnumCeldaSeleccionada>0)
		KRL_GotoRecord (->[TMT_Horario:166];$l_recnumCeldaSeleccionada;False:C215)
		$t_asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]denominacion_interna:16)
		$t_textoAsignacion1:=$t_asignatura+", "+DT_DayNameFromISODayNumber ($l_diaSeleccionado)+", "+String:C10(aiSTK_Hora{$l_filaSeleccionada})+"ª hora"
		$t_TextoAsignacion2:=$t_asignatura+" de los días "+DT_DayNameFromISODayNumber ($l_diaSeleccionado)+" en la "+String:C10(aiSTK_Hora{$l_filaSeleccionada})+"ª hora"
	End if 
End if 
If ($t_TextoAsignacion1#"")
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+__ ("Editar ^1")+"..."
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";"+__ ("Resaltar horario de ^3")+"..."
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";(-"
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";"+__ ("Retirar ^2")+"..."
Else 
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";("+__ ("Editar^1")+"..."
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";("+__ ("Resaltar horario de....")
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";(-"
	$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";("+__ ("Retirar^2")+"..."
End if 
$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"^1";$t_textoAsignacion1)
$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"^2";$t_TextoAsignacion2)
$t_itemsPopUpMenu:=Replace string:C233($t_itemsPopUpMenu;"^3";$t_asignatura)

$t_itemsPopUpMenu:=$t_itemsPopUpMenu+";"+Choose:C955(b_soloBloquesVigentes;"<B";"")+__ ("Mostrar solo bloques vigentes ")  //MONO TICKET 216065


$l_itemSeleccionado:=Pop up menu:C542($t_itemsPopUpMenu;0)
Case of 
	: ($l_itemSeleccionado=1)  // agregar sala
		TMT_NuevaSala 
		
	: ($l_itemSeleccionado=2)  // editar sala
		TMT_EditarSala ($l_IdSala)
		
	: ($l_itemSeleccionado=3)  // eliminar sala
		$b_SalaEliminada:=TMT_EliminaSala ($l_IdSala)
		
	: ($l_itemSeleccionado=5)  // información sobre horario y sesiones de la asignatura seleccionada
		  //$l_filaSeleccionada:=AL_GetLine (xALP_Subsectores)
		LISTBOX GET CELL POSITION:C971(*;"lbAsignaturas";$l_columna;$l_filaSeleccionada)
		TMT_InfoAsignacionAsignatura (alSTK_IDSubsectores{$l_filaSeleccionada})
		
	: ($l_itemSeleccionado=6)  // resaltar el horario de la asignatura seleccionada
		LISTBOX GET CELL POSITION:C971(*;"lbAsignaturas";$l_columna;$l_filaSeleccionada)
		TMT_ResaltaHorario (alSTK_IDSubsectores{$l_filaSeleccionada})
		
		
	: ($l_itemSeleccionado=8)  // info
		$b_AsignacionModificada:=TMT_InfoAsignacion ($l_recnumCeldaSeleccionada)
		If ($b_AsignacionModificada)
			TMT_CargaSalas 
			TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
		End if 
		
	: ($l_itemSeleccionado=9)  // resaltar el horario de la asignatura seleccionada
		KRL_GotoRecord (->[TMT_Horario:166];$l_recnumCeldaSeleccionada;False:C215)
		TMT_ResaltaHorario ([TMT_Horario:166]ID_Asignatura:5)
		
	: ($l_itemSeleccionado=11)  // retirar
		$t_textoError:=TMT_RetiraAsignacion ($l_recnumCeldaSeleccionada)
		If ($t_textoError="")
			TMT_CargaSalas 
			TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
		Else 
			CD_Dlog (0;__ ("No fue porsible retirar la asignación de horario.\rPor favor intente nuevamente más tarde."))
		End if 
	: ($l_itemSeleccionado=12)  //MONO TICKET 216065
		b_soloBloquesVigentes:=Not:C34(b_soloBloquesVigentes)
		TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
		OBJECT SET VISIBLE:C603(*;"txt_bloquesvigentes";b_soloBloquesVigentes)
		PREF_Set (<>lUSR_CurrentUserID;"HORARIOsoloBloquesVigentes";String:C10(Num:C11(b_soloBloquesVigentes)))
End case 