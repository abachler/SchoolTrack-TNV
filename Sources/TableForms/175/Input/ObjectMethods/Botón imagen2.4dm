vt_TransDesde:=""
vd_TransDesde:=!00-00-00!
vt_TransHasta:=""
vd_TransHasta:=!00-00-00!
AL_UpdateArrays (xALP_Transacciones;0)
ACTcc_LoadTransacciones (atACT_TipoTransacciones)
AL_UpdateArrays (xALP_Transacciones;-2)
AL_SetLine (xALP_Transacciones;0)