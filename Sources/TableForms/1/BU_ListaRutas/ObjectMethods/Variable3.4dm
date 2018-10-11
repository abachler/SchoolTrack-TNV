  //********************************* XALP_BUSES ***********************************************************
BU_RefreshBuses 

  //***********************************XALP_MANTENCIONES **********************************************
ARRAY LONGINT:C221(alBU_Mantencion;0)
ARRAY DATE:C224(adBU_Fecha;0)
ARRAY TEXT:C222(atBU_Responsable;0)
ARRAY TEXT:C222(atBU_Tipo;0)
ARRAY REAL:C219(arBU_Valor;0)
ARRAY TEXT:C222(atBU_Patente;0)
  //*******************************XAPL_DOCUMENTOS*******************************************************
ARRAY LONGINT:C221(alBU_NumDoc;0)
ARRAY LONGINT:C221(alBU_NumMant;0)
ARRAY DATE:C224(adBU_FechaDoc;0)
ARRAY TEXT:C222(atBU_Descrip;0)
ARRAY TEXT:C222(atBU_PatBus;0)
ARRAY LONGINT:C221(alBU_DocID;0)



WDW_OpenFormWindow (->[Buses_escolares:57];"input2";-1;4)  //Para abrir la ventana....
FORM SET INPUT:C55([Buses_escolares:57];"input2")
ADD RECORD:C56([Buses_escolares:57];*)
CLOSE WINDOW:C154

AL_SetLine (xalp_Rutas;0)
IT_SetButtonState (False:C215;->bDelRuta)