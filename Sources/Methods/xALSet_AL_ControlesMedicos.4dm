//%attributes = {}
  //xALSet_AL_ControlesMedicos

AL_RemoveArrays (xALP_ControlesMedicos;1;7)

$error:=ALP_DefaultColSettings (xALP_ControlesMedicos;1;"aCMedico_Fecha";__ ("Fecha");60;"";0;0;1)
$error:=ALP_DefaultColSettings (xALP_ControlesMedicos;2;"aCMedico_Curso";__ ("Curso");50)
$error:=ALP_DefaultColSettings (xALP_ControlesMedicos;3;"aCMedico_Edad";__ ("Edad");80)
$error:=ALP_DefaultColSettings (xALP_ControlesMedicos;4;"aCMedico_Talla";__ ("Talla (cm)");80;"###";0;0;1)
$error:=ALP_DefaultColSettings (xALP_ControlesMedicos;5;"aCMedico_Peso";__ ("Peso (kg)");70;"##0"+<>tXS_RS_DecimalSeparator+"0##";0;0;1)
$error:=ALP_DefaultColSettings (xALP_ControlesMedicos;6;"aCMedico_IMC";__ ("IMC");97)
$error:=ALP_DefaultColSettings (xALP_ControlesMedicos;7;"aCMedico_ID";"";10;"###0")

  //general options

AL_SetColOpts (xALP_ControlesMedicos;1;1;1;1;0)
AL_SetRowOpts (xALP_ControlesMedicos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_ControlesMedicos;0;1;1)
AL_SetMiscOpts (xALP_ControlesMedicos;0;0;"\\";0;1)
AL_SetMiscColor (xALP_ControlesMedicos;0;"White";0)
AL_SetMiscColor (xALP_ControlesMedicos;1;"White";0)
AL_SetMiscColor (xALP_ControlesMedicos;2;"White";0)
AL_SetMiscColor (xALP_ControlesMedicos;3;"White";0)
AL_SetCallbacks (xALP_ControlesMedicos;"";"xALCB_EX_ControlesMedicos")
AL_SetMainCalls (xALP_ControlesMedicos;"";"")
  //AL_SetScroll (xALP_ControlesMedicos;-2;-2)
AL_SetCopyOpts (xALP_ControlesMedicos;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_ControlesMedicos;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_ControlesMedicos;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_ControlesMedicos;1;2;1;4;2)
AL_SetDividers (xALP_ControlesMedicos;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetDrgOpts (xALP_ControlesMedicos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_ControlesMedicos;1;"";"";"")
AL_SetDrgSrc (xALP_ControlesMedicos;2;"";"";"")
AL_SetDrgSrc (xALP_ControlesMedicos;3;"";"";"")
AL_SetDrgDst (xALP_ControlesMedicos;1;"";"";"")
AL_SetDrgDst (xALP_ControlesMedicos;1;"";"";"")
AL_SetDrgDst (xALP_ControlesMedicos;1;"";"";"")