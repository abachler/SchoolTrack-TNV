//%attributes = {}
  //AL_TotalizaAtrasos

  //DECLARACIONES & INICIALIZACIONES
C_LONGINT:C283($value;$i_Periodos;$periodo;$nivel;$id_Alumno;$1)
C_TEXT:C284($key)
C_BOOLEAN:C305($0)
$0:=True:C214

  //CUERPO
If (Not:C34(<>vb_BloquearModifSituacionFinal))
	$id_Alumno:=$1
	$nivel:=0
	
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$id_Alumno)
	
	If (Count parameters:C259=2)
		$nivel:=$2
	End if 
	
	If ($nivel=0)
		$nivel:=[Alumnos:2]nivel_numero:29
	End if 
	
	
	If ($recNum>=0)
		PERIODOS_LoadData ($nivel)
		
		$modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]Lates_Mode:16)
		If ($modoRegistroAtrasos=1)
			  //initiacialización de los campos de sintesis relacionados con atrasos
			
			$value:=0
			$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($id_Alumno)
			$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
			[Alumnos_SintesisAnual:210]Atrasos_Jornada:40:=$value
			[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41:=$value
			[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51:=$value
			[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45:=$value
			[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46:=$value
			[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107:=$value
			[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108:=$value
			[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112:=$value
			[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113:=$value
			[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136:=$value
			[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137:=$value
			[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141:=$value
			[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142:=$value
			[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165:=$value
			[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166:=$value
			[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170:=$value
			[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171:=$value
			[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194:=$value
			[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195:=$value
			[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199:=$value
			[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200:=$value
			[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223:=$value
			[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224:=$value
			[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228:=$value
			[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229:=$value
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
			
			READ ONLY:C145([Alumnos_Atrasos:55])
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$id_Alumno;*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2>=vdSTR_Periodos_InicioEjercicio;*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2<=vdSTR_Periodos_FinEjercicio)
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos_Atrasos:55];$aRecNums;"")
			For ($i;1;Size of array:C274($aRecNums))
				GOTO RECORD:C242([Alumnos_Atrasos:55];$aRecNums{$i})
				
				  //lectura del número de periodo y subperiodo correspondiente a la fecha del aatraso
				$devolverPeriodoMasCercano:=False:C215
				$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Atrasos:55]Fecha:2;$devolverPeriodoMasCercano)
				
				  //se incrementan los valores de los totales en los registros de sintesis
				If ($periodo>0)
					Case of 
						: ($periodo=1)
							$y_TotalJornada:=->[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107
							$y_TotalSesiones:=->[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108
							$y_TotalFaltasJornada:=->[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112
							$y_TotalFaltasSesiones:=->[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113
						: ($periodo=2)
							$y_TotalJornada:=->[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136
							$y_TotalSesiones:=->[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137
							$y_TotalFaltasJornada:=->[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141
							$y_TotalFaltasSesiones:=->[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142
						: ($periodo=3)
							$y_TotalJornada:=->[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165
							$y_TotalSesiones:=->[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166
							$y_TotalFaltasJornada:=->[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170
							$y_TotalFaltasSesiones:=->[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171
						: ($periodo=4)
							$y_TotalJornada:=->[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194
							$y_TotalSesiones:=->[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195
							$y_TotalFaltasJornada:=->[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199
							$y_TotalFaltasSesiones:=->[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200
						: ($periodo=5)
							$y_TotalJornada:=->[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223
							$y_TotalSesiones:=->[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224
							$y_TotalFaltasJornada:=->[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228
							$y_TotalFaltasSesiones:=->[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229
					End case 
					
					
					$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($id_Alumno)
					KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
					If (OK=1)
						If ([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4)
							$y_TotalSesiones->:=$y_TotalSesiones->+1
							$y_TotalFaltasSesiones->:=$y_TotalFaltasSesiones->+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
						Else 
							$y_TotalJornada->:=$y_TotalJornada->+1
							$y_TotalFaltasJornada->:=$y_TotalFaltasJornada->+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
						End if 
						[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51+[Alumnos_Atrasos:55]MinutosAtraso:5
						SAVE RECORD:C53([Alumnos_SintesisAnual:210])
						UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
					End if 
					
				End if 
			End for 
		End if 
	Else 
		$0:=True:C214
	End if 
Else 
	$0:=True:C214
End if 

  //LIMPIEZA







