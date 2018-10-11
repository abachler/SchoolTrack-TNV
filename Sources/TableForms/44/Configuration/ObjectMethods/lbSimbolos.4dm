  // [xxSTR_EstilosEvaluacion].Configuration.lbSimbolos()
  //
  //
  // creado por: Alberto Bachler Klein: 26-06-16, 10:31:26
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_editable)
C_LONGINT:C283($l_abajo;$l_alto;$l_ancho;$l_arr;$l_arriba;$l_columna;$l_der;$l_derecha;$l_fila;$l_izq)
C_LONGINT:C283($l_izquierda;$l_modoConversion;$l_opcion)
C_POINTER:C301($y_puntero;$y_simbolosConversion;$y_simbolosConversionPct;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosDesdePct;$y_simbolosHasta;$y_simbolosHastaPct;$y_simbolosSimbolo)
C_TEXT:C284($t_mensaje)

$l_modoConversion:=(OBJECT Get pointer:C1124(Object named:K67:5;"modoConversionSimbolos"))->

$y_simbolosSimbolo:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_simbolo")
$y_simbolosDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_descripcion")
$y_simbolosDesde:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde")
$y_simbolosHasta:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta")
$y_simbolosConversion:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion")
$y_simbolosDesdePct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_desde%")
$y_simbolosHastaPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_hasta%")
$y_simbolosConversionPct:=OBJECT Get pointer:C1124(Object named:K67:5;"simbolos_conversion%")
$b_editable:=OBJECT Get enterable:C1067(*;"simbolos_simbolo")

  //ASM colores gráficos
$y_coloresGraficos:=OBJECT Get pointer:C1124(Object named:K67:5;"color_graficos_stwa")

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		$t_mensaje:="Tabla de equivalencias entre simbolos y escala de referencia"
		If (Not:C34($b_editable))
			$t_mensaje:=$t_mensaje+"\rNo se pueden introducir modificaciones en esta tabla ya que hay evaluaciones registradas con este estilo."
		End if 
		$y_puntero:=OBJECT Get pointer:C1124(Object named:K67:5;"lbSimbolos")
		OBJECT SET HELP TIP:C1181($y_puntero->;$t_mensaje)
		
	: (Form event:C388=On Clicked:K2:4)
		
		If (Contextual click:C713)
			EVS_MenuContextualSimbolos 
		End if 
		
		
		
		
	: (Form event:C388=On Before Data Entry:K2:39)
		EVS_EdicionConversionSimbolos 
		
	: (Form event:C388=On Data Change:K2:15)
		EVS_EdicionConversionSimbolos 
		
End case 