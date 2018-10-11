//%attributes = {}
  // Método: SQ_SeqNumber
  // ----------------------------------------------------
  // Nombre usuario (OS): abachler
  // Fecha y hora: 09/04/08, 10:20:06
  // ----------------------------------------------------

  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_POINTER:C301($1;$pointer)
C_BOOLEAN:C305($2;$vbSecuenciaNegativa)
C_REAL:C285($0)
$pointer:=$1
If (Count parameters:C259=2)
	$vbSecuenciaNegativa:=$2
End if 
$0:=SQ_RetornaNuevoID ($pointer;$vbSecuenciaNegativa)
