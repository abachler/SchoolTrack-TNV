//%attributes = {}
  //xAL_CMT_CBEntry_Tabla

C_LONGINT:C283($1;$2;$3)
C_LONGINT:C283($col;$line)
  //alProEvt:=AL_GetLine ($1)
AL_GetCurrCell ($1;$col;$line)
REDRAW WINDOW:C456
AT_Initialize (->atCMT_NombreCampos)
Case of 
	: (xALP_AreaTransferenciaTablas=$1)  //registrosdel cuerpo
		Case of 
			: ($col=3)
			: ($col=4)
			: ($col=5)
				APPEND TO ARRAY:C911(atCMT_NombreCampos;"")
				
		End case 
		AL_SetEnterable (xALP_AreaTransferenciaTablas;6;2;atCMT_NombreCampos)  //6 FORMATO
		AL_UpdateArrays (xALP_AreaTransferenciaTablas;-2)
End case 
