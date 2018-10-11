C_POINTER:C301($nil)
C_OBJECT:C1216($jsonCondor)
ARRAY TEXT:C222($at_nombres;0)

LICENCIA_VerificaModCondorAct ("";->$jsonCondor)
OB GET PROPERTY NAMES:C1232($jsonCondor;$at_nombres;$al_Types)

If (Size of array:C274($at_nombres)>0)
	WDW_OpenFormWindow (->[xShell_Dialogs:114];"ST_aplicacionesCondor";7;5;"Colegium Cloud")
	DIALOG:C40([xShell_Dialogs:114];"ST_aplicacionesCondor")
	CLOSE WINDOW:C154
Else 
	CD_Dlog (0;"El establecimiento no tiene contratados módulos de Colegium Cloud")
End if 

