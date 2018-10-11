If (Self:C308->>0)
	$sexLimit:=Self:C308->-1
	If ($sexLimit#[MPA_DefinicionCompetencias:187]RestriccionSexo:27)
		Case of 
			: ($sexLimit=1)
				$sex:="F"
			: ($sexLimit=2)
				$sex:="M"
		End case 
		If ($sexLimit>0)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_DefinicionCompetencias:187]ID:1;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos:2]Sexo:49#$sex)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
		End if 
		[MPA_DefinicionCompetencias:187]RestriccionSexo:27:=$sexLimit
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
	End if 
Else 
	
End if 