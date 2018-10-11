C_LONGINT:C283($l_numDec)
IT_MODIFIERS 

$l_numDec:=Num:C11(Substring:C12(String:C10(Dec:C9(Self:C308->));3))
If (Length:C16(String:C10($l_numDec))>3)
	CD_Dlog (0;"La cantidad máxima de decimales es 3.")
	If (Not:C34((<>Shift) & (<>Command)))
		Self:C308->:=Round:C94(Self:C308->;3)
	End if 
End if 