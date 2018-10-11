//%attributes = {}
  //xALP_ADT_EX_JornadasVisita

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($col;$row;$idJornadaI)
C_TEXT:C284($idJornadaT;$lugar;$dia;$horaT)
C_DATE:C307($day)
C_LONGINT:C283($hora)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	
	AL_GetCurrCell (xALP_JornadasVisita;$col;$row)
	AL_GetCellValue (xALP_JornadasVisita;$row;6;$idJornadaT)
	$idJornadaI:=Num:C11($idJornadaT)
	
	Case of 
		: ($col=5)  //lugar
			  //si es la columna del lugar, valido que para una misma hora y lugar no se tenga el mismo lugar
			
			AL_GetCellValue (xALP_JornadasVisita;$row;5;$lugar)
			
			READ ONLY:C145([ADT_JornadasVisita:144])
			QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Place:4=$lugar)
			
			If (Records in selection:C76([ADT_JornadasVisita:144])>0)
				  //por si ya hay un registro con el mismo lugar, verificar que no tenga la misma hora y lugar
				QUERY SELECTION:C341([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Date_Jornada:2=adPST_DateJornada{$row})
				$time:=Time string:C180(aiPST_HoraJornada{$row})
				$time2:=Time:C179($time)
				QUERY SELECTION:C341([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Hora_Jornada:3=$time2)
				
				If (Records in selection:C76([ADT_JornadasVisita:144])=0)
					  //si no hay registros en seleccion, guardo el lugar de la jornada
					READ WRITE:C146([ADT_JornadasVisita:144])
					QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaI)
					
					[ADT_JornadasVisita:144]Section:5:=atPST_SeccionJornada{$row}
					[ADT_JornadasVisita:144]Date_Jornada:2:=adPST_DateJornada{$row}
					[ADT_JornadasVisita:144]Hora_Jornada:3:=aiPST_HoraJornada{$row}
					[ADT_JornadasVisita:144]Place:4:=atPST_LugarJornada{$row}
					SAVE RECORD:C53([ADT_JornadasVisita:144])
					KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
				Else 
					  //de lo contrario, no se puede don jornadas con el mismo lugar en el mismo dia y la misma hora
					$time:=Time string:C180(aiPST_HoraJornada{$row})
					$time2:=Time:C179($time)
					If (($time2=?00:00:00?) | (adPST_DateJornada{$row}=!00-00-00!))
						  //si no hay registros en seleccion, guardo el lugar de la jornada
						READ WRITE:C146([ADT_JornadasVisita:144])
						QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaI)
						
						[ADT_JornadasVisita:144]Section:5:=atPST_SeccionJornada{$row}
						[ADT_JornadasVisita:144]Date_Jornada:2:=adPST_DateJornada{$row}
						[ADT_JornadasVisita:144]Hora_Jornada:3:=aiPST_HoraJornada{$row}
						[ADT_JornadasVisita:144]Place:4:=atPST_LugarJornada{$row}
						SAVE RECORD:C53([ADT_JornadasVisita:144])
						KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
					Else 
						CD_Dlog (1;__ ("No es posible tener una Jornada de Visita en un mismo dia, hora y lugar"))
						STRcfg_ActualizarJornadaVisita 
					End if 
				End if 
				
			Else 
				READ WRITE:C146([ADT_JornadasVisita:144])
				QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaI)
				
				[ADT_JornadasVisita:144]Section:5:=atPST_SeccionJornada{$row}
				[ADT_JornadasVisita:144]Date_Jornada:2:=adPST_DateJornada{$row}
				[ADT_JornadasVisita:144]Hora_Jornada:3:=aiPST_HoraJornada{$row}
				[ADT_JornadasVisita:144]Place:4:=atPST_LugarJornada{$row}
				SAVE RECORD:C53([ADT_JornadasVisita:144])
				KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
			End if 
		: ($col=2)  //dia
			AL_GetCellValue (xALP_JornadasVisita;$row;2;$dia)
			$day:=Date:C102($dia)
			
			READ ONLY:C145([ADT_JornadasVisita:144])
			QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Date_Jornada:2=$day)
			
			If (Records in selection:C76([ADT_JornadasVisita:144])>0)
				  //ya hay una jornada registrada en ese dia, verificar que no sea la misma hora y lugar que se intenta ingresar
				QUERY SELECTION:C341([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Place:4=atPST_LugarJornada{$row})
				$time:=Time string:C180(aiPST_HoraJornada{$row})
				$time2:=Time:C179($time)
				QUERY SELECTION:C341([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Hora_Jornada:3=$time2)
				
				If (Records in selection:C76([ADT_JornadasVisita:144])=0)
					  //si no hay registros en seleccion, guardo el lugar de la jornada
					READ WRITE:C146([ADT_JornadasVisita:144])
					QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaI)
					
					[ADT_JornadasVisita:144]Section:5:=atPST_SeccionJornada{$row}
					[ADT_JornadasVisita:144]Date_Jornada:2:=adPST_DateJornada{$row}
					[ADT_JornadasVisita:144]Hora_Jornada:3:=aiPST_HoraJornada{$row}
					[ADT_JornadasVisita:144]Place:4:=atPST_LugarJornada{$row}
					SAVE RECORD:C53([ADT_JornadasVisita:144])
					KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
				Else 
					  //de lo contrario, no se puede don jornadas con el mismo lugar en el mismo dia y la misma hora
					$time:=Time string:C180(aiPST_HoraJornada{$row})
					$time2:=Time:C179($time)
					If (($time2=?00:00:00?) | (atPST_LugarJornada{$row}=""))
						READ WRITE:C146([ADT_JornadasVisita:144])
						QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaI)
						
						[ADT_JornadasVisita:144]Section:5:=atPST_SeccionJornada{$row}
						[ADT_JornadasVisita:144]Date_Jornada:2:=adPST_DateJornada{$row}
						[ADT_JornadasVisita:144]Hora_Jornada:3:=aiPST_HoraJornada{$row}
						[ADT_JornadasVisita:144]Place:4:=atPST_LugarJornada{$row}
						SAVE RECORD:C53([ADT_JornadasVisita:144])
						KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
					Else 
						CD_Dlog (1;__ ("No es posible tener una Jornada de Visita en un mismo dia, hora y lugar"))
						STRcfg_ActualizarJornadaVisita 
					End if 
				End if 
				
			Else 
				READ WRITE:C146([ADT_JornadasVisita:144])
				QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaI)
				
				[ADT_JornadasVisita:144]Section:5:=atPST_SeccionJornada{$row}
				[ADT_JornadasVisita:144]Date_Jornada:2:=adPST_DateJornada{$row}
				[ADT_JornadasVisita:144]Hora_Jornada:3:=aiPST_HoraJornada{$row}
				[ADT_JornadasVisita:144]Place:4:=atPST_LugarJornada{$row}
				SAVE RECORD:C53([ADT_JornadasVisita:144])
				KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
			End if 
		: ($col=3)  //hora
			AL_GetCellValue (xALP_JornadasVisita;$row;3;$horaT)
			$time2:=Time:C179($horaT)
			
			READ ONLY:C145([ADT_JornadasVisita:144])
			QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Hora_Jornada:3=$time2)
			
			If (Records in selection:C76([ADT_JornadasVisita:144])>0)
				  //ya hay una jornada registrada en ese dia, verificar que no sea la misma hora y lugar que se intenta ingresar
				QUERY SELECTION:C341([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Place:4=atPST_LugarJornada{$row})
				QUERY SELECTION:C341([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]Date_Jornada:2=adPST_DateJornada{$row})
				
				If (Records in selection:C76([ADT_JornadasVisita:144])=0)
					  //si no hay registros en seleccion, guardo el lugar de la jornada
					READ WRITE:C146([ADT_JornadasVisita:144])
					QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaI)
					
					[ADT_JornadasVisita:144]Section:5:=atPST_SeccionJornada{$row}
					[ADT_JornadasVisita:144]Date_Jornada:2:=adPST_DateJornada{$row}
					[ADT_JornadasVisita:144]Hora_Jornada:3:=aiPST_HoraJornada{$row}
					[ADT_JornadasVisita:144]Place:4:=atPST_LugarJornada{$row}
					SAVE RECORD:C53([ADT_JornadasVisita:144])
					KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
				Else 
					  //de lo contrario, no se puede don jornadas con el mismo lugar en el mismo dia y la misma hora
					If ((atPST_LugarJornada{$row}="") | (adPST_DateJornada{$row}=!00-00-00!))
						READ WRITE:C146([ADT_JornadasVisita:144])
						QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaI)
						
						[ADT_JornadasVisita:144]Section:5:=atPST_SeccionJornada{$row}
						[ADT_JornadasVisita:144]Date_Jornada:2:=adPST_DateJornada{$row}
						[ADT_JornadasVisita:144]Hora_Jornada:3:=aiPST_HoraJornada{$row}
						[ADT_JornadasVisita:144]Place:4:=atPST_LugarJornada{$row}
						SAVE RECORD:C53([ADT_JornadasVisita:144])
						KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
					Else 
						CD_Dlog (1;__ ("No es posible tener una Jornada de Visita en un mismo dia, hora y lugar"))
						STRcfg_ActualizarJornadaVisita 
					End if 
				End if 
			Else 
				READ WRITE:C146([ADT_JornadasVisita:144])
				QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaI)
				
				[ADT_JornadasVisita:144]Section:5:=atPST_SeccionJornada{$row}
				[ADT_JornadasVisita:144]Date_Jornada:2:=adPST_DateJornada{$row}
				[ADT_JornadasVisita:144]Hora_Jornada:3:=aiPST_HoraJornada{$row}
				[ADT_JornadasVisita:144]Place:4:=atPST_LugarJornada{$row}
				SAVE RECORD:C53([ADT_JornadasVisita:144])
				KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
			End if 
		Else 
			READ WRITE:C146([ADT_JornadasVisita:144])
			QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=$idJornadaI)
			
			[ADT_JornadasVisita:144]Section:5:=atPST_SeccionJornada{$row}
			[ADT_JornadasVisita:144]Date_Jornada:2:=adPST_DateJornada{$row}
			[ADT_JornadasVisita:144]Hora_Jornada:3:=aiPST_HoraJornada{$row}
			[ADT_JornadasVisita:144]Place:4:=atPST_LugarJornada{$row}
			SAVE RECORD:C53([ADT_JornadasVisita:144])
	End case 
	
	KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
	AL_ExitCell (xALP_JornadasVisita)
	  //PST_SaveParameters 
End if 
