//%attributes = {}
  //AL_TotalizaSuspensiones


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
		
		
		  //inicialización de los campos de sintesis relacionados con Suspensiones
		$value:=0
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($id_Alumno)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Suspensiones:44;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P01_Suspensiones:111;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P02_Suspensiones:140;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P03_Suspensiones:169;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P04_Suspensiones:198;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P05_Suspensiones:227;->$value;True:C214)
		
		READ ONLY:C145([Alumnos_Suspensiones:12])
		QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7=$id_Alumno;*)
		QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Desde:5>=vdSTR_Periodos_InicioEjercicio;*)
		QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Desde:5<=vdSTR_Periodos_FinEjercicio)
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Suspensiones:12];$aRecNums;"")
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([Alumnos_Suspensiones:12];$aRecNums{$i})
			
			  //lectura del número de periodo correspondiente a la fecha de la suspension
			$devolverPeriodoMasCercano:=False:C215
			$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Suspensiones:12]Desde:5;$devolverPeriodoMasCercano)
			
			
			  //se incrementan los valores de los totales en los registros de sintesis
			If ($periodo>0)
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($id_Alumno)
				KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
				If (OK=1)
					Case of 
						: ($periodo=1)
							[Alumnos_SintesisAnual:210]P01_Suspensiones:111:=[Alumnos_SintesisAnual:210]P01_Suspensiones:111+1
						: ($periodo=2)
							[Alumnos_SintesisAnual:210]P02_Suspensiones:140:=[Alumnos_SintesisAnual:210]P02_Suspensiones:140+1
						: ($periodo=3)
							[Alumnos_SintesisAnual:210]P03_Suspensiones:169:=[Alumnos_SintesisAnual:210]P03_Suspensiones:169+1
						: ($periodo=4)
							[Alumnos_SintesisAnual:210]P04_Suspensiones:198:=[Alumnos_SintesisAnual:210]P04_Suspensiones:198+1
						: ($periodo=5)
							[Alumnos_SintesisAnual:210]P05_Suspensiones:227:=[Alumnos_SintesisAnual:210]P05_Suspensiones:227+1
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