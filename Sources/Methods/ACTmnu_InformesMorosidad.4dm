//%attributes = {}
  //ACTmnu_InformesMorosidad

C_LONGINT:C283($proc)

If (USR_GetMethodAcces (Current method name:C684))
	vbACT_MostrarFechaCorte:=True:C214
	vi_TipoInforme:=2
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño";0;Palette form window:K39:9;"Selección del período de generación")
	DIALOG:C40([xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño")
	CLOSE WINDOW:C154
	vbACT_MostrarFechaCorte:=False:C215
	
	If (ok=1)
		If (cb_XApdo=1)
			$label1:=__ ("Apoderado")
			$label2:=__ ("Apdos")
		Else 
			$label1:=__ ("Cuenta Corriente")
			$label2:=__ ("Ctas")
		End if 
		$msg:=__ ("AccountTrack generará un archivo Excel con la morosidad por ")+$label1+__ (" para")
		$msg2:=__ (" Esta operación puede ser larga. ¿Desea continuar?")
		Case of 
			: (b1=1)
				$year:=Year of:C25(Current date:C33(*))
				$month:=Month of:C24(Current date:C33(*))
				$day:=Day of:C23(Current date:C33(*))
				$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
				$msg:=$msg+__ (" el día de hoy.")+$msg2
				
			: (b3=1)
				$year:=viAño
				$month:=vi_SelectedMonth
				$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
				$msg:=$msg+__ (" el mes de ")+<>atXS_MonthNames{$month}+" "+String:C10($year)+"."+$msg2
			: (b5=1)
				$year:=viAño2
				$fileName:=String:C10($year)
				$msg:=$msg+__ (" el año ")+String:C10($year)+"."+$msg2
			: (b6=1)
				$dateInicial:=Replace string:C233(Replace string:C233(vt_Fecha1;"/";"-");":";"-")
				$dateFinal:=Replace string:C233(Replace string:C233(vt_Fecha2;"/";"-");":";"-")
				$fileName:=$dateInicial+"al"+$dateFinal
				$Header2:=""
				$msg:=$msg+__ (" el período entre el ")+vt_Fecha1+__ (" y el ")+vt_Fecha2+"."+$msg2
		End case 
		$r:=CD_Dlog (0;$msg;"";__ ("Si");__ ("No"))
		
		
		
		
		If ($r=1)
			$l_proc:=IT_UThermometer (1;0;"Generando reporte...")
			$xBlob:=ACT_MetodoInforme_Morosidad (cb_XApdo;cb_incluirProtestado;b1;b3;b5;b6;cb_fechaSeleccionada;cb_considerarSoloPagosPeriodo;vi_SelectedMonth;viAño2;vt_Fecha1;vt_Fecha2;vd_Fecha1;vd_Fecha2;cb_SoloActivas;cb_SoloDeudas;vt_Modo;viAño;VD_FECHACORTE)
			IT_UThermometer (-2;$l_proc)
			
			$folderPath:=ACTabc_CreaRutaCarpetas ("Informes de morosidad"+Folder separator:K24:12)
			
			$fileName:="InfoMorosidad_General_"+$label2+"_"+$fileName
			If (cb_incluirProtestado=1)
				$fileName:=$fileName+"_IncProt"
			End if 
			$filePath:=$folderPath+$fileName
			$vt_filePath:=$filePath+".txt"
			BLOB TO DOCUMENT:C526($vt_filePath;$xBlob)
			If (SYS_TestPathName ($vt_filePath)=1)
				ACTcd_DlogWithShowOnDisk ($filePath+".txt";0;__ ("La exportación de la morosidad por ")+__ ($label1)+__ (" para ")+$fileName+__ (" ha concluido.")+"\r\r"+__ ("La encontrará en: ")+"\r"+$folderPath+"\r\r"+__ ("Le recomendamos abrirla con Microsoft Excel."))
			End if 
		End if 
		
		
		
		
	End if 
End if 


