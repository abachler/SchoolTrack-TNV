GET LIST ITEM:C378(hl_Schedule;Selected list items:C379(hl_Schedule);$ref;$text)
PREF_Set (0;"SN3Schedule";String:C10($ref))

OBJECT SET VISIBLE:C603(*;"textohora";False:C215)
OBJECT SET VISIBLE:C603(vh_NextExecSN3;True:C214)
Case of 
	: ($ref=1)
		vh_NextExecSN3:=Current time:C178(*)+?02:00:00?
		OBJECT SET VISIBLE:C603(hl_Hora;False:C215)
	: ($ref=2)
		vh_NextExecSN3:=Current time:C178(*)+?04:00:00?
		OBJECT SET VISIBLE:C603(hl_Hora;False:C215)
		  //: ($ref=-1)
	: ($ref=-5)
		OBJECT SET VISIBLE:C603(vh_NextExecSN3;False:C215)
		OBJECT SET VISIBLE:C603(*;"textohora";True:C214)
		OBJECT SET VISIBLE:C603(hl_Hora;False:C215)
	: ($ref=-2)
		OBJECT SET VISIBLE:C603(hl_Hora;True:C214)
		$horaEnvio:=1
		$horaEnvio:=Num:C11(PREF_fGet (0;"SN3Hora";String:C10($horaEnvio)))
		vh_NextExecSN3:=Time:C179(Time string:C180(($horaEnvio-1)*60*60))
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Hora;$horaEnvio)
End case 


  //JVP 28072016
  //valido para que las horas esten correctas
If (vh_NextExecSN3>?24:00:00?)
	vh_NextExecSN3:=vh_NextExecSN3-?24:00:00?
	$vd_dateNextExecution:=Current date:C33+1
Else 
	vh_NextExecSN3:=vh_NextExecSN3
	
	If (vh_NextExecSN3<Current time:C178(*))
		$vd_dateNextExecution:=Current date:C33+1
	Else 
		$vd_dateNextExecution:=Current date:C33
	End if 
End if 
$dts:=DTS_MakeFromDateTime ($vd_dateNextExecution;vh_NextExecSN3)
PREF_Set (0;"SN3NextSend";$dts)  //Ticket 202688
  //PREF_Set (0;"SN3NextSend";String(vh_NextExecSN3))

  //Jorge: chequeo que el proceso de envio automatico este retrasado (delay process) en el servidor
  // si es así lo resumo para que lea la nueva preferencia que le estoy entregando en este selector, esto facilita para hacer pruebas sin tener que esperar.
$status:=PCS_CheckProcessOnServer ("Conexión SchoolNet")

If ($status=1)  //delayed
	C_TEXT:C284($vt_nameprocess)
	C_LONGINT:C283($processID)
	$vt_nameprocess:="Conexión SchoolNet"
	$processID:=Execute on server:C373("PCS_ResumeProcess";64000;"PCS_ResumeProcess";$vt_nameprocess)
End if 