  //DC OBJETO: 2.1 OK Prototipo 1: 28/10/05
Case of 
	: (alProEvt=AL Single click event)
		
	: (alProEvt=AL Double click event)
		$line:=AL_GetLine (Self:C308->)
		$vl_NumeroRuta:=[BU_Rutas:26]ID:12
		
		If (atBU_ALProf{$line}="Alumno")
			
			ARRAY TEXT:C222(atBU_ALTipoServ;0)
			ARRAY BOOLEAN:C223(atBU_ALDesciende;0)
			ARRAY TEXT:C222(atBU_ALAcompañado;0)
			ARRAY LONGINT:C221(alBU_ALID;0)  //oculto
			ARRAY TEXT:C222(atBU_ALNom;0)
			ARRAY TEXT:C222(atBU_ALCurso;0)
			<>aCursos:=1
			BU_CtrListas (<>aCursos{<>acursos};alBU_IdRec{$line})
			vl_IdRec:=alBU_IdRec{$line}
			WDW_OpenFormWindow (->[BU_Rutas_Inscripciones:35];"input";-1;4)  //Para abrir la ventana....
			DIALOG:C40([BU_Rutas_Inscripciones:35];"input")  //Para abrir el formulario.....
			CLOSE WINDOW:C154
			QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12;=;$vl_NumeroRuta)
			AL_UpdateArrays (xalp_Inscripciones;0)
			BU_Refresh_Inscripciones (0)
			AL_UpdateArrays (xalp_Inscripciones;-2)
		Else 
			ARRAY LONGINT:C221(alBU_PFID;0)
			ARRAY TEXT:C222(atBU_PFNom;0)
			ARRAY TEXT:C222(atBU_PFCargo;0)
			ARRAY TEXT:C222(atBU_PFNomGen;0)
			ARRAY TEXT:C222(atBU_PFCargoGen;0)
			ARRAY LONGINT:C221(alBU_PFIdGen;0)
			BU_CtrListasProfesores (alBU_IdRec{$line})
			vl_IdRec:=alBU_IdRec{$line}
			WDW_OpenFormWindow (->[BU_Rutas_Inscripciones:35];"Funcionarios";-1;4)  //Para abrir la ventana....
			DIALOG:C40([BU_Rutas_Inscripciones:35];"Funcionarios")  //Para abrir el formulario.....
			CLOSE WINDOW:C154
			QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12;=;$vl_NumeroRuta)
		End if 
		
End case 
