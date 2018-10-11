//%attributes = {}
  //XS_SearchCommandAlias

$country:=$1
$langage:=$2
$alias:=$3
$b_existe:=False:C215
ALL RECORDS:C47([xShell_ExecutableCommands:19])
FIRST RECORD:C50([xShell_ExecutableCommands:19])
$search:=True:C214
While ((Not:C34(End selection:C36([xShell_ExecutableCommands:19]))) & ($search))
	QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=[xShell_ExecutableCommands:19]ID:10;*)
	QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Alias:3;=;$alias;*)
	QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Country_Code:1;=;$country;*)
	QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Language_Code:2;=;$langage)
	If (Records in selection:C76([xShell_ExecCommands_Localized:232])#0)
		$search:=False:C215
		$b_existe:=True:C214
	Else 
		NEXT RECORD:C51([xShell_ExecutableCommands:19])
	End if 
End while 
$0:=$b_existe