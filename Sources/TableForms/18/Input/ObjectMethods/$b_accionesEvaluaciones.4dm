  // [Asignaturas].Input.$b_accionesEvaluaciones()
  // Por: Alberto Bachler K.: 05-02-14, 09:13:12
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BLOB:C604($x_RecNumsArray)
C_BOOLEAN:C305($b_promediosBasadosEnAprendizaje)
C_LONGINT:C283($l_hoja;$l_itemSeleccionado;$l_periodo;$l_refXLS;$l_registroAlmacenado;$i)
C_TEXT:C284($t_fecha;$t_ItemsMenu;$t_rutaDocumento)

ARRAY LONGINT:C221($al_ColumnasVisibles;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)
ARRAY POINTER:C280($ay_Arreglos;0)
ARRAY TEXT:C222($at_Encabezados;0)


Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		AL_ExitCell (xALP_ASNotas)
		
	: (Form event:C388=On Clicked:K2:4)
		$b_promediosBasadosEnAprendizaje:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
		Case of 
			: ($b_promediosBasadosEnAprendizaje)
				$t_ItemsMenu:=__ ("Recalcular;(-;Exportar planilla a Excel;Ver Estadísticas...;(-;Ir a Observaciones;(-;(Propiedades de evaluación…")
			: ([Asignaturas:18]Resultado_no_calculado:47)
				$t_ItemsMenu:=__ ("(Recalcular;(-;Exportar planilla a Excel;Ver Estadísticas...;(-;Ir a Observaciones;(-;(Propiedades de evaluación…")
			Else 
				$t_ItemsMenu:=__ ("Recalcular;(-;Exportar planilla a Excel;Ver Estadísticas...;(-;Ir a Observaciones;(-;Propiedades de evaluación…")
		End case 
		$t_ItemsMenu:=Replace string:C233($t_ItemsMenu;";;";";")
		
		$l_itemSeleccionado:=Pop up menu:C542($t_ItemsMenu)
		
		Case of 
			: ($l_ItemSeleccionado=1)
				If (<>vb_BloquearModifSituacionFinal)
					CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
				Else 
					vlSTR_PeriodoSeleccionado:=aiSTR_Periodos_Numero{atSTR_Periodos_Nombre}
					APPEND TO ARRAY:C911($al_RecNumsAsignaturas;Record number:C243([Asignaturas:18]))
					BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumsAsignaturas)
					EV2dbu_Recalculos ($x_RecNumsArray)
					KRL_GotoRecord (->[Asignaturas:18];$al_RecNumsAsignaturas{1})
					atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;vlSTR_PeriodoSeleccionado)
					AS_PaginaEvaluacion 
				End if 
				
			: ($l_ItemSeleccionado=3)
				AL_GetObjects (xALP_ASNotas;ALP_Object_Visible;$al_ColumnasVisibles)
				AL_GetObjects (xALP_ASNotas;ALP_Object_Columns;$ay_Arreglos)
				AL_GetObjects (xALP_ASNotas;ALP_Object_HeaderText;$at_Encabezados)
				If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
					For ($i;Size of array:C274($ay_Arreglos);1;-1)
						If ($al_ColumnasVisibles{$i}=0)
							DELETE FROM ARRAY:C228($ay_Arreglos;$i)
							DELETE FROM ARRAY:C228($at_Encabezados;$i)
						End if 
					End for 
				Else 
					For ($i;1;Size of array:C274($ay_Arreglos))
						If ($at_Encabezados{$i}="")
							RESOLVE POINTER:C394($ay_Arreglos{$i};$t_nombreVar;$l_numeroTabla;$l_numeroCampo)
							$at_Encabezados{$i}:=$t_nombreVar
						End if 
					End for 
				End if 
				
				$t_rutaDocumento:=Temporary folder:C486+"Calificaciones "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+", "+[Asignaturas:18]profesor_nombre:13+".xls"
				$l_refLibro:=XLS_CreateBook 
				$l_refHoja:=XLS_CreateSheet ($l_refLibro;"Calificaciones")
				XLS_SetColumns ($l_refHoja;->$ay_Arreglos;->$at_Encabezados)
				XLS_SaveDocument ($l_refLibro;$t_rutaDocumento)
				XLS_ClearSheet ($l_refHoja)
				XLS_ClearBook ($l_refLibro)
				OPEN URL:C673($t_rutaDocumento)
				
				
			: ($l_ItemSeleccionado=4)
				AS_Estadisticas 
				WDW_OpenFormWindow (->[Asignaturas:18];"Statistics";-1;8;__ ("Estadisticas sobre la asignatura"))
				DIALOG:C40([Asignaturas:18];"Statistics")
				CLOSE WINDOW:C154
				
			: ($l_ItemSeleccionado=6)
				AS_OnRecordLoad (4)
				
			: ($l_ItemSeleccionado=8)
				$l_AutorizarPropEval:=Num:C11(PREF_fGet (0;"PermitirConfigPropEval";"0"))
				If ((USR_checkRights ("M";->[Asignaturas:18])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ($l_AutorizarPropEval=1))
					$l_registroAlmacenado:=AS_fSave 
					$l_periodoActual:=atSTR_Periodos_Nombre
					AS_PropEval_Configura 
					PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
					vl_LastPeriod:=$l_periodoActual
					vlSTR_PeriodoSeleccionado:=$l_periodoActual
					atSTR_Periodos_Nombre:=$l_periodoActual
					AS_PaginaEvaluacion 
				Else 
					USR_ALERT_UserHasNoRights (4)
				End if 
		End case 
End case 