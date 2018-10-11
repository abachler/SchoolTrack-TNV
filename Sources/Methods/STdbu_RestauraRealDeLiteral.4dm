//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 25-04-18, 10:17:20
  // ----------------------------------------------------
  // Método: STdbu_RestauraRealDeLiteral
  // Descripción
  // Método para tomar el valor literal y actualizar el real
  // $1 -> puntero de Array con id de asignaturas
  // $2 -> id de estilo de evaluacion para asignar a la asignatura
  // $3 -> siempre en true
  // Parámetros
  // ----------------------------------------------------


C_BLOB:C604($x_RecNumsArray)
C_BOOLEAN:C305($b_CancelTransaccion;$b_LiteralAReal)
C_LONGINT:C283($l_idAsignatura;$l_idEstiloEvaluacion;$l_indice;$l_indiceAsig;$l_parcial;$l_periodo;$l_progress)
C_POINTER:C301($y_ArrayIdAsignaturas;$y_literal;$y_nota;$y_puntos;$y_real;$y_simbolos)
C_TEXT:C284($t_mensaje;$t_mensaje1;$t_mensaje2)

ARRAY LONGINT:C221($al_recnumCalificaciones;0)
ARRAY LONGINT:C221($al_recNumAsignaturas;0)
READ WRITE:C146([Asignaturas:18])
READ WRITE:C146([Alumnos_Calificaciones:208])

$y_ArrayIdAsignaturas:=$1
$l_idEstiloEvaluacion:=$2
$b_LiteralAReal:=$3

$b_CancelTransaccion:=False:C215

EVS_ReadStyleData ($l_idEstiloEvaluacion)

START TRANSACTION:C239

$l_progress:=IT_Progress (1;0;0;$t_mensaje)

For ($l_indiceAsig;1;Size of array:C274($y_ArrayIdAsignaturas->))
	$l_idAsignatura:=$y_ArrayIdAsignaturas->{$l_indiceAsig}
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_idAsignatura)
	APPEND TO ARRAY:C911($al_recNumAsignaturas;Record number:C243([Asignaturas:18]))
	[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=$l_idEstiloEvaluacion
	$b_CancelTransaccion:=Locked:C147([Asignaturas:18])
	SAVE RECORD:C53([Asignaturas:18])
	
	$t_mensaje:=__ ("Verificando calificaciones para la asignatura: ")+[Asignaturas:18]Asignatura:3
	$l_progress:=IT_Progress (0;$l_progress;$l_indiceAsig/Size of array:C274($y_ArrayIdAsignaturas->);$t_mensaje)
	
	If (Not:C34($b_CancelTransaccion))
		
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_idAsignatura)
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6;>)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$al_recnumCalificaciones)
		
		For ($l_indice;1;Size of array:C274($al_recnumCalificaciones))
			GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_recnumCalificaciones{$l_indice})
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Calificaciones:208]ID_Alumno:6)
			PERIODOS_LoadData ([Alumnos_Calificaciones:208]NIvel_Numero:4)
			$t_mensaje1:=__ ("Alumno:")+[Alumnos:2]apellidos_y_nombres:40
			$l_progress:=IT_Progress (0;$l_progress;$l_indiceAsig/Size of array:C274($y_ArrayIdAsignaturas->);$t_mensaje;$l_indice/Size of array:C274($al_recnumCalificaciones);$t_mensaje1)
			
			
			For ($l_periodo;1;Size of array:C274(adSTR_Periodos_Desde))
				$t_mensaje2:=__ ("Verificando período ")+String:C10(atSTR_Periodos_Nombre{$l_periodo})
				$l_progress:=IT_Progress (0;$l_progress;$l_indiceAsig/Size of array:C274($y_ArrayIdAsignaturas->);$t_mensaje;$l_indice/Size of array:C274($al_recnumCalificaciones);$t_mensaje1;$l_periodo/Size of array:C274(adSTR_Periodos_Desde);$t_mensaje2)
				
				For ($l_parcial;1;12)
					$y_nota:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Eval"+String:C10($l_parcial;"00")+"_Nota")
					$y_literal:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Eval"+String:C10($l_parcial;"00")+"_Literal")
					$y_real:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Eval"+String:C10($l_parcial;"00")+"_Real")
					$y_puntos:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Eval"+String:C10($l_parcial;"00")+"_Puntos")
					$y_simbolos:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Eval"+String:C10($l_parcial;"00")+"_Simbolo")
					
					If ($b_LiteralAReal)
						
						Case of 
							: (iEvaluationMode=Simbolos)
								$y_real->:=EV2_Simbolo_a_Real ($y_simbolos->)
								$y_puntos->:=EV2_Real_a_Puntos ($y_real->)
								$y_literal->:=EV2_Real_a_Simbolo ($y_real->)
								$y_nota->:=EV2_Real_a_Nota ($y_real->;iEvaluationMode;iGradesDec)
								
							: (iEvaluationMode=Notas)
								$y_real->:=EV2_Nota_a_Real ($y_nota->)
								$y_puntos->:=EV2_Real_a_Puntos ($y_real->)
								$y_simbolos->:=EV2_Real_a_Simbolo ($y_real->)
								$y_literal->:=EV2_Real_a_Literal ($y_real->;iEvaluationMode;iGradesDec)
								$y_nota->:=EV2_Real_a_Nota ($y_real->;iEvaluationMode;iGradesDec)
								
							: (iEvaluationMode=Puntos)
								$y_real->:=EV2_Puntos_a_Real ($y_puntos->)
								$y_simbolos->:=EV2_Real_a_Simbolo ($y_real->)
								$y_literal->:=EV2_Real_a_Literal ($y_real->;iEvaluationMode)
								$y_nota->:=EV2_Real_a_Nota ($y_real->;iEvaluationMode;iGradesDec)
								
						End case 
						
					Else 
						$y_real->:=EV2_Nota_a_Real ($y_nota->)
						$y_puntos->:=EV2_Real_a_Puntos ($y_real->)
						$y_simbolos->:=EV2_Real_a_Simbolo ($y_real->)
						$y_literal->:=EV2_Real_a_Literal ($y_real->;iEvaluationMode;iGradesDec)
					End if 
					
					SAVE RECORD:C53([Alumnos_Calificaciones:208])
					$b_CancelTransaccion:=Locked:C147([Alumnos_Calificaciones:208])
					If ($b_CancelTransaccion)
						$l_parcial:=13
						$l_periodo:=Size of array:C274(adSTR_Periodos_Desde)+1
						$l_indice:=Size of array:C274($al_recnumCalificaciones)+1
						$l_indiceAsig:=Size of array:C274($y_ArrayIdAsignaturas->)+1
					End if 
				End for 
			End for 
		End for 
		
	Else 
		$l_indiceAsig:=Size of array:C274($y_ArrayIdAsignaturas->)+1
	End if 
	
End for 
$l_progress:=IT_Progress (-1;$l_progress)

KRL_ReloadAsReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])

If (Not:C34($b_CancelTransaccion))
	VALIDATE TRANSACTION:C240
	If (Size of array:C274($al_recNumAsignaturas)>0)
		BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_recNumAsignaturas)
		EV2dbu_Recalculos ($x_RecNumsArray)
	End if 
Else 
	CANCEL TRANSACTION:C241
	CD_Dlog (0;__ ("Uno o más registros no pudieron ser modificados.")+__ (" No se ha realizado cambios en las asignaturas")+"\r"+__ ("Inténtelo nuevamente."))
End if 



