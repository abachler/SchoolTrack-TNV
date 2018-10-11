$actualSize:=Size of array:C274(atPST_GroupName)

Case of 
	: ($actualSize<iPst_groups)
		$startAT:=AT_Maximum (->aiPST_GroupID)+1
		AT_Insert ($startAt;iPst_groups-Size of array:C274(atPST_GroupName);->atPST_GroupName;->adPST_FromDate;->adPST_ToDate;->aiPST_GroupID;->aiPST_Candidates;->aiPST_ExamTime;->aiPST_Cupos)
		$counter:=1
		For ($i;$actualSize+1;Size of array:C274(atPST_GroupName))
			aiPST_GroupID{$i}:=$startAT+$counter
			atPST_GroupName{$i}:="Grupo "+String:C10($i)
			$counter:=$counter+1
		End for 
		PST_CreateExamSesions 
	: (iPst_groups<Size of array:C274(atPST_GroupName))
		$elementsTodelete:=$actualSize-Self:C308->
		OK:=CD_Dlog (0;__ ("Usted disminuyó el numero de grupos. Esto implica eliminar grupos que podrían tener aspirantes asignados. Para evitar errores solo serán eliminados los grupos sin postulantes asignados. ");__ ("");__ ("Sí");__ ("Cancelar"))
		If (ok=1)
			ARRAY LONGINT:C221($aIDSessionInvolved;0)
			For ($i;$actualSize;1;-1)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
				QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Grupo:21=atPST_GroupName{$i})
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($recs=0)
					QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=atPST_GroupName{$i})
					ARRAY LONGINT:C221($examenes;0)
					LONGINT ARRAY FROM SELECTION:C647([ADT_Examenes:122];$examenes;"")
					$preventDelete:=False:C215
					READ WRITE:C146([ADT_Examenes:122])
					For ($m;1;Size of array:C274($examenes))
						GOTO RECORD:C242([ADT_Examenes:122];$examenes{$m})
						If ([ADT_Examenes:122]Total:11=0)
							APPEND TO ARRAY:C911($aIDSessionInvolved;[ADT_Examenes:122]ID_Sesion:12)
							DELETE RECORD:C58([ADT_Examenes:122])
						Else 
							$preventDelete:=True:C214
							$m:=Size of array:C274($examenes)+1
						End if 
					End for 
					KRL_UnloadReadOnly (->[ADT_Examenes:122])
					$elementsTodelete:=$elementsTodelete-1
					If (Not:C34($preventDelete))
						AT_Delete ($i;1;->atPST_GroupName;->adPST_FromDate;->adPST_ToDate;->aiPST_GroupID;->aiPST_Candidates;->aiPST_ExamTime;->aiPST_Cupos)
					End if 
					If ($elementsTodelete=0)
						$i:=0
					End if 
				End if 
			End for 
			If (Size of array:C274($aIDSessionInvolved)>0)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
				For ($i;Size of array:C274($aIDSessionInvolved);1;-1)
					QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]ID_Sesion:12=$aIDSessionInvolved{$i})
					If ($recs#0)
						DELETE FROM ARRAY:C228($aIDSessionInvolved;$i;1)
					End if 
				End for 
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				QUERY WITH ARRAY:C644([ADT_SesionesDeExamenes:123]ID:1;$aIDSessionInvolved)
				KRL_DeleteSelection (->[ADT_SesionesDeExamenes:123];False:C215)
				READ ONLY:C145([ADT_SesionesDeExamenes:123])
			End if 
		End if 
		iPst_groups:=Size of array:C274(atPST_GroupName)
End case 

Case of 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Losing Focus:K2:8))
		
		  //si se puede cambiar la cantidad máxima de postulantes
		If (VMaximoPostulantesEnterable=1)
			
			  //calculo los aspirantes por seccion
			iPST_MaxPerSection:=Int:C8(iPST_MaxCandidates/(iPST_Groups*iPST_Sections))
		Else 
			  //calculo el máximo de candidatos
			iPST_MaxCandidates:=iPST_Groups*iPST_Sections*iPST_MaxPerSection
		End if 
		
End case 

