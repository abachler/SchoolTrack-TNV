//%attributes = {}
  //dbuTMT_TiemposPorNumHora

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando Horarios..."))
ALL RECORDS:C47([TMT_Horario:166])
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([TMT_Horario:166];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([TMT_Horario:166])
	GOTO RECORD:C242([TMT_Horario:166];$aRecNums{$i})
	$nivel:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Numero_del_Nivel:6)
	PERIODOS_LoadData ($nivel)
	$el:=Find in array:C230(aiSTR_Horario_HoraNo;[TMT_Horario:166]NumeroHora:2)
	If ($el>0)
		[TMT_Horario:166]Desde:3:=alSTR_Horario_Desde{$el}
		[TMT_Horario:166]Hasta:4:=alSTR_Horario_hasta{$el}
	End if 
	SAVE RECORD:C53([TMT_Horario:166])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)