//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 187484
  // Fecha y hora: 02-10-18, 09:36:16
  // ----------------------------------------------------
  // Método: ACTwiz_AsignaIDGlosaTramosMas
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$vt_accion)
C_OBJECT:C1216($0;$ob_retorno)
C_POINTER:C301($2;$y_puntero1;$y_puntero2)

If (USR_GetMethodAcces (Current method name:C684))
	
	If (Count parameters:C259=0)
		$vt_accion:="MostrarFormulario"
	Else 
		$vt_accion:=$1
	End if 
	If (Count parameters:C259>=2)
		$y_puntero1:=$2
	End if 
	If (Count parameters:C259>=3)
		$y_puntero2:=$3
	End if 
	
	Case of 
		: ($vt_accion="MostrarFormulario")
			
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTwiz_AsignaIDGlosaParaTramos";0;4;__ ("Asignación de glosa para tramos"))
			DIALOG:C40([xxSTR_Constants:1];"ACTwiz_AsignaIDGlosaParaTramos")
			CLOSE WINDOW:C154
			
		: ($vt_accion="MsgSinItemsParaSeleccion")
			
			C_TEXT:C284($t_mensaje)
			$t_mensaje:=__ ("No se encontraron ítems de cargo para construir la lista de selección.")
			$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor, revise la configuración de ítems de cargo.")
			
			CD_Dlog (0;$t_mensaje)
			
		: ($vt_accion="DeclaraArraysLB")
			
			  //ARRAY BOOLEAN(ab_asignable;0)
			  //ARRAY LONGINT(al_idCargo;0)
			  //ARRAY TEXT(at_glosaCargo;0)
			  //ARRAY LONGINT(al_idTramo;0)
			  //ARRAY TEXT(at_glosaTramo;0)
			
			  //Modificado por: Saul Ponce (07-10-2018)
			C_POINTER:C301($y_control)
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ab_asignable")
			CLEAR VARIABLE:C89($y_control->)
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"al_idCargo")
			CLEAR VARIABLE:C89($y_control->)
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"at_glosaCargo")
			CLEAR VARIABLE:C89($y_control->)
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"al_idTramo")
			CLEAR VARIABLE:C89($y_control->)
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"at_glosaTramo")
			CLEAR VARIABLE:C89($y_control->)
			
			
		: ($vt_accion="InicializaInterfaz")
			
			ACTwiz_AsignaIDGlosaTramosMas ("DeclaraArraysLB")
			ACTwiz_AsignaIDGlosaTramosMas ("PreparaCBPeriodos")
			
		: ($vt_accion="PreparaArraysLB")
			
			C_LONGINT:C283($i;$l_cantItems;$l_idTramo)
			C_BOOLEAN:C305($b_utilizaTramos)  // Modificado por: Saul Ponce (07-10-2018)
			C_LONGINT:C283($l_glosaFalsa)
			C_POINTER:C301($y_columna)  // Modificado por: Saul Ponce (07-10-2018)
			
			$l_glosaFalsa:=-1000
			$l_cantItems:=Num:C11(ACTcfgit_OpcionesGenerales ("buscaItemsADesplegar";$y_puntero1))
			
			If ($l_cantItems>0)
				For ($i;1;$l_cantItems)
					
					  // Modificado por: Saul Ponce (07-10-2018)
					  //APPEND TO ARRAY(al_idCargo;al_IdsItems{$i})
					  //APPEND TO ARRAY(at_glosaCargo;at_GlosasItems{$i})
					  //$l_idTramo:=Num(ACTcfgit_OpcionesGenerales ("retornaIdParaTramoDeEsteItem";->al_IdsItems{$i}))
					  //APPEND TO ARRAY(al_idTramo;$l_idTramo)
					  //APPEND TO ARRAY(at_glosaTramo;ACTcfgit_OpcionesGenerales ("RetornaGlosaParaTramoPorRefItem";->al_IdsItems{$i};->$l_glosaFalsa))
					  //APPEND TO ARRAY(ab_asignable;False)
					
					$b_utilizaTramos:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->al_IdsItems{$i};->[xxACT_Items:179]Utiliza_tramos:38)
					If ($b_utilizaTramos)
						$y_columna:=OBJECT Get pointer:C1124(Object named:K67:5;"al_idCargo")
						APPEND TO ARRAY:C911($y_columna->;al_IdsItems{$i})
						$y_columna:=OBJECT Get pointer:C1124(Object named:K67:5;"at_glosaCargo")
						APPEND TO ARRAY:C911($y_columna->;at_GlosasItems{$i})
						$l_idTramo:=Num:C11(ACTcfgit_OpcionesGenerales ("retornaIdParaTramoDeEsteItem";->al_IdsItems{$i}))
						$y_columna:=OBJECT Get pointer:C1124(Object named:K67:5;"al_idTramo")
						APPEND TO ARRAY:C911($y_columna->;$l_idTramo)
						$y_columna:=OBJECT Get pointer:C1124(Object named:K67:5;"at_glosaTramo")
						APPEND TO ARRAY:C911($y_columna->;ACTcfgit_OpcionesGenerales ("RetornaGlosaParaTramoPorRefItem";->al_IdsItems{$i};->$l_glosaFalsa))
						$y_columna:=OBJECT Get pointer:C1124(Object named:K67:5;"ab_asignable")
						APPEND TO ARRAY:C911($y_columna->;False:C215)
					End if 
				End for 
			End if 
			
		: ($vt_accion="PreparaControlesInterfazLB")
			
			  //Modificado por: Saul Ponce (07-10-2018)
			  //C_POINTER($y_control)
			
			  //$y_control:=OBJECT Get pointer(Object named;"ab_asignable")
			  //COPY ARRAY(ab_asignable;$y_control->)
			  //$y_control:=OBJECT Get pointer(Object named;"al_idCargo")
			  //COPY ARRAY(al_idCargo;$y_control->)
			  //$y_control:=OBJECT Get pointer(Object named;"at_glosaCargo")
			  //COPY ARRAY(at_glosaCargo;$y_control->)
			  //$y_control:=OBJECT Get pointer(Object named;"al_idTramo")
			  //COPY ARRAY(al_idTramo;$y_control->)
			  //$y_control:=OBJECT Get pointer(Object named;"at_glosaTramo")
			  //COPY ARRAY(at_glosaTramo;$y_control->)
			
		: ($vt_accion="PresentarResumen")
			
			C_POINTER:C301($y_control)
			C_LONGINT:C283($l_marcados)
			C_TEXT:C284($t_mensaje;$t_glosaUtilizada)
			
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramo")
			$t_glosaUtilizada:=$y_control->
			
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ab_asignable")
			$l_marcados:=Count in array:C907($y_control->;True:C214)
			
			If ($l_marcados>0)
				  //$t_mensaje:=__ ("Se dispone a modificar ^0 ";String($l_marcados))+Choose($l_marcados=1;"item";"items")
				  //$t_mensaje:=$t_mensaje+__ (" de cargo, estableciendo la glosa utilizada para generar cargos por tramos en:\r\r\r ^0.";$t_glosaUtilizada)+"\r\r\r"
				  //$t_mensaje:=$t_mensaje+__ ("Además, en cada glosa se añadirá un sufijo que indicará el ^0 y ^1 configurado en el tramo.";ST_Qte ("Desde");ST_Qte ("Hasta"))+"\r\r"
				  //$t_mensaje:=$t_mensaje+"\r\r\r"+__ ("Esta nueva glosa será utilizada, a partir de ahora, cada vez que sea necesario generar cargos por tramos para ")
				  //$t_mensaje:=$t_mensaje+Choose($l_marcados=1;"el item";"los items")+__ (" de cargo ")+Choose($l_marcados=1;"seleccionado";"seleccionados")+__ (" en la página anterior.")
				  //$t_mensaje:=$t_mensaje+"\r\r\r"+__ ("Para aplicar los cambios seleccionados en la página anterior presione ")+ST_Qte ("Aceptar")+"."
				  //$t_mensaje:=$t_mensaje+"\r\r\r"+__ ("Para descartar los cambios seleccionados en la página anterior presione ")+ST_Qte ("Cancelar")+"."
				
				  //201801003 RCH
				$t_mensaje:=__ ("Se dispone a modificar ^0 item(s) de cargo, estableciendo la siguiente glosa utilizada para generar cargos por tramos:\n\n ^1.";String:C10($l_marcados);$t_glosaUtilizada)
				$t_mensaje:=$t_mensaje+"\n\n"
				$t_mensaje:=$t_mensaje+__ ("Además, en cada glosa se añadirá un sufijo que indicará el día ^0 y día ^1 configurado en el tramo.";ST_Qte ("Desde");ST_Qte ("Hasta"))
				$t_mensaje:=$t_mensaje+"\n\n"+__ ("Esta nueva glosa será utilizada, a partir de ahora, cada vez que sea necesario generar cargos por tramos para el/los ítem(s) de cargo seleccionado(s) en la página anterior")
				$t_mensaje:=$t_mensaje+"\n\n"+__ ("Para aplicar los cambios seleccionados en la página anterior presione el botón ^0.";ST_Qte ("Aceptar"))
				$t_mensaje:=$t_mensaje+"\n\n"+__ ("Para descartar los cambios seleccionados en la página anterior presione presione el botón ^0.";ST_Qte ("Cancelar"))
				
				
			Else 
				$t_mensaje:=__ ("Ocurrió un error ...")
			End if 
			
			OB SET:C1220($ob_retorno;"msg";$t_mensaje)
			
		: ($vt_accion="recuperaValoresDelItemSeleccionado")
			
			C_POINTER:C301($y_control)
			C_TEXT:C284($t_glosaSeleccionada)
			C_LONGINT:C283($l_idGlosaSeleccionada)
			
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramo")
			$t_glosaSeleccionada:=$y_control->
			
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramoId")
			$l_idGlosaSeleccionada:=$y_control->
			
			OB SET:C1220($ob_retorno;"idItem";$l_idGlosaSeleccionada)
			OB SET:C1220($ob_retorno;"glosaItem";$t_glosaSeleccionada)
			
		: ($vt_accion="recuperaIDsSeleccionadosDesdeLB")
			
			C_LONGINT:C283($r;$l_marcados)
			C_POINTER:C301($y_seleccionados;$y_idSeleccionados)
			ARRAY LONGINT:C221($al_soloSeleccionados;0)
			
			$y_seleccionados:=OBJECT Get pointer:C1124(Object named:K67:5;"ab_asignable")
			$y_idSeleccionados:=OBJECT Get pointer:C1124(Object named:K67:5;"al_idCargo")
			$l_marcados:=Count in array:C907($y_seleccionados->;True:C214)
			
			If ($l_marcados>0)
				For ($r;1;Size of array:C274($y_seleccionados->))
					If ($y_seleccionados->{$r})
						APPEND TO ARRAY:C911($al_soloSeleccionados;$y_idSeleccionados->{$r})
					End if 
				End for 
			End if 
			
			OB SET:C1220($ob_retorno;"elementos_grilla";Size of array:C274($y_seleccionados->))
			OB SET ARRAY:C1227($ob_retorno;"ids";$al_soloSeleccionados)
			
		: ($vt_accion="aplicarCambiosEnItemsSeleccionados")
			
			C_OBJECT:C1216($ob_retornado)
			C_LONGINT:C283($y;$l_idItemSelec;$l_retorno)
			
			ARRAY LONGINT:C221($al_idItem;0)
			ARRAY LONGINT:C221($al_modificados;0)
			CLEAR VARIABLE:C89($ob_retornado)
			$ob_retornado:=ACTwiz_AsignaIDGlosaTramosMas ("recuperaIDsSeleccionadosDesdeLB")
			
			If (Not:C34(OB Is empty:C1297($ob_retornado)))
				OB GET ARRAY:C1229($ob_retornado;"ids";$al_idItem)
				CLEAR VARIABLE:C89($ob_retornado)
				$ob_retornado:=ACTwiz_AsignaIDGlosaTramosMas ("recuperaValoresDelItemSeleccionado")
				
				If (Not:C34(OB Is empty:C1297($ob_retornado)))
					$l_idItemSelec:=OB Get:C1224($ob_retornado;"idItem")
					
					For ($y;1;Size of array:C274($al_idItem))
						$l_retorno:=Num:C11(ACTcfgit_OpcionesGenerales ("almacenaCambioEnGlosaParaTramoDelItem";->$al_idItem{$y};->$l_idItemSelec))
						If ($l_retorno=1)
							APPEND TO ARRAY:C911($al_modificados;$al_idItem{$y})
						End if 
					End for 
				End if 
			End if 
			
			If (Size of array:C274($al_modificados)>0)
				OB SET:C1220($ob_retorno;"estado";1)
				OB SET:C1220($ob_retorno;"idAsignado";$l_idItemSelec)
				OB SET ARRAY:C1227($ob_retorno;"idItemsModificados";$al_modificados)
			Else 
				OB SET:C1220($ob_retorno;"estado";0)
			End if 
			
			
		: ($vt_accion="habilitarProximaPaginaForm")
			
			C_BOOLEAN:C305($b_marcado1;$b_marcado2)
			C_POINTER:C301($y_nombreItem;$y_seleccionadosEnGrilla;$y_proxPagina)
			
			$b_marcado1:=False:C215
			$b_marcado2:=False:C215
			
			$y_nombreItem:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramo")
			$y_seleccionadosEnGrilla:=OBJECT Get pointer:C1124(Object named:K67:5;"ab_asignable")
			
			If ($y_nombreItem->#"")
				$b_marcado1:=True:C214
			End if 
			
			If (Count in array:C907($y_seleccionadosEnGrilla->;True:C214)>0)
				$b_marcado2:=True:C214
			End if 
			
			$y_proxPagina:=OBJECT Get pointer:C1124(Object named:K67:5;"bProxima")
			OBJECT SET ENABLED:C1123($y_proxPagina->;($b_marcado1 & $b_marcado2))
			
			
			
		: ($vt_accion="TildarDestildarTodasLasFilasLB")
			
			C_OBJECT:C1216($ob_retornado)
			C_LONGINT:C283($l_totalFilas)
			ARRAY LONGINT:C221($al_idsSel;0)
			
			$ob_retornado:=ACTwiz_AsignaIDGlosaTramosMas ("recuperaIDsSeleccionadosDesdeLB")
			
			If (Not:C34(OB Is empty:C1297($ob_retornado)))
				$l_totalFilas:=OB Get:C1224($ob_retornado;"elementos_grilla")
				OB GET ARRAY:C1229($ob_retornado;"ids";$al_idsSel)
				
				$y_proxPagina:=OBJECT Get pointer:C1124(Object named:K67:5;"chk_todos")
				If ($l_totalFilas=Size of array:C274($al_idsSel))
					$y_proxPagina->:=1
				Else 
					$y_proxPagina->:=0
				End if 
			End if 
			ACTwiz_AsignaIDGlosaTramosMas ("actualizaContadores")
			
			
			
		: ($vt_accion="PreparaCBPeriodos")
			
			C_POINTER:C301($y_listaAños)
			
			ARRAY TEXT:C222($at_periodo;0)
			ARRAY LONGINT:C221($al_vacios;0)
			
			READ ONLY:C145([xxACT_Items:179])
			  //ALL RECORDS([xxACT_Items])   //Modificado por: Saul Ponce (07-10-2018)
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1>0)
			DISTINCT VALUES:C339([xxACT_Items:179]Periodo:42;$at_periodo)
			KRL_UnloadReadOnly (->[xxACT_Items:179])
			SORT ARRAY:C229($at_periodo;<)
			
			$at_periodo{0}:=""
			AT_SearchArray (->$at_periodo;"=";->$al_vacios)
			If (Size of array:C274($al_vacios)>0)
				For ($r;Size of array:C274($al_vacios);1;-1)
					AT_Delete ($al_vacios{$r};1;->$at_periodo)
				End for 
			End if 
			
			If (Size of array:C274($at_periodo)>0)
				AT_Insert (1;1;->$at_periodo)
				$at_periodo{1}:=__ ("Todos")
				$at_periodo{0}:=$at_periodo{1}
			End if 
			
			$y_listaAños:=OBJECT Get pointer:C1124(Object named:K67:5;"cb_filtroAños")
			COPY ARRAY:C226($at_periodo;$y_listaAños->)
			
		: ($vt_accion="LogAsignacionIDGlosaParaTramos")
			
			C_LONGINT:C283($l_idItem)
			C_TEXT:C284($t_glosaUtilizada)
			
			ARRAY LONGINT:C221($al_idItem;0)
			
			$l_idItem:=$y_puntero1->
			COPY ARRAY:C226($y_puntero2->;$al_idItem)
			$t_glosaUtilizada:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$l_idItem;->[xxACT_Items:179]Glosa:2)
			LOG_RegisterEvt ("Asignación de glosa "+$t_glosaUtilizada+" para los cargos por tramos en los siguientes id's de items de cargos: "+AT_array2text (->$al_idItem;"; ")+".")
			
		: ($vt_accion="actualizaContadores")
			
			C_LONGINT:C283($l_cantSelec)
			C_POINTER:C301($y_contador;$y_totalizador;$y_array)
			$y_array:=OBJECT Get pointer:C1124(Object named:K67:5;"ab_asignable")
			$l_cantSelec:=Count in array:C907($y_array->;True:C214)
			
			$y_seleccionados:=OBJECT Get pointer:C1124(Object named:K67:5;"t_selec")
			$y_seleccionados->:=String:C10($l_cantSelec)
			
			$y_seleccionados:=OBJECT Get pointer:C1124(Object named:K67:5;"t_total")
			$y_seleccionados->:=String:C10(Size of array:C274($y_array->))
			
		: ($vt_accion="pruebasTramos")
			
			  // Para pruebas de rendimiento del "On Load" del asistente. 
			  // al seleccionar la opción "Crear 1 Tramo" -> marca el atributo utiliza_tramos y crea un registro en [xxACT_ItemsTramos]
			  // al seleccionar la opción "Eliminar Todos los Tramos" -> desmarca el atributo utiliza_tramos y elimina todos los registros relacionados en [xxACT_ItemsTramos]
			
			ARRAY TEXT:C222($at_accion;0)
			APPEND TO ARRAY:C911($at_accion;"Crear 1 Tramo")
			APPEND TO ARRAY:C911($at_accion;"Eliminar Todos los Tramos")
			
			SRtbl_ShowChoiceList (0;"¿Qué desea Hacer?";2;->brepositorio;False:C215;->$at_accion)
			
			If (choiceidx>0)
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1>0)
				If (Records in selection:C76([xxACT_Items:179])>0)
					C_BOOLEAN:C305($b_utilizaTramos)
					C_LONGINT:C283($r;$l_prog;$l_cont)
					
					ARRAY TEXT:C222($at_accionMsj;0)
					ARRAY LONGINT:C221($al_recNumItems;0)
					
					APPEND TO ARRAY:C911($at_accionMsj;"crearon")
					APPEND TO ARRAY:C911($at_accionMsj;"eliminaron")
					
					$b_utilizaTramos:=Choose:C955(choiceidx=1;True:C214;False:C215)
					
					SELECTION TO ARRAY:C260([xxACT_Items:179];$al_recNumItems)
					READ WRITE:C146([xxACT_Items:179])
					$l_prog:=IT_Progress (1;0;0;"Procesando items de cargo .. ")
					For ($r;1;Size of array:C274($al_recNumItems))
						$l_prog:=IT_Progress (0;$l_prog;$r/Size of array:C274($al_recNumItems))
						GOTO RECORD:C242([xxACT_Items:179];$al_recNumItems{$r})
						[xxACT_Items:179]Utiliza_tramos:38:=$b_utilizaTramos
						SAVE RECORD:C53([xxACT_Items:179])
						If ($b_utilizaTramos)
							$l_proceso:=Num:C11(ACTcfgit_OpcionesGenerales ("UtilizaTramos";->$b_utilizaTramos))
						Else 
							$l_proceso:=Num:C11(ACTcfgit_OpcionesGenerales ("EliminaTramosItem";->[xxACT_Items:179]ID:1))
						End if 
						If ($l_proceso=1)
							$l_cont:=($l_cont+1)
						End if 
						AT_Initialize (->alACT_ITid;->alACT_ITdesde;->alACT_IThasta;->abACT_ITesMontoFijo;->arACT_ITvalor)
					End for 
					$l_prog:=IT_Progress (-1;$l_prog)
					KRL_UnloadReadOnly (->[xxACT_Items:179])
					CD_Dlog (0;"Se "+$at_accionMsj{choiceidx}+" tramos para "+String:C10($l_cont)+" items de cargo.")
				Else 
					CD_Dlog (0;"No existen items de cargo para crearles tramos.")
				End if 
			End if 
			
			
			
	End case 
End if 

$0:=$ob_retorno