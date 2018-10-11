C_LONGINT:C283($recNum_Cta)
$recNum_Cta:=Record number:C243([ACT_CuentasCorrientes:175])
CREATE SET:C116([ACT_CuentasCorrientes:175];"ctasCtes")
ACTcc_Activar 
USE SET:C118("ctasCtes")
SET_ClearSets ("ctasCtes")
KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$recNum_Cta;True:C214)
REDRAW WINDOW:C456