//%attributes = {}
  //ACTcc_OnLoadRecord

$ref:=$1

Case of 
	: ($ref=4)
		ACTpp_CargaArregloAñosHist ("avisosDesdeCtas";[ACT_CuentasCorrientes:175]ID:1)
	: ($ref=5)
		ACTpp_CargaArregloAñosHist ("pagosDesdeCtas";[ACT_CuentasCorrientes:175]ID:1)
		
	: ($ref=7)  // Saúl Ponce Ticket Nº 174553
		C_DATE:C307($vd_inicioBusqueda;$vd_finBusqueda)
		$vd_inicioBusqueda:=DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*)))
		$vd_finBusqueda:=DT_GetDateFromDayMonthYear (31;12;Year of:C25(Current date:C33(*)))
		ACT_GeneraEstadoDeCuenta ("CargaInterfaz";->[ACT_CuentasCorrientes:175];Record number:C243([ACT_CuentasCorrientes:175]);$vd_inicioBusqueda;$vd_finBusqueda;False:C215)
End case 
ACTcc_CargasALPCtasCtes ($ref)