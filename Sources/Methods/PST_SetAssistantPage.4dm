//%attributes = {}
  //PST_SetAssistantPage

  //C_LONGINT($result;$records)
  //bNext:=0
  //bPrev:=0
  //Case of 
  //: (vi_currentPage=2)
  //For ($i;1;Size of array(atPST_GroupName))
  //If ((adPST_FromDate{$i}#!00/00/00!) & (adPST_ToDate{$i}#!00/00/00!))
  //SET QUERY DESTINATION(Into variable ;$result)
  //QUERY([ADT_Candidatos];[ADT_Candidatos]Grupo=atPST_GroupName{$i})
  //  `      QUERY([Alumnos];[Alumnos]No_Nivel=-4;*)
  //  `        QUERY([Alumnos]; & [Alumnos]Nacido el>=adPST_FromDate{$i};*)
  //  `        QUERY([Alumnos]; & [Alumnos]Nacido el<=adPST_ToDate{$i})      
  //SET QUERY DESTINATION(Into current selection )
  //aiPST_Candidates{$i}:=$result
  //End if 
  //End for 
  //AL_UpdateArrays (xALP_ExaminationsGroups;-2)
  //AL_SetLine (xALP_ExaminationsGroups;0)
  //: (vi_currentPage=4)
  //For ($i;1;Size of array(adPST_PresentDate))
  //$secs:=SYS_DateTime2Secs (adPST_PresentDate{$i};aLPST_PresentTime{$i})
  //READ ONLY([ADT_Candidatos])
  //QUERY([ADT_Candidatos];[ADT_Candidatos]secs_Presentación=$secs)
  //SELECTION TO ARRAY([ADT_Candidatos]Asistentes_presentación;aInt1)
  //aiPST_Asistentes{$i}:=AT_GetSumArray (->aInt1)
  //End for 
  //
  //AL_SetLine (xALP_Presentations;0)
  //AL_UpdateArrays (xALP_Presentations;-2)
  //: (vi_CurrentPage=5)
  //
  //If (viPST_VariableExSesions=1)
  //viPST_FixedEXSesions:=0
  //SET VISIBLE(*;"Fixed";False)
  //Else 
  //viPST_FixedEXSesions:=1
  //SET VISIBLE(*;"Fixed";True)
  //End if 
  //READ ONLY([ADT_Candidatos])
  //READ WRITE([ADT_SesionesDeExamenes])
  //ALL RECORDS([ADT_SesionesDeExamenes])
  //While (Not(End selection([ADT_SesionesDeExamenes])))
  //SET QUERY DESTINATION(3;$records)
  //QUERY([ADT_Candidatos];[ADT_Candidatos]ID_Sesión=[ADT_SesionesDeExamenes]ID)
  //[ADT_SesionesDeExamenes]Attendance:=$records
  //SET QUERY DESTINATION(0)
  //SAVE RECORD([ADT_SesionesDeExamenes])
  //NEXT RECORD([ADT_SesionesDeExamenes])
  //End while 
  //AL_UpdateFields (xALP_Exams;2)
  //AL_SetSort (xALP_Exams;1)
  //
  //If (viPST_AutoAsigExam=0)
  //viPST_DontAsigExamJF:=0
  //DISABLE BUTTON(viPST_DontAsigExamJF)
  //Else 
  //ENABLE BUTTON(viPST_DontAsigExamJF)
  //End if 
  //End case 