$d_fechaSuspension:=[BBL_Lectores:72]Fecha_Suspención:45
$d_fecha:=DT_PopCalendar 
If ($d_fecha<Current date:C33(*))
	CD_Dlog (0;"La fecha de suspensión no puede ser anterior o igual a hoy.")
Else 
	[BBL_Lectores:72]Fecha_Suspención:45:=$d_fecha
End if 