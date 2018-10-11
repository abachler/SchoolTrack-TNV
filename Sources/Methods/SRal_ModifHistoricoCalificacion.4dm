//%attributes = {}
  //Método: SRal_ModifHistoricoCalificacion


C_LONGINT:C283($idAlumno;$idAsignatura;$i)
If (Records in selection:C76([Alumnos:2])>0)
	$r:=CD_Dlog (0;__ ("¿Desea imprimir este informe para los alumnos en el explorador o para todos los alumnos.");__ ("");__ ("Para todos");__ ("Solo alumnos en el explorador"))
	
	If ($r=2)
		USE NAMED SELECTION:C332("◊Editions")
	Else 
		ALL RECORDS:C47([Alumnos:2])
	End if 
End if 


$p:=IT_UThermometer (1;0;__ ("Preparando informe..."))
QR_InitGenericObjects 

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])

If (Records in selection:C76([Alumnos:2])=0)
	QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3<<>gYear)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88#"")
Else 
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$Ids)
	For ($i;1;Size of array:C274($Ids))
		$Ids{$i}:=-$Ids{$i}
	End for 
	QUERY WITH ARRAY:C644([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;$Ids)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88#"")
End if 


SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209];aQR_Longint1;[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88;$aCambiosHistoricos)
For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
	vQR_Text1:=ST_GetWord ($aCambiosHistoricos{vQR_Long1};1;"\r")
	ARRAY TEXT:C222($aModifs;0)
	AT_Text2Array (->$aModifs;$aCambiosHistoricos{vQR_Long1};"\r")
	For ($iModifs;1;Size of array:C274($aModifs))
		$year:=Num:C11(Substring:C12($aModifs{$iModifs};1;4))
		$month:=Num:C11(Substring:C12($aModifs{$iModifs};6;2))
		$day:=Num:C11(Substring:C12($aModifs{$iModifs};9;2))
		$date:=DT_GetDateFromDayMonthYear ($day;$month;$year)
		vQR_Text1:=Replace string:C233(vQR_Text1;"->";" por ")
		If (($date>=vd_fecha1) & ($date<=vd_fecha2))
			KRL_GotoRecord (->[Alumnos_ComplementoEvaluacion:209];aQR_Longint1{vQR_Long1})
			$IDAlumno:=Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$idAlumno)
			$idAsignatura:=Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48)
			KRL_FindAndLoadRecordByIndex (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->$idAsignatura)
			APPEND TO ARRAY:C911(aQR_Text1;[Alumnos:2]apellidos_y_nombres:40)
			APPEND TO ARRAY:C911(aQR_Text2;[Alumnos:2]curso:20)
			APPEND TO ARRAY:C911(aQR_Longint4;[Alumnos:2]nivel_numero:29)
			APPEND TO ARRAY:C911(aQR_Longint3;[Alumnos_ComplementoEvaluacion:209]Año:3)
			APPEND TO ARRAY:C911(aQR_Text3;[Asignaturas_Historico:84]Asignatura:2)
			APPEND TO ARRAY:C911(aQR_Date1;$date)
			APPEND TO ARRAY:C911(aQR_Text4;ST_GetWord (vQR_Text1;2;"-"))
			APPEND TO ARRAY:C911(aQR_Text5;ST_GetWord (vQR_Text1;3;"-"))
		End if 
	End for 
End for 
USE NAMED SELECTION:C332("◊Editions")

SORT ARRAY:C229(aQR_Longint4;aQR_Text2;aQR_Text1;aQR_Longint3;aQR_Text3;aQR_Date1;aQR_Text4;aQR_Text5;>)

$p:=IT_UThermometer (-2;$p)

