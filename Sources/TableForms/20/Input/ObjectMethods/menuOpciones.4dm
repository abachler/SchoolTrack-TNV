  // [xxSTR_Materias].Input.menuOpciones()
  // Por: Alberto Bachler K.: 12-06-15, 18:38:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_permisos)
C_BOOLEAN:C305($b_configuracionesPropias;$b_otrosPermisos;$b_profesoresAutorizados;$leerMatriz)
C_LONGINT:C283($i;$l_fila;$l_idMatrizOriginal;$l_nivelNumero;$l_numeroNivel;$l_opcion;$l_opcionUsuario;$l_recNumMatrizSeleccionada;$l_recNumNuevaMatriz;$recNumArea)
C_LONGINT:C283($recNumAsignaturas;$records)
C_POINTER:C301($y_listaEnunciadosMapas;$y_listaEnunciadosMatriz;$y_listboxMatrices;$y_nivelNumero_al;$y_nombreMatriz_at;$y_nombreNivel;$y_recNumMatriz_al)
C_TEXT:C284($t_mensaje;$t_menu;$t_nombreMatriz;$t_nombreNivel;$t_opcion;$t_tituloMatriz)

ARRAY LONGINT:C221($al_recNums;0)

$y_recNumMatriz_al:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizRecnum")
$y_nombreMatriz_at:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizNombre")
$l_recNumMatrizSeleccionada:=$y_recNumMatriz_al->{$y_recNumMatriz_al->}
$t_nombreMatriz:=$y_nombreMatriz_at->{$y_nombreMatriz_at->}
$y_nivelNumero_al:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$l_numeroNivel:=$y_nivelNumero_al->{$y_nivelNumero_al->}
$y_nombreNivel:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNombre")
$t_nombreNivel:=$y_nombreNivel->{$y_nombreNivel->}

$y_listaEnunciadosMatriz:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")
$y_listaEnunciadosMapas:=OBJECT Get pointer:C1124(Object named:K67:5;"enunciadosMapa")

