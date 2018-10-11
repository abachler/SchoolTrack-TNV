  //Ticket Nº 174553
C_POINTER:C301($vy_persona)
C_LONGINT:C283($vl_recNumPer)

$vl_recNumPer:=Record number:C243([Personas:7])
vd_EstadoCtaDesde:=Date:C102(vt_EstadoCtaDesde)
vd_EstadoCtaHasta:=Date:C102(vt_EstadoCtaHasta)


If ((vd_EstadoCtaDesde#!00-00-00!) & (vd_EstadoCtaHasta#!00-00-00!))
	$vy_persona:=->[Personas:7]
	ACT_GeneraEstadoDeCuenta ("CargaInterfaz";$vy_persona;$vl_recNumPer;vd_EstadoCtaDesde;vd_EstadoCtaHasta)
Else 
	CD_Dlog (0;"Establezca las fechas para la búsqueda.")
End if 
GOTO RECORD:C242([Personas:7];$vl_recNumPer)