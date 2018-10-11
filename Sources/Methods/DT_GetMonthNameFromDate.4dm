//%attributes = {}
  // Método: DT_GetMonthNameFromDate
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/11/09, 23:18:46
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
If (Count parameters:C259=1)
	$monthNum:=Month of:C24($1)
Else 
	$monthNum:=Month of:C24(Current date:C33(*))
End if 
$0:=<>atXS_MonthNames{$monthNum}



