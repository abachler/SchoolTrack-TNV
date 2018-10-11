//%attributes = {}
  //xALSET_AL_Licencias


  //AL_RemoveArrays (xALP_ConductaAlumnos;1;11)
AL_RemoveArrays (xALP_ConductaAlumnos;1;20)
$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;6;"◊aCdtaDate";"◊aCdtaDate2";"◊aCdtaText1";"◊aCdtaText2";"◊aCdtaRecNo";"◊aCdtaMod")
AL_SetSort (xALP_ConductaAlumnos;-1)
AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;2;0;0;0)
AL_SetRowOpts (xALP_ConductaAlumnos;0;1;0;0;1)
AL_SetSortOpts (xALP_ConductaAlumnos;0;1;1;"Ordenamiento";1)
AL_SetDividers (xALP_ConductaAlumnos;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetStyle (xALP_ConductaAlumnos;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_ConductaAlumnos;0;"Tahoma";9;1)
AL_SetHeaders (xALP_ConductaAlumnos;1;4;__ ("Desde");__ ("Hasta");__ ("Tipo Lic.");__ ("Observaciones"))
AL_SetWidths (xALP_ConductaAlumnos;1;5;55;55;137;530)
AL_SetHeight (xALP_ConductaAlumnos;1;2;2;0;0;0)
AL_SetMiscOpts (xALP_ConductaAlumnos;0;0;"'";0;1)
AL_SetEnterable (xALP_ConductaAlumnos;1;0)
AL_SetEnterable (xALP_ConductaAlumnos;2;0)
AL_SetEnterable (xALP_ConductaAlumnos;3;0)
If (vl_Year=<>gYear)
	If (<>vb_BloquearModifSituacionFinal)
		$enterable:=0
	Else 
		If ((USR_checkRights ("M";->[Alumnos_Conducta:8])) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36))
			$enterable:=1
		End if 
	End if 
	AL_SetEnterable (xALP_ConductaAlumnos;4;$enterable)
	AL_SetCallbacks (xALP_ConductaAlumnos;"";"xALCB_EX_Licencias")
Else 
	AL_SetEnterable (xALP_ConductaAlumnos;4;0)
End if 

AL_SetEntryOpts (xALP_ConductaAlumnos;3;0;0;0;0;<>tXS_RS_DecimalSeparator)  //20160608 RCH. Faltaba definir esto. Si se entraba directo a esta página o a asistencia por hora detallada pasaba siempre esto.
ALP_SetDefaultAppareance (xALP_ConductaAlumnos;0;2)
AL_SetLine (xALP_ConductaAlumnos;0)

For ($i;1;Size of array:C274(<>aCdtaRecNo))
	AL_SetRowColor (xALP_ConductaAlumnos;$i;"Blue")
End for 
