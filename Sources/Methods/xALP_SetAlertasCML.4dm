//%attributes = {}
C_LONGINT:C283($Error)

$Error:=ALP_DefaultColSettings (xALP_AlertasCML;1;"aiCML_IDAlerta";__ ("ID");30;"")
$Error:=ALP_DefaultColSettings (xALP_AlertasCML;2;"atCML_NombreAlerta";__ ("Nombre Alerta");140;"")
$Error:=ALP_DefaultColSettings (xALP_AlertasCML;3;"atCML_ModuloAlerta";__ ("Módulo");90;"")
  //$Error:=ALP_DefaultColSettings (xALP_AlertasCML;4;"atCML_NombreArregloVar";"Arreglo Var";100;"")
  //$Error:=ALP_DefaultColSettings (xALP_AlertasCML;3;"aiPST_Asistentes";"Asistentes";80;"####")

  //general options
ALP_SetDefaultAppareance (xALP_AlertasCML;9;1;6;1;8)
AL_SetColOpts (xALP_AlertasCML;1;1;1;0;0)
AL_SetRowOpts (xALP_AlertasCML;0;0;0;0;1;0)
AL_SetCellOpts (xALP_AlertasCML;0;1;1)
AL_SetMiscOpts (xALP_AlertasCML;0;0;"\\";0;1)
AL_SetMainCalls (xALP_AlertasCML;"";"")
  //AL_SetCallbacks (xALP_AlertasCML;"";"xALP_ADT_CBEX_ExamsGroups")
AL_SetScroll (xALP_AlertasCML;0;0)
AL_SetEntryOpts (xALP_AlertasCML;1;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_AlertasCML;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_AlertasCML;1;"";"";"")
AL_SetDrgSrc (xALP_AlertasCML;2;"";"";"")
AL_SetDrgSrc (xALP_AlertasCML;3;"";"";"")
AL_SetDrgDst (xALP_AlertasCML;1;"";"";"")
AL_SetDrgDst (xALP_AlertasCML;1;"";"";"")
AL_SetDrgDst (xALP_AlertasCML;1;"";"";"")