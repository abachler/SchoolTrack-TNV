  //Ticket Nº 174553
C_POINTER:C301($vy_cuenta)
C_LONGINT:C283($vl_recNumCta)

$vl_recNumCta:=Record number:C243([ACT_CuentasCorrientes:175])
vd_EstadoCtaDesde:=Date:C102(vt_EstadoCtaDesde)
vd_EstadoCtaHasta:=Date:C102(vt_EstadoCtaHasta)


If ((vd_EstadoCtaDesde#!00-00-00!) & (vd_EstadoCtaHasta#!00-00-00!))
	$vy_cuenta:=->[ACT_CuentasCorrientes:175]
	$vl_recNumCta:=Record number:C243([ACT_CuentasCorrientes:175])
	ACT_GeneraEstadoDeCuenta ("CargaInterfaz";$vy_cuenta;$vl_recNumCta;vd_EstadoCtaDesde;vd_EstadoCtaHasta)
Else 
	CD_Dlog (0;"Establezca las fechas para la búsqueda.")
End if 
GOTO RECORD:C242([ACT_CuentasCorrientes:175];$vl_recNumCta)