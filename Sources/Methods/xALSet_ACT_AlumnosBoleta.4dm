//%attributes = {}
  //xALSet_ACT_AlumnosBoleta

C_LONGINT:C283($Error)

$error:=ALP_DefaultColSettings (xALP_AlumnosBol;1;"atACT_CCCurso";"";45)
$error:=ALP_DefaultColSettings (xALP_AlumnosBol;2;"atACT_CCAlumno";"";300)

  //general options
ALP_SetDefaultAppareance (xALP_AlumnosBol;9;1;2;1)
AL_SetColOpts (xALP_AlumnosBol;1;1;1;0;0)
AL_SetRowOpts (xALP_AlumnosBol;0;1;0;0;1;1)
AL_SetCellOpts (xALP_AlumnosBol;0;1;1)
AL_SetMiscOpts (xALP_AlumnosBol;1;0;"\\";0;1)
AL_SetMainCalls (xALP_AlumnosBol;"";"")
AL_SetScroll (xALP_AlumnosBol;0;-3)
AL_SetEntryOpts (xALP_AlumnosBol;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_AlumnosBol;0;30;0)