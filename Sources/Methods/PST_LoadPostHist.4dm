//%attributes = {}
  //PST_LoadPostHist

$rut:=$1

ARRAY TEXT:C222(atADT_ApeyNombPH;0)
_O_ARRAY STRING:C218(15;asADT_RUTPH;0)
ARRAY DATE:C224(adADT_FechaInsPH;0)
_O_ARRAY STRING:C218(35;asADT_SitFinalPH;0)
ARRAY LONGINT:C221(alADT_IDPH;0)

READ ONLY:C145([xxADT_PostulacionesHistoricas:112])
QUERY:C277([xxADT_PostulacionesHistoricas:112];[xxADT_PostulacionesHistoricas:112]RUT:1=$rut)
If (Records in selection:C76([xxADT_PostulacionesHistoricas:112])>0)
	SELECTION TO ARRAY:C260([xxADT_PostulacionesHistoricas:112]Apellidos_y_Nombres:2;atADT_ApeyNombPH;[xxADT_PostulacionesHistoricas:112]RUT:1;asADT_RUTPH;[xxADT_PostulacionesHistoricas:112]Fecha_Inscripcion:5;adADT_FechaInsPH;[xxADT_PostulacionesHistoricas:112]Sit_Final:6;asADT_SitFinalPH;[xxADT_PostulacionesHistoricas:112]ID:4;alADT_IDPH)
End if 

vtADT_Label:="Para el RUT "+$rut+" se han encontrado las siguientes postulaciones históricas:"