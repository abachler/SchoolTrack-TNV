  //Case of 
  //: (alProEvt=1)
  //If (Selected list items(aHL_SNT_ConfigLog)=1)
  //$vl_line:=AL_GetLine (Self->)
  //If ($vl_line>0)
  //C_TEXT($vt_Space)
  //$vt_Space:=" "
  //C_TEXT(vt_Log_DetalleEvento;vt_Log_Fecha;vt_Log_Hora;vt_Log_Evento;vt_Log_TipoEvento;vt_Log_Usuario;vt_Log_Maquina)
  //vt_Log_DetalleEvento:="Información detallada del evento seleccionado"
  //vt_Log_Fecha:="Fecha: "+String(atSNT_Log_Fecha{$vl_Line};7)+$vt_Space
  //vt_Log_Hora:="Hora: "+String(Time(Time string(alSNT_Log_Hora{$vl_Line}));2)
  //vt_Log_Evento:="Descripción del Evento: "+atSNT_Log_Evento{$vl_Line}
  //vt_Log_TipoEvento:="Tipo de Evento: "+atSNT_Log_EventType{$vl_Line}
  //vt_Log_Usuario:="Usuario generador del evento: "+atSNT_Log_GenBy{$vl_Line}
  //vt_Log_Maquina:="Máquina en la que se generó el evento: "+atSNT_Log_Machine{$vl_Line}
  //End if 
  //Else 
  //vt_Log_DetalleEvento:=""
  //vt_Log_Fecha:=""
  //vt_Log_Hora:=""
  //vt_Log_Evento:=""
  //vt_Log_TipoEvento:=""
  //vt_Log_Usuario:=""
  //vt_Log_Maquina:=""
  //End if 
  //End case 