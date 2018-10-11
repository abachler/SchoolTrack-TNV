Spell_CheckSpelling 

$y_minimo:=OBJECT Get pointer:C1124(Object named:K67:5;"minimoAdquisicion_var")

Case of 
	: (Form event:C388=On Load:K2:1)
		ENABLE MENU ITEM:C149(1;5)
		SET MENU ITEM METHOD:C982(1;5;"MNU_PostEnterKey")
		
		
		MPAcfg_Comp_AlCrear 
		
		
		READ ONLY:C145([MPA_DefinicionDimensiones:188])
		RELATE ONE:C42([MPA_DefinicionCompetencias:187]ID_Dimension:23)
		
		READ ONLY:C145([MPA_DefinicionEjes:185])
		RELATE ONE:C42([MPA_DefinicionCompetencias:187]ID_Eje:2)
		
		  // Arreglo para lista desplegable estilos de evaluacion
		ARRAY TEXT:C222(atEVLG_TiposEvaluacion;0)
		COPY ARRAY:C226(<>atEVLG_TiposEvaluacionComp;atEVLG_TiposEvaluacion)
		
		
		  // etapas y niveles de aplicación
		READ ONLY:C145([xxSTR_Niveles:6])
		Case of 
				  // si la competencia aplica en todos las etapas
			: (([MPA_DefinicionCompetencias:187]DesdeGrado:5=-100) & ([MPA_DefinicionCompetencias:187]HastaGrado:13=-100))
				vtMPA_EtapaObjeto:=__ ("Todas")
				vtMPA_NivelesEtapa:=""
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;False:C215)
				
				
				  // si la competencia aplica en niveles específicos 
			: (([MPA_DefinicionCompetencias:187]DesdeGrado:5=999) & ([MPA_DefinicionCompetencias:187]HastaGrado:13=999))
				vtMPA_EtapaObjeto:="Asignación por nivel"
				vtMPA_NivelesEtapa:=""
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;True:C214)
				
				
				  // si la aplicación aplica sólo en una etapa
			: (([MPA_DefinicionCompetencias:187]DesdeGrado:5>-100) & ([MPA_DefinicionCompetencias:187]HastaGrado:13>-100))
				KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->[MPA_DefinicionCompetencias:187]DesdeGrado:5)
				If (OK=1)
					vtMPA_NivelesEtapa:=[xxSTR_Niveles:6]Nivel:1
				End if 
				
				If ([MPA_DefinicionCompetencias:187]DesdeGrado:5#[MPA_DefinicionCompetencias:187]HastaGrado:13)
					KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->[MPA_DefinicionCompetencias:187]HastaGrado:13)
					If (OK=1)
						vtMPA_NivelesEtapa:=vtMPA_NivelesEtapa+" a "+[xxSTR_Niveles:6]Nivel:1
					End if 
				End if 
				alMPA_NivelDesde{0}:=[MPA_DefinicionCompetencias:187]DesdeGrado:5
				alMPA_NivelHasta{0}:=[MPA_DefinicionCompetencias:187]HastaGrado:13
				ARRAY LONGINT:C221($DA_Return;0)
				AT_MultiArraySearch (True:C214;->$DA_Return;->alMPA_NivelDesde;->alMPA_NivelHasta)
				If (Size of array:C274($DA_Return)=1)
					vtMPA_EtapaObjeto:=atMPA_EtapasArea{$DA_Return{1}}
				End if 
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;False:C215)
		End case 
		
		
		  // si la adición de indicadores de logros por parte de los profesores está autorizada es posible 
		  // definir el valor máximo posible para los indicadores
		If ([MPA_DefinicionCompetencias:187]AdicionIndicadores_Autorizada:19)
			OBJECT SET ENTERABLE:C238([MPA_DefinicionCompetencias:187]Maximo_Indicadores:9;True:C214)
		Else 
			OBJECT SET ENTERABLE:C238([MPA_DefinicionCompetencias:187]Maximo_Indicadores:9;False:C215)
		End if 
		
		
		  // construccion de la lista desplegable de restricción por subsector (Materias)
		READ ONLY:C145([MPA_DefinicionAreas:186])
		KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionAreas:186]ID:1;->[MPA_DefinicionCompetencias:187]ID_Area:11;False:C215)
		READ ONLY:C145([xxSTR_Materias:20])
		QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]AreaMPA:4=[MPA_DefinicionAreas:186]AreaAsignatura:4)
		SELECTION TO ARRAY:C260([xxSTR_Materias:20]Materia:2;atMPA_LimiteAsignacion;[xxSTR_Materias:20]ID_Materia:16;alMPA_LimiteAsignacion)
		INSERT IN ARRAY:C227(atMPA_LimiteAsignacion;1;1)
		INSERT IN ARRAY:C227(alMPA_LimiteAsignacion;1;1)
		atMPA_LimiteAsignacion{1}:=__ ("Disponible para todas")
		alMPA_LimiteAsignacion{1}:=0
		$el:=Find in array:C230(alMPA_LimiteAsignacion;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3)
		If ($el>0)
			atMPA_LimiteAsignacion:=$el
		Else 
			[MPA_DefinicionCompetencias:187]RestriccionSubsector:3:=0
		End if 
		
		
		
		
		  // construccion de la lista desplegable de restricción por sexo
		ARRAY TEXT:C222(atMPA_LimiteSexo;0)
		AT_Text2Array (->atMPA_LimiteSexo;__ ("Ambos sexos;Femenino;Masculino"))
		atMPA_LimiteSexo:=[MPA_DefinicionCompetencias:187]RestriccionSexo:27+1
		
		
		
		
		  // botones de información sobre uso actual de la competencia
		If (Is new record:C668([MPA_DefinicionCompetencias:187]))
			OBJECT SET VISIBLE:C603(*;"@bInfoComp@";False:C215)
		Else 
			MPAcfg_InfoUsoEnunciado (Logro_Aprendizaje;Record number:C243([MPA_DefinicionCompetencias:187]);True:C214)
		End if 
		
		
		
		  // activación de la página correspondiente al estilo de evaluación
		$y_minimo:=OBJECT Get pointer:C1124(Object named:K67:5;"minimoAdquisicion_var")
		$y_minimo->:=""
		atEVLG_TiposEvaluacion:=[MPA_DefinicionCompetencias:187]TipoEvaluacion:12
		Case of 
			: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1)  // evaluacion por indicadores
				FORM GOTO PAGE:C247(1)
				
			: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=2)  // evaluación binaria
				FORM GOTO PAGE:C247(2)
				
			: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=3)  //estilos de evaluacion
				FORM GOTO PAGE:C247(3)
				_O_ENABLE BUTTON:C192(aEvStyleName)
				
		End case 
		MPAcfg_MinimoAdquisicion 
		
		
		HIGHLIGHT TEXT:C210([MPA_DefinicionCompetencias:187]Competencia:6;Length:C16([MPA_DefinicionCompetencias:187]Competencia:6)+1;32000)
		
		OBJECT SET VISIBLE:C603([MPA_DefinicionCompetencias:187]ID:1;USR_GetUserID <0)
		SET WINDOW TITLE:C213(__ ("Competencia"))
		
		
		
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		[MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18:=vsEVLG_DescSimbolo_True+";"+vsEVLG_DescSimbolo_False
		[MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17:=vsEVLG_Simbolo_True+";"+vsEVLG_Simbolo_False
		
		
	: (Form event:C388=On Close Box:K2:21)
		POST KEY:C465(Character code:C91("w");Command key mask:K16:1)
		
		
	: (Form event:C388=On Unload:K2:2)
		CFG_SetMenuBar 
		
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
		
	: (Form event:C388=On Validate:K2:3)
		
End case 