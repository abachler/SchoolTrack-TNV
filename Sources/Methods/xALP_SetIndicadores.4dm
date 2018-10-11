//%attributes = {}
  //xALP_SetIndicadores

C_LONGINT:C283($Error)

$Error:=ALP_DefaultColSettings (xALP_Indicadores;1;"atPST_Indicadores";__ ("Indicador");60;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Indicadores;2;"atPST_NombreIndicador";__ ("Nombre Indicador");125;"";0;0;1)
  //$Error:=ALP_DefaultColSettings (xALP_Indicadores;3;"atCML_ModuloAlerta";"Módulo";90;"")
  //$Error:=ALP_DefaultColSettings (xALP_Indicadores;4;"atCML_NombreArregloVar";"Arreglo Var";100;"")
  //$Error:=ALP_DefaultColSettings (xALP_Indicadores;3;"aiPST_Asistentes";"Asistentes";80;"####")

  //PST_ReadParameters
  //PST_SaveParameters

  //general options
ALP_SetDefaultAppareance (xALP_Indicadores;9;1;6;1;8)
AL_SetColOpts (xALP_Indicadores;1;1;1;0;0)
AL_SetRowOpts (xALP_Indicadores;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Indicadores;0;1;1)
AL_SetMiscOpts (xALP_Indicadores;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Indicadores;"";"")
  //  AL_SetCallbacks (xALP_Indicadores;"";"xALP_ADT_EX_GuardarIndicador")
AL_SetScroll (xALP_Indicadores;0;0)
AL_SetEntryOpts (xALP_Indicadores;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Indicadores;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Indicadores;1;"";"";"")
AL_SetDrgSrc (xALP_Indicadores;2;"";"";"")
AL_SetDrgSrc (xALP_Indicadores;3;"";"";"")
AL_SetDrgDst (xALP_Indicadores;1;"";"";"")
AL_SetDrgDst (xALP_Indicadores;1;"";"";"")
AL_SetDrgDst (xALP_Indicadores;1;"";"";"")