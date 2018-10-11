//%attributes = {}
  //UTIL_isOS64bit 


C_BOOLEAN:C305($0;$b_is64)
C_TEXT:C284($in;$out;$err)

If (SYS_IsWindows )
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	LAUNCH EXTERNAL PROCESS:C811("cmd.exe /C set | findstr ProgramFiles(x86)";$in;$out;$err)
	If (Position:C15("ProgramFiles(x86)";$out)>0)
		$b_is64:=True:C214
	End if 
Else 
	LAUNCH EXTERNAL PROCESS:C811("uname -a";$in;$out;$err)
	If (Position:C15("x86_64";$out)>0)
		$b_is64:=True:C214
	End if 
End if 

$0:=$b_is64