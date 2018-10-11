//%attributes = {}
  //ACTcfg_DeleteMatrix

$locked:=False:C215
ARRAY INTEGER:C220(abrSelectMatrices;0)
$err:=AL_GetSelect (xALP_Matrices;abrSelectMatrices)
If (Size of array:C274(abrSelectMatrices)=1)
	$line:=abrSelectMatrices{1}
Else 
	$line:=0
End if 

If ($line>0)
	READ WRITE:C146([ACT_Matrices:177])
	READ WRITE:C146([xxACT_ItemsMatriz:180])
	SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=alACT_IdMatriz{$line})  //Buscamos cuantas ctas ctes tienen asignada la matriz a eliminar
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($records=0)  //Si no hay ctas que tengan asignada la matriz...
		QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=alACT_IdMatriz{$line})
		  //$msg:=Replace string(RP_GetIdxString (21501;34);"^0";[ACT_Matrices]Nombre_matriz)
		$delete:=CD_Dlog (0;Replace string:C233(__ ("¿Está seguro de querer eliminar la matriz ^0?");__ ("^0");[ACT_Matrices:177]Nombre_matriz:2);__ ("");__ ("No");__ ("Si"))
		If ($delete=2)
			QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=[ACT_Matrices:177]ID:1)  //Buscamos la matriz y sus items
			DELETE SELECTION:C66([xxACT_ItemsMatriz:180])  //Borramos los items
			DELETE RECORD:C58([ACT_Matrices:177])  //Borramos la matriz
			LOG_RegisterEvt ("Eliminación de matriz "+[ACT_Matrices:177]Nombre_matriz:2+".")
		End if 
		READ ONLY:C145([ACT_Matrices:177])
		READ ONLY:C145([xxACT_ItemsMatriz:180])
	Else   //Si hay ctas con la matriz asignada preguntamos por cual cambiar (no podemos dejar cuentas sin matriz)
		COPY ARRAY:C226(<>atACT_MatrixName;atACT_Matrices)
		$MatrizaEliminar:=Find in array:C230(atACT_Matrices;atACT_NombreMatriz{$line})
		If ($MatrizaEliminar>0)
			atACT_Matrices{$MatrizaEliminar}:="("+atACT_Matrices{$MatrizaEliminar}
		End if 
		vt_MatrixMenu:=AT_array2text (->atACT_Matrices)
		cdT_Msg:=Replace string:C233(__ ("La matriz a eliminar está asignada a ^0 cuentas corrientes.\rPor favor seleccione otra matriz para reemplazarla.");"^0";String:C10($records))
		WDW_OpenDialogInDrawer (->[xxSTR_Constants:1];"ACT_RequestMatrix")
		CLOSE WINDOW:C154
		$cambioMatriz:=iResult
		cdT_Msg:=""
		AT_Initialize (->atACT_Matrices)  //Borramos este arreglo ya que no lo usamos mas
		If ($cambioMatriz=1)  //Si cambiamos la matriz
			START TRANSACTION:C239  //Iniciamos transaccion
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=alACT_IdMatriz{$line})  //Buscamos las ctas que tiene asignada la matriz a eliminar
			$NumCtas:=Records in selection:C76([ACT_CuentasCorrientes:175])
			CREATE SET:C116([ACT_CuentasCorrientes:175];"CtasAfectadas")  //Almacenamos la seleccion de ctas que usaban la matriz ¿es necesario?
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)  //Almacenamos los record numbers de las cuentas afectadas para regenerar cargos y documentos de cargo.
			ARRAY LONGINT:C221($al_IDNuevaMatriz;$NumCtas)
			For ($i;1;$NumCtas)  //Llenamos un array del porte de la seleccion cont el ID de la nueva matriz a asignar
				$al_IDNuevaMatriz{$i}:=vlACT_IDMatriz
			End for 
			READ WRITE:C146([ACT_CuentasCorrientes:175])
			ARRAY TO SELECTION:C261($al_IDNuevaMatriz;[ACT_CuentasCorrientes:175]ID_Matriz:7)  //Cambiamos la matriz utilizada por la nueva seleccionada en el dialogo
			UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			If (Records in set:C195("LockedSet")>0)  //Si encontramos ctas tomadas al momento de asignar la nueva matriz
				CANCEL TRANSACTION:C241  //Cancelamos la transaccion y avisamos al usuario
				CD_Dlog (0;__ ("Algunas cuentas se encuentran ocupadas y no pueden ser modificadas en este momento.\rIntente repetir la eliminación de la matriz más tarde."))
			Else   //Si no... eliminamos la matriz antigua y sus items y procedemos a regenerar cargos para el mes en curso y documentos de cargo
				QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=alACT_IdMatriz{$line})
				QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=[ACT_Matrices:177]ID:1)
				DELETE SELECTION:C66([xxACT_ItemsMatriz:180])
				DELETE RECORD:C58([ACT_Matrices:177])
				LOG_RegisterEvt ("Eliminación de matriz "+[ACT_Matrices:177]Nombre_matriz:2+".")
				READ ONLY:C145([ACT_Matrices:177])
				READ ONLY:C145([xxACT_ItemsMatriz:180])
				For ($x;1;Size of array:C274(aLong1))
					READ WRITE:C146([ACT_CuentasCorrientes:175])
					GOTO RECORD:C242([ACT_CuentasCorrientes:175];aLong1{$x})
					If ([ACT_CuentasCorrientes:175]ID_Matriz:7#0)
						READ WRITE:C146([ACT_Cargos:173])
						READ WRITE:C146([ACT_Documentos_de_Cargo:174])
						QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=[ACT_CuentasCorrientes:175]ID_Matriz:7)
						KRL_RelateSelection (->[ACT_Cargos:173]Ref_Item:16;->[xxACT_ItemsMatriz:180]ID_Item:2;"")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
						ACTcc_EliminaCargosLoop 
						UNLOAD RECORD:C212([ACT_Documentos_de_Cargo:174])
						READ ONLY:C145([ACT_Documentos_de_Cargo:174])
					End if 
					ACTcc_CalculaMontos ([ACT_CuentasCorrientes:175]ID:1)
					$locked:=Locked:C147([ACT_CuentasCorrientes:175])
				End for 
				VALIDATE TRANSACTION:C240  //y validamos la transaccion
			End if 
		End if 
	End if 
	  //Finalmente, rearmamos el tab de configuracion de matrices.
	ACTcfg_LoadDataMatrices 
	Case of 
		: (Size of array:C274(alACT_IdMatriz)=0)
			$line:=0
			  //AT_Initialize (->alACT_ItemRecNum;->atACT_GlosaItemMatriz;->arACT_amountItemMatriz;->abACT_IsDiscountItemMatriz;->abACT_IsPercentItemMatriz;->abACT_esDescontable;->atACT_MonedaItem;->alACT_MesDeCargo;->abACT_ItemAfectoIVA;->abACT_AfectoDescInd;->apACT_AfectoItemMatriz;->abACT_AfectoItemMatriz;->alACT_IdItemMatriz;->alACT_RecNumItems)
			ACTcfg_OpcionesArraysItemsM ("InicializaArrays")
			vl_ItemsEnMatriz:=0
		: (($line=1) & (Size of array:C274(alACT_IdMatriz)>0))
			$line:=1
			$id:=alACT_IdMatriz{$line}
		: ($line>Size of array:C274(alACT_IdMatriz))
			$line:=Size of array:C274(alACT_IdMatriz)
			$id:=alACT_IdMatriz{$line}
		Else 
			$id:=alACT_IdMatriz{$line}
	End case 
	ACTinit_LoadMatrixIntoArrays   //Regeneramos arreglos con nombres e ids de matrices
	vi_lastLine:=$line
	QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=alACT_IdMatriz{$line})
	AL_UpdateArrays (xALP_Items2;0)
	AL_UpdateArrays (xALP_Matrices;0)
	AL_UpdateArrays (xALP_ItemsMatriz;0)
	ACTcfg_loadMatrixItems ([ACT_Matrices:177]ID:1)
	ACTcfg_UpdateMatrixItemsArea 
	ACTcfg_UpdateItems2Area 
	AL_UpdateArrays (xALP_Matrices;-2)
	If ($line#0)
		$line:=Find in array:C230(alACT_IdMatriz;$id)
		ARRAY INTEGER:C220($alines;1)
		$alines{1}:=$line
		AL_SetSelect (xALP_Matrices;$alines)
	End if 
	ACTcfg_CalculateMatrixAmounts 
	ACTcfg_TestMatrixButtons 
End if 