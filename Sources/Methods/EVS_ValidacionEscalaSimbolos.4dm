//%attributes = {}
  // EVS_ValidacionEscalaSimbolos()
  //
  //
  // creado por: Alberto Bachler Klein: 02-07-16, 11:16:37
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_decimales)
C_POINTER:C301($y_simbolosConversion;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosDesdePct;$y_simbolosHasta;$y_simbolosHastaPct;$y_simbolosSimbolo)
C_REAL:C285($r_diferenciaDecimales;$r_intervalo;$r_maximoEscala;$r_minimoDiferencia;$r_minimoEscala)
C_TEXT:C284($t_simboloBajoMediana;$t_simboloLimiteHasta;$t_simboloMediana;$t_simboloSobreMediana)

$y_simbolosSimbolo:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_simbolo")
$y_simbolosDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_descripcion")
$y_simbolosDesde:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde")
$y_simbolosHasta:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta")
$y_simbolosConversion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion")
$y_simbolosConversionPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion%")
$y_simbolosDesdePct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde%")
$y_simbolosHastaPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta%")

Case of 
	: (((iEvaluationMode=Notas) | ((iEvaluationMode=Simbolos) & (iPrintMode=Notas))) | ((viEVS_equMode=Notas) & (iEvaluationMode=Simbolos) & (iPrintMode=Simbolos) & (iViewMode=Simbolos)))
		$r_minimoEscala:=rGradesFrom
		$r_maximoEscala:=rGradesTo
		$l_decimales:=iGradesDec
		$r_intervalo:=rGradesInterval
		
	: (((iEvaluationMode=Puntos) | ((iEvaluationMode=Simbolos) & (iPrintMode=Puntos))) | ((viEVS_equMode=Puntos) & (iEvaluationMode=Simbolos) & (iPrintMode=Simbolos) & (iViewMode=Simbolos)))
		$r_minimoEscala:=rPointsFrom
		$r_maximoEscala:=rPointsTo
		$l_decimales:=iPointsDec
		$r_intervalo:=rPointsInterval
		
	Else 
		$r_minimoEscala:=1
		$r_maximoEscala:=100
		$l_decimales:=1
		$r_intervalo:=0.1
End case 


$r_minimoDiferencia:=1/(10^$l_decimales)

For ($i;1;Size of array:C274($y_simbolosSimbolo->))
	$y_simbolosDesde->{$i}:=Trunc:C95($y_simbolosDesde->{$i};$l_decimales)
	$y_simbolosHasta->{$i}:=Trunc:C95($y_simbolosHasta->{$i};$l_decimales)
	$y_simbolosDesdePct->{$i}:=Round:C94($y_simbolosDesde->{$i}/$r_maximoEscala*100;11)
	$y_simbolosHastaPct->{$i}:=Round:C94($y_simbolosHasta->{$i}/$r_maximoEscala*100;11)
End for 

For ($i;1;Size of array:C274($y_simbolosSimbolo->)-1)
	$r_diferenciaDecimales:=$y_simbolosDesde->{$i+1}-$y_simbolosHasta->{$i}
	If ($r_diferenciaDecimales>$r_minimoDiferencia)
		$y_simbolosHasta->{$i}:=$y_simbolosDesde->{$i+1}-$r_minimoDiferencia
		$y_simbolosHastaPct->{$i}:=Round:C94($y_simbolosHasta->{$i}/$r_maximoEscala*100;11)
	End if 
End for 

For ($i;1;Size of array:C274($y_simbolosSimbolo->))
	If ($y_simbolosConversion->{$i}>$y_simbolosHasta->{$i})
		$y_simbolosConversion->{$i}:=$y_simbolosHasta->{$i}
		$y_simbolosConversionPct->{$i}:=Round:C94($y_simbolosConversion->{$i}/$r_maximoEscala*100;11)
	End if 
End for 



EVS_GuardaEstiloEvaluacion 