//%attributes = {}
  //UD_v20120611_CL_JornadaCode
  //Según la información dada por el ministerio ahora las jornadas son:  1 (MAÑANA), 2 (TARDE), 3 (MAÑANA Y TARDE) y 4 (VESPERTINA/NOCTURNA). 
  //Ticket 103242 comentario 17-05-2012 16:09:33

If (<>vtXS_CountryCode="cl")
	READ WRITE:C146([Cursos:3])
	ALL RECORDS:C47([Cursos:3])
	ARRAY LONGINT:C221($al_rn_curso;0)
	LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_rn_curso;"")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando códigos de jornada...")
	For ($i;1;Size of array:C274($al_rn_curso))
		GOTO RECORD:C242([Cursos:3];$al_rn_curso{$i})
		
		Case of 
			: ([Cursos:3]Jornada:32=1)  //ex mañana y tarde
				[Cursos:3]Jornada:32:=3
			: ([Cursos:3]Jornada:32=2)  //ex mañana 
				[Cursos:3]Jornada:32:=1
			: ([Cursos:3]Jornada:32=3)  //ex tarde
				[Cursos:3]Jornada:32:=2
		End case 
		SAVE RECORD:C53([Cursos:3])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_rn_curso))
	End for 
	KRL_UnloadReadOnly (->[Cursos:3])
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 