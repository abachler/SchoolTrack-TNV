//%attributes = {}
  //xALSet_XS_FieldSettings

C_LONGINT:C283($Error)

ARRAY INTEGER:C220(alXS_Fields_FieldNo;0)
ARRAY TEXT:C222(atXS_Fields_FieldName;0)
ARRAY TEXT:C222(atXS_Fields_FieldAlias;0)
ARRAY BOOLEAN:C223(abXS_Fields_Indexed;0)
ARRAY BOOLEAN:C223(abXS_Fields_CampoOculto;0)
ARRAY INTEGER:C220(alXS_Fields_Importable;0)
ARRAY REAL:C219(arXS_Fields_AutoformatMode;0)
ARRAY TEXT:C222(atXS_Fields_AssociatedListArray;0)
ARRAY BOOLEAN:C223(abXS_Fields_AutoSeqNumber;0)
ARRAY LONGINT:C221(alXS_Fields_RecNums;0)
AT_Inc (0)
$Error:=ALP_DefaultColSettings (xALP_Fields;AT_Inc ;"alXS_Fields_FieldNo";"N°";20;"##0";0;2;0)
$Error:=ALP_DefaultColSettings (xALP_Fields;AT_Inc ;"atXS_Fields_FieldName";"Nombre del\rCampo";135;"";0;2;0)
$Error:=ALP_DefaultColSettings (xALP_Fields;AT_Inc ;"atXS_Fields_FieldAlias";"Alias del\rCampo";135;"";0;2;1)
$Error:=ALP_DefaultColSettings (xALP_Fields;AT_Inc ;"abXS_Fields_Indexed";"Indexado";50;"Si;No";2;2;1)
$Error:=ALP_DefaultColSettings (xALP_Fields;AT_Inc ;"abXS_Fields_CampoOculto";"Oculto";50;"Si;No";2;2;1)
$Error:=ALP_DefaultColSettings (xALP_Fields;AT_Inc ;"alXS_Fields_Importable";"Importable";60;"";2;2;1)
$Error:=ALP_DefaultColSettings (xALP_Fields;AT_Inc ;"arXS_Fields_AutoformatMode";"Formato";50;"#0,0";3;2;1)
$Error:=ALP_DefaultColSettings (xALP_Fields;AT_Inc ;"atXS_Fields_AssociatedListArray";"Lista";80;"";0;2;1)
$Error:=ALP_DefaultColSettings (xALP_Fields;AT_Inc ;"abXS_Fields_AutoSeqNumber";"Secuenciable";72;"Si;No";2;2;1)
$Error:=ALP_DefaultColSettings (xALP_Fields;AT_Inc ;"alXS_Fields_RecNums";"Rec Nums")

  //general options
ALP_SetDefaultAppareance (xALP_Fields;9;2;2;2;1)
AL_SetColOpts (xALP_Fields;1;1;1;1;0)
AL_SetRowOpts (xALP_Fields;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Fields;0;1;1)
AL_SetMiscOpts (xALP_Fields;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Fields;"";"")
AL_SetCallbacks (xALP_Fields;"";"xALP_CB_EX_XSFields")
AL_SetScroll (xALP_Fields;0;0)
AL_SetEntryOpts (xALP_Fields;3;0;0;1;2;<>tXS_RS_DecimalSeparator)
AL_SetColLock (xALP_Fields;4)
AL_SetDrgOpts (xALP_Fields;0;30;0)






ARRAY TEXT:C222(at_CampoPrincipal;0)
ARRAY TEXT:C222(at_CampoRelacionado;0)
ARRAY TEXT:C222(at_TipoRelacion;0)
ARRAY TEXT:C222(at_metodoBusqueda;0)
ARRAY BOOLEAN:C223(ab_Informes;0)
ARRAY INTEGER:C220(al_NumeroCampoPrincipal;0)
ARRAY INTEGER:C220(al_numeroTablaRelacionada;0)
ARRAY INTEGER:C220(al_numeroCampoRelacionado;0)

AT_Inc (0)
$Error:=ALP_DefaultColSettings (xALP_RelatedFields;AT_Inc ;"at_CampoPrincipal";"Desde";70)
$Error:=ALP_DefaultColSettings (xALP_RelatedFields;AT_Inc ;"at_CampoRelacionado";"Hacia";150)
$Error:=ALP_DefaultColSettings (xALP_RelatedFields;AT_Inc ;"at_TipoRelacion";"Relación";50;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_RelatedFields;AT_Inc ;"at_metodoBusqueda";"Método de\rBúsqueda";60;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_RelatedFields;AT_Inc ;"al_NumeroCampoPrincipal";"Campo Fuente";0;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_RelatedFields;AT_Inc ;"al_numeroTablaRelacionada";"Dest TableNumber";0;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_RelatedFields;AT_Inc ;"al_numeroCampoRelacionado";"Dest Field Number";0;"";0;0;1)


  //general options
ALP_SetDefaultAppareance (xALP_RelatedFields;9;1;2;2;4)
AL_SetColOpts (xALP_RelatedFields;1;1;1;3;0)
AL_SetRowOpts (xALP_RelatedFields;0;1;0;0;1;0)
AL_SetCellOpts (xALP_RelatedFields;0;1;1)
AL_SetMiscOpts (xALP_RelatedFields;0;0;"\\";0;1)
AL_SetMainCalls (xALP_RelatedFields;"";"")
AL_SetCallbacks (xALP_RelatedFields;"";"xALP_CB_EX_XSRelations")
AL_SetScroll (xALP_RelatedFields;0;0)
AL_SetEntryOpts (xALP_RelatedFields;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetColLock (xALP_RelatedFields;0)
AL_SetDrgOpts (xALP_RelatedFields;0;30;0)
AL_SetSort (xALP_RelatedFields;2)


