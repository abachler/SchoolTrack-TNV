//%attributes = {}
  //CFG_ST_BlockEvtAsigNiveles  //157382
C_TEXT:C284($opt;$1;$newValue;$2;$oldValue;$3)
C_LONGINT:C283($i;$l_idTermometro;$fia)
$opt:=$1
$newValue:=$2

If (Count parameters:C259=3)
	$oldValue:=$3
End if 

$l_idTermometro:=IT_Progress (1;0;0;"Configuración de bloqueo de eventos por calendario ...")

ARRAY TEXT:C222(at_EvtCalTipo;0)
ARRAY LONGINT:C221(al_EvtCalMaxDay;0)
ARRAY LONGINT:C221(al_EvtCalMaxWeek;0)

ARRAY LONGINT:C221($al_rnNiveles;0)
READ ONLY:C145([xxSTR_Niveles:6])
ALL RECORDS:C47([xxSTR_Niveles:6])
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$al_rnNiveles;"")

For ($i;1;Size of array:C274($al_rnNiveles))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_rnNiveles))
	
	READ WRITE:C146([xxSTR_Niveles:6])
	GOTO RECORD:C242([xxSTR_Niveles:6];$al_rnNiveles{$i})
	BLOB_Blob2Vars (->[xxSTR_Niveles:6]xEventoCalendario:53;0;->at_EvtCalTipo;->al_EvtCalMaxDay;->al_EvtCalMaxWeek)
	
	Case of 
		: ($opt="new")
			APPEND TO ARRAY:C911(at_EvtCalTipo;$newValue)
			APPEND TO ARRAY:C911(al_EvtCalMaxDay;0)
			APPEND TO ARRAY:C911(al_EvtCalMaxWeek;0)
			
		: ($opt="delete")
			$fia:=Find in array:C230(at_EvtCalTipo;$newValue)
			If ($fia>0)
				DELETE FROM ARRAY:C228(at_EvtCalTipo;$fia)
				DELETE FROM ARRAY:C228(al_EvtCalMaxDay;$fia)
				DELETE FROM ARRAY:C228(al_EvtCalMaxWeek;$fia)
			End if 
			
		: ($opt="edit")
			$fia:=Find in array:C230(at_EvtCalTipo;$oldValue)
			If ($fia>0)
				at_EvtCalTipo{$fia}:=$newValue
			End if 
			
	End case 
	
	BLOB_Variables2Blob (->[xxSTR_Niveles:6]xEventoCalendario:53;0;->at_EvtCalTipo;->al_EvtCalMaxDay;->al_EvtCalMaxWeek)
	SAVE RECORD:C53([xxSTR_Niveles:6])
	KRL_UnloadReadOnly (->[xxSTR_Niveles:6])
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)