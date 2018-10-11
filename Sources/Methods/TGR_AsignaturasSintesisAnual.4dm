//%attributes = {}
  // Método: TGR_AsignaturasSintesisAnual
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:07:40
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

  // Código principal


If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			
			$t_llaveAsigHistorica:=String:C10(<>gInstitucion)+"."+String:C10(<>gyear)+"."+String:C10(Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2))  //MONO 184433
			$l_rnAsigHist:=Find in field:C653([Asignaturas_Historico:84]LlavePrimaria:9;$t_llaveAsigHistorica)  //MONO 184433
			
			If (([Asignaturas_SintesisAnual:202]Año:3=<>gYear) & ($l_rnAsigHist=-1))  //MONO 184433
				[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2)
			Else 
				[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=-Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2)
			End if 
			[Asignaturas_SintesisAnual:202]LLavePrimaria:5:=String:C10([Asignaturas_SintesisAnual:202]ID_Institucion:1)+"."+String:C10([Asignaturas_SintesisAnual:202]Año:3)+"."+String:C10(Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2))
			
			[Asignaturas_SintesisAnual:202]PromedioAnual_Real:10:=-10
			[Asignaturas_SintesisAnual:202]PromedioAnual_Nota:11:=-10
			[Asignaturas_SintesisAnual:202]PromedioAnual_Puntos:12:=-10
			[Asignaturas_SintesisAnual:202]PromedioAnual_Simbolo:13:=""
			[Asignaturas_SintesisAnual:202]PromedioAnual_Literal:14:=""
			[Asignaturas_SintesisAnual:202]PromedioFinal_Real:15:=-10
			[Asignaturas_SintesisAnual:202]PromedioFinal_Nota:16:=-10
			[Asignaturas_SintesisAnual:202]PromedioFinal_Puntos:17:=-10
			[Asignaturas_SintesisAnual:202]PromedioFinal_Simbolo:18:=""
			[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19:=""
			[Asignaturas_SintesisAnual:202]PromedioOficial_Real:20:=-10
			[Asignaturas_SintesisAnual:202]PromedioOficial_Nota:21:=-10
			[Asignaturas_SintesisAnual:202]PromedioOficial_Puntos:22:=-10
			[Asignaturas_SintesisAnual:202]PromedioOficial_Simbolo:23:=""
			[Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24:=""
			[Asignaturas_SintesisAnual:202]P01_Promedio_Real:25:=-10
			[Asignaturas_SintesisAnual:202]P01_Promedio_Nota:26:=-10
			[Asignaturas_SintesisAnual:202]P01_Promedio_Puntos:27:=-10
			[Asignaturas_SintesisAnual:202]P01_Promedio_Simbolo:28:=""
			[Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29:=""
			[Asignaturas_SintesisAnual:202]P02_Promedio_Real:30:=-10
			[Asignaturas_SintesisAnual:202]P02_Promedio_Nota:31:=-10
			[Asignaturas_SintesisAnual:202]P02_Promedio_Puntos:32:=-10
			[Asignaturas_SintesisAnual:202]P02_Promedio_Simbolo:33:=""
			[Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34:=""
			[Asignaturas_SintesisAnual:202]P03_Promedio_Real:35:=-10
			[Asignaturas_SintesisAnual:202]P03_Promedio_Nota:36:=-10
			[Asignaturas_SintesisAnual:202]P03_Promedio_Puntos:37:=-10
			[Asignaturas_SintesisAnual:202]P03_Promedio_Simbolo:38:=""
			[Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39:=""
			[Asignaturas_SintesisAnual:202]P04_Promedio_Real:40:=-10
			[Asignaturas_SintesisAnual:202]P04_Promedio_Nota:41:=-10
			[Asignaturas_SintesisAnual:202]P04_Promedio_Puntos:42:=-10
			[Asignaturas_SintesisAnual:202]P04_Promedio_Simbolo:43:=""
			[Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44:=""
			[Asignaturas_SintesisAnual:202]P05_Promedio_Real:45:=-10
			[Asignaturas_SintesisAnual:202]P05_Promedio_Nota:46:=-10
			[Asignaturas_SintesisAnual:202]P05_Promedio_Puntos:47:=-10
			[Asignaturas_SintesisAnual:202]P05_Promedio_Simbolo:48:=""
			[Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49:=""
			[Asignaturas_SintesisAnual:202]P01_Minimo_Real:50:=-10
			[Asignaturas_SintesisAnual:202]P02_Minimo_Real:51:=-10
			[Asignaturas_SintesisAnual:202]P03_Minimo_Real:52:=-10
			[Asignaturas_SintesisAnual:202]P04_Minimo_Real:53:=-10
			[Asignaturas_SintesisAnual:202]P05_Minimo_Real:54:=-10
			[Asignaturas_SintesisAnual:202]P01_Minimo_Nota:55:=-10
			[Asignaturas_SintesisAnual:202]P02_Minimo_Nota:56:=-10
			[Asignaturas_SintesisAnual:202]P03_Minimo_Nota:57:=-10
			[Asignaturas_SintesisAnual:202]P04_Minimo_Nota:58:=-10
			[Asignaturas_SintesisAnual:202]P05_Minimo_Nota:59:=-10
			[Asignaturas_SintesisAnual:202]P01_Minimo_Puntos:60:=-10
			[Asignaturas_SintesisAnual:202]P02_Minimo_Puntos:61:=-10
			[Asignaturas_SintesisAnual:202]P03_Minimo_Puntos:62:=-10
			[Asignaturas_SintesisAnual:202]P04_Minimo_Puntos:63:=-10
			[Asignaturas_SintesisAnual:202]P05_Minimo_Puntos:64:=-10
			[Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65:=""
			[Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66:=""
			[Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67:=""
			[Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68:=""
			[Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69:=""
			[Asignaturas_SintesisAnual:202]P01_Minimo_Simbolo:70:=""
			[Asignaturas_SintesisAnual:202]P02_Minimo_Simbolo:71:=""
			[Asignaturas_SintesisAnual:202]P03_Minimo_Simbolo:72:=""
			[Asignaturas_SintesisAnual:202]P04_Minimo_Simbolo:73:=""
			[Asignaturas_SintesisAnual:202]P05_Minimo_Simbolo:74:=""
			[Asignaturas_SintesisAnual:202]Anual_Minimo_Real:75:=-10
			[Asignaturas_SintesisAnual:202]Anual_Minimo_Nota:76:=-10
			[Asignaturas_SintesisAnual:202]Anual_Minimo_Puntos:77:=-10
			[Asignaturas_SintesisAnual:202]Anual_Minimo_Simbolo:78:=""
			[Asignaturas_SintesisAnual:202]Anual_Minimo_Literal:79:=""
			[Asignaturas_SintesisAnual:202]Final_Minimo_Real:80:=-10
			[Asignaturas_SintesisAnual:202]Final_Minimo_Nota:81:=-10
			[Asignaturas_SintesisAnual:202]Final_Minimo_Puntos:82:=-10
			[Asignaturas_SintesisAnual:202]Final_Minimo_Simbolo:84:=""
			[Asignaturas_SintesisAnual:202]Final_Minimo_Literal:83:=""
			[Asignaturas_SintesisAnual:202]P01_Maximo_Real:85:=-10
			[Asignaturas_SintesisAnual:202]P02_Maximo_Real:86:=-10
			[Asignaturas_SintesisAnual:202]P03_Maximo_Real:87:=-10
			[Asignaturas_SintesisAnual:202]P04_Maximo_Real:88:=-10
			[Asignaturas_SintesisAnual:202]P05_Maximo_Real:89:=-10
			[Asignaturas_SintesisAnual:202]P01_Maximo_Nota:90:=-10
			[Asignaturas_SintesisAnual:202]P02_Maximo_Nota:91:=-10
			[Asignaturas_SintesisAnual:202]P03_Maximo_Nota:92:=-10
			[Asignaturas_SintesisAnual:202]P04_Maximo_Nota:93:=-10
			[Asignaturas_SintesisAnual:202]P05_Maximo_Nota:94:=-10
			[Asignaturas_SintesisAnual:202]P01_Maximo_Puntos:95:=-10
			[Asignaturas_SintesisAnual:202]P02_Maximo_Puntos:96:=-10
			[Asignaturas_SintesisAnual:202]P03_Maximo_Puntos:97:=-10
			[Asignaturas_SintesisAnual:202]P04_Maximo_Puntos:98:=-10
			[Asignaturas_SintesisAnual:202]P05_Maximo_Puntos:99:=-10
			[Asignaturas_SintesisAnual:202]P01_Maximo_Simbolo:100:=""
			[Asignaturas_SintesisAnual:202]P02_Maximo_Simbolo:101:=""
			[Asignaturas_SintesisAnual:202]P03_Maximo_Simbolo:102:=""
			[Asignaturas_SintesisAnual:202]P04_Maximo_Simbolo:103:=""
			[Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105:=""
			[Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106:=""
			[Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107:=""
			[Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108:=""
			[Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109:=""
			[Asignaturas_SintesisAnual:202]Anual_Maximo_Real:110:=-10
			[Asignaturas_SintesisAnual:202]Anual_Maximo_Nota:111:=-10
			[Asignaturas_SintesisAnual:202]Anual_Maximo_Puntos:112:=-10
			[Asignaturas_SintesisAnual:202]Anual_Maximo_Simbolo:113:=""
			[Asignaturas_SintesisAnual:202]Anual_Maximo_Literal:114:=""
			[Asignaturas_SintesisAnual:202]Final_Maximo_Real:115:=-10
			[Asignaturas_SintesisAnual:202]Final_Maximo_Nota:116:=-10
			[Asignaturas_SintesisAnual:202]Final_Maximo_Puntos:117:=-10
			[Asignaturas_SintesisAnual:202]Final_Maximo_Simbolo:118:=""
			[Asignaturas_SintesisAnual:202]Final_Maximo_Literal:119:=""
			[Asignaturas_SintesisAnual:202]P05_Maximo_Simbolo:104:=""
			[Asignaturas_SintesisAnual:202]PorcentajeAprobados:120:=100
			[Asignaturas_SintesisAnual:202]NumeroReprobados:121:=0
			[Asignaturas_SintesisAnual:202]Examen_Minimo_Real:122:=-10
			[Asignaturas_SintesisAnual:202]Examen_Minimo_Nota:123:=-10
			[Asignaturas_SintesisAnual:202]Examen_Minimo_Puntos:124:=-10
			[Asignaturas_SintesisAnual:202]Examen_Minimo_Simbolo:125:=""
			[Asignaturas_SintesisAnual:202]Examen_Minimo_Literal:126:=""
			[Asignaturas_SintesisAnual:202]Examen_Maximo_Real:127:=-10
			[Asignaturas_SintesisAnual:202]Examen_Maximo_Nota:128:=-10
			[Asignaturas_SintesisAnual:202]Examen_Maximo_Puntos:129:=-10
			[Asignaturas_SintesisAnual:202]Examen_Maximo_Simbolo:130:=""
			[Asignaturas_SintesisAnual:202]Examen_Maximo_Literal:131:=""
			[Asignaturas_SintesisAnual:202]Examen_Promedio_Real:132:=-10
			[Asignaturas_SintesisAnual:202]Examen_Promedio_Nota:133:=-10
			[Asignaturas_SintesisAnual:202]Examen_Promedio_Puntos:134:=-10
			[Asignaturas_SintesisAnual:202]Examen_Promedio_Simbolo:135:=""
			[Asignaturas_SintesisAnual:202]Examen_Promedio_Literal:136:=""
			[Asignaturas_SintesisAnual:202]Oficial_Minimo_Real:137:=-10
			[Asignaturas_SintesisAnual:202]Oficial_Minimo_Nota:138:=-10
			[Asignaturas_SintesisAnual:202]Oficial_Minimo_Puntos:139:=-10
			[Asignaturas_SintesisAnual:202]Oficial_Minimo_Simbolo:140:=""
			[Asignaturas_SintesisAnual:202]Oficial_Minimo_Literal:141:=""
			[Asignaturas_SintesisAnual:202]Oficial_Maximo_Real:142:=-10
			[Asignaturas_SintesisAnual:202]Oficial_Maximo_Nota:143:=-10
			[Asignaturas_SintesisAnual:202]Oficial_Maximo_Puntos:144:=-10
			[Asignaturas_SintesisAnual:202]Oficial_Maximo_Simbolo:145:=""
			[Asignaturas_SintesisAnual:202]Oficial_Maximo_Literal:146:=""
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			$t_llaveAsigHistorica:=String:C10(<>gInstitucion)+"."+String:C10(<>gyear)+"."+String:C10(Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2))  //MONO 184433
			$l_rnAsigHist:=Find in field:C653([Asignaturas_Historico:84]LlavePrimaria:9;$t_llaveAsigHistorica)  //MONO 184433
			
			If (([Asignaturas_SintesisAnual:202]Año:3=<>gYear) & ($l_rnAsigHist=-1))  //MONO 184433
				[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2)
			Else 
				[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=-Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2)
			End if 
			[Asignaturas_SintesisAnual:202]LLavePrimaria:5:=String:C10([Asignaturas_SintesisAnual:202]ID_Institucion:1)+"."+String:C10([Asignaturas_SintesisAnual:202]Año:3)+"."+String:C10(Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2))
			
			
			Case of 
				: (<>vs_AppDecimalSeparator=",")
					[Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29:=Replace string:C233([Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34:=Replace string:C233([Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39:=Replace string:C233([Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44:=Replace string:C233([Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49:=Replace string:C233([Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]PromedioAnual_Literal:14:=Replace string:C233([Asignaturas_SintesisAnual:202]PromedioAnual_Literal:14;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19:=Replace string:C233([Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24:=Replace string:C233([Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105:=Replace string:C233([Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106:=Replace string:C233([Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107:=Replace string:C233([Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108:=Replace string:C233([Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109:=Replace string:C233([Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Anual_Maximo_Literal:114:=Replace string:C233([Asignaturas_SintesisAnual:202]Anual_Maximo_Literal:114;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Final_Maximo_Literal:119:=Replace string:C233([Asignaturas_SintesisAnual:202]Final_Maximo_Literal:119;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Oficial_Maximo_Literal:146:=Replace string:C233([Asignaturas_SintesisAnual:202]Oficial_Maximo_Literal:146;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65:=Replace string:C233([Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66:=Replace string:C233([Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67:=Replace string:C233([Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68:=Replace string:C233([Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69:=Replace string:C233([Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Anual_Minimo_Literal:79:=Replace string:C233([Asignaturas_SintesisAnual:202]Anual_Minimo_Literal:79;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Final_Minimo_Literal:83:=Replace string:C233([Asignaturas_SintesisAnual:202]Final_Minimo_Literal:83;".";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Oficial_Minimo_Literal:141:=Replace string:C233([Asignaturas_SintesisAnual:202]Oficial_Minimo_Literal:141;".";<>vs_AppDecimalSeparator)
					
					
					
					
				: (<>vs_AppDecimalSeparator=".")
					[Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29:=Replace string:C233([Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34:=Replace string:C233([Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39:=Replace string:C233([Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44:=Replace string:C233([Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49:=Replace string:C233([Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]PromedioAnual_Literal:14:=Replace string:C233([Asignaturas_SintesisAnual:202]PromedioAnual_Literal:14;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19:=Replace string:C233([Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24:=Replace string:C233([Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105:=Replace string:C233([Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106:=Replace string:C233([Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107:=Replace string:C233([Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108:=Replace string:C233([Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109:=Replace string:C233([Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Anual_Maximo_Literal:114:=Replace string:C233([Asignaturas_SintesisAnual:202]Anual_Maximo_Literal:114;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Final_Maximo_Literal:119:=Replace string:C233([Asignaturas_SintesisAnual:202]Final_Maximo_Literal:119;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Oficial_Maximo_Literal:146:=Replace string:C233([Asignaturas_SintesisAnual:202]Oficial_Maximo_Literal:146;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65:=Replace string:C233([Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66:=Replace string:C233([Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67:=Replace string:C233([Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68:=Replace string:C233([Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69:=Replace string:C233([Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Anual_Minimo_Literal:79:=Replace string:C233([Asignaturas_SintesisAnual:202]Anual_Minimo_Literal:79;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Final_Minimo_Literal:83:=Replace string:C233([Asignaturas_SintesisAnual:202]Final_Minimo_Literal:83;",";<>vs_AppDecimalSeparator)
					[Asignaturas_SintesisAnual:202]Oficial_Minimo_Literal:141:=Replace string:C233([Asignaturas_SintesisAnual:202]Oficial_Minimo_Literal:141;",";<>vs_AppDecimalSeparator)
					
					
					
					
			End case 
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	SN3_MarcarRegistros (SN3_DTi_Asignaturas)
End if 



