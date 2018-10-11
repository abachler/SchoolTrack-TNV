EVS_GuardaTablaConversion 
FORM SET OUTPUT:C54([xxSTR_EstilosEvaluacion:44];"Print_TablaConversion")
C_DATE:C307(vd_fecha)
vd_fecha:=Current date:C33
PRINT RECORD:C71([xxSTR_EstilosEvaluacion:44])