//%attributes = {}
  //ACTcfg_RecalcUF

C_BLOB:C604(xBlob)

SET BLOB SIZE:C606(xBlob;0)
BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
PREF_SetBlob (0;"ACT_IPC "+String:C10(vl_lastYear);xBlob)
SET BLOB SIZE:C606(xBlob;0)

$monthName:=atACT_MesIPC{1}
$year:=aiACT_YearIPC{1}
$ipc:=arACT_VariacionIPC{1}
$monthNumber:=Find in array:C230(<>atXS_MonthNames;$monthName)
$monthtodisplay:=Month of:C24(Current date:C33(*))
$yeartodisplay:=Year of:C25(Current date:C33(*))

Case of 
	: ($monthNumber=11)
		$Month1:=12
		$year1:=$year
		$Month2:=1
		$year2:=$year+1
	: ($monthNumber=12)
		$monthtodisplay:=1
		$yeartodisplay:=$year+1
		$Month1:=1
		$year1:=$year+1
		$Month2:=2
		$year2:=$year+1
	Else 
		$Month1:=$monthNumber+1
		$Month2:=$monthNumber+2
		$year1:=$year
		$year2:=$year
End case 
$numberOfDays:=DT_GetLastDay ($monthNumber;$year)

$currentUFRef:="ACT_UF/"+String:C10($year)+"/"+String:C10($monthNumber;"00")

ARRAY INTEGER:C220(aiACT_DiaUF;0)
ARRAY REAL:C219(arACT_ValorUF;0)

READ ONLY:C145([xShell_Prefs:46])
QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
QUERY:C277([xShell_Prefs:46]; & ;[xShell_Prefs:46]Reference:1=("ACT_UF/@");*)
QUERY:C277([xShell_Prefs:46]; & ;[xShell_Prefs:46]Reference:1>=$currentUFRef)
SELECTION TO ARRAY:C260([xShell_Prefs:46]Reference:1;atACT_UFReference)
xBlob:=PREF_fGetBlob (0;$currentUFRef)
If (BLOB size:C605(xBlob)>0)
	BLOB_Blob2Vars (->xBlob;0;->aiACT_DiaUF;->arACT_ValorUF)
End if 
$lastUFValue:=arACT_ValorUF{Size of array:C274(arACT_ValorUF)}

AL_UpdateArrays (xALP_IPC;0)

$currentUFRef:="ACT_UF/"+String:C10($year1)+"/"+String:C10($month1;"00")
READ ONLY:C145([xShell_Prefs:46])
QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
QUERY:C277([xShell_Prefs:46]; & ;[xShell_Prefs:46]Reference:1=("ACT_UF/@");*)
QUERY:C277([xShell_Prefs:46]; & ;[xShell_Prefs:46]Reference:1>=$currentUFRef)
ORDER BY:C49([xShell_Prefs:46];[xShell_Prefs:46]Reference:1;>)
SELECTION TO ARRAY:C260([xShell_Prefs:46]Reference:1;atACT_UFReference)
For ($tablasUF;1;Size of array:C274(atACT_UFReference))
	$currentUFRef:=atACT_UFReference{$tablasUF}
	xBlob:=PREF_fGetBlob (0;atACT_UFReference{$tablasUF})
	If (BLOB size:C605(xBlob)>0)
		BLOB_Blob2Vars (->xBlob;0;->aiACT_DiaUF;->arACT_ValorUF)
	End if 
	
	$month:=Num:C11(ST_GetWord ($currentUFRef;3;"/"))
	$year:=Num:C11(ST_GetWord ($currentUFRef;2;"/"))
	
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
			  //$ufRef2:=arACT_UFReferencia{1}
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
			$ipc1:=arACT_VariacionIPC{$month-2}/100
			$ipc2:=arACT_VariacionIPC{$month-1}/100
			$ufRef1:=arACT_UFReferencia{$month-1}
			$ufRef2:=arACT_UFReferencia{$month}
			$fechaInicioPeriodo1:=DT_GetDateFromDayMonthYear (9;$month-1;$year)
			$fechaInicioPeriodo2:=DT_GetDateFromDayMonthYear (9;$month;$year)
	End case 
	
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
				arACT_ValorUF{$k}:=Round:C94($ufRef1*(1+$Ipc1);2)
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
				$ufRef2:=arACT_UFReferencia{$month}
				arACT_ValorUF{$k}:=Round:C94($ufRef2*(Round:C94($factor1;16)^$dias);2)
				ACTmon_ActualizaValor (-6;$year;$month;$k;arACT_ValorUF{$k})
		End case 
	End for 
	  // end
	SET BLOB SIZE:C606(xBlob;0)
	BLOB_Variables2Blob (->xBlob;0;->aiACT_DiaUF;->arACT_ValorUF)
	PREF_SetBlob (0;$currentUFRef;xBlob)
	SET BLOB SIZE:C606(xBlob;0)
	
