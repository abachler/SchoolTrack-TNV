//%attributes = {}
  //ACTcar_AsignaCtasContables

C_POINTER:C301($2;$ptr1;$3;$ptr2;$4;$ptr3)
C_TEXT:C284($5;$vt_texto;$0;$vt_accion;$1)
C_TEXT:C284($vt_moneda)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$vt_texto:=$5
End if 


Case of 
	: ($vt_accion="declaraVars")
		C_TEXT:C284(vtMsg;vtDesc1;vtDesc2;vtBtn1;vtBtn2)
		_O_ARRAY STRING:C218(80;asNCta;0)
		_O_ARRAY STRING:C218(80;asCACta;0)
		
	: ($vt_accion="initVars")
		vtMsg:=""
		vtDesc1:=""
		vtDesc2:=""
		vtBtn1:=""
		vtBtn2:=""
		AT_Initialize (->asNCta;->asCACta)
		
	: ($vt_accion="asignaCtaACargos")
		C_LONGINT:C283($proc)
		C_POINTER:C301($field1;$field2)
		C_BOOLEAN:C305($b_centroCosto)
		ACTcar_AsignaCtasContables ("declaraVars")
		Case of 
			: (KRL_isSameField (->[xxACT_Items:179]No_de_Cuenta_Contable:15;$ptr2))
				$field1:=->[ACT_Cargos:173]No_de_Cuenta_contable:17
				$field2:=->[ACT_Cargos:173]CodAuxCta:43
				
			: (KRL_isSameField (->[xxACT_Items:179]No_CCta_contable:22;$ptr2))
				$field1:=->[ACT_Cargos:173]No_CCta_contable:39
				$field2:=->[ACT_Cargos:173]CodAuxCCta:44
				
			: (KRL_isSameField (->[xxACT_Items:179]Centro_de_Costos:21;$ptr2))
				$field1:=->[ACT_Cargos:173]Centro_de_costos:15
				$b_centroCosto:=True:C214
				
			: (KRL_isSameField (->[xxACT_Items:179]CCentro_de_costos:23;$ptr2))
				$field1:=->[ACT_Cargos:173]CCentro_de_costos:40
				$b_centroCosto:=True:C214
				
			: (KRL_isSameField (->[xxACT_Items:179]CodAuxCta:27;$ptr2))
				$field1:=->[ACT_Cargos:173]CodAuxCta:43
				
			: (KRL_isSameField (->[xxACT_Items:179]CodAuxCCta:28;$ptr2))
				$field1:=->[ACT_Cargos:173]CodAuxCCta:44
				
		End case 
		C_BLOB:C604($b_asignaCtaContable)
		$b_asignaCtaContable:=KRL_GetBlobFieldData (->[xxACT_Items:179]ID:1;$ptr1;->[xxACT_Items:179]xCentro_Costo:41)
		
		READ WRITE:C146([ACT_Cargos:173])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$ptr1->)
		$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en cargos..."))
		If ((BLOB size:C605($b_asignaCtaContable)=0) | (Not:C34($b_centroCosto)))
			_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Cargos:173]))
			AT_Populate (->asNCta;$ptr2)
			Case of 
				: (Count parameters:C259=3)
					ARRAY TO SELECTION:C261(asNCta;$field1->)
					
				: (Count parameters:C259=4)
					_O_ARRAY STRING:C218(80;asCACta;Records in selection:C76([ACT_Cargos:173]))
					AT_Populate (->asCACta;$ptr3)
					ARRAY TO SELECTION:C261(asNCta;$field1->;asCACta;$field2->)
					
			End case 
		Else 
			
			ARRAY LONGINT:C221($alACT_recNumsCargos;0)
			C_LONGINT:C283($l_lineaCargos)
			
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumsCargos;"")
			For ($l_lineaCargos;1;Size of array:C274($alACT_recNumsCargos))
				KRL_GotoRecord (->[ACT_Cargos:173];$alACT_recNumsCargos{$l_lineaCargos})
				  // Modificado por: Saúl Ponce (29-12-2016) - comentado para utilizar el nuevo parámetro del método
				  //[ACT_Cargos]Centro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CC")
				  //[ACT_Cargos]CCentro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CCC")
				
				$vt_moneda:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
				[ACT_Cargos:173]Centro_de_costos:15:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CC";$vt_moneda)
				[ACT_Cargos:173]CCentro_de_costos:40:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCC";$vt_moneda)
				
				SAVE RECORD:C53([ACT_Cargos:173])
			End for 
			
		End if 
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		REDUCE SELECTION:C351([ACT_Cargos:173];0)
		IT_UThermometer (-2;$proc)
		ACTcar_AsignaCtasContables ("initVars")
		
	: ($vt_accion="muestraDlog")
		vtMsg:="Usted modificó el código de plan de "+$ptr1->+" para este cargo."+"\r"+"Si lo desea puede aplicar el cambio a los cargos ya generados o bien sólo para lo"+"s cargos que se generen de ahora en adelante."
		vtDesc1:="El código de plan de "+$ptr1->+" es modificado, pero sólo será aplicado a los nuevos "+"cargos que se generen."
		vtDesc2:="Se asigna el cambio a los cargos ya generados."
		vtBtn1:="Sólo para los nuevos cargos"
		vtBtn2:="Aplicar también a los cargos ya generados"
		WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
		
	: ($vt_accion="asignaCta")
		ACTcar_AsignaCtasContables ("declaraVars")
		ARRAY POINTER:C280(<>aChoicePtrs;0)
		ARRAY POINTER:C280(<>aChoicePtrs;3)
		<>aChoicePtrs{1}:=-><>asACT_CuentaCta
		<>aChoicePtrs{2}:=-><>asACT_CodAuxCta
		<>aChoicePtrs{3}:=-><>asACT_GlosaCta
		TBL_ShowChoiceList (0;"Seleccione la Cuenta";1;$ptr2)
		If (ok=1)
			$ptr2->:=<>asACT_CuentaCta{choiceIdx}
			$ptr3->:=<>asACT_CodAuxCta{choiceIdx}
			ACTcar_AsignaCtasContables ("muestraDlog";->$vt_texto)
			If (ok=1)
				If (r2=1)
					ACTcar_AsignaCtasContables ("asignaCtaACargos";$ptr1;$ptr2;$ptr3)
				End if 
				ACTcar_AsignaCtasContables ("asignaNewValueVars";$ptr2)
				ACTcar_AsignaCtasContables ("asignaNewValueVars";$ptr3)
			Else 
				ACTcar_AsignaCtasContables ("retornaValueVars";$ptr2)
				ACTcar_AsignaCtasContables ("retornaValueVars";$ptr3)
			End if 
		End if 
		
	: ($vt_accion="asignaCentroCostos")
		ACTcar_AsignaCtasContables ("declaraVars")
		ARRAY POINTER:C280(<>aChoicePtrs;0)
		ARRAY POINTER:C280(<>aChoicePtrs;1)
		<>aChoicePtrs{1}:=-><>asACT_Centro
		TBL_ShowChoiceList (0;"Seleccione el Centro de Costos";1;$ptr2)
		If (ok=1)
			  //20130909 RCH
			$b_readOnlyState:=Read only state:C362([xxACT_Items:179])
			$l_idItem:=$ptr1->
			$ptr2->:=<>asACT_Centro{choiceIdx}
			ACTcar_AsignaCtasContables ("asignaCodACargo";$ptr1;$ptr2;$ptr3)
			
			SAVE RECORD:C53([xxACT_Items:179])  //20131015 RCH
			
			  //20130909 RCH
			$b_hecho:=ACTitems_AsignaCCostoXNivel ($l_idItem)
			If (Not:C34($b_hecho))
				BM_CreateRequest ("ACT_actualizaCCostoXNivel";String:C10($l_idItem);String:C10($l_idItem))
			End if 
			
			KRL_ResetPreviousRWMode (->[xxACT_Items:179];$b_readOnlyState)
			KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem)
			
		End if 
		
		
	: ($vt_accion="asignaCentroCostosVar")
		C_POINTER:C301($ptr)
		C_TEXT:C284($varName1)
		C_LONGINT:C283($tableNum1;$fieldNum1)
		RESOLVE POINTER:C394($ptr2;$varName1;$tableNum1;$fieldNum1)
		Case of 
			: ($varName1="vsACT_CentroInteresesIE")
				$ptr:=->[xxACT_Items:179]Centro_de_Costos:21
				
			: ($varName1="vsACT_CCentroInteresesIE")
				$ptr:=->[xxACT_Items:179]CCentro_de_costos:23
				
		End case 
		ACTcar_AsignaCtasContables ("asignaCentroCostos";$ptr1;$ptr;$ptr3)
		ACTcar_AsignaCtasContables ("asignaNewValueVarsVar";->$varName1)
		
	: ($vt_accion="asignaNewValueVars")
		Case of 
			: (KRL_isSameField (->[xxACT_Items:179]No_de_Cuenta_Contable:15;$ptr1))
				vtACT_CPCCS:=$ptr1->
				
			: (KRL_isSameField (->[xxACT_Items:179]No_CCta_contable:22;$ptr1))
				vtACT_CCPCCS:=$ptr1->
				
			: (KRL_isSameField (->[xxACT_Items:179]Centro_de_Costos:21;$ptr1))
				vtACT_CCCCS:=$ptr1->
				
			: (KRL_isSameField (->[xxACT_Items:179]CCentro_de_costos:23;$ptr1))
				vtACT_CCCCCS:=$ptr1->
				
			: (KRL_isSameField (->[xxACT_Items:179]CodAuxCta:27;$ptr1))
				vtACT_CAUXCC:=$ptr1->
				
			: (KRL_isSameField (->[xxACT_Items:179]CodAuxCCta:28;$ptr1))
				vtACT_CAUXCCC:=$ptr1->
				
		End case 
		
	: ($vt_accion="retornaValueVars")
		Case of 
			: (KRL_isSameField (->[xxACT_Items:179]No_de_Cuenta_Contable:15;$ptr1))
				$ptr1->:=vtACT_CPCCS
				
			: (KRL_isSameField (->[xxACT_Items:179]No_CCta_contable:22;$ptr1))
				$ptr1->:=vtACT_CCPCCS
				
			: (KRL_isSameField (->[xxACT_Items:179]Centro_de_Costos:21;$ptr1))
				$ptr1->:=vtACT_CCCCS
				
			: (KRL_isSameField (->[xxACT_Items:179]CCentro_de_costos:23;$ptr1))
				$ptr1->:=vtACT_CCCCCS
				
			: (KRL_isSameField (->[xxACT_Items:179]CodAuxCta:27;$ptr1))
				$ptr1->:=vtACT_CAUXCC
				
			: (KRL_isSameField (->[xxACT_Items:179]CodAuxCCta:28;$ptr1))
				$ptr1->:=vtACT_CAUXCCC
				
		End case 
		
	: ($vt_accion="asignaCodACargo")
		ACTcar_AsignaCtasContables ("declaraVars")
		ACTcar_AsignaCtasContables ("muestraDlog";$ptr3)
		If (ok=1)
			If (r2=1)
				ACTcar_AsignaCtasContables ("asignaCtaACargos";$ptr1;$ptr2)
			End if 
			ACTcar_AsignaCtasContables ("asignaNewValueVars";$ptr2)
		Else 
			ACTcar_AsignaCtasContables ("retornaValueVars";$ptr2)
		End if 
		
	: ($vt_accion="asignaCodACargoVar")
		C_POINTER:C301($ptr)
		C_TEXT:C284($varName1)
		C_LONGINT:C283($tableNum1;$fieldNum1)
		RESOLVE POINTER:C394($ptr2;$varName1;$tableNum1;$fieldNum1)
		Case of 
			: ($varName1="vsACT_CtaInteresesIE")
				[xxACT_Items:179]No_de_Cuenta_Contable:15:=vsACT_CtaInteresesIE
				$ptr:=->[xxACT_Items:179]No_de_Cuenta_Contable:15
				
			: ($varName1="vsACT_CodInteresesIE")
				[xxACT_Items:179]CodAuxCta:27:=vsACT_CodInteresesIE
				$ptr:=->[xxACT_Items:179]CodAuxCta:27
				
			: ($varName1="vsACT_CentroInteresesIE")
				[xxACT_Items:179]Centro_de_Costos:21:=vsACT_CentroInteresesIE
				$ptr:=->[xxACT_Items:179]Centro_de_Costos:21
				
			: ($varName1="vsACT_CCtaInteresesIE")
				[xxACT_Items:179]No_CCta_contable:22:=vsACT_CCtaInteresesIE
				$ptr:=->[xxACT_Items:179]No_CCta_contable:22
				
			: ($varName1="vsACT_CCodInteresesIE")
				[xxACT_Items:179]CodAuxCCta:28:=vsACT_CCodInteresesIE
				$ptr:=->[xxACT_Items:179]CodAuxCCta:28
				
			: ($varName1="vsACT_CCentroInteresesIE")
				[xxACT_Items:179]CCentro_de_costos:23:=vsACT_CCentroInteresesIE
				$ptr:=->[xxACT_Items:179]CCentro_de_costos:23
				
		End case 
		ACTcar_AsignaCtasContables ("asignaCodACargo";$ptr1;$ptr;$ptr3)
		ACTcar_AsignaCtasContables ("asignaNewValueVarsVar";->$varName1)
		
	: ($vt_accion="asignaCtaVar")
		C_POINTER:C301($ptr)
		C_POINTER:C301($ptr0)
		C_TEXT:C284($varName1;$varName2)
		C_LONGINT:C283($tableNum1;$fieldNum1)
		RESOLVE POINTER:C394($ptr2;$varName1;$tableNum1;$fieldNum1)
		Case of 
			: ($varName1="vsACT_CtaInteresesIE")
				$varName2:="vsACT_CodInteresesIE"
				$ptr:=->[xxACT_Items:179]No_de_Cuenta_Contable:15
				$ptr0:=->[xxACT_Items:179]CodAuxCta:27
				
			: ($varName1="vsACT_CCtaInteresesIE")
				$varName2:="vsACT_CCodInteresesIE"
				$ptr:=->[xxACT_Items:179]No_CCta_contable:22
				$ptr0:=->[xxACT_Items:179]CodAuxCCta:28
				
		End case 
		ACTcar_AsignaCtasContables ("asignaCta";$ptr1;$ptr;$ptr0;$ptr3->)
		ACTcar_AsignaCtasContables ("asignaNewValueVarsVar";->$varName1)
		ACTcar_AsignaCtasContables ("asignaNewValueVarsVar";->$varName2)
		
	: ($vt_accion="asignaNewValueVarsVar")
		Case of 
			: ($ptr1->="vsACT_CtaInteresesIE")
				vsACT_CtaInteresesIE:=vtACT_CPCCS
				
			: ($ptr1->="vsACT_CodInteresesIE")
				vsACT_CodInteresesIE:=vtACT_CAUXCC
				
			: ($ptr1->="vsACT_CentroInteresesIE")
				vsACT_CentroInteresesIE:=vtACT_CCCCS
				
			: ($ptr1->="vsACT_CCtaInteresesIE")
				vsACT_CCtaInteresesIE:=vtACT_CCPCCS
				
			: ($ptr1->="vsACT_CCodInteresesIE")
				vsACT_CCodInteresesIE:=vtACT_CAUXCCC
				
			: ($ptr1->="vsACT_CCentroInteresesIE")
				vsACT_CCentroInteresesIE:=vtACT_CCCCCS
				
		End case 
End case 