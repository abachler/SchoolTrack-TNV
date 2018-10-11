//%attributes = {}
  //xALSet_ACT_AlumnosPagos

C_LONGINT:C283($Error)

AT_Inc (0)
$Error:=ALP_DefaultColSettings (ALP_AlumnosXPagar;AT_Inc ;"apACT_ASelectedAlumnos";__ ("Pagar/No Pagar");100;"1")
$Error:=ALP_DefaultColSettings (ALP_AlumnosXPagar;AT_Inc ;"alACT_AIdsCtas";__ ("Id Cuenta\rCorriente");55;"######";2)
$Error:=ALP_DefaultColSettings (ALP_AlumnosXPagar;AT_Inc ;"atACT_ANombresAlumnos";__ ("Apellidos y nombres");350)
$Error:=ALP_DefaultColSettings (ALP_AlumnosXPagar;AT_Inc ;"arACT_AMontoXAlumno";__ ("Monto del alumno");120;"|Despliegue_ACT_Pagos")
$Error:=ALP_DefaultColSettings (ALP_AlumnosXPagar;AT_Inc ;"arACT_AMontoSeleccionadoXAl";__ ("Monto(s) Seleccionado(s)");120;"|Despliegue_ACT_Pagos")
$Error:=ALP_DefaultColSettings (ALP_AlumnosXPagar;AT_Inc ;"abACT_ASelectedAlumno";"")

  //general options
ALP_SetDefaultAppareance (ALP_AlumnosXPagar;9;1;6;2;8)
AL_SetColOpts (ALP_AlumnosXPagar;1;1;1;1;0)
AL_SetRowOpts (ALP_AlumnosXPagar;0;1;0;0;1;0)
AL_SetCellOpts (ALP_AlumnosXPagar;0;1;1)
AL_SetMainCalls (ALP_AlumnosXPagar;"";"")
AL_SetScroll (ALP_AlumnosXPagar;0;-3)
AL_SetEntryOpts (ALP_AlumnosXPagar;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (ALP_AlumnosXPagar;0;30;0)