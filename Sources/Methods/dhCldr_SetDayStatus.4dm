//%attributes = {}
  //dhCldr_SetDayStatus


$feriado:=$1
$date:=$2

OK:=1
If ($feriado=1)
	OK:=CD_Dlog (0;__ ("Las eventuales informaciones conductuales o de asistencia vinculadas a esta fecha serán eliminadas si usted marca este día como no laborable.\r\r¿Desea realmente marcar este día como no laborable ?");__ ("");__ ("Si");__ ("No"))
	If (ok=1)
		vb_CambiosEnCalendario:=True:C214
		If (Application type:C494=4D Remote mode:K5:5)
			$PID:=Execute on server:C373("STRcal_FijaFeriadoLaborable";Pila_256K;"Fijando "+String:C10($date)+"como feriado.";$date;vlSTR_Periodos_CurrentRef)
		Else 
			$PID:=New process:C317("STRcal_FijaFeriadoLaborable";Pila_256K;"Fijando "+String:C10($date)+"como feriado.";$date;vlSTR_Periodos_CurrentRef)
		End if 
	End if 
Else 
	vb_CambiosEnCalendario:=True:C214
	If (($date<=Current date:C33(*)) & (Year of:C25($date)=<>gYear))
		If (Application type:C494=4D Remote mode:K5:5)
			$PID:=Execute on server:C373("STRcal_CreaSesionesClases";Pila_256K;"Creando sesiones "+String:C10($date)+".";$date)
		Else 
			$PID:=New process:C317("STRcal_CreaSesionesClases";Pila_256K;"Creando sesiones "+String:C10($date)+".";$date)
		End if 
	End if 
End if 
DELAY PROCESS:C323(Current process:C322;15)
$semaphore:=Test semaphore:C652("CambioStatus"+String:C10($date))
If ($semaphore)
	$unlimitedPid:=IT_UThermometer (1;0;__ ("Actualizando eventos calendario..."))
	While ($semaphore)
		$semaphore:=Test semaphore:C652("CambioStatus"+String:C10($date))
		DELAY PROCESS:C323(Current process:C322;15)
	End while 
	$ignore:=IT_UThermometer (-2;$unlimitedPid)
End if 
$0:=OK