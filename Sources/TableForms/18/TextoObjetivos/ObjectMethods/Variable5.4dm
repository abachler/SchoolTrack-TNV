AS_GuardaObjetivosAlumnos 
vl_rowseleccionAL:=Size of array:C274(aNtaStdNme)

vt_ObjAlumnoSeleccionadoAL:=aNtaObj{vl_rowseleccionAL}
vl_IDAlumnoseleccionadoAL:=aNtaIDAlumno{vl_rowseleccionAL}
vt_NombreAlumnoSeleccionadoAL:="Objetivos en "+vt_periodo+" para "+aNtaStdNme{vl_rowseleccionAL}
vp_FotografiaAlumno:=aFotografias{vl_rowseleccionAL}
vt_CuadroTextoObj:=vt_ObjAlumnoSeleccionadoAL