//%attributes = {}
  // EV2_ConsolidaTodasLasParciales()
  //
  //
  // creado por: Alberto Bachler Klein: 20-05-16, 18:08:06
  // -----------------------------------------------------------
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_finalPendiente)
C_LONGINT:C283($i_columnas;$i_parcial;$l_evaluaciones;$l_idAlumno;$l_idAsignatura;$l_ItemEncontrado;$l_periodo;$l_recNumCalificaciones;$l_recNumSubasignatura;$recNum)
C_POINTER:C301($y_campo;$y_campoLiteral;$y_campoNota;$y_campoPuntos;$y_campoReal;$y_campoSimbolo;$y_evaluacionParcial)
C_REAL:C285($r_evaluacion;$r_promedio;$r_suma)
C_TEXT:C284($t_llaveCalificaciones;$t_llaveCalificacionesHija)


If (False:C215)
	C_LONGINT:C283(EV2_ConsolidaTodasLasParciales ;$1)
End if 

$l_periodo:=$1




$l_recNumCalificaciones:=Record number:C243([Alumnos_Calificaciones:208])
$t_llaveCalificaciones:=[Alumnos_Calificaciones:208]Llave_principal:1
$l_idAlumno:=[Alumnos_Calificaciones:208]ID_Alumno:6
$l_idAsignatura:=[Alumnos_Calificaciones:208]ID_Asignatura:5
$r_suma:=0
$l_evaluaciones:=0
ARRAY REAL:C219($ar_Parciales;12)
For ($i_parcial;1;12)
	$ar_Parciales{$i_parcial}:=-10
End for 

KRL_ReloadInReadWriteMode (->[Alumnos_Calificaciones:208])

AS_PropEval_Lectura ("";$l_Periodo)
For ($i_parcial;1;12)
	  //If ($r_suma#-2)  //si $r_suma toma el valor 0 durante una iteración significa que hay una evaluación pendiente: el calculo de promedio no se realiza
	Case of 
		: (alAS_EvalPropSourceID{$i_parcial}=0)  // es evaluacion directa
			$y_campo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Real")
			
			  // obtengo la evaluación directa y asigno las variables para el calculo de promedios
			$r_evaluacion:=KRL_GetNumericFieldData (->[Alumnos_Calificaciones:208]Llave_principal:1;->$t_llaveCalificaciones;$y_campo)
			Case of 
				: ($r_evaluacion=-3)  // eximición
				: ($r_evaluacion=-2)  // pendiente
					$r_suma:=-2
				: ($r_evaluacion>=vrNTA_MinimoEscalaReferencia)  // evaluacion valida
					$r_suma:=$r_suma+$r_evaluacion
					$l_evaluaciones:=$l_evaluaciones+1
			End case 
			  //
			$ar_Parciales{$i_parcial}:=$r_evaluacion  //guardo la nota parcial directa en el arreglo de parciales para asignarlas a las parciales de la asignatura madre (en este caso es la misma)
			
			
			
		: (alAS_EvalPropSourceID{$i_parcial}<0)  // es subasignatura
			$l_recNumSubasignatura:=ASsev_LeeDatosSubasignatura ([Alumnos_Calificaciones:208]ID_Asignatura:5;$l_Periodo;$i_parcial;False:C215)
			If ($l_recNumSubasignatura>=0)
				$l_ItemEncontrado:=Find in array:C230(aSubEvalID;$l_IdAlumno)
			End if 
			If ($l_ItemEncontrado>0)
				
				  // obtengo las evaluaciones parciales y asigno las variables para el calculo de promedios
				For ($i_columnas;1;12)
					$y_evaluacionParcial:=Get pointer:C304("aRealSubEval"+String:C10($i_columnas))
					$r_evaluacion:=$y_evaluacionParcial->{$l_ItemEncontrado}
					Case of 
						: ($r_evaluacion=-3)  // eximición
						: ($r_evaluacion=-2)  // pendiente
							  //  //corto el ciclo debido a que si tiene la nota pendiente debe mostrar p
							  //  //JVP ticket 166870 20160825
							$r_suma:=-2
							$i_columnas:=12
						: ($r_evaluacion>=vrNTA_MinimoEscalaReferencia)  // evaluacion valida
							$r_suma:=$r_suma+$r_evaluacion
							$l_evaluaciones:=$l_evaluaciones+1
					End case 
				End for 
				  //
				$ar_Parciales{$i_parcial}:=aRealSubEvalP1{$l_ItemEncontrado}  // guardo el promedio de la subasignatura en el arreglo de parciales
			End if 
			
			
			
		: (alAS_EvalPropSourceID{$i_parcial}>0)  // es asignatura hija
			$t_llaveCalificacionesHija:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)+"."+String:C10(alAS_EvalPropSourceID{$i_parcial})+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
			
			  // obtengo las evaluaciones parciales y asigno las variables para el calculo de promedios
			For ($i_columnas;1;12)
				$y_campo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_columnas;"00")+"_Real")
				$r_evaluacion:=KRL_GetNumericFieldData (->[Alumnos_Calificaciones:208]Llave_principal:1;->$t_llaveCalificacionesHija;$y_campo)
				Case of 
					: ($r_evaluacion=-3)  // eximición
					: ($r_evaluacion=-2)  // pendiente
						$r_suma:=-2
						$i_columnas:=12
						$b_finalPendiente:=True:C214
					: ($r_evaluacion>=vrNTA_MinimoEscalaReferencia)  // evaluacion valida
						$r_suma:=$r_suma+$r_evaluacion
						$l_evaluaciones:=$l_evaluaciones+1
				End case 
			End for 
			
			$y_campo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Final"+"_Real")
			$recNum:=Find in field:C653([Alumnos_Calificaciones:208]Llave_principal:1;$t_llaveCalificacionesHija)
			If ($recNum>=0)
				$ar_Parciales{$i_parcial}:=KRL_GetNumericFieldData (->[Alumnos_Calificaciones:208]Llave_principal:1;->$t_llaveCalificacionesHija;$y_campo)
			Else 
				$ar_Parciales{$i_parcial}:=-10
			End if 
			
			
	End case 
	  //End if
