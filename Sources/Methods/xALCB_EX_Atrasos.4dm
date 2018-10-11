//%attributes = {}
  //xALCB_EX_Atrasos

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)
C_DATE:C307($dStart;$dEnd)
C_LONGINT:C283($minutos)
C_TEXT:C284($msg_log)
C_BOOLEAN:C305($modificar)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	$dStart:=adSTR_Periodos_Desde{1}
	Case of 
		: (Size of array:C274(atSTR_Periodos_Nombre)=2)  //ASM Ticket 143492
			$dEnd:=adSTR_Periodos_Hasta{2}
		: (Size of array:C274(atSTR_Periodos_Nombre)=3)
			$dEnd:=adSTR_Periodos_Hasta{3}
		: (Size of array:C274(atSTR_Periodos_Nombre)=4)
			$dEnd:=adSTR_Periodos_Hasta{4}
		: (Size of array:C274(atSTR_Periodos_Nombre)=5)
			$dEnd:=adSTR_Periodos_Hasta{5}
		Else 
			$dEnd:=adSTR_Periodos_Hasta{1}
	End case 
	
	If (AL_GetCellMod (xALP_ConductaAlumnos)=1)
		AL_GetCurrCell (xALP_ConductaAlumnos;vCol;vRow)
		Case of 
			: ((vCol=1) & (<>aCdtadate{vRow}#<>aCdtadate{0}))
				<>aCdtadate{vRow}:=AL_isNotLate (<>aCdtadate{vRow})
				If (<>aCdtadate{vRow}=!00-00-00!)
					<>aCdtadate{vRow}:=<>aCdtadate{0}
					AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
				End if 
			: (vCol=2)
				
			: ((vCol=3) & (<>aCdtadate{vRow}#<>aCdtadate{0}))
				<>aCdtadate{vRow}:=AL_isNotLate (<>aCdtadate{vRow})
		End case 
		If (<>aCdtadate{vRow}#!00-00-00!)
			If (<>vr_InasistenciasXatrasos>0)
				If (al_alMinutosAtraso{vRow}<0)
					al_alMinutosAtraso{vRow}:=0
					$minutos:=0
				Else 
					$minutos:=al_alMinutosAtraso{vRow}
				End if 
			Else 
				  //$minutos:=0//ticket 120905
				$minutos:=al_alMinutosAtraso{vRow}
			End if 
			
			$modificar:=False:C215
			$resultado:=AL_validaIngresoAtraso ([Alumnos:2]numero:1;<>aCdtaDate{vrow};$minutos)  //20170227 ASM Ticket 175427
			READ WRITE:C146([Alumnos_Atrasos:55])
			GOTO RECORD:C242([Alumnos_Atrasos:55];<>aCdtaRecNo{vrow})
			
			If ([Alumnos_Atrasos:55]Fecha:2#<>aCdtaDate{vrow})
				$msg_log:=$msg_log+"Cambio de fecha de "+String:C10([Alumnos_Atrasos:55]Fecha:2)+" a "+String:C10(<>aCdtaDate{vrow})+"\r"
				[Alumnos_Atrasos:55]Fecha:2:=<>aCdtaDate{vrow}
				$modificar:=True:C214
			End if 
			If ([Alumnos_Atrasos:55]Observaciones:3#<>aCdtaText1{vRow})
				$msg_log:=$msg_log+"Cambio de observación de '"+[Alumnos_Atrasos:55]Observaciones:3+"' a '"+<>aCdtaText1{vRow}+"'"+"\r"
				[Alumnos_Atrasos:55]Observaciones:3:=<>aCdtaText1{vRow}
				$modificar:=True:C214
			End if 
			If ([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4#aCdtaBoolean1{vRow})
				$msg_log:=$msg_log+"Cambio de intersesion de "+String:C10([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4)+" a "+String:C10(aCdtaBoolean1{vRow})+"\r"
				[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4:=aCdtaBoolean1{vRow}
				$modificar:=True:C214
			End if 
			If ([Alumnos_Atrasos:55]MinutosAtraso:5#$minutos)
				If ($resultado>1)  //20180504 ASM Ticket 206026
					al_alMinutosAtraso{vRow}:=[Alumnos_Atrasos:55]MinutosAtraso:5
					$modificar:=False:C215
					CD_Dlog (0;__ ("No puede modificar los minutos de atrasos para el alumno ")+[Alumnos:2]apellidos_y_nombres:40+"."+Char:C90(13)+__ ("Verifique que no existan inasistencias registradas, o que las faltas por atrasos no sumen mas de un día para la fecha seleccionada."))
				Else 
					$msg_log:=$msg_log+"Cambio de minutos de "+String:C10([Alumnos_Atrasos:55]MinutosAtraso:5)+" a "+String:C10($minutos)+"\r"
					[Alumnos_Atrasos:55]MinutosAtraso:5:=$minutos
					$modificar:=True:C214
				End if 
			End if 
			
			If ([Alumnos_Atrasos:55]justificado:14#ab_justificado{vRow})
				$msg_log:=$msg_log+"Cambio en el estado de justificación de atraso "+"\r"
				[Alumnos_Atrasos:55]justificado:14:=ab_justificado{vRow}  //20180627 ASM Ticket 210369
				$modificar:=True:C214
			End if 
			
			
			If ($modificar)
				SAVE RECORD:C53([Alumnos_Atrasos:55])
				LOG_RegisterEvt ("Modificación de atraso del alumno "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Atrasos:55]Alumno_numero:1;->[Alumnos:2]apellidos_y_nombres:40)+"\r"+$msg_log)
			End if 
			
			UNLOAD RECORD:C212([Alumnos_Atrasos:55])
			READ ONLY:C145([Alumnos_Atrasos:55])
			AL_TotalizaAtrasos ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
			AL_TotalizaInasistencias ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
			AL_LeeSintesisConducta ([Alumnos:2]numero:1)
			  //AL_LeeRegistrosConducta  ticket 164069
		End if 
	End if 
End if 
  //20180627 ASM Ticket 210369
  //$b_continuar:=False
  //$modo_asistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles]NoNivel;->[Alumnos]Nivel_Número;->[xxSTR_Niveles]AttendanceMode)
  //If ($modo_asistencia=2)
  //If (vi_RegistrarMinutosEnAtrasos>0)
  //If (vCol=7)
  //$b_continuar:=True
  //End if 
  //Else 
  //If (vCol=6)
  //$b_continuar:=True
  //End if 
  //End if 
  //Else 
  //If (vi_RegistrarMinutosEnAtrasos>0)
  //If (vCol=6)
  //$b_continuar:=True
  //End if 
  //Else 
  //If (vCol=5)
  //$b_continuar:=True
  //End if 
  //End if 
  //End if 

  //If ($b_continuar)
  //READ WRITE([Alumnos_Atrasos])
  //GOTO RECORD([Alumnos_Atrasos];<>aCdtaRecNo{vrow})
  //[Alumnos_Atrasos]justificado:=ab_justificado{vRow}
  //SAVE RECORD([Alumnos_Atrasos])
  //UNLOAD RECORD([Alumnos_Atrasos])
  //READ ONLY([Alumnos_Atrasos])
  //AL_UpdateArrays (xALP_ConductaAlumnos;-2)
  //End if 











  //