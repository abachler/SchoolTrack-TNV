//%attributes = {}
  //xALCB_EX_Delegados

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;vRow)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_Delegados)=1)
		$stop:=False:C215
		AL_GetCurrCell (xALP_Delegados;$Col;vRow)
		vb_ModDelegados:=True:C214
		Case of 
			: ($col=1)
				C_TEXT:C284($text)
				$text:=at_CUDelegacionDelegado{vRow}
				$text:=TBL_GetValue (-><>at_Delegaciones;->$text;"Comités de curso")
				at_CUDelegacionDelegado{vRow}:=$text
				AL_SetEnterable (xALP_Delegados;1;3;<>at_Delegaciones)
				AL_UpdateArrays (xALP_Delegados;-2)
			: ($col=2)
				If (at_CUNameDelegado{vRow}#"")
					$value:=at_CUNameDelegado{vRow}+"@"
					If ($value#"")
						ARRAY TEXT:C222(aText1;0)
						$el:=Find in array:C230(at_CUApoderados;$value)
						If ($el>0)
							INSERT IN ARRAY:C227(aText1;1)
							aText1{1}:=at_CUApoderados{$el}
							For ($i;$el+1;Size of array:C274(at_CUApoderados))
								If (at_CUApoderados{$i}=$value)
									INSERT IN ARRAY:C227(aText1;Size of array:C274(atext1)+1;1)
									aText1{Size of array:C274(atext1)}:=at_CUApoderados{$i}
								Else 
									$i:=Size of array:C274(at_CUApoderados)
								End if 
							End for 
						End if 
						Case of 
							: (Size of array:C274(aText1)=0)
								CD_Dlog (0;__ ("Persona inexistente."))
								at_CUNameDelegado{vRow}:=""
								AL_UpdateArrays (xALP_Delegados;-1)
							: (Size of array:C274(aText1)=1)
								at_CUNameDelegado{vRow}:=aText1{1}
								  //AL_UpdateArrays (xALP_Delegados;-1)
								POST KEY:C465(Character code:C91("*");256)
							: (Size of array:C274(aText1)>1)
								POST KEY:C465(Character code:C91("*");256)
						End case 
					End if 
				End if 
		End case 
	End if 
End if 
