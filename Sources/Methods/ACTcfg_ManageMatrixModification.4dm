//%attributes = {}
  //ACTcfg_ManageMatrixModification

$idMatrix:=$1
Case of 
	: ($2="borrar")
		$borrar:=True:C214
		$crear:=False:C215
	: ($2="crear")
		$borrar:=False:C215
		$crear:=True:C214
	: ($2="regenerar")
		$borrar:=False:C215
		$crear:=False:C215
End case 
$ask:=True:C214
$idItem:=alACT_IDItem{AL_GetLine (xALP_Items2)}
If (Count parameters:C259=3)
	$idItem:=$3
End if 
If (Count parameters:C259=4)
	$idItem:=$3
	$ask:=$4
End if 

If ($ask)
	$accion:=CD_Dlog (0;__ ("¿Está seguro de querer modificar esta matriz?");__ ("");__ ("Cancelar");__ ("Si"))
	If ($accion=2)
		$proc:=IT_UThermometer (1;0;__ ("Modificando matriz..."))
		If ($borrar)
			READ WRITE:C146([xxACT_ItemsMatriz:180])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Item:2=$idItem;*)
			QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Matriz:1=$idMatrix)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=[xxACT_ItemsMatriz:180]ID_Item:2;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Matriz:2=$idMatrix)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
			ACTcc_EliminaCargosLoop 
			READ ONLY:C145([ACT_Matrices:177])
			READ ONLY:C145([xxACT_Items:179])
			QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=$idMatrix)
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$idItem)
			LOG_RegisterEvt ("Modificación de matriz "+[ACT_Matrices:177]Nombre_matriz:2+". Eliminación de item "+[xxACT_Items:179]Glosa:2+".")
			UNLOAD RECORD:C212([ACT_Matrices:177])
			UNLOAD RECORD:C212([xxACT_Items:179])
			DELETE RECORD:C58([xxACT_ItemsMatriz:180])
			KRL_UnloadReadOnly (->[xxACT_ItemsMatriz:180])
			AL_UpdateArrays (xALP_ItemsMatriz;0)
		End if 
		
		If ($crear)
			CREATE RECORD:C68([xxACT_ItemsMatriz:180])
			[xxACT_ItemsMatriz:180]ID_Item:2:=$idItem
			[xxACT_ItemsMatriz:180]ID_Matriz:1:=$idMatrix
			SAVE RECORD:C53([xxACT_ItemsMatriz:180])
			UNLOAD RECORD:C212([xxACT_ItemsMatriz:180])
			READ ONLY:C145([ACT_Matrices:177])
			READ ONLY:C145([xxACT_Items:179])
			QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=$idMatrix)
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$idItem)
			LOG_RegisterEvt ("Modificación de matriz "+[ACT_Matrices:177]Nombre_matriz:2+". Se agrega item "+[xxACT_Items:179]Glosa:2+".")
			UNLOAD RECORD:C212([ACT_Matrices:177])
			UNLOAD RECORD:C212([xxACT_Items:179])
			AL_UpdateArrays (xALP_ItemsMatriz;0)
		End if 
		IT_UThermometer (-2;$proc)
	End if 
Else 
	$proc:=IT_UThermometer (1;0;__ ("Modificando matriz..."))
	If ($borrar)
		READ WRITE:C146([xxACT_ItemsMatriz:180])
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Item:2=$idItem;*)
		QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Matriz:1=$idMatrix)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=[xxACT_ItemsMatriz:180]ID_Item:2;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Matriz:2=$idMatrix)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
		ACTcc_EliminaCargosLoop 
		READ ONLY:C145([ACT_Matrices:177])
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=$idMatrix)
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$idItem)
		LOG_RegisterEvt ("Modificación de matriz "+[ACT_Matrices:177]Nombre_matriz:2+". Eliminación de item "+[xxACT_Items:179]Glosa:2+".")
		UNLOAD RECORD:C212([ACT_Matrices:177])
		UNLOAD RECORD:C212([xxACT_Items:179])
		DELETE RECORD:C58([xxACT_ItemsMatriz:180])
		KRL_UnloadReadOnly (->[xxACT_ItemsMatriz:180])
		AL_UpdateArrays (xALP_ItemsMatriz;0)
	End if 
	
	If ($crear)
		CREATE RECORD:C68([xxACT_ItemsMatriz:180])
		[xxACT_ItemsMatriz:180]ID_Item:2:=$idItem
		[xxACT_ItemsMatriz:180]ID_Matriz:1:=$idMatrix
		SAVE RECORD:C53([xxACT_ItemsMatriz:180])
		UNLOAD RECORD:C212([xxACT_ItemsMatriz:180])
		READ ONLY:C145([ACT_Matrices:177])
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=$idMatrix)
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$idItem)
		LOG_RegisterEvt ("Modificación de matriz "+[ACT_Matrices:177]Nombre_matriz:2+". Se agrega item "+[xxACT_Items:179]Glosa:2+".")
		UNLOAD RECORD:C212([ACT_Matrices:177])
		UNLOAD RECORD:C212([xxACT_Items:179])
		AL_UpdateArrays (xALP_ItemsMatriz;0)
	End if 
	IT_UThermometer (-2;$proc)
End if 
