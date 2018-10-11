//%attributes = {}
  //xALPSet_ACT_Modelos

C_LONGINT:C283($Error)

ALP_DefaultColSettings (xAL_Modelos;1;"atACT_ModelosDoc";__ ("Modelo");150;"";0;0;1)
ALP_DefaultColSettings (xAL_Modelos;2;"atACT_ModelosDesc";__ ("Descripción");330;"";0;0;1)
ALP_DefaultColSettings (xAL_Modelos;3;"alACT_ModelosDocRegXPag";__ ("Documentos\rpor Página");74;"#0";0;0;1)
ALP_DefaultColSettings (xAL_Modelos;4;"alACT_ModelosDocID";"")
ALP_DefaultColSettings (xAL_Modelos;5;"abACT_ModelosEsSt";"")
AL_SetFilter (xAL_Modelos;3;"&9")

  //general options
ALP_SetDefaultAppareance (xAL_Modelos;9;4;4;2;6)
AL_SetColOpts (xAL_Modelos;1;1;1;2;0)
AL_SetRowOpts (xAL_Modelos;0;1;0;0;1;0)
AL_SetCellOpts (xAL_Modelos;0;1;1)
AL_SetMiscOpts (xAL_Modelos;0;0;"\\";0;1)
AL_SetMainCalls (xAL_Modelos;"";"")
AL_SetCallbacks (xAL_Modelos;"xAL_ACT_CBIN_ModelosBol";"xAL_ACT_CB_ModelosBol")
AL_SetScroll (xAL_Modelos;0;-3)
AL_SetEntryOpts (xAL_Modelos;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xAL_Modelos;0;30;0)

  //dragging options

AL_SetDrgSrc (xAL_Modelos;1;"";"";"")
AL_SetDrgSrc (xAL_Modelos;2;"";"";"")
AL_SetDrgSrc (xAL_Modelos;3;"";"";"")
AL_SetDrgDst (xAL_Modelos;1;"";"";"")
AL_SetDrgDst (xAL_Modelos;1;"";"";"")
AL_SetDrgDst (xAL_Modelos;1;"";"";"")