//%attributes = {}
  // xALSet_AreasCamposUsuario()
  // Por: Alberto Bachler K.: 23-12-13, 14:07:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_Error;$l_refArea)

$l_refArea:=$1

AL_RemoveArrays ($l_refArea;1;2)
$l_Error:=AL_SetArraysNam ($l_refArea;1;2;"aUFItmName";"aUFItmVal")
AL_SetHeaders ($l_refArea;1;2;__ ("Campo");__ ("Información"))
AL_SetHdrStyle ($l_refArea;0;"Tahoma";9;1)
AL_SetStyle ($l_refArea;0;"Tahoma";9;0)
AL_SetRowOpts ($l_refArea;0;0;0;0;0)
AL_SetLine ($l_refArea;0)
AL_SetColOpts ($l_refArea;1;1;0;0;0;0;0)
AL_SetWidths ($l_refArea;1;2;90;185)
AL_SetSortOpts ($l_refArea;0;0;0;"";0)
AL_SetSort ($l_refArea;1)
AL_SetEnterable ($l_refArea;1;0)
AL_SetEnterable ($l_refArea;2;1)
AL_SetEntryOpts ($l_refArea;2;0;0;1;1;<>tXS_RS_DecimalSeparator)
AL_SetDividers ($l_refArea;"Black";"";15*16+3;"Black";"";15*16+3)
AL_SetHeight ($l_refArea;1;6;1;4;0;0)
AL_SetCallbacks ($l_refArea;"xALCB_EN_UserFields";"xALCB_EX_UserFields")
AL_UpdateArrays ($l_refArea;Size of array:C274(aUFItmName))
AL_SetScroll ($l_refArea;0;-3)


AL_SetMiscOpts ($l_refArea;1;0;"\\";0;1)