vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		vi_step:=1
		  //$case1:=((cbPAT=1) & (vlACT_ExportadorPATID#0))
		  //$case2:=((cbPAC=1) & (vlACT_ExportadorPACID#0))
		  //$case3:=((cbCuponera=1) & (vlACT_ExportadorCUPID#0))
		
		$case1:=((vlACT_id_modo_pago=-9) & (vlACT_Exportador#0))  //pat
		$case2:=((vlACT_id_modo_pago=-10) & (vlACT_Exportador#0))  //pac
		$case3:=((vlACT_id_modo_pago=-11) & (vlACT_Exportador#0))  //cup
		
		If (($case1) | ($case2) | ($case3))
			_O_ENABLE BUTTON:C192(bNext)
		Else 
			_O_DISABLE BUTTON:C193(bNext)
		End if 
	: (vi_PageNumber=2)
		vi_step:=2
	: (vi_PageNumber=3)
		vt_aviso2:="Archivo "
		If ((vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-10) | (vlACT_id_modo_pago=-11))
			If (vlACT_Exportador>0)
				vt_aviso2:=vt_aviso2+"NO "
			End if 
		End if 
		
		vt_aviso2:=vt_aviso2+"generado con Asistente."
		
		If (<>gCountryCode="cl")
			OBJECT SET VISIBLE:C603(*;"UF@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"UF@";False:C215)
		End if 
		OBJECT SET VISIBLE:C603(*;"OtrasMonedas@";True:C214)
		
		Case of 
			: (b1=1)
				$year:=Year of:C25(Current date:C33(*))
				$month:=Month of:C24(Current date:C33(*))
				$day:=Day of:C23(Current date:C33(*))
				$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
			: (b2=1)
				$year:=viAño
				$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
			: (b3=1)
				$vt_Fecha1:=Replace string:C233(Replace string:C233(vt_Fecha1;"-";"");"/";"")
				$vt_Fecha2:=Replace string:C233(Replace string:C233(vt_Fecha2;"-";"");"/";"")
				$fileName:=$vt_Fecha1+"al"+$vt_Fecha2
			: (b4=1)
				$year:=viAño2
				$fileName:=String:C10($year)
		End case 
		
		$space:="\r\r"
		
		  //20120222 RCH Se obtiene nombre de carpeta dinamicamente...
		$tipoArchivo:=KRL_GetTextFieldData (->[ACT_Formas_de_Pago:287]id:1;->vlACT_id_modo_pago;->[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9)
		
		$ubicacion:=""
		$label:=""
		Case of 
			: (vlACT_id_modo_pago=-9)
				Case of 
					: (btn_Internacional=1)
						$file:="PAT_Int"+$fileName
					: (btn_Nacional=1)
						$file:="PAT_Nac"+$fileName
					Else 
						$file:="PAT"+$fileName
				End case 
			: (vlACT_id_modo_pago=-10)
				$file:="PAC"+$fileName
			: (vlACT_id_modo_pago=-10)
				$file:="CUP"+$fileName
			Else 
				$file:=$tipoArchivo+$fileName
		End case 
		
		  // MOD Ticket N° 196415 20180203 Patricio Aliaga
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=vlACT_Exportador)
		$file:=ACTabc_NombreArchivoBancario ($file)
		  //If (SYS_IsWindows )
		  //$file:=$file+".txt"
		  //End if 
		
		$folderPath:=ACTabc_CreaRutaCarpetas ("Archivos Bancarios"+Folder separator:K24:12+$tipoArchivo+Folder separator:K24:12)
		$ubicacion:=$folderPath+$file
		$label:="Archivo "+$tipoArchivo+":"+$space
		
		If (cbArchivoValidacion=1)
			$folderPath:=ACTabc_CreaRutaCarpetas ("Archivos Bancarios"+Folder separator:K24:12+"Archivos de Validación"+Folder separator:K24:12)
			$ubicacionFilesV:=$folderPath
			$labelFilesV:="Archivo(s) de Validación:"+$space
		Else 
			$ubicacionFilesV:=""
			$labelFilesV:=""
		End if 
		$ret:="\r"
		vtUbicacionArchivos:=$label+$ubicacion+$labelFilesV+$ubicacionFilesV
		
		If (vlACT_id_modo_pago=-10)
			vi_step:=3
		Else 
			vi_step:=2
		End if 
End case 