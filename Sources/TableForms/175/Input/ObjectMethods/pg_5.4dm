If (USR_GetMethodAcces ("ACTmnu_AsignMatrix"))
	  //If (([ACT_CuentasCorrientes]Estado=False) | (([Alumnos]Nivel_Número=Nivel_AdmisionDirecta) & (viACT_AsignarMatAdmision=0)))
	If (([ACT_CuentasCorrientes:175]Estado:4=False:C215) | (([Alumnos:2]nivel_numero:29<=Nivel_AdmisionDirecta) & (viACT_AsignarMatAdmision=0)))  //20170801 RCH
		$Matrices:="Ninguna"
	Else 
		If (Not:C34(Locked:C147([ACT_CuentasCorrientes:175])))
			vbSpell_StopChecking:=True:C214
			C_LONGINT:C283($choice)
			IT_Clairvoyance (Self:C308;->atACTcc_MatrixName;"";False:C215)
			If (Form event:C388=On Data Change:K2:15)
				Case of 
					: (Find in array:C230(<>atACT_MatrixName;Self:C308->)#-1)
						$choice:=Find in array:C230(<>atACT_MatrixName;Self:C308->)
					: (Self:C308->="Ninguna")
						$choice:=0
					Else 
						$choice:=-1
				End case 
			End if 
			If ($choice#-1)
				$return:=ACTmnu_AsignMatrix ($choice)
			End if 
			If ([ACT_CuentasCorrientes:175]ID_Matriz:7#0)
				vsACT_AsignedMatrix:=KRL_GetTextFieldData (->[ACT_Matrices:177]ID:1;->[ACT_CuentasCorrientes:175]ID_Matriz:7;->[ACT_Matrices:177]Nombre_matriz:2)
			End if 
		Else 
			CD_Dlog (0;__ ("Esta cuenta está siendo utilizada por otro proceso. Intente cambiar la matriz más tarde"))
		End if 
	End if 
End if 