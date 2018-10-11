//%attributes = {}
  //AL_TotalizaCastigos

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
		
		
		  //inicialización de los campos de sintesis relacionados con castigos
		
		$value:=0
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($id_Alumno)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Castigos:43;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P01_Castigos:110;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P02_Castigos:139;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P03_Castigos:168;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P04_Castigos:197;->$value;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]P05_Castigos:226;->$value;True:C214)
		
		READ ONLY:C145([Alumnos_Castigos:9])
		QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8=$id_Alumno;*)
		QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Fecha:9>=vdSTR_Periodos_InicioEjercicio;*)
		QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Fecha:9<=vdSTR_Periodos_FinEjercicio)
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Castigos:9];$aRecNums;"")
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([Alumnos_Castigos:9];$aRecNums{$i})
			
			  //lectura del número de periodo y subperiodo correspondiente a la fecha del castigo
			$devolverPeriodoMasCercano:=False:C215
			$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Castigos:9]Fecha:9;$devolverPeriodoMasCercano)
			
			
			  //se incrementan los valores de los totales en los registros de sintesis
			If ($periodo>0)
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($nivel)+"."+String:C10($id_Alumno)
				KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
				If (OK=1)
					Case of 
						: ($periodo=1)
							[Alumnos_SintesisAnual:210]P01_Castigos:110:=[Alumnos_SintesisAnual:210]P01_Castigos:110+1
						: ($periodo=2)
							[Alumnos_SintesisAnual:210]P02_Castigos:139:=[Alumnos_SintesisAnual:210]P02_Castigos:139+1
						: ($periodo=3)
							[Alumnos_SintesisAnual:210]P03_Castigos:168:=[Alumnos_SintesisAnual:210]P03_Castigos:168+1
						: ($periodo=4)
							[Alumnos_SintesisAnual:210]P04_Castigos:197:=[Alumnos_SintesisAnual:210]P04_Castigos:197+1
						: ($periodo=5)
							[Alumnos_SintesisAnual:210]P05_Castigos:226:=[Alumnos_SintesisAnual:210]P05_Castigos:226+1
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