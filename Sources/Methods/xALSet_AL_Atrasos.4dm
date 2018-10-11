//%attributes = {}
  //xALSET_AL_Atrasos
C_LONGINT:C283($modo_asistencia;$1;$enterable)
$modo_asistencia:=$1

  //AL_RemoveArrays (xALP_ConductaAlumnos;1;11)
AL_RemoveArrays (xALP_ConductaAlumnos;1;20)

If ($modo_asistencia=2)
	If (vi_RegistrarMinutosEnAtrasos>0)
		If (vi_RegistrarMinutosEnAtrasos=2)  //fracción.159627
			$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;9;"◊aCdtaDate";"◊aCdtaText1";"aCdtaBoolean1";"at_fraccion";"at_hora_atraso";"at_NombreJustificacion";"ab_justificado";"at_atrasoAsig";"◊aCdtaRecNo")  //MONO 180505
			AL_SetHeaders (xALP_ConductaAlumnos;1;8;__ ("Fecha");__ ("Observaciones");__ ("Tipo de Atraso");__ ("Fracción");__ ("Hora");__ ("Motivo Justificación");__ ("Justificado");__ ("Asignatura"))  //MONO 180505
			AL_SetWidths (xALP_ConductaAlumnos;1;8;50;300;108;50;60;80;55;60)  //MONO 180505
			  //AL_SetFormat (xALP_ConductaAlumnos;4;"##0")
			AL_SetFormat (xALP_ConductaAlumnos;7;"Si;No")
			AL_SetEnterable (xALP_ConductaAlumnos;4;0)  ///cuando es fraccion se debe mostrar menú y no editar 159627
			AL_SetEnterable (xALP_ConductaAlumnos;8;0)  //Asignatura no es editable//MONO 180505
			justificado:=7
		Else 
			$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;9;"◊aCdtaDate";"◊aCdtaText1";"aCdtaBoolean1";"al_alMinutosAtraso";"at_hora_atraso";"at_NombreJustificacion";"ab_justificado";"at_atrasoAsig";"◊aCdtaRecNo")  //MONO 180505
			AL_SetHeaders (xALP_ConductaAlumnos;1;8;__ ("Fecha");__ ("Observaciones");__ ("Tipo de Atraso");__ ("Minutos");__ ("Hora");__ ("Motivo Justificación");__ ("Justificado");__ ("Asignatura"))  //MONO 180505
			AL_SetWidths (xALP_ConductaAlumnos;1;8;50;300;108;50;60;80;55;60)  //MONO 180505
			AL_SetFormat (xALP_ConductaAlumnos;4;"##0")
			AL_SetFormat (xALP_ConductaAlumnos;7;"Si;No")
			AL_SetEnterable (xALP_ConductaAlumnos;8;0)  //Asignatura no es editable//MONO 180505
			justificado:=7
		End if 
	Else 
		$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;8;"◊aCdtaDate";"◊aCdtaText1";"aCdtaBoolean1";"at_hora_atraso";"at_NombreJustificacion";"ab_justificado";"at_atrasoAsig";"◊aCdtaRecNo")  //MONO 180505
		AL_SetHeaders (xALP_ConductaAlumnos;1;7;__ ("Fecha");__ ("Observaciones");__ ("Tipo de Atraso");__ ("Hora");__ ("Motivo Justificación");__ ("Justificado");__ ("Asignatura"))  //MONO 180505
		AL_SetWidths (xALP_ConductaAlumnos;1;7;50;300;108;60;80;55;120)  //MONO 180505
		AL_SetFormat (xALP_ConductaAlumnos;6;"Si;No")
		AL_SetEnterable (xALP_ConductaAlumnos;7;0)  //Asignatura no es editable//MONO 180505
		justificado:=6
	End if 
