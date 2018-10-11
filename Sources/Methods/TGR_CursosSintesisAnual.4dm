//%attributes = {}
  //TGR_CursosSintesisAnual

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			
			$l_numCruso:=Abs:C99([Cursos_SintesisAnual:63]ID_Curso:52)  //MONO 184433
			$l_rmCurso:=Find in field:C653([Cursos:3]Numero_del_curso:6;[Cursos_SintesisAnual:63]ID_Curso:52)
			If (([Cursos_SintesisAnual:63]Año:2=<>gYear) & ($l_rmCurso>=0))  //MONO 184433--Los id de los cursos van cambiando si se van promoviendo así que un id de sintesis anual que no encuentre su curso es la sintesis de un curso ya promovido
				[Cursos_SintesisAnual:63]ID_Curso:52:=$l_numCruso  //MONO 184433
			Else 
				[Cursos_SintesisAnual:63]ID_Curso:52:=-($l_numCruso)  //MONO 184433
			End if 
			
			[Cursos_SintesisAnual:63]LLavePrimaria:6:=KRL_MakeStringAccesKey (->[Cursos_SintesisAnual:63]ID_Institucion:1;->[Cursos_SintesisAnual:63]Año:2;->[Cursos_SintesisAnual:63]NumeroNivel:3;->[Cursos_SintesisAnual:63]Curso:5;->$l_numCruso)  //MONO 184433
			[Cursos_SintesisAnual:63]P01_Promedio_Real:27:=-10
			[Cursos_SintesisAnual:63]P01_Promedio_Nota:28:=-10
			[Cursos_SintesisAnual:63]P01_Promedio_Puntos:29:=-10
			[Cursos_SintesisAnual:63]P01_Promedio_Simbolo:30:=""
			[Cursos_SintesisAnual:63]P01_Promedio_Literal:31:=""
			[Cursos_SintesisAnual:63]P02_Promedio_Real:32:=-10
			[Cursos_SintesisAnual:63]P02_Promedio_Nota:33:=-10
			[Cursos_SintesisAnual:63]P02_Promedio_Puntos:34:=-10
			[Cursos_SintesisAnual:63]P02_Promedio_Simbolo:35:=""
			[Cursos_SintesisAnual:63]P02_Promedio_Literal:36:=""
			[Cursos_SintesisAnual:63]P03_Promedio_Real:37:=-10
			[Cursos_SintesisAnual:63]P03_Promedio_Nota:38:=-10
			[Cursos_SintesisAnual:63]P03_Promedio_Puntos:39:=-10
			[Cursos_SintesisAnual:63]P03_Promedio_Simbolo:40:=""
			[Cursos_SintesisAnual:63]P03_Promedio_Literal:41:=""
			[Cursos_SintesisAnual:63]P04_Promedio_Real:42:=-10
			[Cursos_SintesisAnual:63]P04_Promedio_Nota:43:=-10
			[Cursos_SintesisAnual:63]P04_Promedio_Puntos:44:=-10
			[Cursos_SintesisAnual:63]P04_Promedio_Simbolo:45:=""
			[Cursos_SintesisAnual:63]P04_Promedio_Literal:46:=""
			[Cursos_SintesisAnual:63]P05_Promedio_Real:47:=-10
			[Cursos_SintesisAnual:63]P05_Promedio_Nota:48:=-10
			[Cursos_SintesisAnual:63]P05_Promedio_Puntos:49:=-10
			[Cursos_SintesisAnual:63]P05_Promedio_Simbolo:50:=""
			[Cursos_SintesisAnual:63]P05_Promedio_Literal:51:=""
			[Cursos_SintesisAnual:63]PromedioAnual_Real:12:=-10
			[Cursos_SintesisAnual:63]PromedioAnual_Nota:13:=-10
			[Cursos_SintesisAnual:63]PromedioAnual_Puntos:14:=-10
			[Cursos_SintesisAnual:63]PromedioAnual_Simbolo:15:=""
			[Cursos_SintesisAnual:63]PromedioAnual_Literal:16:=""
			[Cursos_SintesisAnual:63]PromedioFinal_Real:17:=-10
			[Cursos_SintesisAnual:63]PromedioFinal_Nota:18:=-10
			[Cursos_SintesisAnual:63]PromedioFinal_Puntos:19:=-10
			[Cursos_SintesisAnual:63]PromedioFinal_Simbolo:20:=""
			[Cursos_SintesisAnual:63]PromedioFinal_Literal:21:=""
			[Cursos_SintesisAnual:63]PromedioOficial_Real:22:=-10
			[Cursos_SintesisAnual:63]PromedioOficial_Nota:23:=-10
			[Cursos_SintesisAnual:63]PromedioOficial_Puntos:24:=-10
			[Cursos_SintesisAnual:63]PromedioOficial_Simbolo:25:=""
			[Cursos_SintesisAnual:63]PromedioOficial_Literal:26:=""
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			$l_numCruso:=Abs:C99([Cursos_SintesisAnual:63]ID_Curso:52)  //MONO 184433
			$l_rmCurso:=Find in field:C653([Cursos:3]Numero_del_curso:6;[Cursos_SintesisAnual:63]ID_Curso:52)
			If (([Cursos_SintesisAnual:63]Año:2=<>gYear) & ($l_rmCurso>=0))  //MONO 184433--Los id de los cursos van cambiando si se van promoviendo así que un id de sintesis anual que no encuentre su curso es la sintesis de un curso ya promovido
				[Cursos_SintesisAnual:63]ID_Curso:52:=$l_numCruso  //MONO 184433
			Else 
				[Cursos_SintesisAnual:63]ID_Curso:52:=-($l_numCruso)  //MONO 184433
			End if 
			
			[Cursos_SintesisAnual:63]LLavePrimaria:6:=KRL_MakeStringAccesKey (->[Cursos_SintesisAnual:63]ID_Institucion:1;->[Cursos_SintesisAnual:63]Año:2;->[Cursos_SintesisAnual:63]NumeroNivel:3;->[Cursos_SintesisAnual:63]Curso:5;->$l_numCruso)  //MONO 184433
			Case of 
				: (<>vs_AppDecimalSeparator=",")
					[Cursos_SintesisAnual:63]P01_Promedio_Literal:31:=Replace string:C233([Cursos_SintesisAnual:63]P01_Promedio_Literal:31;".";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]P02_Promedio_Literal:36:=Replace string:C233([Cursos_SintesisAnual:63]P02_Promedio_Literal:36;".";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]P03_Promedio_Literal:41:=Replace string:C233([Cursos_SintesisAnual:63]P03_Promedio_Literal:41;".";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]P04_Promedio_Literal:46:=Replace string:C233([Cursos_SintesisAnual:63]P04_Promedio_Literal:46;".";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]P05_Promedio_Literal:51:=Replace string:C233([Cursos_SintesisAnual:63]P05_Promedio_Literal:51;".";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]PromedioAnual_Literal:16:=Replace string:C233([Cursos_SintesisAnual:63]PromedioAnual_Literal:16;".";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]PromedioFinal_Literal:21:=Replace string:C233([Cursos_SintesisAnual:63]PromedioFinal_Literal:21;".";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]PromedioOficial_Literal:26:=Replace string:C233([Cursos_SintesisAnual:63]PromedioOficial_Literal:26;".";<>vs_AppDecimalSeparator)
					
				: (<>vs_AppDecimalSeparator=".")
					[Cursos_SintesisAnual:63]P01_Promedio_Literal:31:=Replace string:C233([Cursos_SintesisAnual:63]P01_Promedio_Literal:31;",";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]P02_Promedio_Literal:36:=Replace string:C233([Cursos_SintesisAnual:63]P02_Promedio_Literal:36;",";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]P03_Promedio_Literal:41:=Replace string:C233([Cursos_SintesisAnual:63]P03_Promedio_Literal:41;",";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]P04_Promedio_Literal:46:=Replace string:C233([Cursos_SintesisAnual:63]P04_Promedio_Literal:46;",";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]P05_Promedio_Literal:51:=Replace string:C233([Cursos_SintesisAnual:63]P05_Promedio_Literal:51;",";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]PromedioAnual_Literal:16:=Replace string:C233([Cursos_SintesisAnual:63]PromedioAnual_Literal:16;",";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]PromedioFinal_Literal:21:=Replace string:C233([Cursos_SintesisAnual:63]PromedioFinal_Literal:21;",";<>vs_AppDecimalSeparator)
					[Cursos_SintesisAnual:63]PromedioOficial_Literal:26:=Replace string:C233([Cursos_SintesisAnual:63]PromedioOficial_Literal:26;",";<>vs_AppDecimalSeparator)
					
			End case 
			
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 