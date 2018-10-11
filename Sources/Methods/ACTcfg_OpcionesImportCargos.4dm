//%attributes = {}
  // Método: ACTcfg_OpcionesImportCargos
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 21-07-10, 14:53:01
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




  //ACTcfg_OpcionesImportCargos

C_TEXT:C284($1;$vt_accion)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1)
$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="DeclaraArreglosCopia")
		ARRAY PICTURE:C279(ap_item2ImportC2;0)
		ARRAY TEXT:C222(at_glosasItemsC2;0)
		ARRAY LONGINT:C221(al_idItemsC2;0)
		ARRAY BOOLEAN:C223(ab_Item2ImportC2;0)
		ARRAY LONGINT:C221(alACT_idsRSOrgC2;0)
		
	: ($vt_accion="DeclaraArreglosReferencias")
		ARRAY LONGINT:C221(al_idItems;0)
		ARRAY TEXT:C222(at_glosasItems;0)
		ARRAY LONGINT:C221(alACT_idsRSOrg;0)
		ARRAY BOOLEAN:C223(ab_Item2Import;0)
		ARRAY PICTURE:C279(ap_item2Import;0)
		
	: ($vt_accion="DeclaraArreglosCargos")
		ARRAY LONGINT:C221(al_rnCargosT;0)
		ARRAY LONGINT:C221(al_refItemsT;0)
		ARRAY LONGINT:C221(al_mesCargosT;0)
		ARRAY LONGINT:C221(alACT_idsRST;0)
		ARRAY TEXT:C222(at_glosasItems2;0)
		
	: ($vt_accion="DeclaraArreglosEliminados")
		ARRAY LONGINT:C221(al_itemsEliminados;0)
		ARRAY LONGINT:C221(al_mesesItemsEliminados;0)
		ARRAY TEXT:C222(at_glosasItemsEliminados;0)
		ARRAY LONGINT:C221(alACT_idsRSTEliminados;0)
		
	: ($vt_accion="CopiaArreglosCopia")
		COPY ARRAY:C226(ap_item2Import;ap_item2ImportC2)
		COPY ARRAY:C226(at_glosasItems;at_glosasItemsC2)
		COPY ARRAY:C226(al_idItems;al_idItemsC2)
		COPY ARRAY:C226(ab_Item2Import;ab_Item2ImportC2)
		COPY ARRAY:C226(alACT_idsRSOrg;alACT_idsRSOrgC2)
		
	: ($vt_accion="RetornaArreglosCopia")
		COPY ARRAY:C226(ap_item2ImportC2;ap_item2Import)
		COPY ARRAY:C226(at_glosasItemsC2;at_glosasItems)
		COPY ARRAY:C226(al_idItemsC2;al_idItems)
		COPY ARRAY:C226(ab_Item2ImportC2;ab_Item2Import)
		COPY ARRAY:C226(alACT_idsRSOrgC2;alACT_idsRSOrg)
		
	: ($vt_accion="EliminaItemRef")
		$idItemEliminado:=al_idItems{$ptr1->}
		ab_Item2Import{$ptr1->}:=False:C215
		al_refItemsT{0}:=$idItemEliminado
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->al_refItemsT;"=";->$DA_Return)
		AT_Insert (1;Size of array:C274($DA_Return);->al_itemsEliminados;->al_mesesItemsEliminados;->at_glosasItemsEliminados;->alACT_idsRSTEliminados)
		For ($i;1;Size of array:C274($DA_Return))
			at_glosasItemsEliminados{$i}:=at_glosasItems2{$DA_Return{$i}}
			al_mesesItemsEliminados{$i}:=al_mesCargosT{$DA_Return{$i}}
			al_itemsEliminados{$i}:=al_refItemsT{$DA_Return{$i}}
			alACT_idsRSTEliminados{$i}:=alACT_idsRST{$DA_Return{$i}}
		End for 
		
		For ($i;Size of array:C274($DA_Return);1;-1)
			AT_Delete ($DA_Return{$i};1;->at_glosasItems2;->al_mesCargosT;->al_refItemsT;->alACT_idsRST)
		End for 
		ACTat_LLenaArregloPict (->ab_Item2Import;->ap_item2Import)
		
	: ($vt_accion="RecuperaItemRef")
		ab_Item2Import{$ptr1->}:=True:C214
		$idItemEliminado:=al_idItems{$ptr1->}
		al_itemsEliminados{0}:=$idItemEliminado
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->al_itemsEliminados;"=";->$DA_Return)
		AT_Insert (1;Size of array:C274($DA_Return);->at_glosasItems2;->al_mesCargosT;->al_refItemsT;->alACT_idsRST)
		  //AT_Insert (1;Size of array(DA_Return);->al_itemsEliminados;->al_mesesItemsEliminados;->at_glosasItemsEliminados)
		For ($i;Size of array:C274($DA_Return);1;-1)
			at_glosasItems2{$i}:=at_glosasItemsEliminados{$DA_Return{$i}}
			al_mesCargosT{$i}:=al_mesesItemsEliminados{$DA_Return{$i}}
			al_refItemsT{$i}:=al_itemsEliminados{$DA_Return{$i}}
			alACT_idsRST{$i}:=alACT_idsRSTEliminados{$DA_Return{$i}}
		End for 
		
		For ($i;Size of array:C274($DA_Return);1;-1)
			AT_Delete ($DA_Return{$i};1;->al_itemsEliminados;->al_mesesItemsEliminados;->at_glosasItemsEliminados;->alACT_idsRSTEliminados)
		End for 
		ACTat_LLenaArregloPict (->ab_Item2Import;->ap_item2Import)
		
	: ($vt_accion="SeleccionaXRS")
		$vl_idRazon:=alACTcfg_Razones{atACTcfg_Razones}
		If ($vl_idRazon#0)
			AL_UpdateArrays (ALP_CargosXPagar;0)
			AL_UpdateArrays (ALP_CargosXPagarO;0)
			
			ACTcfg_OpcionesImportCargos ("RetornaArreglosCopia")
			
			ARRAY LONGINT:C221($alACT_Posiciones;0)
			If ($vl_idRazon>0)
				alACT_idsRSOrg{0}:=$vl_idRazon
				AT_SearchArray (->alACT_idsRSOrg;"#";->$alACT_Posiciones)
			Else 
				alACT_idsRSOrg{0}:=0
				AT_SearchArray (->alACT_idsRSOrg;">";->$alACT_Posiciones)
			End if 
			For ($i;1;Size of array:C274($alACT_Posiciones))
				$vl_line:=$alACT_Posiciones{$i}
				ACTcfg_OpcionesImportCargos ("EliminaItemRef";->$vl_line)
			End for 
			If ($vl_idRazon>0)
				alACT_idsRSOrg{0}:=$vl_idRazon
				AT_SearchArray (->alACT_idsRSOrg;"=";->$alACT_Posiciones)
			Else 
				alACT_idsRSOrg{0}:=0
				AT_SearchArray (->alACT_idsRSOrg;"<=";->$alACT_Posiciones)
			End if 
			For ($i;1;Size of array:C274($alACT_Posiciones))
				$vl_line:=$alACT_Posiciones{$i}
				ACTcfg_OpcionesImportCargos ("RecuperaItemRef";->$vl_line)
			End for 
			
			AT_Initialize (->al_idItems;->at_glosasItems;->alACT_idsRSOrg;->ab_Item2Import;->ap_item2Import)
			For ($i;1;Size of array:C274($alACT_Posiciones))
				APPEND TO ARRAY:C911(ap_item2Import;ap_item2ImportC2{$alACT_Posiciones{$i}})
				APPEND TO ARRAY:C911(at_glosasItems;at_glosasItemsC2{$alACT_Posiciones{$i}})
				APPEND TO ARRAY:C911(al_idItems;al_idItemsC2{$alACT_Posiciones{$i}})
				APPEND TO ARRAY:C911(ab_Item2Import;ab_Item2ImportC2{$alACT_Posiciones{$i}})
				APPEND TO ARRAY:C911(alACT_idsRSOrg;alACT_idsRSOrgC2{$alACT_Posiciones{$i}})
			End for 
			
			AL_UpdateArrays (ALP_CargosXPagar;-2)
			AL_UpdateArrays (ALP_CargosXPagarO;-2)
		End if 
		
	: ($vt_accion="TodasXRS")
		AL_UpdateArrays (ALP_CargosXPagar;0)
		AL_UpdateArrays (ALP_CargosXPagarO;0)
		ACTcfg_OpcionesImportCargos ("RetornaArreglosCopia")
		For ($i;1;Size of array:C274(al_idItems))
			$vl_line:=$i
			ACTcfg_OpcionesImportCargos ("RecuperaItemRef";->$vl_line)
		End for 
		AL_UpdateArrays (ALP_CargosXPagar;-2)
		AL_UpdateArrays (ALP_CargosXPagarO;-2)
		
	: ($vt_accion="OrdenaCargos")
		If (consideraMesSC)
			ARRAY LONGINT:C221(al_refMeses;0)
			AT_Insert (1;12;->al_refMeses)
			For ($i;1;12)
				al_refMeses{$i}:=$i
			End for 
			AT_OrderArraysByArray (0;->al_idItems;->al_refItemsT;->al_mesCargosT;->at_glosasItems2;->alACT_idsRST)
			AT_OrderArraysByArray (0;->al_refMeses;->al_mesCargosT;->at_glosasItems2;->al_refItemsT;->alACT_idsRST)
		Else 
			AT_OrderArraysByArray (0;->al_idItems;->al_refItemsT;->al_mesCargosT;->at_glosasItems2;->alACT_idsRST)
		End if 
		
End case 
