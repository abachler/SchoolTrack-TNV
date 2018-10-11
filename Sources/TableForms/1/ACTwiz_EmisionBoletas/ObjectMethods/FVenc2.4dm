C_DATE:C307(vdACT_FVencimientoBol;$d_fechaActual)
C_BOOLEAN:C305($b_rsElectronica;$b_rsNormal)
ARRAY LONGINT:C221($alACT_id;0)
C_LONGINT:C283($l_indice)

$d_fechaActual:=vdACT_FVencimientoBol
$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vdACT_FVencimientoBol:=$FechaFecha
Else 
	vdACT_FVencimientoBol:=!00-00-00!
End if 

ACTbol_CargaDiasVencimiento ("ValidaCambioFecha";->vdACT_FVencimientoBol)

vtACT_FVencimientoBol:=String:C10(vdACT_FVencimientoBol;7)