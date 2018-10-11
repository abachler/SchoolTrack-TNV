  // [xxSTR_EstilosEvaluacion].Configuration.menuContextual()
  //
  //
  // creado por: Alberto Bachler Klein: 12-07-16, 20:33:24
  // -----------------------------------------------------------
C_LONGINT:C283($l_opcion)
C_POINTER:C301($y_Bonificacion;$y_conversionNota;$y_conversionPuntos)
C_TEXT:C284($t_text)

$l_opcion:=Pop up menu:C542(__ ("Copiar tabla al portapapeles…")+";"+__ ("Imprimir tabla de conversión…"))
Case of 
	: ($l_opcion=1)
		POST KEY:C465(Character code:C91("c");Command key mask:K16:1+Shift key mask:K16:3+Option key mask:K16:7)
		
	: ($l_opcion=2)
		POST KEY:C465(Character code:C91("p");Command key mask:K16:1+Shift key mask:K16:3)
		
End case 

