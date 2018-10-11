//%attributes = {}
  //xALCB_EX_Vacunas

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;$Row)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_Vacunas)=1)
		$stop:=False:C215
		vl_ModSalud:=vl_ModSalud ?+ 4
		AL_GetCurrCell (xALP_Vacunas;$Col;$Row)
		If ($col=1)
			$separator:=Position:C15(".";aVacuna_Edad{$row})
			If ($separator=0)
				$separator:=Position:C15(",";aVacuna_Edad{$row})
				If ($separator=0)
					$separator:=Position:C15(" ";aVacuna_Edad{$row})
					If ($separator=0)
						$separator:=Position:C15("-";aVacuna_Edad{$row})
						If ($separator=0)
							$separator:=Position:C15("/";aVacuna_Edad{$row})
						End if 
					End if 
				End if 
			End if 
			
			If ($separator>0)
				$years:=Num:C11(Substring:C12(aVacuna_Edad{$row};1;$separator-1))
				$months:=Num:C11(Substring:C12(aVacuna_Edad{$row};$separator+1))
				$months:=($years*12)+$months
			Else 
				$months:=Num:C11(aVacuna_Edad{$row})
			End if 
			aVacuna_Edad{$row}:=DT_Months2AgeLongString ($months)
			aVacuna_meses{$row}:=$months
		End if 
	End if 
End if 

