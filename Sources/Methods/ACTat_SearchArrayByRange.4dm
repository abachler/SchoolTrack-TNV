//%attributes = {}
  //ACTat_SearchArrayByRange

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301(${2})
C_DATE:C307($vd_fechaInicio;$vd_fechaTermino)
C_LONGINT:C283($vl_mes;$vl_agno)
ARRAY LONGINT:C221($al_fechasDesde;0)
ARRAY LONGINT:C221($al_fechasHasta;0)

$vt_accion:=$1

If (Count parameters:C259>1)
	$ptr1:=$2
End if 
If (Count parameters:C259>2)
	$ptr2:=$3
End if 
If (Count parameters:C259>3)
	$ptr3:=$4
End if 
If (Count parameters:C259>4)
	$ptr4:=$5
End if 
If (Count parameters:C259>5)
	$ptr5:=$6
End if 

Case of 
	: ($vt_accion="DesdeRango")
		$vd_fechaInicio:=$ptr1->
		$vd_fechaTermino:=$ptr2->
		$ptr3->{0}:=$vd_fechaInicio
		AT_SearchArray ($ptr3;">=";->$al_fechasDesde)
		$ptr3->{0}:=$vd_fechaTermino
		AT_SearchArray ($ptr3;"<=";->$al_fechasHasta)
		AT_intersect (->$al_fechasDesde;->$al_fechasHasta;$ptr4)
		
	: ($vt_accion="DesdeAAAAMM")
		$vt_valorABuscar:=$ptr1->
		
		$vl_mes:=Num:C11(Substring:C12($vt_valorABuscar;5;2))
		$vl_agno:=Num:C11(Substring:C12($vt_valorABuscar;1;4))
		
		$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;$vl_mes;$vl_agno)
		$vd_fechaTermino:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($vl_mes;$vl_agno);$vl_mes;$vl_agno)
		ACTat_SearchArrayByRange ("DesdeRango";->$vd_fechaInicio;->$vd_fechaTermino;$ptr2;$ptr3)
		
		
End case 
