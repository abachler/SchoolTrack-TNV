  // [TMT_Horario].InfoSesiones()
  // Por: Alberto Bachler: 23/05/13, 20:09:34
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
ARRAY LONGINT:C221($al_recNums;0)

Case of 
	: (Form event:C388=On Load:K2:1)
		If (Size of array:C274(al_RecNumSesiones)>0)
			LISTBOX SELECT ROW:C912(lb_Sesiones;1;lk replace selection:K53:1)
			TMT_LeeDetallesSesion (al_RecNUmSesiones{1})
		Else 
			vt_info:=""
			LISTBOX SELECT ROW:C912(lb_Sesiones;0;lk remove from selection:K53:3)
		End if 
		
		LISTBOX SORT COLUMNS:C916(lb_alumnos;5;>)
		vl_ColumnaAlumnos:=1
		
		If (Size of array:C274(al_RecNumSesiones)>0)
			vt_etiquetaSesiones:=__ ("Sesiones (^0 sesiones, ^1 inasistencias)")
			vt_etiquetaSesiones:=Replace string:C233(vt_etiquetaSesiones;"^0";String:C10(Size of array:C274(al_RecNumSesiones)))
			vt_etiquetaSesiones:=Replace string:C233(vt_etiquetaSesiones;"^1";String:C10(AT_GetSumArray (->al_Inasistencias)))
		Else 
			vt_etiquetaSesiones:=__ ("Sesiones")
		End if 
		
		If (Size of array:C274(atTMT_alumnos_nombres)>0)
			vt_etiquetaAlumnos:=__ ("Alumnos")+" ("+String:C10(Size of array:C274(atTMT_alumnos_nombres))+")"
		Else 
			vt_etiquetaAlumnos:=__ ("Alumnos")
		End if 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

