//%attributes = {}
  // EVS_CargaTablaConversion()
  //
  //
  // creado por: Alberto Bachler Klein: 04-07-16, 17:19:10
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_calculosEscalaAlternativa)
C_LONGINT:C283($i;$l_ConversionTable;$l_decimales;$l_modo;$l_posicion)
C_POINTER:C301($y_bonificaciones;$y_intervalosNota;$y_intervalosNotaPct;$y_intervalosPointsPct;$y_intervalosPuntos;$y_intervalosPuntosPct)
C_REAL:C285($r_intervalo;$r_maximoEscala;$r_minimoEscala;$r_nota;$r_paso;$r_puntos;$r_realNota;$r_realPuntos)
C_TEXT:C284($t_formato;$t_formatoBonificacion;$t_formatoNotas;$t_formatoPuntos;$t_separadorDecimal)

ARRAY LONGINT:C221($al_decimales;0)

$y_intervalosNota:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota")
$y_intervalosPuntos:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosPuntos")
$y_bonificaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"bonificacion")
$y_intervalosNotaPct:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota%")
$y_intervalosPuntosPct:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosPuntos%")

COPY ARRAY:C226(arEVS_ConvGrades;$y_intervalosNota->)
COPY ARRAY:C226(arEVS_ConvPoints;$y_intervalosPuntos->)
COPY ARRAY:C226(arEVS_ConvGradesOfficial;$y_bonificaciones->)
COPY ARRAY:C226(arEVS_ConvGradesPercent;$y_intervalosNotaPct->)
COPY ARRAY:C226(arEVS_ConvPointsPercent;$y_intervalosPuntosPct->)

EVS_ValidaTablaConversion 



Case of 
	: ((iEvaluationMode=Notas) & ((iPrintMode=Puntos) | (iPrintActa=Puntos) | (iViewMode=Puntos)))
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Notas
		
	: ((iEvaluationMode=Puntos) & ((iPrintMode=Notas) | (iPrintActa=Notas) | (iViewMode=Notas)))
		$l_decimales:=MATH_Max (iPointsDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Puntos
		
	: ((iEvaluationMode=Simbolos) & ((iPrintMode=Simbolos) | (iPrintActa=Simbolos) & (iViewMode=Simbolos)))
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Notas
		
	: ((iEvaluationMode=Porcentaje) & ((iPrintMode=Porcentaje) | (iPrintActa=Porcentaje) & (iViewMode=Porcentaje)))
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Notas
		
	Else 
		$l_decimales:=iGradesDec
		$l_decimales:=MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
		$l_modo:=Notas
End case 

GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$t_separadorDecimal)
$t_formatoNotas:=Choose:C955($l_decimales>0;"##0"+$t_separadorDecimal+("0"*$l_decimales);"###0")
$t_formatoPuntos:=Choose:C955($l_decimales>0;"##0"+$t_separadorDecimal+("0"*$l_decimales);"###0")
Case of 
	: ($l_modo=Notas)
		$t_formatoBonificacion:=$t_formatoNotas
		OBJECT SET FONT STYLE:C166(*;"intervalosNota";Bold:K14:2)
		OBJECT SET FONT STYLE:C166(*;"intervalosPuntos";Plain:K14:1)
		OBJECT SET ENTERABLE:C238(*;"intervalosNotas";False:C215)
		
	: ($l_modo=Puntos)
		$t_formatoBonificacion:=$t_formatoPuntos
		OBJECT SET FONT STYLE:C166(*;"intervalosNota";Plain:K14:1)
		OBJECT SET FONT STYLE:C166(*;"intervalosPuntos";Bold:K14:2)
		OBJECT SET ENTERABLE:C238(*;"intervalosPuntos";False:C215)
		
End case 

OBJECT SET FORMAT:C236(*;"intervalosNota";$t_formatoNotas)
OBJECT SET FORMAT:C236(*;"intervalosPuntos";$t_formato)
OBJECT SET FORMAT:C236(*;"bonificacion";$t_formatoBonificacion)
OBJECT SET FORMAT:C236(*;"intervalosNota%";"##0"+$t_separadorDecimal+"00000000000")
OBJECT SET FORMAT:C236(*;"intervalosPuntos%";"##0"+$t_separadorDecimal+"00000000000")


  // determino si es posible calcular promedios en la escala alternativa con evaluaciones parciales convertidas a esa escala
$l_ConversionTable:=iConversionTable
iConversionTable:=0
If (Size of array:C274(arEVS_ConvGrades)>0)
	For ($i;1;Size of array:C274(arEVS_ConvGrades))
		Case of 
			: (iEvaluationMode=Notas)
				$r_realNota:=EV2_Nota_a_Real (arEVS_ConvGrades{$i})
				$r_puntos:=EV2_Real_a_Puntos ($r_realNota)
				If ($r_puntos#arEVS_ConvPoints{$i})
					$b_calculosEscalaAlternativa:=True:C214
					$i:=Size of array:C274(arEVS_ConvGrades)
				End if 
				
			: (iEvaluationMode=Puntos)
				$r_realPuntos:=EV2_Puntos_a_Real (arEVS_ConvPoints{$i})
				$r_nota:=EV2_Real_a_Nota ($r_realPuntos)
				If ($r_nota#arEVS_ConvGrades{$i})
					$b_calculosEscalaAlternativa:=True:C214
					$i:=Size of array:C274(arEVS_ConvGrades)
				End if 
		End case 
	End for 
End if 
iConversionTable:=$l_ConversionTable
$b_calculosEscalaAlternativa:=$b_calculosEscalaAlternativa | (AT_CountNulValues (->arEVS_ConvGradesOfficial)#Size of array:C274(arEVS_ConvGradesOfficial))
If ($b_calculosEscalaAlternativa)
	Case of 
		: ((iEvaluationMode=Puntos) & ((iPrintMode=Notas) | (iPrintActa=Notas)))
			OBJECT SET TITLE:C194(*;"calcularConEscala";__ ("Calcular promedio en notas con las calificaciones de la escala"))
		: ((iEvaluationMode=Notas) & ((iPrintMode=Puntos) | (iPrintActa=Puntos)))
			OBJECT SET TITLE:C194(*;"calcularConEscala";__ ("Calcular promedio en puntos con las calificaciones de la escala"))
	End case 
End if 
OBJECT SET ENABLED:C1123(*;"calcularConEscala";$b_calculosEscalaAlternativa)
