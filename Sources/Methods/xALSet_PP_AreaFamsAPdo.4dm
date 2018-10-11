//%attributes = {}
  //xALSet_PP_AreaFamsAPdo

ARRAY TEXT:C222(atACT_NombreFam;0)
ARRAY TEXT:C222(atACT_CodigoFam;0)

$err:=ALP_DefaultColSettings (xALP_FamsApdo;1;"atACT_NombreFam";__ ("Familia");94)
$err:=ALP_DefaultColSettings (xALP_FamsApdo;2;"atACT_CodigoFam";__ ("Código");50)

  //general options
ALP_SetDefaultAppareance (xALP_FamsApdo;9;1;6;1;8)
AL_SetColOpts (xALP_FamsApdo;1;1;1;0;0)
AL_SetRowOpts (xALP_FamsApdo;0;1;0;0;1;1)
AL_SetCellOpts (xALP_FamsApdo;0;1;1)
AL_SetMiscOpts (xALP_FamsApdo;0;0;"\\";0;1)
AL_SetMainCalls (xALP_FamsApdo;"";"")
AL_SetScroll (xALP_FamsApdo;-3;-3)
AL_SetEntryOpts (xALP_FamsApdo;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_FamsApdo;0;30;0)