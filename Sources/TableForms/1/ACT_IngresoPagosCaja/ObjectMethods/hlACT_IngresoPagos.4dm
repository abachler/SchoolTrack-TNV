C_LONGINT:C283($page;$proc)
$page:=Selected list items:C379(Self:C308->)
$vb_bool:=False:C215
$proc:=IT_UThermometer (1;0;__ ("Actualizando datos..."))
ACTpgs_MarkNotMark ("InitArrays";->$page;->$vb_bool)
ACTpgs_OrdenaCargosAviso (1;True:C214)
ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
IT_UThermometer (-2;$proc)

AL_UpdateArrays (ALP_AvisosXPagar;-1)
AL_UpdateArrays (ALP_ItemsXPagar;-1)
AL_UpdateArrays (ALP_AlumnosXPagar;-1)
AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;-1)