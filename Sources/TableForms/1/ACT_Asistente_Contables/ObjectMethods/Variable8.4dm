vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		vi_step:=1
		If ((cbFacturacion=1) | (cbRecaudacion=1))
			_O_ENABLE BUTTON:C192(bNext)
		Else 
			_O_DISABLE BUTTON:C193(bNext)
		End if 
	: (vi_PageNumber=2)
		vi_step:=2
	: (vi_PageNumber=3)
		Case of 
			: (b1=1)
				$year:=Year of:C25(Current date:C33(*))
				$month:=Month of:C24(Current date:C33(*))
				$day:=Day of:C23(Current date:C33(*))
				$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
			: (b3=1)
				$year:=viAño
				$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
			: (b5=1)
				$year:=viAño2
				$fileName:=String:C10($year)
			: (b6=1)
				$vt_Fecha1:=Replace string:C233(vt_Fecha1;<>tXS_RS_DateSeparator;"")
				$vt_Fecha2:=Replace string:C233(vt_Fecha2;<>tXS_RS_DateSeparator;"")
				$fileName:=$vt_Fecha1+"al"+$vt_Fecha2
		End case 
		If (cbRecaudacion=1)
			$fileRecaud:="Recaudacion"+$fileName
			If (SYS_IsWindows )
				$fileRecaud:=$fileRecaud+".txt"
			End if 
			  // Modificado por: Saúl Ponce (03-03-2017) Ticket 175810, la ruta es sólo informativa, no se debe crear acá el directorio
			  // $folderPath:=ACTabc_CreaRutaCarpetas ("Archivos Contables"+Folder separator+"Recaudacion"+Folder separator)
			$folderPath:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+"Archivos Contables"+Folder separator:K24:12+"Recaudación"+Folder separator:K24:12
			$ubicacionRecaud:=$folderPath+$fileRecaud
			$labelRecaud:="Archivo de recaudación:"+"\r\r"
			$ret:="\r\r"
		Else 
			$ubicacionRecaud:=""
			$labelRecaud:=""
			$ret:=""
		End if 
		If (cbFacturacion=1)
			  //$fileFact:="Facturacion"+$fileName
			$fileFact:="Facturacion"+vtACT_Documento+$fileName
			If (SYS_IsWindows )
				$fileFact:=$fileFact+".txt"
			End if 
			  //Modificado por: Saúl Ponce (03-03-2017) Ticket 175810, la ruta es sólo informativa, no se debe crear acá el directorio
			Case of 
				: (td1=1)
					  //$folderPath:=ACTabc_CreaRutaCarpetas ("Archivos Contables"+Folder separator+"Emisión"+Folder separator)
					$folderPath:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+"Archivos Contables"+Folder separator:K24:12+"Emisión"+Folder separator:K24:12
				: (td2=1)
					  //$folderPath:=ACTabc_CreaRutaCarpetas ("Archivos Contables"+Folder separator+"Facturación"+Folder separator)
					$folderPath:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+"Archivos Contables"+Folder separator:K24:12+"Facturación"+Folder separator:K24:12
				: (td3=1)
					  //$folderPath:=ACTabc_CreaRutaCarpetas ("Archivos Contables"+Folder separator+"Proyectado"+Folder separator)
					$folderPath:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+"Archivos Contables"+Folder separator:K24:12+"Proyectado"+Folder separator:K24:12
			End case 
			$ubicacionFact:=$folderPath+$fileFact
			$labelFact:="Archivo de facturación:"+"\r\r"
		Else 
			$ubicacionFact:=""
			$labelFact:=""
		End if 
		vtUbicacionArchivos:=$labelRecaud+$ubicacionRecaud+$ret+$labelFact+$ubicacionFact
End case 