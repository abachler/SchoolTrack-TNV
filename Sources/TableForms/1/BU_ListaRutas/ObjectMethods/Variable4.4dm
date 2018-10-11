  //DC OBJETO  1.2
  //************************************* XALP_RECORRIDOS ***********************************************
ARRAY TEXT:C222(atBU_RecNombre;0)
ARRAY TEXT:C222(atBU_Jornada;0)
ARRAY LONGINT:C221(alBU_Hora;0)
ARRAY TEXT:C222(atBU_Dia;0)
ARRAY BOOLEAN:C223(abBU_ES;0)
ARRAY LONGINT:C221(alBU_IdRecorrido;0)  //oculto
ARRAY LONGINT:C221(alBU_Ruta;0)  //oculto
  //*************************************XALP_INSCRIPCIONES *****************************************************
ARRAY TEXT:C222(atBU_ALProf;0)
ARRAY TEXT:C222(atBU_Nombre;0)
ARRAY TEXT:C222(atBU_Curso;0)
ARRAY TEXT:C222(atBU_NomRec;0)
ARRAY LONGINT:C221(alBU_IdRec;0)  //Oculto
ARRAY LONGINT:C221(alBU_IdAlumno;0)  //Oculto
ARRAY LONGINT:C221(alBU_IdProfesor;0)  //Oculto

  //*************************************XALP_LISTACOMUNAS *****************************************************
  //Array para las comunas seleccionadas para la ruta
ARRAY TEXT:C222(alBU_IDCom;0)
ARRAY TEXT:C222(atBU_NomCom;0)

  //*************************************XALP_COMUNAS *****************************************************

  //Array para el listado de Comunas a seleccionar
ARRAY TEXT:C222(atBU_GenNomCom;0)
If (<>vtXS_CountryCode="cl")
	COPY ARRAY:C226(<>aComuna;atBU_GenNomCom)
Else 
	COPY ARRAY:C226(<>aComuna;atBU_GenNomCom)
End if 
  //START TRANSACTION
WDW_OpenFormWindow (->[BU_Rutas:26];"input";-1;4)  //Para abrir la ventana....
FORM SET INPUT:C55([BU_Rutas:26];"input")
ADD RECORD:C56([BU_Rutas:26];*)
CLOSE WINDOW:C154
  //If (vb_ValidateTransaction)
  //  //VALIDATE TRANSACTION
  //Else 
  //  //CANCEL TRANSACTION
  //End if 
AL_SetLine (xalp_Rutas;0)
IT_SetButtonState ((Size of array:C274(alBU_IdRuta)>0);->bConfig;->bPrintRuta)
IT_SetButtonState (False:C215;->bDelRuta)



