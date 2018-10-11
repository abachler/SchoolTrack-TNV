$b_fechaEsValida:=DateIsValid (Self:C308->)
If (dDate<=Current date:C33(*))
	If (Not:C34($b_fechaEsValida))
		Self:C308->:=!00-00-00!
		GOTO OBJECT:C206(dDate)
	End if 
Else 
	Self:C308->:=!00-00-00!
	GOTO OBJECT:C206(Self:C308->)
	HIGHLIGHT TEXT:C210(Self:C308->;1;80)
	$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar un atraso anticipadamente."))
End if 



If ((sCurso="") | (dDate=!00-00-00!))
	OBJECT SET ENTERABLE:C238(sName;False:C215)
Else 
	OBJECT SET ENTERABLE:C238(sName;True:C214)
End if 
