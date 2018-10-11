C_LONGINT:C283(hl_EstilosEvaluacion;hl_EstilosActuales;hl_EstilosHistoricos;vi_lastGradeView)


Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If (<>vtXS_CountryCode#"cl")
			OBJECT SET TITLE:C194(*;"calificaciones_enActas";__ ("Asignatura Oficial"))
		Else 
			OBJECT SET VISIBLE:C603(*;"AprobacionDiferida@";False:C215)
		End if 
		
		Case of 
			: (<>vtXS_CountryCode="pe")
				OBJECT SET TITLE:C194(*;"calificaciones24";__ ("Taller"))
		End case 
		
		vt_Text2:=""
		vs_SubjectName:=""
		[Alumnos_Calificaciones:208]Año:3:=[Alumnos_SintesisAnual:210]Año:2
		[Alumnos_Calificaciones:208]ID_Alumno:6:=[Alumnos_SintesisAnual:210]ID_Alumno:4
		[Alumnos_Calificaciones:208]ID_institucion:2:=<>gInstitucion
		[Alumnos_Calificaciones:208]NIvel_Numero:4:=[Alumnos_SintesisAnual:210]NumeroNivel:6
		PERIODOS_Init 
		PERIODOS_LeeDatosHistoricos ([Alumnos_Historico:25]Nivel:11;[Alumnos_SintesisAnual:210]Año:2)
		
		If ([Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25#0)
			OBJECT SET ENTERABLE:C238(*;"calificaciones@";False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(*;"calificaciones@";True:C214)
		End if 
		
		
		If (viSTR_Periodos_NumeroPeriodos=0)
			CD_Dlog (0;__ ("No se encontró una configuración de períodos histórica para este nivel/año.\r\rSe utilizará la configuración de períodos para este nivel en el año actual."))
			PERIODOS_LoadData ([Alumnos_Historico:25]Nivel:11)
		End if 
		
		vLabelP1:=""
		vLabelP2:=""
		vLabelP3:=""
		vLabelP4:=""
		vLabelP5:=""
		
		Case of 
			: (viSTR_Periodos_NumeroPeriodos=2)
				vLabelP1:="1S"
				vLabelP2:="2S"
				OBJECT SET VISIBLE:C603(vLabelP1;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP2;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP3;False:C215)
				OBJECT SET VISIBLE:C603(vLabelP4;False:C215)
				OBJECT SET VISIBLE:C603(vLabelP5;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Literal:116;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Literal:191;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Literal:266;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Literal:341;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Literal:416;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Real:112;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Real:187;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Real:262;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Real:337;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Real:412;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Nota:113;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Nota:188;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Nota:263;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Nota:338;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Nota:413;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Puntos:114;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Puntos:189;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Puntos:264;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Puntos:339;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Puntos:414;False:C215)
				
			: (viSTR_Periodos_NumeroPeriodos=3)
				vLabelP1:="1T"
				vLabelP2:="2T"
				vLabelP3:="3T"
				OBJECT SET VISIBLE:C603(vLabelP1;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP2;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP3;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP4;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Literal:116;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Literal:191;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Literal:266;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Literal:341;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Literal:416;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Real:112;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Real:187;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Real:262;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Real:337;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Real:412;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Nota:113;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Nota:188;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Nota:263;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Nota:338;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Nota:413;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Puntos:114;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Puntos:189;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Puntos:264;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Puntos:339;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Puntos:414;False:C215)
				
			: (viSTR_Periodos_NumeroPeriodos=4)
				vLabelP1:="1B"
				vLabelP2:="2B"
				vLabelP3:="3B"
				vLabelP4:="4B"
				OBJECT SET VISIBLE:C603(vLabelP1;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP2;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP3;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP4;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Literal:116;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Literal:191;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Literal:266;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Literal:341;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Literal:416;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Real:112;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Real:187;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Real:262;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Real:337;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Real:412;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Nota:113;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Nota:188;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Nota:263;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Nota:338;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Nota:413;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Puntos:114;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Puntos:189;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Puntos:264;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Puntos:339;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Puntos:414;False:C215)
				
			: (viSTR_Periodos_NumeroPeriodos=5)
				vLabelP1:="1B"
				vLabelP2:="2B"
				vLabelP3:="3B"
				vLabelP4:="4B"
				vLabelP5:="5B"
				OBJECT SET VISIBLE:C603(vLabelP1;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP2;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP3;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP4;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP5;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Literal:116;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Literal:191;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Literal:266;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Literal:341;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Literal:416;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Real:112;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Real:187;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Real:262;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Real:337;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Real:412;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Nota:113;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Nota:188;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Nota:263;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Nota:338;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Nota:413;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Puntos:114;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Puntos:189;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Puntos:264;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Puntos:339;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Puntos:414;True:C214)
		End case 
		
		$formatPercent:="###"+<>tXS_RS_DecimalSeparator+"##; "
		OBJECT SET FORMAT:C236(*;"Porcentajes@";$formatPercent)
		
		Case of 
			: (((<>vtXS_CountryCode="ar") | (<>vtXS_CountryCode="co")) & (([Alumnos_Calificaciones:208]Reprobada:9) | ([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_1:52#"") | ([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_2:53#"") | ([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_3:54#"")))
				OBJECT SET VISIBLE:C603(*;"recuperacion@";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"recuperacion@";False:C215)
		End case 
		
		OBJECT SET ENTERABLE:C238(*;"calificaciones@";False:C215)
		OBJECT SET ENTERABLE:C238(*;"AprobacionDiferida@";False:C215)
		OBJECT SET ENTERABLE:C238([Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88;False:C215)
		OBJECT SET VISIBLE:C603(*;"vLabel@";True:C214)
		OBJECT SET ENABLED:C1123(*;"calificaciones@";True:C214)
		
		
		
		If (<>vtXS_CountryCode#"cl")
			OBJECT SET TITLE:C194(*;"calificacionesenActas";__ ("Asignatura Oficial"))
		Else 
			OBJECT SET VISIBLE:C603(*;"AprobacionDiferida@";False:C215)
		End if 
		
		OBJECT SET VISIBLE:C603(*;"estiloEvaluacion@";True:C214)
		OBJECT SET VISIBLE:C603(*;"notasHistoricas@";False:C215)
		
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hl_EstilosEvaluacion;hl_EstilosActuales;hl_EstilosHistoricos)
		
	: (Form event:C388=On Clicked:K2:4)
		If ([Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25=0)
			OBJECT SET ENTERABLE:C238(*;"calificaciones@";False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(*;"calificaciones@";True:C214)
		End if 
		If ([Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25#0)
			OBJECT SET VISIBLE:C603(*;"msg";False:C215)
		End if 
		REDRAW:C174([Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88)
		
		
		REDRAW WINDOW:C456
	: ((Form event:C388=On Data Change:K2:15))
		
		REDRAW:C174([Asignaturas_Historico:84]Historial_de_Cambios:40)
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 

OBJECT SET ENABLED:C1123(bSave;Records in selection:C76([Asignaturas_Historico:84])>0)
OBJECT SET ENTERABLE:C238(*;"calificaciones@";Records in selection:C76([Asignaturas_Historico:84])>0)
OBJECT SET ENABLED:C1123(*;"calificaciones@";Records in selection:C76([Asignaturas_Historico:84])>0)
