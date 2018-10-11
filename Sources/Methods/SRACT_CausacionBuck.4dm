//%attributes = {}
  //SRACT_CausacionBuck

WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SelFechaBuckingham";0;-Palette form window:K39:9;__ ("Seleccione Período"))
DIALOG:C40([xxSTR_Constants:1];"ACT_SelFechaBuckingham")
CLOSE WINDOW:C154
If (ok=1)
	READ ONLY:C145([xxACT_Items:179])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Transacciones:178])
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsRelativo:5=False:C215;*)
	QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]EsDescuento:6=False:C215)
	ORDER BY:C49([xxACT_Items:179];[xxACT_Items:179]Glosa:2;>)
	ARRAY TEXT:C222(atACT_xxGlosas;0)
	ARRAY LONGINT:C221(alACT_IDsxxItems;0)
	ARRAY REAL:C219(arACT_xxMontos;0)
	ARRAY REAL:C219(arACT_xxDesctos;0)
	ARRAY LONGINT:C221(alACT_xxNumTrans;0)
	SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_xxGlosas;[xxACT_Items:179]ID:1;alACT_IDsxxItems)
	ARRAY REAL:C219(arACT_xxMontos;Size of array:C274(atACT_xxGlosas))
	ARRAY REAL:C219(arACT_xxDesctos;Size of array:C274(atACT_xxGlosas))
	ARRAY LONGINT:C221(alACT_xxNumTrans;Size of array:C274(atACT_xxGlosas))
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando montos por item de cargo..."))
	Case of 
		: (vb_Hoy=1)
			vtitle:="Para el día "+String:C10(Current date:C33(*);7)
		: (vb_Mes=1)
			vtitle:="Para el mes de "+aMeses{vl_Mes}+" de "+String:C10(vl_año)
		: (vb_Año=1)
			vtitle:="Para el año "+String:C10(vl_Año)
		: (vb_Rango=1)
			$date1:=vd_Fecha1
			$date2:=vd_Fecha2
			vtitle:="Para el período entre el "+String:C10($date1;7)+" y el "+String:C10($date2)
	End case 
	vrACT_TotalIngresos:=0
	For ($i;1;Size of array:C274(alACT_IDsxxItems))
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=alACT_IDsxxItems{$i};*)
		Case of 
			: (vb_Hoy=1)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=Current date:C33(*))
				$date1:=Current date:C33(*)
				$date2:=Current date:C33(*)
			: (vb_Mes=1)
				$currentyear:=Year of:C25(Current date:C33(*))
				$lastday:=DT_GetLastDay (vl_Mes;$currentYear)
				$date1:=DT_GetDateFromDayMonthYear (1;vl_Mes;$currentyear)
				$date2:=DT_GetDateFromDayMonthYear ($lastday;vl_Mes;$currentyear)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>=$date1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$date2)
			: (vb_Año=1)
				$date1:=DT_GetDateFromDayMonthYear (1;1;vl_Año)
				$date2:=DT_GetDateFromDayMonthYear (31;12;vl_Año)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>=$date1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$date2)
			: (vb_Rango=1)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>=vd_Fecha1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=vd_Fecha2)
				$date1:=vd_Fecha1
				$date2:=vd_Fecha2
		End case 
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
		vrACT_TotalIngresos:=vrACT_TotalIngresos+Sum:C1([ACT_Transacciones:178]Debito:6)
		arACT_xxMontos{$i}:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
		arACT_xxDesctos{$i}:=Sum:C1([ACT_Cargos:173]Descuentos_XItem:35)+Sum:C1([ACT_Cargos:173]Descuentos_Familia:26)+Sum:C1([ACT_Cargos:173]Descuentos_Individual:31)+Sum:C1([ACT_Cargos:173]Descuentos_Ingresos:25)
		alACT_xxNumTrans{$i}:=Records in selection:C76([ACT_Cargos:173])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_IDsxxItems);"Calculando montos por item de cargo...")
	End for 
	vrACT_TotalItems:=AT_GetSumArray (->arACT_xxMontos)
	vrACT_TotalDesctos:=AT_GetSumArray (->arACT_xxDesctos)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
$0:=(ok=1)