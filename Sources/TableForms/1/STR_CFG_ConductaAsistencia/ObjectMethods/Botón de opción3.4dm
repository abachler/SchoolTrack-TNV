$modo:=0
<>vr_RegistrarMinutosEnAtrasos:=$modo
PREF_Set (0;"RegistrarMinutosEnAtrasos";String:C10($modo))
cb_TGenInasDia:=0
vt_Intervalos:=""
OBJECT SET ENTERABLE:C238(vt_Intervalos;False:C215)
_O_DISABLE BUTTON:C193(*;"oTabla@")
AL_SetEnterable (xALP_TablaFaltasMin;2;0)
AL_SetEnterable (xALP_TablaFaltasMin;3;0)
AL_SetEnterable (xALP_TablaFaltasMin;4;0)