  // [TMT_Horario].InfoAsignacionAsignatura()
  // Por: Alberto Bachler: 30/05/13, 17:08:48
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY LONGINT:C221(al_recNumSesiones;0)
		ARRAY DATE:C224(ad_FechaSesiones;0)
		ARRAY LONGINT:C221(al_Inasistencias;0)
		vt_info:=""
		vt_AlumnosAusentes:=""
		If (Size of array:C274(at_DiasAsignados)>0)
			LISTBOX SELECT ROW:C912(lb_asignaciones;1;lk replace selection:K53:1)
			TMT_LeeDetallesAsignacion (al_recnumAsignaciones{1})
			If (Size of array:C274(al_RecNumSesiones)>0)
				LISTBOX SELECT ROW:C912(lb_sesiones;1;lk replace selection:K53:1)
				TMT_LeeDetallesSesion (al_RecNumSesiones{1})
			End if 
		End if 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 





