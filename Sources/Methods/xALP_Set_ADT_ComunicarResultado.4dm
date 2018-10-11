//%attributes = {}
  //xALP_Set_ADT_ComunicarResultado 

C_LONGINT:C283($err)

$err:=ALP_DefaultColSettings (xALP_ComunicacionResultados;1;"<>FormasComunicarResultados";"";60;"";0;0;0)

  //general options
ALP_SetDefaultAppareance (xALP_ComunicacionResultados;9;1;6;1;8)
AL_SetColOpts (xALP_ComunicacionResultados;1;1;1;0;0)
AL_SetRowOpts (xALP_ComunicacionResultados;0;0;0;0;1;0)
AL_SetCellOpts (xALP_ComunicacionResultados;0;1;1)
AL_SetMiscOpts (xALP_ComunicacionResultados;1;0;"\\";0;1)
  //AL_SetCallbacks (xALP_ComunicacionResultados;"";"xALP_GuardarDocumento")
AL_SetMainCalls (xALP_ComunicacionResultados;"";"")
AL_SetScroll (xALP_ComunicacionResultados;0;0)
AL_SetEntryOpts (xALP_ComunicacionResultados;7;0;0;1;1;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_ComunicacionResultados;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_ComunicacionResultados;1;"";"";"")
AL_SetDrgSrc (xALP_ComunicacionResultados;2;"";"";"")
AL_SetDrgSrc (xALP_ComunicacionResultados;3;"";"";"")
AL_SetDrgDst (xALP_ComunicacionResultados;1;"";"";"")
AL_SetDrgDst (xALP_ComunicacionResultados;1;"";"";"")
AL_SetDrgDst (xALP_ComunicacionResultados;1;"";"";"")

