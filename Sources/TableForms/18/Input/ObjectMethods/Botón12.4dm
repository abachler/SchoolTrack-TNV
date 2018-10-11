$text:=Replace string:C233(vtSTR_PeriodosPopupMenu;"; ";";( ")

If (([Asignaturas:18]ObjetivosxAlumno:112) & (vl_refPestañaObjetivosActiva=2))
	$result:=Pop up menu:C542($text+"(-;Finales";0)
Else 
	$result:=Pop up menu:C542($text;0)
End if 

If ($result>0)
	
	If (([Asignaturas:18]ObjetivosxAlumno:112) & (vl_refPestañaObjetivosActiva=2))
		OBJECT SET VISIBLE:C603(*;"vObj_P@";False:C215)
		If ($result>Size of array:C274(atSTR_Periodos_nombre))
			vl_PeriodosObservaciones:=0
			vlSTR_PeriodoSeleccionado:=0
			vt_periodo:=__ ("Finales")
		Else 
			vlSTR_PeriodoSeleccionado:=aiSTR_Periodos_Numero{$result}
			vt_periodo:=atSTR_Periodos_Nombre{$result}
		End if 
		AS_Load_ObjxAlu 
	Else 
		
		$Periodo:=aiSTR_Periodos_Numero{$result}
		vlSTR_PeriodoSeleccionado:=$periodo
		
		OBJECT SET VISIBLE:C603(*;"vObj_P@";False:C215)
		OBJECT SET VISIBLE:C603(*;"vObj_P"+String:C10(vlSTR_PeriodoSeleccionado);True:C214)
		
		If ($periodo#viSTR_PeriodoActual_Numero)
			vb_AvisaSiCambioPeriodo:=True:C214
		End if 
		vt_periodo:=atSTR_Periodos_Nombre{$result}
		GOTO OBJECT:C206(*;"vObj_P"+String:C10($periodo))
	End if 
	
End if 

If (vlSTR_PeriodoSeleccionado#viSTR_PeriodoActual_Numero)
	OBJECT SET COLOR:C271(vt_periodo;-3)
Else 
	OBJECT SET COLOR:C271(vt_periodo;-5)
End if 


