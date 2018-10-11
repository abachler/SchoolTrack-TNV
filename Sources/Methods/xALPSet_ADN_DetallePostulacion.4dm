//%attributes = {}
  //xALPSet_ADN_DetallePostulacion

_O_C_INTEGER:C282($err)

$err:=ALP_DefaultColSettings (xALP_DetallePostulacion;1;"atNombreCampo";__ ("Campo");150;"";1;0)
$err:=ALP_DefaultColSettings (xALP_DetallePostulacion;2;"atValorCampo";__ ("Valor");130;"";1;0;1)
$err:=ALP_DefaultColSettings (xALP_DetallePostulacion;3;"aiIdCampos";"IDCampo";100;"";1;0)
$err:=ALP_DefaultColSettings (xALP_DetallePostulacion;4;"atTagCampo";"Tag Campo";100;"";1;0)
$err:=ALP_DefaultColSettings (xALP_DetallePostulacion;5;"atSiLlenado";"";30;"";1;0)


  //$err:=ALP_DefaultColSettings (xALP_DetallePostulacion;4;"atEstadoPostulacion";"Estado";70;"";1;0)
  //$err:=ALP_DefaultColSettings (xALP_DetallePostulacion;5;"apRecibirPostulaciones";"";30;"1")
  //$err:=ALP_DefaultColSettings (xALP_DetallePostulacion;6;"atRutPostulantes";"Rut Postulante";100;"")

ALP_SetDefaultAppareance (xALP_DetallePostulacion;9;1;6;1;8)
AL_SetColOpts (xALP_DetallePostulacion;1;1;1;3;0)
AL_SetRowOpts (xALP_DetallePostulacion;0;0;0;0;1;0)
AL_SetCellOpts (xALP_DetallePostulacion;0;1;1)
AL_SetMiscOpts (xALP_DetallePostulacion;0;0;"\\";0;1)
AL_SetCallbacks (xALP_DetallePostulacion;"";"xALPGuardarDetallePostulacion")  //llama a un metodo que guarda en un arreglo los valores que se deben enviar al servidor
AL_SetMainCalls (xALP_DetallePostulacion;"";"")
AL_SetScroll (xALP_DetallePostulacion;0;0)
AL_SetEntryOpts (xALP_DetallePostulacion;3;0;0;1;1;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_DetallePostulacion;0;30;0)

  //dragging options
AL_SetDrgSrc (xALP_DetallePostulacion;1;"";"";"")
AL_SetDrgSrc (xALP_DetallePostulacion;2;"";"";"")
AL_SetDrgSrc (xALP_DetallePostulacion;3;"";"";"")
AL_SetDrgDst (xALP_DetallePostulacion;1;"";"";"")
AL_SetDrgDst (xALP_DetallePostulacion;1;"";"";"")
AL_SetDrgDst (xALP_DetallePostulacion;1;"";"";"")