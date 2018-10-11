Spell_CheckSpelling 

C_LONGINT:C283(vlb_HeaderAsignaturasArea;vlb_HeaderDesde;vlb_HeaderHasta;vlb_HeaderNoNivelDesde;vlb_HeaderNoNivelHasta;vlb_HeaderEtapas)
Case of 
	: (Form event:C388=On Load:K2:1)
		ENABLE MENU ITEM:C149(1;5)
		SET MENU ITEM METHOD:C982(1;5;"MNU_PostEnterKey")
		
		If (Is new record:C668([MPA_DefinicionAreas:186]))
			OBJECT SET VISIBLE:C603(*;"ot_MensajeEntrada";True:C214)
			[MPA_DefinicionAreas:186]ID:1:=SQ_SeqNumber (->[MPA_DefinicionAreas:186]ID:1)
			  //[MPA_DefinicionAreas]AreaAsignatura:="Area de aprendizaje Nº "+String([MPA_DefinicionAreas]ID)
			GOTO OBJECT:C206([MPA_DefinicionAreas:186]AreaAsignatura:4)
			IT_HighlightContent (->[MPA_DefinicionAreas:186]AreaAsignatura:4)
		Else 
			OBJECT SET VISIBLE:C603(*;"ot_MensajeEntrada";False:C215)
		End if 
		SET WINDOW TITLE:C213(__ ("Area de Aprendizaje: ")+[MPA_DefinicionAreas:186]AreaAsignatura:4)
		
		
		  // el arreglo <>aAsign que contiene todos los nombres de subsectores definidos en Configuración / Subsectores
		  // es desplegado en el listbox  lb_asignaturas
		
		
		  // leo las asignaturas actualmente asignadas al área
		  // el arreglo es desplegado en el listbox lb_asisgnaturasArea
		ARRAY BOOLEAN:C223(lb_asignaturasArea;0)
		ARRAY TEXT:C222(atMPA_AsignaturasArea;0)
		If ([MPA_DefinicionAreas:186]AreaAsignatura:4#"")
			QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]AreaMPA:4;=;[MPA_DefinicionAreas:186]AreaAsignatura:4)
			SELECTION TO ARRAY:C260([xxSTR_Materias:20]Materia:2;atMPA_AsignaturasArea)
			LISTBOX SORT COLUMNS:C916(lb_asignaturasArea;1;>)
		End if 
		
		
		  //inicializo los arreglos que definen las etapas del área
		ARRAY TEXT:C222(atMPA_EtapasArea;0)
		ARRAY LONGINT:C221(alMPA_NivelDesde;0)
		ARRAY LONGINT:C221(alMPA_NivelHasta;0)
		ARRAY TEXT:C222(atMPA_NivelDesde;0)
		ARRAY TEXT:C222(atMPA_NivelHasta;0)
		
		
		If (BLOB size:C605([MPA_DefinicionAreas:186]xEtapas:10)=0)
			  // si no hay información en el blob almaceno en el blob los arreglos necesarios para la definición de las etapas
			  // sin ningún elemento
			
			APPEND TO ARRAY:C911(atMPA_EtapasArea;"Etapa única")
			APPEND TO ARRAY:C911(alMPA_NivelDesde;<>al_NumeroNivelesActivos{1})
			APPEND TO ARRAY:C911(alMPA_NivelHasta;<>al_NumeroNivelesActivos{Size of array:C274(<>al_NumeroNivelesActivos)})
			BLOB_Variables2Blob (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
		Else 
			  // si el blob tiene información leo los arreglos que definene las etapas registradas
			BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
		End if 
		
		
		  //los arreglos correspondientes a la definición de etapas son desplegados en el listbox lb_etapas
		ARRAY TEXT:C222(atMPA_NivelDesde;Size of array:C274(atMPA_EtapasArea))
		ARRAY TEXT:C222(atMPA_NivelHasta;Size of array:C274(atMPA_EtapasArea))
		READ ONLY:C145([xxSTR_Niveles:6])
		For ($i;Size of array:C274(atMPA_EtapasArea);1;-1)
			$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;alMPA_NivelDesde{$i})
			If ($recNum>=0)
				GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
				atMPA_NivelDesde{$i}:="["+String:C10([xxSTR_Niveles:6]NoNivel:5)+"] "+[xxSTR_Niveles:6]Nivel:1
				If (alMPA_NivelHasta{$i}=-100)
					alMPA_NivelHasta{$i}:=12
				End if 
				$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;alMPA_NivelHasta{$i})
				If ($recNum>=0)
					GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
					atMPA_NivelHasta{$i}:="["+String:C10([xxSTR_Niveles:6]NoNivel:5)+"] "+[xxSTR_Niveles:6]Nivel:1
				End if 
			Else 
				AT_Delete ($i;1;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta;->atMPA_NivelDesde;->atMPA_NivelHasta)
			End if 
		End for 
		LISTBOX SORT COLUMNS:C916(lb_etapas;4;>)
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		POST KEY:C465(Character code:C91("w");Command key mask:K16:1)
		
		
		
		
	: (Form event:C388=On Unload:K2:2)
		CFG_SetMenuBar 
		
		
	: (Form event:C388=On Outside Call:K2:11)
		
		
		
		
	: (Form event:C388=On Resize:K2:27)
		
		
		
	: (Form event:C388=On Before Keystroke:K2:6)
		
		
		
		
	: (Form event:C388=On After Keystroke:K2:26)
		
		
End case 