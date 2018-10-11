C_LONGINT:C283($selectedMonth;$selectedYear;$thisYear;$nextYear)
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		_O_DISABLE BUTTON:C193(bPrev)
		
		ACTinit_LoadPrefs 
		vd_currentDate:=Current date:C33(*)
		
		COPY ARRAY:C226(<>atACT_MAtrixName;atACT_MAtrixNameCopy3)
		_O_DISABLE BUTTON:C193(bMatrizaReemplazar)
		OBJECT SET COLOR:C271(*;"Reemplazo@";-61966)
		
		vt_Matrices:=AT_array2text (->atACT_MAtrixNameCopy3)
		
		
		  // defectos pagina 2
		b1:=0
		b2:=0
		b3:=0
		cbTodosb2:=0
		cbTodosb3:=0
		vsGlosab2:=""
		vsGlosab3:=""
		
		ARRAY TEXT:C222(atACT_CargosEspeciales;0)
		READ ONLY:C145([ACT_Cargos:173])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsRelativo:5=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]VentaRapida:3=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1>0)
		SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_ItemNames2Charge;[xxACT_Items:179]ID:1;alACT_ItemIds2Charge)
		SORT ARRAY:C229(atACT_ItemNames2Charge;alACT_ItemIds2Charge)
		If (Size of array:C274(atACT_ItemNames2Charge)>0)
			vsGlosab2:=atACT_ItemNames2Charge{1}
			viACT_IDItem:=alACT_ItemIds2Charge{1}
		Else 
			_O_DISABLE BUTTON:C193(b2)
		End if 
		vtACT_Items:=AT_array2text (->atACT_ItemNames2Charge)
		
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
				vdACT_AñoAviso:=$selectedYear
				vs1:=aMeses{$selectedMonth}
				vs2:=vs1
			: (($selectedMonth=0) & ($selectedYear#0))
				vdACT_AñoAviso:=$selectedYear
				vs1:=aMeses{1}
				vs2:=aMeses{12}
			: (($selectedMonth=0) & ($selectedYear=0))
				vdACT_AñoAviso:=$thisYear
				vs1:=aMeses{Month of:C24(Current date:C33(*))}
				vs2:=vs1
		End case 
		vdACT_AñoAviso2:=vdACT_AñoAviso
		aMeses:=Find in array:C230(aMeses;vs1)
		aMeses2:=Find in array:C230(aMeses2;vs2)
		Meses1:=AT_array2text (->aMeses)
		Meses2:=Meses1
		
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
		  //vsACT_AsignedMatrix2:=atACT_MatrixNameCopy3{1}
		vsACT_AsignedMatrix2:=""
		OBJECT SET COLOR:C271(viACT_cuentas4;-3)
		OBJECT SET COLOR:C271(viACT_cuentas5;-12)
		
		vi_PageNumber:=1
		vi_step:=1
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
	: (Form event:C388=On Unload:K2:2)
		vt_msg:=""
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
End case 