End for 


  // calculo el promedio y lo asigno en la asignatura madre
Case of 
	: ($b_finalPendiente)
		$r_promedio:=-2
	: (($r_suma>=0) & ($l_evaluaciones>0))
		$r_promedio:=Round:C94($r_suma/$l_evaluaciones;11)
	: ($r_suma<0)
		$r_promedio:=$r_suma
	Else 
		$r_promedio:=-10
End case 
$y_campoReal:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Presentacion"+"_Real")
If ($y_campoReal->#$r_promedio)
	$y_campoReal->:=$r_promedio
	$y_campoReal:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Presentacion"+"_Real")
	$y_campoNota:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Presentacion"+"_Nota")
	$y_campoPuntos:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Presentacion"+"_Puntos")
	$y_campoSimbolo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Presentacion"+"_Simbolo")
	$y_campoLiteral:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Presentacion"+"_Literal")
	$y_campoNota->:=Choose:C955($r_promedio>=vrNTA_MinimoEscalaReferencia;EV2_Real_a_Nota ($r_promedio;0;iGradesDec);$r_promedio)
	$y_campoPuntos->:=Choose:C955($r_promedio>=vrNTA_MinimoEscalaReferencia;EV2_Real_a_Puntos ($r_promedio;0;iPointsDec);$r_promedio)
	$y_campoSimbolo->:=EV2_Real_a_Simbolo ($r_promedio)
	$y_campoLiteral->:=EV2_Real_a_Literal ($r_promedio;iPrintMode;vlNTA_DecimalesParciales)
End if 
  //

  // asigno las parciales provenientes de evaluación directa, subasignaturas o asignaturas hijas a las columnas de la asignatura madre
For ($i_parcial;1;12)
	$y_campoReal:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Real")
	If ($y_campoReal->#$ar_Parciales{$i_parcial})
		$y_campoReal->:=$ar_Parciales{$i_parcial}
		$y_campoNota:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Nota")
		$y_campoPuntos:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Puntos")
		$y_campoSimbolo:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Simbolo")
		$y_campoLiteral:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Eval"+String:C10($i_parcial;"00")+"_Literal")
		$y_campoNota->:=Choose:C955($ar_Parciales{$i_parcial}>=vrNTA_MinimoEscalaReferencia;EV2_Real_a_Nota ($ar_Parciales{$i_parcial};0;iGradesDec);$ar_Parciales{$i_parcial})
		$y_campoPuntos->:=Choose:C955($ar_Parciales{$i_parcial}>=vrNTA_MinimoEscalaReferencia;EV2_Real_a_Puntos ($ar_Parciales{$i_parcial};0;iPointsDec);$ar_Parciales{$i_parcial})
		$y_campoSimbolo->:=EV2_Real_a_Simbolo ($ar_Parciales{$i_parcial})
		$y_campoLiteral->:=EV2_Real_a_Literal ($ar_Parciales{$i_parcial};iPrintMode;vlNTA_DecimalesParciales)
	End if 
End for 
  //
If ($l_recNumCalificaciones=Record number:C243([Alumnos_Calificaciones:208]))  // solo para asegurarme
	SAVE RECORD:C53([Alumnos_Calificaciones:208])
End if 



