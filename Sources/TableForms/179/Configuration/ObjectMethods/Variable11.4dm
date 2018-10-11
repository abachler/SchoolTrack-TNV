ACTdesc_OpcionesVariables ("DeclaraVars")

Case of 
	: (alProEvt=-1)
		AL_GetSort (xALP_Items;$col)
		$lastID:=[xxACT_Items:179]ID:1
		ACTcfg_SaveItemdeCargo 
		AL_SetSort (xALP_Items;$col)
		vi_lastLine:=Find in array:C230(alACT_idItem;$lastID)
		AL_SetLine (xALP_Items;vi_lastLine)
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=alACT_IdItem{vi_lastLine})
		BLOB_Blob2Vars (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
		BLOB_Blob2Vars (->[xxACT_Items:179]Descuentos_Ingreso:16;0;->vr_Tramo1;->vr_Tramo2;->vr_Tramo3;->vr_Tramo4;->vr_Tramo5;->vr_Tramo6;->vr_Tramo7;->vr_Tramo8;->vr_Tramo9;->vr_Tramo10;->vr_Tramo11;->vr_Tramo12;->vr_Tramo13;->vr_Tramo14;->vr_Tramo15;->vr_Tramo16)
		BLOB_Blob2Vars (->[xxACT_Items:179]Descuento_Familia:32;0;->vr_Familia2;->vr_Familia3;->vr_Familia4;->vr_Familia5;->vr_Familia6;->vr_Familia7;->vr_Familia8;->vr_Familia9;->vr_Familia10;->vr_Familia11;->vr_Familia12;->vr_Familia13;->vr_Familia14;->vr_Familia15;->vr_Familia16;->vr_Familia17)
		ARRAY REAL:C219(arACT_DesctoPorHijo;0)
		ARRAY REAL:C219(arACT_DesctoTramo;0)
		ARRAY REAL:C219(arACT_DesctoPorFamilia;0)
		ARRAY REAL:C219(arACT_DesctoPorFamilia;16)
		ARRAY REAL:C219(arACT_DesctoPorHijo;16)
		ARRAY REAL:C219(arACT_DesctoTramo;16)
		For ($i;1;16)
			$hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
			$tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
			$familia:=Get pointer:C304("vr_Familia"+String:C10($i+1))
			arACT_DesctoPorHijo{$i}:=$hijo->
			arACT_DesctoTramo{$i}:=$tramo->
			arACT_DesctoPorFamilia{$i}:=$familia->
		End for 
		ACTcfg_OpcionesRazonesSociales ("ActualizaNombreRazon")
		AL_UpdateArrays (xALP_DesctosHijos;-2)
		AL_UpdateArrays (xALP_DesctosTramos;-2)
		AL_UpdateArrays (xALP_DesctosFamilia;-2)
	: ((alProEvt=1) | (alProEvt=2))
		$line:=AL_GetLine (xALP_Items)
		ACTcfg_SaveItemdeCargo 
		If ($line>0)
			vModificaCPCCS:=False:C215
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=alACT_IdItem{$line})
			BLOB_Blob2Vars (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
			BLOB_Blob2Vars (->[xxACT_Items:179]Descuentos_Ingreso:16;0;->vr_Tramo1;->vr_Tramo2;->vr_Tramo3;->vr_Tramo4;->vr_Tramo5;->vr_Tramo6;->vr_Tramo7;->vr_Tramo8;->vr_Tramo9;->vr_Tramo10;->vr_Tramo11;->vr_Tramo12;->vr_Tramo13;->vr_Tramo14;->vr_Tramo15;->vr_Tramo16)
			BLOB_Blob2Vars (->[xxACT_Items:179]Descuento_Familia:32;0;->vr_Familia2;->vr_Familia3;->vr_Familia4;->vr_Familia5;->vr_Familia6;->vr_Familia7;->vr_Familia8;->vr_Familia9;->vr_Familia10;->vr_Familia11;->vr_Familia12;->vr_Familia13;->vr_Familia14;->vr_Familia15;->vr_Familia16;->vr_Familia17)
			ARRAY REAL:C219(arACT_DesctoPorHijo;0)
			ARRAY REAL:C219(arACT_DesctoTramo;0)
			ARRAY REAL:C219(arACT_DesctoPorFamilia;0)
			ARRAY REAL:C219(arACT_DesctoPorFamilia;16)
			ARRAY REAL:C219(arACT_DesctoPorHijo;16)
			ARRAY REAL:C219(arACT_DesctoTramo;16)
			For ($i;1;16)
				$hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
				$tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
				$familia:=Get pointer:C304("vr_Familia"+String:C10($i+1))
				arACT_DesctoPorHijo{$i}:=$hijo->
				arACT_DesctoTramo{$i}:=$tramo->
				arACT_DesctoPorFamilia{$i}:=$familia->
			End for 
			ACTcfg_OpcionesRazonesSociales ("ActualizaNombreRazon")
			AL_UpdateArrays (xALP_DesctosHijos;-2)
			AL_UpdateArrays (xALP_DesctosTramos;-2)
			AL_UpdateArrays (xALP_DesctosFamilia;-2)
			vi_lastLine:=$line
		End if 
		AL_UpdateArrays (xALP_Items;-2)
		AL_SetLine (xALP_Items;$line)
		ACTcfg_OpcionesItems ("ColoreaMeses")
		SET QUERY LIMIT:C395(1)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=[xxACT_Items:179]ID:1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		SET QUERY LIMIT:C395(0)
		If (Records in selection:C76([ACT_Cargos:173])=0)
			IT_SetButtonState (True:C214;->j1)
			IT_SetButtonState ((Not:C34([xxACT_Items:179]EsRelativo:5)) & (Not:C34([xxACT_Items:179]EsDescuento:6));->j2)
		Else 
			IT_SetButtonState (False:C215;->j1;->j2)
		End if 
		j1:=Num:C11(Not:C34(([xxACT_Items:179]VentaRapida:3)))
		j2:=Num:C11(([xxACT_Items:179]VentaRapida:3))
		OBJECT SET VISIBLE:C603(bDisableMeses;(j2=1))
		IT_SetEnterable (True:C214;0;->[xxACT_Items:179]EsRelativo:5;->[xxACT_Items:179]EsDescuento:6;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]Item_Global:13)
		If (j2=1)
			IT_SetEnterable (False:C215;0;->[xxACT_Items:179]EsRelativo:5;->[xxACT_Items:179]EsDescuento:6;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]Item_Global:13)
			ACTcfg_Habilitatramoshijos (False:C215;False:C215;False:C215)
			OBJECT SET ENTERABLE:C238([xxACT_Items:179]TasaInteresMensual:25;False:C215)
			OBJECT SET ENTERABLE:C238([xxACT_Items:179]AfectoInteres:26;False:C215)
			For ($i;1;12)
				OBJECT SET COLOR:C271(*;"mes"+String:C10($i);-3)
			End for 
		Else 
			ACTcfg_HabilitaOpcionesItem (False:C215)
		End if 
		
		  //recargos automaticos
		ACTcfg_OpcionesRecAutTabla ("CargaVarsConfiguracion")
		
		REDRAW WINDOW:C456
		vtACT_CPCCS:=[xxACT_Items:179]No_de_Cuenta_Contable:15
		vtACT_CCCCS:=[xxACT_Items:179]Centro_de_Costos:21
		vtACT_CCPCCS:=[xxACT_Items:179]No_CCta_contable:22
		vtACT_CCCCCS:=[xxACT_Items:179]CCentro_de_costos:23
		
	: (alProEvt=5)
		
		  //***** SELECCIONA LINEA ****
		$line:=AL_GetLine (xALP_Items)
		ACTcfg_SaveItemdeCargo 
		If ($line>0)
			vModificaCPCCS:=False:C215
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=alACT_IdItem{$line})
			BLOB_Blob2Vars (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
			BLOB_Blob2Vars (->[xxACT_Items:179]Descuentos_Ingreso:16;0;->vr_Tramo1;->vr_Tramo2;->vr_Tramo3;->vr_Tramo4;->vr_Tramo5;->vr_Tramo6;->vr_Tramo7;->vr_Tramo8;->vr_Tramo9;->vr_Tramo10;->vr_Tramo11;->vr_Tramo12;->vr_Tramo13;->vr_Tramo14;->vr_Tramo15;->vr_Tramo16)
			BLOB_Blob2Vars (->[xxACT_Items:179]Descuento_Familia:32;0;->vr_Familia2;->vr_Familia3;->vr_Familia4;->vr_Familia5;->vr_Familia6;->vr_Familia7;->vr_Familia8;->vr_Familia9;->vr_Familia10;->vr_Familia11;->vr_Familia12;->vr_Familia13;->vr_Familia14;->vr_Familia15;->vr_Familia16;->vr_Familia17)
			ARRAY REAL:C219(arACT_DesctoPorHijo;0)
			ARRAY REAL:C219(arACT_DesctoTramo;0)
			ARRAY REAL:C219(arACT_DesctoPorFamilia;0)
			ARRAY REAL:C219(arACT_DesctoPorFamilia;16)
			ARRAY REAL:C219(arACT_DesctoPorHijo;16)
			ARRAY REAL:C219(arACT_DesctoTramo;16)
			For ($i;1;16)
				$hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
				$tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
				$familia:=Get pointer:C304("vr_Familia"+String:C10($i+1))
				arACT_DesctoPorHijo{$i}:=$hijo->
				arACT_DesctoTramo{$i}:=$tramo->
				arACT_DesctoPorFamilia{$i}:=$familia->
			End for 
			ACTcfg_OpcionesRazonesSociales ("ActualizaNombreRazon")
			AL_UpdateArrays (xALP_DesctosHijos;-2)
			AL_UpdateArrays (xALP_DesctosTramos;-2)
			AL_UpdateArrays (xALP_DesctosFamilia;-2)
			vi_lastLine:=$line
		End if 
		AL_UpdateArrays (xALP_Items;-2)
		AL_SetLine (xALP_Items;$line)
		ACTcfg_OpcionesItems ("ColoreaMeses")
		SET QUERY LIMIT:C395(1)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=[xxACT_Items:179]ID:1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		SET QUERY LIMIT:C395(0)
		If (Records in selection:C76([ACT_Cargos:173])=0)
			IT_SetButtonState (True:C214;->j1)
			IT_SetButtonState ((Not:C34([xxACT_Items:179]EsRelativo:5)) & (Not:C34([xxACT_Items:179]EsDescuento:6));->j2)
		Else 
			IT_SetButtonState (False:C215;->j1;->j2)
		End if 
		j1:=Num:C11(Not:C34(([xxACT_Items:179]VentaRapida:3)))
		j2:=Num:C11(([xxACT_Items:179]VentaRapida:3))
		OBJECT SET VISIBLE:C603(bDisableMeses;(j2=1))
		IT_SetEnterable (True:C214;0;->[xxACT_Items:179]EsRelativo:5;->[xxACT_Items:179]EsDescuento:6;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]Item_Global:13)
		If (j2=1)
			IT_SetEnterable (False:C215;0;->[xxACT_Items:179]EsRelativo:5;->[xxACT_Items:179]EsDescuento:6;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]Item_Global:13)
			ACTcfg_Habilitatramoshijos (False:C215;False:C215;False:C215)
			OBJECT SET ENTERABLE:C238([xxACT_Items:179]TasaInteresMensual:25;False:C215)
			OBJECT SET ENTERABLE:C238([xxACT_Items:179]AfectoInteres:26;False:C215)
			For ($i;1;12)
				OBJECT SET COLOR:C271(*;"mes"+String:C10($i);-3)
			End for 
		Else 
			ACTcfg_HabilitaOpcionesItem (False:C215)
		End if 
		
		REDRAW WINDOW:C456
		vtACT_CPCCS:=[xxACT_Items:179]No_de_Cuenta_Contable:15
		vtACT_CCCCS:=[xxACT_Items:179]Centro_de_Costos:21
		vtACT_CCPCCS:=[xxACT_Items:179]No_CCta_contable:22
		vtACT_CCCCCS:=[xxACT_Items:179]CCentro_de_costos:23
		
		  //***** SELECCIONA NUEVA LINEA ****
		
		  //***** MUESTRA MENU ****
		
		C_TEXT:C284($t_periodo)
		$t_periodo:=ACTitems_BuscaAñoEnCargos ([xxACT_Items:179]ID:1)
		Case of 
			: ($t_periodo="-1")  //nuevo año
				ACTitems_CreaNuevoPeriodo 
				
			: ($t_periodo#"")
				[xxACT_Items:179]Periodo:42:=$t_periodo
				
				AL_UpdateArrays (xALP_Items;0)
				$l_idItem:=[xxACT_Items:179]ID:1
				PREF_Set (0;"ACT_pref_filtroItems";[xxACT_Items:179]Periodo:42)
				ACTitems_FiltroPeriodo ("CreaLista")
				AL_UpdateArrays (xALP_Items;-2)
				ACTitems_SeleccionaLinea ($l_idItem)
				
		End case 
		  //***** MUESTRA MENU ****
		
End case 
  //20160223 RCH
  //OBJECT SET ENABLED(*;"Codigo_interno";[xxACT_Items]VentaRapida)
OBJECT SET ENABLED:C1123(*;"Codigo_interno";(([xxACT_Items:179]VentaRapida:3) | (<>gCountryCode="mx")))  //20170920 RCH Ticket 188464
ACTcfgcar_SetObjects ("SetPrivilegios")