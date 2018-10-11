
$habilitaOpcionesCalculo:=False:C215
For ($i;1;Size of array:C274(alAS_EvalPropSourceID))
	If (alAS_EvalPropSourceID{$i}>0)
		$habilitaOpcionesCalculo:=True:C214
		$i:=Size of array:C274(alAS_EvalPropSourceID)
	End if 
End for 
If ($habilitaOpcionesCalculo)
	_O_ENABLE BUTTON:C192(*;"Opciones consolidacion@")
	OBJECT SET FONT STYLE:C166(*;"Opciones consolidacion";1)
	OBJECT SET COLOR:C271(*;"Opciones consolidacion@";-15)
Else 
	_O_DISABLE BUTTON:C193(*;"Opciones consolidacion@")
	OBJECT SET FONT STYLE:C166(*;"Opciones consolidacion";0)
	OBJECT SET COLOR:C271(*;"Opciones consolidacion@";-14)
End if 

GOTO OBJECT:C206(xALP_CsdList2)
If (vCol=6)
	AL_GotoCell (xALP_CsdList2;3;vRow+1)
Else 
	AL_GotoCell (xALP_CsdList2;vcol+1;vRow)
End if 
  //POST KEY(9;0)