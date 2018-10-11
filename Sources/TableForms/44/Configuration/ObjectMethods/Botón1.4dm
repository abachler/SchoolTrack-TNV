  // [xxSTR_EstilosEvaluacion].Configuration.Botón1()
  // 
  //
  // creado por: Alberto Bachler Klein: 18-07-16, 10:00:36
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_tablaModificada)
C_LONGINT:C283($i_intervalos;$l_decimales;$l_modo;$i)
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
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Notas
		
	: ((iEvaluationMode=Puntos) & ((iPrintMode=Notas) | (iPrintActa=Notas) | (iViewMode=Notas)))
		$r_minimoEscala:=rPointsFrom
		$r_maximoEscala:=rPointsTo
		$l_decimales:=MATH_Max (iPointsDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_decimales:=Max:C3($al_decimales)
		$l_modo:=Puntos
		
	: ((iEvaluationMode=Simbolos) & ((iPrintMode=Simbolos) | (iPrintActa=Simbolos) & (iViewMode=Simbolos)))
		$r_minimoEscala:=rGradesFrom
		$r_maximoEscala:=rGradesTo
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;GradesDecNO)
		$l_decimales:=Max:C3($al_decimales)
		$l_modo:=Notas
		  //AT_Initialize ($y_intervalosNota;$y_intervalosPuntos;$y_bonificaciones;$y_intervalosNotaPct;$y_intervalosPuntosPct)
		
	: ((iEvaluationMode=Porcentaje) & ((iPrintMode=Porcentaje) | (iPrintActa=Porcentaje) & (iViewMode=Porcentaje)))
		$r_minimoEscala:=rGradesFrom
		$r_maximoEscala:=rGradesTo
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_decimales:=Max:C3($al_decimales)
		$l_modo:=Notas
		  //AT_Initialize ($y_intervalosNota;$y_intervalosPuntos;$y_bonificaciones;$y_intervalosNotaPct;$y_intervalosPuntosPct)
		
	Else 
		$r_minimoEscala:=rGradesFrom
		$r_maximoEscala:=rGradesTo
		$l_decimales:=iGradesDec
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_decimales:=Max:C3($al_decimales)
		$l_modo:=Notas
End case 

For ($i;1;Size of array:C274($y_intervalosNota->))
	Case of 
		: ($l_modo=Notas)
			$r_valor:=EV2_Real_a_Puntos ($y_intervalosNotaPct->{$i})
			If ($y_intervalosPuntos->{$i}#$r_valor)
				$y_intervalosPuntos->{$i}:=EV2_Real_a_Puntos ($y_intervalosNotaPct->{$i})
			End if 
		: ($l_modo=Puntos)
			$r_valor:=EV2_Real_a_Nota ($y_intervalosPuntosPct->{$i})
			If ($y_intervalosNota->{$i}#$r_valor)
				$y_intervalosNota->{$i}:=EV2_Real_a_Nota ($y_intervalosPuntosPct->{$i})
			End if 
	End case 
End for 


