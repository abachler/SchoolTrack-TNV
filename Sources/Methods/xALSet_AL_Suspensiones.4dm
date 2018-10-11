//%attributes = {}
  //xALSET_AL_Suspensiones


  //AL_RemoveArrays (xALP_ConductaAlumnos;1;11)
AL_RemoveArrays (xALP_ConductaAlumnos;1;20)
$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;7;"◊aCdtaDate";"◊aCdtaDate2";"◊aCdtaText1";"◊aCdtaText2";"◊aCdtaText3";"◊aCdtaLong1";"◊aCdtaRecNo")
AL_SetSort (xALP_ConductaAlumnos;-1)
AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;2;0;0;0)
AL_SetRowOpts (xALP_ConductaAlumnos;0;1;0;0;1)
AL_SetSortOpts (xALP_ConductaAlumnos;0;1;1;"Ordenamiento";1)
AL_SetDividers (xALP_ConductaAlumnos;"Black";"Light Gray";0;"Black";"Light Gray";0)
If (SYS_IsMacintosh )
	AL_SetStyle (xALP_ConductaAlumnos;0;"Tahoma";9;0)
	AL_SetHdrStyle (xALP_ConductaAlumnos;0;"Tahoma";9;1)
Else 
	AL_SetStyle (xALP_ConductaAlumnos;0;"Arial";9;0)
	AL_SetHdrStyle (xALP_ConductaAlumnos;0;"Arial";9;1)
End if 
AL_SetHeaders (xALP_ConductaAlumnos;1;5;__ ("Desde");__ ("Hasta");__ ("Motivo");__ ("Observaciones");__ ("Profesor"))
AL_SetWidths (xALP_ConductaAlumnos;1;5;55;55;110;448;110)
AL_SetHeight (xALP_ConductaAlumnos;1;2;2;0;0;0)
AL_SetMiscOpts (xALP_ConductaAlumnos;0;0;"'";0;1)
If (vl_Year=<>gYear)
	If (<>vb_BloquearModifSituacionFinal)
		$enterable:=0
	Else 
		If ((USR_checkRights ("M";->[Alumnos_Conducta:8])) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36))
			$enterable:=1
		End if 
	End if 
	AL_SetEnterable (xALP_ConductaAlumnos;1;$enterable)
	AL_SetEnterable (xALP_ConductaAlumnos;2;$enterable)
	AL_SetEnterable (xALP_ConductaAlumnos;3;$enterable;atSTRal_MotivosSuspension)
	AL_SetEnterable (xALP_ConductaAlumnos;4;$enterable)
	AL_SetEnterable (xALP_ConductaAlumnos;5;$enterable)
	AL_SetEntryOpts (xALP_ConductaAlumnos;3;0)
	AL_SetCallbacks (xALP_ConductaAlumnos;"xALCB_EN_Suspensiones";"xALCB_EX_Suspensiones")
Else 
	AL_SetEntryOpts (xALP_ConductaAlumnos;0;0)
End if 
AL_UpdateArrays (xALP_ConductaAlumnos;Size of array:C274(<>aCdtaRecNo))

ALP_SetDefaultAppareance (xALP_ConductaAlumnos;0;2)
AL_SetInterface (xALP_ConductaAlumnos;AL Force OSX Interface;1;1;0;60;1)

AL_SetLine (xALP_ConductaAlumnos;0)
AL_SetScroll (xALP_ConductaAlumnos;0;-3)


For ($i;1;Size of array:C274(<>aCdtaRecNo))
	AL_SetRowColor (xALP_ConductaAlumnos;$i;"Red")
End for 