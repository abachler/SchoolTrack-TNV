//%attributes = {}
  //xALSet_FM_AreaEventos

ARRAY DATE:C224(ad_Date1;0)
ARRAY TEXT:C222(at_Text1;0)
ARRAY TEXT:C222(at_Text2;0)
ARRAY TEXT:C222(at_Text3;0)
ARRAY LONGINT:C221(al_Long1;0)

$err:=AL_SetArraysNam (xALP_EventosFamiliares;1;5;"ad_Date1";"at_Text1";"at_Text2";"at_Text3";"al_Long1")
AL_SetHeaders (xALP_EventosFamiliares;1;4;__ ("Fecha");__ ("Tipo de evento");__ ("Notas");__ ("Registrado por"))
AL_SetStyle (xALP_EventosFamiliares;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_EventosFamiliares;0;"Tahoma";9;1)
AL_SetStyle (xALP_EventosFamiliares;0;"Arial";9;0)
AL_SetHdrStyle (xALP_EventosFamiliares;0;"Tahoma";9;1)
AL_SetMiscOpts (xALP_EventosFamiliares;0;0;"'";0;1)
AL_SetDividers (xALP_EventosFamiliares;"Black";"";15*16+3;"Black";"";15*16+3)
AL_SetColOpts (xALP_EventosFamiliares;0;0;0;1;0;0;0)
AL_SetSortOpts (xALP_EventosFamiliares;1;1;0;"";1)
AL_SetWidths (xALP_EventosFamiliares;1;5;70;250;310;150;0)
AL_SetHeight (xALP_EventosFamiliares;2;6;2;8;0;0)
AL_SetLine (xALP_EventosFamiliares;0)
AL_SetSort (xALP_EventosFamiliares;-1)
AL_SetFormat (xALP_EventosFamiliares;0;"";0;2;0;0)
AL_SetScroll (xALP_EventosFamiliares;0;-3)

ALP_SetDefaultAppareance (xALP_EventosFamiliares;9;1;6;2;8)
AL_SetInterface (xALP_EventosFamiliares;AL Force OSX Interface;1;1;0;60;1)
