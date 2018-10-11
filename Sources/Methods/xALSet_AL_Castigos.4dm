//%attributes = {}
  //xALSET_AL_Castigos

  //AL_RemoveArrays (xALP_ConductaAlumnos;1;11)
AL_RemoveArrays (xALP_ConductaAlumnos;1;20)
$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;8;"◊aCdtaDate";"◊aCdtaText1";"◊aCdtaText2";"◊aCdtaText3";"◊aCdtaNum1";"◊aCdtaBool";"◊aCdtaLong1";"◊aCdtaRecNo")
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
AL_SetHeaders (xALP_ConductaAlumnos;1;6;__ ("Fecha");__ ("Motivo");__ ("Observaciones");__ ("Profesor");__ ("Hrs");__ ("Cumplido"))
AL_SetWidths (xALP_ConductaAlumnos;1;6;55;200;300;110;30;82)
AL_SetFormat (xALP_ConductaAlumnos;5;"#####";0;0;0;0)
AL_SetFormat (xALP_ConductaAlumnos;6;"Si;No";1;1;1;0)
If (vl_Year=<>gYear)
	If (<>vb_BloquearModifSituacionFinal)
		$enterable:=0
	Else 
		If ((USR_checkRights ("M";->[Alumnos_Conducta:8])) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36))
			$enterable:=1
		End if 
	End if 
	AL_SetEnterable (xALP_ConductaAlumnos;1;0)
	  //cambio ingreso manual a ingreso segun listado de las medidas, debido a que no se visualizan de manera correcta
	  //ticket 149034 27-8-2015    JVP
	  //AL_SetEnterable (xALP_ConductaAlumnos;2;2;atSTRal_MotivosCastigo)
	AL_SetEnterable (xALP_ConductaAlumnos;2;0)
	AL_SetEnterable (xALP_ConductaAlumnos;3;$enterable)
	AL_SetEnterable (xALP_ConductaAlumnos;4;$enterable)
	AL_SetEnterable (xALP_ConductaAlumnos;5;$enterable)
	AL_SetFilter (xALP_ConductaAlumnos;5;"&9")
	AL_SetEnterable (xALP_ConductaAlumnos;6;$enterable)
	AL_SetEntryCtls (xALP_ConductaAlumnos;6;0)
	AL_SetEntryOpts (xALP_ConductaAlumnos;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
	AL_SetCallbacks (xALP_ConductaAlumnos;"xALCB_EN_Castigos";"xALCB_EX_Castigos")
Else 
	AL_SetEnterable (xALP_ConductaAlumnos;0;0)
End if 

ALP_SetDefaultAppareance (xALP_ConductaAlumnos;0;2)
AL_SetInterface (xALP_ConductaAlumnos;AL Force OSX Interface;1;1;0;60;1)

AL_SetLine (xALP_ConductaAlumnos;0)

For ($i;1;Size of array:C274(<>aCdtaRecNo))
	AL_SetRowColor (xALP_ConductaAlumnos;$i;"Red")
End for 
