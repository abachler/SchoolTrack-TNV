AS_GuardaObservaciones 

If (vl_rowseleccionAL<Size of array:C274(aNtaStdNme))
	vl_rowseleccionAL:=vl_rowseleccionAL+1
	vt_CuadroTextoObj:=aNtaObj{vl_rowseleccionAL}
	vt_ObsAlumnoSeleccionadoAL:=aNtaObs{vl_rowseleccionAL}
	vl_IDAlumnoseleccionadoAL:=aNtaIDAlumno{vl_rowseleccionAL}
	vt_NombreAlumnoSeleccionadoAL:="Observaciones en "+vt_periodo+" para "+aNtaStdNme{vl_rowseleccionAL}
	vp_FotografiaAlumno:=aFotografias{vl_rowseleccionAL}
	vt_CuadroTextoObs:=vt_ObsAlumnoSeleccionadoAL
	vt_ObjAlumnoSeleccionadoAL:=aNtaObj{vl_rowseleccionAL}
	vt_CuadroTextoObj:=vt_ObjAlumnoSeleccionadoAL
Else 
	_O_DISABLE BUTTON:C193(bLast)
	_O_DISABLE BUTTON:C193(bNext)
End if 



