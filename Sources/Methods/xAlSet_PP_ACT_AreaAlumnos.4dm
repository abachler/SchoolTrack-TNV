//%attributes = {}
  //xAlSet_PP_ACT_AreaAlumnos

  //ACTpp_FormArraysDeclarations ("ArreglosAlumnos") // se llama en ACTpp_FormArraysDeclarations


C_LONGINT:C283($Error)
C_LONGINT:C283($vl_espacioExtra;$vl_anchoFDP)

$vl_anchoFDP:=115
If (csACTcfg_ModosPagoXCuenta=0)
	$vl_espacioExtra:=$vl_anchoFDP/5
End if 

AT_Inc (0)
$err:=ALP_DefaultColSettings (xALP_Alumnos;AT_Inc ;"atACT_CCCurso";__ ("Curso");60+$vl_espacioExtra)
$err:=ALP_DefaultColSettings (xALP_Alumnos;AT_Inc ;"atACT_CCAlumno";__ ("Nombre");229+$vl_espacioExtra)
If (csACTcfg_ModosPagoXCuenta=1)
	$err:=ALP_DefaultColSettings (xALP_Alumnos;AT_Inc ;"atACT_CCModoPago";__ ("Forma Pago");$vl_anchoFDP)
End if 
$err:=ALP_DefaultColSettings (xALP_Alumnos;AT_Inc ;"arACT_CCFacturado";__ ("Emitidos");110+$vl_espacioExtra;"|Despliegue_ACT")
$err:=ALP_DefaultColSettings (xALP_Alumnos;AT_Inc ;"arACT_CCVencido";__ ("Vencidos");110+$vl_espacioExtra;"|Despliegue_ACT")
$err:=ALP_DefaultColSettings (xALP_Alumnos;AT_Inc ;"arACT_CCSaldo";__ ("Saldo");110+$vl_espacioExtra;"|Despliegue_ACT")

  //general options
ALP_SetDefaultAppareance (xALP_Alumnos;9;1;6;1;8)
AL_SetColOpts (xALP_Alumnos;1;1;1;0;0)
AL_SetRowOpts (xALP_Alumnos;0;1;0;0;1;1)
AL_SetCellOpts (xALP_Alumnos;0;1;1)
AL_SetMiscOpts (xALP_Alumnos;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Alumnos;"";"")
AL_SetScroll (xALP_Alumnos;0;-3)
AL_SetEntryOpts (xALP_Alumnos;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Alumnos;0;30;0)