//%attributes = {}
  //SQ_RestauraSecuencias

C_LONGINT:C283($tableNum;$fieldNum)
C_REAL:C285($positif;$negatif)

$fieldPointer:=$1
$tablePointer:=Table:C252(Table:C252($fieldPointer))

$positif:=0
$negatif:=0

If (KRL_IsFieldIndexed ($fieldPointer))
	SCAN INDEX:C350($fieldPointer->;1;>)
	If ($fieldPointer-><0)
		$negatif:=$fieldPointer->
	End if 
	SCAN INDEX:C350($fieldPointer->;1;<)
	If ($fieldPointer->>0)
		$positif:=$fieldPointer->
	End if 
	
Else 
	ALL RECORDS:C47($tablePointer->)
	ORDER BY:C49($tablePointer->;$fieldPointer->;>)
	FIRST RECORD:C50($tablePointer->)
	If ($fieldPointer-><0)
		$negatif:=$fieldPointer->
	End if 
	LAST RECORD:C200($tablePointer->)
	If ($fieldPointer->>0)
		$positif:=$fieldPointer->
	End if 
	
End if 



SQ_EstableceSecuencia ($fieldPointer;$positif;False:C215)
SQ_EstableceSecuencia ($fieldPointer;$negatif;True:C214)

