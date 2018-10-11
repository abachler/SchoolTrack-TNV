  //$sel:=Selected list items(Self->)
  //If ($sel>0)
  //GET LIST ITEM(Self->;$sel;$horaEnvio;$text)
  //vh_NextExecSN3:=Time(Time string(($horaEnvio-1)*60*60))
  //PREF_Set (0;"SN3Hora";String($horaEnvio))
  //End if 

$sel:=Selected list items:C379(Self:C308->)
If ($sel>0)
	GET LIST ITEM:C378(Self:C308->;$sel;$horaEnvio;$text)
	vh_NextExecSN3:=Time:C179(Time string:C180(($horaEnvio-1)*60*60))
	If (vh_NextExecSN3<Current time:C178(*))
		$vd_dateNextExecution:=Current date:C33+1
	Else 
		$vd_dateNextExecution:=Current date:C33
	End if 
	PREF_Set (0;"SN3Hora";String:C10($horaEnvio))
	$dts:=DTS_MakeFromDateTime ($vd_dateNextExecution;vh_NextExecSN3)
	  //PREF_Set (0;"SN3NextSend";String(vh_NextExecSN3))
	PREF_Set (0;"SN3NextSend";$dts)
	  //Jorge: chequeo que el proceso de envio automatico este retrasado (delay process) en el servidor
	  // si es así lo resumo para que lea la nueva preferencia que le estoy entregando en este selector, esto facilita para hacer pruebas sin tener que esperar.
	$status:=PCS_CheckProcessOnServer ("Conexión SchoolNet")
	
	If ($status=1)  //delayed
		C_TEXT:C284($vt_nameprocess)
		C_LONGINT:C283($processID)
		$vt_nameprocess:="Conexión SchoolNet"
		$processID:=Execute on server:C373("PCS_ResumeProcess";64000;"PCS_ResumeProcess";$vt_nameprocess)
	End if 
End if 