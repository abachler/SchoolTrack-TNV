//%attributes = {}
  //ACTitems_LeeCentrosCostoXNivel
  // Modificado por: Saúl Ponce (30-11-2016)
  // Agregué el segundo parámetro para recibir el campo que se necesita leer ([xxACT_Items]xCentro_Costo / [xxACT_Items]ContaMonedaPagoPais)

C_LONGINT:C283($l_idItem;$1)
C_BLOB:C604($xBlob)
C_LONGINT:C283($l_nivel)
ARRAY LONGINT:C221($alACT_idNivel;0)
ARRAY TEXT:C222($atACT_Nivel;0)
C_BOOLEAN:C305(vbACTcfg_EnItemsEsp)

$l_idItem:=$1

If (Count parameters:C259=2)
	$vy_puntero:=$2
Else 
	  // Modificado por: Saúl Ponce (23-02-2017) - Ticket 175336
	  // Añadí este ELSE para que cuando no venga indicado el campo requerido, trabaje por omisión con [xxACT_Items]xCentro_Costo
	$vy_puntero:=->[xxACT_Items:179]xCentro_Costo:41
End if 


ACTcfg_DeclaraArreglos ("ACTcfgitems_CentroCostoXNivel")

If ($l_idItem#0)
	If (vbACTcfg_EnItemsEsp)
		$xBlob:=vx_CentroCostoXNivel
	Else 
		  //$xBlob:=KRL_GetBlobFieldData (->[xxACT_Items]ID;->$l_idItem;->[xxACT_Items]xCentro_Costo)
		$xBlob:=KRL_GetBlobFieldData (->[xxACT_Items:179]ID:1;->$l_idItem;$vy_puntero)
	End if 
	If (BLOB size:C605($xBlob)=0)
		  //BLOB_Variables2Blob (->$xBlob;0;->abACT_CCXN_UsarConfItem;->atACT_CCXN_Nivel;->atACT_CCXN_CentroCosto;->atACT_CCXN_CentroCostoContra;->alACT_CCXN_NivelID)
		BLOB_Variables2Blob (->$xBlob;0;->abACT_CCXN_UsarConfItem;->atACT_CCXN_Nivel;->atACT_CCXN_CentroCosto;->atACT_CCXN_CentroCostoContra;->alACT_CCXN_NivelID;->atACT_CCXN_CodAux;->atACT_CCXN_CodPlanCtas;->atACT_CCXN_CodAuxCC;->atACT_CCXN_CodPlanCCtas)
	Else 
		  //BLOB_Blob2Vars (->$xBlob;0;->abACT_CCXN_UsarConfItem;->atACT_CCXN_Nivel;->atACT_CCXN_CentroCosto;->atACT_CCXN_CentroCostoContra;->alACT_CCXN_NivelID)
		BLOB_Blob2Vars (->$xBlob;0;->abACT_CCXN_UsarConfItem;->atACT_CCXN_Nivel;->atACT_CCXN_CentroCosto;->atACT_CCXN_CentroCostoContra;->alACT_CCXN_NivelID;->atACT_CCXN_CodAux;->atACT_CCXN_CodPlanCtas;->atACT_CCXN_CodAuxCC;->atACT_CCXN_CodPlanCCtas)
	End if 
	
	READ ONLY:C145([xxSTR_Niveles:6])
	
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214;*)
	QUERY:C277([xxSTR_Niveles:6]; | ;[xxSTR_Niveles:6]EsNivelSistema:10=True:C214)
	
	SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$alACT_idNivel;[xxSTR_Niveles:6]Nivel:1;$atACT_Nivel)
	
	  //si no esta en el arreglo, lo agrego
	For ($l_nivel;1;Size of array:C274($alACT_idNivel))
		$l_noNivel:=Find in array:C230(alACT_CCXN_NivelID;$alACT_idNivel{$l_nivel})
		If ($l_noNivel=-1)
			APPEND TO ARRAY:C911(abACT_CCXN_UsarConfItem;True:C214)
			APPEND TO ARRAY:C911(atACT_CCXN_Nivel;$atACT_Nivel{$l_nivel})
			If (vbACTcfg_EnItemsEsp)
				APPEND TO ARRAY:C911(atACT_CCXN_CentroCosto;vsACT_CentroInteresesIE)
				APPEND TO ARRAY:C911(atACT_CCXN_CentroCostoContra;vsACT_CCentroInteresesIE)
				
				  // Modificado por: Saúl Ponce (09-12-2016)
				  // Agregué estos 4 arrays para manejar las columnas de cuentas, contra ceuntas, cod uxiliares y contra cod auxiliares en la interfaz
				APPEND TO ARRAY:C911(atACT_CCXN_CodAux;vsACT_codInteresesIE)
				APPEND TO ARRAY:C911(atACT_CCXN_CodPlanCtas;vsACT_CtaInteresesIE)
				APPEND TO ARRAY:C911(atACT_CCXN_CodAuxCC;vsACT_CCodInteresesIE)
				APPEND TO ARRAY:C911(atACT_CCXN_CodPlanCCtas;vsACT_CCentroInteresesIE)
			Else 
				APPEND TO ARRAY:C911(atACT_CCXN_CentroCosto;[xxACT_Items:179]Centro_de_Costos:21)
				APPEND TO ARRAY:C911(atACT_CCXN_CentroCostoContra;[xxACT_Items:179]CCentro_de_costos:23)
				
				  // Modificado por: Saúl Ponce (09-12-2016)
				  // Agregué estos 4 arrays para manejar las columnas de cuentas, contra cuentas, cod auxiliares y contra cod auxiliares en la interfaz
				APPEND TO ARRAY:C911(atACT_CCXN_CodAux;[xxACT_Items:179]CodAuxCta:27)
				APPEND TO ARRAY:C911(atACT_CCXN_CodAuxCC;[xxACT_Items:179]CodAuxCCta:28)
				APPEND TO ARRAY:C911(atACT_CCXN_CodPlanCtas;[xxACT_Items:179]No_de_Cuenta_Contable:15)
				APPEND TO ARRAY:C911(atACT_CCXN_CodPlanCCtas;[xxACT_Items:179]No_CCta_contable:22)
			End if 
			APPEND TO ARRAY:C911(alACT_CCXN_NivelID;$alACT_idNivel{$l_nivel})
		End if 
	End for 
	
	  //si esta guardado pero el nivel no esta
	For ($l_nivel;Size of array:C274(alACT_CCXN_NivelID);1;-1)
		$l_noNivel:=Find in array:C230($alACT_idNivel;alACT_CCXN_NivelID{$l_nivel})
		If ($l_noNivel=-1)
			  // Modificado por: Saúl Ponce (09-12-2016)
			  // AT_Delete ($l_nivel;1;->abACT_CCXN_UsarConfItem;->atACT_CCXN_Nivel;->atACT_CCXN_CentroCosto;->atACT_CCXN_CentroCostoContra;->alACT_CCXN_NivelID)
			AT_Delete ($l_nivel;1;->abACT_CCXN_UsarConfItem;->atACT_CCXN_Nivel;->atACT_CCXN_CentroCosto;->atACT_CCXN_CentroCostoContra;->alACT_CCXN_NivelID;->atACT_CCXN_CodAux;->atACT_CCXN_CodPlanCtas;->atACT_CCXN_CodAuxCC;->atACT_CCXN_CodPlanCCtas)
		End if 
	End for 
	  // Modificado por: Saúl Ponce (09-12-2016)
	  //SORT ARRAY(alACT_CCXN_NivelID;atACT_CCXN_Nivel;abACT_CCXN_UsarConfItem;atACT_CCXN_CentroCosto;atACT_CCXN_CentroCostoContra;>)
	SORT ARRAY:C229(alACT_CCXN_NivelID;atACT_CCXN_Nivel;abACT_CCXN_UsarConfItem;atACT_CCXN_CentroCosto;atACT_CCXN_CentroCostoContra;atACT_CCXN_CodAux;atACT_CCXN_CodPlanCtas;atACT_CCXN_CodAuxCC;atACT_CCXN_CodPlanCCtas;>)
	
End if 