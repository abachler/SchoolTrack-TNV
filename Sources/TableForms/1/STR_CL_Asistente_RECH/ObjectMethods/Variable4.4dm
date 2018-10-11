vt_msg2:="Verificando los datos, un momento por favor…"
_O_DISABLE BUTTON:C193(bNext)
_O_DISABLE BUTTON:C193(bPrev)
POST OUTSIDE CALL:C329(-1)
REDRAW:C174(vt_Msg)
REDRAW WINDOW:C456
  //vt_text1:=""
  //vt_ResultadoDiagnostico:=""
MINEDUC_VerifyData 