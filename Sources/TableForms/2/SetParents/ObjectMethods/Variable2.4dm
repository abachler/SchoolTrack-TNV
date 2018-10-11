If (aParentNames>0)
	READ ONLY:C145([Personas:7])
	  //03/05/2011, AS. Se comenta porque se perdía la selección.
	  //GOTO RECORD([Personas];aParentRecNo{Self->})
Else 
	BEEP:C151
End if 