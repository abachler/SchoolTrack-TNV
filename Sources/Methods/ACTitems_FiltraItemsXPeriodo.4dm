//%attributes = {}
  //ACTitems_FiltraItemsXPeriodo

C_TEXT:C284($t_periodo;$t_periodoSeleccionado)
C_REAL:C285(l_periodosItems)
C_BOOLEAN:C305($b_creaLista)

READ ONLY:C145([xxACT_Items:179])

If (Count parameters:C259>=1)
	$b_creaLista:=$1
End if 
If (Count parameters:C259>=2)
	$t_periodoSeleccionado:=$2
End if 

Case of 
	: ($b_creaLista)
		ARRAY TEXT:C222($atACT_periodos;0)
		
		ARRAY TEXT:C222(atACT_ItemNames2Charge;0)
		ARRAY LONGINT:C221(alACT_ItemIds2Charge;0)
		ARRAY TEXT:C222(atACT_itemsPeriodo;0)
		
		ARRAY TEXT:C222(atACT_ItemNames2ChargeT;0)
		ARRAY LONGINT:C221(alACT_ItemIds2ChargeT;0)
		ARRAY TEXT:C222(atACT_itemsPeriodoT;0)
		
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsRelativo:5=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]VentaRapida:3=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1>0)
		If (Records in selection:C76([xxACT_Items:179])>0)
			SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_ItemNames2ChargeT;[xxACT_Items:179]ID:1;alACT_ItemIds2ChargeT;[xxACT_Items:179]Periodo:42;atACT_itemsPeriodoT)
			  //20140429 RCH Los ítems perdían sincronía...
			  //SORT ARRAY(atACT_itemsPeriodoT;atACT_ItemNames2ChargeT;alACT_ItemIds2ChargeT;<)
			SORT ARRAY:C229(atACT_ItemNames2ChargeT;atACT_itemsPeriodoT;alACT_ItemIds2ChargeT;>)
			
			COPY ARRAY:C226(atACT_itemsPeriodoT;$atACT_periodos)
			AT_DistinctsArrayValues (->$atACT_periodos)
			SORT ARRAY:C229($atACT_periodos;<)
			AT_Insert (1;1;->$atACT_periodos)
			$atACT_periodos{1}:=__ ("Todos")
		End if 
		l_periodosItems:=New list:C375
		For ($l_periodo;1;Size of array:C274($atACT_periodos))
			APPEND TO LIST:C376(l_periodosItems;$atACT_periodos{$l_periodo};$l_periodo)
		End for 
		
		$t_periodo:=PREF_fGet (0;"ACT_pref_filtroItems";"Todos")
		ACTitems_FiltraItemsXPeriodo (False:C215;$t_periodo)
		
	: ($t_periodoSeleccionado#"")
		  //C_LONGINT($page)
		  //C_TEXT($itemText)
		  //C_REAL($itemRef)
		  //GET LIST ITEM(al_FiltroYears;*;$itemRef;$itemText)
		  //
		  //If ($itemRef>0)
		  //PREF_Set (0;"ACT_pref_filtroItems";$itemText)
		  //
		  //AL_UpdateArrays (xALP_Items;0)
		  //ACTitems_CargaLista ($itemText)
		  //AL_UpdateArrays (xALP_Items;-2)
		  //
		  //ACTitems_CargaItemConf 
		  //End if 
		
		ARRAY TEXT:C222(atACT_ItemNames2Charge;0)
		ARRAY LONGINT:C221(alACT_ItemIds2Charge;0)
		ARRAY TEXT:C222(atACT_itemsPeriodo;0)
		
		If ($t_periodoSeleccionado=__ ("Todos"))
			COPY ARRAY:C226(atACT_ItemNames2ChargeT;atACT_ItemNames2Charge)
			COPY ARRAY:C226(alACT_ItemIds2ChargeT;alACT_ItemIds2Charge)
			COPY ARRAY:C226(atACT_itemsPeriodoT;atACT_itemsPeriodo)
		Else 
			ARRAY LONGINT:C221($al_posiciones;0)
			atACT_itemsPeriodoT{0}:=$t_periodoSeleccionado
			AT_SearchArray (->atACT_itemsPeriodoT;"=";->$al_posiciones)
			For ($l_indice;1;Size of array:C274($al_posiciones))
				APPEND TO ARRAY:C911(atACT_ItemNames2Charge;atACT_ItemNames2ChargeT{$al_posiciones{$l_indice}})
				APPEND TO ARRAY:C911(alACT_ItemIds2Charge;alACT_ItemIds2ChargeT{$al_posiciones{$l_indice}})
				APPEND TO ARRAY:C911(atACT_itemsPeriodo;atACT_itemsPeriodoT{$al_posiciones{$l_indice}})
			End for 
			  //20140423 RCH Dentro de IT_Clairvoyance se podia ordenar atACT_ItemNames2Charge y eso hacia perder la sincronia con el arreglo de ids.- Ahora se ordena siempre.
			SORT ARRAY:C229(atACT_ItemNames2Charge;alACT_ItemIds2Charge;atACT_itemsPeriodo;>)
		End if 
		
		vsACT_SelectedItemName:=""
		atACT_ItemNames2Charge:=0
		vlACT_selectedItemId:=0
		vsACT_MonedaDef:=""
		vrACT_MontoDef:=0
		vsACT_CtaContableDef:=""
		vsACT_CentroContableDef:=""
		vsACT_CCtaContableDef:=""
		vsACT_CCentroContableDef:=""
		vsACT_CodAuxCtaDef:=""
		vsACT_CodAuxCCtaDef:=""
		
		vsACT_Glosa:=""
		atACT_ItemNames2Charge:=0
		vlACT_selectedItemId:=0
		vsACT_Moneda:=""
		prevMoneda:=""
		vrACT_Monto:=0
		vsACT_CtaContable:=""
		vsACT_CentroContable:=""
		vsACT_CCtaContable:=""
		vsACT_CCentroContable:=""
		vsACT_CodAuxCta:=""
		vsACT_CodAuxCCta:=""
		
		vt_ItemNames:=AT_array2text (->atACT_ItemNames2Charge)
		
		$l_posicion:=Find in list:C952(l_periodosItems;$t_periodoSeleccionado;0)
		If ($l_posicion#0)
			SELECT LIST ITEMS BY POSITION:C381(l_periodosItems;$l_posicion)
		End if 
		
		If (Size of array:C274(atACT_ItemNames2Charge)>0)
			
			vsACT_SelectedItemName:=atACT_ItemNames2Charge{1}
			atACT_ItemNames2Charge:=1
			vlACT_selectedItemId:=alACT_ItemIds2Charge{1}
			
			vsACT_Glosa:=atACT_ItemNames2Charge{1}
			
			READ ONLY:C145([xxACT_Items:179])
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=vlACT_selectedItemId)
			vsACT_MonedaDef:=[xxACT_Items:179]Moneda:10
			vrACT_MontoDef:=[xxACT_Items:179]Monto:7
			vsACT_CtaContableDef:=[xxACT_Items:179]No_de_Cuenta_Contable:15
			vsACT_CentroContableDef:=[xxACT_Items:179]Centro_de_Costos:21
			vsACT_CCtaContableDef:=[xxACT_Items:179]No_CCta_contable:22
			vsACT_CCentroContableDef:=[xxACT_Items:179]CCentro_de_costos:23
			vsACT_CodAuxCtaDef:=[xxACT_Items:179]CodAuxCta:27
			vsACT_CodAuxCCtaDef:=[xxACT_Items:179]CodAuxCCta:28
			
			vsACT_Moneda:=[xxACT_Items:179]Moneda:10
			prevMoneda:=vsACT_Moneda
			vrACT_Monto:=[xxACT_Items:179]Monto:7
			vsACT_CtaContable:=[xxACT_Items:179]No_de_Cuenta_Contable:15
			vsACT_CentroContable:=[xxACT_Items:179]Centro_de_Costos:21
			vsACT_CCtaContable:=[xxACT_Items:179]No_CCta_contable:22
			vsACT_CCentroContable:=[xxACT_Items:179]CCentro_de_costos:23
			vsACT_CodAuxCta:=[xxACT_Items:179]CodAuxCta:27
			vsACT_CodAuxCCta:=[xxACT_Items:179]CodAuxCCta:28
			
		End if 
		
End case 