//%attributes = {}
  //SN3_BuildCalificacionTag

C_POINTER:C301($1)
C_LONGINT:C283($idCalificacion;$3;$idalumno;$4;$idasignatura;$5;$13)
C_REAL:C285($notaPuntos;$9;$10;$11)
C_TEXT:C284($7;$8;$12)

$xmlRef:=$2

$idCalificacion:=$3

$idalumno:=$4
$idasignatura:=$5
$periodo:=$6

$tipo:=$7
$notaLiteral:=$8

If (Count parameters:C259=13)
	$notaReal:=$9
	$notaNota:=$10
	$notaPuntos:=$11
	$notaSimbolo:=$12
	$estilo:=$13
End if 

SAX_CreateNode ($xmlRef;"cal")
SAX_CreateNode ($xmlRef;"id";True:C214;String:C10($idCalificacion))
SAX_CreateNode ($xmlRef;"idalu";True:C214;String:C10($idalumno))
SAX_CreateNode ($xmlRef;"idasig";True:C214;String:C10($idasignatura))
SAX_CreateNode ($xmlRef;"per";True:C214;$periodo)
SAX_CreateNode ($xmlRef;"tipo";True:C214;$tipo)
SAX_CreateNode ($xmlRef;"nota";True:C214;$notaLiteral)

If (Count parameters:C259=13)
	If ($notaReal<0)
		SAX_CreateNode ($xmlRef;"porcentaje";True:C214;$notaLiteral)
		SAX_CreateNode ($xmlRef;"notanum";True:C214;$notaLiteral)
		SAX_CreateNode ($xmlRef;"puntos";True:C214;$notaLiteral)
		SAX_CreateNode ($xmlRef;"simbolo";True:C214;$notaLiteral)
	Else 
		SAX_CreateNode ($xmlRef;"porcentaje";True:C214;EV2_Real_a_Literal ($notaReal;Porcentaje))
		SAX_CreateNode ($xmlRef;"notanum";True:C214;String:C10($notaNota))
		SAX_CreateNode ($xmlRef;"puntos";True:C214;String:C10($notaPuntos))
		SAX_CreateNode ($xmlRef;"simbolo";True:C214;$notaSimbolo)
	End if 
	
	SAX_CreateNode ($xmlRef;"col";True:C214;SN3_GetColorNota ($estilo;$notaReal))
	
Else 
	SAX_CreateNode ($xmlRef;"col";True:C214;"B")
End if 

SAX CLOSE XML ELEMENT:C854($xmlRef)

$1->:=$1->+1