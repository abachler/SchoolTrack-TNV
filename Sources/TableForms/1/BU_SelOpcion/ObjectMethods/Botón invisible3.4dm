  //objeto 6.2 OK Prototipo 1: 31/10/05

If (Size of array:C274(alBU_IdRecorrido)>0)
	ARRAY LONGINT:C221(alBU_PFID;0)
	ARRAY TEXT:C222(atBU_PFNom;0)
	ARRAY TEXT:C222(atBU_PFCargo;0)
	ARRAY TEXT:C222(atBU_PFNomGen;0)
	ARRAY TEXT:C222(atBU_PFCargoGen;0)
	ARRAY LONGINT:C221(alBU_PFIdGen;0)
	BU_CtrListasProfesores (alBU_IdRecorrido{1})
	WDW_OpenFormWindow (->[BU_Rutas_Inscripciones:35];"Funcionarios";-1;4)  //Para abrir la ventana....
	DIALOG:C40([BU_Rutas_Inscripciones:35];"Funcionarios")  //Para abrir el formulario.....
	CLOSE WINDOW:C154
Else 
	OK:=CD_Dlog (1;__ ("No existen recorridos para la Ruta, debe crear al menos un recorrido antes de inscribir a un Profesor");__ ("");__ ("Ok"))
End if 

