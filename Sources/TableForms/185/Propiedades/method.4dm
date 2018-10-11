Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		ENABLE MENU ITEM:C149(1;5)
		SET MENU ITEM METHOD:C982(1;5;"MNU_PostEnterKey")
		
		MPAcfg_Eje_AlCrear 
		RELATE ONE:C42([MPA_DefinicionEjes:185]ID_Area:2)
		
		
		  //arreglos para seleccionar (popup menu) el tipo de evaluación de un eje
		ARRAY TEXT:C222(atEVLG_TiposEvaluacion;0)
		COPY ARRAY:C226(<>atEVLG_TiposEvaluacion;atEVLG_TiposEvaluacion)
		
		
		
		
		  // Etapas y niveles de aplicación
		Case of 
			: (([MPA_DefinicionEjes:185]DesdeGrado:4=999) & ([MPA_DefinicionEjes:185]HastaGrado:5=999))
				vtMPA_EtapaObjeto:="Asignación por nivel"
				vtMPA_NivelesEtapa:=""
				OBJECT SET VISIBLE:C603(bSeleccionNiveles;True:C214)
				
			: (([MPA_DefinicionEjes:185]DesdeGrado:4>-100) & ([MPA_DefinicionEjes:185]HastaGrado:5>-100))
				$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;[MPA_DefinicionEjes:185]DesdeGrado:4)
				If ($recNum>=0)
					GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
					vtMPA_NivelesEtapa:=[xxSTR_Niveles:6]Nivel:1
				End if 
				If ([MPA_DefinicionEjes:185]DesdeGrado:4#[MPA_DefinicionEjes:185]HastaGrado:5)
					$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;[MPA_DefinicionEjes:185]HastaGrado:5)
					If ($recNum>=0)
						GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
						vtMPA_NivelesEtapa:=vtMPA_NivelesEtapa+" a "+[xxSTR_Niveles:6]Nivel:1
					End if 
				End if 
				alMPA_NivelDesde{0}:=[MPA_DefinicionEjes:185]DesdeGrado:4
				alMPA_NivelHasta{0}:=[MPA_DefinicionEjes:185]HastaGrado:5
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
		
		
		
		
		  // botones de información sobre uso actual  del eje
		If (Is new record:C668([MPA_DefinicionEjes:185]))
			OBJECT SET VISIBLE:C603(*;"@Eje_Info@";False:C215)
		Else 
			MPAcfg_InfoUsoEnunciado (Eje_Aprendizaje;Record number:C243([MPA_DefinicionEjes:185]);True:C214)
		End if 
		
		
		atEVLG_TiposEvaluacion:=[MPA_DefinicionEjes:185]TipoEvaluación:12
		Case of 
			: ([MPA_DefinicionEjes:185]TipoEvaluación:12=1)
				$el:=Find in array:C230(aEvStyleId;[MPA_DefinicionEjes:185]EstiloEvaluación:13)
				If ($el>0)
					aEvStyleName:=$el
				End if 
				[MPA_DefinicionEjes:185]EstiloEvaluación:13:=aEvStyleId{aEvStyleName}
				EVS_ReadStyleData ([MPA_DefinicionEjes:185]EstiloEvaluación:13)
				FORM GOTO PAGE:C247(1)
				
			: ([MPA_DefinicionEjes:185]TipoEvaluación:12=2)  //binario
				vsEVLG_Simbolo_True:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14;1;";")
				vsEVLG_Simbolo_False:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14;2;";")
				vsEVLG_DescSimbolo_True:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;1;";")
				vsEVLG_DescSimbolo_False:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;2;";")
				FORM GOTO PAGE:C247(2)
				
				
			: ([MPA_DefinicionEjes:185]TipoEvaluación:12=3)  //escala independiente
				viEVLG_RequeridoEje:=Round:C94([MPA_DefinicionEjes:185]Escala_Maximo:18*[MPA_DefinicionEjes:185]PctParaAprobacion:16/100;0)
				FORM GOTO PAGE:C247(3)
		End case 
		
		
		
		HIGHLIGHT TEXT:C210([MPA_DefinicionEjes:185]Nombre:3;Length:C16([MPA_DefinicionEjes:185]Nombre:3)+1;32000)
		
		
		OBJECT SET VISIBLE:C603([MPA_DefinicionEjes:185]ID:1;USR_GetUserID <0)
		SET WINDOW TITLE:C213(__ ("Eje de Aprendizaje"))
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If ([MPA_DefinicionEjes:185]TipoEvaluación:12=2)
			[MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15:=vsEVLG_DescSimbolo_True+";"+vsEVLG_DescSimbolo_False
			[MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14:=vsEVLG_Simbolo_True+";"+vsEVLG_Simbolo_False
		End if 
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		POST KEY:C465(Character code:C91("w");Command key mask:K16:1)
		
		
		
		
	: (Form event:C388=On Unload:K2:2)
		CFG_SetMenuBar 
		
		
End case 