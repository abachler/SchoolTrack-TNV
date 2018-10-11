//%attributes = {}
  //CFG_ADT_DefEt

CFG_OpenConfigPanel (->[xxSTR_Constants:1];"ADTcfg_Grupos")
PST_SaveParameters 

If (cb_noActualizarGrupos=0)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando grupos en candidatos..."))
	
	  //para actualizar los grupos de los candidatos
	  //verifico el intervalo de fechas y actualizo los grupos de los candidatos
	ARRAY LONGINT:C221($records;0)
	READ WRITE:C146([ADT_Candidatos:49])
	ALL RECORDS:C47([ADT_Candidatos:49])
	LONGINT ARRAY FROM SELECTION:C647([ADT_Candidatos:49];$records;"")
	
	For ($i;1;Size of array:C274($records))
		GOTO RECORD:C242([ADT_Candidatos:49];$records{$i})
		
		READ ONLY:C145([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
		
		For ($j;1;Size of array:C274(adPST_FromDate))
			
			If (([Alumnos:2]Fecha_de_nacimiento:7>adPST_FromDate{$j}) & ([Alumnos:2]Fecha_de_nacimiento:7<adPST_ToDate{$j}))
				
				[ADT_Candidatos:49]Grupo:21:=atPST_GroupName{$j}
				SAVE RECORD:C53([ADT_Candidatos:49])
			End if 
		End for 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($records);__ ("Actualizando grupos en candidatos..."))
	End for 
	
	KRL_UnloadReadOnly (->[ADT_Candidatos:49])
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 


  //For ($i;1;Size of array(atPST_GroupName))
  //If (atPST_GroupName{$i}#atPST_OriginalGroupNames{$i})
  //READ WRITE([ADT_Candidatos])
  //QUERY([ADT_Candidatos];[ADT_Candidatos]Grupo=atPST_OriginalGroupNames{$i})
  //APPLY TO SELECTION([ADT_Candidatos];[ADT_Candidatos]Grupo:=atPST_GroupName{$i})
  //KRL_UnloadReadOnly (->[ADT_Candidatos])
  //End if 
  //CD_THERMOMETRE (0;$i/Size of array(atPST_GroupName)*100;"Actualizando grupos en candidatos...")
  //End for 

  //AT_Initialize (->atPST_OriginalGroupNames)
PST_ReadParameters 