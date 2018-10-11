C_LONGINT:C283(lb_col;lb_line)
C_BOOLEAN:C305($guardar)
If (Form event:C388=On Clicked:K2:4)
	LISTBOX GET CELL POSITION:C971(EvtAsigbloqueo_LB;lb_col;lb_line)
	LISTBOX SELECT ROW:C912(EvtAsigbloqueo_LB;lb_line)
End if 
If (Form event:C388=On Data Change:K2:15)
	Case of 
		: (lb_col=2)  //bloqueo diario
			If ((al_EvtCalMaxDay{lb_line}>al_EvtCalMaxWeek{lb_line}) & (al_EvtCalMaxDay{lb_line}>=0))
				CD_Dlog (0;__ ("No puede ingresar un valor superior al máximo semanal."))
				$guardar:=False:C215
			Else 
				$guardar:=True:C214
			End if 
			
		: (lb_col=3)  //bloqueo semanal
			If ((al_EvtCalMaxDay{lb_line}>al_EvtCalMaxWeek{lb_line}) & (al_EvtCalMaxWeek{lb_line}>=0))
				CD_Dlog (0;__ ("No puede ingresar un valor inferior el máximo diario."))
				$guardar:=False:C215
			Else 
				$guardar:=True:C214
			End if 
			
	End case 
	
	If ($guardar)
		BLOB_Variables2Blob (->[xxSTR_Niveles:6]xEventoCalendario:53;0;->at_EvtCalTipo;->al_EvtCalMaxDay;->al_EvtCalMaxWeek)
	Else 
		BLOB_Blob2Vars (->[xxSTR_Niveles:6]xEventoCalendario:53;0;->at_EvtCalTipo;->al_EvtCalMaxDay;->al_EvtCalMaxWeek)
	End if 
	
End if 