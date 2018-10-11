//%attributes = {}
  //xALPSet_CamposFormulario

C_LONGINT:C283($err)

$err:=ALP_DefaultColSettings (xALP_CamposFormulario;1;"abCampoObligatorio";__ ("Obligatorio");65;"Si;No";0;0;1)
$err:=ALP_DefaultColSettings (xALP_CamposFormulario;2;"atnombreCampo";__ ("Nombre");165;"";0;0;0)
$err:=ALP_DefaultColSettings (xALP_CamposFormulario;3;"atEtiquetaCampo";__ ("Etiqueta");158;"";0;0;1)
$err:=ALP_DefaultColSettings (xALP_CamposFormulario;4;"aiIDCampo";"ID (hidden)";30;"";0;0;0)


  //general options
ALP_SetDefaultAppareance (xALP_CamposFormulario;9;1;6;1;8)
AL_SetColOpts (xALP_CamposFormulario;1;1;1;1;0)
AL_SetRowOpts (xALP_CamposFormulario;0;0;0;0;1;0)
AL_SetCellOpts (xALP_CamposFormulario;0;1;1)
AL_SetMiscOpts (xALP_CamposFormulario;0;0;"\\";0;1)
AL_SetCallbacks (xALP_CamposFormulario;"";"xALP_EX_ValidarCampoObligatorio")
AL_SetMainCalls (xALP_CamposFormulario;"";"")
AL_SetScroll (xALP_CamposFormulario;0;0)
AL_SetEntryOpts (xALP_CamposFormulario;14;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_CamposFormulario;0;30;0)
AL_SetSortOpts (xALP_CamposFormulario;1;0;0)
  //dragging options

AL_SetDrgSrc (xALP_CamposFormulario;1;String:C10(xALP_CamposFormulario))
AL_SetDrgDst (xALP_CamposFormulario;1;String:C10(xALP_CamposFormulario))
  //AL_SetDrgDst (xALP_CamposFormulario;1;String(xALP_ItemsMatriz))

  //AL_SetDrgSrc (xALP_CamposFormulario;1;"";"";"")
  //AL_SetDrgSrc (xALP_CamposFormulario;2;"";"";"")
  //AL_SetDrgSrc (xALP_CamposFormulario;3;"";"";"")
  //AL_SetDrgDst (xALP_CamposFormulario;1;"";"";"")
  //AL_SetDrgDst (xALP_CamposFormulario;1;"";"";"")
  //AL_SetDrgDst (xALP_CamposFormulario;1;"";"";"")
