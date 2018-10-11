  // [xxSTR_EstilosEvaluacion].Configuration.lbTablaConversion()
  //
  //
  // creado por: Alberto Bachler Klein: 12-07-16, 12:18:28
  // -----------------------------------------------------------
C_LONGINT:C283($l_columna;$l_decimales;$l_fila)
C_POINTER:C301($y_antesEdicionBonificacion;$y_antesEdicionNota;$y_antesEdicionPuntos;$y_Bonificacion;$y_conversionNota;$y_conversionNotaPCT;$y_conversionPuntos;$y_conversionPuntosPCT;$y_variable)
C_REAL:C285($r_maximo;$r_minimo;$r_nota;$r_Puntos;$r_valorBonificado;$r_valorConversion)
C_TEXT:C284($t_formato;$t_maximo;$t_mensaje;$t_minimo;$t_separadorDecimal)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY LONGINT:C221($al_decimales;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY POINTER:C280($ay_variableColumnas;0)
ARRAY POINTER:C280($ay_variableEncabezados;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)

$y_conversionNotaPCT:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota%")
$y_conversionPuntosPCT:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota%")
$y_conversionNota:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota")
$y_conversionPuntos:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosPuntos")
$y_Bonificacion:=OBJECT Get pointer:C1124(Object named:K67:5;"bonificacion")

$y_antesEdicionNota:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionTablaNota")
$y_antesEdicionPuntos:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionTablaPuntos")
$y_antesEdicionBonificacion:=OBJECT Get pointer:C1124(Object named:K67:5;"antesEdicionTablaBonificacion")

LISTBOX GET ARRAYS:C832(*;OBJECT Get name:C1087;$at_nombreColumnas;$at_nombreEncabezados;$ay_variableColumnas;$ay_variableEncabezados;$ab_visibles;$ay_estilos)
LISTBOX GET CELL POSITION:C971(*;OBJECT Get name:C1087;$l_columna;$l_fila;$y_variable)


Case of 
	: (Form event:C388=On Before Data Entry:K2:39)
		Case of 
			: ($at_nombreColumnas{$l_columna}="intervalosNota")
				$y_antesEdicionNota->:=$y_conversionNota->{$l_fila}
			: ($at_nombreColumnas{$l_columna}="intervalosPuntos")
				$y_antesEdicionPuntos->:=$y_conversionPuntos->{$l_fila}
			: ($at_nombreColumnas{$l_columna}="bonificacion")
				$y_antesEdicionBonificacion->:=$y_Bonificacion->{$l_fila}
		End case 
		
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: ($at_nombreColumnas{$l_columna}="intervalosNota")
				$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
				GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$t_separadorDecimal)
				$t_formato:=Choose:C955($l_decimales>0;"##0"+$t_separadorDecimal+("0"*$l_decimales);"###0")
				$t_minimo:=String:C10(rGradesFrom;$t_formato)
				$t_maximo:=String:C10(rGradesTo;$t_formato)
				$r_nota:=Trunc:C95($y_conversionNota->{$l_fila};$l_decimales)
				Case of 
					: (($r_nota<rGradesFrom) | ($r_nota>rGradesTo))
						$t_mensaje:=__ ("El valor registrado está fuera de la escala de notas.\r\rPor favor ingrese un valor en el rango ^0 a ^1")
						$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_minimo))
						$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_maximo))
						ModernUI_Notificacion (__ ("Tabla de conversión entre escalas");$t_mensaje)
						$y_conversionNota->{$l_fila}:=$y_antesEdicionNota->
						EDIT ITEM:C870(*;"intervalosNota";$l_fila)
					Else 
						$y_conversionNotaPCT->{$l_fila}:=Round:C94($r_nota/rGradesTo*100;11)
						EVS_GuardaEstiloEvaluacion 
				End case 
				
			: ($at_nombreColumnas{$l_columna}="intervalosPuntos")
				$l_decimales:=MATH_Max (iPointsDec;iPointsDecPP;iPointsDecPF;iPointsDecNF;iPointsDecNO)
				GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$t_separadorDecimal)
				$t_formato:=Choose:C955($l_decimales>0;"##0"+$t_separadorDecimal+("0"*$l_decimales);"###0")
				$t_minimo:=String:C10(rPointsFrom;$t_formato)
				$t_maximo:=String:C10(rPointsTo;$t_formato)
				$r_Puntos:=Trunc:C95($y_conversionPuntos->{$l_fila};$l_decimales)
				Case of 
					: (($r_Puntos<rPointsFrom) | ($r_Puntos>rPointsTo))
						$t_mensaje:=__ ("El valor registrado está fuera de la escala de puntos.\r\rPor favor ingrese un valor en el rango ^0 a ^1")
						$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_minimo))
						$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_maximo))
						ModernUI_Notificacion (__ ("Tabla de conversión entre escalas");$t_mensaje)
						$y_conversionPuntos->{$l_fila}:=$y_antesEdicionPuntos->
						EDIT ITEM:C870(*;"intervalosNota";$l_fila)
					Else 
						$y_conversionPuntosPCT->{$l_fila}:=Round:C94($r_puntos/rPointsTo*100;11)
						EVS_GuardaEstiloEvaluacion 
				End case 
				
				
			: ($at_nombreColumnas{$l_columna}="bonificacion")
				Case of 
					: (OBJECT Get enterable:C1067(*;"intervalosNota")=False:C215)
						$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
						$r_minimo:=rGradesFrom
						$r_maximo:=rGradesTo
						GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$t_separadorDecimal)
						$t_formato:=Choose:C955($l_decimales>0;"##0"+$t_separadorDecimal+("0"*$l_decimales);"###0")
						$t_minimo:=String:C10(rGradesFrom;$t_formato)
						$t_maximo:=String:C10(rGradesTo;$t_formato)
						$r_valorConversion:=$y_conversionNota->{$l_fila}
						
					: (OBJECT Get enterable:C1067(*;"intervalosPuntos")=False:C215)
						$l_decimales:=MATH_Max (iPointsDec;iPointsDecPP;iPointsDecPF;iPointsDecNF;iPointsDecNO)
						$r_minimo:=rPointsFrom
						$r_maximo:=rPointsTo
						GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$t_separadorDecimal)
						$t_formato:=Choose:C955($l_decimales>0;"##0"+$t_separadorDecimal+("0"*$l_decimales);"###0")
						$t_minimo:=String:C10(rPointsFrom;$t_formato)
						$t_maximo:=String:C10(rPointsTo;$t_formato)
						$r_valorConversion:=$y_conversionPuntos->{$l_fila}
				End case 
				
				$y_Bonificacion->{$l_fila}:=Trunc:C95($y_Bonificacion->{$l_fila};$l_decimales)  //MONO TICKET 194786
				$r_valorBonificado:=$y_Bonificacion->{$l_fila}+$r_valorConversion
				If (($r_valorBonificado<$r_minimo) | ($r_valorBonificado>$r_maximo))
					$t_mensaje:=__ ("El valor bonificado en la escala de conversión está fuera de la escala.\r\rPor favor ingrese un valor en el rango ^0 a ^1")
					$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_minimo))
					$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_maximo))
					ModernUI_Notificacion (__ ("Tabla de conversión entre escalas");$t_mensaje)
					$y_Bonificacion->{$l_fila}:=$y_antesEdicionBonificacion->
					EDIT ITEM:C870(*;"bonificacion";$l_fila)
				End if 
				
		End case 
		
End case 






