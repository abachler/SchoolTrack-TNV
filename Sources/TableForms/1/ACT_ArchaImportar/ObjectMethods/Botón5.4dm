$largopath:=Length:C16(vt_Ruta)
$vb_continuar:=False:C215
Case of 
	: ($largopath=0)
		CD_Dlog (0;__ ("Debe especificar una ruta de archivo."))
	: ($largopath>255)
		CD_Dlog (0;__ ("La ruta del archivo es demasiado larga."))
	: ((vlACT_id_modo_pago=0) & (vlACT_ImportadorID=0))
		CD_Dlog (0;__ ("Debe especificar el tipo de archivo a importar y el importador a utilizar."))
	: (vlACT_id_modo_pago=0)
		CD_Dlog (0;__ ("Debe especificar el tipo de archivo a importar."))
	: (vlACT_ImportadorID=0)
		CD_Dlog (0;__ ("Debe especificar el importador a utilizar."))
	: (vdACT_ImpRealDate>Current date:C33(*))
		CD_Dlog (0;__ ("La fecha de pago no puede ser superior a la fecha de hoy."))
	: ((vdACT_ImpRealDate=!00-00-00!) & (Not:C34(vb_fechaPago)))
		CD_Dlog (0;__ ("Debe especificar una fecha de pago."))
	: (((vb_selectionMonth2Pay) | (vb_selectionItems2Pay)) & ((Not:C34(vb_importSoloCuadrado)) & (Not:C34(vb_crearCargoAut))))  //validado también en ACTpgs_OpcionesImportacion
		$resp:=CD_Dlog (0;__ ("Al seleccionar el mes o los ítems a pagar debe especificar si creará un cargo o si no importará el pago si los montos no coinciden.")+"\r\r"+__ (" Si usted seleccionó los ítems a exportar en el archivo de rendición, puede continuar.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
		If ($resp=1)
			$vb_continuar:=True:C214
		End if 
	: ((vb_crearCargoAut) & (vsACT_SelectedItemName=""))
		CD_Dlog (0;__ ("Debe especificar el nombre del ítem de cargo."))
	: (Not:C34(ACTcm_IsMonthOpenFromDate (vdACT_ImpRealDate)))
		CD_Dlog (0;__ ("Los pagos no podrán ser registrados con esta fecha ya que corresponde a un mes cerrado."))
	Else 
		$vb_continuar:=True:C214
End case 
If ($vb_continuar)
	  //If ((vTipo="Cheque") | (vTipo="Efectivo") | (vTipo="Tarjeta de crédito"))
	  //If ((vlACT_id_modo_pago=-4) | (vlACT_id_modo_pago=-3) | (vlACT_id_modo_pago=-6))
	If (vb_fechaPago)  //20180828 RCH Ticket 214343
		$r:=CD_Dlog (0;__ ("¿Está seguro de querer registrar los pagos con la fecha leída desde el archivo?");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			vdACT_ImpRealDate:=!00-00-00!
			ACCEPT:C269
		End if 
	Else 
		$r:=CD_Dlog (0;__ ("¿Está seguro de querer registrar los pagos con fecha ")+String:C10(vdACT_ImpRealDate;7)+__ ("?");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			ACCEPT:C269
		End if 
	End if 
End if 