//%attributes = {}
  //AL_TotalizaAnotaciones

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
		
		  //inicialización de los campos de sintesisrelacionados con anotaciones
		
		$value:=0
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($id_Alumno)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Anotaciones_Neutras:35;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PuntajeConductual_Balance:39;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PuntajeConductual_Positivo:37;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PuntajeConductual_Negativo:38;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PuntajeNegativoAcumulado:52;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PuntajePositivoAcumulado:53;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P01_Anotaciones_Neutras:102;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Negativo:105;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Positivo:104;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Balance:106;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P02_Anotaciones_Neutras:131;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Negativo:134;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Positivo:133;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Balance:135;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P03_Anotaciones_Neutras:160;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Negativo:163;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Positivo:162;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Balance:164;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P04_Anotaciones_Neutras:189;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Negativo:192;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Positivo:191;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Balance:193;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P05_Anotaciones_Neutras:218;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Negativo:221;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Positivo:220;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Balance:222;->$value;True:C214)
		
		
		READ ONLY:C145([Alumnos_Anotaciones:11])
		QUERY:C277([Alumnos_Anotaciones:11]; & [Alumnos_Anotaciones:11]Alumno_Numero:6=$id_Alumno;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Fecha:1>=vdSTR_Periodos_InicioEjercicio;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Fecha:1<=vdSTR_Periodos_FinEjercicio)
		
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Anotaciones:11];$aRecNums;"")
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([Alumnos_Anotaciones:11];$aRecNums{$i})
			
			  //lectura del número de periodo correspondiente a la fecha de la anotacion
			$devolverPeriodoMasCercano:=False:C215
			$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Anotaciones:11]Fecha:1;$devolverPeriodoMasCercano)
			
			
			If ($periodo>0)
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($id_Alumno)
				KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
				
				Case of 
					: ($periodo=1)
						$y_TotalPositivas:=->[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101
						$y_TotalNeutras:=->[Alumnos_SintesisAnual:210]P01_Anotaciones_Neutras:102
						$y_TotalNegativas:=->[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103
						$y_PuntajeNegativo:=->[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Negativo:105
						$y_PuntajePositivo:=->[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Positivo:104
						$y_PuntajeBalance:=->[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Balance:106
					: ($periodo=2)
						$y_TotalPositivas:=->[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130
						$y_TotalNeutras:=->[Alumnos_SintesisAnual:210]P02_Anotaciones_Neutras:131
						$y_TotalNegativas:=->[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132
						$y_PuntajeNegativo:=->[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Negativo:134
						$y_PuntajePositivo:=->[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Positivo:133
						$y_PuntajeBalance:=->[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Balance:135
					: ($periodo=3)
						$y_TotalPositivas:=->[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159
						$y_TotalNeutras:=->[Alumnos_SintesisAnual:210]P03_Anotaciones_Neutras:160
						$y_TotalNegativas:=->[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161
						$y_PuntajeNegativo:=->[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Negativo:163
						$y_PuntajePositivo:=->[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Positivo:162
						$y_PuntajeBalance:=->[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Balance:164
					: ($periodo=4)
						$y_TotalPositivas:=->[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188
						$y_TotalNeutras:=->[Alumnos_SintesisAnual:210]P04_Anotaciones_Neutras:189
						$y_TotalNegativas:=->[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190
						$y_PuntajeNegativo:=->[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Negativo:192
						$y_PuntajePositivo:=->[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Positivo:191
						$y_PuntajeBalance:=->[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Balance:193
					: ($periodo=5)
						$y_TotalPositivas:=->[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217
						$y_TotalNeutras:=->[Alumnos_SintesisAnual:210]P05_Anotaciones_Neutras:218
						$y_TotalNegativas:=->[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219
						$y_PuntajeNegativo:=->[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Negativo:221
						$y_PuntajePositivo:=->[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Positivo:220
						$y_PuntajeBalance:=->[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Balance:222
				End case 
				
				
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($id_Alumno)
				KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
				If (OK=1)
					Case of 
						: ([Alumnos_Anotaciones:11]Signo:7="-")
							$y_TotalNegativas->:=$y_TotalNegativas->+1
							$y_PuntajeNegativo->:=$y_PuntajeNegativo->+[Alumnos_Anotaciones:11]Puntos:9
							$y_PuntajeBalance->:=$y_PuntajePositivo->-$y_PuntajeNegativo->
							
						: ([Alumnos_Anotaciones:11]Signo:7="=")
							$y_TotalNeutras->:=$y_TotalNeutras->+1
							
						: ([Alumnos_Anotaciones:11]Signo:7="+")
							$y_TotalPositivas->:=$y_TotalPositivas->+1
							$y_PuntajePositivo->:=$y_PuntajePositivo->+[Alumnos_Anotaciones:11]Puntos:9
							$y_PuntajeBalance->:=$y_PuntajePositivo->-$y_PuntajeNegativo->
					End case 
					SAVE RECORD:C53([Alumnos_SintesisAnual:210])
					UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
				End if 
				
				
			End if 
		End for 
	Else 
		$0:=True:C214
	End if 
Else 
	$0:=True:C214
End if 


  //LIMPIEZA
