Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Self:C308->=False:C215)
			C_LONGINT:C283($resp)
			$resp:=CD_Dlog (0;__ ("Esta inactivando la regla de suspensión, los usuarios suspendidos de este grupo dejarán de estarlo. ¿Desea Continuar?");__ ("");__ ("Cancelar");__ ("Continuar"))
			
			If ($resp=1)
				Self:C308->:=True:C214
			Else 
				READ WRITE:C146([BBL_Lectores:72])
				QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Regla:4=[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;*)
				QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Fecha_Suspención:45#!00-00-00!)
				
				If (Records in selection:C76([BBL_Lectores:72])>0)
					APPLY TO SELECTION:C70([BBL_Lectores:72];[BBL_Lectores:72]Fecha_Suspención:45:=!00-00-00!)
					LOG_RegisterEvt ("Se ha quitado la regla de suspensión y han dejado de estar suspendidos "+String:C10(Records in selection:C76([BBL_Lectores:72]))+" lectores del Grupo de Reglas: "+[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2)
				End if 
				KRL_UnloadReadOnly (->[BBL_Lectores:72])
				
			End if 
			
		End if 
End case 

