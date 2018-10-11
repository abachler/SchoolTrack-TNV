

Spell_CheckSpelling 
Case of 
	: (Form event:C388=On Load:K2:1)
		ENABLE MENU ITEM:C149(1;5)
		SET MENU ITEM METHOD:C982(1;5;"MNU_PostEnterKey")
		
		MPAcfg_Dim_AlCrear 
		
		
		  //arreglos para seleccionar (popup menu) el tipo de evaluación de un eje
		ARRAY TEXT:C222(atEVLG_TiposEvaluacion;0)
		COPY ARRAY:C226(<>atEVLG_TiposEvaluacion;atEVLG_TiposEvaluacion)
		
		READ ONLY:C145([MPA_DefinicionAreas:186])
		READ ONLY:C145([MPA_DefinicionEjes:185])
		READ ONLY:C145([MPA_DefinicionCompetencias:187])
		READ ONLY:C145([MPA_ObjetosMatriz:204])
		READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
		
		
		RELATE ONE:C42([MPA_DefinicionDimensiones:188]ID_Eje:3)
		RELATE ONE:C42([MPA_DefinicionEjes:185]ID_Area:2)
		
		
		READ ONLY:C145([xxSTR_Niveles:6])
		Case of 
			: (([MPA_DefinicionDimensiones:188]DesdeGrado:6=999) & ([MPA_DefinicionDimensiones:188]HastaGrado:7=999))
				vtMPA_EtapaObjeto:="Asignación por nivel"
				vtMPA_NivelesEtapa:=""
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;True:C214)
				
			: (([MPA_DefinicionDimensiones:188]DesdeGrado:6>-100) & ([MPA_DefinicionDimensiones:188]HastaGrado:7>-100))
				$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;[MPA_DefinicionDimensiones:188]DesdeGrado:6)
				If ($recNum>=0)
					GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
					vtMPA_NivelesEtapa:=[xxSTR_Niveles:6]Nivel:1
				End if 
				If ([MPA_DefinicionDimensiones:188]DesdeGrado:6#[MPA_DefinicionDimensiones:188]HastaGrado:7)
					$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;[MPA_DefinicionDimensiones:188]HastaGrado:7)
					If ($recNum>=0)
						GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
						vtMPA_NivelesEtapa:=vtMPA_NivelesEtapa+" a "+[xxSTR_Niveles:6]Nivel:1
					End if 
				End if 
				alMPA_NivelDesde{0}:=[MPA_DefinicionDimensiones:188]DesdeGrado:6
				alMPA_NivelHasta{0}:=[MPA_DefinicionDimensiones:188]HastaGrado:7
				ARRAY LONGINT:C221($DA_Return;0)
				AT_MultiArraySearch (True:C214;->$DA_Return;->alMPA_NivelDesde;->alMPA_NivelHasta)
				If (Size of array:C274($DA_Return)=1)
					vtMPA_EtapaObjeto:=atMPA_EtapasArea{$DA_Return{1}}
				End if 
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;False:C215)
			Else 
				vtMPA_EtapaObjeto:=__ ("Todas")
				vtMPA_NivelesEtapa:=""
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;False:C215)
		End case 
		
		  // botones de información sobre uso actual de la Dimensión
		If (Is new record:C668([MPA_DefinicionDimensiones:188]))
			OBJECT SET VISIBLE:C603(*;"@Dim_Info@";False:C215)
		Else 
			MPAcfg_InfoUsoEnunciado (Dimension_Aprendizaje;Record number:C243([MPA_DefinicionDimensiones:188]);True:C214)
		End if 
		
		
		
		atEVLG_TiposEvaluacion:=[MPA_DefinicionDimensiones:188]TipoEvaluacion:15
		Case of 
			: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=1)  //segun estilo de evaluación
				$el:=Find in array:C230(aEvStyleId;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
				If ($el>0)
					aEvStyleName:=$el
				End if 
				[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11:=aEvStyleId{aEvStyleName}
				EVS_ReadStyleData ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
				FORM GOTO PAGE:C247(1)
				
			: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=2)  //binario
				vsEVLG_Simbolo_True:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17;1;";")
				vsEVLG_Simbolo_False:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17;2;";")
				vsEVLG_DescSimbolo_True:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;1;";")
				vsEVLG_DescSimbolo_False:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;2;";")
				FORM GOTO PAGE:C247(2)
				
				
			: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=3)  //escala independiente
				viEVLG_RequeridoDimension:=Round:C94([MPA_DefinicionDimensiones:188]Escala_Maximo:13*[MPA_DefinicionDimensiones:188]PctParaAprobacion:14/100;0)
				FORM GOTO PAGE:C247(3)
				
		End case 
		
		HIGHLIGHT TEXT:C210([MPA_DefinicionDimensiones:188]Dimensión:4;Length:C16([MPA_DefinicionDimensiones:188]Dimensión:4)+1;Length:C16([MPA_DefinicionDimensiones:188]Dimensión:4)+1)
		
		
		
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=2)
			[MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16:=vsEVLG_DescSimbolo_True+";"+vsEVLG_DescSimbolo_False
			[MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17:=vsEVLG_Simbolo_True+";"+vsEVLG_Simbolo_False
		End if 
		
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		POST KEY:C465(Character code:C91("w");Command key mask:K16:1)
		
		
		
		
	: (Form event:C388=On Unload:K2:2)
		CFG_SetMenuBar 
		
End case 