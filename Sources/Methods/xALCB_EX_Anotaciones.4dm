//%attributes = {}
  //xALCB_EX_Anotaciones

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_ConductaAlumnos)=1)
		AL_GetCurrCell (xALP_ConductaAlumnos;vCol;vRow)
		Case of 
			: ((vCol=1) & (adSTRal_FechaAnotacion{vRow}#adSTRal_FechaAnotacion{0}))
				adSTRal_FechaAnotacion{vRow}:=AL_isNotAbsent (adSTRal_FechaAnotacion{vRow})
				If (adSTRal_FechaAnotacion{vRow}=!00-00-00!)
					adSTRal_FechaAnotacion{vRow}:=adSTRal_FechaAnotacion{0}
					AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
				End if 
			: (vCol=5)
				AL_GotoCell (xALP_ConductaAlumnos;4;vRow)
			: (vCol=6)
				AL_GotoCell (xALP_ConductaAlumnos;vCol;vRow)  //para no pasar a la celda o linea siguinete
				  //ticket 161577
				  //POST KEY(Character code("-");256)
				AL_actualizadatos 
		End case 
		If ((adSTRal_FechaAnotacion{vRow}#!00-00-00!) & (atSTRal_MotivoAnotacion{vRow}#"") & (alSTRal_NoProfesorAnot{vRow}#0))
			  //20130614 ASM. se agrega validación 
			C_BOOLEAN:C305($vb_registrar_anotacion)
			If (((Current date:C33(*)-adSTRal_FechaAnotacion{vRow})><>vi_nd_reg_anotacion) & (<>vi_nd_reg_anotacion>0))
				GOTO RECORD:C242([Alumnos_Anotaciones:11];<>aCdtaRecNo{vrow})
				$t_mensaje:=__ ("El registro de anotaciones después de más ^0 días de la fecha del evento no está autorizado.\r\rPor favor consulte con el administrador si piensa que esto es un error.")
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10(<>vi_nd_reg_anotacion))
				CD_Dlog (0;$t_mensaje)
				adSTRal_FechaAnotacion{vRow}:=[Alumnos_Anotaciones:11]Fecha:1
			Else 
				READ WRITE:C146([Alumnos_Anotaciones:11])
				GOTO RECORD:C242([Alumnos_Anotaciones:11];<>aCdtaRecNo{vrow})
				[Alumnos_Anotaciones:11]Fecha:1:=adSTRal_FechaAnotacion{vRow}
				[Alumnos_Anotaciones:11]Motivo:3:=atSTRal_MotivoAnotacion{vRow}
				[Alumnos_Anotaciones:11]Observaciones:4:=atSTRal_NotasAnotacion{vRow}
				[Alumnos_Anotaciones:11]Profesor_Numero:5:=alSTRal_NoProfesorAnot{vRow}
				SAVE RECORD:C53([Alumnos_Anotaciones:11])
				UNLOAD RECORD:C212([Alumnos_Anotaciones:11])
				READ ONLY:C145([Alumnos_Anotaciones:11])
			End if 
		End if 
	End if 
End if 

