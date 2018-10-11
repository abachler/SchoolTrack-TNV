ARRAY TEXT:C222(SN3_Manual_TipoDato;0)
ARRAY LONGINT:C221(SN3_Manual_DataRefs;0)
ARRAY TEXT:C222(SN3_Manual_Niveles;0)
ARRAY LONGINT:C221(SN3_Manual_NivelesLong;0)
ARRAY TEXT:C222(SN3_Manual_CualesDatos;0)
ARRAY BOOLEAN:C223(SN3_Manual_CualesDatosBool;0)
ARRAY LONGINT:C221(SN3_Manual_Styles;0)

SELECT LIST ITEMS BY POSITION:C381(hl_Dato;1)
SELECT LIST ITEMS BY POSITION:C381(hl_Niveles;1)
_O_REDRAW LIST:C382(hl_Dato)
_O_REDRAW LIST:C382(hl_Niveles)
SN3_Manual_Todo:=1
SN3_Manual_Modificados:=0
_O_ENABLE BUTTON:C192(b_Manual_Enviar)

IT_SetButtonState (False:C215;->SN3_Manual_Todo;->SN3_Manual_Modificados;->hl_Niveles;->bAddEnvio;->bDelEnvio)