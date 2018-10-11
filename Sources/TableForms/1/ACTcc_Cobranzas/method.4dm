C_LONGINT:C283($table)

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		  //ACTinit_LoadPrefs 
		  //xALP_SET_ACT_DivisasEmision 
		OBJECT SET ENABLED:C1123(bPrev;False:C215)
		
		vd_currentDate:=Current date:C33(*)
		vi_PageNumber:=1
		vi_step:=1
		
		  // defectos pagina 2 (emision/impresión)
		b1:=0
		b2:=1
		b3:=0
		OldPos:=2
		
		C_BOOLEAN:C305(Generar;b_soloProyectados)  //20160820 RCH
		b_soloProyectados:=False:C215
		Generar:=Not:C34(b_soloProyectados)
		
		  //201206016 RCH Se declaran las variables...
		ACTcar_OpcionesGenerales ("DeclaraVarsEm")
		
		ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
		
		mAvisoApoderado:=bAvisoApoderado  //viene de las prefs. no sacar!!!
		mAvisoAlumno:=bAvisoAlumno
		
		  // defectos pagina 3 (periodos y modelo de impresión)
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
		
		aMeses:=Find in array:C230(aMeses;vs1)
		aMeses2:=Find in array:C230(aMeses2;vs2)
		
		Meses1:=AT_array2text (->aMeses)
		Meses2:=Meses1
		vdACT_DiaAviso:=viACT_DiaDeuda
		vdACT_FechaAviso:=DT_GetDateFromDayMonthYear (vdACT_DiaAviso;aMeses;vdACT_AñoAviso)
		
		l_diasEmision:=viACT_DiaVencimiento
		
		vdACT_DiaVctoAviso:=Day of:C23(vdACT_FechaAviso+viACT_DiaVencimiento)
		cbVctoSegunConf:=1
		IT_SetEnterable (Not:C34(cbVctoSegunConf=1);0;->vdACT_DiaVctoAviso)
		
		vdACT_FechaUFSel:=Current date:C33(*)
		cbIncluirSaldosAnteriores:=cb_IncluirSaldosAnteriores  //from prefs
		ACTac_OpcionesGenerales ("CargaModelosDeInforme")
		xALSet_ACT_ModelosEmision 
		AL_SetLine (xALP_SelModeloAviso;0)
		
		  // defectos página 4 (seleccion del universo)
		ACTcc_CobranzasUniverso 
		
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
						
					: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
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
							End if 
						End if 
					Else 
						f1:=0
						f2:=0
						f3:=1
						OBJECT SET ENABLED:C1123(f1;False:C215)
						OBJECT SET ENABLED:C1123(f2;False:C215)
						
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
				OBJECT SET ENABLED:C1123(f1;False:C215)
				
				OBJECT SET ENABLED:C1123(f2;False:C215)
				
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
		End case 
		
		Case of 
			: (f1=1)
				viACT_cuentas:=viACT_cuentas1
			: (f2=1)
				viACT_cuentas:=viACT_cuentas2
			: (f3=1)
				viACT_cuentas:=viACT_cuentas3
		End case 
		vsACT_AsignedMatrix2:=""
		
		OBJECT SET ENTERABLE:C238(vHrs;False:C215)
		OBJECT SET ENTERABLE:C238(vMinutes;False:C215)
		OBJECT SET ENTERABLE:C238(vt_Fecha;False:C215)
		
		bc_SetProgTask:=0
		
		IT_SetButtonStateObject (False:C215;->bCalendar1;->bUpHrs;->bDownHrs;->bUpMinutes;->bDownMinutes)
		
		vHrs:=TM_Get_Hours (Current time:C178(*))
		vMinutes:=TM_Get_Minutes (Current time:C178(*))
		vt_Fecha:=String:C10(Current date:C33(*);7)
		vdDate:=Current date:C33(*)
		
		If (Application type:C494#4D Remote mode:K5:5)
			OBJECT SET VISIBLE:C603(*;"server@";False:C215)
			bc_ExecuteOnServer:=0
		Else 
			OBJECT SET VISIBLE:C603(*;"server@";(b3#1))
			bc_ExecuteOnServer:=Num:C11((b3#1))
		End if 
		
		  //lista con monedas
		ACTcfgmyt_OpcionesGenerales ("CargaListBoxEmision")
		C_TEXT:C284($vt_pref)
		$vt_pref:="0"
		cbMontosEnMonedaPago:=Num:C11(PREF_fGet (0;"ACTcfg_EmitirEnMontosFijos";$vt_pref))
		$vt_pref:=String:C10(cbMontosEnMonedaPago)
		ACTcfgmyt_OpcionesGenerales ("SetEstadoObjetosMontosFijos";->$vt_pref)
		
		If (cbVctoSegunConf=1)
			cbUltimoDiaMes:=0
		End if 
		OBJECT SET ENABLED:C1123(*;"cbUltimoDiaMes";cbVctoSegunConf=0)
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		If (cbVctoSegunConf=1)
			cbUltimoDiaMes:=0
		End if 
		OBJECT SET ENABLED:C1123(*;"NoConf0@";(cbVctoSegunConf=0))
		OBJECT SET ENTERABLE:C238(l_diasEmision;(cbVctoSegunConf=0))
		
		OBJECT SET ENTERABLE:C238(vdACT_DiaAviso;(cbVctoSegunConf=0))
		OBJECT SET ENTERABLE:C238(vdACT_DiaVctoAviso;False:C215)
		
		
	: (Form event:C388=On Unload:K2:2)
		
	: ((vi_PageNumber=5) & (viACT_cuentas=0))
		OBJECT SET ENABLED:C1123(bNext;False:C215)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (xALP_Divisas)
		
End case 