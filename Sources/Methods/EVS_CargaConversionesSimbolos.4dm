//%attributes = {}
  // EVS_CargaConversionesSimbolos()
  //
  //
  // creado por: Alberto Bachler Klein: 25-06-16, 12:29:13
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_decimales;$l_modoConversion)
C_POINTER:C301($y_simbolosConversion;$y_simbolosConversionPct;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosDesdePct;$y_simbolosHasta;$y_simbolosHastaPct;$y_simbolosSimbolo)
C_REAL:C285($r_maxEscala)
C_TEXT:C284($t_formato;$t_separadorDecimal)

$y_simbolosSimbolo:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_simbolo")
$y_simbolosDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_descripcion")
$y_simbolosDesde:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde")
$y_simbolosHasta:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta")
$y_simbolosConversion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion")
$y_simbolosDesdePct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde%")
$y_simbolosHastaPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta%")
$y_simbolosConversionPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion%")
  //AT_RedimArrays (0;$y_simbolosSimbolo;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosHasta;$y_simbolosConversion;$y_simbolosDesdePct;$y_simbolosHastaPct;$y_simbolosConversionPct)
$y_coloresGraficos:=OBJECT Get pointer:C1124(Object named:K67:5;"color_graficos_stwa")  //MONO Ticket 213076

$l_modoConversion:=EVS_ModoConversionSimbolos   // establece el modo de conversion a usar en la tabla de conversión de símbolos


COPY ARRAY:C226(aSymbol;$y_simbolosSimbolo->)
COPY ARRAY:C226(aSymbDesc;$y_simbolosDescripcion->)
COPY ARRAY:C226(aSymbPctFrom;$y_simbolosDesdePct->)
COPY ARRAY:C226(aSymbPctTo;$y_simbolosHastaPct->)
COPY ARRAY:C226(aSymbPctEqu;$y_simbolosConversionPct->)
COPY ARRAY:C226(aSTWAColorRGB;$y_coloresGraficos->)  //MONO Ticket 213076

Case of 
	: ($l_modoConversion=Notas)
		$r_maxEscala:=rGradesTo
		$l_decimales:=iGradesDec
		COPY ARRAY:C226(aSymbGradeFrom;$y_simbolosDesde->)
		COPY ARRAY:C226(aSymbGradeTo;$y_simbolosHasta->)
		COPY ARRAY:C226(aSymbGradesEqu;$y_simbolosConversion->)
		
	: ($l_modoConversion=Puntos)
		$r_maxEscala:=rPointsTo
		$l_decimales:=iPointsDec
		COPY ARRAY:C226(aSymbPointsFrom;$y_simbolosDesde->)
		COPY ARRAY:C226(aSymbPointsTo;$y_simbolosHasta->)
		COPY ARRAY:C226(aSymbPointsEqu;$y_simbolosConversion->)
		
	: ($l_modoConversion=Porcentaje)
		$r_maxEscala:=100
		$l_decimales:=1
		COPY ARRAY:C226($y_simbolosDesdePct->;$y_simbolosDesde->)
		COPY ARRAY:C226($y_simbolosHastaPct->;$y_simbolosHasta->)
		COPY ARRAY:C226($y_simbolosConversionPct->;$y_simbolosConversion->)
End case 
AT_RedimArrays (Size of array:C274(aSymbol);->aSymbGradeFrom;->aSymbGradeTo;->aSymbGradesEqu;->aSymbPointsFrom;->aSymbPointsTo;->aSymbPointsEqu)



GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$t_separadorDecimal)
$t_formato:=Choose:C955($l_decimales>0;"##0"+$t_separadorDecimal+("0"*$l_decimales);"###0")
OBJECT SET FORMAT:C236(*;"simbolos_desde";$t_formato)
OBJECT SET FORMAT:C236(*;"simbolos_hasta";$t_formato)
OBJECT SET FORMAT:C236(*;"simbolos_conversion";$t_formato)


