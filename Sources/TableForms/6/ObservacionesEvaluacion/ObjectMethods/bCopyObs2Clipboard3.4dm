HL_ClearList (hl_observaciones)
hl_observaciones:=New list:C375
LIST TO BLOB:C556(hl_observaciones;[xxSTR_Niveles:6]ObservacionesEvaluacion:22)
SAVE RECORD:C53([xxSTR_Niveles:6])
