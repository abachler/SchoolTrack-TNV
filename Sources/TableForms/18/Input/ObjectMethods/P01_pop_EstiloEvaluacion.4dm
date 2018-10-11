  //[Asignaturas].Input.Variable8

C_BLOB:C604($x_RecNumsArray)
C_LONGINT:C283($l_ItemEncontrado;$l_modoConversionEstiloActual;$l_modoConversionNuevoEstilo;$l_modoEvaluacionEstiloActual;$l_modoEvaluacionNuevoEstilo;$l_nuevoModoEvaluacion;$l_numeroEstiloActual;$l_numeroNuevoEstilo;$l_recNumAsignatura)
C_REAL:C285($r_maximoEscalaActual;$r_maximoNuevaEscala;$r_minimoEscalaActual;$r_minimoNuevaEscala;$r_requeridoEscalaActual;$r_requeridoNuevaEscala;$r_requeridoNuevaEscala_pct)
C_TEXT:C284($t_mensajeEstiloActual;$t_mensajeNuevoEstilo)

ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)
C_REAL:C285($r_requeridoEscalaActual_pct)

C_BOOLEAN:C305(<>vb_ComparacionActiva)

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
	$l_ItemEncontrado:=Find in array:C230(aEvStyleId;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	If ($l_ItemEncontrado>0)
		aEvStyleName:=$l_ItemEncontrado
	End if 
Else 
	
	If (Self:C308->>0)
		AL_UpdateArrays (xALP_StdList;0)
		AL_UpdateArrays (xALP_ASNotas;0)
		AL_UpdateArrays (xALP_Planes;0)
		AL_UpdateArrays (xALP_AsistenciaSesiones;0)
		
		vl_NewEvStyle:=aEvStyleID{Find in array:C230(aEvStyleName;aEvStyleName{aEvStyleName})}
		$l_numeroEstiloActual:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
		$l_numeroNuevoEstilo:=vl_NewEvStyle
		
		EVS_ReadStyleData ($l_numeroNuevoEstilo)
		$l_nuevoModoEvaluacion:=iEvaluationMode
		EVS_ReadStyleData ($l_numeroEstiloActual)
		Case of 
			: ($l_nuevoModoEvaluacion=Notas)
				$r_minimoEscalaActual:=rGradesFrom
				$r_maximoEscalaActual:=rGradesTo
				$r_requeridoEscalaActual:=rGradesMinimum
			: ($l_nuevoModoEvaluacion=Puntos)
				$r_minimoEscalaActual:=rPointsFrom
				$r_maximoEscalaActual:=rPointsTo
				$r_requeridoEscalaActual:=rPointsMinimum
			Else 
				$r_minimoEscalaActual:=1
				$r_maximoEscalaActual:=100
				$r_requeridoEscalaActual:=rpctMinimum
		End case 
		$r_requeridoEscalaActual_pct:=Round:C94(rpctMinimum;11)
		$l_modoConversionEstiloActual:=iConversionTable
		$l_modoEvaluacionEstiloActual:=iEvaluationMode
		
		EVS_ReadStyleData ($l_numeroNuevoEstilo)
		Case of 
			: ($l_nuevoModoEvaluacion=Notas)
				$r_minimoNuevaEscala:=rGradesFrom
				$r_maximoNuevaEscala:=rGradesTo
				$r_requeridoNuevaEscala:=rGradesMinimum
			: ($l_nuevoModoEvaluacion=Puntos)
				$r_minimoNuevaEscala:=rPointsFrom
				$r_maximoNuevaEscala:=rPointsTo
				$r_requeridoNuevaEscala:=rPointsMinimum
			Else 
				$r_minimoNuevaEscala:=1
				$r_maximoNuevaEscala:=100
				$r_requeridoNuevaEscala:=rpctMinimum
		End case 
		$r_requeridoNuevaEscala_pct:=Round:C94(rpctMinimum;11)
		$l_modoConversionNuevoEstilo:=iConversionTable
		$l_modoEvaluacionNuevoEstilo:=iEvaluationMode
		
		OK:=1
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
		SET QUERY LIMIT:C395(1)
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY LIMIT:C395(0)
		Case of 
			: ($l_records=0)
				OK:=1
				vb_ConvierteNotas:=False:C215
				
			: (($r_requeridoEscalaActual_pct#$r_requeridoNuevaEscala_pct) & ($l_modoConversionNuevoEstilo=$l_modoConversionEstiloActual))
				$l_respuestaUsuario:=CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("La posición relativa de la evaluación requerida es diferente:\r- actualmente: (^0) \r- nuevo estilo (^1)\rLas evaluaciones  pueden ser convertidas o conservadas.\rSi convierte las evaluaciones  diferirán de las actualmente registradas.");__ ("^0");String:C10($r_requeridoEscalaActual)+__ ("=")+String:C10(Round:C94($r_requeridoEscalaActual_pct;11))+__ ("%"));__ ("^1");String:C10($r_requeridoNuevaEscala)+__ ("=")+String:C10(Round:C94($r_requeridoNuevaEscala_pct;11))+__ ("%"));__ ("");__ ("Conservar");__ ("Convertir");__ ("Cancelar"))
				Case of 
					: ($l_respuestaUsuario=1)
						OK:=1
						vb_ConvierteNotas:=False:C215
					: ($l_respuestaUsuario=2)
						OK:=1
						vb_ConvierteNotas:=True:C214
					Else 
						OK:=0
				End case 
				
			: ($l_modoConversionNuevoEstilo#$l_modoConversionEstiloActual)
				$t_mensajeEstiloActual:=(__ ("tablas de conversión")*$l_modoConversionEstiloActual)+(__ ("conversión matemática")*Num:C11($l_modoConversionEstiloActual=0))
				$t_mensajeNuevoEstilo:=(__ ("tablas de conversión")*$l_modoConversionNuevoEstilo)+(__ ("conversión matemática")*Num:C11($l_modoConversionNuevoEstilo=0))
				$l_respuestaUsuario:=CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("El método de conversión entre escalas es diferente: estilo de \r- actualmente: (^0)\r- nuevo estilo (^1)\rLas evaluaciones  pueden ser convertidas o conservadas.\rSi convierte las evaluaciones  diferirán de las actualmente registradas.");__ ("^0");$t_mensajeEstiloActual);__ ("^1");$t_mensajeNuevoEstilo);__ ("");__ ("Conservar");__ ("Convertir");__ ("Cancelar"))
				Case of 
					: ($l_respuestaUsuario=1)
						OK:=1
						vb_ConvierteNotas:=False:C215
					: ($l_respuestaUsuario=2)
						OK:=1
						vb_ConvierteNotas:=True:C214
					Else 
						OK:=0
				End case 
				
			: (($r_minimoEscalaActual#$r_minimoNuevaEscala) | ($r_maximoEscalaActual#$r_maximoNuevaEscala))
				$l_respuestaUsuario:=CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("Las escalas de evaluación son diferentes: \r- actualmente: (^0)\r- nuevo estilo:  (^1)\r\r¿Continuar?");__ ("^0");String:C10($r_minimoEscalaActual)+__ (" a ")+String:C10($r_maximoEscalaActual));__ ("^1");String:C10($r_minimoNuevaEscala)+__ (" a ")+String:C10($r_maximoNuevaEscala))+__ ("\r\r")+__ ("¿Desea continuar la conversión a pesar de todo?");__ ("");__ ("No");__ ("Si"))
				If ($l_respuestaUsuario=2)
					OK:=1
					vb_ConvierteNotas:=True:C214  //MONO: en este caso estabamos con la variable indefinida.
				Else 
					OK:=0
					vb_ConvierteNotas:=False:C215  //MONO: en este caso estabamos con la variable indefinida.
				End if 
			Else 
				OK:=1
				vb_ConvierteNotas:=False:C215
		End case 
		
		
		
		
		
		If (ok=1)
			If (Size of array:C274(aNtaStdNme)>0)
				$l_recNumAsignatura:=Record number:C243([Asignaturas:18])
				EV2_CambiaEstiloEvaluacion ($l_numeroEstiloActual;$l_numeroNuevoEstilo)
				APPEND TO ARRAY:C911($al_RecNumsAsignaturas;Record number:C243([Asignaturas:18]))
				BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumsAsignaturas)
				$b_ReadWriteMode:=Not:C34(Read only state:C362([Asignaturas:18]))  //ASM 20160404 Ticket 158275
				EV2dbu_Recalculos ($x_RecNumsArray)
				KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;$b_ReadWriteMode)
				
				  //GOTO RECORD([Asignaturas];$l_recNumAsignatura)
				
				
			Else 
				AS_UpdateStyleSettings ($l_numeroNuevoEstilo)
			End if 
			LOG_RegisterEvt ("Cambio de estilo de evaluación en "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10($l_numeroEstiloActual)+" a "+String:C10($l_numeroNuevoEstilo)+"]";Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1)
		End if 
		
		$l_ItemEncontrado:=Find in array:C230(aEvStyleId;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		If ($l_ItemEncontrado>0)
			aEvStyleName:=$l_ItemEncontrado
		Else 
			aEvStyleName:=0
		End if 
		AL_UpdateArrays (xALP_StdList;-2)
		AL_UpdateArrays (xALP_ASNotas;-2)
		AL_UpdateArrays (xALP_Planes;-2)
		Case of 
			: (<>gOrdenNta=0)
				AL_SetSort (xALP_StdList;3;2)
			: (<>gOrdenNta=1)
				AL_SetSort (xALP_StdList;1)
			: (<>gOrdenNta=2)
				AL_SetSort (xALP_StdList;2)
		End case 
	End if 
End if 

