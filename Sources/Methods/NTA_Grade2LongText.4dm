//%attributes = {}
  //NTA_Grade2LongText

C_TEXT:C284($grade;$0)
C_LONGINT:C283($symbolIndex)
$grade:=$1
If ($grade#"")
	If ((Character code:C91($grade[[1]])>64) & ($grade#"*"))
		$symbolIndex:=Find in array:C230(aSymbol;$grade)
	End if 
	
	Case of 
		: ($symbolIndex>0)
			$0:=aSymbDesc{$symbolIndex}
		: (($grade="EX") | ($grade="X"))
			$0:="Eximido"
		: ($grade="E")
			$0:="Excelente"
		: ($grade="MB")
			$0:="Muy Bueno"
		: ($grade="B")
			$0:="Bueno"
		: ($grade="S")
			$0:="Suficiente"
		: ($grade="I")
			$0:="Insuficiente"
		: ($grade="*")
			$0:="No Evaluado"
		: ($grade="P")
			$0:="Pendiente"
		Else 
			$0:=ST_Num2Text2 (Num:C11($grade);"es";True:C214;True:C214)
	End case 
End if 