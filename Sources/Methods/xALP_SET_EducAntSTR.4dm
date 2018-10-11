//%attributes = {}
  //  `xALP_SET_EducAntSTR
  //xALP_SET_EducAntSTR

C_LONGINT:C283($Error)
ARRAY TEXT:C222(<>tiposInstituciones;3)
<>tiposInstituciones{1}:="Colegio"
<>tiposInstituciones{2}:="Estudio Universitario"
<>tiposInstituciones{3}:="Otro"


  //APPEND TO ARRAY(atTipoInstitucion;"Universidad")
$error:=ALP_DefaultColSettings (xALP_EducAntSTR;1;"atTipoInstitucion";"Tipo Institución";150;"";0;2;1)
$error:=ALP_DefaultColSettings (xALP_EducAntSTR;2;"atInstitucion";"Institución";291;"";0;2;1)
$error:=ALP_DefaultColSettings (xALP_EducAntSTR;3;"atPaisEducacion";"País";106;"";0;2;1)
$error:=ALP_DefaultColSettings (xALP_EducAntSTR;4;"atGradoONivel";"Nivel/Carrera";150;"";0;2;1)
$error:=ALP_DefaultColSettings (xALP_EducAntSTR;5;"aiAno";"Año";78;"####";0;2;1)
$error:=ALP_DefaultColSettings (xALP_EducAntSTR;6;"IDEducacionAnterior";"ID";80;"####";0;2;0)
AL_SetEnterable (xALP_EducAntSTR;1;2;<>tiposInstituciones)
AL_SetEnterable (xALP_EducAntSTR;2;3;<>at_TitulosInstitucion)
AL_SetEnterable (xALP_EducAntSTR;4;3;<>at_TitulosNIvel)

  //general options
ALP_SetDefaultAppareance (xALP_EducAntSTR;9;1;6;1;8)
AL_SetInterface (xALP_EducAntSTR;AL Force OSX Interface;1;1;0;60;1)

AL_SetColOpts (xALP_EducAntSTR;1;1;1;1;0)
AL_SetRowOpts (xALP_EducAntSTR;0;0;0;0;1;0)
AL_SetCellOpts (xALP_EducAntSTR;0;1;1)
AL_SetMiscOpts (xALP_EducAntSTR;0;0;"\\";0;1)
AL_SetCallbacks (xALP_EducAntSTR;"xALP_ADT_SaveEducAntSTRIN";"xALP_ADT_SaveEducAntSTR")
AL_SetMainCalls (xALP_EducAntSTR;"";"")
AL_SetScroll (xALP_EducAntSTR;0;-3)
AL_SetEntryOpts (xALP_EducAntSTR;3;0;0;1;1;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_EducAntSTR;0;30;0)

  //dragging options
AL_SetDrgSrc (xALP_EducAntSTR;1;"";"";"")
AL_SetDrgSrc (xALP_EducAntSTR;2;"";"";"")
AL_SetDrgSrc (xALP_EducAntSTR;3;"";"";"")
AL_SetDrgDst (xALP_EducAntSTR;1;"";"";"")
AL_SetDrgDst (xALP_EducAntSTR;1;"";"";"")
AL_SetDrgDst (xALP_EducAntSTR;1;"";"";"")

