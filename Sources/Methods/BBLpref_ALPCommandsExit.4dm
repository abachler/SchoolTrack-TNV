//%attributes = {}
  //BBLpref_ALPCommandsExit

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)
C_LONGINT:C283(vCol;vRow)
_O_C_STRING:C293(255;$value)

AL_GetCurrCell (xALP_CommandsConsola_BBL;vCol;vRow)
Case of 
	: (vCol=1)
		$oldValue:=<>atBBL_CommandCode{0}
		$value:=<>atBBL_CommandCode{vRow}
		<>atBBL_CommandCode{vRow}:=$oldValue
		If ($value#<>atBBL_CommandCode{0})
			If (Length:C16($value)>1)
				CD_Dlog (0;__ ("El código no puede tener más de un caracter."))
				<>atBBL_CommandCode{vRow}:=$oldValue
				AL_ExitCell (xALP_CommandsConsola_BBL)
			Else 
				<>atBBL_CommandCode{0}:=$value
				$el:=Find in array:C230(<>atBBL_CommandCode;$value)
				If ($el>0)
					CD_Dlog (0;__ ("Este código es utilizado para otro comando."))
					<>atBBL_CommandCode{vRow}:=$oldValue
					AL_ExitCell (xALP_CommandsConsola_BBL)
				Else 
					<>atBBL_CommandCode{vRow}:=$value
				End if 
				AL_UpdateArrays (xALP_CommandsConsola_BBL;-1)
			End if 
		End if 
	: (vCol=2)
		<>atBBL_Command{vRow}:=Substring:C12(<>atBBL_Command{vRow};1;30)
End case 

