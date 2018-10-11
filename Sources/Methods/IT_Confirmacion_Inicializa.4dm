//%attributes = {}
  // IT_Confirmacion_Inicializa()
  // Por: Alberto Bachler: 07/06/13, 15:49:05
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284(vt_mensaje;vt_boton1;vt_Boton2;vt_Boton3;vt_Boton4;vt_Boton5)
C_LONGINT:C283(vl_Confirmacion_Error)


vt_mensaje:=""
vt_boton1:=""
vt_Boton2:=""
vt_Boton3:=""
vt_Boton4:=""
vt_Boton5:=""

ARRAY TEXT:C222(at_Confirmacion_Elementos;0)
ARRAY TEXT:C222(at_Confirmacion_Tags;0)
ARRAY TEXT:C222(at_Confirmacion_Valor;0)

vl_Confirmacion_Error:=0


REDUCE SELECTION:C351([xShell_MensajesAplicacion_Loc:242];0)
REDUCE SELECTION:C351([xShell_MensajesAplicacion:244];0)