//%attributes = {}
  //STX_EvtPersVentanaEntrevista


OBJECT SET VISIBLE:C603(*;"entrevista@";True:C214)

OBJECT GET COORDINATES:C663(*;"bOK";left;top;right;bottom)

If (left#707)
	
	OBJECT MOVE:C664(*;"campoPrivado";0;315)
	OBJECT MOVE:C664(*;"variable3";244;315)
	OBJECT MOVE:C664(*;"variable4";244;315)
	OBJECT MOVE:C664(*;"bOK";244;315)
	OBJECT MOVE:C664(*;"objNotas@";0;315)
	SET WINDOW RECT:C444(100;60;900;560)
End if 

REDRAW WINDOW:C456