//%attributes = {}
  //ACTcc_CreaRecDctoMontoItem

C_LONGINT:C283($itemRefRecNum;$1)
C_REAL:C285($desctoXItem;$2)
C_BOOLEAN:C305($vl_cargoRelacionado)

$itemRefRecNum:=$1
$desctoXItem:=$2
$vl_cargoRelacionado:=$3

$b_noElimina:=False:C215

  // Modificado por: Saúl Ponce (30/01/2018) Nº 192927, Para almacenar en el array el rec num de los cargos. Este array se utiliza en el ingreso de pagos.
C_POINTER:C301(vy_puntero)
If (Count parameters:C259>=4)
	vy_puntero:=$4
End if 

READ WRITE:C146([ACT_Cargos:173])
GOTO RECORD:C242([ACT_Cargos:173];$itemRefRecNum)
If (([ACT_Cargos:173]ID_CargoRelacionado:47=0) | (($vl_cargoRelacionado) & ([ACT_Cargos:173]ID_Tercero:54=1)))
	If (Not:C34([ACT_Cargos:173]EsRelativo:10))
		  //$vr_dctoIndividual:=[ACT_Cargos]Descuentos_Individual*-1
		$vr_dctoFamilia:=[ACT_Cargos:173]Descuentos_Familia:26*-1
		$vr_dctoCargas:=[ACT_Cargos:173]Descuentos_Cargas:51*-1
		$vr_dctoXItem:=$desctoXItem*-1
		
		$r_descuento:=0
		For ($l_indice;1;Size of array:C274(alACT_DIIdItem))
			$r_monto:=Abs:C99(arACT_DIMonto{$l_indice})*-1
			  //ACTcc_DuplicaCargoDcto (0;$itemRefRecNum;$r_monto;False;"";alACT_DIIdItem{$l_indice};$r_descuento;alACT_DIId{$l_indice})
			
			  // Modificado por: Saúl Ponce (30/01/2018) Nº 192927, Para almacenar en el array el rec num de los cargos. Este array se utiliza en el ingreso de pagos.
			  //ACTcc_DuplicaCargoDcto (0;$itemRefRecNum;$r_monto;$b_noElimina;"";alACT_DIIdItem{$l_indice};$r_descuento;alACT_DIId{$l_indice};$l_indice)
			If (Not:C34(Is nil pointer:C315(vy_puntero)))
				C_LONGINT:C283($vl_RNCargoDescto)
				$vl_RNCargoDescto:=-1
				$vl_RNCargoDescto:=ACTcc_DuplicaCargoDcto (0;$itemRefRecNum;$r_monto;$b_noElimina;"";alACT_DIIdItem{$l_indice};$r_descuento;alACT_DIId{$l_indice};$l_indice)
				If ($vl_RNCargoDescto>-1)
					If (Find in array:C230(vy_puntero->;$vl_RNCargoDescto)=-1)
						APPEND TO ARRAY:C911(vy_puntero->;$vl_RNCargoDescto)
					End if 
				End if 
			Else 
				ACTcc_DuplicaCargoDcto (0;$itemRefRecNum;$r_monto;$b_noElimina;"";alACT_DIIdItem{$l_indice};$r_descuento;alACT_DIId{$l_indice};$l_indice)
			End if 
			
			$b_noElimina:=True:C214
			If (cbUsarDescuentosXSeparado=1)
				$r_descuento:=$r_descuento+arACT_DIMonto{$l_indice}
			End if 
		End for 
		
		ACTcfg_OpcionesDescuentos ("InicializaArreglosCalc")
		
		  //ACTcc_DuplicaCargoDcto (10;$itemRefRecNum;$vr_dctoIndividual)  //descuento por cuenta
		  //ACTcc_DuplicaCargoDcto (11;$itemRefRecNum;$vr_dctoFamilia)  //descuento por número de hijo
		  //ACTcc_DuplicaCargoDcto (12;$itemRefRecNum;$vr_dctoCargas)
		  //ACTcc_DuplicaCargoDcto (13;$itemRefRecNum;$vr_dctoXItem)
		
		ACTcc_DuplicaCargoDcto (11;$itemRefRecNum;$vr_dctoFamilia;$b_noElimina)  //descuento por número de hijo
		$b_noElimina:=True:C214
		ACTcc_DuplicaCargoDcto (12;$itemRefRecNum;$vr_dctoCargas;$b_noElimina)
		ACTcc_DuplicaCargoDcto (13;$itemRefRecNum;$vr_dctoXItem;$b_noElimina)
		
		READ WRITE:C146([ACT_Cargos:173])
		GOTO RECORD:C242([ACT_Cargos:173];$itemRefRecNum)
		[ACT_Cargos:173]Descuentos_Individual:31:=0
		[ACT_Cargos:173]Descuentos_Familia:26:=0
		[ACT_Cargos:173]Descuentos_Cargas:51:=0
		  //20120804 RCH Este total no quedaba correcto.
		[ACT_Cargos:173]Total_Desctos:45:=0
		SAVE RECORD:C53([ACT_Cargos:173])
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_Cargos:173])