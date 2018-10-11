//%attributes = {}
  //ACT_OnRightClick

$col:=AL_GetColumn (xALP_Browser)
If ($col=10)
	If (Size of array:C274(alBWR_RecordNumber)>0)
		hl_años:=New list:C375
		hl_meses:=New list:C375
		ARRAY TEXT:C222(aMeses;12)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		APPEND TO LIST:C376(hl_años;"No calcular";9999)
		For ($r;2005;Year of:C25(Current date:C33(*))+1)
			hl_meses:=New list:C375
			For ($t;1;12)
				APPEND TO LIST:C376(hl_meses;<>atXS_MonthNames{$t};$t)
				$StrRef:=String:C10($r)+String:C10($t)
				$ref:=Num:C11($StrRef)
				GET LIST ITEM:C378(hl_meses;$t;$itemRef;$itemText)
				SET LIST ITEM:C385(hl_meses;$itemRef;$itemText;$ref)
			End for 
			APPEND TO LIST:C376(hl_años;String:C10($r);$r;hl_meses;False:C215)
		End for 
		$selected:=HL_ShowHListPopWindow (hl_años;"Seleccione Período...";7)
		If (($selected#0) & ($selected#9999))
			$selectedStr:=String:C10($selected)
			$selectedMonth:=Num:C11(Substring:C12($selectedStr;5))
			$selectedYear:=Num:C11(Substring:C12($selectedStr;1;4))
			If (($selectedMonth#0) & ($selectedYear#0))
				If (($selectedMonth=Month of:C24(Current date:C33(*))) & ($selectedYear=Year of:C25(Current date:C33(*))))
					AL_SetHeaders (xALP_Browser;$col;1;__ ("Proyectado\rMes en Curso"))
				Else 
					AL_SetHeaders (xALP_Browser;$col;1;__ ("Proyectado\r")+<>atXS_MonthNames{$selectedMonth}+" "+String:C10($selectedYear))
				End if 
				$recs:=Size of array:C274(alBWR_recordNumber)
				$arrayProyMes:=Get pointer:C304(atBWR_ArrayNames{$col})
				PREF_Set (<>lUSR_CurrentUserID;"ACTcc_MesProyectado";String:C10($selectedMonth))
				PREF_Set (<>lUSR_CurrentUserID;"ACTcc_AñoProyectado";String:C10($selectedYear))
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando proyectado para el mes de ")+<>atXS_MonthNames{$selectedMonth}+__ (" de ")+String:C10($selectedYear)+__ ("..."))
				For ($i;1;$recs)
					READ ONLY:C145([ACT_CuentasCorrientes:175])
					READ ONLY:C145([ACT_Cargos:173])
					GOTO RECORD:C242([ACT_CuentasCorrientes:175];alBWR_recordNumber{$i})
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$selectedMonth;*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$selectedYear)
					  //$arrayProyMes->{$i}:=Sum([ACT_Cargos]Monto_Neto)+Sum([ACT_Cargos]Intereses)
					  //$arrayProyMes->{$i}:=Sum([ACT_Cargos]Monto_Neto)
					$arrayProyMes->{$i}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$recs;__ ("Calculando proyectado para el mes de ")+<>atXS_MonthNames{$selectedMonth}+__ (" de ")+String:C10($selectedYear)+__ ("..."))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
				AL_UpdateArrays (xALP_Browser;-1)
			Else 
				If (($selectedMonth=0) & ($selectedYear#0))
					PREF_Set (<>lUSR_CurrentUserID;"ACTcc_MesProyectado";String:C10($selectedMonth))
					PREF_Set (<>lUSR_CurrentUserID;"ACTcc_AñoProyectado";String:C10($selectedYear))
					AL_SetHeaders (xALP_Browser;$col;1;"Proyectado\r"+"Año "+String:C10($selectedYear))
					$recs:=Size of array:C274(alBWR_recordNumber)
					$arrayProyMes:=Get pointer:C304(atBWR_ArrayNames{$col})
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando proyectado para el año ")+String:C10($selectedYear)+__ ("..."))
					For ($i;1;$recs)
						READ ONLY:C145([ACT_CuentasCorrientes:175])
						READ ONLY:C145([ACT_Cargos:173])
						GOTO RECORD:C242([ACT_CuentasCorrientes:175];alBWR_recordNumber{$i})
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$selectedYear)
						  //$arrayProyMes->{$i}:=Sum([ACT_Cargos]Monto_Neto)+Sum([ACT_Cargos]Intereses)
						  //$arrayProyMes->{$i}:=Sum([ACT_Cargos]Monto_Neto)
						$arrayProyMes->{$i}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$recs;__ ("Calculando proyectado para el año ")+String:C10($selectedYear)+__ ("..."))
					End for 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
					AL_UpdateArrays (xALP_Browser;-1)
				End if 
			End if 
		Else 
			If ($selected=9999)
				$arrayProyMes:=Get pointer:C304(atBWR_ArrayNames{$col})
				dummy:=0
				AT_Populate ($arrayProyMes;->dummy)
				AL_SetHeaders (xALP_Browser;$col;1;"Proyectado\rPara Período...")
				AL_UpdateArrays (xALP_Browser;-1)
				PREF_Set (<>lUSR_CurrentUserID;"ACTcc_MesProyectado";String:C10(dummy))
				PREF_Set (<>lUSR_CurrentUserID;"ACTcc_AñoProyectado";String:C10(dummy))
			End if 
		End if 
	End if 
End if 

HL_ClearList (hl_meses;hl_años)