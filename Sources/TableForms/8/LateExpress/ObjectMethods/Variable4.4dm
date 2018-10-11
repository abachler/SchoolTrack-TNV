If (Lid#0)
	If (i_line>0)
		$s:=i_Line
		  //AT_Delete ($s;1;-><>aExAbs1;-><>aExAbs2;-><>aExAbs2)  //EMA 05/10/06
		AT_Delete ($s;1;-><>aExAbs1;-><>aExAbs2;-><>aExAbs3)  //20180724 ASM Ticket 212497
	End if 
	sName:=""
	Lid:=0
	AL_UpdateArrays (xALP_Anot;Size of array:C274(<>aExAbs1))
	GOTO OBJECT:C206(sName)
	AL_SetLine (xALP_Anot;0)
	i_Line:=0
Else 
	BEEP:C151
End if 