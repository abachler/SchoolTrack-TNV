AS_GuardaObjetivosAlumnos 
vl_rowseleccionAL:=1

vt_ObjAlumnoSeleccionadoAL:=aNtaObj{vl_rowseleccionAL}
vl_IDAlumnoseleccionadoAL:=aNtaIDAlumno{vl_rowseleccionAL}
vt_NombreAlumnoSeleccionadoAL:="Objetivos en "+vt_periodo+" para "+aNtaStdNme{vl_rowseleccionAL}
vp_FotografiaAlumno:=aFotografias{vl_rowseleccionAL}
vt_CuadroTextoObj:=vt_ObjAlumnoSeleccionadoAL

_O_DISABLE BUTTON:C193(bFirst)
_O_DISABLE BUTTON:C193(bPrev)