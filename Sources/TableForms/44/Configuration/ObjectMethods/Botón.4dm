  // [xxSTR_EstilosEvaluacion].Configuration.Botón()
  //
  //
  // creado por: Alberto Bachler Klein: 22-12-15, 12:03:34
  // -----------------------------------------------------------
C_POINTER:C301($y_Bonificacion;$y_conversionNota;$y_conversionNotaPCT;$y_conversionPuntos;$y_conversionPuntosPCT)
C_TEXT:C284($t_text)

$y_conversionNota:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota")
$y_conversionPuntos:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosPuntos")
$y_Bonificacion:=OBJECT Get pointer:C1124(Object named:K67:5;"bonificacion")
$y_conversionNotaPCT:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosNota")
$y_conversionPuntosPCT:=OBJECT Get pointer:C1124(Object named:K67:5;"intervalosPuntos")


If (<>lUSR_CurrentUserID<0)
	$t_text:=__ ("Notas")+"\t"+__ ("Puntos")+"\t"+__ ("Bonificación")+"\t"+__ ("% Nota")+"\t"+__ ("% Puntos")+"\r"+AT_Arrays2Text ("\r";"\t";$y_conversionNota;$y_conversionPuntos;$y_Bonificacion;$y_conversionNotaPCT;$y_conversionPuntosPCT)
Else 
	$t_text:=__ ("Notas")+"\t"+__ ("Puntos")+"\t"+__ ("Bonificación")+"\r"+AT_Arrays2Text ("\r";"\t";$y_conversionNota;$y_conversionPuntos;$y_Bonificacion)
End if 
SET TEXT TO PASTEBOARD:C523($t_Text)


