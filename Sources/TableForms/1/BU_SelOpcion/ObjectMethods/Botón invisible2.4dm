  //OBJETO 6,1  OK Prototipo 1: 31/10/05

If (Size of array:C274(alBU_IdRecorrido)>0)
	ARRAY TEXT:C222(atBU_ALTipoServ;0)
	ARRAY BOOLEAN:C223(atBU_ALDesciende;0)
	ARRAY TEXT:C222(atBU_ALAcompañado;0)
	ARRAY LONGINT:C221(alBU_ALID;0)  //oculto
	ARRAY TEXT:C222(atBU_ALNom;0)
	ARRAY TEXT:C222(atBU_ALCurso;0)
	<>aCursos:=1
	BU_CtrListas (<>aCursos{<>acursos};alBU_IdRecorrido{1})
	WDW_OpenFormWindow (->[BU_Rutas_Inscripciones:35];"input";-1;4)  //Para abrir la ventana....
	DIALOG:C40([BU_Rutas_Inscripciones:35];"input")  //Para abrir el formulario.....
	CLOSE WINDOW:C154
Else 
	OK:=CD_Dlog (1;__ ("No existen recorridos para la Ruta, debe crear al menos un recorrido antes de inscribir a un Alumno");__ ("");__ ("Ok"))
End if 
