//%attributes = {}
  // AS_PaginaSesiones()
  // Por: Alberto Bachler: 20/05/13, 18:21:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_EdicionAutorizada)
C_LONGINT:C283($l_filaSeleccionada)
C_LONGINT:C283(vl_TipoInformacionSesion)
C_BOOLEAN:C305(vb_SesionesAñosAnteriores)

ASrs_CargaArreglos 
If (Size of array:C274(alSTK_sesionRecNum)>0)
	If (vl_TipoInformacionSesion=0)
		vl_TipoInformacionSesion:=1
	End if 
	OBJECT SET SCROLL POSITION:C906(lb_sesiones;1)
	LISTBOX SELECT ROW:C912(lb_sesiones;1;lk replace selection:K53:1)
	ASrs_CargaSesion 
Else 
	vt_InfoSesion:=""
	OBJECT SET SCROLL POSITION:C906(lb_sesiones;0)
	LISTBOX SELECT ROW:C912(lb_sesiones;0;lk remove from selection:K53:3)
End if 

SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_asignaturas;7)
  //_o_REDRAW LIST(hlTab_STR_asignaturas)

FORM GOTO PAGE:C247(7)
