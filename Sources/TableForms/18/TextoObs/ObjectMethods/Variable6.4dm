AS_GuardaObservaciones 

vl_rowseleccionAL:=1
vt_CuadroTextoObj:=aNtaObj{vl_rowseleccionAL}
vt_ObsAlumnoSeleccionadoAL:=aNtaObs{vl_rowseleccionAL}
vl_IDAlumnoseleccionadoAL:=aNtaIDAlumno{vl_rowseleccionAL}
vt_NombreAlumnoSeleccionadoAL:="Observaciones en "+vt_periodo+" para "+aNtaStdNme{vl_rowseleccionAL}
vp_FotografiaAlumno:=aFotografias{vl_rowseleccionAL}
vt_CuadroTextoObs:=vt_ObsAlumnoSeleccionadoAL
vt_ObjAlumnoSeleccionadoAL:=aNtaObj{vl_rowseleccionAL}
vt_CuadroTextoObj:=vt_ObjAlumnoSeleccionadoAL
_O_DISABLE BUTTON:C193(bFirst)
_O_DISABLE BUTTON:C193(bPrev)
