C_BOOLEAN:C305($imprimir;$b_confirmTransaction)
$imprimir:=False:C215
  // MOD Ticket N° 216560 Patricio Aliaga 20180912
  // If ((Is new record([Alumnos_EventosEnfermeria])) & (cb_ticketEnfermeria=1))
If (cb_ticketEnfermeria=1)
	  //imprimo el ticket de enfermeria
	$imprimir:=True:C214
End if 

If (([Alumnos_EventosEnfermeria:14]Fecha:2#!00-00-00!) & ([Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3#?00:00:00?) & ([Alumnos_EventosEnfermeria:14]Hora_de_Salida:8#?00:00:00?) & ([Alumnos_EventosEnfermeria:14]Procedencia:4#"") & ([Alumnos_EventosEnfermeria:14]Afeccion:6#"") & ([Alumnos_EventosEnfermeria:14]Destino:9#""))
	$b_confirmTransaction:=True:C214
	START TRANSACTION:C239
	
	If ([Alumnos_EventosEnfermeria:14]ID_ProfesorIngresa:16=0)
		C_LONGINT:C283($idUser)
		$idUser:=USR_GetUserID 
		If ($idUser<0)
			  //superUsuario
			[Alumnos_EventosEnfermeria:14]ID_ProfesorIngresa:16:=$idUser
		Else 
			QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=$idUser)
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[xShell_Users:47]NoEmployee:7)
			[Alumnos_EventosEnfermeria:14]ID_ProfesorIngresa:16:=[Profesores:4]Numero:1
		End if 
	End if 
	
	ARRAY TEXT:C222($at_afeccion;0)
	If (Undefined:C82([Alumnos_EventosEnfermeria:14]OB_Afeccion:20))
		[Alumnos_EventosEnfermeria:14]OB_Afeccion:20:=OB_Create 
		APPEND TO ARRAY:C911($at_afeccion;[Alumnos_EventosEnfermeria:14]Afeccion:6)
		OB_SET ([Alumnos_EventosEnfermeria:14]OB_Afeccion:20;->$at_afeccion;"OB")
	Else 
		C_OBJECT:C1216($ob_temporal)
		$ob_temporal:=OB_Create 
		OB_GET ([Alumnos_EventosEnfermeria:14]OB_Afeccion:20;->$at_afeccion;"OB")
		If (Find in array:C230($at_afeccion;[Alumnos_EventosEnfermeria:14]Afeccion:6)=-1)
			APPEND TO ARRAY:C911($at_afeccion;[Alumnos_EventosEnfermeria:14]Afeccion:6)
			OB_SET ($ob_temporal;->$at_afeccion;"OB")
			[Alumnos_EventosEnfermeria:14]OB_Afeccion:20:=$ob_temporal
		End if 
	End if 
	
	ARRAY TEXT:C222($at_iniciaObjeto;0)
	$ob_temporal:=OB_Create 
	OB_SET ($ob_temporal;->$at_iniciaObjeto;"evolucion")
	[Alumnos_EventosEnfermeria:14]OB_evolucion:21:=$ob_temporal
	
	$ob_temporal:=OB_Create 
	OB_SET ($ob_temporal;->$at_iniciaObjeto;"medicamentos")
	[Alumnos_EventosEnfermeria:14]OB_medicamentos:22:=$ob_temporal
	
	$ob_temporal:=OB_Create 
	OB_SET ($ob_temporal;->$at_iniciaObjeto;"derivacion")
	[Alumnos_EventosEnfermeria:14]OB_derivacion:23:=$ob_temporal
	
	KRL_SaveRecord (->[Alumnos_EventosEnfermeria:14])
	
	  //MONO TICKET 203131
	If ($imprimir=True:C214)
		ARRAY LONGINT:C221($al_idTicketEnf;0)
		ARRAY TEXT:C222($at_TicketEnf;0)
		C_LONGINT:C283($l_rnReport;$l_sel)
		
		$y_objtEnf:=OBJECT Get pointer:C1124(Object named:K67:5;"ticketEnfermeria_Obj")
		$y_nomTickEnfSel:=OBJECT Get pointer:C1124(Object named:K67:5;"ticketEnfermeria_nombre")
		OB GET ARRAY:C1229($y_objtEnf->;"ticketEnfermeria_nombre";$at_TicketEnf)
		OB GET ARRAY:C1229($y_objtEnf->;"ticketEnfermeria_id";$al_idTicketEnf)
		$l_sel:=OB Get:C1224($y_objtEnf->;"ticketEnfermeria_seleccionado")
		
		$l_rnReport:=Find in field:C653([xShell_Reports:54]ID:7;$al_idTicketEnf{$l_sel})
		If ($l_rnReport=-1)
			CD_Dlog (0;__ ("El ticket ^0, no se encuentra disponible, por favor utilice otro .";$at_TicketEnf{$l_sel}))
			$b_confirmTransaction:=False:C215
		Else 
			C_POINTER:C301($ptrCurrentTable)
			$ptrCurrentTable:=yBWR_currentTable
			READ ONLY:C145(*)
			GOTO RECORD:C242([xShell_Reports:54];$l_rnReport)
			$reportName:=[xShell_Reports:54]FormName:17
			$specialConfig:=[xShell_Reports:54]SpecialParameter:18
			$tableNumber:=Abs:C99([xShell_Reports:54]MainTable:3)
			$tablePointer:=Table:C252($tableNumber)
			yBWR_currentTable:=$tablePointer
			xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
			COPY NAMED SELECTION:C331([Alumnos:2];"◊Editions")
			xSR_ReportBlob:=SRP_ValidaAjustesImpresion ($l_rnReport)  //MONO Ticket 179726 -209686
			If (ok=1)
				$err:=SR Print Report (xSR_ReportBlob;3;65535)
			End if 
			yBWR_currentTable:=$ptrCurrentTable
			
		End if 
	End if 
	
	If ($b_confirmTransaction)
		VALIDATE TRANSACTION:C240
		CANCEL:C270
	Else 
		CANCEL TRANSACTION:C241
	End if 
	
Else 
	$r:=CD_Dlog (1;__ ("La ficha de visita no puede ser grabada ya que está incompleta revise, fecha, horas, destino)."))
End if 