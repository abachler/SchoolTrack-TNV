//%attributes = {}
  //UD_v20120814_SIGECodNivel 
If (<>vtXS_CountryCode="cl")
	
	ARRAY LONGINT:C221($al_rn_cursos;0)
	C_LONGINT:C283($i)
	READ ONLY:C145([Cursos:3])
	QUERY:C277([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21=10;*)
	QUERY:C277([Cursos:3]; | ;[Cursos:3]cl_CodigoTipoEnseñanza:21=310;*)
	QUERY:C277([Cursos:3]; | ;[Cursos:3]cl_CodigoTipoEnseñanza:21=410;*)
	QUERY:C277([Cursos:3]; | ;[Cursos:3]cl_CodigoTipoEnseñanza:21=510;*)
	QUERY:C277([Cursos:3]; | ;[Cursos:3]cl_CodigoTipoEnseñanza:21=610;*)
	QUERY:C277([Cursos:3]; | ;[Cursos:3]cl_CodigoTipoEnseñanza:21=710;*)
	QUERY:C277([Cursos:3]; | ;[Cursos:3]cl_CodigoTipoEnseñanza:21=810;*)
	QUERY:C277([Cursos:3]; | ;[Cursos:3]cl_CodigoTipoEnseñanza:21=910)
	
	LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_rn_cursos;"")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Reparando codigos de nivel Chile ...")
	
	For ($i;1;Size of array:C274($al_rn_cursos))
		READ WRITE:C146([Cursos:3])
		GOTO RECORD:C242([Cursos:3];$al_rn_cursos{$i})
		If ([Cursos:3]cl_CodigoTipoEnseñanza:21=10)
			[Cursos:3]cl_CodigoNivelEspecial:36:=String:C10(6+[Cursos:3]Nivel_Numero:7)
		Else 
			[Cursos:3]cl_CodigoNivelEspecial:36:=String:C10([Cursos:3]Nivel_Numero:7-8)
		End if 
		SAVE RECORD:C53([Cursos:3])
		KRL_UnloadReadOnly (->[Cursos:3])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_rn_cursos))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
End if 