$ptr_id_alu:=->[Alumnos:2]numero:1
Case of 
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Anotaciones:11]))
		$yDateField:=->[Alumnos_Anotaciones:11]Fecha:1
		$ptrIDField:=->[Alumnos_Anotaciones:11]Alumno_Numero:6
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Atrasos:55]))
		$yDateField:=->[Alumnos_Atrasos:55]Fecha:2
		$ptrIDField:=->[Alumnos_Atrasos:55]Alumno_numero:1
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Castigos:9]))
		$yDateField:=->[Alumnos_Castigos:9]Fecha:9
		$ptrIDField:=->[Alumnos_Castigos:9]Alumno_Numero:8
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_ControlesMedicos:99]))
		$yDateField:=->[Alumnos_ControlesMedicos:99]Fecha:2
		$ptrIDField:=->[Alumnos_ControlesMedicos:99]Numero_Alumno:1
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosEnfermeria:14]))
		$yDateField:=->[Alumnos_EventosEnfermeria:14]Fecha:2
		$ptrIDField:=->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosOrientacion:21]))
		$yDateField:=->[Alumnos_EventosOrientacion:21]Fecha:2
		$ptrIDField:=->[Alumnos_EventosOrientacion:21]Alumno_Numero:1
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Inasistencias:10]))
		$yDateField:=->[Alumnos_Inasistencias:10]Fecha:1
		$ptrIDField:=->[Alumnos_Inasistencias:10]Alumno_Numero:4
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_ObsOrientacion:127]))
		$yDateField:=->[Alumnos_ObsOrientacion:127]Fecha_observación:2
		$ptrIDField:=->[Alumnos_ObsOrientacion:127]Alumno_Numero:1
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Suspensiones:12]))
		$yDateField:=->[Alumnos_Suspensiones:12]Desde:5
		$ptrIDField:=->[Alumnos_Suspensiones:12]Alumno_Numero:7
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Asignaturas_Inasistencias:125]))
		$yDateField:=->[Asignaturas_Inasistencias:125]dateSesion:4
		$ptrIDField:=->[Asignaturas_Inasistencias:125]ID_Alumno:2
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Licencias:73]))
		$yDateField:=->[Alumnos_Licencias:73]Desde:2
		$ptrIDField:=->[Alumnos_Licencias:73]Alumno_numero:1
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosPersonales:16]))
		$yDateField:=->[Alumnos_EventosPersonales:16]Fecha:3
		$ptrIDField:=->[Alumnos_EventosPersonales:16]Alumno_Numero:1
End case 

If (Table:C252(ybwr_CurrentTable)=Table:C252(->[Cursos:3]))
	KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
	KRL_RelateSelection ($ptrIDField;->[Alumnos:2]numero:1;"")
End if 

CREATE SET:C116(vyQRY_TablePointer->;"SetActual")
ARRAY LONGINT:C221($al_idalu;0)
C_LONGINT:C283($i)
AT_DistinctsFieldValues ($ptr_id_alu;->$al_idalu)
For ($i;1;Size of array:C274($al_idalu))
	$al_idalu{$i}:=$al_idalu{$i}*-1
End for 
QUERY WITH ARRAY:C644($ptrIDField->;$al_idalu)
CREATE SET:C116(vyQRY_TablePointer->;"SetHistorico")
UNION:C120("SetActual";"SetHistorico";"SetActual")
USE SET:C118("SetActual")
SET_ClearSets ("SetActual";"SetHistorico")

If (cbSearchSelection=1)
	QUERY SELECTION:C341(vyQRY_TablePointer->;$yDateField->>=dDate1;*)
	QUERY SELECTION:C341(vyQRY_TablePointer->; & ;$yDateField-><=dDate2)
Else 
	QUERY:C277(vyQRY_TablePointer->;$yDateField->>=dDate1;*)
	QUERY:C277(vyQRY_TablePointer->; & ;$yDateField-><=dDate2)
End if 


Case of 
		
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Anotaciones:11]))
		Case of 
			: (r1=1)
				QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Signo:7="+")
			: (r2=1)
				QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Signo:7="-")
			: (r3=1)
				QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Signo:7="=")
		End case 
		
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Castigos:9]))
		Case of 
			: (r1=1)
				QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=True:C214)
			: (r2=1)
				QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=False:C215)
		End case 
		
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Inasistencias:10]))
		Case of 
			: (r1=1)
				QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Justificación:2#"")
			: (r2=1)
				QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Justificación:2="")
		End case 
		
End case 

If (Records in selection:C76(vyQRY_TablePointer->)>0)
	ACCEPT:C269
Else 
	$ignore:=CD_Dlog (0;__ ("No se encontró ningun registro en el rango de fechas especificado."))
End if 
