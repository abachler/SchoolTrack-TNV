//%attributes = {}
  //UD_v20161128_ACT_ConfigCCXN
  //
  // ----------------------------------------------------
  // Usuario (SO): Saúl Ponce
  // Fecha y hora: 30-11-16, 12:11:16
  // ----------------------------------------------------
  // Método: UD_v20161128_ACT_ConfigCCXN
  //
  // Descripción: Para actualizar los centros de costos de cada item añadiendo al blob 4 nuevos arrays para codigo auxiliar, contra codigos auxiliar, 
  // plan de cuentas y contra plan de cuentas.
  //
  // Parámetros: No necesita.
  // ----------------------------------------------------



If (ACT_AccountTrackInicializado )
	READ ONLY:C145([xxACT_Items:179])
	QUERY BY FORMULA:C48([xxACT_Items:179];BLOB size:C605([xxACT_Items:179]xCentro_Costo:41)>0)
	
	If (Records in selection:C76([xxACT_Items:179])>0)
		C_LONGINT:C283($w)
		ARRAY LONGINT:C221($al_idItems;0)
		
		ACTcfg_DeclaraArreglos ("ACTcfgitems_CentroCostoXNivel")
		SELECTION TO ARRAY:C260([xxACT_Items:179];$al_idItems)
		For ($w;1;Size of array:C274($al_idItems))
			READ WRITE:C146([xxACT_Items:179])
			GOTO RECORD:C242([xxACT_Items:179];$al_idItems{$w})
			
			BLOB_Blob2Vars (->[xxACT_Items:179]xCentro_Costo:41;0;->abACT_CCXN_UsarConfItem;->atACT_CCXN_Nivel;->atACT_CCXN_CentroCosto;->atACT_CCXN_CentroCostoContra;->alACT_CCXN_NivelID)
			SET BLOB SIZE:C606([xxACT_Items:179]xCentro_Costo:41;0)
			
			  // Modificado por: Alexis Bustamante (12-05-2017)  Ticket 181188, 181093  los arrays no estaban sincronizados en tamaño.
			AT_RedimArrays (Size of array:C274(alACT_CCXN_NivelID);->atACT_CCXN_CodAux;->atACT_CCXN_CodPlanCtas;->atACT_CCXN_CodAuxCC;->atACT_CCXN_CodPlanCCtas)
			
			
			BLOB_Variables2Blob (->[xxACT_Items:179]xCentro_Costo:41;0;->abACT_CCXN_UsarConfItem;->atACT_CCXN_Nivel;->atACT_CCXN_CentroCosto;->atACT_CCXN_CentroCostoContra;->alACT_CCXN_NivelID;->atACT_CCXN_CodAux;->atACT_CCXN_CodPlanCtas;->atACT_CCXN_CodAuxCC;->atACT_CCXN_CodPlanCCtas)
			SAVE RECORD:C53([xxACT_Items:179])
		End for 
		
		KRL_UnloadReadOnly (->[xxACT_Items:179])
	End if 
End if 