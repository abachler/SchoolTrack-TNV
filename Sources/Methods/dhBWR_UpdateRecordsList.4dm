//%attributes = {}
  //dhBWR_UpdateRecordsList

C_BOOLEAN:C305($trapped;$0)
C_POINTER:C301($1;$tablepointer)

$tablepointer:=$1

Case of 
	: (vsBWR_CurrentModule="AccountTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				$trapped:=True:C214
				If (Not:C34(vb_RecordInInputForm))
					BWR_UpdateLastRecordSelected ($tablepointer)
					$arrayApdo:=Get pointer:C304(atBWR_ArrayNames{8})
					$arrayAlumno:=Get pointer:C304(atBWR_ArrayNames{7})
					$arrayProyMes:=Get pointer:C304(atBWR_ArrayNames{10})
					ARRAY TEXT:C222(aMeses;12)
					COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
					$selectedMonth:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"ACTcc_MesProyectado";String:C10(Month of:C24(Current date:C33(*)))))
					$selectedYear:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"ACTcc_AñoProyectado";String:C10(Year of:C25(Current date:C33(*)))))
					READ ONLY:C145([Alumnos:2])
					READ ONLY:C145([Personas:7])
					
					If ($arrayApdo->{lBWR_recordNumber}="")
						GOTO RECORD:C242([ACT_CuentasCorrientes:175];alBWR_recordNumber{lBWR_recordNumber})
						RELATE ONE:C42([ACT_CuentasCorrientes:175]ID_Alumno:3)
						$apdo:=Find in field:C653([Personas:7]No:1;[Alumnos:2]Apoderado_Cuentas_Número:28)
						If ($apdo#-1)
							GOTO RECORD:C242([Personas:7];$apdo)
							If ([Personas:7]Nacionalidad:7#"Chilen@")
								If ([Personas:7]Pasaporte:59#"")
									$arrayApdo->{lBWR_recordNumber}:="#######P"
								End if 
							End if 
						End if 
					End if 
					If ($arrayAlumno->{lBWR_recordNumber}="")
						GOTO RECORD:C242([ACT_CuentasCorrientes:175];alBWR_recordNumber{lBWR_recordNumber})
						RELATE ONE:C42([ACT_CuentasCorrientes:175]ID_Alumno:3)
						If ([Alumnos:2]Nacionalidad:8#"Chilen@")
							If ([Alumnos:2]NoPasaporte:87#"")
								$arrayAlumno->{lBWR_recordNumber}:="#######P"
							End if 
						End if 
					End if 
					READ ONLY:C145([ACT_CuentasCorrientes:175])
					READ ONLY:C145([ACT_Cargos:173])
					If (($selectedMonth#0) & ($selectedYear#0))
						GOTO RECORD:C242([ACT_CuentasCorrientes:175];alBWR_recordNumber{lBWR_recordNumber})
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$selectedMonth;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$selectedYear)
						$arrayProyMes->{lBWR_recordNumber}:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
					Else 
						If (($selectedMonth=0) & ($selectedYear#0))
							GOTO RECORD:C242([ACT_CuentasCorrientes:175];alBWR_recordNumber{lBWR_recordNumber})
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$selectedYear)
							$arrayProyMes->{lBWR_recordNumber}:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
						End if 
					End if 
					If (($selectedMonth=0) & ($selectedYear=0))
						$arrayProyMes->{lBWR_recordNumber}:=0
					End if 
					REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
				Else 
					READ ONLY:C145([Personas:7])
					READ ONLY:C145([ACT_Matrices:177])
					KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					KRL_FindAndLoadRecordByIndex (->[ACT_Matrices:177]ID:1;->[ACT_CuentasCorrientes:175]ID_Matriz:7)
					BWR_UpdateLastRecordSelected ($tablepointer)
				End if 
		End case 
	: (vsBWR_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
				
		End case 
	: (vsBWR_CurrentModule="AdmissionTrack")
		
		
End case 
$0:=$trapped