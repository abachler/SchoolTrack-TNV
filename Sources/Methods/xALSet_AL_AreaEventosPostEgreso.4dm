//%attributes = {}
  //xALSet_AL_AreaEventosPostEgreso

ARRAY DATE:C224(ad_EventosEgreso_Fecha;0)
ARRAY TEXT:C222(at_EventosEgreso_Tipo;0)
ARRAY TEXT:C222(at_EventosEgreso_Carrera;0)
ARRAY LONGINT:C221(al_EventosEgreso_RecNum;0)
$err:=AL_SetArraysNam (xALP_EventosPostEgreso;1;4;"ad_EventosEgreso_Fecha";"at_EventosEgreso_Tipo";"at_EventosEgreso_Carrera";"al_EventosEgreso_RecNum")
AL_SetHeaders (xALP_EventosPostEgreso;1;4;__ ("Fecha");__ ("Tipo de evento");__ ("Carrera, título o cargo"))
AL_SetStyle (xALP_EventosPostEgreso;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_EventosPostEgreso;0;"Tahoma";9;1)
AL_SetStyle (xALP_EventosPostEgreso;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_EventosPostEgreso;0;"Tahoma";9;1)
AL_SetMiscOpts (xALP_EventosPostEgreso;0;0;"'";0)
AL_SetDividers (xALP_EventosPostEgreso;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetColOpts (xALP_EventosPostEgreso;0;0;0;1;0;0;0)
AL_SetSortOpts (xALP_EventosPostEgreso;1;1;0;"";1)
AL_SetWidths (xALP_EventosPostEgreso;1;4;48;200;200)
AL_SetHeight (xALP_EventosPostEgreso;1;2;1;4;0;0)
AL_SetLine (xALP_EventosPostEgreso;0)
AL_SetSort (xALP_EventosPostEgreso;-1)
ALP_SetDefaultAppareance (xALP_EventosPostEgreso)