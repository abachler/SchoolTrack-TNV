//%attributes = {}
  // MÉTODO: dbu_VerificaConsolidaciones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 16:59:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // dbu_VerificaConsolidaciones()
  // ----------------------------------------------------
C_BOOLEAN:C305($b_esConsolidante)
C_LONGINT:C283($iAsignaturas;$iParciales;$iPeriodo;$l_IdAsignaturaMadre;$l_OtrasMadres)
C_TEXT:C284($t_nombreAsignaturaMadre)
ARRAY LONGINT:C221($al_recNumAsignaturas;0)


ARRAY TEXT:C222($at_asignaturasMadres;0)
ARRAY TEXT:C222($at_asignaturasHijas;0)
ARRAY TEXT:C222($at_periodo;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)
ARRAY TEXT:C222($at_errores;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_Colores;0)


  // CODIGO PRINCIPAL
PERIODOS_Init 
ALL RECORDS:C47([Asignaturas:18])
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsignaturas;"")
READ WRITE:C146([Asignaturas:18])
MESSAGES ON:C181


<>vb_ImportHistoricos_STX:=True:C214
0xDev_AvoidTriggerExecution (True:C214)
APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Consolidacion_Madre_Id:7:=0)
APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Consolidacion_Madre_nombre:8:="")
0xDev_AvoidTriggerExecution (False:C215)
<>vb_ImportHistoricos_STX:=False:C215

