//%attributes = {}
  //ALh_RecalcHistoric

If (<>vtXS_CountryCode="cl")
	EV2_RegistrosDelAlumno ([Alumnos_Historico:25]Alumno_Numero:1;[Alumnos_Historico:25]Nivel:11;[Alumnos_Historico:25]Año:2;<>gInstitucion)
	If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$aNotaOficial;[Asignaturas_Historico:84]Promediable:6;$aInAv)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		$sum:=0
		$div:=0
		For ($i;1;Size of array:C274($aNotaOficial))
			If ($aInAv{$i})
				$nValue:=$aNotaOficial{$i}
				$div:=$div+Num:C11($nValue>0)
				If ($nValue>0)
					$sum:=$sum+$nValue
				End if 
			End if 
		End for 
		$key:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Historico:25]Año:2)+"."+String:C10([Alumnos_Historico:25]Nivel:11)+"."+String:C10([Alumnos_Historico:25]Alumno_Numero:1)
		$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
		If ($recNum>=0)
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26:=Round:C94($sum/$div;1)
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=EV2_Numerico_a_Literal ([Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26;1;1)
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25:=Round:C94([Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26/7*100;1)
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Historico:25]Alumno_Numero:1)
			If (Year of:C25([Alumnos:2]Fecha_de_retiro:42)=[Alumnos_Historico:25]Año:2)
				[Alumnos_SintesisAnual:210]SituacionFinal:8:="Y"
			End if 
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
		End if 
	End if 
	SAVE RECORD:C53([Alumnos_Historico:25])
	KRL_UnloadReadOnly (->[Alumnos_Historico:25])
End if 