  // [Actividades].Input.retirar()
  // Por: Alberto Bachler K.: 05-06-14, 13:52:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$j;$l_filaSeleccionada;$l_opcionUsuario;$l_recNumActividad)
C_POINTER:C301($y_Idalumnos_al;$y_listaAlumnosInscritos;$y_periodoSeleccionado)
C_TEXT:C284($t_detalle;$t_nombrePeriodo;$t_titulo)

ARRAY LONGINT:C221($al_filasSeleccionadas;0)


ARRAY LONGINT:C221($al_filasSeleccionadas;0)
$y_listaAlumnosInscritos:=OBJECT Get pointer:C1124(Object named:K67:5;"ListaAlumnosInscritos")
$y_Idalumnos_al:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosId")
$y_periodoSeleccionado:=OBJECT Get pointer:C1124(Object named:K67:5;"periodo")
If ($y_periodoSeleccionado->>0)
	$t_nombrePeriodo:=atSTR_Periodos_Nombre{$y_periodoSeleccionado->}
End if 

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		If (OBJECT Get enabled:C1079(*;OBJECT Get name:C1087(Object current:K67:2)))
			IT_MuestraTip (__ ("Retirar Alumnos"))
		Else 
			If (USR_checkRights ("M";->[Actividades:29]))
				IT_MuestraTip (__ ("Retirar Alumnos")+"\r"+__ ("Seleccione los alumnos a retirar para activar el botón"))
			Else 
				IT_MuestraTip (__ ("Retirar Alumnos")+"\r"+__ ("Usted no está autorizado para esta operación"))
			End if 
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		$l_filaSeleccionada:=LB_GetSelectedRows ($y_listaAlumnosInscritos;->$al_filasSeleccionadas)
		If ($y_periodoSeleccionado->>0)
			$t_nombrePeriodo:=atSTR_Periodos_Nombre{$y_periodoSeleccionado->}
			
			$t_titulo:=__ ("Retiro de alumnos de ")+[Actividades:29]Nombre:2
			$t_detalle:=__ ("Si retira los alumnos seleccionados de todos los períodos se eliminarán las evaluaciones e inasistencia registradas para ellos en esta actividad.")
			$t_detalle:=$t_detalle+"\r"+__ ("Si opta por retirar los alumnos seleccionados solo en un período, la información registrada se conservará pero el alumno dejará de aparecer en las nóminas en ese período.")
			$t_detalle:=$t_detalle+"\r\r"+__ ("¿Desea retirar los alumnos seleccionados de esta actividad del ^0 o de todos los períodos?")
			$t_detalle:=Replace string:C233($t_detalle;"^0";IT_SetTextStyle_Bold (->$t_nombrePeriodo;True:C214))
			$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_detalle;__ ("Cancelar");__ ("De todos los períodos");$t_nombrePeriodo)
		Else 
			$t_titulo:=__ ("Retiro de alumnos de ")+[Actividades:29]Nombre:2
			$t_detalle:=__ ("Si retira los alumnos seleccionados se eliminarán las evaluaciones e inasistencia registradas para ellos en esta actividad.")
			$t_detalle:=$t_detalle+"\r\r"+__ ("¿Desea realmente retirar estos alumnos?")
			$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_detalle;__ ("Cancelar");__ ("Retirar"))
		End if 
		Case of 
			: ($l_opcionUsuario=2)
				For ($i;1;Size of array:C274($al_filasSeleccionadas))
					QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Alumno_Numero:1=$y_Idalumnos_al->{$al_filasSeleccionadas{$i}};*)
					QUERY:C277([Alumnos_Actividades:28]; & [Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
					QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Año:3=<>gyear)
					OK:=KRL_DeleteRecord (->[Alumnos_Actividades:28])
					If (ok=1)
						LOG_RegisterEvt ("Alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Actividades:28]Alumno_Numero:1;->[Alumnos:2]apellidos_y_nombres:40)+" retirado de la actividad: "+[Actividades:29]Nombre:2+", ID "+String:C10([Alumnos_Actividades:28]ID:63)+".")
					End if 
				End for 
				
				
				
				
			: ($l_opcionUsuario=3)
				For ($i;1;Size of array:C274($al_filasSeleccionadas))
					QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Alumno_Numero:1=$y_Idalumnos_al->{$al_filasSeleccionadas{$i}};*)
					QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
					QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Año:3=<>gyear)
					KRL_ReloadInReadWriteMode (->[Alumnos_Actividades:28])
					If ([Alumnos_Actividades:28]Periodos_Inscritos:44=1)
						[Alumnos_Actividades:28]Periodos_Inscritos:44:=[Alumnos_Actividades:28]Periodos_Inscritos:44 ?- 0
						For ($j;1;Size of array:C274(atSTR_Periodos_Nombre))
							[Alumnos_Actividades:28]Periodos_Inscritos:44:=[Alumnos_Actividades:28]Periodos_Inscritos:44 ?+ $j
						End for 
					End if 
					[Alumnos_Actividades:28]Periodos_Inscritos:44:=[Alumnos_Actividades:28]Periodos_Inscritos:44 ?- $y_periodoSeleccionado->
					If ([Alumnos_Actividades:28]Periodos_Inscritos:44=0)
						LOG_RegisterEvt ("Alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Actividades:28]Alumno_Numero:1;->[Alumnos:2]apellidos_y_nombres:40)+" retirado de la actividad: "+[Actividades:29]Nombre:2+", ID "+String:C10([Alumnos_Actividades:28]ID:63)+".")
						OK:=KRL_DeleteRecord (->[Alumnos_Actividades:28])
					Else 
						LOG_RegisterEvt ("Alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Actividades:28]Alumno_Numero:1;->[Alumnos:2]apellidos_y_nombres:40)+" retirado de la actividad: "+[Actividades:29]Nombre:2+", ID "+String:C10([Alumnos_Actividades:28]ID:63)+", para el período: "+$t_nombrePeriodo+".")
						OK:=KRL_DeleteRecord (->[Alumnos_Actividades:28])
					End if 
					KRL_UnloadReadOnly (->[Alumnos_Actividades:28])
				End for 
				$l_recNumActividad:=Record number:C243([Actividades:29])
				XCR_ContabilizaInscritos ([Actividades:29]ID:1)
				KRL_GotoRecord (->[Actividades:29];$l_recNumActividad;True:C214)
				
				XCR_ListaAlumnosInscritos 
				
		End case 
		
		$l_recNumActividad:=Record number:C243([Actividades:29])
		XCR_ContabilizaInscritos ([Actividades:29]ID:1)
		KRL_GotoRecord (->[Actividades:29];$l_recNumActividad;True:C214)
		
		XCR_ListaAlumnosInscritos 
		
End case 