MESSAGES OFF:C175
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando asignaturas..."))
For ($iAsignaturas;1;Size of array:C274($al_recNumAsignaturas))
	GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$iAsignaturas})
	
	  //elimino todas las referencias de consolidación
	  //AScsd_EliminaReferencias ([Asignaturas]Numero)
	
	$l_IdAsignaturaMadre:=[Asignaturas:18]Numero:1
	$t_nombreAsignaturaMadre:=[Asignaturas:18]denominacion_interna:16
	$t_nombreCurso:=[Asignaturas:18]Curso:5
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
		$b_esConsolidante:=False:C215
		$b_conSubasignaturas:=False:C215
		For ($iPeriodo;1;Size of array:C274(atSTR_Periodos_Nombre))
			READ WRITE:C146([Asignaturas:18])
			GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$iAsignaturas})
			AS_PropEval_Lectura ("P"+String:C10($iPeriodo))
			For ($iParciales;1;12)
				
				  // elimino las referencias de consolidación para el año completo (periodo="")
				QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;alAS_EvalPropSourceID{$iParciales};*)
				QUERY:C277([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;=$l_IdAsignaturaMadre;*)
				QUERY:C277([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]Periodo:3="")
				If (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
					KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])
				End if 
				
				Case of 
					: (alAS_EvalPropSourceID{$iParciales}>0)
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=alAS_EvalPropSourceID{$iParciales})
						[Asignaturas:18]Consolidacion_Madre_Id:7:=-1
						[Asignaturas:18]Consolidacion_Madre_nombre:8:="Varía según período"
						SAVE RECORD:C53([Asignaturas:18])
						
						  // Para cada período, busco la referencia de consolidación en la madre correspondiente a la asignatura hija
						QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;alAS_EvalPropSourceID{$iParciales};*)
						QUERY:C277([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;=$l_IdAsignaturaMadre;*)
						QUERY:C277([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]Periodo:3=String:C10(aiSTR_Periodos_Numero{$iperiodo}))
						
						  // si la referencia a la madre no existe para la asignatura la hija la creo en la tabla [Asignaturas_Consolidantes]
						If (Records in selection:C76([Asignaturas_Consolidantes:231])=0)
							  // creo la nueva referencia de consolidación
							CREATE RECORD:C68([Asignaturas_Consolidantes:231])
							[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=alAS_EvalPropSourceID{$iParciales}
							[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1:=$l_IdAsignaturaMadre
							[Asignaturas_Consolidantes:231]Name:2:=$t_nombreAsignaturaMadre
							[Asignaturas_Consolidantes:231]Periodo:3:=String:C10(aiSTR_Periodos_Numero{$iperiodo})
							SAVE RECORD:C53([Asignaturas_Consolidantes:231])
							KRL_ReloadAsReadOnly (->[Asignaturas_Consolidantes:231])
							$t_NombreAsignaturaHija:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_ParentRecord:5;->[Asignaturas:18]denominacion_interna:16)
							$t_CursoAsignaturaHija:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_ParentRecord:5;->[Asignaturas:18]Curso:5)
							GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$iAsignaturas})
							APPEND TO ARRAY:C911($at_asignaturasMadres;$t_nombreAsignaturaMadre+", "+$t_nombreCurso)
							APPEND TO ARRAY:C911($at_asignaturasHijas;$t_NombreAsignaturaHija+","+$t_CursoAsignaturaHija)
							APPEND TO ARRAY:C911($at_periodo;String:C10(aiSTR_Periodos_Numero{$iperiodo}))
							APPEND TO ARRAY:C911($at_errores;"La asignatura hija estaba definida en las propiedades de evaluación de la madre pero no existía la referencia hacia la madre en la hija.")
							APPEND TO ARRAY:C911($al_estilos;0)
							APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
							
						Else 
							  // si el nombre de la asignatura madre en la tabla [Asignaturas_Consolidantes] difiere del nombre actual de la madre lo actualizo
							If ([Asignaturas_Consolidantes:231]Name:2#$t_nombreAsignaturaMadre)
								KRL_ReloadInReadWriteMode (->[Asignaturas_Consolidantes:231])
								[Asignaturas_Consolidantes:231]Name:2:=$t_nombreAsignaturaMadre
								SAVE RECORD:C53([Asignaturas_Consolidantes:231])
								KRL_ReloadAsReadOnly (->[Asignaturas_Consolidantes:231])
							End if 
						End if 
						$b_esConsolidante:=True:C214
						
						
					: (alAS_EvalPropSourceID{$iParciales}<0)
						$b_esConsolidante:=True:C214
						$b_conSubasignaturas:=True:C214
				End case 
			End for 
		End for 
		GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$iAsignaturas})
		[Asignaturas:18]Consolidacion_EsConsolidante:35:=$b_esConsolidante
		[Asignaturas:18]Consolidacion_EsConsolidante:35:=$b_conSubasignaturas
		SAVE RECORD:C53([Asignaturas:18])
		
	Else 
		
		AS_PropEval_Lectura ("Anual")
		$b_esConsolidante:=False:C215
		$b_conSubasignaturas:=False:C215
		For ($iParciales;1;12)
			
			Case of 
				: (alAS_EvalPropSourceID{$iParciales}>0)
					
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_OtrasMadres)  // determino si hay otras madres
					QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;alAS_EvalPropSourceID{$iParciales};*)
					QUERY:C277([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;#;$l_IdAsignaturaMadre)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=alAS_EvalPropSourceID{$iParciales})
					If ($l_OtrasMadres=0)
						[Asignaturas:18]Consolidacion_Madre_Id:7:=$l_IdAsignaturaMadre
						[Asignaturas:18]Consolidacion_Madre_nombre:8:=$t_nombreAsignaturaMadre
					Else 
						[Asignaturas:18]Consolidacion_Madre_Id:7:=-2  // asigno -2 para indicar que tiene varias madres
						[Asignaturas:18]Consolidacion_Madre_nombre:8:="Consolida en mas de 1 asignatura durante todo el año"
					End if 
					SAVE RECORD:C53([Asignaturas:18])
					
					  // Para cada período, busco la referencia de consolidación en la madre correspondiente a la asignatura hija
					QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;alAS_EvalPropSourceID{$iParciales};*)
					QUERY:C277([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;=$l_IdAsignaturaMadre;*)
					QUERY:C277([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]Periodo:3="")
					
					  // si la referencia a la madre no existe para la asignatura la hija la creo en la tabla [Asignaturas_Consolidantes]
					If (Records in selection:C76([Asignaturas_Consolidantes:231])=0)
						  // creo la nueva referencia de consolidación
						CREATE RECORD:C68([Asignaturas_Consolidantes:231])
						[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=alAS_EvalPropSourceID{$iParciales}
						[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1:=$l_IdAsignaturaMadre
						[Asignaturas_Consolidantes:231]Name:2:=$t_nombreAsignaturaMadre
						[Asignaturas_Consolidantes:231]Periodo:3:=""
						SAVE RECORD:C53([Asignaturas_Consolidantes:231])
						KRL_ReloadAsReadOnly (->[Asignaturas_Consolidantes:231])
						
						$t_NombreAsignaturaHija:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_ParentRecord:5;->[Asignaturas:18]denominacion_interna:16)
						$t_CursoAsignaturaHija:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_ParentRecord:5;->[Asignaturas:18]Curso:5)
						GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$iAsignaturas})
						APPEND TO ARRAY:C911($at_asignaturasMadres;$t_nombreAsignaturaMadre+", "+$t_nombreCurso)
						APPEND TO ARRAY:C911($at_asignaturasHijas;$t_NombreAsignaturaHija+", "+$t_CursoAsignaturaHija)
						APPEND TO ARRAY:C911($at_periodo;"Todos")
						APPEND TO ARRAY:C911($at_errores;"La asignatura hija estaba definida en las propiedades de evaluación de la madre pero no existía la referencia hacia la madre en la hija.")
						APPEND TO ARRAY:C911($al_estilos;0)
						APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
						
						
					Else 
						  // si el nombre de la asignatura madre en la tabla [Asignaturas_Consolidantes] difiere del nombre actual de la madre lo actualizo
						If ([Asignaturas_Consolidantes:231]Name:2#$t_nombreAsignaturaMadre)
							KRL_ReloadInReadWriteMode (->[Asignaturas_Consolidantes:231])
							[Asignaturas_Consolidantes:231]Name:2:=$t_nombreAsignaturaMadre
							SAVE RECORD:C53([Asignaturas_Consolidantes:231])
							KRL_ReloadAsReadOnly (->[Asignaturas_Consolidantes:231])
						End if 
					End if 
					$b_esConsolidante:=True:C214
					
				: (alAS_EvalPropSourceID{$iParciales}<0)
					$b_esConsolidante:=True:C214
					$b_conSubasignaturas:=True:C214
			End case 
			
		End for 
		
		GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$iAsignaturas})
		[Asignaturas:18]Consolidacion_EsConsolidante:35:=$b_esConsolidante
		[Asignaturas:18]Consolidacion_ConSubasignaturas:31:=$b_conSubasignaturas
		SAVE RECORD:C53([Asignaturas:18])
	End if 
	
	If (Dec:C9($iAsignaturas/20)=0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iAsignaturas/Size of array:C274($al_recNumAsignaturas);__ ("Verificando asignaturas..."))
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)


