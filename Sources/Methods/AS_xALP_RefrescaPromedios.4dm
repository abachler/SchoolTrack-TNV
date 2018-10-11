//%attributes = {}
  // AS_xALP_RefrescaPromedios()
  // Por: Alberto Bachler K.: 01-02-14, 16:25:16
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_fila:=$1

Case of 
	: ((iViewMode=Notas) & (iPrintMode#iViewMode))
		
		aNtaP1{$l_fila}:=[Alumnos_Calificaciones:208]P01_Final_Literal:116
		aNtaP2{$l_fila}:=[Alumnos_Calificaciones:208]P02_Final_Literal:191
		aNtaP3{$l_fila}:=[Alumnos_Calificaciones:208]P03_Final_Literal:266
		aNtaP4{$l_fila}:=[Alumnos_Calificaciones:208]P04_Final_Literal:341
		aNtaP5{$l_fila}:=[Alumnos_Calificaciones:208]P05_Final_Literal:416
		aNtaPF{$l_fila}:=[Alumnos_Calificaciones:208]Anual_Literal:15
		aNtaF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		
		If ([Alumnos_Calificaciones:208]P01_Final_Real:112>=vrNTA_MinimoEscalaReferencia)
			If (iGradesDecPP>0)
				aNtaP1{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P01_Final_Nota:113;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPP))
			Else 
				aNtaP1{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P01_Final_Nota:113)
			End if 
		End if 
		If ([Alumnos_Calificaciones:208]P02_Final_Real:187>=vrNTA_MinimoEscalaReferencia)
			If (iGradesDecPP>0)
				aNtaP2{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P02_Final_Nota:188;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPP))
			Else 
				aNtaP2{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P02_Final_Nota:188)
			End if 
		End if 
		If ([Alumnos_Calificaciones:208]P03_Final_Real:262>=vrNTA_MinimoEscalaReferencia)
			If (iGradesDecPP>0)
				aNtaP3{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P03_Final_Nota:263;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPP))
			Else 
				aNtaP3{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P03_Final_Nota:263)
			End if 
		End if 
		If ([Alumnos_Calificaciones:208]P04_Final_Real:337>=vrNTA_MinimoEscalaReferencia)
			If (iGradesDecPP>0)
				aNtaP4{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P04_Final_Nota:338;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPP))
			Else 
				aNtaP4{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P04_Final_Nota:338)
			End if 
		End if 
		If ([Alumnos_Calificaciones:208]P05_Final_Real:412>=vrNTA_MinimoEscalaReferencia)
			If (iGradesDecPP>0)
				aNtaP5{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P05_Final_Nota:413;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPP))
			Else 
				aNtaP5{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P05_Final_Nota:413)
			End if 
		End if 
		If ([Alumnos_Calificaciones:208]Anual_Real:11>=vrNTA_MinimoEscalaReferencia)
			If (iGradesDecPF>0)
				aNtaPF{$l_fila}:=String:C10([Alumnos_Calificaciones:208]Anual_Nota:12;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPF))
			Else 
				aNtaPF{$l_fila}:=String:C10([Alumnos_Calificaciones:208]Anual_Nota:12)
			End if 
		Else 
			aNtaPF{$l_fila}:=[Alumnos_Calificaciones:208]Anual_Literal:15
		End if 
		If ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26>=vrNTA_MinimoEscalaReferencia)
			If (iGradesDecNF>0)
				aNtaF{$l_fila}:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecNF))
			Else 
				aNtaF{$l_fila}:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27)
			End if 
		Else 
			aNtaF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		End if 
		aNtaPTC_Literal{$l_fila}:=String:C10([Alumnos_Calificaciones:208]PTC_Nota:536;"###0"+<>vs_AppDecimalSeparator+("0"*iGradesDecPF))
		
		
		
	: ((iViewMode=Puntos) & (iPrintMode#iViewMode))
		
		aNtaP1{$l_fila}:=[Alumnos_Calificaciones:208]P01_Final_Literal:116
		aNtaP2{$l_fila}:=[Alumnos_Calificaciones:208]P02_Final_Literal:191
		aNtaP3{$l_fila}:=[Alumnos_Calificaciones:208]P03_Final_Literal:266
		aNtaP4{$l_fila}:=[Alumnos_Calificaciones:208]P04_Final_Literal:341
		aNtaP5{$l_fila}:=[Alumnos_Calificaciones:208]P05_Final_Literal:416
		aNtaPF{$l_fila}:=[Alumnos_Calificaciones:208]Anual_Literal:15
		aNtaF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		
		If ([Alumnos_Calificaciones:208]P01_Final_Real:112>=vrNTA_MinimoEscalaReferencia)
			If (iPointsDecPP>0)
				aNtaP1{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P01_Final_Puntos:114;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecPP))
			Else 
				aNtaP1{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P01_Final_Puntos:114)
			End if 
		End if 
		If ([Alumnos_Calificaciones:208]P02_Final_Real:187>=vrNTA_MinimoEscalaReferencia)
			If (iPointsDecPP>0)
				aNtaP2{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P02_Final_Puntos:189;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecPP))
			Else 
				aNtaP2{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P02_Final_Puntos:189)
			End if 
		End if 
		If ([Alumnos_Calificaciones:208]P03_Final_Real:262>=vrNTA_MinimoEscalaReferencia)
			If (iPointsDecPP>0)
				aNtaP3{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P03_Final_Puntos:264;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecPP))
			Else 
				aNtaP3{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P03_Final_Puntos:264)
			End if 
		End if 
		If ([Alumnos_Calificaciones:208]P04_Final_Real:337>=vrNTA_MinimoEscalaReferencia)
			If (iPointsDecPP>0)
				aNtaP4{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P04_Final_Puntos:339;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecPP))
			Else 
				aNtaP4{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P04_Final_Puntos:339)
			End if 
		End if 
		If ([Alumnos_Calificaciones:208]P05_Final_Real:412>=vrNTA_MinimoEscalaReferencia)
			If (iPointsDecPP>0)
				aNtaP5{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P05_Final_Puntos:414;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecPP))
			Else 
				aNtaP5{$l_fila}:=String:C10([Alumnos_Calificaciones:208]P05_Final_Puntos:414)
			End if 
		End if 
		If ([Alumnos_Calificaciones:208]Anual_Real:11>=vrNTA_MinimoEscalaReferencia)
			If (iPointsDecPF>0)
				aNtaPF{$l_fila}:=String:C10([Alumnos_Calificaciones:208]Anual_Puntos:13;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecPF))
			Else 
				aNtaPF{$l_fila}:=String:C10([Alumnos_Calificaciones:208]Anual_Puntos:13)
			End if 
		Else 
			aNtaPF{$l_fila}:=[Alumnos_Calificaciones:208]Anual_Literal:15
		End if 
		If ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26>=vrNTA_MinimoEscalaReferencia)
			If (iPointsDecNF>0)
				aNtaF{$l_fila}:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecNF))
			Else 
				aNtaF{$l_fila}:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28)
			End if 
		Else 
			aNtaF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		End if 
		aNtaPTC_Literal{$l_fila}:=String:C10([Alumnos_Calificaciones:208]PTC_Puntos:537;"###0"+<>vs_AppDecimalSeparator+("0"*iPointsDecPF))
		
	Else 
		aNtaOf{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
		If (iViewMode=iPrintMode)
			aNtaP1{$l_fila}:=[Alumnos_Calificaciones:208]P01_Final_Literal:116
			aNtaP2{$l_fila}:=[Alumnos_Calificaciones:208]P02_Final_Literal:191
			aNtaP3{$l_fila}:=[Alumnos_Calificaciones:208]P03_Final_Literal:266
			aNtaP4{$l_fila}:=[Alumnos_Calificaciones:208]P04_Final_Literal:341
			aNtaP5{$l_fila}:=[Alumnos_Calificaciones:208]P05_Final_Literal:416
			aNtaPF{$l_fila}:=[Alumnos_Calificaciones:208]Anual_Literal:15
			aNtaF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		Else 
			aNtaP1{$l_fila}:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P01_Final_Real:112;iViewMode;vlNTA_DecimalesPP)
			aNtaP2{$l_fila}:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P02_Final_Real:187;iViewMode;vlNTA_DecimalesPP)
			aNtaP3{$l_fila}:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P03_Final_Real:262;iViewMode;vlNTA_DecimalesPP)
			aNtaP4{$l_fila}:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P04_Final_Real:337;iViewMode;vlNTA_DecimalesPP)
			aNtaP5{$l_fila}:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]P05_Final_Real:412;iViewMode;vlNTA_DecimalesPP)
			aNtaPF{$l_fila}:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iViewMode;vlNTA_DecimalesPF)
			aNtaF{$l_fila}:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;iViewMode;vlNTA_DecimalesNF)
		End if 
		
		
		Case of 
			: (iViewMode=Notas)
				$t_formato:="####0"+<>tXS_RS_DecimalSeparator+("0"*iGradesDecPF)
				aNtaPTC_Literal{$l_fila}:=String:C10([Alumnos_Calificaciones:208]PTC_Nota:536;$t_formato)
				
			: (iViewMode=Puntos)
				$t_formato:="####0"+<>tXS_RS_DecimalSeparator+("0"*iPointsDecPF)
				aNtaPTC_Literal{$l_fila}:=String:C10([Alumnos_Calificaciones:208]PTC_Puntos:537;$t_formato)
				
			: (iViewMode=Porcentaje)
				$t_formato:="##0"+<>tXS_RS_DecimalSeparator+"0"
				aNtaPTC_Literal{$l_fila}:=String:C10([Alumnos_Calificaciones:208]PTC_Real:535;$t_formato)
				
			: (iViewMode=Simbolos)
				aNtaPTC_Literal{$l_fila}:=[Alumnos_Calificaciones:208]PTC_Simbolos:538
		End case 
		
End case 


aNtaOf{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
aRealNtaP1{$l_fila}:=[Alumnos_Calificaciones:208]P01_Final_Real:112
aRealNtaP2{$l_fila}:=[Alumnos_Calificaciones:208]P02_Final_Real:187
aRealNtaP3{$l_fila}:=[Alumnos_Calificaciones:208]P03_Final_Real:262
aRealNtaP4{$l_fila}:=[Alumnos_Calificaciones:208]P04_Final_Real:337
aRealNtaP5{$l_fila}:=[Alumnos_Calificaciones:208]P05_Final_Real:412
aRealNtaPF{$l_fila}:=[Alumnos_Calificaciones:208]Anual_Real:11
aRealNtaF{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
aRealNtaOficial{$l_fila}:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26

aRealEXRecuperatorio{$l_fila}:=[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95


aNtaReprobada{$l_fila}:=[Alumnos_Calificaciones:208]Reprobada:9



