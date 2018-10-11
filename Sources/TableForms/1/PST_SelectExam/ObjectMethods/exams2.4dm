$fEvent:=Form event:C388
  //atADT_place
_O_C_INTEGER:C282($cantidad)
_O_C_INTEGER:C282($inicial)
$cantidad:=Size of array:C274(atPST_LugarExamen)
$inicial:=1


$fEvent:=Form event:C388
Case of 
	: ($fEvent=On Load:K2:1)
		Case of 
			: (iPST_DistributeBySex=0)
				$max:=iPST_MaxPerSection
				$arrPtr:=->aiPST_SelEXmTotal
			: ([Alumnos:2]Sexo:49="F")
				$max:=iPST_MaxPerSection/2
				$arrPtr:=->aiPST_SelEXmGirls
			: ([Alumnos:2]Sexo:49="M")
				$max:=iPST_MaxPerSection/2
				$arrPtr:=->aiPST_SelEXmBoys
		End case 
		For ($i;1;Size of array:C274(adPST_SelEXmDate))
			$asistants:=$arrPtr->{$i}
			Case of 
				: (aiPST_SelEXmTotal{$i}>=iPST_MaxPerSection)
					AL_SetRowColor (Self:C308->;$i;"";4;"";161)
				: ($asistants>=$max)
					AL_SetRowColor (Self:C308->;$i;"";3;"";161)
				Else 
					AL_SetRowColor (Self:C308->;$i;"";7;"";161)
			End case 
			
			If (IDS_Examen{$i}=[ADT_Candidatos:49]ID_Exam:29)
				viPST_CurrentExamID:=[ADT_Candidatos:49]ID_Exam:29
				AL_SetRowStyle (Self:C308->;$i;1;"Tahoma")
			Else 
				AL_SetRowStyle (Self:C308->;$i;0;"Tahoma")
			End if 
		End for 
		AL_SetLine (Self:C308->;0)  //hightlight la columna 0
		  //AL_SetSort (Self->;8;1)  `
	: (alProEvt=2)
		$line:=AL_GetLine (Self:C308->)
		
		[ADT_Candidatos:49]ID_Exam:29:=IDS_Examen{$line}
		[ADT_Candidatos:49]Fecha_de_examen:7:=adPST_SelEXmDate{$line}
		[ADT_Candidatos:49]Hora_de_examen:19:=ALPST_SelEXmTime{$line}
		[ADT_Candidatos:49]Sección:26:=asPST_SelEXmSections{$line}
		
		  //consultar en ADT_Examenes
		
		QUERY:C277([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]ID:1=aLPST_SelEXmID{$line})
		[ADT_Candidatos:49]ID_Examinador:53:=[ADT_SesionesDeExamenes:123]ID_Responsable:7
		[ADT_Candidatos:49]Examinador:8:=[ADT_SesionesDeExamenes:123]Responsable:6
		SAVE RECORD:C53([ADT_Candidatos:49])
		  //READ ONLY([Profesores])
		  //QUERY([Profesores];[Profesores]Número=[ADT_Candidatos]ID_Examinador)
		  //[ADT_Candidatos]ID_Examinador:=[Profesores]Número
		ACCEPT:C269
End case 