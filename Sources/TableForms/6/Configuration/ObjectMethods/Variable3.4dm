C_LONGINT:C283(hl_observaciones)
If (Not:C34(Is a list:C621(hl_observaciones)))
	hl_observaciones:=New list:C375
End if 
If (BLOB size:C605([xxSTR_Niveles:6]ObservacionesEvaluacion:22)>0)
	hl_observaciones:=BLOB to list:C557([xxSTR_Niveles:6]ObservacionesEvaluacion:22)
Else 
	hl_observaciones:=New list:C375
End if 
SET LIST PROPERTIES:C387(hl_observaciones;2;0;16;1)

WDW_OpenFormWindow (->[xxSTR_Niveles:6];"ObservacionesEvaluacion";-1;8)
DIALOG:C40([xxSTR_Niveles:6];"ObservacionesEvaluacion")
CLOSE WINDOW:C154