//%attributes = {}
  //BWR_SetInputFormButtons

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 18/07/03, 17:25:05
  // -------------------------------------------------------------------------------
  // Metodo: BWR_SetInputFormButtons
  // Descripcion
  // 
  //
  // Parametros
  //$1= Table pointer
  //$2= Method (0:browser navigation; 1=Referenced array navigation; 2=Current selection navigation; 3=Disable navigation buttons
  // ===============================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_LONGINT:C283($method;$2)
C_POINTER:C301($tablePointer;$ArrayIndexPointer;$fieldIndexPointer;$1;$3;$4)

C_LONGINT:C283(lBWR_recordNumber)

  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$method:=0
Case of 
	: (Count parameters:C259=4)
		$tablePointer:=$1
		$method:=$2
		$ArrayIndexPointer:=$3
		$fieldIndexPointer:=$4
	: (Count parameters:C259=2)
		$tablePointer:=$1
		$method:=$2
	: (Count parameters:C259=1)
		$tablePointer:=$1
		If (vlBWR_BrowsingMethod#0)
			$method:=vlBWR_BrowsingMethod
		End if 
	Else 
		$tablePointer:=yBWR_currentTable
		If (vlBWR_BrowsingMethod#0)
			$method:=vlBWR_BrowsingMethod
		End if 
End case 

BWR_SetInputButtonsAppearence 

  //initializing buttons
bBWR_SaveRecord:=0
bBWR_Cancel:=0
bBWR_Delete:=0
<>bDuplicate:=0
<>bPrint:=0
bBWR_FirstRecord:=0
bBWR_PreviousRecord:=0
bBWR_NextRecord:=0
bBWR_LastRecord:=0
bBWR_Close:=0


  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------



Case of 
	: ((Is new record:C668($tablePointer->)) | ($method=BWR Browsing Disabled))
		_O_DISABLE BUTTON:C193(bBWR_FirstRecord)
		_O_DISABLE BUTTON:C193(bBWR_PreviousRecord)
		_O_DISABLE BUTTON:C193(bBWR_LastRecord)
		_O_DISABLE BUTTON:C193(bBWR_NextRecord)
		DISABLE MENU ITEM:C150(2;13)
		DISABLE MENU ITEM:C150(2;14)
		DISABLE MENU ITEM:C150(2;15)
		DISABLE MENU ITEM:C150(2;16)
		
	: ($method=BWR Standard Browsing)
		If (lBWR_recordNumber=0)
			_O_DISABLE BUTTON:C193(bBWR_FirstRecord)
			_O_DISABLE BUTTON:C193(bBWR_PreviousRecord)
			_O_DISABLE BUTTON:C193(bBWR_LastRecord)
			_O_DISABLE BUTTON:C193(bBWR_NextRecord)
			DISABLE MENU ITEM:C150(2;13)
			DISABLE MENU ITEM:C150(2;14)
			DISABLE MENU ITEM:C150(2;15)
			DISABLE MENU ITEM:C150(2;16)
		Else 
			If (lBWR_recordNumber=1)  //at First Record
				_O_DISABLE BUTTON:C193(bBWR_FirstRecord)
				_O_DISABLE BUTTON:C193(bBWR_PreviousRecord)
				DISABLE MENU ITEM:C150(2;13)
				DISABLE MENU ITEM:C150(2;14)
			Else 
				_O_ENABLE BUTTON:C192(bBWR_FirstRecord)
				_O_ENABLE BUTTON:C192(bBWR_PreviousRecord)
				ENABLE MENU ITEM:C149(2;13)
				ENABLE MENU ITEM:C149(2;14)
			End if 
			If (lBWR_recordNumber=Size of array:C274(alBWR_recordNumber))  //at Last Record
				_O_DISABLE BUTTON:C193(bBWR_LastRecord)
				_O_DISABLE BUTTON:C193(bBWR_NextRecord)
				DISABLE MENU ITEM:C150(2;15)
				DISABLE MENU ITEM:C150(2;16)
			Else 
				_O_ENABLE BUTTON:C192(bBWR_LastRecord)
				_O_ENABLE BUTTON:C192(bBWR_NextRecord)
				ENABLE MENU ITEM:C149(2;15)
				ENABLE MENU ITEM:C149(2;16)
			End if 
		End if 
		
	: (($method=BWR Array Browsing) & (Not:C34(Is nil pointer:C315(vyBWR_CustomArrayPointer))))
		If (vyBWR_CustomArrayPointer->=0)
			_O_DISABLE BUTTON:C193(bBWR_FirstRecord)
			_O_DISABLE BUTTON:C193(bBWR_PreviousRecord)
			_O_DISABLE BUTTON:C193(bBWR_LastRecord)
			_O_DISABLE BUTTON:C193(bBWR_NextRecord)
			DISABLE MENU ITEM:C150(2;13)
			DISABLE MENU ITEM:C150(2;14)
			DISABLE MENU ITEM:C150(2;15)
			DISABLE MENU ITEM:C150(2;16)
		Else 
			If (vyBWR_CustomArrayPointer->=1)  //at First Record
				_O_DISABLE BUTTON:C193(bBWR_FirstRecord)
				_O_DISABLE BUTTON:C193(bBWR_PreviousRecord)
				DISABLE MENU ITEM:C150(2;13)
				DISABLE MENU ITEM:C150(2;14)
			Else 
				_O_ENABLE BUTTON:C192(bBWR_FirstRecord)
				_O_ENABLE BUTTON:C192(bBWR_PreviousRecord)
				ENABLE MENU ITEM:C149(2;13)
				ENABLE MENU ITEM:C149(2;14)
			End if 
			If (vyBWR_CustomArrayPointer->=Size of array:C274(vyBWR_CustomArrayPointer->))  //at Last Record
				_O_DISABLE BUTTON:C193(bBWR_LastRecord)
				_O_DISABLE BUTTON:C193(bBWR_NextRecord)
				DISABLE MENU ITEM:C150(2;15)
				DISABLE MENU ITEM:C150(2;16)
			Else 
				_O_ENABLE BUTTON:C192(bBWR_LastRecord)
				_O_ENABLE BUTTON:C192(bBWR_NextRecord)
				ENABLE MENU ITEM:C149(2;15)
				ENABLE MENU ITEM:C149(2;16)
			End if 
		End if 
		
	: ($method=BWR Browse Selection)
		If (Selected record number:C246($tablePointer->)=1)  //at First Record
			_O_DISABLE BUTTON:C193(bBWR_FirstRecord)
			_O_DISABLE BUTTON:C193(bBWR_PreviousRecord)
			DISABLE MENU ITEM:C150(2;13)
			DISABLE MENU ITEM:C150(2;14)
		Else 
			_O_ENABLE BUTTON:C192(bBWR_FirstRecord)
			_O_ENABLE BUTTON:C192(bBWR_PreviousRecord)
			ENABLE MENU ITEM:C149(2;13)
			ENABLE MENU ITEM:C149(2;14)
		End if 
		If (Selected record number:C246($tablePointer->)=Records in selection:C76($tablePointer->))  //at Last Record
			_O_DISABLE BUTTON:C193(bBWR_LastRecord)
			_O_DISABLE BUTTON:C193(bBWR_NextRecord)
			DISABLE MENU ITEM:C150(2;15)
			DISABLE MENU ITEM:C150(2;16)
		Else 
			_O_ENABLE BUTTON:C192(bBWR_LastRecord)
			_O_ENABLE BUTTON:C192(bBWR_NextRecord)
			ENABLE MENU ITEM:C149(2;15)
			ENABLE MENU ITEM:C149(2;16)
		End if 
	Else 
		_O_DISABLE BUTTON:C193(bBWR_FirstRecord)
		_O_DISABLE BUTTON:C193(bBWR_PreviousRecord)
		_O_DISABLE BUTTON:C193(bBWR_LastRecord)
		_O_DISABLE BUTTON:C193(bBWR_NextRecord)
		DISABLE MENU ITEM:C150(2;13)
		DISABLE MENU ITEM:C150(2;14)
		DISABLE MENU ITEM:C150(2;15)
		DISABLE MENU ITEM:C150(2;16)
End case 

IT_SetButtonState (Size of array:C274(atQR_FormReportNames)>0;-><>bPrint)
IT_SetButtonState ((Record number:C243(yBWR_currentTable->)>=0) & (USR_checkRights ("D";yBWR_currentTable));->bBWR_Delete)
MNU_SetMenuItemState ((Record number:C243(yBWR_currentTable->)>=0) & (USR_checkRights ("D";yBWR_currentTable));2;18)
MNU_SetMenuItemState ((Record number:C243(yBWR_currentTable->)>=0) & (USR_checkRights ("D";yBWR_currentTable));2;8)
IT_SetButtonState (USR_checkRights ("M";yBWR_currentTable);->bBWR_SaveRecord)
IT_SetButtonState (USR_checkRights ("L";yBWR_currentTable);->bBWR_Print)
IT_SetButtonState (True:C214;->bBWR_Cancel)
ENABLE MENU ITEM:C149(1;4)
DISABLE MENU ITEM:C150(1;7)
MNU_SetMenuItemState (USR_checkRights ("M";yBWR_currentTable);1;5)


OBJECT SET VISIBLE:C603(bBWR_CloseRecord;False:C215)
OBJECT SET VISIBLE:C603(bBWR_SaveRecord;True:C214)
OBJECT SET VISIBLE:C603(bBWR_Cancel;True:C214)
dhBWR_SetInputFormButtons 

  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------