//%attributes = {}
  //ACTpp_OnRecordLoad

$ref:=$1
Case of 
	: ($ref=3)
		
	: ($ref=4)
		ACTpp_CargaArregloAñosHist ("avisos";[Personas:7]No:1)
		
	: ($ref=5)
		ACTpp_CargaArregloAñosHist ("pagos";[Personas:7]No:1)
		
	: ($ref=6)
		ACTpp_CargaArregloAñosHist ("doctrib";[Personas:7]No:1)
		
	: ($ref=7)
		
	: ($ref=8)
		ACTpp_CargaArregloAñosHist ("docdep";[Personas:7]No:1)
		
	: ($ref=9)
		
	: ($ref=10)
		
	: ($ref=11)
		ACTdgi_CargaInfo ([Personas:7]No:1)
		
	: ($ref=12)  // Saúl Ponce Ticket Nº 174553
		C_DATE:C307($vd_inicioBusqueda;$vd_finBusqueda)
		$vd_inicioBusqueda:=DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*)))
		$vd_finBusqueda:=DT_GetDateFromDayMonthYear (31;12;Year of:C25(Current date:C33(*)))
		ACT_GeneraEstadoDeCuenta ("CargaInterfaz";->[Personas:7];Record number:C243([Personas:7]);$vd_inicioBusqueda;$vd_finBusqueda;False:C215)
End case 
ACTpp_CargaALPPersonas ($ref)