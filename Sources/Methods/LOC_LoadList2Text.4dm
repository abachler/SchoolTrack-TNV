//%attributes = {}
  // LOC_LoadList2Text()
  // Por: Alberto Bachler K.: 07-08-15, 19:27:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_refLista)
C_TEXT:C284($t_delimitador;$t_nombreLista)


If (False:C215)
	C_TEXT:C284(LOC_LoadList2Text ;$0)
	C_TEXT:C284(LOC_LoadList2Text ;$1)
	C_TEXT:C284(LOC_LoadList2Text ;$2)
End if 

$t_nombreLista:=$1
If (Count parameters:C259=2)
	$t_delimitador:=$2
Else 
	$t_delimitador:=";"
End if 

$l_refLista:=LOC_LoadList ($t_nombreLista)
$0:=HL_ReferencedList2Text ($l_refLista;$t_delimitador)
CLEAR LIST:C377($l_refLista)