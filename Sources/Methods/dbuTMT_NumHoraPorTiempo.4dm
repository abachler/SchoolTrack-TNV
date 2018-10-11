//%attributes = {}
  //dbuTMT_NumHoraPorTiempo

CONFIRM:C162("Este comando puede afectar seriamente los horarios ya definidos.\r\rPor favor consu"+"lte con personal del departamento de desarollo de Colegium antes de ejecutarlo.";"Ejecutar";"Cancelar")
If (OK=1)
	C_LONGINT:C283($hora)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando Horarios..."))
	ALL RECORDS:C47([TMT_Horario:166])
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([TMT_Horario:166])
		GOTO RECORD:C242([TMT_Horario:166];$aRecNums{$i})
		$nivel:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Numero_del_Nivel:6)
		PERIODOS_LoadData ($nivel)
		$hora:=[TMT_Horario:166]Desde:3*1
		$el:=Find in array:C230(alSTR_Horario_Desde;$hora)
		If ($el>0)
			[TMT_Horario:166]NumeroHora:2:=aiSTR_Horario_HoraNo{$el}
		End if 
		SAVE RECORD:C53([TMT_Horario:166])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	LOG_RegisterEvt ("Reasignación de número de hora en base a la hora de inicio y termino de la sesión"+".")
Else 
	
End if 
