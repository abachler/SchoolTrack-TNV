//%attributes = {}
  //elimino lineas con debe y haber en 0...
ARRAY LONGINT:C221($alACT_Debe;0)
ARRAY LONGINT:C221($alACT_Haber;0)
ARRAY LONGINT:C221($alACT_Result;0)
acampocc2{0}:=0
AT_SearchArray (->acampocc2;"=";->$alACT_Debe)
acampocc3{0}:=0
AT_SearchArray (->acampocc3;"=";->$alACT_Haber)
AT_intersect (->$alACT_Debe;->$alACT_Haber;->$alACT_Result)
For ($i;Size of array:C274($alACT_Result);1;-1)
	AT_Delete ($alACT_Result{$i};1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
End for 

ARRAY LONGINT:C221($alACT_Debe;0)
ARRAY LONGINT:C221($alACT_Haber;0)
ARRAY LONGINT:C221($alACT_Result;0)
acampo2{0}:=0
AT_SearchArray (->acampo2;"=";->$alACT_Debe)
acampo3{0}:=0
AT_SearchArray (->acampo3;"=";->$alACT_Haber)
AT_intersect (->$alACT_Debe;->$alACT_Haber;->$alACT_Result)
For ($i;Size of array:C274($alACT_Result);1;-1)
	AT_Delete ($alACT_Result{$i};1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID;->alACT_IdsBoletas)
End for 