KRL_UnloadReadOnly (->[Asignaturas:18])

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando asignaturas consolidantes..."))
CREATE EMPTY SET:C140([Asignaturas_Consolidantes:231];"$ReferenciasObsoletas")
ALL RECORDS:C47([Asignaturas_Consolidantes:231])
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Consolidantes:231];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Asignaturas_Consolidantes:231];$aRecNums{$i})
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Verificando asignaturas consolidantes..."))
	$b_continuar:=True:C214
	If (([Asignaturas_Consolidantes:231]Periodo:3#"") & ([Asignaturas_Consolidantes:231]Periodo:3#"0"))
		  //$t_NombreRegistroPropiedades:="Blob_ConfigNotas/"+String([Asignaturas_Consolidantes]ID_AsignaturaMadre)+"/P"+[Asignaturas_Consolidantes]Periodo
		$t_NombreRegistroPropiedades:="P"+[Asignaturas_Consolidantes:231]Periodo:3
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1)
		  //20131129 RCH Cuando la asignatura no existia, aparecia un error en AS_PropEval_Lectura. Se agrega if.
		  //AS_PropEval_Lectura ($t_NombreRegistroPropiedades;Num([Asignaturas_Consolidantes]Periodo))
		If (Records in selection:C76([Asignaturas:18])>0)
			  //AS_PropEval_Lectura ($t_NombreRegistroPropiedades;Num([Asignaturas_Consolidantes]Periodo))
			AS_PropEval_Lectura ($t_NombreRegistroPropiedades)
		Else 
			ADD TO SET:C119([Asignaturas_Consolidantes:231];"$ReferenciasObsoletas")
			$b_continuar:=False:C215
		End if 
	Else 
		  //$t_NombreRegistroPropiedades:="Blob_ConfigNotas/"+String([Asignaturas_Consolidantes]ID_AsignaturaMadre)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1)
		  //20131129 RCH Cuando la asignatura no existia, aparecia un error en AS_PropEval_Lectura. Se agrega if.
		  //AS_PropEval_Lectura ($t_NombreRegistroPropiedades;0)
		If (Records in selection:C76([Asignaturas:18])>0)
			AS_PropEval_Lectura ("Anual")
		Else 
			ADD TO SET:C119([Asignaturas_Consolidantes:231];"$ReferenciasObsoletas")
			$b_continuar:=False:C215
		End if 
	End if 
	
	If ($b_continuar)
		$l_EsReferenciaValida:=Find in array:C230(alAS_EvalPropSourceID;[Asignaturas_Consolidantes:231]ID_ParentRecord:5)
		If ($l_EsReferenciaValida<0)
			
			$t_nombreAsignaturaMadre:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;->[Asignaturas:18]denominacion_interna:16)
			$t_nombreCurso:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;->[Asignaturas:18]Curso:5)
			$t_NombreAsignaturaHija:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_ParentRecord:5;->[Asignaturas:18]denominacion_interna:16)
			$t_CursoAsignaturaHija:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_ParentRecord:5;->[Asignaturas:18]Curso:5)
			GOTO RECORD:C242([Asignaturas_Consolidantes:231];$aRecNums{$i})
			APPEND TO ARRAY:C911($at_asignaturasMadres;$t_nombreAsignaturaMadre+", "+$t_nombreCurso)
			APPEND TO ARRAY:C911($at_asignaturasHijas;$t_NombreAsignaturaHija+", "+$t_CursoAsignaturaHija)
			APPEND TO ARRAY:C911($at_periodo;"Todos")
			APPEND TO ARRAY:C911($at_errores;"Había una referencia hacia una asignatura madre que no estaba definida en la asignatura madre.")
			APPEND TO ARRAY:C911($al_estilos;0)
			APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
			
			ADD TO SET:C119([Asignaturas_Consolidantes:231];"$ReferenciasObsoletas")
		End if 
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

USE SET:C118("$ReferenciasObsoletas")
KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])

If (Size of array:C274($at_errores)>0)
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Asignatura madre")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Asignatura hija")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Período")
	$t_Encabezado:="Verificación de las propiedades de consolidación de calificaciones"
	$t_descripcion:="Se detectaron inconsistencias durante la verificación de propiedades de consolidación de calificaciones. En la lista más abajo se puede ver el detalle de los problemas corregidos."
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_asignaturasMadres;->$at_asignaturasHijas;->$at_periodo)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	$t_mensajeFalla:="Se detectaron inconsistencias en las propiedades de consolidación de calificaciones.\r\rEl detalle será mostrado en el centro de notificaciones."
	$t_mensajeExito:="No se detectó ninguna inconsistencia en las propiedades de consolidación de calificaciones."
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684;$t_mensajeFalla;$t_mensajeExito)
	$0:=-1
	
End if 


QUERY:C277([Asignaturas:18];[Asignaturas:18]Consolidacion_EsConsolidante:35=True:C214)
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	AS_FijaNivelJeraquicoHijas ($aRecNums{$i})
End for 
KRL_UnloadReadOnly (->[Asignaturas:18])

