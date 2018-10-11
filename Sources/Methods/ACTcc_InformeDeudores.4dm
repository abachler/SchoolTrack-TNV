//%attributes = {}
  //ACTcc_InformeDeudores

If (USR_GetMethodAcces (Current method name:C684))
	
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcc_DeudoresDetallado";0;Palette form window:K39:9;__ ("Opciones de generación"))
	DIALOG:C40([xxSTR_Constants:1];"ACTcc_DeudoresDetallado")
	CLOSE WINDOW:C154
	
	If (ok=1)
		C_DATE:C307($vd_fechaHasta)
		C_LONGINT:C283($vl_WhichPhoneInfSelected;$l_idTermometro;$proc)
		ARRAY LONGINT:C221(alACT_IDsDefinitivos;0)
		ARRAY LONGINT:C221($al_recnumCtasCorrientes;0)
		ARRAY LONGINT:C221($al_recnumCargos;0)
		
		For ($i;1;Size of array:C274(abACT_PrintItem))
			If (abACT_PrintItem{$i})
				AT_Insert (1;1;->alACT_IDsDefinitivos)
				alACT_IDsDefinitivos{1}:=alACT_IDsItems{$i}
			End if 
		End for 
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([xxACT_Items:179])
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([Cursos:3])
		
		$msg:=__ ("AccountTrack generará un archivo Excel con la morosidad detallada para")
		$msg2:=__ (" Esta operación puede ser larga. ¿Desea continuar?")
		Case of 
			: (b1=1)
				$year:=viAño
				$month:=vi_SelectedMonth
				$dateInicial:=DT_GetDateFromDayMonthYear (1;$month;$year)
				$dateFinal:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($month;$year);$month;$year)
				$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
				$msg:=$msg+__ (" el mes de ")+<>atXS_MonthNames{$month}+" "+String:C10($year)+"."+$msg2
				$vd_fechaHasta:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($month;$year);$month;$year)
			: (b2=1)
				$year:=viAño2
				$dateInicial:=DT_GetDateFromDayMonthYear (1;1;$year)
				$dateFinal:=DT_GetDateFromDayMonthYear (31;12;$year)
				$fileName:=String:C10($year)
				$msg:=$msg+__ (" el año ")+String:C10($year)+"."+$msg2
				$vd_fechaHasta:=$dateFinal
			: (b3=1)
				$dateInicial:=Date:C102(vt_Fecha1)
				$dateFinal:=Date:C102(vt_Fecha2)
				$fileName:=Replace string:C233(Replace string:C233(vt_Fecha1;"/";"");":";"")+"_"+Replace string:C233(Replace string:C233(vt_Fecha2;"/";"");":";"")
				$msg:=$msg+__ (" el período entre el ")+vt_Fecha1+" y el "+vt_Fecha2+"."+$msg2
				$vd_fechaHasta:=Date:C102(vt_Fecha2)
		End case 
		
		  //20100525 en algunas ocasiones puede ser que el campo Total saldos no esté actualizado. Con esto se recalcula el saldo de la cuenta...
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=al_NivelDesdeInf{al_NivelDesdeInf};*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=al_NivelHastaInf{al_NivelHastaInf})
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
		
		If (cb_SoloCtasActivas=1)
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		End if 
		
		  //20100525 en algunas ocasiones puede ser que el campo Total saldos no esté actualizado. Con esto se recalcula el saldo de la cuenta...
		KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7>=$dateInicial;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<=$dateFinal)
		QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;alACT_IDsDefinitivos)
		If (cb_considerarSoloPagosPeriodo=0)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23<0)
		End if 
		CREATE SET:C116([ACT_Cargos:173];"$Todos")
		KRL_RelateSelection (->[ACT_Cargos:173]ID_CargoRelacionado:47;->[ACT_Cargos:173]ID:1;"")
		QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;alACT_IDsDefinitivos)
		CREATE SET:C116([ACT_Cargos:173];"$relacionados")
		UNION:C120("$Todos";"$relacionados";"$Todos")
		CLEAR SET:C117("$relacionados")
		USE SET:C118("$Todos")
		CLEAR SET:C117("$Todos")
		  //para considerar los cargos relacionados de los Items en seleccion como descuentos.
		  //ABC //TKT202037 //20180723
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
		If (Records in selection:C76([ACT_Cargos:173])>0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recnumCargos;"")
		End if 
		If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$al_recnumCtasCorrientes;"")
		End if 
		If (Size of array:C274($al_recnumCtasCorrientes)>0)
			$r:=CD_Dlog (0;$msg;"";__ ("Si");__ ("No"))
			If ($r=1)
				$vl_WhichPhoneInfSelected:=aPtr_WhichPhoneInf
				
				C_BLOB:C604($blob)
				SET BLOB SIZE:C606($blob;0)
				BLOB_Variables2Blob (->$blob;0;->$al_recnumCtasCorrientes;->$al_recnumCargos;->cb_considerarSoloPagosPeriodo;->cb_ProximoCurso;->cb_Agrupar;->cb_FiltrosExcel;->cb_PrintPhone;->cb_ObsApdo;->$vl_WhichPhoneInfSelected;->$fileName;->$dateInicial;->$dateFinal)
				
				$l_idTermometro:=IT_UThermometer (1;0;__ ("Generando Informe Morosidad en el servidor..."))
				$proc:=Execute on server:C373("ACT_MetodoInforme_Deudores";Pila_256K;"Generando Informe Morosidad";$blob)
				
				DELAY PROCESS:C323(Current process:C322;120)
				
				C_BLOB:C604($xBlob)  // para recibir el archivo generado en el servidor
				SET BLOB SIZE:C606($xBlob;0)
				
				C_LONGINT:C283($l_proc)
				$l_proc:=IT_UThermometer (1;0;"Generando reporte...")
				While (Test semaphore:C652("InformeServer"))
					DELAY PROCESS:C323(Current process:C322;60)
				End while 
				IT_UThermometer (-2;$l_proc)
				GET PROCESS VARIABLE:C371($proc;x_Informe;$xBlob)
				$b_terminar:=True:C214
				SET PROCESS VARIABLE:C370($proc;b_terminar;$b_terminar)
				
				$folderPath:=ACTabc_CreaRutaCarpetas ("Informes de morosidad"+Folder separator:K24:12)
				CREATE FOLDER:C475($folderPath;*)
				
				$fileName:="Info_Morosidad_Detallado_"+$fileName
				$filePath:=$folderPath+$fileName
				$vt_filePath:=$filePath+".txt"
				BLOB TO DOCUMENT:C526($vt_filePath;$xBlob)
				IT_UThermometer (-2;$l_idTermometro)
				If (SYS_TestPathName ($vt_filePath)=1)
					ACTcd_DlogWithShowOnDisk ($filePath+".txt";0;__ ("La exportación de la morosidad detallada para ")+$fileName+__ (" ha concluido.")+"\r\r"+__ ("La encontrará en: ")+"\r"+$folderPath+"\r\r"+__ ("Le recomendamos abrirla con Microsoft Excel."))
				End if 
				
			End if 
		Else 
			If (cb_SoloCtasActivas=1)
				CD_Dlog (0;__ ("No hay cuentas corrientes activas en el rango de niveles seleccionado."))
			Else 
				CD_Dlog (0;__ ("No hay cuentas corrientes en el rango de niveles seleccionado."))
			End if 
		End if 
	End if 
	ARRAY BOOLEAN:C223(abACT_PrintItem;0)
	ARRAY TEXT:C222(atACT_GlosasItem;0)
	ARRAY LONGINT:C221(alACT_IDsItems;0)
	ARRAY TEXT:C222(at_NivelDesdeInf;0)
	ARRAY TEXT:C222(at_NivelHastaInf;0)
	ARRAY LONGINT:C221(al_NivelDesdeInf;0)
	ARRAY LONGINT:C221(al_NivelHastaInf;0)
	ARRAY TEXT:C222(at_WhichPhoneInf;0)
	ARRAY POINTER:C280(aPtr_WhichPhoneInf;0)
	ARRAY TEXT:C222(asACT_SinItemMark;0)
	
	
End if 
