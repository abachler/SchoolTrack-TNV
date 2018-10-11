//%attributes = {}
  //BWR_EnableSpecificObjects

  // ----------------------------------------------------
  // Nombre usuario (OS): abachler
  // Fecha y hora: 12/08/07, 23:35:44
  // ----------------------------------------------------
  // Método: BWR_EnableSpecificObjects
  // Descripción
  // Se activa los atributos cliequeables y enterables de los objetos pasados en argumento
  //
  // Parámetros
  // ----------------------------------------------------



C_TEXT:C284($varName)
C_POINTER:C301(${1};$pointer)
C_LONGINT:C283($i;$tableNum;$fieldNum)
For ($i;1;Count parameters:C259)
	$pointer:=${$i}
	RESOLVE POINTER:C394($pointer;$varName;$tableNum;$fieldNum)
	If (($varName#"") | ($fieldNum>0))
		OBJECT SET ENTERABLE:C238($pointer->;True:C214)
		_O_ENABLE BUTTON:C192($pointer->)
	End if 
End for 
