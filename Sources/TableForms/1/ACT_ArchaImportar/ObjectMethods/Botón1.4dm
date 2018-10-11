C_BOOLEAN:C305($salir)
$salir:=True:C214
Case of 
	: ((vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-10))
		If (vAOptions)
			
			<>atXS_MonthNames:=Month of:C24(Current date:C33(*))
			vi_SelectedMonth:=<>atXS_MonthNames
			
			FORM GOTO PAGE:C247(2)
			$salir:=False:C215
		End if 
	: (vlACT_id_modo_pago=-11)
		If (vAOptions)
			FORM GOTO PAGE:C247(3)
			$salir:=False:C215
		End if 
	Else 
		C_REAL:C285(vi_SelectedMonth)
		C_BOOLEAN:C305(vb_selectionMonth2Pay)
		C_BOOLEAN:C305(vb_selectionItems2Pay)
		C_BOOLEAN:C305(vb_selectionOrder2PayItems)
		C_BOOLEAN:C305(vb_importSoloCuadrado)
		C_BOOLEAN:C305(vb_crearCargoAut)
		C_TEXT:C284(vsACT_SelectedItemName)
		C_TEXT:C284(vt_ItemNames)
		C_REAL:C285(vlACT_selectedItemId)
		C_BOOLEAN:C305(vb_crearCargoAutCUP)
		vb_crearCargoAutCUP:=False:C215
		vlACT_selectedItemId:=0
		vt_ItemNames:=""
		vsACT_SelectedItemName:=""
		vb_crearCargoAut:=False:C215
		vb_importSoloCuadrado:=False:C215
		vb_selectionOrder2PayItems:=False:C215
		vb_selectionItems2Pay:=False:C215
		vb_selectionMonth2Pay:=False:C215
		vi_SelectedMonth:=0
End case 
If ($salir)
	$largopath:=Length:C16(vt_Ruta)
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
		: (Not:C34(ACTcm_IsMonthOpenFromDate (vdACT_ImpRealDate)))
			CD_Dlog (0;__ ("Los pagos no podrán ser registrados con esta fecha ya que corresponde a un mes cerrado."))
		Else 
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
	End case 
End if 