//%attributes = {}
  //PST_SetExamsArea

  //C_BOOLEAN($expanded)
  //C_LONGINT($subList;$ref)
  //C_STRING(255;$LABEL)
  //AL_UpdateArrays (xALP_Groups;0)
  //
  //ARRAY TEXT(atPST_SelEXmGroupNames;0)
  //ARRAY LONGINT(aLPST_SelEXmID;0)
  //ARRAY STRING(2;asPST_SelEXmSections;0)
  //ARRAY INTEGER(aiPST_SelEXmTotal;0)
  //ARRAY REAL(aLPST_SelEXmSecs;0)
  //
  //
  //If ((vl_SelectedItemRef=3) | (vl_SelectedItemRef=-1))
  //If (Size of array(adPst_ExamSesionsDate)>0)
  //GET LIST ITEM(hl_Postulaciones;List item position(hl_Postulaciones;3);$ref;$label;$sublist;$expanded)
  //SET LIST ITEM(hl_Postulaciones;$ref;$label;$ref;$subList;True)
  //vt_MNGmsg:=RP_GetIdxString (21403;23)
  //Else 
  //vt_MNGmsg:=RP_GetIdxString (21403;22)
  //End if 
  //SET VISIBLE(*;"exams@";False)
  //SET VISIBLE(vt_MNGmsg;True)
  //ARRAY TEXT(atPST_SelEXmGroupNames;0)
  //ARRAY LONGINT(aiPST_SelEXmGroupID;0)
  //AL_UpdateArrays (xALP_Groups;0)
  //Else 
  //vdPST_SelectedExamDate:=adPst_ExamSesionsDate{$1-30}
  //vLPST_SelectedSesionID:=aLPST_SesionID{$1-30}
  //
  //QUERY([ADT_Examenes];[ADT_Examenes]ID_Sesion=vLPST_SelectedSesionID)
  //ORDER BY([ADT_Examenes];[ADT_Examenes]Group;>)
  //SELECTION TO ARRAY([ADT_Examenes]ID;aLPST_SelEXmID;[ADT_Examenes]Group;atPST_SelEXmGroupNames;[ADT_Examenes]Time_Exam;aLPST_SelEXmTime;[ADT_Examenes]Secs;aLPST_SelEXmSecs;[ADT_Examenes]Date_Exam;adPST_SelEXmDate)
  //For ($i;Size of array(atPST_SelEXmGroupNames);2;-1)
  //If (atPST_SelEXmGroupNames{$i}=atPST_SelEXmGroupNames{$i-1})
  //AT_Delete ($i;1;->aLPST_SelEXmID;->atPST_SelEXmGroupNames;->aLPST_SelEXmTime;->aLPST_SelEXmSecs;->adPST_SelEXmDate)
  //End if 
  //End for 
  //
  //SET VISIBLE(*;"exams@";True)
  //SET VISIBLE(vt_MNGmsg;False)
  //AL_SetSort (xALP_Groups;1)
  //AL_UpdateArrays (xALP_Groups;-2)
  //If (Size of array(atPST_SelEXmGroupNames)>0)
  //AL_SetLine (xALP_Groups;1)
  //PST_ListSections (1)
  //End if 
  //End if 
  //
  //GOTO PAGE(2)
