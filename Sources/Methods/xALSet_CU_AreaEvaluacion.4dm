//%attributes = {}
  //xALSet_CU_AreaEvaluacion


  //Configuration commands for ALP object CUx_EvVal
$err:=AL_SetArraysNam (xALP_EvaluacionPersonal;1;8;"aNtaStdNme";"aNtaCurso";"aNta1";"aNta2";"aNta3";"aNta4";"aNta5";"aNta6")
AL_SetHeaders (xALP_EvaluacionPersonal;1;8;__ ("Alumno");__ ("Curso");<>aAbrevVal{1};<>aAbrevVal{2};<>aAbrevVal{3};<>aAbrevVal{4};<>aAbrevVal{5};<>aAbrevVal{6})
ALP_SetDefaultAppareance (xALP_EvaluacionPersonal;9;1;6;1;8)
AL_SetInterface (xALP_EvaluacionPersonal;AL Force OSX Interface;1;1;0;60;1)

AL_SetColOpts (xALP_EvaluacionPersonal;0;3;0;0;0;0;0)
AL_SetMiscOpts (xALP_EvaluacionPersonal;0;0;"'";0;1)
AL_SetSortOpts (xALP_EvaluacionPersonal;0;0;0;"";0)
AL_SetRowOpts (xALP_EvaluacionPersonal;1;0;0;0;0)

  //20141202 RCH
AL_SetWidths (xALP_EvaluacionPersonal;1;8;204;50;88;88;88;88;88;88)
AL_SetWidths (xALP_EvaluacionPersonal;1;8;204;50;87;87;87;87;87;87)

AL_SetScroll (xALP_EvaluacionPersonal;0;-3)
If ((USR_checkRights ("M";->[Alumnos_EvaluacionValorica:23])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
	AL_SetEntryOpts (xALP_EvaluacionPersonal;2;0;0;1;2;<>tXS_RS_DecimalSeparator)
	AL_SetEnterable (xALP_EvaluacionPersonal;1;0)
	AL_SetEnterable (xALP_EvaluacionPersonal;2;0)
	For ($i;3;8)
		$enterable:=Num:C11((<>aAbrevVal{$i-2}#""))
		AL_SetEnterable (xALP_EvaluacionPersonal;$i;$enterable)
	End for 
	AL_SetCallbacks (xALP_EvaluacionPersonal;"";"xALCB_EX_EvaluacionValores")
End if 

  //20141202 RCH
AL_SetColLock (xALP_EvaluacionPersonal;2)