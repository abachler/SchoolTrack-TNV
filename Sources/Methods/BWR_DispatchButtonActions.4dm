//%attributes = {}
  //BWR_DispatchButtonActions

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : gnc_IptBtnHandl
	  //Autor: Alberto Bachler
	  //Creada el 30/5/96 a 05:39
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_LONGINT:C283(<>bDuplicate)
If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 



Case of 
	: (bBWR_CloseRecord>=1)
		BWR_InputFormButtonsHandler ($tablePointer;-4)
	: (bBWR_Cancel>=1)
		BWR_InputFormButtonsHandler ($tablePointer;-1)
	: (bBWR_SaveRecord>=1)
		BWR_InputFormButtonsHandler ($tablePointer;0)
	: (bBWR_FirstRecord>=1)
		BWR_InputFormButtonsHandler ($tablePointer;1)
	: (bBWR_PreviousRecord>=1)
		BWR_InputFormButtonsHandler ($tablePointer;2)
	: (bBWR_NextRecord>=1)
		BWR_InputFormButtonsHandler ($tablePointer;3)
	: (bBWR_LastRecord>=1)
		BWR_InputFormButtonsHandler ($tablePointer;4)
	: (<>bDuplicate>=1)
		BWR_InputFormButtonsHandler ($tablePointer;5)
	: (bBWR_Delete>=1)
		BWR_InputFormButtonsHandler ($tablePointer;-3)
	: (bClose=1)
		BWR_InputFormButtonsHandler ($tablePointer;-2)
End case 
bBWR_Cancel:=0
bBWR_SaveRecord:=0
bBWR_FirstRecord:=0
bBWR_PreviousRecord:=0
bBWR_NextRecord:=0
bBWR_LastRecord:=0
bBWR_Delete:=0
bClose:=0