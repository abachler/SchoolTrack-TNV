//%attributes = {}
  //KRL_isSameField

  //Método por RCH, fecha 20080305
  //Compara 2 punteros sobre campos pasados en $1 y $2 y devuelve verdadero cuando son campos y son iguales y falso cuando no son campos o son distintos
  //se utiliza en el caso en que se tenga un puntero sobre un campo dentro de una variable pointer (el puntero puede estar dentro de un loop) y se quiera comparar con un campo específico de la base de datos
C_POINTER:C301($1;$2)
C_BOOLEAN:C305($0;$retorno)
C_TEXT:C284($varName1;$varName2)
C_LONGINT:C283($tableNum1;$tableNum2;$fieldNum1;$fieldNum2)

RESOLVE POINTER:C394($1;$varName1;$tableNum1;$fieldNum1)
RESOLVE POINTER:C394($2;$varName2;$tableNum2;$fieldNum2)

$retorno:=False:C215
If (($fieldNum1#0) & ($fieldNum2#0))
	If (($tableNum1=$tableNum2) & ($fieldNum1=$fieldNum2))
		$retorno:=True:C214
	End if 
End if 
$0:=$retorno