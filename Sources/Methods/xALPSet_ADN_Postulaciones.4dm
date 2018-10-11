//%attributes = {}
  //xALPSet_ADN_Postulaciones

_O_C_INTEGER:C282($err)

$err:=ALP_DefaultColSettings (xALP_nuevasPostulaciones;1;"atNombrePostulante";__ ("Nombre del Postulante");200;"";1;0)
$err:=ALP_DefaultColSettings (xALP_nuevasPostulaciones;2;"atFechaPostulacion";__ ("Fecha de Postulación");120;"";1;0)
$err:=ALP_DefaultColSettings (xALP_nuevasPostulaciones;3;"atGrupoEtario";__ ("Grupo");100;"";1;0)
$err:=ALP_DefaultColSettings (xALP_nuevasPostulaciones;4;"atEstadoPostulacion";__ ("Estado");75;"";1;0)
$err:=ALP_DefaultColSettings (xALP_nuevasPostulaciones;5;"apRecibirPostulaciones";"";22;"1")
$err:=ALP_DefaultColSettings (xALP_nuevasPostulaciones;6;"atRutPostulantes";__ ("Rut Postulante");90;"")
$err:=ALP_DefaultColSettings (xALP_nuevasPostulaciones;7;"atFecha";"Fecha";0;"";1;0)
$err:=ALP_DefaultColSettings (xALP_nuevasPostulaciones;8;"atHoraPostulacion";__ ("Hora");0;"";1;0)
$err:=ALP_DefaultColSettings (xALP_nuevasPostulaciones;9;"atIDFormularioPostulacion";__ ("Formulario");0;"";1;0)

ALP_SetDefaultAppareance (xALP_nuevasPostulaciones;9;1;6;1;8)
AL_SetColOpts (xALP_nuevasPostulaciones;1;1;1;4;0)
AL_SetRowOpts (xALP_nuevasPostulaciones;0;0;0;0;1;0)
AL_SetCellOpts (xALP_nuevasPostulaciones;0;1;1)
AL_SetMiscOpts (xALP_nuevasPostulaciones;0;0;"\\";0;1)
  //AL_SetCallbacks (xALP_nuevasPostulaciones;"";"xALP_ADT_GuardarFormulario")
AL_SetMainCalls (xALP_nuevasPostulaciones;"";"")
AL_SetScroll (xALP_nuevasPostulaciones;0;0)
AL_SetEntryOpts (xALP_nuevasPostulaciones;7;0;0;1;1;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_nuevasPostulaciones;0;30;0)

  //dragging options
AL_SetDrgSrc (xALP_nuevasPostulaciones;1;"";"";"")
AL_SetDrgSrc (xALP_nuevasPostulaciones;2;"";"";"")
AL_SetDrgSrc (xALP_nuevasPostulaciones;3;"";"";"")
AL_SetDrgDst (xALP_nuevasPostulaciones;1;"";"";"")
AL_SetDrgDst (xALP_nuevasPostulaciones;1;"";"";"")
AL_SetDrgDst (xALP_nuevasPostulaciones;1;"";"";"")
