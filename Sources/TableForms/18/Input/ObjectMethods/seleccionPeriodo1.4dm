  // [Asignaturas].Input.seleccionPeriodo1()
  // Por: Alberto Bachler K.: 31-03-14, 10:49:48
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$text:=Replace string:C233(vtSTR_PeriodosPopupMenu;"; ";";( ")
$result:=Pop up menu:C542($text+"(-;Finales";0)

If ($result>0)
	  //AS_SaveComments 
	If ($result>Size of array:C274(atSTR_Periodos_nombre))
		vl_PeriodosObservaciones:=$result
		vlSTR_PeriodoSeleccionado:=0
		vt_periodo:="Finales"
		AS_PageObs ($result)  //notas finales
		OBJECT SET COLOR:C271(vt_periodo;-5)
	Else 
		vt_periodo:=atSTR_Periodos_Nombre{$result}
		vlSTR_PeriodoSeleccionado:=aiSTR_Periodos_Numero{$result}
		atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;vlSTR_PeriodoSeleccionado)
		vl_PeriodosObservaciones:=aiSTR_Periodos_Numero{$result}
		AS_PageObs (vl_PeriodosObservaciones)
		
		If (vlSTR_PeriodoSeleccionado#viSTR_PeriodoActual_Numero)
			vb_AvisaSiCambioPeriodo:=True:C214
			OBJECT SET COLOR:C271(*;"seleccionPeriodo1";-Grey:K11:15)
		Else 
			OBJECT SET COLOR:C271(*;"seleccionPeriodo1";-Black:K11:16)
		End if 
	End if 
	
	OBJECT SET TITLE:C194(*;"seleccionPeriodo1";vt_periodo)
End if 

