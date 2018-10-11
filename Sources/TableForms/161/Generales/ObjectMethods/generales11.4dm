$machine:=Current machine:C483
$user:=Current system user:C484

$combinedWS:=$machine+"/"+$user
If (SN3_SendFrom_SelectedWS#$combinedWS)
	If (($machine#"") & ($user#""))
		SN3_SendFrom_SelectedWS:=$combinedWS
	Else 
		SN3_SendFrom_SelectedWS:=""
	End if 
	If (SN3_SendFrom_SelectedWS="")
		CD_Dlog (0;__ ("La actualización no puede realizarse en esta máquina ya que el nombre del computador y/o el nombre de usuario no han sido definido.\r\rPor favor consulte la documentación de su sistema operativo para configurar adecuadamente su computador."))
		SN3_SendFrom_Server:=1
		SN3_SendFrom_Workstation:=0
		OBJECT SET ENTERABLE:C238(SN3_SendFrom_SelectedWS;False:C215)
		_O_DISABLE BUTTON:C193(bSame2)
	Else 
		CD_Dlog (0;__ ("Si modifica el nombre del computador o del usuario deberá redefinir esta estación (u otra) para efectuar la actualización de las páginas web."))
	End if 
End if 