vt_ObsDesde:=""
vd_ObsDesde:=!00-00-00!
vt_ObsHasta:=""
vd_ObsHasta:=!00-00-00!
AL_UpdateArrays (xALP_Observaciones;0)
ACTcc_LoadObs 
AL_UpdateArrays (xALP_Observaciones;-2)
AL_SetLine (xALP_Observaciones;0)