End for 

  //READ ONLY([xShell_Prefs])
  //QUERY([xShell_Prefs];[xShell_Prefs]User=0)
  //QUERY([xShell_Prefs]; & ;[xShell_Prefs]Reference="ACT_UF/@")
  //SELECTION TO ARRAY([xShell_Prefs]Reference;atACT_UFReference)
  //SORT ARRAY(atACT_UFReference;>)
  //ARRAY TEXT(atACT_UFLabel;Size of array(atACT_UFReference))
  //STRING LIST TO ARRAY(20109;$aMeses)
  //For ($i;1;Size of array(atACT_UFReference))
  //$mes:=Num(ST_GetWord (atACT_UFReference{$i};3;"/"))
  //$year:=Num(ST_GetWord (atACT_UFReference{$i};2;"/"))
  //atACT_UFLabel{$i}:=$aMeses{$mes}+" "+String($year)
  //End for 
  //$currentUFRef:="ACT_UF/"+String($yeartodisplay)+"/"+String($monthtodisplay;"00")
  //atACT_UFLabel:=Find in array(atACT_UFReference;$currentUFRef)
  //REDRAW WINDOW
  //vi_LastUFMonth:=atACT_UFLabel
  //xBlob:=PREF_fGetBlob (0;$currentUFRef;xBlob)
  //BLOB_Blob2Vars (->xBlob;0;->aiACT_DiaUF;->arACT_ValorUFstored)
  //COPY ARRAY(arACT_ValorUFstored;arACT_ValorUF)
  //For ($i;1;Size of array(arACT_ValorUF))
  //arACT_ValorUF{$i}:=Round(arACT_ValorUFstored{$i};2)
  //End for 
  //SET BLOB SIZE(xBlob;0)
  //AL_UpdateArrays (xALP_UF;-2)

  //20141118 RCH Actualizo valores de tabla de paridad
If ($year>=Year of:C25(Current date:C33(*)))
	READ WRITE:C146([xxACT_MonedaParidad:147])
	QUERY:C277([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Fecha:12>DT_GetDateFromDayMonthYear (31;12;$year))
	APPLY TO SELECTION:C70([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Valor:6:=arACT_ValorUF{Size of array:C274(arACT_ValorUF)})
	KRL_UnloadReadOnly (->[xxACT_MonedaParidad:147])
End if 

alACT_IPCYears:=Find in array:C230(alACT_IPCYears;vl_LastYear)
xBlob:=PREF_fGetBlob (0;"ACT_IPC "+String:C10(vl_LastYear);xBlob)
If (BLOB size:C605(xBlob)>0)
	BLOB_Blob2Vars (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
	For ($i;1;12)
		aiACT_YearIPC{$i}:=vl_LastYear
	End for 
Else 
	COPY ARRAY:C226(<>atXS_MonthNames;atACT_MesIPC)
	ARRAY INTEGER:C220(aiACT_YearIPC;0)
	ARRAY TEXT:C222(atACT_MesIPC;0)
	ARRAY REAL:C219(arACT_VariacionIPC;0)
	ARRAY INTEGER:C220(aiACT_YearIPC;12)
	ARRAY TEXT:C222(atACT_MesIPC;12)
	ARRAY REAL:C219(arACT_VariacionIPC;12)
	For ($i;1;12)
		aiACT_YearIPC{$i}:=$currentyear
	End for 
	BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
	PREF_SetBlob (0;"ACT_IPC "+String:C10($currentyear);xBlob)
	SET BLOB SIZE:C606(xBlob;0)
End if 
alACT_IPCYears:=Find in array:C230(alACT_IPCYears;vl_LastYear)
AL_UpdateArrays (xALP_IPC;-2)
AL_UpdateArrays (xALP_Divisas;0)

  //$posUF:=Find in array(atACT_NombreMoneda;"UF")
  //$currentUFRef:="ACT_UF/"+String(Year of(Current date(*)))+"/"+String(Month of(Current date(*));"00")
  //xBlob:=PREF_fGetBlob (0;$currentUFRef;xBlob)
  //BLOB_Blob2Vars (->xBlob;0;->aiACT_DiaUF;->arACT_ValorUFstored)
  //arACT_ValorMoneda{$posUF}:=arACT_ValorUFstored{Day of(Current date(*))}
  //AL_UpdateArrays (xALP_Divisas;-2)

  //ACTcfg_ColorUndelDivisas 
ACTcfgmyt_OpcionesGenerales ("RecalculaUF")
  //ACTut_CargaUF ("ActualizaUF")