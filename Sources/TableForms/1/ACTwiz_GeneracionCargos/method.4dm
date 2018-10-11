C_LONGINT:C283($selectedMonth;$selectedYear;$thisYear;$nextYear)
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		_O_DISABLE BUTTON:C193(bPrev)
		
		ACTinit_LoadPrefs 
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		COPY ARRAY:C226(<>atACT_MAtrixName;atACT_MAtrixNameCopy3)
		_O_DISABLE BUTTON:C193(bMatrizaReemplazar)
		OBJECT SET COLOR:C271(*;"Reemplazo@";-61966)
		vd_currentDate:=Current date:C33(*)
		SORT ARRAY:C229(atACT_ItemNames2Charge;alACT_ItemIds2Charge)
		vt_ItemNames:=AT_array2text (->atACT_ItemNames2Charge)
		vt_Matrices:=AT_array2text (->atACT_MAtrixNameCopy3)
		
		  // defectos pagina 2
		
		$CantidadMatrices:=Size of array:C274(atACT_MatrixNameCopy3)
		$CantidadItems:=Size of array:C274(atACT_ItemNames2Charge)
		
		Case of 
				
			: (Table:C252(yBWR_currentTable)#Table:C252(->[ACT_CuentasCorrientes:175]))
				b1:=1
				b2:=0
				b3:=0
				_O_ENABLE BUTTON:C192(b1)
				_O_DISABLE BUTTON:C193(b2)
				_O_DISABLE BUTTON:C193(b3)
			: ($CantidadItems=0)
				b1:=0
				b2:=0
				b3:=1
				_O_DISABLE BUTTON:C193(b1)
				_O_DISABLE BUTTON:C193(b2)
				_O_DISABLE BUTTON:C193(b3)
			: (($CantidadItems>0) & ($CantidadMatrices=0))
				b1:=0
				b2:=1
				b3:=0
				_O_DISABLE BUTTON:C193(b1)
				_O_ENABLE BUTTON:C192(b2)
				_O_ENABLE BUTTON:C192(b3)
			: ($CantidadMatrices>0)
				b1:=1
				b2:=0
				b3:=0
				_O_ENABLE BUTTON:C192(b1)
				_O_ENABLE BUTTON:C192(b2)
				_O_ENABLE BUTTON:C192(b3)
		End case 
		
		  // defectos página 3 (seleccion del item de cargo)
		vsACT_SelectedItemName:=atACT_ItemNames2Charge{1}
		atACT_ItemNames2Charge:=1
		vlACT_selectedItemId:=alACT_ItemIds2Charge{1}
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=vlACT_selectedItemId)
		vsACT_MonedaDef:=[xxACT_Items:179]Moneda:10
		vrACT_MontoDef:=[xxACT_Items:179]Monto:7
		vsACT_CtaContableDef:=""
		vsACT_CentroContableDef:=""
		vsACT_CCtaContableDef:=""
		vsACT_CCentroContableDef:=""
		vsACT_CodAuxCtaDef:=""
		vsACT_CodAuxCCtaDef:=""
		
		  //20130910 RCH
		OBJECT SET VISIBLE:C603(*;"CentroCostoXNivel_@";BLOB size:C605([xxACT_Items:179]xCentro_Costo:41)>0)
		
		If (vsACT_MonedaDef#<>vsACT_MonedaColegio)
			OBJECT SET FORMAT:C236(vrACT_ValorMonedaDef;"|Despliegue_UF")
			If (vsACT_MonedaDef="UF")
				vrACT_ValorMonedaDef:=ACTut_fValorUF (Current date:C33(*))
			Else 
				vrACT_ValorMonedaDef:=ACTut_fValorDivisa (vsACT_MonedaDef)
			End if 
			vrACT_MontoPesosDef:=Round:C94((vrACT_ValorMonedaDef*vrACT_MontoDef);<>vlACT_Decimales)
		Else 
			OBJECT SET FORMAT:C236(vrACT_ValorMonedaDef;"|Despliegue_ACT")
		End if 
		  //SET VISIBLE(*;"@calc@";(vsACT_MonedaDef#"Peso Chileno"))
		OBJECT SET VISIBLE:C603(*;"@calcitem@";(vsACT_MonedaDef#<>vsACT_MonedaColegio))
		OBJECT SET VISIBLE:C603(*;"@ufcalcitem@";(vsACT_MonedaDef="UF"))
		  //SET VISIBLE(*;"@divisa@";((vsACT_MonedaDef#"UF") & (vsACT_MonedaDef#"Peso Chileno")))
		OBJECT SET VISIBLE:C603(*;"@divisacalcitem@";((vsACT_MonedaDef#"UF") & (vsACT_MonedaDef#<>vsACT_MonedaColegio)))
		
		OBJECT SET VISIBLE:C603(*;"ImputacionUnica";[xxACT_Items:179]Imputacion_Unica:24)
		
		  // defectos página 4 (seleccion del item de cargo)
		vsACT_Glosa:=""
		atACT_NombreMoneda:=1
		vsACT_Moneda:=atACT_NombreMoneda{atACT_NombreMoneda}
		prevMoneda:=vsACT_Moneda
		vrACT_Monto:=0
		cbACT_EsDescuento:=0
		cbACT_Afecto_IVA:=0
		cbACT_NoDocTrib:=0
		vrACT_ValorMoneda:=0
		vrACT_MontoPesos:=0
		vsACT_CtaContable:=""
		vsACT_CentroContable:=""
		vsACT_CCtaContable:=""
		vsACT_CCentroContable:=""
		vsACT_CodAuxCta:=""
		vsACT_CodAuxCCta:=""
		vbACT_ImputacionUnica:=False:C215
		OBJECT SET VISIBLE:C603(*;"@calcextra@";False:C215)
		OBJECT SET VISIBLE:C603(*;"ImputacionUnica1";False:C215)
		
		  // defectos página 5 (periodos y fechas)
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		COPY ARRAY:C226(aMeses;aMeses2)
		$selectedMonth:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"ACTcc_MesProyectado";String:C10(Month of:C24(Current date:C33(*)))))
		$selectedYear:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"ACTcc_AñoProyectado";String:C10(Year of:C25(Current date:C33(*)))))
		$thisYear:=Year of:C25(Current date:C33(*))
		$nextYear:=$thisYear+1
		Case of 
			: (($selectedMonth#0) & ($selectedYear#0))
				If (($selectedYear=$thisYear) | ($selectedYear=$nextYear))
					vdACT_AñoAviso:=$selectedYear
				Else 
					vdACT_AñoAviso:=$thisYear
				End if 
				l1:=Num:C11((vdACT_AñoAviso=$thisYear))
				l2:=Num:C11((vdACT_AñoAviso=$nextYear))
				vs1:=aMeses{$selectedMonth}
				vs2:=vs1
			: (($selectedMonth=0) & ($selectedYear#0))
				If (($selectedYear=$thisYear) | ($selectedYear=$nextYear))
					vdACT_AñoAviso:=$selectedYear
					vs1:=aMeses{1}
					vs2:=aMeses{12}
				Else 
					vdACT_AñoAviso:=$thisYear
					vs1:=aMeses{Month of:C24(Current date:C33(*))}
					vs2:=vs1
				End if 
				l1:=Num:C11((vdACT_AñoAviso=$thisYear))
				l2:=Num:C11((vdACT_AñoAviso=$nextYear))
			: (($selectedMonth=0) & ($selectedYear=0))
				vdACT_AñoAviso:=$thisYear
				l1:=1
				l2:=0
				vs1:=aMeses{Month of:C24(Current date:C33(*))}
				vs2:=vs1
		End case 
		vdACT_AñoAviso2:=vdACT_AñoAviso
		viACT_DiaGeneracion:=viACT_DiaDeuda
		aMeses:=Find in array:C230(aMeses;vs1)
		aMeses2:=Find in array:C230(aMeses2;vs2)
		If (aMeses2<aMeses)
			vdACT_AñoAviso2:=vdACT_AñoAviso2+1
		End if 
		
		Meses1:=AT_array2text (->aMeses)
		Meses2:=Meses1
		
		vdACT_FechaUFSel:=Current date:C33(*)
		  //aiACT_DiaUF:=Find in array(aiACT_DiaUF;Day of(vdACT_FechaUFSel))
		  //arACT_ValorUF:=aiACT_DiaUF
		  //SET VISIBLE(*;"uf@";(<>vtXS_CountryCode="cl"))
		
		  // defectos página 6  (universo de cuentas)
		
		ACTcc_GeneracionUniverso 
		OBJECT SET VISIBLE:C603(*;"Alumnos@";True:C214)
		OBJECT SET VISIBLE:C603(*;"Apdos@";False:C215)
		
		Case of 
			: (Table:C252(yBWR_currentTable)#Table:C252(->[ACT_CuentasCorrientes:175]))
				Case of 
					: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
						OBJECT SET TITLE:C194(f1;__ ("Sólo para los apoderados seleccionados en la lista"))
						OBJECT SET TITLE:C194(f2;__ ("Para todos los apoderados de la lista"))
						OBJECT SET TITLE:C194(f3;__ ("Para todos los alumnos activos"))
						OBJECT SET VISIBLE:C603(*;"Alumnos@";False:C215)
						OBJECT SET VISIBLE:C603(*;"Apdos@";True:C214)
						$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
						If (Records in set:C195($set)>0)
							USE SET:C118($set)
							$encontrados:=BWR_SearchRecords 
							If ($encontrados#-1)
								KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
								QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
								CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
								viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
							End if 
						End if 
						
					: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))  //20171201 ASM Ticket 188856 
						OBJECT SET TITLE:C194(f1;__ ("Sólo para los Terceros seleccionados en la lista"))
						OBJECT SET TITLE:C194(f2;__ ("Para todos los Terceros de la lista"))
						OBJECT SET TITLE:C194(f3;__ ("Para todos los alumnos activos"))
						OBJECT SET VISIBLE:C603(*;"Alumnos@";False:C215)
						OBJECT SET VISIBLE:C603(*;"Apdos@";True:C214)
						$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
						If (Records in set:C195($set)>0)
							USE SET:C118($set)
							$encontrados:=BWR_SearchRecords 
							If ($encontrados#-1)
								KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->[ACT_Terceros:138]Id:1;"")
								KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")
								QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
								CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
								viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
								viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
							End if 
						End if 
					Else 
						f1:=0
						f2:=0
						f3:=1
						_O_DISABLE BUTTON:C193(f1)
						_O_DISABLE BUTTON:C193(f2)
						QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
						CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
						viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
				End case 
			: (Size of array:C274(aBrSelect)>0)
				f1:=1
				f2:=0
				f3:=0
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				USE SET:C118($set)
				BWR_SearchRecords 
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
			: (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))>0)
				f1:=0
				f2:=1
				f3:=0
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				USE SET:C118($set)
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
			Else 
				f1:=0
				f2:=0
				f3:=1
				_O_DISABLE BUTTON:C193(f1)
				_O_DISABLE BUTTON:C193(f2)
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
		End case 
		r1:=1
		r2:=0
		Case of 
			: (f1=1)
				viACT_cuentas4:=viACT_cuentas1
			: (f2=1)
				viACT_cuentas4:=viACT_cuentas2
			: (f3=1)
				viACT_cuentas4:=viACT_cuentas3
		End case 
		viACT_cuentas5:=0
		If ($CantidadMatrices>0)
			vsACT_AsignedMatrix2:=atACT_MatrixNameCopy3{1}
		Else 
			vsACT_AsignedMatrix2:=""
		End if 
		OBJECT SET COLOR:C271(viACT_cuentas4;-3)
		OBJECT SET COLOR:C271(viACT_cuentas5;-12)
		
		  //vsACT_SelectedItem:=""
		  //vsACT_SelectedItemName:=""
		vi_PageNumber:=1
		vi_step:=1
		
		bc_EliminaDesctos:=0
		bc_ReplaceSameDescription:=0
		
		If (Application type:C494#4D Remote mode:K5:5)
			OBJECT SET VISIBLE:C603(*;"server@";False:C215)
			bc_ExecuteOnServer:=0
		Else 
			OBJECT SET VISIBLE:C603(*;"server@";True:C214)
			bc_ExecuteOnServer:=1
		End if 
		
		  //lista con monedas
		ACTcfg_LoadConfigData (6)
		ACTcfgmyt_OpcionesGenerales ("CargaListBoxEmision")
		C_TEXT:C284($vt_pref)
		$vt_pref:="0"
		cbMontosEnMonedaPago:=Num:C11(PREF_fGet (0;"ACTcfg_EmitirEnMontosFijos";$vt_pref))
		$vt_pref:=String:C10(cbMontosEnMonedaPago)
		ACTcfgmyt_OpcionesGenerales ("SetEstadoObjetosMontosFijos";->$vt_pref)
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
	: (Form event:C388=On Unload:K2:2)
		vt_msg:=""
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
End case 