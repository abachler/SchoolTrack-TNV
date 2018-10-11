  // [xxBBL_Preferencias].CFG_CodigosBarra.Grupos_lectores()
  // Por: Alberto Bachler: 14/09/13, 17:32:10
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_Error;$l_idGrupoLectores;$l_IDProgreso;$l_numeroLectores;$l_opcionUsuario)
C_TEXT:C284($t_mensajeProgreso;$t_Textolog;$t_valorAntesEdicion;$t_valorDespuesEdicion)

ARRAY LONGINT:C221($al_RecNums;0)

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		EDIT ITEM:C870(<>atBBL_GruposLectores;<>atBBL_GruposLectores)
		
	: (Form event:C388=On Data Change:K2:15)
		$t_valorAntesEdicion:=<>atBBL_GruposLectores{0}
		$t_valorDespuesEdicion:=<>atBBL_GruposLectores{<>atBBL_GruposLectores}
		$l_idGrupoLectores:=<>alBBL_GruposLectores{<>atBBL_GruposLectores}
		
		If (al_NumeroLectoresMediaTrack{<>atBBL_GruposLectores}>0)
			$l_numeroLectores:=al_NumeroLectoresMediaTrack{<>atBBL_GruposLectores}
			  // inicio la transacción antes de mostrar el mensaje para evitar el registro en el log si la transacción debe
			  // ser cancelada debido a registros bloqueados en la selección resultante de la búsqueda.
			START TRANSACTION:C239
			
			  // Inicializo el componente IT_Confirmacion
			IT_Confirmacion_Inicializa 
			
			  //Cargo los elementos que se mostrarán en el mensaje de confirmación
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("189/_Encabezado"))
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("190/btn1_ConfirmarCambio"))
			IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("191/btn2_Cancelar"))
			
			  // Paso los tags que deberan ser procesados en el componente IT_Confirmacion ante de desplegar el mensaje
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$l_numeroLectores";String:C10($l_numeroLectores))
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_valorAntesEdicion";$t_valorAntesEdicion)
			$l_Error:=IT_Confirmacion_AgregaTagValor ("$t_valorDespuesEdicion";$t_valorDespuesEdicion)
			
			  // Muestro el cuadro de diálogo de confirmación
			  // pasa en $t_textoLog el encabezado para el registro de actividades
			$t_Textolog:=__ ("Modificacion del nombre del grupo de lectores")
			$l_opcionUsuario:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
			
			
			If ($l_opcionUsuario=1)
				SET QUERY AND LOCK:C661(True:C214)
				QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$t_valorAntesEdicion)
				If (Records in set:C195("LockedSet")>0)
					CANCEL TRANSACTION:C241
					<>atBBL_GruposLectores{<>atBBL_GruposLectores}:=$t_valorAntesEdicion
					CD_Dlog (0;__ ("No es posible ejecutar esta operación en este momento.\rPor favor intente nuevamente más tarde."))
				Else 
					QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37;=;$l_idGrupoLectores)
					LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$al_RecNums;"")
					$t_mensajeProgreso:=__ ("Cambiando tipo de documento...")
					$l_IDProgreso:=IT_Progress (1;$l_IDProgreso;0;$t_mensajeProgreso)
					For ($i_registros;1;Size of array:C274($al_RecNums))
						READ WRITE:C146([BBL_Lectores:72])
						GOTO RECORD:C242([BBL_Lectores:72];$al_RecNums{$i_registros})
						[BBL_Lectores:72]Grupo:2:=$t_valorDespuesEdicion
						SAVE RECORD:C53([BBL_Lectores:72])
						$l_IDProgreso:=IT_Progress (0;$l_IDProgreso;$i_registros/Size of array:C274($al_RecNums);$t_mensajeProgreso+"\r"+[BBL_Lectores:72]NombreCompleto:3)
					End for 
					$l_IDProgreso:=IT_Progress (-1;$l_IDProgreso)
					KRL_UnloadReadOnly (->[BBL_Lectores:72])
					VALIDATE TRANSACTION:C240
				End if 
				SET QUERY AND LOCK:C661(False:C215)
			Else 
				<>atBBL_GruposLectores{<>atBBL_GruposLectores}:=$t_valorAntesEdicion
			End if 
		End if 
		
		BBLcfg_GuardaCambiosGruposLect 
		BBLcfg_Listbox_CodigosBarra 
		
	Else 
		POST KEY:C465(Tab key:K12:28)
		GOTO OBJECT:C206(lb_GruposLectores)
		LISTBOX SELECT ROW:C912(lb_GruposLectores;<>atBBL_GruposLectores;lk replace selection:K53:1)
End case 

