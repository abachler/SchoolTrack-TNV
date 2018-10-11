C_LONGINT:C283($subList;$selected)
C_BOOLEAN:C305($expanded)
C_TEXT:C284($asignatura)

$selected:=Selected list items:C379(hl_diferencias)
GET LIST ITEM:C378(hl_diferencias;$selected;$itemRef;$text;$subList;$expanded)
If ($sublist>0)
	If ($expanded=False:C215)
		SET LIST ITEM:C385(hl_diferencias;$itemRef;$text;$itemRef;$sublist;True:C214)
	End if 
	_O_REDRAW LIST:C382(hl_diferencias)
	If ($subList>0)
		SELECT LIST ITEMS BY POSITION:C381(hl_diferencias;$selected+1)
	End if 
	$id_alumno:=$itemRef
End if 


$id_alumno:=List item parent:C633(hl_diferencias;*)
If ($id_alumno>0)
	GET LIST ITEM:C378(hl_diferencias;*;$idAsignatura;$asignatura)
	$idAsignatura:=Abs:C99($idAsignatura)
	KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$id_alumno)
	KRL_FindAndLoadRecordByIndex (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->$idAsignatura)
	$keySintesis:="0"+"."+String:C10([Asignaturas_Historico:84]Año:5)+"."+String:C10([Alumnos:2]numero:1)
	KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$keySintesis)
	$keyCalificaciones:="0"+"."+String:C10([Asignaturas_Historico:84]Año:5)+"."+String:C10([Asignaturas_Historico:84]ID_RegistroHistorico:1)+"."+String:C10(Abs:C99($id_alumno))
	KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_RegistroHistorico:504;->$keyCalificaciones)
	
	ARRAY REAL:C219($aNotas;0)
	APPEND TO ARRAY:C911($aNotas;[Alumnos_Calificaciones:208]P01_Final_Nota:113)
	APPEND TO ARRAY:C911($aNotas;[Alumnos_Calificaciones:208]P02_Final_Nota:188)
	APPEND TO ARRAY:C911($aNotas;[Alumnos_Calificaciones:208]P03_Final_Nota:263)
	APPEND TO ARRAY:C911($aNotas;[Alumnos_Calificaciones:208]P04_Final_Nota:338)
	APPEND TO ARRAY:C911($aNotas;[Alumnos_Calificaciones:208]P05_Final_Nota:413)
	vr_promedioAnual:=Round:C94(AT_Mean (->$aNotas;1);1)
	
	If ([Alumnos_Calificaciones:208]ExamenAnual_Real:16>0)
		$percent:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16/[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32
		vr_PercentEX:=$percent*100
		vr_promedioOficial:=Round:C94([Alumnos_Calificaciones:208]Anual_Real:11*(1-$percent)+[Alumnos_Calificaciones:208]ExamenAnual_Real:16*$percent;1)
	Else 
		vr_promedioOficial:=vr_PromedioAnual
	End if 
	
	If (vr_promedioOficial=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]Anual_Nota:12;-6)
	Else 
		OBJECT SET COLOR:C271([Alumnos_Calificaciones:208]Anual_Nota:12;-3)
	End if 
	
End if 


