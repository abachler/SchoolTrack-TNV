//%attributes = {}
  //ACTcfg_OpenYear

$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	If (<>vtXS_CountryCode="cl")
		C_BLOB:C604(xBlob)
		C_DATE:C307($vd_Fecha)
		ARRAY INTEGER:C220(aiACT_YearIPC;0)
		ARRAY TEXT:C222(atACT_MesIPC;0)
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		
		$vd_Fecha:=Add to date:C393(Current date:C33(*);0;1;0)
		
		If (Count parameters:C259=1)
			$vl_year:=$1
		Else 
			$vl_year:=Year of:C25($vd_Fecha)
		End if 
		
		For ($years;2002;$vl_year)  //NO CAMBIAR EL 2002!!!
			$lastMonth:=12
			For ($i;1;$lastMonth)
				$month:=$i
				$year:=$years
				Case of 
					: ($month=1)
						xBlob:=PREF_fGetBlob (0;"ACT_IPC "+String:C10($year-1);xBlob)
						BLOB_Blob2Vars (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
						$ipc1:=arACT_VariacionIPC{11}/100
						$ipc2:=arACT_VariacionIPC{12}/100
						$fechaInicioPeriodo1:=DT_GetDateFromDayMonthYear (9;12;$year-1)
						$fechaInicioPeriodo2:=DT_GetDateFromDayMonthYear (9;1;$year)
						$ufRef1:=arACT_UFReferencia{12}
						xBlob:=PREF_fGetBlob (0;"ACT_IPC "+String:C10($year);xBlob)
						BLOB_Blob2Vars (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
						$ufRef2:=arACT_UFReferencia{1}
					: ($month=2)
						xBlob:=PREF_fGetBlob (0;"ACT_IPC "+String:C10($year-1);xBlob)
						BLOB_Blob2Vars (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
						$ipc1:=arACT_VariacionIPC{12}/100
						xBlob:=PREF_fGetBlob (0;"ACT_IPC "+String:C10($year);xBlob)
						BLOB_Blob2Vars (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
						$ipc2:=arACT_VariacionIPC{1}/100
						$fechaInicioPeriodo1:=DT_GetDateFromDayMonthYear (9;$month-1;$year)
						$fechaInicioPeriodo2:=DT_GetDateFromDayMonthYear (9;$month;$year)
						$ufRef1:=arACT_UFReferencia{1}
						$ufRef2:=arACT_UFReferencia{2}
					Else 
						xBlob:=PREF_fGetBlob (0;"ACT_IPC "+String:C10($year);xBlob)
						BLOB_Blob2Vars (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
						$ipc1:=arACT_VariacionIPC{$i-2}/100
						$ipc2:=arACT_VariacionIPC{$i-1}/100
						$ufRef1:=arACT_UFReferencia{$i-1}
						$ufRef2:=arACT_UFReferencia{$i}
						$fechaInicioPeriodo1:=DT_GetDateFromDayMonthYear (9;$month-1;$year)
						$fechaInicioPeriodo2:=DT_GetDateFromDayMonthYear (9;$month;$year)
				End case 
				
				$currentUFRef:="ACT_UF/"+String:C10($year)+"/"+String:C10($month;"00")
				
				$days:=DT_GetLastDay ($month;$year)
				ARRAY INTEGER:C220(aiACT_DiaUF;$days)
				ARRAY REAL:C219(arACT_ValorUF;$days)
				For ($k;1;$days)
					aiACT_DiaUF{$k}:=$k
					$currentDate:=DT_GetDateFromDayMonthYear ($k;$month;$year)
					Case of 
						: ($k<9)
							$uf:=ACTutl_CalculaUF ($currentDate;$fechaInicioPeriodo1;$ufRef1;$Ipc1)
							$dias:=$currentdate-$fechaInicioPeriodo1
							$fechaTerminoPeriodo:=$fechaInicioPeriodo1+32
							$fechaTerminoPeriodo:=DT_GetDateFromDayMonthYear (9;Month of:C24($fechaTerminoPeriodo);Year of:C25($fechaTerminoPeriodo))
							$d:=$fechaTerminoPeriodo-$fechaInicioPeriodo1
							$factor1:=Exp:C21(Log:C22(1+$ipc1)/$d)
							arACT_ValorUF{$k}:=Round:C94($ufRef1*(Round:C94($factor1;16)^$dias);2)
							ACTmon_ActualizaValor (-6;$year;$month;$k;arACT_ValorUF{$k})
						: ($k=9)
							$uf:=ACTutl_CalculaUF ($currentDate;$fechaInicioPeriodo1;$ufRef1;$Ipc1)
							arACT_ValorUF{$k}:=Round:C94($ufRef1*(1+($ipc1));2)
							ACTmon_ActualizaValor (-6;$year;$month;$k;arACT_ValorUF{$k})
							If ($uf#arACT_UFReferencia{$month})
								arACT_UFReferencia{$month}:=$uf
								SET BLOB SIZE:C606(xBlob;0)
								BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
								PREF_SetBlob (0;"ACT_IPC "+String:C10(Year of:C25($currentDate));xBlob)
							End if 
						Else 
							$uf:=ACTutl_CalculaUF ($currentDate;$fechaInicioPeriodo2;$ufRef2;$ipc2)
							$dias:=$currentdate-$fechaInicioPeriodo2
							$fechaTerminoPeriodo:=$fechaInicioPeriodo2+32
							$fechaTerminoPeriodo:=DT_GetDateFromDayMonthYear (9;Month of:C24($fechaTerminoPeriodo);Year of:C25($fechaTerminoPeriodo))
							$d:=$fechaTerminoPeriodo-$fechaInicioPeriodo2
							$factor1:=Exp:C21(Log:C22(1+$ipc2)/$d)
							arACT_ValorUF{$k}:=Round:C94($ufRef2*(Round:C94($factor1;16)^$dias);2)
							ACTmon_ActualizaValor (-6;$year;$month;$k;arACT_ValorUF{$k})
					End case 
				End for 
				SET BLOB SIZE:C606(xBlob;0)
				BLOB_Variables2Blob (->xBlob;0;->aiACT_DiaUF;->arACT_ValorUF)
				PREF_SetBlob (0;$currentUFRef;xBlob)
				SET BLOB SIZE:C606(xBlob;0)
			End for 
		End for 
		
		  //20141118 RCH Actualiza valores de tabla de paridad
		If ($vl_year>=Year of:C25(Current date:C33(*)))
			READ WRITE:C146([xxACT_MonedaParidad:147])
			QUERY:C277([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Fecha:12>DT_GetDateFromDayMonthYear (31;12;$vl_year))
			APPLY TO SELECTION:C70([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Valor:6:=arACT_ValorUF{Size of array:C274(arACT_ValorUF)})
			KRL_UnloadReadOnly (->[xxACT_MonedaParidad:147])
		End if 
		
		SET BLOB SIZE:C606(xBlob;0)
	End if 
End if 