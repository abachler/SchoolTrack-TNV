//%attributes = {}
  //NTA_SymbolValue2Percent

C_REAL:C285($0)
$0:=0
  //If ($1#"")
Case of 
	: ($1="")
		$0:=-10
	: ($1="P")
		$0:=-2
	: ($1="X")
		$0:=-3
	: ($1="*")
		$0:=-4
	: ($1=">>>")
		$0:=-5
	Else 
		$el:=Find in array:C230(aSymbol;$1)
		If ($el>0)
			$0:=aSymbPctEqu{$el}
		End if 
End case 
  //End if 