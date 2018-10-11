//%attributes = {}
  //  //ACTcc_InformeMorosidadSimple
C_BLOB:C604($x_blob)
C_DATE:C307($vd_fechaHasta)
C_LONGINT:C283($l_proc)
C_POINTER:C301($TotalMorosidadPtr)
C_TEXT:C284($aHeaderTextAño;$col2;$Header1;$Header2;$HeaderText2;$HeaderTextRow2;$vt_filePath)


C_REAL:C285(TotalMorosidad1;TotalMorosidad2;TotalMorosidad3;TotalMorosidad4;TotalMorosidad5;TotalMorosidad6;TotalMorosidad7;TotalMorosidad8;TotalMorosidad9;TotalMorosidad10;TotalMorosidad11;TotalMorosidad12)

If (USR_GetMethodAcces (Current method name:C684))
	vbACT_MostrarFechaCorte:=True:C214
	vi_TipoInforme:=4
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño";0;Palette form window:K39:9;__ ("Selección del período de generación"))
	DIALOG:C40([xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño")
	CLOSE WINDOW:C154
	vbACT_MostrarFechaCorte:=False:C215
	If (ok=1)
		
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([ACT_Cargos:173])
		If (cb_XApdo=1)
			$label1:=__ ("Apoderado")
			$label2:=__ ("Apdos")
			$hdr:=__ ("No.")+"\t"+__ ("Cod. Interno")+"\t"+__ ("Nombre")+"\t"
			$tabTotales:="\t"*2
		Else 
			$label1:=__ ("Cuenta Corriente")
			$label2:=__ ("Ctas")
			$hdr:=__ ("No.")+"\t"+__ ("Código")+"\t"+__ ("Nombre")+"\t"+__ ("Curso")+"\t"
			$tabTotales:="\t"*3
		End if 
		COPY ARRAY:C226(<>atXS_MonthNames;aHeaders1)
		$HeaderText1:=$hdr+AT_array2text (->aHeaders1;"\t")+"\t"+"Anual"+"\r\n"
		$msg:=__ ("AccountTrack generará un archivo Excel con la morosidad simplificada por ")+$label1+__ (" para")
		$msg2:=__ (" Esta operación puede ser larga. ¿Desea continuar?")
		
		$year:=viAño2
		$fileName:=String:C10($year)
		$titulo:=__ ("Morosidad por ")+$label1+__ (" para el año ")+String:C10($year)+"\r\n"+"\r\n"+"\r\n"
		$msg:=$msg+__ (" el año ")+String:C10($year)+"."+$msg2
		If (cb_considerarSoloPagosPeriodo=1)
			$msg:=$msg+"\r\r"+__ (" - El informe sólo considera los pagos realizados hasta el ")+ST_Boolean2Str (cb_fechaSeleccionada=1;String:C10(vd_fechaCorte);__ ("último día de cada mes"))+"-"
			$fileName:="InfoMorosidad_Simple_P_"+$label2+"_"+$fileName
		Else 
			$fileName:="InfoMorosidad_Simple_"+$label2+"_"+$fileName
		End if 
		
		If (cb_incluirProtestado=1)
			$fileName:=$fileName+"_IncProt"
		End if 
		
		$r:=CD_Dlog (0;$msg;"";__ ("Si");__ ("No"))
		If ($r=1)
			$l_proc:=IT_UThermometer (1;0;"Generando reporte...")
			$x_blob:=ACT_MetodoInforme_Simple (cb_XApdo;cb_incluirProtestado;cb_fechaSeleccionada;cb_considerarSoloPagosPeriodo;viAño2;cb_SoloActivas;cb_SoloDeudas;vd_fechaCorte)
			IT_UThermometer (-2;$l_proc)
			
			$folderPath:=ACTabc_CreaRutaCarpetas ("Informes de morosidad"+Folder separator:K24:12)
			CREATE FOLDER:C475($folderPath;*)
			
			$fileName:="InfoMorosidad_Simple_"+$label2+"_"+$fileName
			If (cb_incluirProtestado=1)
				$fileName:=$fileName+"_IncProt"
			End if 
			$filePath:=$folderPath+$fileName
			$vt_filePath:=$filePath+".txt"
			BLOB TO DOCUMENT:C526($vt_filePath;$x_blob)
			If (SYS_TestPathName ($vt_filePath)=1)
				ACTcd_DlogWithShowOnDisk ($filePath+".txt";0;__ ("La exportación de la morosidad por ")+__ ($label1)+__ (" para ")+$fileName+__ (" ha concluido.")+"\r\r"+__ ("La encontrará en: ")+"\r"+$folderPath+"\r\r"+__ ("Le recomendamos abrirla con Microsoft Excel."))
			End if 
			
		End if 
	End if 
End if 








