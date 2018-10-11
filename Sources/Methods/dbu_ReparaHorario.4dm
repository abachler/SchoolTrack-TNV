//%attributes = {}
  //dbu_ReparaHorario

$pID:=IT_UThermometer (1;0;__ ("Verificando horario..."))
PERIODOS_Init 
ALL RECORDS:C47([TMT_Horario:166])

SELECTION TO ARRAY:C260([TMT_Horario:166];$aRecNums)
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([TMT_Horario:166])
	GOTO RECORD:C242([TMT_Horario:166];$aRecNums{$i})
	RELATE ONE:C42([TMT_Horario:166]ID_Asignatura:5)
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	If ([TMT_Horario:166]NumeroHora:2>0)
		If (Size of array:C274(alSTR_Horario_Desde)>=[TMT_Horario:166]NumeroHora:2)
			[TMT_Horario:166]Desde:3:=alSTR_Horario_Desde{[TMT_Horario:166]NumeroHora:2}
			[TMT_Horario:166]Hasta:4:=alSTR_Horario_Hasta{[TMT_Horario:166]NumeroHora:2}
		End if 
	End if 
	SAVE RECORD:C53([TMT_Horario:166])
End for 

$pID:=IT_UThermometer (-2;$pID;__ ("Verificando horario..."))