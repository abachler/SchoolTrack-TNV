//%attributes = {}
  // EVS_GuardaConversionSimbolos()
  //
  //
  // creado por: Alberto Bachler Klein: 30-06-16, 10:15:05
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_decimales;$l_modoConversion)
C_POINTER:C301($y_simbolosConversion;$y_simbolosDesde;$y_simbolosHasta;$y_simbolosConversionPct;$y_simbolosDescripcion;$y_simbolosDesdePct;$y_simbolosHastaPct;$y_simbolosSimbolo)
C_REAL:C285($r_maxEscala)

$y_simbolosDesde:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde")
$y_simbolosHasta:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta")
$y_simbolosConversion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion")
$y_simbolosDesdePct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde%")
$y_simbolosHastaPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta%")
$y_simbolosConversionPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion%")
$y_simbolosSimbolo:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_simbolo")
$y_simbolosDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_descripcion")
$y_coloresGraficos:=OBJECT Get pointer:C1124(Object named:K67:5;"color_graficos_stwa")  //MONO Ticket 213076

COPY ARRAY:C226($y_simbolosSimbolo->;aSymbol)
COPY ARRAY:C226($y_simbolosDescripcion->;aSymbDesc)
COPY ARRAY:C226($y_simbolosDesdePct->;aSymbPctFrom)
COPY ARRAY:C226($y_simbolosHastaPct->;aSymbPctTo)
COPY ARRAY:C226($y_simbolosConversionPct->;aSymbPctEqu)
COPY ARRAY:C226($y_coloresGraficos->;aSTWAColorRGB)  //MONO Ticket 213076

$l_modoConversion:=EVS_ModoConversionSimbolos   // establece el modo de conversion a usar en la tabla de conversión de símbolos


Case of 
	: ($l_modoConversion=Notas)
		$r_maxEscala:=rGradesTo
		$l_decimales:=iGradesDec
		COPY ARRAY:C226($y_simbolosDesde->;aSymbGradeFrom)
		COPY ARRAY:C226($y_simbolosHasta->;aSymbGradeTo)
		COPY ARRAY:C226($y_simbolosConversion->;aSymbGradesEqu)
		
	: ($l_modoConversion=Puntos)
		$r_maxEscala:=rPointsTo
		$l_decimales:=iPointsDec
		COPY ARRAY:C226($y_simbolosDesde->;aSymbPointsFrom)
		COPY ARRAY:C226($y_simbolosHasta->;aSymbPointsTo)
		COPY ARRAY:C226($y_simbolosConversion->;aSymbPointsEqu)
		
	: ($l_modoConversion=Porcentaje)
		$r_maxEscala:=100
		$l_decimales:=1
		COPY ARRAY:C226($y_simbolosDesde->;$y_simbolosDesdePct->)
		COPY ARRAY:C226($y_simbolosHasta->;$y_simbolosHastaPct->)
		COPY ARRAY:C226($y_simbolosConversion->;$y_simbolosConversionPct->)
End case 

AT_RedimArrays (Size of array:C274(aSymbol);->aSymbDesc;->aSymbGradeFrom;->aSymbGradeTo;->aSymbGradesEqu;->aSymbPointsFrom;->aSymbPointsTo;->aSymbPointsEqu)
