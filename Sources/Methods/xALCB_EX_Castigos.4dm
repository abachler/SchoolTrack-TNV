//%attributes = {}
  //xALCB_EX_Castigos

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
			: ((vCol=1) & (<>aCdtadate{vRow}#<>aCdtadate{0}))
				<>aCdtadate{vRow}:=AL_isNotAbsent (<>aCdtadate{vRow})
				If (<>aCdtadate{vRow}=!00-00-00!)
					<>aCdtadate{vRow}:=<>aCdtadate{0}
					AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
				End if 
			: (vCol=2)
				  //Case of 
				  //: (<>aCdtatext1{vRow}="")
				  //CD_Dlog (0;__ ("Ingrese el motivo del castigo."))
				  //AL_GotoCell (xALP_ConductaAlumnos;2;vRow)
				  //: (Position("[+]";<>aCdtaText1{vRow})>0)
				  //CD_Dlog (0;__ ("Un castigo no puede originarse en un comportamiento positivo."))
				  //<>aCdtaText1{vRow}:=""
				  //AL_GotoCell (xALP_ConductaAlumnos;2;vRow)
				  //AL_GotoCell (xALP_ConductaAlumnos;3;vRow)
				  //End case 
			: (vCol=3)
				AL_GotoCell (xALP_ConductaAlumnos;4;vRow)
			: (vCol=4)
				  //AL_GotoCell (areaCdta;vCol;vRow)
				POST KEY:C465(Character code:C91("-");256)
			: (vCol=5)
				If (<>aCdtaNum1{vRow}=0)
					CD_Dlog (0;__ ("Ingrese el número de horas de castigo."))
					AL_GotoCell (xALP_ConductaAlumnos;5;vRow)
					AL_GotoCell (xALP_ConductaAlumnos;6;vRow)
				End if 
			: (vCol=6)
				AL_GotoCell (xALP_ConductaAlumnos;6;vRow)
		End case 
		
		If ((<>aCdtaDate{vRow}#!00-00-00!) & (<>aCdtaText1{vRow}#"") & (<>aCdtaLong1{vRow}#0) & (<>aCdtaNum1{vRow}>0))
			READ WRITE:C146([Alumnos_Castigos:9])
			GOTO RECORD:C242([Alumnos_Castigos:9];<>aCdtaRecNo{vrow})
			[Alumnos_Castigos:9]Fecha:9:=<>aCdtaDate{vRow}
			[Alumnos_Castigos:9]Motivo:2:=<>aCdtaText1{vRow}
			[Alumnos_Castigos:9]Observaciones:3:=<>aCdtaText2{vRow}
			[Alumnos_Castigos:9]Profesor_Numero:6:=<>aCdtaLong1{vRow}
			[Alumnos_Castigos:9]Horas_de_castigo:7:=<>aCdtaNum1{vRow}
			[Alumnos_Castigos:9]Castigo_cumplido:4:=<>aCdtaBool{vRow}
			SAVE RECORD:C53([Alumnos_Castigos:9])
			UNLOAD RECORD:C212([Alumnos_Castigos:9])
			READ ONLY:C145([Alumnos_Castigos:9])
		End if 
	End if 
End if 