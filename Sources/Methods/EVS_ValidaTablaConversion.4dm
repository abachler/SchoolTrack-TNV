//%attributes = {}
  // EVS_ValidaTablaConversion()
  //
  //
  // creado por: Alberto Bachler Klein: 14-07-16, 11:55:00
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_tablaModificada)
C_LONGINT:C283($i_intervalos;$l_decimales;$l_modo;$l_posicion)
C_POINTER:C301($y_bonificaciones;$y_intervalosNota;$y_intervalosNotaPct;$y_intervalosPuntos;$y_intervalosPuntosPct)
C_REAL:C285($r_intervalo;$r_maximoEscala;$r_minimoEscala;$r_paso)

ARRAY LONGINT:C221($al_decimales;0)

$y_intervalosNota:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota")
$y_intervalosPuntos:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosPuntos")
$y_bonificaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"bonificacion")
$y_intervalosNotaPct:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota%")
$y_intervalosPuntosPct:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosPuntos%")


Case of 
	: ((iEvaluationMode=Notas) & ((iPrintMode=Puntos) | (iPrintActa=Puntos) | (iViewMode=Puntos)))
		$r_minimoEscala:=rGradesFrom
		$r_maximoEscala:=rGradesTo
		  //AT_AppendToPointerArray (->$al_decimales;->iGradesDec;->iGradesDecPP;->iGradesDecPF;->iGradesDecNF;->iGradesDecNO)
		  //$l_decimales:=Max($al_decimales)
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Notas
		
	: ((iEvaluationMode=Puntos) & ((iPrintMode=Notas) | (iPrintActa=Notas) | (iViewMode=Notas)))
		$r_minimoEscala:=rPointsFrom
		$r_maximoEscala:=rPointsTo
		  //AT_AppendToPointerArray (->$al_decimales;->iPointsDec;->iGradesDecPP;->iGradesDecPF;->iGradesDecNF;->iGradesDecNO)
		  //$l_decimales:=Max($al_decimales)
		$l_decimales:=MATH_Max (iPointsDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Puntos
		
	: ((iEvaluationMode=Simbolos) & ((iPrintMode=Simbolos) | (iPrintActa=Simbolos) & (iViewMode=Simbolos)))
		$r_minimoEscala:=rGradesFrom
		$r_maximoEscala:=rGradesTo
		  //AT_AppendToPointerArray (->$al_decimales;->iGradesDec;->iGradesDecPP;->iGradesDecPF;->iGradesDecNF;->iGradesDecNO)
		  //$l_decimales:=Max($al_decimales)
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Notas
		  //AT_Initialize ($y_intervalosNota;$y_intervalosPuntos;$y_bonificaciones;$y_intervalosNotaPct;$y_intervalosPuntosPct)
		
	: ((iEvaluationMode=Porcentaje) & ((iPrintMode=Porcentaje) | (iPrintActa=Porcentaje) & (iViewMode=Porcentaje)))
		$r_minimoEscala:=rGradesFrom
		$r_maximoEscala:=rGradesTo
		  //AT_AppendToPointerArray (->$al_decimales;->iGradesDec;->iGradesDecPP;->iGradesDecPF;->iGradesDecNF;->iGradesDecNO)
		  //$l_decimales:=Max($al_decimales)
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Notas
		  //AT_Initialize ($y_intervalosNota;$y_intervalosPuntos;$y_bonificaciones;$y_intervalosNotaPct;$y_intervalosPuntosPct)
		
	Else 
		$r_minimoEscala:=rGradesFrom
		$r_maximoEscala:=rGradesTo
		  //$l_decimales:=iGradesDec
		  //AT_AppendToPointerArray (->$al_decimales;->iGradesDec;->iGradesDecPP;->iGradesDecPF;->iGradesDecNF;->iGradesDecNO)
		  //$l_decimales:=Max($al_decimales)
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Notas
End case 

  // me aseguro que todos los intervalos posibles estén representados en la tabla correspondiente a la escala de referencia
$r_paso:=1/(10^$l_decimales)
$r_intervalo:=$r_minimoEscala
Repeat 
	Case of 
		: ($l_modo=Notas)
			If (Find in array:C230($y_intervalosNota->;$r_intervalo)<0)
				$l_posicion:=Size of array:C274($y_intervalosNota->)+1
				AT_Insert ($l_posicion;1;$y_intervalosNota;$y_intervalosPuntos;$y_bonificaciones;$y_intervalosNotaPct;$y_intervalosPuntosPct)
				$y_intervalosNota->{$l_posicion}:=$r_intervalo
				$y_intervalosNotaPct->{$l_posicion}:=Round:C94($y_intervalosNota->{$l_posicion}/rGradesTo*100;11)
				$y_intervalosPuntosPct->{$l_posicion}:=$y_intervalosNotaPct->{$l_posicion}
				  //$y_intervalosPuntos->{$l_posicion}:=Round(rPointsTo*$y_intervalosPuntosPct->{$l_posicion}/100;iPointsDec)
				$y_intervalosPuntos->{$l_posicion}:=EV2_Real_a_Puntos ($y_intervalosNotaPct->{$l_posicion})
				$b_tablaModificada:=True:C214
			End if 
		: ($l_modo=Puntos)
			If (Find in array:C230($y_intervalosPuntos->;$r_intervalo)<0)
				$l_posicion:=Size of array:C274($y_intervalosNota->)+1
				AT_Insert ($l_posicion;1;$y_intervalosNota;$y_intervalosPuntos;$y_bonificaciones;$y_intervalosNotaPct;$y_intervalosPuntosPct)
				$y_intervalosPuntos->{$l_posicion}:=$r_intervalo
				$y_intervalosPuntosPct->{$l_posicion}:=Round:C94($y_intervalosPuntos->{$l_posicion}/rPointsTo*100;11)
				$y_intervalosNotaPct->{$l_posicion}:=$y_intervalosPuntosPct->{$l_posicion}
				  //$y_intervalosNota->{$l_posicion}:=Round(rGradesTo*$y_intervalosNotaPct->{$l_posicion}/100;iGradesDec)
				$y_intervalosNota->{$l_posicion}:=EV2_Real_a_Nota ($y_intervalosPuntosPct->{$l_posicion})
				$b_tablaModificada:=True:C214
			End if 
	End case 
	$r_intervalo:=$r_intervalo+$r_Paso
Until ($r_intervalo>$r_maximoEscala)


  // reordeno en el caso que se hayan agregado elementos a la tabla
Case of 
	: ($l_modo=Notas)
		SORT ARRAY:C229($y_intervalosNota->;$y_intervalosPuntos->;$y_bonificaciones->;$y_intervalosNotaPct->;$y_intervalosPuntosPct->)
	: ($l_modo=Puntos)
		SORT ARRAY:C229($y_intervalosPuntos->;$y_intervalosNota->;$y_bonificaciones->;$y_intervalosNotaPct->;$y_intervalosPuntosPct->)
End case 


  // elimino eventuales intervalos inválidos en la escala de referencia y sus correspondencias en la otra escala
For ($i_intervalos;Size of array:C274($y_intervalosNota->)-1;1;-1)
	Case of 
		: ($l_modo=Notas)
			If ((($y_intervalosNota->{$i_intervalos+1}-$y_intervalosNota->{$i_intervalos})<$r_paso) | ($y_intervalosNota->{$i_intervalos}<$r_minimoEscala) | ($y_intervalosNota->{$i_intervalos}>$r_maximoEscala))
				AT_Delete ($i_intervalos;1;$y_intervalosNota;$y_intervalosPuntos;$y_bonificaciones;$y_intervalosNotaPct;$y_intervalosPuntosPct)
				$b_tablaModificada:=True:C214
			End if 
		: ($l_modo=Puntos)
			If ((($y_intervalosPuntos->{$i_intervalos+1}-$y_intervalosPuntos->{$i_intervalos})<$r_paso) | ($y_intervalosPuntos->{$i_intervalos}<$r_minimoEscala) | ($y_intervalosPuntos->{$i_intervalos}>$r_maximoEscala))
				AT_Delete ($i_intervalos;1;$y_intervalosNota;$y_intervalosPuntos;$y_bonificaciones;$y_intervalosNotaPct;$y_intervalosPuntosPct)
				$b_tablaModificada:=True:C214
			End if 
	End case 
End for 
$l_ultimo:=Size of array:C274($y_intervalosNota->)
Case of 
	: ($l_modo=Notas)
		If (($y_intervalosNota->{$l_ultimo}<$r_minimoEscala) | ($y_intervalosNota->{$l_ultimo}>$r_maximoEscala))
			AT_Delete ($l_ultimo;1;$y_intervalosNota;$y_intervalosPuntos;$y_bonificaciones;$y_intervalosNotaPct;$y_intervalosPuntosPct)
			$b_tablaModificada:=True:C214
		End if 
	: ($l_modo=Puntos)
		If (($y_intervalosPuntos->{$l_ultimo}<$r_minimoEscala) | ($y_intervalosPuntos->{$l_ultimo}>$r_maximoEscala))
			AT_Delete ($l_ultimo;1;$y_intervalosNota;$y_intervalosPuntos;$y_bonificaciones;$y_intervalosNotaPct;$y_intervalosPuntosPct)
			$b_tablaModificada:=True:C214
		End if 
End case 


If ($b_tablaModificada)
	EVS_GuardaEstiloEvaluacion (False:C215)  //MONO Ticket 202359
End if 