Case of 
	: (Form event:C388=On Clicked:K2:4)
		QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
		QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_numeroNivel;*)
		QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
		$b_profesoresAutorizados:=[MPA_AsignaturasMatrices:189]PersonalizacionPermitida:21
		$b_otrosPermisos:=(BLOB size:C605([MPA_AsignaturasMatrices:189]xPermisos:5)>0)
		
		$t_menu:=Create menu:C408
		If ([MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19)
			APPEND MENU ITEM:C411($t_menu;"("+__ ("Establecer como matriz por defecto"))
		Else 
			APPEND MENU ITEM:C411($t_menu;__ ("Establecer como matriz por defecto"))
			SET MENU ITEM PARAMETER:C1004($t_menu;-1;"matrizDefecto")
		End if 
		APPEND MENU ITEM:C411($t_menu;"-")
		APPEND MENU ITEM:C411($t_menu;__ ("Renombrar…"))
		SET MENU ITEM PARAMETER:C1004($t_menu;-1;"renombrar")
		APPEND MENU ITEM:C411($t_menu;__ ("Duplicar…"))
		SET MENU ITEM PARAMETER:C1004($t_menu;-1;"duplicar")
		APPEND MENU ITEM:C411($t_menu;"-")
		If ([MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19)
			APPEND MENU ITEM:C411($t_menu;"("+__ ("Eliminar"))
		Else 
			APPEND MENU ITEM:C411($t_menu;__ ("Eliminar"))
			SET MENU ITEM PARAMETER:C1004($t_menu;-1;"eliminar")
		End if 
		APPEND MENU ITEM:C411($t_menu;"-")
		APPEND MENU ITEM:C411($t_menu;__ ("Asignar"))
		SET MENU ITEM PARAMETER:C1004($t_menu;-1;"asignar")
		APPEND MENU ITEM:C411($t_menu;"-")
		APPEND MENU ITEM:C411($t_menu;__ ("Opciones de cálculo…"))
		SET MENU ITEM PARAMETER:C1004($t_menu;-1;"opciones")
		APPEND MENU ITEM:C411($t_menu;"-")
		APPEND MENU ITEM:C411($t_menu;__ ("Autorizar profesores a crear sus propias matrices…"))
		SET MENU ITEM PARAMETER:C1004($t_menu;-1;"autorizarProfesores")
		If ($b_profesoresAutorizados)
			SET MENU ITEM MARK:C208($t_menu;-1;Char:C90(18))
		End if 
		APPEND MENU ITEM:C411($t_menu;__ ("Autorizar a otros usuarios a crear matrices…"))
		SET MENU ITEM PARAMETER:C1004($t_menu;-1;"autorizarOtros")
		If ($b_otrosPermisos)
			SET MENU ITEM MARK:C208($t_menu;-1;Char:C90(18))
		End if 
		$t_opcion:=Dynamic pop up menu:C1006($t_menu)
		
		Case of 
			: ($t_opcion="matrizDefecto")
				$l_opcionUsuario:=CD_Dlog (0;__ ("La matriz seleccionada será utilizada como matriz de referencia para todas las asignaturas de este nivel.\rEsto no afecta las matrices actualmente asignadas a las asignaturas.\r\r¿Continuar?");"";__ ("Si");__ ("No"))
				If ($l_opcionUsuario=1)
					READ WRITE:C146([MPA_AsignaturasMatrices:189])
					QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_numeroNivel;*)
					QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
					If ([MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19)
						$b_configuracionesPropias:=[MPA_AsignaturasMatrices:189]PersonalizacionPermitida:21
						$x_permisos:=[MPA_AsignaturasMatrices:189]xPermisos:5
						[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19:=False:C215
						SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
					End if 
					KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatrizSeleccionada;True:C214)
					[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19:=True:C214
					[MPA_AsignaturasMatrices:189]PersonalizacionPermitida:21:=$b_configuracionesPropias
					[MPA_AsignaturasMatrices:189]xPermisos:5:=$x_permisos
					SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
					KRL_ReloadAsReadOnly (->[MPA_AsignaturasMatrices:189])
				End if 
				
				
			: ($t_opcion="renombrar")
				$t_nombreMatriz:=ModernUI_Peticion (__ ("Renombrar matriz de evaluación de aprendizaje");__ ("Por favor ingrese el nuevo nombre de la matriz:");"";$t_nombreMatriz;__ ("Aceptar");__ ("Cancelar"))
				If (Find in field:C653([MPA_AsignaturasMatrices:189]NombreMatriz:2;$t_nombreMatriz)>=0)
					BEEP:C151
				Else 
					KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatrizSeleccionada;True:C214)
					If (OK=1)
						[MPA_AsignaturasMatrices:189]NombreMatriz:2:=$t_nombreMatriz
						SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
						KRL_ReloadAsReadOnly (->[MPA_AsignaturasMatrices:189])
						$y_nombreMatriz_at->{$y_nombreMatriz_at->}:=$t_nombreMatriz
						$leerMatriz:=True:C214
					End if 
				End if 
				
			: ($t_opcion="duplicar")
				$l_idMatrizOriginal:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
				$recNumArea:=Find in field:C653([MPA_DefinicionAreas:186]AreaAsignatura:4;[xxSTR_Materias:20]AreaMPA:4)
				KRL_GotoRecord (->[MPA_DefinicionAreas:186];$recNumArea;False:C215)
				If (OK=1)
					If (Find in field:C653([MPA_AsignaturasMatrices:189]NombreMatriz:2;$t_nombreMatriz)>=0)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
						QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]NombreMatriz:2;=;$t_nombreMatriz+"@")
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						$t_nombreMatriz:=$t_nombreMatriz+" ("+String:C10($records+1)+")"
					End if 
				End if 
				$t_nombreMatriz:=CD_Request (__ ("Nombre de la nueva matriz de Evaluación:");__ ("Aceptar");__ ("Cancelar");"";$t_nombreMatriz)
				If (OK=1)
					KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatrizSeleccionada)
					DUPLICATE RECORD:C225([MPA_AsignaturasMatrices:189])
					[MPA_AsignaturasMatrices:189]ID_Matriz:1:=SQ_SeqNumber (->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
					[MPA_AsignaturasMatrices:189]ID_Creador:20:=<>lUSR_CurrentUserID
					[MPA_AsignaturasMatrices:189]CreadaPor:15:=<>tUSR_CurrentUser
					[MPA_AsignaturasMatrices:189]DTS_Creacion:16:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
					[MPA_AsignaturasMatrices:189]ModificadaPor:17:=[MPA_AsignaturasMatrices:189]CreadaPor:15
					[MPA_AsignaturasMatrices:189]DTS_Modificacion:18:=[MPA_AsignaturasMatrices:189]DTS_Creacion:16
					[MPA_AsignaturasMatrices:189]ID_Area:22:=[MPA_DefinicionAreas:186]ID:1
					[MPA_AsignaturasMatrices:189]Area:13:=[MPA_DefinicionAreas:186]AreaAsignatura:4
					[MPA_AsignaturasMatrices:189]Asignatura:3:=[xxSTR_Materias:20]Materia:2
					[MPA_AsignaturasMatrices:189]NumeroNivel:4:=$l_numeroNivel
					[MPA_AsignaturasMatrices:189]NombreMatriz:2:=$t_nombreMatriz
					[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19:=False:C215
					SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
					$l_recNumNuevaMatriz:=Record number:C243([MPA_AsignaturasMatrices:189])
					
					QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=$l_idMatrizOriginal)
					LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$al_recNums;"")
					For ($i;1;Size of array:C274($al_recNums))
						GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_recNums{$i})
						DUPLICATE RECORD:C225([MPA_ObjetosMatriz:204])
						[MPA_ObjetosMatriz:204]ID_Matriz:1:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					End for 
					GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$l_recNumNuevaMatriz)
					APPEND TO ARRAY:C911($y_nombreMatriz_at->;[MPA_AsignaturasMatrices:189]NombreMatriz:2)
					APPEND TO ARRAY:C911($y_recNumMatriz_al->;$l_recNumNuevaMatriz)
					LISTBOX SELECT ROW:C912(*;"lb_matrices";Size of array:C274($y_nombreMatriz_at->))
					MPA_ListaEnunciadosMatriz ($l_recNumNuevaMatriz;$l_numeroNivel;$y_listaEnunciadosMatriz)
					$t_tituloMatriz:=__ ("Competencias en ^0")
					$t_tituloMatriz:=Replace string:C233($t_tituloMatriz;"^0";$t_nombreMatriz)
					OBJECT SET TITLE:C194(*;"tituloMatriz";$t_tituloMatriz)
				End if 
				
			: ($t_opcion="eliminar")
				KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatrizSeleccionada;True:C214)
				$recNumAsignaturas:=Find in field:C653([Asignaturas:18]EVAPR_IdMatriz:91;[MPA_AsignaturasMatrices:189]ID_Matriz:1)
				If ($recNumAsignaturas>=0)
					CD_Dlog (0;__ ("Esta matriz es utilizada por una o más asignaturas.\r\rNo es posible eliminar una matriz mientras esté asignada a alguna asignatura."))
				Else 
					If (OK=1)
						DELETE RECORD:C58([MPA_AsignaturasMatrices:189])
						$l_fila:=$y_nombreMatriz_at->
						DELETE FROM ARRAY:C228($y_nombreMatriz_at->;$l_fila)
						DELETE FROM ARRAY:C228($y_recNumMatriz_al->;$l_fila)
						LISTBOX SELECT ROW:C912(*;"lb_matrices";1)
						MPA_ListaEnunciadosMatriz ($y_recNumMatriz_al->{$y_recNumMatriz_al->};$l_numeroNivel;$y_listaEnunciadosMatriz)
					End if 
				End if 
				
				
			: ($t_opcion="asignar")
				$t_mensaje:=__ ("¿Está seguro que desea asignar esta matriz de evaluación a las asignaturas ^0 en ^1?")
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";[xxSTR_Materias:20]Materia:2)
				$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_nombreNivel)
				$l_opcion:=ModernUI_Notificacion (__ ("Asignar matriz de evaluación a asignaturas");$t_mensaje;__ ("Cancelar");__ ("Asignar"))
				If ($l_opcion=2)
					READ WRITE:C146([Asignaturas:18])
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
					QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6=$l_numeroNivel)
					APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91:=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
					KRL_UnloadReadOnly (->[Asignaturas:18])
				End if 
				
			: ($t_opcion="opciones")
				MPAmtx_OpcionesCalculo 
				
				
			: ($t_opcion="autorizarProfesores")
				READ WRITE:C146([MPA_AsignaturasMatrices:189])
				QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_numeroNivel;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
				[MPA_AsignaturasMatrices:189]PersonalizacionPermitida:21:=Not:C34([MPA_AsignaturasMatrices:189]PersonalizacionPermitida:21)
				SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
				KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatrizSeleccionada;True:C214)
				
				
			: ($t_opcion="autorizarOtros")
				READ WRITE:C146([MPA_AsignaturasMatrices:189])
				QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=$l_numeroNivel;*)
				QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
				WDW_OpenDialogInDrawer (->[MPA_AsignaturasMatrices:189];"Permisos")
				KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatrizSeleccionada;True:C214)
		End case 
		
	Else 
		$y_listboxMatrices:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_matrices")
		If (Find in array:C230($y_listboxMatrices->;True:C214)<0)
			$y_recNumMatriz_al->:=0
			HL_ClearList ($y_listaEnunciadosMatriz->)
		Else 
			If ($y_nivelNumero_al-><=0)
				KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatrizSeleccionada;False:C215)
				$y_nivelNumero_al->:=Find in array:C230($y_nivelNumero_al->;[MPA_AsignaturasMatrices:189]NumeroNivel:4)
				$l_nivelNumero:=$y_nivelNumero_al->{$y_nivelNumero_al->}
				LISTBOX SELECT ROW:C912(*;"listbox.niveles";$y_nivelNumero_al->;lk replace selection:K53:1)
				MPA_ListaEnunciadosMapa ([xxSTR_Materias:20]Materia:2;$l_nivelNumero;$y_listaEnunciadosMapas)
			End if 
		End if 
		
End case 


