  // [TMT_Horario].InfoSesiones.lb_Sesiones()
  // Por: Alberto Bachler: 23/05/13, 20:13:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

  //Case of 
  //: (Form event=On Selection Change)
  //$l_row:=LB_GetSelectedRows (lb_asignaciones)
$l_elemento:=Find in array:C230(lb_asignaciones;True:C214)
If ($l_elemento>0)
	TMT_LeeDetallesAsignacion (al_recnumAsignaciones{lb_asignaciones})
	If (Size of array:C274(al_RecNumSesiones)>0)
		LISTBOX SELECT ROW:C912(lb_Sesiones;1;lk replace selection:K53:1)
		TMT_LeeDetallesSesion (al_RecNumSesiones{lb_Sesiones})
	Else 
		vt_info:=""
		vt_AlumnosAusentes:=""
	End if 
Else 
	vt_info:=""
	vt_AlumnosAusentes:=""
	ARRAY LONGINT:C221(al_recNumSesiones;0)
	ARRAY DATE:C224(ad_FechaSesiones;0)
	ARRAY LONGINT:C221(al_Inasistencias;0)
End if 
  //End case 

