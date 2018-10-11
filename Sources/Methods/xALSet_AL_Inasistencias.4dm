//%attributes = {}
  //xALSET_AL_Inasistencias


  //AL_RemoveArrays (xALP_ConductaAlumnos;1;11)
AL_RemoveArrays (xALP_ConductaAlumnos;1;20)
$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;5;"<>aCdtaDate";"<>aCdtaText1";"<>aCdtaText2";"<>aCdtaRecNo";"◊aCdtaLong1")
AL_SetSort (xALP_ConductaAlumnos;-1)
AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;2;0;0;0)
AL_SetRowOpts (xALP_ConductaAlumnos;0;1;0;0;1)
AL_SetSortOpts (xALP_ConductaAlumnos;0;1;1;"Ordenamiento";1)
AL_SetDividers (xALP_ConductaAlumnos;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetStyle (xALP_ConductaAlumnos;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_ConductaAlumnos;0;"Tahoma";9;1)
AL_SetHeaders (xALP_ConductaAlumnos;1;3;__ ("Fecha");__ ("Licencia o aut.");__ ("Observaciones"))
AL_SetWidths (xALP_ConductaAlumnos;1;3;60;120;597)
AL_SetHeight (xALP_ConductaAlumnos;1;2;2;0;0;0)
AL_SetMiscOpts (xALP_ConductaAlumnos;0;0;"'";0)
AL_SetMiscOpts (xALP_ConductaAlumnos;0;0;"'";0;1)


If (vl_year=<>gYear)
	If (<>vb_BloquearModifSituacionFinal)
		$enterable:=0
	Else 
		If ((USR_checkRights ("M";->[Alumnos_Conducta:8])) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36))
			$enterable:=1
		End if 
	End if 
	AL_SetEntryOpts (xALP_ConductaAlumnos;3;0)
	AL_SetEnterable (xALP_ConductaAlumnos;1;0)
	AL_SetEnterable (xALP_ConductaAlumnos;2;0)
	AL_SetEnterable (xALP_ConductaAlumnos;3;$enterable)
	AL_SetCallbacks (xALP_ConductaAlumnos;"xALCB_EN_Inasistencias";"xALCB_EX_Inasistencias")
Else 
	AL_SetEnterable (xALP_ConductaAlumnos;0;0)
End if 

ALP_SetDefaultAppareance (xALP_ConductaAlumnos;0;2)
AL_SetLine (xALP_ConductaAlumnos;0)

For ($i;1;Size of array:C274(<>aCdtaRecNo))
	If (<>aCdtaText1{$i}="")
		AL_SetRowColor (xALP_ConductaAlumnos;$i;"Red")
	Else 
		AL_SetRowColor (xALP_ConductaAlumnos;$i;"Black")
	End if 
End for 