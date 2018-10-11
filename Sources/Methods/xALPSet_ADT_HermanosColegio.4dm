//%attributes = {}
  //xALPSet_ADT_HermanosColegio

_O_C_INTEGER:C282($err)

$err:=ALP_DefaultColSettings (xALP_HermanosEnColegio;1;"atNombreHemanos";__ ("Nombre");200;"";1;0)
$err:=ALP_DefaultColSettings (xALP_HermanosEnColegio;2;"atCursoHermanos";__ ("Curso");128;"";1;0)
  //$err:=ALP_DefaultColSettings (xALP_HermanosEnColegio;4;"atEstadoPostulacion";"Estado";70;"";1;0)
  //$err:=ALP_DefaultColSettings (xALP_HermanosEnColegio;5;"apRecibirPostulaciones";"";30;"1")
  //$err:=ALP_DefaultColSettings (xALP_HermanosEnColegio;6;"atRutPostulantes";"Rut Postulante";100;"")


ALP_SetDefaultAppareance (xALP_HermanosEnColegio;9;1;6;1;8)
AL_SetColOpts (xALP_HermanosEnColegio;1;1;1;0;0)
AL_SetRowOpts (xALP_HermanosEnColegio;0;0;0;0;1;0)
AL_SetCellOpts (xALP_HermanosEnColegio;0;1;1)
AL_SetMiscOpts (xALP_HermanosEnColegio;0;0;"\\";0;1)
  //AL_SetCallbacks (xALP_HermanosEnColegio;"";"xALPGuardarDetallePostulacion")  `llama a un metodo que guarda en un arreglo los valores que se deben enviar al servidor
AL_SetMainCalls (xALP_HermanosEnColegio;"";"")
AL_SetScroll (xALP_HermanosEnColegio;0;0)
AL_SetEntryOpts (xALP_HermanosEnColegio;3;0;0;1;1;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_HermanosEnColegio;0;30;0)

  //dragging options
AL_SetDrgSrc (xALP_HermanosEnColegio;1;"";"";"")
AL_SetDrgSrc (xALP_HermanosEnColegio;2;"";"";"")
AL_SetDrgSrc (xALP_HermanosEnColegio;3;"";"";"")
AL_SetDrgDst (xALP_HermanosEnColegio;1;"";"";"")
AL_SetDrgDst (xALP_HermanosEnColegio;1;"";"";"")
AL_SetDrgDst (xALP_HermanosEnColegio;1;"";"";"")

  //ADT_HermanosEnColegio