Else 
	If (vi_RegistrarMinutosEnAtrasos>0)
		If (vi_RegistrarMinutosEnAtrasos=2)  //fracción.159627
			$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;9;"◊aCdtaDate";"◊aCdtaText1";"aCdtaBoolean1";"at_fraccion";"at_hora_atraso";"at_NombreJustificacion";"ab_justificado";"at_atrasoAsig";"◊aCdtaRecNo")  //MONO 180505
			AL_SetHeaders (xALP_ConductaAlumnos;1;8;__ ("Fecha");__ ("Observaciones");__ ("Tipo de Atraso");__ ("Fracción");__ ("Hora");__ ("Motivo Justificación");__ ("Justificado");__ ("Asignatura"))  //MONO 180505
			AL_SetWidths (xALP_ConductaAlumnos;1;8;50;300;108;50;60;80;55;60)  //MONO 180505
			  //AL_SetFormat (xALP_ConductaAlumnos;4;"")//sin formato en la columna cuando es fraccion 
			AL_SetFormat (xALP_ConductaAlumnos;7;"Si;No")
			AL_SetEnterable (xALP_ConductaAlumnos;4;0)  ///cuando es fraccion se debe mostrar menú y no editar 159627
			AL_SetEnterable (xALP_ConductaAlumnos;8;0)  //Asignatura no es editable//MONO 180505
			justificado:=6
		Else 
			$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;9;"◊aCdtaDate";"◊aCdtaText1";"aCdtaBoolean1";"al_alMinutosAtraso";"at_hora_atraso";"at_NombreJustificacion";"ab_justificado";"at_atrasoAsig";"◊aCdtaRecNo")  //MONO 180505
			AL_SetHeaders (xALP_ConductaAlumnos;1;8;__ ("Fecha");__ ("Observaciones");__ ("Tipo de Atraso");__ ("Minutos");__ ("Hora");__ ("Motivo Justificación");__ ("Justificado");__ ("Asignatura"))  //MONO 180505
			AL_SetWidths (xALP_ConductaAlumnos;1;8;50;300;108;50;60;80;55;60)  //MONO 180505
			AL_SetFormat (xALP_ConductaAlumnos;4;"##0")
			AL_SetFormat (xALP_ConductaAlumnos;7;"Si;No")
			AL_SetEnterable (xALP_ConductaAlumnos;8;0)  //Asignatura no es editable//MONO 180505
			justificado:=6
		End if 
	Else 
		$err:=AL_SetArraysNam (xALP_ConductaAlumnos;1;7;"◊aCdtaDate";"◊aCdtaText1";"aCdtaBoolean1";"at_NombreJustificacion";"ab_justificado";"at_atrasoAsig";"◊aCdtaRecNo")
		AL_SetHeaders (xALP_ConductaAlumnos;1;6;__ ("Fecha");__ ("Observaciones");__ ("Tipo de Atraso");__ ("Motivo Justificación");__ ("Justificado");__ ("Asignatura"))  //MONO 180505
		AL_SetWidths (xALP_ConductaAlumnos;1;6;45;370;108;80;55;120)
		AL_SetFormat (xALP_ConductaAlumnos;5;"Si;No")
		AL_SetEnterable (xALP_ConductaAlumnos;6;0)  //Asignatura no es editable//MONO 180505
		justificado:=5
	End if 
End if 

AL_SetSort (xALP_ConductaAlumnos;-1)
AL_SetColOpts (xALP_ConductaAlumnos;0;0;0;1;0;0;0)
AL_SetRowOpts (xALP_ConductaAlumnos;0;1;0;0;1)
AL_SetSortOpts (xALP_ConductaAlumnos;0;1;1;"Ordenamiento";1)
AL_SetDividers (xALP_ConductaAlumnos;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetStyle (xALP_ConductaAlumnos;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_ConductaAlumnos;0;"Tahoma";9;1)
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
	AL_SetEnterable (xALP_ConductaAlumnos;3;$enterable)
	
	If (vi_RegistrarMinutosEnAtrasos=2)
		AL_SetEnterable (xALP_ConductaAlumnos;4;0)
	Else 
		AL_SetEnterable (xALP_ConductaAlumnos;4;$enterable)
	End if 
	
	AL_SetEnterable (xALP_ConductaAlumnos;(justificado-1);0)
	AL_SetEnterable (xALP_ConductaAlumnos;justificado;$enterable)
	AL_SetEntryOpts (xALP_ConductaAlumnos;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
	AL_SetCallbacks (xALP_ConductaAlumnos;"xALCB_EN_Atrasos";"xALCB_EX_Atrasos")
Else 
	AL_SetEnterable (xALP_ConductaAlumnos;0;0)
End if 

ALP_SetDefaultAppareance (xALP_ConductaAlumnos;0;2)
AL_SetInterface (xALP_ConductaAlumnos;AL Force OSX Interface;1;1;0;60;1)

AL_SetLine (xALP_ConductaAlumnos;0)
AL_SetFormat (xALP_ConductaAlumnos;3;"Inter sesiones;Inicio Jornada")

For ($i;1;Size of array:C274(<>aCdtaRecNo))
	AL_SetRowColor (xALP_ConductaAlumnos;$i;"Black")
End for 
AL_UpdateArrays (xALP_ConductaAlumnos;-2)