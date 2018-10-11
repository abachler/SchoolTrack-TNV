C_LONGINT:C283(hl_Diferencias;$hl_asignaturas)


QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5>=2000;*)
QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Promediable:6=True:C214)
KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;->[Asignaturas_Historico:84]ID_RegistroHistorico:1)
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32>=0)

$modoCalculoPromedio:=1
$decimalesPromedio:=1
$advertir_PPInexistentes:=False:C215

HL_ClearList (hl_Diferencias)
hl_Diferencias:=New list:C375


ARRAY TEXT:C222($aErrores;0)
APPEND TO ARRAY:C911($aErrores;"Situación\tAño\tAlumno\tCurso\tAsignatura\tP1\tP2\tP3\tP4\tP5\tPromedio SchoolTrack\tPromedi"+"o anual recalculado\tDiferencia\t\tExamen\tNota Oficial")

ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando promedios finales en registros de evaluación históricos...")
For ($i;1;Size of array:C274($aRecNums))
	ARRAY REAL:C219($aNotas;0)
	GOTO RECORD:C242([Alumnos_Calificaciones:208];$aRecNums{$i})
	
	  //divido por diez si las notas almacenadas eestan en escala de 10 a 70
	If ([Alumnos_Calificaciones:208]P01_Final_Nota:113>7)
		[Alumnos_Calificaciones:208]P01_Final_Nota:113:=[Alumnos_Calificaciones:208]P01_Final_Nota:113/10
	End if 
	If ([Alumnos_Calificaciones:208]P02_Final_Nota:188>7)
		[Alumnos_Calificaciones:208]P02_Final_Nota:188:=[Alumnos_Calificaciones:208]P02_Final_Nota:188/10
	End if 
	If ([Alumnos_Calificaciones:208]P03_Final_Nota:263>7)
		[Alumnos_Calificaciones:208]P03_Final_Nota:263:=[Alumnos_Calificaciones:208]P03_Final_Nota:263/10
	End if 
	If ([Alumnos_Calificaciones:208]P04_Final_Nota:338>7)
		[Alumnos_Calificaciones:208]P04_Final_Nota:338:=[Alumnos_Calificaciones:208]P04_Final_Nota:338/10
	End if 
	If ([Alumnos_Calificaciones:208]P05_Final_Nota:413>7)
		[Alumnos_Calificaciones:208]P05_Final_Nota:413:=[Alumnos_Calificaciones:208]P05_Final_Nota:413/10
	End if 
	If ([Alumnos_Calificaciones:208]Anual_Nota:12>7)
		[Alumnos_Calificaciones:208]Anual_Nota:12:=[Alumnos_Calificaciones:208]Anual_Nota:12/10
	End if 
	
	
	APPEND TO ARRAY:C911($aNotas;[Alumnos_Calificaciones:208]P01_Final_Nota:113)
	APPEND TO ARRAY:C911($aNotas;[Alumnos_Calificaciones:208]P02_Final_Nota:188)
	APPEND TO ARRAY:C911($aNotas;[Alumnos_Calificaciones:208]P03_Final_Nota:263)
	APPEND TO ARRAY:C911($aNotas;[Alumnos_Calificaciones:208]P04_Final_Nota:338)
	APPEND TO ARRAY:C911($aNotas;[Alumnos_Calificaciones:208]P05_Final_Nota:413)
	$promedio:=Round:C94(AT_Mean (->$aNotas;$modoCalculoPromedio);$decimalesPromedio)
	
	Case of 
		: (($promedio=0) & ($advertir_PPInexistentes))
			  //$idAlumno:=Abs([Alumnos_Calificaciones]ID_Alumno)
			  //$alumno:=KRL_GetTextFieldData (->[Alumnos]Número;->$idAlumno;->[Alumnos]Apellidos_y_Nombres)
			  //$curso:=KRL_GetTextFieldData (->[Alumnos_Histórico]Alumno_Numero;->$idAlumno;->[Alumnos_Histórico]Curso)
			  //$asignatura:=KRL_GetTextFieldData (->[Asignaturas_Histórico]ID_RegistroHistorico;->[Alumnos_Calificaciones]ID_HistoricoAsignatura;->[Asignaturas_Histórico]Asignatura)
			  //APPEND TO ARRAY($aErrores;"No hay promedios periódicos\t"+String([Alumnos_Calificaciones]Año)+Char(Tab )+$alumno+Char(Tab )+$curso+Char(Tab )+$asignatura+Char(Tab )+String([Alumnos_Calificaciones]P01_Final_Nota)+Char(Tab )+String([Alumnos_Calificaciones]P02_Final_Nota)+Char(Tab )+String([Alumnos_Calificaciones]P03_Final_Nota)+Char(Tab )+String([Alumnos_Calificaciones]P04_Final_Nota)+Char(Tab )+String([Alumnos_Calificaciones]P05_Final_Nota)+Char(Tab )+String([Alumnos_Calificaciones]Anual_Nota)+Char(Tab )+String($promedio)+Char(Tab )+String($promedio-[Alumnos_Calificaciones]Anual_Nota)+Char(Tab )+Char(Tab )+String([Alumnos_Calificaciones]ExamenAnual_Nota)+Char(Tab )+String([Alumnos_Calificaciones]EvaluacionFinalOficial_Nota))
			
		: (($promedio#[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33) & ($promedio>0) & ([Alumnos_Calificaciones:208]ExamenAnual_Nota:17<=0))
			$idAlumno:=Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
			$alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$idAlumno;->[Alumnos:2]apellidos_y_nombres:40)
			$curso:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$idAlumno;->[Alumnos:2]curso:20)
			$asignatura:=KRL_GetTextFieldData (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;->[Asignaturas_Historico:84]Asignatura:2)
			
			$nombreEnLista:=HL_FindInListByReference (hl_Diferencias;$idAlumno)
			If ($alumno#$nombreEnLista)
				$hl_asignaturas:=New list:C375
				APPEND TO LIST:C376($hl_asignaturas;$asignatura;-[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493)
				APPEND TO LIST:C376(hl_Diferencias;$alumno;$idAlumno;$hl_asignaturas;True:C214)
			Else 
				SELECT LIST ITEMS BY REFERENCE:C630(hl_Diferencias;$idAlumno)
				GET LIST ITEM:C378(hl_Diferencias;*;$idAlumno;$alumno;$hl_asignaturas)
				APPEND TO LIST:C376($hl_asignaturas;$asignatura;-[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493)
				SET LIST ITEM:C385(hl_Diferencias;$idAlumno;$alumno;$idAlumno;$hl_asignaturas;True:C214)
			End if 
			
		: (($promedio#[Alumnos_Calificaciones:208]Anual_Nota:12) & ($promedio>0) & ([Alumnos_Calificaciones:208]ExamenAnual_Nota:17>0))
			$idAlumno:=Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
			$alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$idAlumno;->[Alumnos:2]apellidos_y_nombres:40)
			$curso:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$idAlumno;->[Alumnos:2]curso:20)
			$asignatura:=KRL_GetTextFieldData (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;->[Asignaturas_Historico:84]Asignatura:2)
			  //$infoKey:=String([Alumnos_Calificaciones]Año)+"."+String($idAlumno)+
			
			$nombreEnLista:=HL_FindInListByReference (hl_Diferencias;$idAlumno)
			If ($alumno#$nombreEnLista)
				$hl_asignaturas:=New list:C375
				APPEND TO LIST:C376($hl_asignaturas;$asignatura;-[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493)
				APPEND TO LIST:C376(hl_Diferencias;$alumno;$idAlumno;$hl_asignaturas;True:C214)
			Else 
				SELECT LIST ITEMS BY REFERENCE:C630(hl_Diferencias;$idAlumno)
				GET LIST ITEM:C378(hl_Diferencias;*;$idAlumno;$alumno;$hl_asignaturas)
				APPEND TO LIST:C376($hl_asignaturas;$asignatura;-[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493)
				SET LIST ITEM:C385(hl_Diferencias;$idAlumno;$alumno;$idAlumno;$hl_asignaturas;True:C214)
			End if 
			
			APPEND TO ARRAY:C911($aErrores;"Diferencia\t"+String:C10([Alumnos_Calificaciones:208]Año:3)+Char:C90(Tab:K15:37)+$alumno+Char:C90(Tab:K15:37)+$curso+Char:C90(Tab:K15:37)+$asignatura+Char:C90(Tab:K15:37)+String:C10([Alumnos_Calificaciones:208]P01_Final_Nota:113)+Char:C90(Tab:K15:37)+String:C10([Alumnos_Calificaciones:208]P02_Final_Nota:188)+Char:C90(Tab:K15:37)+String:C10([Alumnos_Calificaciones:208]P03_Final_Nota:263)+Char:C90(Tab:K15:37)+String:C10([Alumnos_Calificaciones:208]P04_Final_Nota:338)+Char:C90(Tab:K15:37)+String:C10([Alumnos_Calificaciones:208]P05_Final_Nota:413)+Char:C90(Tab:K15:37)+String:C10([Alumnos_Calificaciones:208]Anual_Nota:12)+Char:C90(Tab:K15:37)+String:C10($promedio)+Char:C90(Tab:K15:37)+String:C10($promedio-[Alumnos_Calificaciones:208]Anual_Nota:12)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+String:C10([Alumnos_Calificaciones:208]ExamenAnual_Nota:17)+Char:C90(Tab:K15:37)+String:C10([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33))
	End case 
	
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);"Verificando promedios finales en registros de evaluación históricos...\r"+String:C10($i)+" / "+String:C10(Size of array:C274($aRecNums)))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

If (Count list items:C380(hl_Diferencias)>0)
	FORM GOTO PAGE:C247(2)
Else 
	CD_Dlog (0;__ ("No se encontró ninguna diferencia en los promedios"))
End if 
