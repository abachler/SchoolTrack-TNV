AL_UpdateArrays (xALP_Cuentas;0)

$vl_id:=Num:C11(ACTcfg_OpcionesContabilidad ("InsertaArreglosCuentasContables"))

AL_UpdateArrays (xALP_Cuentas;-2)
AL_SetEnterable (xALP_CtasEspeciales;2;2;<>asACT_CuentaCta)
GOTO OBJECT:C206(xALP_Cuentas)
$vl_pos:=Find in array:C230(<>alACT_idCta;$vl_id)
AL_GotoCell (xALP_Cuentas;1;$vl_pos)