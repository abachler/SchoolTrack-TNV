//%attributes = {}
C_TEXT:C284($1;$vt_accion)
C_TEXT:C284($0;$vt_retorno)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1;$vy_pointer2)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="MuestraFormTramos")
		If ([xxACT_Items:179]ID:1#0)
			If ([xxACT_Items:179]EsDescuento:6=False:C215)
				C_TEXT:C284($vt_item;$vt_title)
				If ([xxACT_Items:179]Monto:7>0)
					If (Length:C16([xxACT_Items:179]Glosa:2)>20)
						$vt_item:=Substring:C12([xxACT_Items:179]Glosa:2;1;17)+"..."
					Else 
						$vt_item:=[xxACT_Items:179]Glosa:2
					End if 
					$vt_title:=__ ("Tramos para ^0";$vt_item)
					WDW_OpenFormWindow (->[xxACT_ItemsTramos:291];"Configuration";-1;4;$vt_title)
					DIALOG:C40([xxACT_ItemsTramos:291];"Configuration")
					CLOSE WINDOW:C154
					ACTcfgit_OpcionesGenerales ("DeclaraArreglos")
				Else 
					CD_Dlog (0;__ ("Para poder utilizar esta opción el monto del ítems debe ser superior a 0."))
				End if 
			Else 
				CD_Dlog (0;__ ("Esta opción solo está disponible para cargos."))
			End if 
		Else 
			CD_Dlog (0;__ ("Se necesita buscar un ítem de cargo antes de utilizar esta opción."))
		End if 
		
	: ($vt_accion="LlenaArreglosLB")
		$vl_idItem:=[xxACT_Items:179]ID:1
		
		ACTcfgit_OpcionesGenerales ("DeclaraArreglos")
		
		READ ONLY:C145([xxACT_ItemsTramos:291])
		QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id_item_de_cargo:2=$vl_idItem)
		ORDER BY:C49([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]dia_tramo_desde:3;>)
		SELECTION TO ARRAY:C260([xxACT_ItemsTramos:291]id:1;alACT_ITid;[xxACT_ItemsTramos:291]dia_tramo_desde:3;alACT_ITdesde;[xxACT_ItemsTramos:291]dia_tramo_hasta:4;alACT_IThasta;[xxACT_ItemsTramos:291]es_monto_fijo:5;abACT_ITesMontoFijo;[xxACT_ItemsTramos:291]valor:6;arACT_ITvalor)
		
	: ($vt_accion="DeclaraArreglos")
		ARRAY LONGINT:C221(alACT_ITid;0)
		ARRAY LONGINT:C221(alACT_ITdesde;0)
		ARRAY LONGINT:C221(alACT_IThasta;0)
		ARRAY BOOLEAN:C223(abACT_ITesMontoFijo;0)
		ARRAY REAL:C219(arACT_ITvalor;0)
		
	: ($vt_accion="UtilizaTramos")
		$vl_idItem:=[xxACT_Items:179]ID:1
		If ($vy_pointer1->)
			$vl_desde:=1
			$vl_hasta:=31
			$vb_esMontoFijo:=True:C214
			$vr_valor:=0
			ACTit_CreaRegistro ($vl_idItem;$vl_desde;$vl_hasta;$vb_esMontoFijo;$vr_valor)
			ACTcfgit_OpcionesGenerales ("LlenaArreglosLB")
			$vt_retorno:="1"
		Else 
			$vl_resp:=CD_Dlog (0;__ ("Los tramos configurados serán eliminados.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
			If ($vl_resp=1)
				$vl_ok:=Num:C11(ACTcfgit_OpcionesGenerales ("EliminaTramosItem";->$vl_idItem))
				If ($vl_ok=1)
					CD_Dlog (0;__ ("Tramos eliminados"))
					ACTcfgit_OpcionesGenerales ("LlenaArreglosLB")
					$vt_retorno:="0"
				Else 
					CD_Dlog (0;__ ("Los Tramos no pudieron ser eliminados"))
					$vt_retorno:="1"
				End if 
			Else 
				$vt_retorno:="1"
			End if 
		End if 
		
	: ($vt_accion="EliminaTramosItem")
		ARRAY LONGINT:C221($alACT_idTramo;0)
		$vl_idItem:=$vy_pointer1->
		START TRANSACTION:C239
		READ WRITE:C146([xxACT_ItemsTramos:291])
		QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id_item_de_cargo:2=$vl_idItem)
		SELECTION TO ARRAY:C260([xxACT_ItemsTramos:291]id:1;$alACT_idTramo)
		For ($i;1;Size of array:C274($alACT_idTramo))
			$vt_retorno:=ACTcfgit_OpcionesGenerales ("EliminaTramo";->$alACT_idTramo{$i})
			If ($vt_retorno="0")
				$i:=Size of array:C274($alACT_idTramo)
			End if 
		End for 
		If ($vt_retorno="1")
			VALIDATE TRANSACTION:C240
		Else 
			CANCEL TRANSACTION:C241
		End if 
		KRL_UnloadReadOnly (->[xxACT_ItemsTramos:291])
		
	: ($vt_accion="ValidaItemDesctoCargo")
		If ([xxACT_Items:179]EsDescuento:6)
			READ ONLY:C145([xxACT_ItemsTramos:291])
			QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id_item_de_cargo:2=[xxACT_Items:179]ID:1)
			If (Records in selection:C76([xxACT_Items:179])>0)
				$vl_resp:=CD_Dlog (0;__ ("Este ítem de cargo tiene configurado tramos. Si continúa estos tramos serán eliminados.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
				If ($vl_resp=1)
					$vt_retorno:=ACTcfgit_OpcionesGenerales ("EliminaTramosItem";->[xxACT_Items:179]ID:1)
					If ($vt_retorno="0")
						[xxACT_Items:179]EsDescuento:6:=Old:C35([xxACT_Items:179]EsDescuento:6)
						CD_Dlog (0;__ ("Los tramos no pudieron ser eliminados. La configuración será mantenida."))
					Else 
						[xxACT_Items:179]Utiliza_tramos:38:=False:C215
					End if 
				Else 
					[xxACT_Items:179]EsDescuento:6:=Old:C35([xxACT_Items:179]EsDescuento:6)
				End if 
			End if 
		End if 
		
	: ($vt_accion="InsertaTramo")
		If ([xxACT_Items:179]Utiliza_tramos:38)
			READ WRITE:C146([xxACT_ItemsTramos:291])
			QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id_item_de_cargo:2=[xxACT_Items:179]ID:1)
			ORDER BY:C49([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]dia_tramo_desde:3;<)
			If ([xxACT_ItemsTramos:291]dia_tramo_desde:3<27)
				If (Not:C34(Locked:C147([xxACT_ItemsTramos:291])))
					$vl_idItem:=[xxACT_Items:179]ID:1
					$vl_hasta:=[xxACT_ItemsTramos:291]dia_tramo_hasta:4
					[xxACT_ItemsTramos:291]dia_tramo_hasta:4:=[xxACT_ItemsTramos:291]dia_tramo_desde:3+1
					SAVE RECORD:C53([xxACT_ItemsTramos:291])
					
					$vl_desde:=[xxACT_ItemsTramos:291]dia_tramo_hasta:4+1
					$vb_esMontoFijo:=True:C214
					$vr_valor:=0
					ACTit_CreaRegistro ($vl_idItem;$vl_desde;$vl_hasta;$vb_esMontoFijo;$vr_valor)
					ACTcfgit_OpcionesGenerales ("ValidaDiasTramos")
					ACTcfgit_OpcionesGenerales ("LlenaArreglosLB")
				Else 
					CD_Dlog (0;__ ("Tramo no agregado."))
				End if 
			Else 
				CD_Dlog (0;__ ("Tramo no agregado."))
			End if 
			KRL_UnloadReadOnly (->[xxACT_ItemsTramos:291])
		Else 
			CD_Dlog (0;__ ("El ítem de cargo debe utilizar tramos antes de utilizar esta opción."))
		End if 
		
	: ($vt_accion="EliminaTramoLB")
		C_LONGINT:C283($vl_line;$vl_col)
		LISTBOX GET CELL POSITION:C971(lb_tramos;$vl_col;$vl_line)
		If (Size of array:C274(alACT_ITid)>1)
			If ($vl_line<=Size of array:C274(alACT_ITid))
				$vl_idTramo:=alACT_ITid{$vl_line}
				START TRANSACTION:C239
				$vt_retorno:=ACTcfgit_OpcionesGenerales ("EliminaTramo";->$vl_idTramo)
				If ($vt_retorno="1")
					$vt_retorno:=ACTcfgit_OpcionesGenerales ("ValidaDiasTramos")
					If ($vt_retorno="1")
						ACTcfgit_OpcionesGenerales ("LlenaArreglosLB")
						VALIDATE TRANSACTION:C240
					Else 
						CANCEL TRANSACTION:C241
						CD_Dlog (0;__ ("El tramo no pudo ser eliminado."))
					End if 
				Else 
					CANCEL TRANSACTION:C241
					CD_Dlog (0;__ ("El tramo no pudo ser eliminado."))
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("El primer tramo no pude ser eliminado con esta opción. Si quiere eliminar este tramo, desmarque la propiedad Utilizar tramos"))
		End if 
	: ($vt_accion="EliminaTramo")
		C_LONGINT:C283($vl_idTramo;$vl_records)
		$vl_idTramo:=$vy_pointer1->
		READ WRITE:C146([xxACT_ItemsTramos:291])
		QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id:1=$vl_idTramo)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
		QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id_item_de_cargo:2=[xxACT_ItemsTramos:291]id_item_de_cargo:2)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_recordsCargos)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Id_TramoItem:62=$vl_idTramo)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ((Records in selection:C76([xxACT_ItemsTramos:291])=1) & (Not:C34(Locked:C147([xxACT_ItemsTramos:291]))) & (($vl_records>1) | (Not:C34([xxACT_Items:179]Utiliza_tramos:38))) & ($vl_recordsCargos=0))
			DELETE RECORD:C58([xxACT_ItemsTramos:291])
			$vt_retorno:="1"
		Else 
			$vt_retorno:="0"
			Case of 
				: ($vl_recordsCargos>0)
					CD_Dlog (0;__ ("Existen cargos asociados al tramo que intenta eliminar."+" "+__ ("El registro no pudo ser eliminado")))
					
			End case 
		End if 
		KRL_UnloadReadOnly (->[xxACT_ItemsTramos:291])
		
		
	: ($vt_accion="ValidaDiasTramos")
		C_LONGINT:C283($vl_inicial)
		C_BOOLEAN:C305($vb_error)
		ARRAY LONGINT:C221($alACT_id;0)
		READ ONLY:C145([xxACT_ItemsTramos:291])
		QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id_item_de_cargo:2=[xxACT_Items:179]ID:1)
		ORDER BY:C49([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]dia_tramo_desde:3;>)
		$vl_inicial:=1
		$vb_error:=False:C215
		SELECTION TO ARRAY:C260([xxACT_ItemsTramos:291]id:1;$alACT_id)
		$vb_validarT:=False:C215
		If (Not:C34(In transaction:C397))
			START TRANSACTION:C239
			$vb_validarT:=True:C214
		End if 
		For ($i;1;Size of array:C274($alACT_id))
			READ WRITE:C146([xxACT_ItemsTramos:291])
			KRL_FindAndLoadRecordByIndex (->[xxACT_ItemsTramos:291]id:1;->$alACT_id{$i};True:C214)
			If (ok=1)
				If ([xxACT_ItemsTramos:291]dia_tramo_desde:3#$vl_inicial)
					  //20150909 RCH Para soportar dia 0
					  //[xxACT_ItemsTramos]dia_tramo_desde:=$vl_inicial
					If (Not:C34((IT_AltKeyIsDown ) & ($i=1)))
						[xxACT_ItemsTramos:291]dia_tramo_desde:3:=$vl_inicial
					End if 
				End if 
				If ([xxACT_ItemsTramos:291]dia_tramo_hasta:4<[xxACT_ItemsTramos:291]dia_tramo_desde:3)
					[xxACT_ItemsTramos:291]dia_tramo_hasta:4:=[xxACT_ItemsTramos:291]dia_tramo_desde:3+1
				End if 
				
				If ($i=Size of array:C274($alACT_id))
					[xxACT_ItemsTramos:291]dia_tramo_hasta:4:=31
				Else 
					If (([xxACT_ItemsTramos:291]dia_tramo_desde:3>27) | ([xxACT_ItemsTramos:291]dia_tramo_hasta:4>27))
						$vl_inicial:=[xxACT_ItemsTramos:291]dia_tramo_desde:3
						$vt_retorno:=ACTcfgit_OpcionesGenerales ("EliminaTramo";->[xxACT_ItemsTramos:291]id:1)
						If ($vt_retorno="0")
							$i:=Size of array:C274($alACT_id)
							$vb_error:=True:C214
						End if 
					Else 
						$vl_inicial:=[xxACT_ItemsTramos:291]dia_tramo_hasta:4+1
					End if 
				End if 
				SAVE RECORD:C53([xxACT_ItemsTramos:291])
				$vt_retorno:="1"
			Else 
				$i:=Size of array:C274($alACT_id)
				$vb_error:=True:C214
				$vt_retorno:="0"
			End if 
			KRL_UnloadReadOnly (->[xxACT_ItemsTramos:291])
		End for 
		If ($vb_validarT)
			If ($vb_error)
				CANCEL TRANSACTION:C241
			Else 
				VALIDATE TRANSACTION:C240
			End if 
		End if 
		
	: ($vt_accion="ValidaIngreso")
		C_LONGINT:C283($vl_col;$vl_line)
		C_POINTER:C301($vy_pointer)
		C_TEXT:C284($varName1)
		LISTBOX GET CELL POSITION:C971(lb_tramos;$vl_col;$vl_line;$vy_pointer)
		RESOLVE POINTER:C394($vy_pointer;$varName1;$tableNum1;$fieldNum1)
		  //ARRAY LONGINT(alACT_ITdesde;0)
		  //ARRAY LONGINT(alACT_IThasta;0)
		  //ARRAY BOOLEAN(abACT_ITesMontoFijo;0)
		  //ARRAY REAL(arACT_ITvalor;0)
		Case of 
			: ($varName1="alACT_ITdesde")
				If ($vl_line=1)
					alACT_ITdesde{$vl_line}:=1
					  //20150909 RCH Para soportar dia de inicio 0
					If (IT_AltKeyIsDown )
						alACT_ITdesde{$vl_line}:=0
					End if 
				End if 
				If (alACT_ITdesde{$vl_line}<0)
					alACT_ITdesde{$vl_line}:=1
				End if 
				If (alACT_ITdesde{$vl_line}>27)
					alACT_ITdesde{$vl_line}:=27
				End if 
				
			: ($varName1="alACT_IThasta")
				If (alACT_IThasta{$vl_line}<alACT_ITdesde{$vl_line})
					alACT_IThasta{$vl_line}:=alACT_ITdesde{$vl_line}+1
				End if 
				If ($vl_line=Size of array:C274(alACT_IThasta))
					alACT_IThasta{$vl_line}:=31
				End if 
				
			: ($varName1="arACT_ITvalor")
				  // Modificado por: Saúl Ponce (21-11-2016) Ticket 170873
				  // $vl_dec:=Num(ACTcar_OpcionesGenerales ("NumeroDecimales";->[xxACT_Items]Moneda))
				  // Se establecen dos decimales para los montos porcentuales. Para montos fijos se usa la conf. de moneda del item.
				$vl_dec:=Choose:C955(Not:C34(abACT_ITesMontoFijo{$vl_line});2;Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->[xxACT_Items:179]Moneda:10)))
				arACT_ITvalor{$vl_line}:=Round:C94(arACT_ITvalor{$vl_line};$vl_dec)
				
			: ($varName1="abACT_ITesMontoFijo")
				If (abACT_ITesMontoFijo{$vl_line}#abACT_ITesMontoFijo{0})
					arACT_ITvalor{$vl_line}:=0
				End if 
				
		End case 
		
		If (Not:C34(abACT_ITesMontoFijo{$vl_line}))
			If ((arACT_ITvalor{$vl_line}<-100) | (arACT_ITvalor{$vl_line}>100))
				arACT_ITvalor{$vl_line}:=0
			End if 
		End if 
		
		$vt_retorno:=ACTcfgit_OpcionesGenerales ("AlmacenaPorID";->$vl_line)
		If ($vt_retorno="0")
			$vy_pointer->{$vl_line}:=$vy_pointer->{0}
		Else 
			$vt_retorno:=ACTcfgit_OpcionesGenerales ("ValidaDiasTramos")
			If ($vt_retorno="0")  //si hay error, devuelvo el valor original
				$vy_pointer->{$vl_line}:=$vy_pointer->{0}
			Else 
				ACTcfgit_OpcionesGenerales ("LlenaArreglosLB")
			End if 
		End if 
		
		
	: ($vt_accion="AlmacenaPorID")
		$vl_line:=$vy_pointer1->
		$vl_idTramo:=alACT_ITid{$vl_line}
		READ WRITE:C146([xxACT_ItemsTramos:291])
		KRL_FindAndLoadRecordByIndex (->[xxACT_ItemsTramos:291]id:1;->$vl_idTramo;True:C214)
		If (ok=1)
			[xxACT_ItemsTramos:291]dia_tramo_desde:3:=alACT_ITdesde{$vl_line}
			[xxACT_ItemsTramos:291]dia_tramo_hasta:4:=alACT_IThasta{$vl_line}
			[xxACT_ItemsTramos:291]es_monto_fijo:5:=abACT_ITesMontoFijo{$vl_line}
			[xxACT_ItemsTramos:291]valor:6:=arACT_ITvalor{$vl_line}
			SAVE RECORD:C53([xxACT_ItemsTramos:291])
			$vt_retorno:="1"
		Else 
			$vt_retorno:="0"
		End if 
		KRL_UnloadReadOnly (->[xxACT_ItemsTramos:291])
		
	: ($vt_accion="ValidaCambioMontoOMoneda")
		C_LONGINT:C283($vl_records)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
		QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id_item_de_cargo:2=[xxACT_Items:179]ID:1)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($vl_records>0)
			If (KRL_FieldChanges (->[xxACT_Items:179]Monto:7))
				CD_Dlog (0;__ ("Recuerde configurar adecuadamente los tramos de montos para este ítem de cargo."))
			Else 
				If (KRL_FieldChanges (->[xxACT_Items:179]Moneda:10))
					CD_Dlog (0;__ ("Recuerde configurar adecuadamente los tramos de montos para este ítem de cargo."))
				End if 
			End if 
		End if 
		
	: ($vt_accion="DuplicaItemsTramosParaItem")  //20131002 RCH
		C_LONGINT:C283($l_idItemOrg;$l_idItemNuevo;$l_indiceTramos;$vl_idItem;$vl_desde;$vl_hasta)
		C_BOOLEAN:C305($vb_esMontoFijo)
		C_REAL:C285($vr_valor)
		ARRAY LONGINT:C221($al_recNumsTramos;0)
		$l_idItemOrg:=$vy_pointer1->
		$l_idItemNuevo:=$vy_pointer2->
		
		READ ONLY:C145([xxACT_ItemsTramos:291])
		QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id_item_de_cargo:2=$l_idItemOrg)
		ORDER BY:C49([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]dia_tramo_desde:3;>)
		
		LONGINT ARRAY FROM SELECTION:C647([xxACT_ItemsTramos:291];$al_recNumsTramos;"")
		For ($l_indiceTramos;1;Size of array:C274($al_recNumsTramos))
			GOTO RECORD:C242([xxACT_ItemsTramos:291];$al_recNumsTramos{$l_indiceTramos})
			$vl_idItem:=$l_idItemNuevo
			$vl_desde:=[xxACT_ItemsTramos:291]dia_tramo_desde:3
			$vl_hasta:=[xxACT_ItemsTramos:291]dia_tramo_hasta:4
			$vb_esMontoFijo:=[xxACT_ItemsTramos:291]es_monto_fijo:5
			$vr_valor:=[xxACT_ItemsTramos:291]valor:6
			ACTit_CreaRegistro ($vl_idItem;$vl_desde;$vl_hasta;$vb_esMontoFijo;$vr_valor)
		End for 
		
	: ($vt_accion="buscaItemsADesplegar")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		
		
		C_TEXT:C284($t_periodo)
		C_LONGINT:C283($l_idItemSelec)
		$t_periodo:=""
		
		If (Not:C34(Is nil pointer:C315($vy_pointer1)))
			$t_periodo:=$vy_pointer1->
		End if 
		
		ACTcfgit_OpcionesGenerales ("declaraArrayUtilizadoEnLista")
		
		$l_idItemSelec:=[xxACT_Items:179]ID:1
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsDescuento:6=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]EsRelativo:5=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]ID:1>0;*)
		If ($t_periodo#"")
			QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]Periodo:42=$t_periodo;*)
		End if 
		ACTqry_Items ("NoEspeciales";->[xxACT_Items:179]ID:1;->al_IdsItems;->[xxACT_Items:179]Glosa:2;->at_GlosasItems)
		
		$vt_retorno:=String:C10(Size of array:C274(al_IdsItems))
		
		If ($l_idItemSelec>0)
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$l_idItemSelec)
		End if 
		
		
	: ($vt_accion="declaraArrayUtilizadoEnLista")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		ARRAY LONGINT:C221(al_IdsItems;0)
		ARRAY TEXT:C222(at_GlosasItems;0)
		
		
		
		
	: ($vt_accion="retornaIdParaTramoDeEsteItem")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		C_LONGINT:C283($l_idItem)
		$l_idItem:=$vy_pointer1->
		
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$l_idItem)
		
		If ([xxACT_Items:179]tramos_idItem:51#0)
			$vt_retorno:=String:C10([xxACT_Items:179]tramos_idItem:51)
		Else 
			$vt_retorno:=String:C10([xxACT_Items:179]ID:1)
		End if 
		
		
		
	: ($vt_accion="preparaCambioGlosaParaTramo")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		C_LONGINT:C283($l_resp;$l_IdItemSeleccionado;$l_idItemPorModificar)
		C_TEXT:C284($t_mensaje;$t_glosaItemSelec)
		
		$l_IdItemSeleccionado:=$vy_pointer2->
		$l_idItemPorModificar:=$vy_pointer1->
		
		$t_glosaItemSelec:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$l_IdItemSeleccionado;->[xxACT_Items:179]Glosa:2)
		
		$t_mensaje:=__ ("Se dispone a modificar la glosa que este item de cargo utiliza para generar tramos. ")+"\r\r"
		$t_mensaje:=$t_mensaje+__ ("Si continúa, a partir de este momento, los tramos de este item utilizarán la glosa: ^0,";$t_glosaItemSelec)
		$t_mensaje:=$t_mensaje+__ (" más un sufijo que indicará el ^0 y ^1 configurado en el tramo.";ST_Qte ("Desde");ST_Qte ("Hasta"))+"\r\r"
		$t_mensaje:=$t_mensaje+__ ("¿Desea continuar?")
		$l_resp:=CD_Dlog (0;$t_mensaje;"";__ ("Continuar");__ ("Cancelar"))
		
		If (($l_resp=1) | ($l_resp=2))
			
			If ($l_resp=1)
				$vt_retorno:=ACTcfgit_OpcionesGenerales ("almacenaCambioEnGlosaParaTramoDelItem";->$l_idItemPorModificar;->$l_IdItemSeleccionado)
			End if 
			
			  // el usuario canceló
			If ($l_resp=2)
				$vt_retorno:="-1"
			End if 
		End if 
		
		
	: ($vt_accion="almacenaCambioEnGlosaParaTramoDelItem")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		C_LONGINT:C283($l_idItem;$l_valor)
		
		$l_idItem:=$vy_pointer1->
		$l_valor:=$vy_pointer2->
		
		READ WRITE:C146([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$l_idItem)
		If (Not:C34(Locked:C147([xxACT_Items:179])))
			[xxACT_Items:179]tramos_idItem:51:=$l_valor
			[xxACT_Items:179]Utiliza_tramos:38:=($l_valor>0)  // Modificado por: Saul Ponce (07-10-2018) Ticket Nº 187484
			SAVE RECORD:C53([xxACT_Items:179])
		End if 
		
		$vt_retorno:=String:C10(Records in selection:C76([xxACT_Items:179]))
		
		
	: ($vt_accion="logCambioDeItemEnIdParaTramo")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		C_LONGINT:C283($l_idItem;$l_nuevoIdAsignado)
		C_TEXT:C284($t_log;$t_glosaItemSelec)
		
		$l_idItem:=$vy_pointer1->
		$l_nuevoIdAsignado:=$vy_pointer2->
		
		$t_glosaItemSelec:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$l_nuevoIdAsignado;->[xxACT_Items:179]Glosa:2)
		$t_log:="Modificación en "+ST_Qte ("Configuración de Glosa para Tramos")+" para el item de cargo Id: "+String:C10($l_idItem)
		$t_log:=$t_log+". Valor seleccionado "+ST_Qte ($t_glosaItemSelec)+", del item correspondiente al Id "+String:C10($l_nuevoIdAsignado)+"."
		
		LOG_RegisterEvt ($t_log)
		
		
	: ($vt_accion="problemaAlCambiarElIdParaTramos")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		C_TEXT:C284($t_mensaje)
		$t_mensaje:=__ ("Ocurrió un problema al almacenar ")+__ (ST_Qte ("Glosa para Tramos"))+__ (" en este item.")
		$t_mensaje:=$t_mensaje+"\r\r"+__ ("Inténtelo nuevamente más tarde.")
		CD_Dlog (0;$t_mensaje)
		
	: ($vt_accion="retornaGlosaParaTramoPorRefItem")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		C_TEXT:C284($t_glosaTemp)
		C_LONGINT:C283($l_idItem;$l_idParaTramo;$l_posicion)
		
		$l_idItem:=$vy_pointer1->
		$l_posicion:=$vy_pointer2->
		
		$t_glosaTemp:=""
		$l_idParaTramo:=0
		
		$l_idParaTramo:=Num:C11(ACTcfgit_OpcionesGenerales ("retornaIdParaTramoDeEsteItem";->$l_idItem))
		
		If ($l_idParaTramo=$l_idItem)
			$t_glosaTemp:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$l_idItem;->[xxACT_Items:179]Glosa:2)
		Else 
			$t_glosaTemp:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$l_idParaTramo;->[xxACT_Items:179]Glosa:2)
			
			If ($l_posicion>0)
				If (Num:C11(ACTcfgit_OpcionesGenerales ("CargaArraysConFechasDeTramos";->$l_idItem))>0)
					$t_glosaTemp:=$t_glosaTemp+" - Tramo desde "+String:C10(alACT_ITdesdeTramo{$l_posicion})+" hasta "+String:C10(alACT_IThastaTramo{$l_posicion})
				End if 
			End if 
			
		End if 
		
		$vt_retorno:=$t_glosaTemp
		
	: ($vt_accion="DeclaraArraysParaFechasDeTramos")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		ARRAY LONGINT:C221(alACT_ITdesdeTramo;0)
		ARRAY LONGINT:C221(alACT_IThastaTramo;0)
		
	: ($vt_accion="CargaArraysConFechasDeTramos")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		C_LONGINT:C283($j;$vl_refItem;$vl_idTramo;$l_desde;$l_hasta)
		
		$vl_refItem:=$vy_pointer1->
		
		ACTcfgit_OpcionesGenerales ("declaraArraysParaFechasDeTramos")
		ACTitems_OpcionesRecalculoTramo ("BuscaTramoItem";->$vl_refItem)
		
		For ($j;1;Size of array:C274(alACT_idTramo))
			$vl_idTramo:=alACT_idTramo{$j}
			$l_desde:=KRL_GetNumericFieldData (->[xxACT_ItemsTramos:291]id:1;->$vl_idTramo;->[xxACT_ItemsTramos:291]dia_tramo_desde:3)
			$l_hasta:=KRL_GetNumericFieldData (->[xxACT_ItemsTramos:291]id:1;->$vl_idTramo;->[xxACT_ItemsTramos:291]dia_tramo_hasta:4)
			APPEND TO ARRAY:C911(alACT_ITdesdeTramo;$l_desde)
			APPEND TO ARRAY:C911(alACT_IThastaTramo;$l_hasta)
		End for 
		
		$vt_retorno:=String:C10(Size of array:C274(alACT_idTramo))
		
	: ($vt_accion="ComparaIdSeleccionadoConAsignadoEnItem")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		C_LONGINT:C283($l_idItem;$l_idParaTramoEnItem)
		C_LONGINT:C283($l_idSeleccionadoPorUsuario)
		
		$l_idItem:=$vy_pointer1->
		$l_idSeleccionadoPorUsuario:=$vy_pointer2->
		
		$l_idParaTramoEnItem:=KRL_GetNumericFieldData (->[xxACT_Items:179]ID:1;->$l_idItem;->[xxACT_Items:179]tramos_idItem:51)
		
		If ($l_idParaTramoEnItem=$l_idSeleccionadoPorUsuario)
			$vt_retorno:="0"  // no se debe producir el cambio de id pa tramo
		Else 
			$vt_retorno:="1"  // debe asignarse el nuevo id
		End if 
		
	: ($vt_accion="EliminacionDeItemConfiguradoParaTramos")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		C_LONGINT:C283($l_idItem;$l_indice;$l_cero;$l_eliminados)
		ARRAY LONGINT:C221($al_idItems;0)
		
		$l_idItem:=$vy_pointer1->
		$l_cero:=0
		
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]tramos_idItem:51=$l_idItem)
		SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$al_idItems)
		For ($l_indice;1;Size of array:C274($al_idItems))
			If (Num:C11(ACTcfgit_OpcionesGenerales ("almacenaCambioEnGlosaParaTramoDelItem";->$al_idItems{$l_indice};->$l_cero))=1)
				$l_eliminados:=($l_eliminados+1)
			End if 
		End for 
		
		If ($l_eliminados>0)
			ACTcfgit_OpcionesGenerales ("LogEliminacionItemUtizadoEnGlosaParaCargosPorTramo";->$l_idItem;->$al_idItems)
		End if 
		
		$vt_retorno:=String:C10(Size of array:C274($al_idItems))
		
		If ($l_idItem>0)
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]tramos_idItem:51=$l_idItem)
		End if 
		
		
		
	: ($vt_accion="LogEliminacionItemUtizadoEnGlosaParaCargosPorTramo")  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		
		C_LONGINT:C283($l_idItem)
		C_TEXT:C284($t_log;$t_glosa;$t_periodo)
		
		$l_idItem:=$vy_pointer1->
		$t_glosa:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$l_idItem;->[xxACT_Items:179]Glosa:2)
		$t_periodo:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$l_idItem;->[xxACT_Items:179]Periodo:42)
		
		$t_log:="Eliminación del item de cargo id "+String:C10($l_idItem)+", Glosa: "+$t_glosa+", correspondinte al periodo "+$t_periodo+".\r"
		$t_log:=$t_log+"Modificación en la glosa utilizada para cargos por tramos en los siguientes items id's: "+AT_array2text ($vy_pointer2;", ")
		LOG_RegisterEvt ($t_log)
		
	: ($vt_accion="deshabilitaLista")  // Modificado por: Saul Ponce (07-10-2018) Ticket Nº 187484
		
		C_BOOLEAN:C305($b_habilitar)
		$b_habilitar:=$vy_pointer1->
		$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramo")
		OBJECT SET ENABLED:C1123($y_control->;$b_habilitar)
		$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_itemGeneraTramo")
		OBJECT SET ENABLED:C1123($y_control->;$b_habilitar)
		
		
	: ($vt_accion="actualizaListaParaItemSeleccionado")  // Modificado por: Saul Ponce (07-10-2018) Ticket Nº 187484
		
		C_LONGINT:C283($l_idParaTramo;$l_posItem)
		$l_idParaTramo:=$vy_pointer1->
		$l_posItem:=Find in array:C230(al_IdsItems;$l_idParaTramo)
		If ($l_posItem>-1)
			at_GlosasItems:=$l_posItem
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramo")
			$y_control->:=at_GlosasItems{$l_posItem}
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramoId")
			$y_control->:=al_IdsItems{$l_posItem}
		End if 
		
		
		
End case 


$0:=$vt_retorno