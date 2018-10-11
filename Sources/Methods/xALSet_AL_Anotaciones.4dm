//%attributes = {}
  //xALSET_AL_Anotaciones


  //AL_RemoveArrays (xALP_ConductaAlumnos;1;11)
AL_RemoveArrays (xALP_ConductaAlumnos;1;20)
  //$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;9;"adSTRal_FechaAnotacion";"atSTRal_CategoriaAnotacion";"atSTRal_MotivoAnotacion";"alSTRal_PuntosAnotacion";"atSTRal_NotasAnotacion";"atSTRal_NombreProfesorAnot";"alSTRal_NoProfesorAnot";"alSTRal_RecNumItemAnotacion";"atSTRal_TipoAnotacion")
$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;9;"adSTRal_FechaAnotacion";"atSTRal_CategoriaAnotacion";"atSTRal_MotivoAnotacion";"alSTRal_PuntosAnotacion";"atSTRal_NotasAnotacion";"atSTRal_NombreProfesorAnot";"alSTRal_NoProfesorAnot";"<>aCdtaRecNo";"atSTRal_TipoAnotacion")
AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;3;0;0;0)
AL_SetRowOpts (xALP_ConductaAlumnos;0;1;0;0;1)
AL_SetSortOpts (xALP_ConductaAlumnos;0;1;1;"Ordenamiento";1)
AL_SetDividers (xALP_ConductaAlumnos;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetStyle (xALP_ConductaAlumnos;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_ConductaAlumnos;0;"Tahoma";9;1)
AL_SetHeaders (xALP_ConductaAlumnos;1;6;__ ("Fecha");__ ("Categoria");__ ("Motivo");__ ("Puntos");__ ("Observaciones");__ ("Profesor"))
AL_SetWidths (xALP_ConductaAlumnos;1;6;70;120;246;40;190;110)
AL_SetFormat (xALP_ConductaAlumnos;4;"####";2)
AL_SetHeight (xALP_ConductaAlumnos;1;2;2;0;0;0)
AL_SetMiscOpts (xALP_ConductaAlumnos;0;0;"'";0;1)
AL_SetEnterable (xALP_ConductaAlumnos;0)
If (vl_Year=<>gYear)
	If (<>vb_BloquearModifSituacionFinal)
		$enterable:=0
	Else 
		If ((USR_checkRights ("M";->[Alumnos_Conducta:8])) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36))
			$enterable:=1
		End if 
	End if 
	AL_SetEnterable (xALP_ConductaAlumnos;1;$enterable)
	AL_SetEnterable (xALP_ConductaAlumnos;5;$enterable)
	AL_SetEnterable (xALP_ConductaAlumnos;6;$enterable)
	AL_SetEntryOpts (xALP_ConductaAlumnos;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
	AL_SetCallbacks (xALP_ConductaAlumnos;"xALCB_EN_Anotaciones";"xALCB_EX_Anotaciones")
Else 
	AL_SetEnterable (xALP_ConductaAlumnos;0;0)
End if 


ALP_SetDefaultAppareance (xALP_ConductaAlumnos;0;2)
AL_SetInterface (xALP_ConductaAlumnos;AL Force OSX Interface;1;1;0;60;1)

AL_SetLine (xALP_ConductaAlumnos;0)

AL_SetSort (xALP_ConductaAlumnos;-1)
For ($i;1;Size of array:C274(<>aCdtaRecNo))
	Case of 
		: (atSTRal_TipoAnotacion{$i}="-")
			AL_SetRowColor (xALP_ConductaAlumnos;$i;"Red")
		: (atSTRal_TipoAnotacion{$i}="=")
			AL_SetRowColor (xALP_ConductaAlumnos;$i;"Blue")
		: (atSTRal_TipoAnotacion{$i}="+")
			AL_SetRowColor (xALP_ConductaAlumnos;$i;"Green")
	End case 
End for 