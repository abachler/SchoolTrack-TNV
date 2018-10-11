//%attributes = {}
  //XS_GetCommandAliasDescription


  //======NO COPIAR A STX========
vb_Modificado_4Dv11:=True:C214
  //método modificado para v11
  //puede necesitar ajustes si se copia  a STX


C_TEXT:C284($0)

$commandRN:=$1
$countryCode:=$2
$langageCode:=$3
If (Record number:C243([xShell_ExecutableCommands:19])#$commandRN)
	READ ONLY:C145([xShell_ExecutableCommands:19])
	GOTO RECORD:C242([xShell_ExecutableCommands:19];$commandRN)
End if 

QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=;[xShell_ExecutableCommands:19]ID:10;*)
QUERY:C277([xShell_ExecCommands_Localized:232]; & [xShell_ExecCommands_Localized:232]Country_Code:1;=;$countryCode;*)
QUERY:C277([xShell_ExecCommands_Localized:232]; & [xShell_ExecCommands_Localized:232]Language_Code:2;=;$langageCode)

$0:=[xShell_ExecCommands_Localized:232]Alias:3+"\t"+[xShell_ExecCommands_Localized:232]Description:4

KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
KRL_UnloadReadOnly (->[xShell_ExecCommands_Localized:232])