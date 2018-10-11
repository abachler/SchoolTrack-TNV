//%attributes = {}
  //xALPSet_CandidatosObservaciones

C_LONGINT:C283($error)

ARRAY DATE:C224(ad_fechaIngresoObservacion;0)
ARRAY TEXT:C222(at_ObservacionesCandidatos;0)
ARRAY TEXT:C222(at_Ingresador;0)

QUERY:C277([ADT_Candidatos_Observaciones:154];[ADT_Candidatos_Observaciones:154]IDAlumno:5=[Alumnos:2]numero:1)
SELECTION TO ARRAY:C260([ADT_Candidatos_Observaciones:154]FechaIngreso:3;ad_fechaIngresoObservacion;[ADT_Candidatos_Observaciones:154]Observaciones:2;at_ObservacionesCandidatos;[ADT_Candidatos_Observaciones:154]IngresadaPor:4;at_Ingresador)

$err:=ALP_DefaultColSettings (xALP_CandidatosObservaciones;1;"ad_fechaIngresoObservacion";__ ("Fecha");56;"";1;0)
$err:=ALP_DefaultColSettings (xALP_CandidatosObservaciones;2;"at_ObservacionesCandidatos";__ ("Observaciones");350;"";1;0)
$err:=ALP_DefaultColSettings (xALP_CandidatosObservaciones;3;"at_Ingresador";__ ("Ingresado por");80;"";1;0)

ALP_SetDefaultAppareance (xALP_CandidatosObservaciones;9;1;6;1;8)
AL_SetColOpts (xALP_CandidatosObservaciones;1;1;1;0;0)
AL_SetRowOpts (xALP_CandidatosObservaciones;0;0;0;0;1;0)
AL_SetCellOpts (xALP_CandidatosObservaciones;0;1;1)
AL_SetMiscOpts (xALP_CandidatosObservaciones;0;0;"\\";0;1)
  //AL_SetCallbacks (xALP_nuevasPostulaciones;"";"xALP_ADT_GuardarFormulario")
AL_SetMainCalls (xALP_CandidatosObservaciones;"";"")
AL_SetScroll (xALP_CandidatosObservaciones;0;0)
AL_SetEntryOpts (xALP_CandidatosObservaciones;7;0;0;1;1;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_CandidatosObservaciones;0;30;0)

  //dragging options
AL_SetDrgSrc (xALP_CandidatosObservaciones;1;"";"";"")
AL_SetDrgSrc (xALP_CandidatosObservaciones;2;"";"";"")
AL_SetDrgSrc (xALP_CandidatosObservaciones;3;"";"";"")
AL_SetDrgDst (xALP_CandidatosObservaciones;1;"";"";"")
AL_SetDrgDst (xALP_CandidatosObservaciones;1;"";"";"")
AL_SetDrgDst (xALP_CandidatosObservaciones;1;"";"";"")


