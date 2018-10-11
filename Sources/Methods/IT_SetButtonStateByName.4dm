//%attributes = {}
  // MÉTODO: IT_SetButtonStateByName
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/04/12, 17:40:54
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // IT_SetButtonStateByName()
  // ----------------------------------------------------
C_TEXT:C284(${2})
C_BOOLEAN:C305($1;$b_buttonEnabled)
$b_buttonEnabled:=$1


  // CODIGO PRINCIPAL
For ($i;2;Count parameters:C259)
	If ($b_buttonEnabled)
		_O_ENABLE BUTTON:C192(*;${$i})
	Else 
		_O_DISABLE BUTTON:C193(*;${$i})
	End if 
End for 