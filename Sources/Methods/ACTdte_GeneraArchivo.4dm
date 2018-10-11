//%attributes = {}

C_TEXT:C284($1;$vt_accion;$vt_dts;$vt_prefijo)
C_TEXT:C284($0;$vt_retorno)
C_POINTER:C301($ptr1;$ptr2;$ptr3;${2};$ptr4;$ptr5;$ptr6;$ptr7;$ptr8;$ptr9;$ptr10)
C_POINTER:C301($vy_pointer1;$vy_pointer2;$vy_pointer3;$vy_pointer4;$vy_pointer5)
C_LONGINT:C283($vl_idDcto)
C_LONGINT:C283($vl_index;$vl_numero1;$vl_numero2;$vl_idRecord;$vl_idRS)
C_DATE:C307($vd_fecha)

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
	$ptr4:=$5
End if 
If (Count parameters:C259>=6)
	$ptr5:=$6
End if 
If (Count parameters:C259>=7)
	$ptr6:=$7
End if 
If (Count parameters:C259>=8)
	$ptr7:=$8
End if 
If (Count parameters:C259>=9)
	$ptr8:=$9
End if 
If (Count parameters:C259>=10)
	$ptr9:=$10
End if 

Case of 
	: ($vt_accion="FolioDesdeIdBolActual")
		$vl_def:=Find in array:C230(alACT_IDDT;$ptr1->)
		If ($vl_def#-1)
			$el:=Find in array:C230(alACT_IDsCats;alACT_IDCat{$vl_def})
			If ($el#-1)
				Case of 
					: ((alACT_IDsCats{$el}=-1) | (atACT_Categorias{$el}="Boleta@"))
						If (abACT_Afecta{$vl_def})
							$vt_retorno:="39"
						Else 
							$vt_retorno:="41"
						End if 
						
					: ((alACT_IDsCats{$el}=-3) | (atACT_Categorias{$el}="Factura@"))
						If (abACT_Afecta{$vl_def})
							$vt_retorno:="33"
						Else 
							$vt_retorno:="34"
						End if 
						
					: ((alACT_IDsCats{$el}=-4) | (atACT_Categorias{$el}="Nota de Crédito@"))
						$vt_retorno:="61"
						
					: ((alACT_IDsCats{$el}=-5) | (atACT_Categorias{$el}="Nota de Débito@"))
						$vt_retorno:="56"
						
					: ((alACT_IDsCats{$el}=-6) | (atACT_Categorias{$el}="Guía de Despacho@"))
						$vt_retorno:="52"
						
				End case 
			End if 
		End if 
		
	: ($vt_accion="RetornaIndexPorIdTipoDctoSII")
		  //tener cargados los arreglos de la configuración
		C_LONGINT:C283($vl_catDcto;$vl_idACTCatDcto;$vl_indexIdDefinicion)
		$vl_catDcto:=$ptr1->
		Case of 
			: (($vl_catDcto=33) | ($vl_catDcto=34))
				$vl_idACTCatDcto:=-3
				If (Find in array:C230(alACT_IDsCats;$vl_idACTCatDcto)=-1)
					$el:=Find in array:C230(atACT_Categorias;"Factura@")
					If ($el#-1)
						$vl_idACTCatDcto:=alACT_IDsCats{$el}
					Else 
						$vl_idACTCatDcto:=0
					End if 
				End if 
				
			: (($vl_catDcto=39) | ($vl_catDcto=41))
				$vl_idACTCatDcto:=-1
				If (Find in array:C230(alACT_IDsCats;$vl_idACTCatDcto)=-1)
					$el:=Find in array:C230(atACT_Categorias;"Boleta@")
					If ($el#-1)
						$vl_idACTCatDcto:=alACT_IDsCats{$el}
					Else 
						$vl_idACTCatDcto:=0
					End if 
				End if 
				
			: ($vl_catDcto=61)
				$vl_idACTCatDcto:=-4
				If (Find in array:C230(alACT_IDsCats;$vl_idACTCatDcto)=-1)
					$el:=Find in array:C230(atACT_Categorias;"Nota de Crédito@")
					If ($el#-1)
						$vl_idACTCatDcto:=alACT_IDsCats{$el}
					Else 
						$vl_idACTCatDcto:=0
					End if 
				End if 
				
			: ($vl_catDcto=56)
				$vl_idACTCatDcto:=-5
				If (Find in array:C230(alACT_IDsCats;$vl_idACTCatDcto)=-1)
					$el:=Find in array:C230(atACT_Categorias;"Nota de Débito@")
					If ($el#-1)
						$vl_idACTCatDcto:=alACT_IDsCats{$el}
					Else 
						$vl_idACTCatDcto:=0
					End if 
				End if 
				
			: ($vl_catDcto=52)
				$vl_idACTCatDcto:=-6
				If (Find in array:C230(alACT_IDsCats;$vl_idACTCatDcto)=-1)
					$el:=Find in array:C230(atACT_Categorias;"Guía de Despacho@")
					If ($el#-1)
						$vl_idACTCatDcto:=alACT_IDsCats{$el}
					Else 
						$vl_idACTCatDcto:=0
					End if 
				End if 
				
		End case 
		If ($vl_idACTCatDcto#0)
			$ok:=ACTcfg_SearchCatDocs ($vl_idACTCatDcto)
			If ($ok)
				$vl_indexIdDefinicion:=0
				Case of 
					: (($vl_catDcto=33) | ($vl_catDcto=39))
						$vl_indexIdDefinicion:=vlACT_IndexAfecta2
						
					: (($vl_catDcto=34) | ($vl_catDcto=41))
						$vl_indexIdDefinicion:=vlACT_IndexExenta2
						
				End case 
				If ($vl_indexIdDefinicion>0)
					$vt_retorno:=String:C10($vl_indexIdDefinicion)
				Else 
					$vt_retorno:="-3"
				End if 
			Else 
				$vt_retorno:="-2"
			End if 
		Else 
			$vt_retorno:="-1"
		End if 
		
		
		
		
		
		
		
		
		
		
	: ($vt_accion="SendMail")
		$mailAddress:=SMTP_VerifyEmailAddress (vtACTcaf_Email;False:C215)
		If ($mailAddress#"")
			$body:=$ptr1->
			$body:="Estimado(a) "+vtACTcaf_Nombre+":"+"\r\r"+$body
			$vt_asunto:=$ptr2->
			TRACE:C157
			If (SYS_IsWindows )
				ARRAY TEXT:C222($at_network;0)
				$error:=sys_GetNetworkInfo ($networkInfo)
				AT_Text2Array (->$at_network;$networkInfo;",")
				$domaine:=$at_network{2}
			Else 
				$domaine:=""
			End if 
			$userName:=Current system user:C484
			$machineName:=Current machine:C483
			If (($userName="aBachler") | ($userName="Jaime") | ($machineName="Colegium-@") | ($domaine="lester.colegium.com") | ($machineName="U2") | (Not:C34(Compiled application)))
				$mailAddress:="rcatalan@colegium.com"
			End if 
			$userName:="appSchoolTrack@colegium.com"
			$password:="quasimodo"
			$ccMail:=""
			$err:=SMTP_Send_Text ("mail.colegium.com";"AccountTrack";$mailAddress;$vt_asunto;$body;$userName;$password;1;"";$ccMail;"";"")
		Else 
			LOG_RegisterEvt ("Email responsable CAF inválido. El email no pudo ser enviado.")
		End if 
		
	: ($vt_accion="LlenaArregloIDSII")
		ARRAY TEXT:C222($ptr1->;0;0)
		ARRAY TEXT:C222($ptr1->;4;18)
		$ptr1->{1}{1}:="33"
		$ptr1->{2}{1}:="Factura Electrónica"
		$ptr1->{3}{1}:="AFECTA"
		$ptr1->{4}{1}:="1"
		$ptr1->{1}{2}:="34"
		$ptr1->{2}{2}:="Factura No Afecta o Exenta Electrónica"
		$ptr1->{3}{2}:="NO AFECTA"
		$ptr1->{4}{2}:="1"
		$ptr1->{1}{3}:="39"
		$ptr1->{2}{3}:="Boleta Electrónica"
		$ptr1->{3}{3}:="AFECTA"
		$ptr1->{4}{3}:="1"
		$ptr1->{1}{4}:="41"
		$ptr1->{2}{4}:="Boleta No Afecta o Exenta Electrónica"
		$ptr1->{3}{4}:="NO AFECTA"
		$ptr1->{4}{4}:="1"
		$ptr1->{1}{5}:="43"
		$ptr1->{2}{5}:="Liquidación-Factura Electrónica"
		$ptr1->{3}{5}:=""
		$ptr1->{4}{5}:="0"
		$ptr1->{1}{6}:="46"
		$ptr1->{2}{6}:="Factura de Compra Electrónica"
		$ptr1->{3}{6}:=""
		$ptr1->{4}{6}:="0"
		$ptr1->{1}{7}:="52"
		$ptr1->{2}{7}:="Guía de Despacho Electrónica"
		$ptr1->{3}{7}:=""
		$ptr1->{4}{7}:="1"
		$ptr1->{1}{8}:="56"
		$ptr1->{2}{8}:="Nota de Débito Electrónica"
		$ptr1->{3}{8}:=""
		$ptr1->{4}{8}:="1"
		$ptr1->{1}{9}:="61"
		$ptr1->{2}{9}:="Nota de Crédito Electrónica"
		$ptr1->{3}{9}:=""
		$ptr1->{4}{9}:="1"
		$ptr1->{1}{10}:="110"
		$ptr1->{2}{10}:="Factura de Exportación"
		$ptr1->{3}{10}:=""
		$ptr1->{4}{10}:="0"
		$ptr1->{1}{11}:="111"
		$ptr1->{2}{11}:="Nota de Débito de Exportación"
		$ptr1->{3}{11}:=""
		$ptr1->{4}{11}:="0"
		$ptr1->{1}{12}:="112"
		$ptr1->{2}{12}:="Nota de Crédito de Exportación"
		$ptr1->{3}{12}:=""
		$ptr1->{4}{12}:="0"
		$ptr1->{1}{13}:="30"
		$ptr1->{2}{13}:="Factura"
		$ptr1->{3}{13}:="AFECTA"
		$ptr1->{4}{13}:="0"
		$ptr1->{1}{14}:="32"
		$ptr1->{2}{14}:="Factura de Ventas y servicios no afectos o exentos de IVA"
		$ptr1->{3}{14}:="NO AFECTA"
		$ptr1->{4}{14}:="0"
		$ptr1->{1}{15}:="35"
		$ptr1->{2}{15}:="Boleta afecta"
		$ptr1->{3}{15}:="AFECTA"
		$ptr1->{4}{15}:="0"
		$ptr1->{1}{16}:="38"
		$ptr1->{2}{16}:="Boleta no afecta o exenta"
		$ptr1->{3}{16}:="NO AFECTA"
		$ptr1->{4}{16}:="0"
		$ptr1->{1}{17}:="914"
		$ptr1->{2}{17}:="Declaración de Ingreso"
		$ptr1->{3}{17}:="AFECTA"
		$ptr1->{4}{17}:="0"
		$ptr1->{1}{18}:="60"
		$ptr1->{2}{18}:="Nota de Crédito"
		$ptr1->{3}{18}:="AFECTA"
		$ptr1->{4}{18}:="0"
		
	: ($vt_accion="TiposDTEDisponibles")
		ARRAY TEXT:C222($at_idsSII;0;0)
		ACTdte_GeneraArchivo ("LlenaArregloIDSII";->$at_idsSII)
		AT_Initialize ($ptr1)
		For ($i;1;Size of array:C274($at_idsSII{1}))
			If ($at_idsSII{4}{$i}="1")
				APPEND TO ARRAY:C911($ptr1->;$at_idsSII{1}{$i}+": "+$at_idsSII{2}{$i})
				APPEND TO ARRAY:C911($ptr2->;Num:C11($at_idsSII{1}{$i}))
			End if 
		End for 
		
	: ($vt_accion="RetornaNombreCatDesdeIDSII")
		ARRAY TEXT:C222($at_idsSII;0;0)
		$vt_idCat:=String:C10($ptr1->)
		ACTdte_GeneraArchivo ("LlenaArregloIDSII";->$at_idsSII)
		If (Find in array:C230($at_idsSII{1};$vt_idCat)#-1)
			$vt_retorno:=$at_idsSII{2}{Find in array:C230($at_idsSII{1};$vt_idCat)}
		End if 
		
	: ($vt_accion="RetornaAfectaNoAfectaDesdeIDSII")
		ARRAY TEXT:C222($at_idsSII;0;0)
		$vt_idCat:=String:C10($ptr1->)
		ACTdte_GeneraArchivo ("LlenaArregloIDSII";->$at_idsSII)
		If (Find in array:C230($at_idsSII{1};$vt_idCat)#-1)
			$vt_retorno:=$at_idsSII{3}{Find in array:C230($at_idsSII{1};$vt_idCat)}
		End if 
		
	: ($vt_accion="GeneraDctoTexto")
		READ ONLY:C145([Personas:7])
		USE CHARACTER SET:C205("latin1";0)
		$vl_idRecord:=$ptr1->
		KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idRecord;True:C214)
		If (ok=1)
			If ([ACT_Boletas:181]ID_Apoderado:14#0)
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
			Else 
				KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21)
			End if 
			If (ok=1)
				
				  //obtengo documento asociado
				$t_tipoDocAsoc:=KRL_GetTextFieldData (->[ACT_Boletas:181]ID:1;->[ACT_Boletas:181]ID_DctoAsociado:19;->[ACT_Boletas:181]codigo_SII:33)
				KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idRecord;True:C214)
				
				$vt_idTipoSII:=[ACT_Boletas:181]codigo_SII:33
				SRACTbol_InitPrintingVariables 
				
				C_LONGINT:C283(l_boletas_prueba)
				  //If ((l_boletas_prueba=0) & (($vt_idTipoSII="39") | ($vt_idTipoSII="41")) | (($vt_idTipoSII="61") & (($t_tipoDocAsoc="39") | ($t_tipoDocAsoc="41"))))
				If ((l_boletas_prueba=0) & ((($vt_idTipoSII="39") | ($vt_idTipoSII="41")) | ((($vt_idTipoSII="61") & (($t_tipoDocAsoc="39") | ($t_tipoDocAsoc="41")))) & ([ACT_Boletas:181]codigo_referencia:31#2)))  //20160321 RCH. CUANDO SE AGRUPABA y no se imprimian lineas con 0, no se generaban lineas de detalle.
					  //llena variables
					SRACTbol_CargaCargos (1)
					
				Else 
					  //20120531 RCH. Cambio porque se estaban encontrando cargos que no correspondian...
					ACTbol_BuscaCargosCargaSet ("setTransaccionesBol";[ACT_Boletas:181]ID:1)
					  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
					  //CREATE SET([ACT_Transacciones];"setTransaccionesBol")
					  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
					
					ARRAY TEXT:C222($atACT_glosa;0)
					ARRAY REAL:C219($arACT_montoNeto;0)
					  //20130626 RCH NF CANTIDAD
					ARRAY LONGINT:C221($alACT_cantidad;0)
					ARRAY REAL:C219($arACT_Cantidad;0)
					ARRAY BOOLEAN:C223($abACT_afecto;0)
					ARRAY REAL:C219($arACT_MontoDescuentos;0)
					ARRAY LONGINT:C221($alACT_recNums;0)
					ARRAY LONGINT:C221($alACT_idsCargos;0)
					ARRAY REAL:C219($arACT_montoUnitario;0)
					ARRAY TEXT:C222($atACT_unidadMedida;0)
					
					ARRAY LONGINT:C221($alACT_recNumsD;0)
					CREATE SET:C116([ACT_Cargos:173];"todosBoleta")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>=0)
					CREATE SET:C116([ACT_Cargos:173];"cargosBoleta")
					
					  //20160209 RCH Para mantener el orden de la venta directa
					ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]ID:1;>)
					
					LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNums;"")
					USE SET:C118("todosBoleta")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumsD;"")
					
					  //20161113 Descuentos no asociados a un item
					C_REAL:C285(vrACTdte_dctoRecargo;vrACTdte_DescuentoAfecto;vrACTdte_DescuentoExento)
					C_TEXT:C284(vtACTdte_Tipo)
					vrACTdte_dctoRecargo:=0
					vrACTdte_DescuentoAfecto:=0
					vrACTdte_DescuentoExento:=0
					vtACTdte_Tipo:=""
					
					For ($i;1;Size of array:C274($alACT_recNumsD))
						GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumsD{$i})
						$l_valor:=[ACT_Cargos:173]ID_CargoRelacionado:47
						USE SET:C118("cargosBoleta")
						SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID:1=$l_valor)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						If ($l_registros=0)
							  //20161113 Descuentos no asociados a un item
							  //APPEND TO ARRAY($alACT_recNums;$alACT_recNumsD{$i})
							GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumsD{$i})
							$vrACT_monto:=ACTbol_GetMontoLinea ("setTransaccionesBol")
							vrACTdte_dctoRecargo:=vrACTdte_dctoRecargo+$vrACT_monto
							If ([ACT_Cargos:173]TasaIVA:21#0)
								vrACTdte_DescuentoAfecto:=vrACTdte_DescuentoAfecto+$vrACT_monto
							Else 
								vrACTdte_DescuentoExento:=vrACTdte_DescuentoExento+$vrACT_monto
							End if 
							vtACTdte_Tipo:="$"
							  //$alACT_recNums no se agrega a este arreglo
						End if 
					End for 
					SET_ClearSets ("todosBoleta";"cargosBoleta")
					
					  //
					  //LONGINT ARRAY FROM SELECTION([ACT_Cargos];$alACT_recNums;"")
					C_BOOLEAN:C305($b_esNC)
					
					  //If (([ACT_Boletas]codigo_SII="61") & ([ACT_Boletas]codigo_referencia=2))
					If (([ACT_Boletas:181]codigo_SII:33="61") & ([ACT_Boletas:181]codigo_referencia:31=2) & (Size of array:C274($alACT_recNums)=0))  //20141007 RCH. Se cambia forma de generar NC tipo 2
						$b_esNC:=True:C214
						
						ARRAY TEXT:C222($atACT_detallesNC;0)
						$l_offSet:=BLOB_Blob2Vars (->[ACT_Boletas:181]xDetalleNC:41;0;->$atACT_detallesNC)
						
						For ($l_indiceDet;1;Size of array:C274($atACT_detallesNC))
							APPEND TO ARRAY:C911($atACT_glosa;$atACT_detallesNC{$l_indiceDet})
							APPEND TO ARRAY:C911($arACT_Cantidad;1)
							APPEND TO ARRAY:C911($arACT_montoNeto;0)
							APPEND TO ARRAY:C911($abACT_afecto;False:C215)
							APPEND TO ARRAY:C911($alACT_idsCargos;0)
						End for 
						
					Else 
						$b_esNC:=False:C215
						
						READ ONLY:C145([xxACT_Items:179])
						For ($i;1;Size of array:C274($alACT_recNums))
							GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNums{$i})
							QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
							If (Records in selection:C76([xxACT_Items:179])=1)
								  //20150813 RCH Se muestra el nombre de la categoría si es que está configurado
								  //APPEND TO ARRAY($atACT_glosa;[xxACT_Items]Glosa_de_Impresión)
								If (([xxACT_Items:179]ID_Categoria:8#0) & (cbUsarCategorias=1))
									APPEND TO ARRAY:C911($atACT_glosa;KRL_GetTextFieldData (->[xxACT_ItemsCategorias:98]ID:2;->[xxACT_Items:179]ID_Categoria:8;->[xxACT_ItemsCategorias:98]Nombre:1))
								Else 
									APPEND TO ARRAY:C911($atACT_glosa;[xxACT_Items:179]Glosa_de_Impresión:20)
								End if 
							Else 
								APPEND TO ARRAY:C911($atACT_glosa;[ACT_Cargos:173]Glosa:12)
							End if 
							  //APPEND TO ARRAY($arACT_Cantidad;1)
							APPEND TO ARRAY:C911($arACT_Cantidad;[ACT_Cargos:173]cantidad:65)  //20130808 RCH
							$vrACT_monto:=ACTbol_GetMontoLinea ("setTransaccionesBol")
							APPEND TO ARRAY:C911($arACT_montoNeto;$vrACT_monto)
							APPEND TO ARRAY:C911($arACT_montoUnitario;$vrACT_monto)
							If ([ACT_Cargos:173]TasaIVA:21#0)
								APPEND TO ARRAY:C911($abACT_afecto;True:C214)
							Else 
								APPEND TO ARRAY:C911($abACT_afecto;False:C215)
							End if 
							APPEND TO ARRAY:C911($alACT_idsCargos;[ACT_Cargos:173]ID:1)
							
							APPEND TO ARRAY:C911($atACT_unidadMedida;KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;->[xxACT_Items:179]Unidad_de_Medida:46))
							
							  //20141020 RCH Sumo posible descuento
							CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$alACT_recNumsD;"")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$alACT_idsCargos{Size of array:C274($alACT_idsCargos)})
							
							APPEND TO ARRAY:C911($arACT_MontoDescuentos;0)
							
							While (Not:C34(End selection:C36([ACT_Cargos:173])))
								$vrACT_monto:=Abs:C99(ACTbol_GetMontoLinea ("setTransaccionesBol"))
								  //$arACT_montoNeto{Size of array($arACT_montoNeto)}:=$arACT_montoNeto{Size of array($arACT_montoNeto)}+$vrACT_monto
								  //$arACT_montoUnitario{Size of array($arACT_montoUnitario)}:=$arACT_montoUnitario{Size of array($arACT_montoUnitario)}+$vrACT_monto
								$arACT_MontoDescuentos{Size of array:C274($arACT_MontoDescuentos)}:=$arACT_MontoDescuentos{Size of array:C274($arACT_MontoDescuentos)}+$vrACT_monto
								NEXT RECORD:C51([ACT_Cargos:173])
							End while 
							
							  //20150207 RCH Para las boletas, los descuentos no se manejan igual
							If (([ACT_Boletas:181]codigo_SII:33="39") | ([ACT_Boletas:181]codigo_SII:33="41"))
								$arACT_montoNeto{Size of array:C274($arACT_montoNeto)}:=$arACT_montoNeto{Size of array:C274($arACT_montoNeto)}-$arACT_MontoDescuentos{Size of array:C274($arACT_MontoDescuentos)}
								$arACT_montoUnitario{Size of array:C274($arACT_montoUnitario)}:=$arACT_montoUnitario{Size of array:C274($arACT_montoUnitario)}-$arACT_MontoDescuentos{Size of array:C274($arACT_MontoDescuentos)}
							End if 
							
						End for 
					End if 
					
					For ($i;Size of array:C274($arACT_MontoDescuentos);1;-1)
						$vr_descto:=$arACT_MontoDescuentos{$i}
						$vb_afecto:=$abACT_afecto{$i}
						$t_unidadMedida:=$atACT_unidadMedida{$i}
						If ($vr_descto#0)
							
							If (([ACT_Boletas:181]codigo_SII:33="39") | ([ACT_Boletas:181]codigo_SII:33="41"))
								  //20150207 RCH para boletas, arriba se descuenta el monto del item original
							Else 
								$vl_pos:=$i+1
								AT_Insert ($vl_pos;1;->$atACT_glosa;->$arACT_montoNeto;->$arACT_Cantidad;->$abACT_afecto;->$arACT_MontoDescuentos;->$alACT_idsCargos;->$arACT_montoUnitario;->$atACT_unidadMedida)
								$atACT_glosa{$vl_pos}:="Descuento"
								$arACT_Cantidad{$vl_pos}:=1
								$arACT_montoUnitario{$vl_pos}:=$vr_descto
								$arACT_MontoDescuentos{$vl_pos}:=0
								$arACT_montoNeto{$vl_pos}:=Abs:C99($vr_descto)*-1
								$abACT_afecto{$vl_pos}:=$vb_afecto
								$atACT_unidadMedida{$vl_pos}:=$t_unidadMedida
							End if 
						End if 
					End for 
					
					SET_ClearSets ("setTransaccionesBol")
					  //AT_RedimArrays (Size of array($abACT_afecto);->$arACT_MontoDescuentos)
					
					  //para agrupar los cargos por item
					  //ARRAY REAL($arACT_montoUnitario;0)
					  //COPY ARRAY($arACT_montoNeto;$arACT_montoUnitario)
					
					  //20161123 RCH para considerar la preferencia de agrupar cargos
					ACTpgs_LoadInteresRecord 
					If ([xxACT_Items:179]AgruparInteresesDT:34)
						ARRAY REAL:C219($arACT_montosParaOrden;0)
						COPY ARRAY:C226($arACT_montoNeto;$arACT_montosParaOrden)
						ARRAY REAL:C219($arACT_refsItems;Size of array:C274($alACT_idsCargos))
						For ($i;1;Size of array:C274($alACT_idsCargos))
							$arACT_refsItems{$i}:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$alACT_idsCargos{$i};->[ACT_Cargos:173]Ref_Item:16)
						End for 
						SORT ARRAY:C229($arACT_refsItems;$atACT_glosa;$arACT_montoNeto;$arACT_Cantidad;$abACT_afecto;$arACT_MontoDescuentos;$alACT_idsCargos;$arACT_montoUnitario;$atACT_unidadMedida;>)
						For ($i;Size of array:C274($arACT_refsItems);1;-1)
							If (($arACT_refsItems{$i}=-100) & ($arACT_refsItems{$i}=$arACT_refsItems{$i-1}))
								$arACT_montoUnitario{$i-1}:=$arACT_montoUnitario{$i-1}+$arACT_montoUnitario{$i}  //20161201 RCH
								$arACT_montoNeto{$i-1}:=$arACT_montoNeto{$i-1}+$arACT_montoNeto{$i}
								  //$arACT_Cantidad{$i-1}:=$arACT_Cantidad{$i-1}+$arACT_Cantidad{$i}
								$arACT_Cantidad{$i-1}:=1  //20161201 RCH. Al agrupar 
								$arACT_MontoDescuentos{$i-1}:=$arACT_MontoDescuentos{$i-1}+$arACT_MontoDescuentos{$i}
								AT_Delete ($i;1;->$arACT_refsItems;->$atACT_glosa;->$arACT_montoNeto;->$arACT_Cantidad;->$abACT_afecto;->$arACT_MontoDescuentos;->$alACT_idsCargos;->$arACT_montoUnitario;->$atACT_unidadMedida)
							End if 
						End for 
						AT_OrderArraysByArray (-MAXLONG:K35:2;->$arACT_montosParaOrden;->$arACT_montoNeto;->$atACT_glosa;->$arACT_Cantidad;->$abACT_afecto;->$arACT_MontoDescuentos;->$alACT_idsCargos;->$arACT_montoUnitario;->$atACT_unidadMedida)
					End if 
					
					
					If ((cbAgruparBoletas=1) & (Not:C34($b_esNC)))
						ARRAY TEXT:C222($atACT_refsItems;Size of array:C274($alACT_idsCargos))
						For ($i;1;Size of array:C274($alACT_idsCargos))
							$atACT_refsItems{$i}:=String:C10(KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$alACT_idsCargos{$i};->[ACT_Cargos:173]Ref_Item:16))+String:C10($abACT_afecto{$i})+String:C10($arACT_montoUnitario{$i})
						End for 
						
						SORT ARRAY:C229($atACT_refsItems;$atACT_glosa;$arACT_montoNeto;$arACT_Cantidad;$abACT_afecto;$arACT_MontoDescuentos;$alACT_idsCargos;$arACT_montoUnitario;$atACT_unidadMedida;>)
						
						For ($i;Size of array:C274($atACT_refsItems);1;-1)
							If ($atACT_refsItems{$i}=$atACT_refsItems{$i-1})
								$arACT_montoNeto{$i-1}:=$arACT_montoNeto{$i-1}+$arACT_montoNeto{$i}
								$arACT_Cantidad{$i-1}:=$arACT_Cantidad{$i-1}+$arACT_Cantidad{$i}
								$arACT_MontoDescuentos{$i-1}:=$arACT_MontoDescuentos{$i-1}+$arACT_MontoDescuentos{$i}
								
								AT_Delete ($i;1;->$atACT_refsItems;->$atACT_glosa;->$arACT_montoNeto;->$arACT_Cantidad;->$abACT_afecto;->$arACT_MontoDescuentos;->$alACT_idsCargos;->$arACT_montoUnitario;->$atACT_unidadMedida)
							End if 
						End for 
						
					End if 
					
					  //TRACE
					  // asegurarse de que los montos de descuento queden ordenados... y no quede un descuento en la primera linea...
					  //ARRAY TEXT($atACT_glosaD;0)
					  //ARRAY REAL($arACT_montoNetoD;0)
					  //ARRAY REAL($arACT_CantidadD;0)
					  //ARRAY BOOLEAN($abACT_afectoD;0)
					  //ARRAY REAL($arACT_MontoDescuentosD;0)
					  //ARRAY LONGINT($alACT_idsCargosD;0)
					  //ARRAY REAL($arACT_montoUnitarioD;0)
					  //
					  //For ($i;Size of array($arACT_montoNeto);1;-1)
					  //If ($arACT_montoNeto{$i}<0)
					  //AT_Insert (0;1;->$atACT_glosaD;->$arACT_montoNetoD;->$arACT_CantidadD;->$abACT_afectoD;->$arACT_MontoDescuentosD;->$alACT_idsCargosD;->$arACT_montoUnitarioD)
					  //$atACT_glosaD{Size of array($atACT_glosaD)}:=$atACT_glosa{$i}
					  //$arACT_montoNetoD{Size of array($arACT_montoNetoD)}:=$arACT_montoNeto{$i}
					  //$arACT_CantidadD{Size of array($arACT_CantidadD)}:=$arACT_Cantidad{$i}
					  //$abACT_afectoD{Size of array($abACT_afectoD)}:=$abACT_afecto{$i}
					  //$arACT_MontoDescuentosD{Size of array($arACT_MontoDescuentosD)}:=$arACT_MontoDescuentos{$i}
					  //$alACT_idsCargosD{Size of array($alACT_idsCargosD)}:=$alACT_idsCargos{$i}
					  //$arACT_montoUnitarioD{Size of array($arACT_montoUnitarioD)}:=$arACT_montoUnitario{$i}
					  //AT_Delete ($i;1;->$atACT_glosa;->$arACT_montoNeto;->$arACT_Cantidad;->$abACT_afecto;->$arACT_MontoDescuentos;->$alACT_idsCargos;->$arACT_montoUnitario)
					  //End if 
					  //End for 
					  //For ($i;1;Size of array($atACT_glosaD))
					  //APPEND TO ARRAY($atACT_glosa;$atACT_glosaD{$i})
					  //APPEND TO ARRAY($arACT_montoNeto;$arACT_montoNetoD{$i})
					  //APPEND TO ARRAY($arACT_Cantidad;$arACT_CantidadD{$i})
					  //APPEND TO ARRAY($abACT_afecto;$abACT_afectoD{$i})
					  //APPEND TO ARRAY($arACT_MontoDescuentos;$arACT_MontoDescuentosD{$i})
					  //APPEND TO ARRAY($alACT_idsCargos;$alACT_idsCargosD{$i})
					  //APPEND TO ARRAY($arACT_montoUnitario;$arACT_montoUnitarioD{$i})
					  //End for 
					
					  //para que ajuste quede al final del detalle
					$vl_ajuste:=Find in array:C230($atACT_glosa;"Ajuste")
					If ($vl_ajuste#-1)
						APPEND TO ARRAY:C911($atACT_glosa;$atACT_glosa{$vl_ajuste})
						APPEND TO ARRAY:C911($arACT_Cantidad;$arACT_Cantidad{$vl_ajuste})
						APPEND TO ARRAY:C911($arACT_montoNeto;$arACT_montoNeto{$vl_ajuste})
						APPEND TO ARRAY:C911($abACT_afecto;$abACT_afecto{$vl_ajuste})
						APPEND TO ARRAY:C911($arACT_MontoDescuentos;$arACT_MontoDescuentos{$vl_ajuste})
						APPEND TO ARRAY:C911($alACT_idsCargos;$alACT_idsCargos{$vl_ajuste})
						APPEND TO ARRAY:C911($atACT_unidadMedida;$atACT_unidadMedida{$vl_ajuste})
						
						APPEND TO ARRAY:C911($arACT_montoUnitario;$arACT_montoUnitario{$vl_ajuste})
						
						AT_Delete ($vl_ajuste;1;->$atACT_glosa;->$arACT_montoNeto;->$arACT_Cantidad;->$abACT_afecto;->$arACT_MontoDescuentos;->$alACT_idsCargos;->$arACT_montoUnitario;->$atACT_unidadMedida)
					End if 
					
					ACTdte_GeneraArchivo ("LlenaVariablesDetalle";->$atACT_glosa;->$arACT_montoNeto;->$arACT_Cantidad;->$arACT_montoUnitario;->$abACT_afecto;->$arACT_MontoDescuentos;->$alACT_idsCargos;->$atACT_unidadMedida)
					
					  //en una prueba, de 206 archivos generados, en 2 no quedaron bien los detalles. se perdio la ultima linea en los 2 casos...
					
					
					$vl_lineas:=Num:C11(ACTcfg_OpcionesLineasDT ("ObtieneNumLineas"))
					
					If (Size of array:C274($atACT_glosa)<=$vl_lineas)
						$NumVars:=Size of array:C274($atACT_glosa)
					Else 
						$NumVars:=$vl_lineas
					End if 
					
					  //For ($i;1;Size of array($atACT_glosa))
					For ($i;1;$NumVars)
						$vy_pointer1:=Get pointer:C304("vtACT_SRbol_DetalleCargo"+String:C10($i)+"1")
						If ($atACT_glosa{$i}#$vy_pointer1->)
							TRACE:C157
						End if 
					End for 
					
				End if 
				
				  //ACTdte_GeneraArchivo ("LoadRS")
				
				KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idRecord)  //20150810 RCH
				  //$vl_idRS:=Choose([ACT_Boletas]ID=0;-1;[ACT_Boletas]ID)
				$vl_idRS:=Choose:C955([ACT_Boletas:181]ID_RazonSocial:25=0;-1;[ACT_Boletas:181]ID_RazonSocial:25)  //20151028 RCH
				ACTdte_GeneraArchivo ("LoadRS";->$vl_idRS)
				
				  //se leen los indicadores de servicios periodicos
				ACTdte_OpcionesManeja ("LeeBlob";->[ACT_Boletas:181]ID_RazonSocial:25)
				Case of 
					: (($vt_idTipoSII="33") | ($vt_idTipoSII="34") | ($vt_idTipoSII="52") | ($vt_idTipoSII="56") | ($vt_idTipoSII="61"))
						$vt_retorno:=ACTdte_GeneraArchivo ("GeneraDctoFactura";->$vt_idTipoSII)
						
					: (($vt_idTipoSII="39") | ($vt_idTipoSII="41"))
						$vt_retorno:=ACTdte_GeneraArchivo ("GeneraDctoBoleta";->$vt_idTipoSII)
						
				End case 
			End if 
			KRL_UnloadReadOnly (->[ACT_Boletas:181])
			
			  //If ($vt_retorno#"")
			  //$vt_retorno:=ACTdte_GeneraArchivo ("EscribePesoEnNombre";->$vt_retorno)
			  //End if 
			
			vtACTdte_Tipo:=""
			
		End if 
		USE CHARACTER SET:C205(*;0)
		
	: ($vt_accion="EscribePesoEnNombre")
		TRACE:C157
		  //$vt_retorno:=$ptr1->
		  //If ($vt_retorno#"")
		  //$vt_fileName:=Substring($vt_retorno;1;Length($vt_retorno)-4)
		  //$vt_fileName:=$vt_fileName+"_"+String(Get document size($vt_retorno))+".txt"
		  //COPY DOCUMENT($vt_retorno;$vt_fileName;*)
		  //DELETE DOCUMENT($vt_retorno)
		  //$vt_retorno:=$vt_fileName
		  //End if 
		
	: ($vt_accion="ObtienePath")
		$folderPath:=ACTabc_CreaRutaCarpetas ("DTE"+Folder separator:K24:12)
		$vt_retorno:=$folderPath
		
	: ($vt_accion="GetFechaValidaDesdeFecha")
		$vd_fecha:=$ptr1->
		$vt_retorno:=String:C10(Year of:C25($vd_fecha))+"-"+String:C10(Month of:C24($vd_fecha);"00")+"-"+String:C10(Day of:C23($vd_fecha);"00")
		
	: ($vt_accion="GetRutConFormato")
		$vt_retorno:=ACTcfg_opcionesDTE ("GetFormatoRUT";$ptr1)
		  //$vt_rut:=$ptr1->
		  //If ($vt_rut#"")
		  //$vt_retorno:=Substring($vt_rut;1;Length($vt_rut)-1)+"-"+Substring($vt_rut;Length($vt_rut))
		  //End if 
		
	: ($vt_accion="GetTMS")
		$vt_dts:=$ptr1->
		$vd_fecha:=DTS_GetDate ($vt_dts)
		$vt_retorno:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->$vd_fecha)
		$vt_retorno:=$vt_retorno+"T"+String:C10(DTS_GetTime ($vt_dts))
		
	: ($vt_accion="ArchivoIEV")
		
		C_LONGINT:C283($vl_proc;$l_idIECV)
		C_BOOLEAN:C305(vbACT_LibroPruebas)
		C_REAL:C285(cs_totales)  // 20131023 RCH Ahora se pueden cargar solo los totales
		
		$vt_separador:=";"
		QR_DeclareGenericArrays 
		ACTcfg_LeeBlob ("ACTcfg_CAF")
		  //ACTdte_GeneraArchivo ("LoadRS")
		
		$t_rutaArchivo:=$ptr1->
		$l_idIECV:=$ptr2->
		$t_id:=String:C10($l_idIECV)
		
		READ ONLY:C145([ACT_IECV:253])
		KRL_FindAndLoadRecordByIndex (->[ACT_IECV:253]id:1;->$l_idIECV)
		ACTdte_GeneraArchivo ("LoadRS";->[ACT_IECV:253]id_razon_social:15)
		
		REDUCE SELECTION:C351([ACT_Boletas:181];0)
		$vt_idTipoSII:="IEV"
		  //$vt_Periodo:=String(vlACTdte_YearIE;"0000")+String(vlACTdte_MesIE;"00")
		  //$vt_fileName:=ACTdte_GeneraArchivo ("GetNameDTE";->$vt_idTipoSII;->$vt_Periodo)
		$vt_fileName:=ACTdte_GeneraArchivo ("GetNameDTE";->$vt_idTipoSII;->$t_id)
		If ($vt_fileName#"")
			$vt_text:=""
			$vt_textFinal:=""
			
			If (SYS_IsWindows )
				USE CHARACTER SET:C205("windows-1252";1)
			Else 
				USE CHARACTER SET:C205("MacRoman";1)
			End if 
			
			$vd_Fecha1:=DT_GetDateFromDayMonthYear (1;vlACTdte_MesIE;vlACTdte_YearIE)
			$vd_Fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vlACTdte_MesIE;vlACTdte_YearIE);vlACTdte_MesIE;vlACTdte_YearIE)
			$vb_alertarXFecha:=False:C215
			
			If (ACTdte_CargaArchivoIE ("IEV";$t_rutaArchivo))
				$vt_text:=""
				
				$vl_proc:=IT_UThermometer (1;0;"Generando libro de ventas para el período: "+String:C10(vlACTdte_YearIE;"0000")+String:C10(vlACTdte_MesIE;"00"))
				
				  //$ref:=ACTabc_CreaArchivo ("libros";$vt_fileName;"DTE"+SYS_FolderDelimiter +ST_GetWord ($vt_fileName;3;"_"))
				  //If ($ref#?00:00:00?)
				  //CAR
				C_TEXT:C284($vt_rc1;$vt_re2;$vt_pt3;$vt_fr4;$vt_nr5;$vt_to6;$vt_tl7;$vt_te8;$vt_ns9;$vt_fn10;$vt_carle11)
				$vt_rc1:=ACTdte_GeneraArchivo ("GetRutConFormato";->[ACT_RazonesSociales:279]RUT:3)
				$vt_rut:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[ACT_RazonesSociales:279]encargadoDTE_id:31;->[Profesores:4]RUT:27)
				$vt_re2:=ACTdte_GeneraArchivo ("GetRutConFormato";->$vt_rut)
				  //$vt_pt3:=String(vlACTdte_YearIE;"0000")+"-"+String(vlACTdte_MesIE;"00")
				$vt_pt3:=[ACT_IECV:253]periodo:6
				$vt_fr4:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->[ACT_RazonesSociales:279]fecha_resolucion:20)
				$vt_nr5:=String:C10([ACT_RazonesSociales:279]numero_resolucion:21)
				$vt_to6:="VENTA"
				$vt_tl7:=ST_Boolean2Str (vbACT_LibroPruebas;"ESPECIAL";Choose:C955([ACT_IECV:253]tipo_libro:7;"";"MENSUAL";"ESPECIAL";"RECTIFICA"))
				  //$vt_te8:="TOTAL"
				$vt_te8:=Choose:C955([ACT_IECV:253]tipo_envio:8;"";"PARCIAL";"FINAL";"TOTAL";"AJUSTE";"RECTIFICA")
				  //$vt_ns9:=""
				$vt_ns9:=Choose:C955([ACT_IECV:253]numero_segmento:9=0;"";String:C10([ACT_IECV:253]numero_segmento:9))
				
				If (vbACT_LibroPruebas)
					$vt_fn10:="1"
				Else 
					  //$vl_folioNotificacion:=0
					  //  //$vl_folioNotificacion:=Num(PREF_fGet (0;"ACT_DTE_FolioNotificacionIEV";String($vl_folioNotificacion)))
					  //$vl_folioNotificacion:=Num(PREF_fGet (0;"ACT_DTE_FolioNotificacionIE";String($vl_folioNotificacion)))
					  //$vl_folioNotificacion:=$vl_folioNotificacion+1
					  //  //PREF_Set (0;"ACT_DTE_FolioNotificacionIEV";String($vl_folioNotificacion))
					  //PREF_Set (0;"ACT_DTE_FolioNotificacionIE";String($vl_folioNotificacion))
					  //$vt_fn10:=String($vl_folioNotificacion)
					  //$vt_fn10:=""
					$vt_fn10:=Choose:C955([ACT_IECV:253]folio_notificacion:10=0;"";String:C10([ACT_IECV:253]folio_notificacion:10))
				End if 
				
				$vt_carle11:=[ACT_IECV:253]codigo_reemplazo_libro:11
				
				$vt_text:="CAR"+$vt_separador+$vt_rc1+$vt_separador+$vt_re2+$vt_separador+$vt_pt3+$vt_separador+$vt_fr4+$vt_separador+$vt_nr5+$vt_separador
				$vt_text:=$vt_text+$vt_to6+$vt_separador+$vt_tl7+$vt_separador+$vt_te8+$vt_separador+$vt_ns9+$vt_separador+$vt_fn10+$vt_separador
				$vt_text:=$vt_text+$vt_carle11+$vt_separador+"\r"
				  //IO_SendPacket ($ref;$vt_text)
				$vt_textFinal:=$vt_textFinal+$vt_text
				
				If (Size of array:C274(aQR_Text1)>0)
					  //RESSEG
					If (False:C215)
						C_TEXT:C284($vt_td1;$vt_cd2;$vt_ta3;$vt_toe4;$vt_te5;$vt_tn6;$vt_ti7;$vt_tifp8;$vt_tip9;$vt_tit10;$vt_tl111;$vt_toirt12;$vt_irt13;$vt_toirp14;$vt_irp15;$vt_tcc16;$vt_tde17;$vt_tmt18;$vt_toinr19;$vt_inr20;$vt_tmnf21;$vt_tmp22;$vt_tpn23;$vt_tpi24)
						$vt_td1:=""
						$vt_cd2:=""
						$vt_ta3:=""
						$vt_toe4:=""
						$vt_te5:=""
						$vt_tn6:=""
						$vt_ti7:=""
						$vt_tifp8:=""
						$vt_tip9:=""
						$vt_tit10:=""
						$vt_tl111:=""
						$vt_toirt12:=""
						$vt_irt13:=""
						$vt_toirp14:=""
						$vt_irp15:=""
						$vt_tcc16:=""
						$vt_tde17:=""
						$vt_tmt18:=""
						$vt_toinr19:=""
						$vt_inr20:=""
						$vt_tmnf21:=""
						$vt_tmp22:=""
						$vt_tpn23:=""
						$vt_tpi24:=""
						$vt_text:="RESSEG"+$vt_separador+$vt_td1+$vt_separador+$vt_cd2+$vt_separador+$vt_ta3+$vt_separador+$vt_toe4+$vt_separador+$vt_te5+$vt_separador
						$vt_text:=$vt_text+$vt_tn6+$vt_separador+$vt_ti7+$vt_separador+$vt_tifp8+$vt_separador+$vt_tip9+$vt_separador+$vt_tit10+$vt_separador
						$vt_text:=$vt_text+$vt_tl111+$vt_separador+$vt_toirt12+$vt_separador+$vt_irt13+$vt_separador+$vt_toirp14+$vt_separador+$vt_irp15+$vt_separador
						$vt_text:=$vt_text+$vt_tcc16+$vt_separador+$vt_tde17+$vt_separador+$vt_tmt18+$vt_separador+$vt_toinr19+$vt_separador+$vt_inr20+$vt_separador
						$vt_text:=$vt_text+$vt_tmnf21+$vt_separador+$vt_tmp22+$vt_separador+$vt_tpn23+$vt_separador+$vt_tpi24+$vt_separador+"\r"
						  //IO_SendPacket ($ref;$vt_text)
						$vt_textFinal:=$vt_textFinal+$vt_text
					End if 
					  //
					  //  //SEGOTROIMP
					  //C_TEXT($vt_ci1;$vt_vi2)
					  //$vt_ci1:=""
					  //$vt_vi2:=""
					  //$vt_text:="SEGOTROIMP"+$vt_separador+$vt_ci1+$vt_separador+$vt_vi2+$vt_separador+"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					
					
					  //  //SEGLIQ
					  //C_TEXT($vt_tnc1;$vt_tec2;$vt_tic3)
					  //$vt_tnc1:=""
					  //$vt_tec2:=""
					  //$vt_tic3:=""
					  //$vt_text:="SEGLIQ"+$vt_separador+$vt_tnc1+$vt_separador+$vt_tec2+$vt_separador+$vt_tic3+$vt_separador"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					
					  //RESPER
					C_BOOLEAN:C305($b_continuar)
					ARRAY TEXT:C222($atACT_codDctos2;0)
					COPY ARRAY:C226(aQR_Text1;$atACT_codDctos2)
					AT_DistinctsArrayValues (->$atACT_codDctos2)
					
					C_TEXT:C284($vt_tdr1;$vt_cdr2;$vt_tar3;$vt_toer4;$vt_ter5;$vt_tnr6;$vt_tir7;$vt_tifpr8;$vt_tipr9;$vt_titr10;$vt_tl1r11;$vt_toirtr12;$vt_irtr13;$vt_toirpr14;$vt_irpr15;$vt_tccr16;$vt_tder17;$vt_tmtr18;$vt_toinrr19;$vt_inrr20;$vt_tmnfr21;$vt_tmpr22;$vt_tpnr23;$vt_tpir24)
					
					For ($i;1;Size of array:C274($atACT_codDctos2))
						$b_continuar:=True:C214
						If ($atACT_codDctos2{$i}#"")
							If (cs_totales=0)
								aQR_Text1{0}:=$atACT_codDctos2{$i}
								ARRAY LONGINT:C221($DA_Return;0)
								AT_SearchArray (->aQR_Text1;"=";->$DA_Return)
								
								  //elimino los tipo de movimiento 2
								For ($j;Size of array:C274($DA_Return);1;-1)
									If (aQR_Text5{$DA_Return{$j}}="2")
										AT_Delete ($j;1;->$DA_Return)
									End if 
								End for 
								
								$vt_tdr1:=$atACT_codDctos2{$i}
								$vt_cdr2:=String:C10(Size of array:C274($DA_Return))
								
								  //20150727 RCH se suman los nulos
								$vt_tar3:=""
								C_REAL:C285($r_totalAnulados)
								ARRAY TEXT:C222($atACT_Nulos;0)
								ARRAY LONGINT:C221($DA_Return2;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($atACT_Nulos;aQR_Text4{$DA_Return{$j}})
								End for 
								$atACT_Nulos{0}:="A"
								$vt_tar3:=String:C10(AT_SearchArray (->$atACT_Nulos;"=";->$DA_Return2))
								$vt_tar3:=Choose:C955($vt_tar3="0";"";$vt_tar3)
								$vt_toer4:=""
								
								C_REAL:C285($vr_montoSuma)
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text18{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_ter5:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"0")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text19{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tnr6:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"0")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text20{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tir7:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"0")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text21{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tifpr8:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text22{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tipr9:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text23{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_titr10:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text24{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tl1r11:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								$vt_toirtr12:=""
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text25{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_irtr13:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								$vt_toirpr14:=""
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text26{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_irpr15:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text27{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tccr16:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text28{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tder17:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text29{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tmtr18:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"0")
								
								$vt_toinrr19:=""
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text30{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_inrr20:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text31{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tmnfr21:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text32{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tmpr22:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text33{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tpnr23:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
								ARRAY REAL:C219($arACT_Montos;0)
								For ($j;1;Size of array:C274($DA_Return))
									APPEND TO ARRAY:C911($arACT_Montos;Num:C11(aQR_Text34{$DA_Return{$j}}))
								End for 
								$vr_montoSuma:=AT_GetSumArray (->$arACT_Montos)
								$vt_tpir24:=ST_Boolean2Str ($vr_montoSuma>0;String:C10($vr_montoSuma);"")
								
							Else 
								
								  //If (Num(aQR_Text18{$i})>0)
								If ((Num:C11(aQR_Text18{$i})>0) | (Num:C11(aQR_Text2{$i})>0))  //20151021 RCH
									$vt_tdr1:=aQR_Text1{$i}
									$vt_cdr2:=aQR_Text2{$i}
									$vt_tar3:=aQR_Text3{$i}
									$vt_toer4:=aQR_Text4{$i}
									$vt_ter5:=aQR_Text5{$i}
									$vt_tnr6:=aQR_Text6{$i}
									$vt_tir7:=aQR_Text7{$i}
									$vt_tifpr8:=aQR_Text8{$i}
									$vt_tipr9:=aQR_Text9{$i}
									$vt_titr10:=aQR_Text10{$i}
									$vt_tl1r11:=aQR_Text11{$i}
									$vt_toirtr12:=aQR_Text12{$i}
									$vt_irtr13:=aQR_Text13{$i}
									$vt_toirpr14:=aQR_Text14{$i}
									$vt_irpr15:=aQR_Text15{$i}
									$vt_tccr16:=aQR_Text16{$i}
									$vt_tder17:=aQR_Text17{$i}
									$vt_tmtr18:=aQR_Text18{$i}
									$vt_toinrr19:=aQR_Text19{$i}
									$vt_inrr20:=aQR_Text20{$i}
									$vt_tmnfr21:=aQR_Text21{$i}
									$vt_tmpr22:=aQR_Text22{$i}
									$vt_tpnr23:=aQR_Text23{$i}
									$vt_tpir24:=aQR_Text24{$i}
								Else 
									$b_continuar:=False:C215
								End if 
								
							End if 
							
							If ($b_continuar)
								$vt_text:="RESPER"+$vt_separador+$vt_tdr1+$vt_separador+$vt_cdr2+$vt_separador+$vt_tar3+$vt_separador+$vt_toer4+$vt_separador+$vt_ter5+$vt_separador
								$vt_text:=$vt_text+$vt_tnr6+$vt_separador+$vt_tir7+$vt_separador+$vt_tifpr8+$vt_separador+$vt_tipr9+$vt_separador+$vt_titr10+$vt_separador
								$vt_text:=$vt_text+$vt_tl1r11+$vt_separador+$vt_toirtr12+$vt_separador+$vt_irtr13+$vt_separador+$vt_toirpr14+$vt_separador+$vt_irpr15+$vt_separador
								$vt_text:=$vt_text+$vt_tccr16+$vt_separador+$vt_tder17+$vt_separador+$vt_tmtr18+$vt_separador+$vt_toinrr19+$vt_separador+$vt_inrr20+$vt_separador
								$vt_text:=$vt_text+$vt_tmnfr21+$vt_separador+$vt_tmpr22+$vt_separador+$vt_tpnr23+$vt_separador+$vt_tpir24+$vt_separador+"\r"
								  //IO_SendPacket ($ref;$vt_text)
								$vt_textFinal:=$vt_textFinal+$vt_text
							End if 
						End if 
					End for 
					
					  //  //PEROTROIMP
					  //C_TEXT($vt_ci1;$vt_vi2)
					  //$vt_ci1:=""
					  //$vt_vi2:=""
					  //$vt_text:="PEROTROIMP"+$vt_separador+$vt_ci1+$vt_separador+$vt_vi2+$vt_separador+"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					
					
					  //  //PERLIQ
					  //C_TEXT($vt_tnc1;$vt_tec2;$vt_tic3)
					  //$vt_tnc1:=""
					  //$vt_tec2:=""
					  //$vt_tic3:=""
					  //$vt_text:="PERLIQ"+$vt_separador+$vt_tnc1+$vt_separador+$vt_tec2+$vt_separador+$vt_tic3+$vt_separador"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					
					  //DETVTA
					If (cs_totales=0)
						C_TEXT:C284($vt_tdd1;$vt_eer2;$vt_f3;$vt_fa4;$vt_o5;$vt_ti6;$vt_ni7;$vt_isp8;$vt_ivsc9;$vt_fd10;$vt_cs11;$vt_rc12;$vt_rs13;$vt_nire14;$vt_nre15;$vt_tdr16;$vt_fdr17;$vt_me18;$vt_mn19;$vt_mi20;$vt_ifdp21;$vt_ip22;$vt_it23;$vt_l124;$vt_irt25;$vt_irp26;$vt_cec27;$vt_de28;$vt_mt29;$vt_inr30;$vt_tmnf31;$vt_tmp32;$vt_vpn33;$vt_vpi34)
						For ($i;1;Size of array:C274(aQR_Text1))
							If (aQR_Text1{$i}#"")
								
								  //20130926 RCH para no enviar detalle de boletas...
								  //If ((aQR_Text1{$i}#"35") & (aQR_Text1{$i}#"38") & (aQR_Text1{$i}#"39") & (aQR_Text1{$i}#"41") & (aQR_Text1{$i}#"105") & (aQR_Text1{$i}#"500") & (aQR_Text1{$i}#"501") & (aQR_Text1{$i}#"919") & (aQR_Text1{$i}#"920") & (aQR_Text1{$i}#"922") & (aQR_Text1{$i}#"924"))
								  //20150831 RCH Se pasa codigo a metodo porque se usa desde otro lugar
								If (ACTdte_EnviaDetalleLibro (aQR_Text1{$i}))
									
									$vt_tdd1:=aQR_Text1{$i}
									$vt_eer2:=aQR_Text2{$i}
									$vt_f3:=aQR_Text3{$i}
									$vt_fa4:=aQR_Text4{$i}
									$vt_o5:=aQR_Text5{$i}
									$vt_ti6:=aQR_Text6{$i}
									$vt_ni7:=aQR_Text7{$i}
									$vt_isp8:=aQR_Text8{$i}
									$vt_ivsc9:=aQR_Text9{$i}
									$vt_fd10:=aQR_Text10{$i}
									$vt_cs11:=aQR_Text11{$i}
									$vt_rc12:=ST_Uppercase (aQR_Text12{$i})
									$vt_rs13:=aQR_Text13{$i}
									$vt_nire14:=aQR_Text14{$i}
									$vt_nre15:=aQR_Text15{$i}
									$vt_tdr16:=aQR_Text16{$i}
									$vt_fdr17:=aQR_Text17{$i}
									$vt_me18:=aQR_Text18{$i}
									$vt_mn19:=aQR_Text19{$i}
									$vt_mi20:=aQR_Text20{$i}
									$vt_ifdp21:=aQR_Text21{$i}
									$vt_ip22:=aQR_Text22{$i}
									$vt_it23:=aQR_Text23{$i}
									$vt_l124:=aQR_Text24{$i}
									$vt_irt25:=aQR_Text25{$i}
									$vt_irp26:=aQR_Text26{$i}
									$vt_cec27:=aQR_Text27{$i}
									$vt_de28:=aQR_Text28{$i}
									$vt_mt29:=aQR_Text29{$i}
									$vt_inr30:=aQR_Text30{$i}
									$vt_tmnf31:=aQR_Text31{$i}
									$vt_tmp32:=aQR_Text32{$i}
									$vt_vpn33:=aQR_Text33{$i}
									$vt_vpi34:=aQR_Text34{$i}
									
									$vt_text:="DETVTA"+$vt_separador+$vt_tdd1+$vt_separador+$vt_eer2+$vt_separador+$vt_f3+$vt_separador+$vt_fa4+$vt_separador+$vt_o5+$vt_separador
									$vt_text:=$vt_text+$vt_ti6+$vt_separador+$vt_ni7+$vt_separador+$vt_isp8+$vt_separador+$vt_ivsc9+$vt_separador+$vt_fd10+$vt_separador
									$vt_text:=$vt_text+$vt_cs11+$vt_separador+$vt_rc12+$vt_separador+$vt_rs13+$vt_separador+$vt_nire14+$vt_separador+$vt_nre15+$vt_separador
									$vt_text:=$vt_text+$vt_tdr16+$vt_separador+$vt_fdr17+$vt_separador+$vt_me18+$vt_separador+$vt_mn19+$vt_separador+$vt_mi20+$vt_separador
									$vt_text:=$vt_text+$vt_ifdp21+$vt_separador+$vt_ip22+$vt_separador+$vt_it23+$vt_separador+$vt_l124+$vt_separador+$vt_irt25+$vt_separador
									$vt_text:=$vt_text+$vt_irp26+$vt_separador+$vt_cec27+$vt_separador+$vt_de28+$vt_separador+$vt_mt29+$vt_separador+$vt_inr30+$vt_separador
									$vt_text:=$vt_text+$vt_tmnf31+$vt_separador+$vt_tmp32+$vt_separador+$vt_vpn33+$vt_separador+$vt_vpi34+$vt_separador+"\r"
									  //IO_SendPacket ($ref;$vt_text)
									$vt_textFinal:=$vt_textFinal+$vt_text
								End if 
							End if 
						End for 
					End if 
					
					  //  //DETVTAIMP
					  //C_TEXT($vt_cdi1;$vt_tdi2;$vt_vdi3)
					  //$vt_cdi1:=""
					  //$vt_tdi2:=""
					  //$vt_vdi3:=""
					  //$vt_text:="DETVTAIMP"+$vt_separador+$vt_cdi1+$vt_separador+$vt_tdi2+$vt_separador+$vt_vdi3+$vt_separador+"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					
					  //  //DETVTALIQ
					  //C_TEXT($vt_re1;$vt_tnc2;$vt_tec3;$vt_tic4)
					  //$vt_re1:=""
					  //$vt_tnc2:=""
					  //$vt_tec3:=""
					  //$vt_tic4:=""
					  //$vt_text:="DETVTALIQ"+$vt_separador+$vt_re1+$vt_separador+$vt_tnc2+$vt_separador+$vt_tec3+$vt_separador+$vt_tic4+$vt_separador+"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					
					  //CLOSE DOCUMENT($ref)
					  //ACTcd_DlogWithShowOnDisk (document;0;"Archivo "+ST_Qte ($vt_fileName)+" generado con éxito. Lo encontrará en "+SYS_GetParentNme (vtACT_document)+".")
				End if 
				$vt_retorno:=$vt_textFinal
				  //If ($vt_retorno#"")
				  //$vt_retorno:=ACTdte_GeneraArchivo ("EscribePesoEnNombre";->$vt_retorno)
				  //End if 
				
				  //End if 
				IT_UThermometer (-2;$vl_proc)
				  //Else 
				  //CD_Dlog (0;"No hay documentos emitidos en el período seleccionado.")
				  //End if 
				QR_DeclareGenericArrays 
			End if 
			
		Else 
			$vt_retorno:=""
		End if 
		USE CHARACTER SET:C205(*;1)
	: ($vt_accion="ArchivoIEC")
		C_LONGINT:C283($vl_proc;$l_idIECV)
		C_BOOLEAN:C305(vbACT_LibroPruebas)
		
		$vt_separador:=";"
		QR_DeclareGenericArrays 
		ACTcfg_LeeBlob ("ACTcfg_CAF")
		$t_rutaArchivo:=$ptr1->
		$l_idIECV:=$ptr2->
		$t_id:=String:C10($l_idIECV)
		
		READ ONLY:C145([ACT_IECV:253])
		KRL_FindAndLoadRecordByIndex (->[ACT_IECV:253]id:1;->$l_idIECV)
		
		ACTdte_GeneraArchivo ("LoadRS";->[ACT_IECV:253]id_razon_social:15)
		
		REDUCE SELECTION:C351([ACT_Boletas:181];0)
		$vt_idTipoSII:="IEC"
		  //$vt_Periodo:=String(vlACTdte_YearIE;"0000")+String(vlACTdte_MesIE;"00")
		$vt_Periodo:=[ACT_IECV:253]periodo:6
		
		  //$vl_folioNotificacion:=0
		  //$vl_folioNotificacion:=Num(PREF_fGet (0;"ACT_DTE_FolioNotificacionIE";String($vl_folioNotificacion)))
		  //$vl_folioNotificacion:=$vl_folioNotificacion+1
		  //PREF_Set (0;"ACT_DTE_FolioNotificacionIE";String($vl_folioNotificacion))
		
		  //$vt_Periodo:=$vt_Periodo+String($vl_folioNotificacion)  //mas numero envio
		  //$vt_Periodo:=$vt_Periodo
		  //$vt_fileName:=ACTdte_GeneraArchivo ("GetNameDTE";->$vt_idTipoSII;->$vt_Periodo)
		$vt_fileName:=ACTdte_GeneraArchivo ("GetNameDTE";->$vt_idTipoSII;->$t_id)
		
		If ($vt_fileName#"")
			$vt_text:=""
			
			If (SYS_IsWindows )
				USE CHARACTER SET:C205("windows-1252";1)
			Else 
				USE CHARACTER SET:C205("MacRoman";1)
			End if 
			
			$vd_Fecha1:=DT_GetDateFromDayMonthYear (1;vlACTdte_MesIE;vlACTdte_YearIE)  //20170527 RCH Modificadas variables
			$vd_Fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vlACTdte_MesIE;vlACTdte_YearIE);vlACTdte_MesIE;vlACTdte_YearIE)  //20170527 RCH Modificadas variables
			$vb_alertarXFecha:=False:C215
			
			  //$vl_refEncabezado:=22 // entrega el numero de elementos por defecto, los demas seran las tablas...
			If (ACTdte_CargaArchivoIE ("IEC";$t_rutaArchivo;->$vl_refEncabezado))
				
				
				ARRAY TEXT:C222($atACT_encabezados;0)
				APPEND TO ARRAY:C911($atACT_encabezados;"CodIVANoRec")  //tabla iva no recup
				APPEND TO ARRAY:C911($atACT_encabezados;"MntIVANoRec")  // tabla iva no recup
				APPEND TO ARRAY:C911($atACT_encabezados;"CodImp")  // tipos de impuesto o recargo
				APPEND TO ARRAY:C911($atACT_encabezados;"TasaImp")  // tipos de impuesto o recargo
				APPEND TO ARRAY:C911($atACT_encabezados;"MntImp")  // tipos de impuesto o recargo
				
				$vt_text:=""
				$vt_textFinal:=""
				
				$vl_proc:=IT_UThermometer (1;0;"Generando libro de compras para el período: "+String:C10(vlACTdte_YearIE;"0000")+String:C10(vlACTdte_MesIE;"00"))
				  //$ref:=ACTabc_CreaArchivo ("libros";$vt_fileName;"DTE"+SYS_FolderDelimiter +ST_GetWord ($vt_fileName;3;"_"))
				  //If ($ref#?00:00:00?)
				  //CAR
				C_TEXT:C284($vt_rc1;$vt_re2;$vt_pt3;$vt_fr4;$vt_nr5;$vt_to6;$vt_tl7;$vt_te8;$vt_ns9;$vt_fn10;$vt_carle11)
				$vt_rc1:=ACTdte_GeneraArchivo ("GetRutConFormato";->[ACT_RazonesSociales:279]RUT:3)
				$vt_rut:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[ACT_RazonesSociales:279]encargadoDTE_id:31;->[Profesores:4]RUT:27)
				$vt_re2:=ACTdte_GeneraArchivo ("GetRutConFormato";->$vt_rut)
				  //$vt_pt3:=String(vlACTdte_YearIE;"0000")+"-"+String(vlACTdte_MesIE;"00")
				$vt_pt3:=[ACT_IECV:253]periodo:6
				$vt_fr4:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->[ACT_RazonesSociales:279]fecha_resolucion:20)
				$vt_nr5:=String:C10([ACT_RazonesSociales:279]numero_resolucion:21)
				$vt_to6:="COMPRA"
				  //$vt_tl7:=ST_Boolean2Str (vbACT_LibroPruebas;"ESPECIAL";"MENSUAL")
				  //$vt_tl7:=ST_Boolean2Str (vbACT_LibroPruebas;"ESPECIAL";Choose([ACT_IECV]tipo_libro;"";"MENSUAL";"ESPECIAL"))
				$vt_tl7:=ST_Boolean2Str (vbACT_LibroPruebas;"ESPECIAL";Choose:C955([ACT_IECV:253]tipo_libro:7;"";"MENSUAL";"ESPECIAL";"RECTIFICA"))
				  //$vt_te8:="TOTAL"
				$vt_te8:=Choose:C955([ACT_IECV:253]tipo_envio:8;"";"PARCIAL";"FINAL";"TOTAL";"AJUSTE";"RECTIFICA")
				  //$vt_ns9:=""
				$vt_ns9:=Choose:C955([ACT_IECV:253]numero_segmento:9=0;"";String:C10([ACT_IECV:253]numero_segmento:9))
				
				If (vbACT_LibroPruebas)
					$vt_fn10:="2"
				Else 
					  //$vl_folioNotificacion:=0
					  //$vl_folioNotificacion:=Num(PREF_fGet (0;"ACT_DTE_FolioNotificacionIEC";String($vl_folioNotificacion)))
					  //$vl_folioNotificacion:=Num(PREF_fGet (0;"ACT_DTE_FolioNotificacionIE";String($vl_folioNotificacion)))
					  //$vl_folioNotificacion:=$vl_folioNotificacion+1
					  //  //PREF_Set (0;"ACT_DTE_FolioNotificacionIEC";String($vl_folioNotificacion))
					  //PREF_Set (0;"ACT_DTE_FolioNotificacionIE";String($vl_folioNotificacion))
					  //$vt_fn10:=String($vl_folioNotificacion)
					  //$vt_fn10:=""
					$vt_fn10:=Choose:C955([ACT_IECV:253]folio_notificacion:10=0;"";String:C10([ACT_IECV:253]folio_notificacion:10))
				End if 
				$vt_carle11:=[ACT_IECV:253]codigo_reemplazo_libro:11
				
				
				$vt_text:="CAR"+$vt_separador+$vt_rc1+$vt_separador+$vt_re2+$vt_separador+$vt_pt3+$vt_separador+$vt_fr4+$vt_separador+$vt_nr5+$vt_separador
				$vt_text:=$vt_text+$vt_to6+$vt_separador+$vt_tl7+$vt_separador+$vt_te8+$vt_separador+$vt_ns9+$vt_separador+$vt_fn10+$vt_separador
				$vt_text:=$vt_text+$vt_carle11+$vt_separador+"\r"
				  //IO_SendPacket ($ref;$vt_text)
				$vt_textFinal:=$vt_textFinal+$vt_text
				
				If (Size of array:C274(aQR_Text1)>0)
					  //  //RESSEG
					  //C_TEXT($vt_td1;$vt_ti2;$vt_cd3;$vt_ta4;$vt_toe5;$vt_te6;$vt_tn7;$vt_toir8;$vt_ti9;$vt_toaf10;$vt_mnaf11;$vt_tiaf12;$vt_toiuc13;$vt_iuc14;$vt_isdac15;$vt_tmt16;$vt_inr17;$vt_ttp18;$vt_ttc19;$vt_tte20)
					  //$vt_td1:=""
					  //$vt_ti2:=""
					  //$vt_cd3:=""
					  //$vt_ta4:=""
					  //$vt_toe5:=""
					  //$vt_te6:=""
					  //$vt_tn7:=""
					  //$vt_toir8:=""
					  //$vt_ti9:=""
					  //$vt_toaf10:=""
					  //$vt_mnaf11:=""
					  //$vt_tiaf12:=""
					  //$vt_toiuc13:=""
					  //$vt_iuc14:=""
					  //$vt_isdac15:=""
					  //$vt_tmt16:=""
					  //$vt_inr17:=""
					  //$vt_ttp18:=""
					  //$vt_ttc19:=""
					  //$vt_tte20:=""
					  //$vt_text:="RESSEG"+$vt_separador+$vt_td1+$vt_separador+$vt_ti2+$vt_separador+$vt_cd3+$vt_separador+$vt_ta4+$vt_separador+$vt_toe5+$vt_separador
					  //$vt_text:=$vt_text+$vt_te6+$vt_separador+$vt_tn7+$vt_separador+$vt_toir8+$vt_separador+$vt_ti9+$vt_separador+$vt_toaf10+$vt_separador
					  //$vt_text:=$vt_text+$vt_mnaf11+$vt_separador+$vt_tiaf12+$vt_separador+$vt_toiuc13+$vt_separador+$vt_iuc14+$vt_separador+$vt_isdac15+$vt_separador
					  //$vt_text:=$vt_text+$vt_tmt16+$vt_separador+$vt_inr17+$vt_separador+$vt_ttp18+$vt_separador+$vt_ttc19+$vt_separador+$vt_tte20+$vt_separador+"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					  //
					  //  //SEGIVANOREC
					  //C_TEXT($vt_cnr1;$vt_oinr2;$vt_minr3)
					  //$vt_cnr1:=""
					  //$vt_oinr2:=""
					  //$vt_minr3:=""
					  //$vt_text:="SEGIVANOREC"+$vt_separador+$vt_cnr1+$vt_separador+$vt_oinr2+$vt_separador+$vt_minr3+$vt_separador+"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					  //
					  //  //SEGOTROIMP
					  //C_TEXT($vt_cdi1;$vt_vdi2)
					  //$vt_cdi1:=""
					  //$vt_vdi2:=""
					  //$vt_text:="SEGOTROIMP"+$vt_separador+$vt_cdi1+$vt_separador+$vt_vdi2+$vt_separador+"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					
					  //RESPER
					C_TEXT:C284($vt_tdr1;$vt_tdir2;$vt_cdr3;$vt_tar4;$vt_toer5;$vt_ter6;$vt_tnr7;$vt_toirr8;$vt_tmir9;$vt_toafr10;$vt_mnafr11;$vt_tiafr12;$vt_toiucr13;$vt_iucr14;$vt_fpir15;$vt_tciucr16;$vt_isdacr17;$vt_tmtr18;$vt_inrr19;$vt_ttpr20;$vt_ttcr21;$vt_tter22;$vt_tivr23)
					ARRAY TEXT:C222($atACT_codDctos2;0)
					COPY ARRAY:C226(aQR_Text1;$atACT_codDctos2)
					AT_DistinctsArrayValues (->$atACT_codDctos2)
					
					For ($i;1;Size of array:C274($atACT_codDctos2))
						aQR_Text1{0}:=$atACT_codDctos2{$i}
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (->aQR_Text1;"=";->$DA_Return)
						$vt_tdr1:=$atACT_codDctos2{$i}
						$vt_tdir2:="1"
						$vt_cdr3:=String:C10(Size of array:C274($DA_Return))
						$vt_tar4:=""
						$vt_toer5:="0"
						$ptr:=Get pointer:C304("aQR_Text13")
						$vr_monto:=0
						For ($x;1;Size of array:C274($DA_Return))
							$vr_monto2:=Num:C11($ptr->{$DA_Return{$x}})
							$vr_monto:=$vr_monto+$vr_monto2
							If ($vr_monto2>0)
								$vt_toer5:=String:C10(Num:C11($vt_toer5)+1)
							End if 
						End for 
						$vt_toer5:=ST_Boolean2Str ($vt_toer5="0";"";$vt_toer5)
						$vt_ter6:=String:C10($vr_monto)
						$ptr:=Get pointer:C304("aQR_Text14")
						$vr_monto:=0
						For ($x;1;Size of array:C274($DA_Return))
							$vr_monto:=$vr_monto+Num:C11($ptr->{$DA_Return{$x}})
						End for 
						$vt_tnr7:=String:C10($vr_monto)
						$vt_toirr8:=""
						$ptr:=Get pointer:C304("aQR_Text15")
						$vr_monto:=0
						For ($x;1;Size of array:C274($DA_Return))
							$vr_monto2:=Num:C11($ptr->{$DA_Return{$x}})
							$vr_monto:=$vr_monto+$vr_monto2
							If ($vr_monto2>0)
								$vt_toirr8:=String:C10(Num:C11($vt_toirr8)+1)
							End if 
						End for 
						$vt_tmir9:=String:C10($vr_monto)
						$vt_toafr10:=""
						$ptr:=Get pointer:C304("aQR_Text16")
						$vr_monto:=0
						For ($x;1;Size of array:C274($DA_Return))
							$vr_monto2:=Num:C11($ptr->{$DA_Return{$x}})
							$vr_monto:=$vr_monto+$vr_monto2
							If ($vr_monto2>0)
								$vt_toafr10:=String:C10(Num:C11($vt_toafr10)+1)
							End if 
						End for 
						$vt_mnafr11:=String:C10($vr_monto)
						$ptr:=Get pointer:C304("aQR_Text17")
						$vr_monto:=0
						For ($x;1;Size of array:C274($DA_Return))
							$vr_monto:=$vr_monto+Num:C11($ptr->{$DA_Return{$x}})
						End for 
						$vt_tiafr12:=String:C10($vr_monto)
						$vt_toiucr13:=""
						$ptr:=Get pointer:C304("aQR_Text18")
						$vr_monto:=0
						For ($x;1;Size of array:C274($DA_Return))
							$vr_monto2:=Num:C11($ptr->{$DA_Return{$x}})
							$vr_monto:=$vr_monto+$vr_monto2
							If ($vr_monto2>0)
								$vt_toiucr13:=String:C10(Num:C11($vt_toiucr13)+1)
							End if 
						End for 
						$vt_iucr14:=String:C10($vr_monto)
						  //TRACE
						$vt_fpir15:=PREF_fGet (0;"ACT_DTE_FactorPropIVA";"0")
						
						TRACE:C157  //Prueba de factor de proporcionalidad del IVA
						  //Se debe ingresar el factor. Si esta en pct se debe dividir por 100 al ingresarlo.
						If (Not:C34((<>Shift) & (<>Command)))
							$vt_tciucr16:=String:C10(Round:C94(Num:C11($vt_iucr14)*Num:C11($vt_fpir15);<>vlACT_Decimales))  //dejar asi porque de esta manera deberia ser validado el libro de compras del set de pruebas del SII.
						Else 
							$vt_tciucr16:=String:C10(Round:C94(Num:C11($vt_iucr14)*(Num:C11($vt_fpir15)/100);<>vlACT_Decimales))
						End if 
						  //$vt_tciucr16:=String(Round(Num($vt_iucr14)*(Num($vt_fpir15)/100);<>vlACT_Decimales))
						
						If ($vt_tciucr16="0")
							$vt_fpir15:=""
							$vt_tciucr16:=""
						End if 
						
						  //los decimales tienen que ir con punto
						$vt_fpir15:=Replace string:C233($vt_fpir15;",";".")
						
						$ptr:=Get pointer:C304("aQR_Text19")
						$vr_monto:=0
						For ($x;1;Size of array:C274($DA_Return))
							$vr_monto:=$vr_monto+Num:C11($ptr->{$DA_Return{$x}})
						End for 
						$vt_isdacr17:=String:C10($vr_monto)
						$ptr:=Get pointer:C304("aQR_Text20")
						$vr_monto:=0
						For ($x;1;Size of array:C274($DA_Return))
							$vr_monto:=$vr_monto+Num:C11($ptr->{$DA_Return{$x}})
						End for 
						$vt_tmtr18:=String:C10($vr_monto)
						$ptr:=Get pointer:C304("aQR_Text21")
						$vr_monto:=0
						For ($x;1;Size of array:C274($DA_Return))
							$vr_monto:=$vr_monto+Num:C11($ptr->{$DA_Return{$x}})
						End for 
						$vt_inrr19:=String:C10($vr_monto)
						$vt_ttpr20:=""
						$vt_ttcr21:=""
						$vt_tter22:=""
						$vt_tivr23:=""
						
						$vt_text:="RESPER"+$vt_separador+$vt_tdr1+$vt_separador+$vt_tdir2+$vt_separador+$vt_cdr3+$vt_separador+$vt_tar4+$vt_separador+$vt_toer5+$vt_separador
						$vt_text:=$vt_text+$vt_ter6+$vt_separador+$vt_tnr7+$vt_separador+$vt_toirr8+$vt_separador+$vt_tmir9+$vt_separador+$vt_toafr10+$vt_separador
						$vt_text:=$vt_text+$vt_mnafr11+$vt_separador+$vt_tiafr12+$vt_separador+$vt_toiucr13+$vt_separador+$vt_iucr14+$vt_separador+$vt_fpir15+$vt_separador
						$vt_text:=$vt_text+$vt_tciucr16+$vt_separador+$vt_isdacr17+$vt_separador+$vt_tmtr18+$vt_separador+$vt_inrr19+$vt_separador+$vt_ttpr20+$vt_separador
						$vt_text:=$vt_text+$vt_ttcr21+$vt_separador+$vt_tter22+$vt_separador+$vt_tivr23+$vt_separador+"\r"
						  //IO_SendPacket ($ref;$vt_text)
						$vt_textFinal:=$vt_textFinal+$vt_text
						
						$vl_refEncabezadoCodIVA:=0
						
						If (Size of array:C274(atACT_encabezadosFile)>$vl_refEncabezado)
							$vl_refEncabezado2:=$vl_refEncabezado
							$vl_refEncabezado:=$vl_refEncabezado+1
							$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_refEncabezado))
							If (Size of array:C274($ptr->)>0)
								  //While (atACT_encabezadosFile{$vl_refEncabezado}#"")
								While ((Size of array:C274(atACT_encabezadosFile)>$vl_refEncabezado))
									$vl_tipoCampo:=Find in array:C230($atACT_encabezados;atACT_encabezadosFile{$vl_refEncabezado})
									
									$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_refEncabezado))
									Case of 
										: ($vl_tipoCampo=1)
											
											If ($vl_refEncabezadoCodIVA=0)
												$vl_refEncabezadoCodIVA:=$vl_refEncabezado
											End if 
											
											ARRAY TEXT:C222($at_encabezado;0)
											COPY ARRAY:C226($ptr->;$at_encabezado)
											AT_DistinctsArrayValues (->$at_encabezado)
											For ($vl_tabla1;1;Size of array:C274($at_encabezado))
												If ($at_encabezado{$vl_tabla1}#"")
													
													$vl_refEncabezado:=$vl_refEncabezadoCodIVA
													$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_refEncabezado))
													
													ARRAY LONGINT:C221($alACT_indices;0)
													$ptr->{0}:=$at_encabezado{$vl_tabla1}
													AT_SearchArray ($ptr;"=";->$alACT_indices)
													  // para obtener indice de montos...
													$vl_refEncabezado:=$vl_refEncabezado+1
													$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_refEncabezado))
													$vr_monto:=0
													$vl_contador:=0
													For ($x;1;Size of array:C274($alACT_indices))
														  // valido que corresponde a tipo
														If (aQR_Text1{0}=aQR_Text1{$alACT_indices{$x}})
															$vr_monto:=$vr_monto+Num:C11($ptr->{$alACT_indices{$x}})
															$vl_contador:=$vl_contador+1
														End if 
													End for 
													
													If ($vl_contador>0)
														  //PERIVANOREC
														C_TEXT:C284($vt_cnr1;$vt_oinr2;$vt_minr3)
														$vt_cnr1:=$at_encabezado{$vl_tabla1}
														$vt_oinr2:=String:C10($vl_contador)
														$vt_minr3:=String:C10($vr_monto)
														$vt_text:="PERIVANOREC"+$vt_separador+$vt_cnr1+$vt_separador+$vt_oinr2+$vt_separador+$vt_minr3+$vt_separador+"\r"
														  //IO_SendPacket ($ref;$vt_text)
														$vt_textFinal:=$vt_textFinal+$vt_text
													End if 
													
												End if 
											End for 
											
										: ($vl_tipoCampo=3)
											
											ARRAY TEXT:C222($at_encabezado;0)
											COPY ARRAY:C226($ptr->;$at_encabezado)
											AT_DistinctsArrayValues (->$at_encabezado)
											For ($vl_tabla1;1;Size of array:C274($at_encabezado))
												If ($at_encabezado{$vl_tabla1}#"")
													ARRAY LONGINT:C221($alACT_indices;0)
													$ptr->{0}:=$at_encabezado{$vl_tabla1}
													AT_SearchArray ($ptr;"=";->$alACT_indices)
													
													  // para obtener indice de montos...
													$vl_refEncabezado:=$vl_refEncabezado+2
													$ptr:=Get pointer:C304("aQR_Text"+String:C10($vl_refEncabezado))
													$vr_monto:=0
													For ($x;1;Size of array:C274($alACT_indices))
														If (aQR_Text1{0}=aQR_Text1{$alACT_indices{$x}})
															$vr_monto:=$vr_monto+Num:C11($ptr->{$alACT_indices{$x}})
														End if 
													End for 
													
													If ($vr_monto>0)
														  //PEROTROIMP
														C_TEXT:C284($vt_cdir1;$vt_vdir2;$vt_fiar3;$vt_cir4)
														$vt_cdir1:=$at_encabezado{$vl_tabla1}
														$vt_vdir2:=String:C10($vr_monto)
														$vt_fiar3:=""
														$vt_cir4:=String:C10($vr_monto)
														$vt_text:="PEROTROIMP"+$vt_separador+$vt_cdir1+$vt_separador+$vt_vdir2+$vt_separador+$vt_fiar3+$vt_separador+$vt_cir4+$vt_separador+"\r"
														  //IO_SendPacket ($ref;$vt_text)
														$vt_textFinal:=$vt_textFinal+$vt_text
													End if 
												End if 
											End for 
									End case 
									$vl_refEncabezado:=$vl_refEncabezado+1
								End while 
							End if 
							$vl_refEncabezado:=$vl_refEncabezado2
						End if 
						
					End for 
					
					  //If (Size of array(atACT_encabezadosFile)>$vl_refEncabezado)
					  //$vl_refEncabezado:=$vl_refEncabezado+1
					  //$ptr:=Get pointer("aQR_Text"+String($vl_refEncabezado))
					  //If (Size of array($ptr->)>0)
					  //  //While (atACT_encabezadosFile{$vl_refEncabezado}#"")
					  //While ((Size of array(atACT_encabezadosFile)>$vl_refEncabezado))
					  //$vl_tipoCampo:=Find in array($atACT_encabezados;atACT_encabezadosFile{$vl_refEncabezado})
					  //
					  //$ptr:=Get pointer("aQR_Text"+String($vl_refEncabezado))
					  //Case of 
					  //: ($vl_tipoCampo=1)
					  //ARRAY TEXT($at_encabezado;0)
					  //COPY ARRAY($ptr->;$at_encabezado)
					  //AT_DistinctsArrayValues (->$at_encabezado)
					  //For ($vl_tabla1;1;Size of array($at_encabezado))
					  //If ($at_encabezado{$vl_tabla1}#"")
					  //ARRAY LONGINT($alACT_indices;0)
					  //$ptr->{0}:=$at_encabezado{$vl_tabla1}
					  //AT_SearchArray ($ptr;"=";->$alACT_indices)
					  //
					  //  // para obtener indice de montos...
					  //$vl_refEncabezado:=$vl_refEncabezado+1
					  //$ptr:=Get pointer("aQR_Text"+String($vl_refEncabezado))
					  //$vr_monto:=0
					  //$vl_contador:=0
					  //For ($x;1;Size of array($alACT_indices))
					  //$vr_monto:=$vr_monto+Num($ptr->{$alACT_indices{$x}})
					  //$vl_contador:=$vl_contador+1
					  //End for 
					  //
					  //  //PERIVANOREC
					  //C_TEXT($vt_cnr1;$vt_oinr2;$vt_minr3)
					  //$vt_cnr1:=$at_encabezado{$vl_tabla1}
					  //$vt_oinr2:=String($vl_contador)
					  //$vt_minr3:=String($vr_monto)
					  //$vt_text:="PERIVANOREC"+$vt_separador+$vt_cnr1+$vt_separador+$vt_oinr2+$vt_separador+$vt_minr3+$vt_separador+"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					  //
					  //End if 
					  //End for 
					  //
					  //: ($vl_tipoCampo=3)
					  //
					  //ARRAY TEXT($at_encabezado;0)
					  //COPY ARRAY($ptr->;$at_encabezado)
					  //AT_DistinctsArrayValues (->$at_encabezado)
					  //For ($vl_tabla1;1;Size of array($at_encabezado))
					  //If ($at_encabezado{$vl_tabla1}#"")
					  //ARRAY LONGINT($alACT_indices;0)
					  //$ptr->{0}:=$at_encabezado{$vl_tabla1}
					  //AT_SearchArray ($ptr;"=";->$alACT_indices)
					  //
					  //  // para obtener indice de montos...
					  //$vl_refEncabezado:=$vl_refEncabezado+2
					  //$ptr:=Get pointer("aQR_Text"+String($vl_refEncabezado))
					  //$vr_monto:=0
					  //For ($x;1;Size of array($alACT_indices))
					  //$vr_monto:=$vr_monto+Num($ptr->{$alACT_indices{$x}})
					  //End for 
					  //
					  //  //PEROTROIMP
					  //C_TEXT($vt_cdir1;$vt_vdir2;$vt_fiar3;$vt_cir4)
					  //$vt_cdir1:=$at_encabezado{$vl_tabla1}
					  //$vt_vdir2:=String($vr_monto)
					  //$vt_fiar3:=""
					  //$vt_cir4:=String($vr_monto)
					  //$vt_text:="PEROTROIMP"+$vt_separador+$vt_cdir1+$vt_separador+$vt_vdir2+$vt_separador+$vt_fiar3+$vt_separador+$vt_cir4+$vt_separador+"\r"
					  //IO_SendPacket ($ref;$vt_text)
					  //$vt_textFinal:=$vt_textFinal+$vt_text
					  //End if 
					  //End for 
					  //End case 
					  //$vl_refEncabezado:=$vl_refEncabezado+1
					  //End while 
					  //End if 
					
					  //DETCOM
					C_TEXT:C284($vt_tdd1;$vt_ee2;$vt_f3;$vt_a4;$vt_o5;$vt_ti6;$vt_tdi7;$vt_ni8;$vt_fd9;$vt_cs10;$vt_rp11;$vt_rs12;$vt_me13;$vt_mn14;$vt_mi15;$vt_mnaf16;$vt_iaf17;$vt_iuc18;$vt_isdac19;$vt_mt20;$vt_inr21;$vt_tp22;$vt_tc23;$vt_te24;$vt_iv25)
					For ($i;1;Size of array:C274(aQR_Text1))
						  //$vt_tdd1:=""
						  //$vt_ee2:=""
						  //$vt_f3:=""
						  //$vt_a4:=""
						  //$vt_o5:=""
						  //$vt_ti6:=""
						  //$vt_tdi7:=""
						  //$vt_ni8:=""
						  //$vt_fd9:=""
						  //$vt_cs10:=""
						  //$vt_rp11:=""
						  //$vt_rs12:=""
						  //$vt_me13:=""
						  //$vt_mn14:=""
						  //$vt_mi15:=""
						  //$vt_mnaf16:=""
						  //$vt_iaf17:=""
						  //$vt_iuc18:=""
						  //$vt_isdac19:=""
						  //$vt_mt20:=""
						  //$vt_inr21:=""
						  //$vt_tp22:=""
						  //$vt_tc23:=""
						  //$vt_te24:=""
						  //$vt_iv25:=""
						$vt_tdd1:=aQR_Text1{$i}
						$vt_ee2:=aQR_Text2{$i}
						$vt_f3:=aQR_Text3{$i}
						$vt_a4:=aQR_Text4{$i}
						$vt_o5:=aQR_Text5{$i}
						$vt_ti6:=aQR_Text6{$i}
						$vt_tdi7:=Replace string:C233(aQR_Text7{$i};",";".")
						$vt_ni8:=aQR_Text8{$i}
						  //$vt_fd9:=aQR_Text9{$i}
						$vt_fd9:=Replace string:C233(aQR_Text9{$i};"/";"-")  //20170808 RCH Con / da error
						$vt_cs10:=aQR_Text10{$i}
						$vt_rp11:=Replace string:C233(aQR_Text11{$i};".";"")
						$vt_rs12:=aQR_Text12{$i}
						$vt_me13:=aQR_Text13{$i}
						$vt_mn14:=aQR_Text14{$i}
						$vt_mi15:=aQR_Text15{$i}
						If ($vt_mi15="")
							$vt_mi15:="0"
						End if 
						$vt_mnaf16:=aQR_Text16{$i}
						$vt_iaf17:=aQR_Text17{$i}
						$vt_iuc18:=aQR_Text18{$i}
						$vt_isdac19:=aQR_Text19{$i}
						$vt_mt20:=aQR_Text20{$i}
						$vt_inr21:=aQR_Text21{$i}
						$vt_tp22:=aQR_Text22{$i}
						$vt_tc23:=aQR_Text23{$i}
						$vt_te24:=aQR_Text24{$i}
						$vt_iv25:=aQR_Text25{$i}
						
						C_POINTER:C301($vy_pointer1)
						ARRAY TEXT:C222($atACT_CodIVANoRec;0)
						ARRAY TEXT:C222($atACT_MntIVANoRec;0)
						ARRAY TEXT:C222($atACT_CodImp;0)
						ARRAY TEXT:C222($atACT_TasaImp;0)
						ARRAY TEXT:C222($atACT_MntImp;0)
						
						  //$vl_indice:=2
						For ($vl_indice;26;Size of array:C274(atACT_encabezadosFile))
							$vy_pointer1:=Get pointer:C304("aQR_Text"+String:C10($vl_indice))
							
							If ($i<=Size of array:C274($vy_pointer1->))
								$vl_tipoCampo:=Find in array:C230($atACT_encabezados;atACT_encabezadosFile{$vl_indice})
								Case of 
									: ($vl_tipoCampo=1)
										APPEND TO ARRAY:C911($atACT_CodIVANoRec;$vy_pointer1->{$i})
										
									: ($vl_tipoCampo=2)
										APPEND TO ARRAY:C911($atACT_MntIVANoRec;$vy_pointer1->{$i})
										
									: ($vl_tipoCampo=3)
										APPEND TO ARRAY:C911($atACT_CodImp;$vy_pointer1->{$i})
										
									: ($vl_tipoCampo=4)
										APPEND TO ARRAY:C911($atACT_TasaImp;$vy_pointer1->{$i})
										
									: ($vl_tipoCampo=5)
										APPEND TO ARRAY:C911($atACT_MntImp;$vy_pointer1->{$i})
										
								End case 
							End if 
						End for 
						
						$vt_text:="DETCOM"+$vt_separador+$vt_tdd1+$vt_separador+$vt_ee2+$vt_separador+$vt_f3+$vt_separador+$vt_a4+$vt_separador+$vt_o5+$vt_separador
						$vt_text:=$vt_text+$vt_ti6+$vt_separador+$vt_tdi7+$vt_separador+$vt_ni8+$vt_separador+$vt_fd9+$vt_separador+$vt_cs10+$vt_separador
						$vt_text:=$vt_text+$vt_rp11+$vt_separador+$vt_rs12+$vt_separador+$vt_me13+$vt_separador+$vt_mn14+$vt_separador+$vt_mi15+$vt_separador
						$vt_text:=$vt_text+$vt_mnaf16+$vt_separador+$vt_iaf17+$vt_separador+$vt_iuc18+$vt_separador+$vt_isdac19+$vt_separador+$vt_mt20+$vt_separador
						$vt_text:=$vt_text+$vt_inr21+$vt_separador+$vt_tp22+$vt_separador+$vt_tc23+$vt_separador+$vt_te24+$vt_separador+$vt_iv25+$vt_separador+"\r"
						  //IO_SendPacket ($ref;$vt_text)
						$vt_textFinal:=$vt_textFinal+$vt_text
						
						
						For ($vl_cod;1;Size of array:C274($atACT_CodIVANoRec))
							  //DETCOMIVANR
							C_TEXT:C284($vt_cnrd1;$vt_minrd2)
							If ($atACT_CodIVANoRec{$vl_cod}#"")
								$vt_cnrd1:=$atACT_CodIVANoRec{$vl_cod}
								$vt_minrd2:=$atACT_MntIVANoRec{$vl_cod}
								$vt_text:="DETCOMIVANR"+$vt_separador+$vt_cnrd1+$vt_separador+$vt_minrd2+$vt_separador+"\r"
								  //IO_SendPacket ($ref;$vt_text)
								$vt_textFinal:=$vt_textFinal+$vt_text
							End if 
						End for 
						
						For ($vl_cod;1;Size of array:C274($atACT_CodIVANoRec))
							  //DETCOMIMP
							C_TEXT:C284($vt_cdid1;$vt_tdid2;$vt_vdid3)
							If ($atACT_CodImp{$vl_cod}#"")
								$vt_cdid1:=$atACT_CodImp{$vl_cod}
								$vt_tdid2:=Replace string:C233($atACT_TasaImp{$vl_cod};",";".")
								$vt_vdid3:=$atACT_MntImp{$vl_cod}
								$vt_text:="DETCOMIMP"+$vt_separador+$vt_cdid1+$vt_separador+$vt_tdid2+$vt_separador+$vt_vdid3+$vt_separador+"\r"
								  //IO_SendPacket ($ref;$vt_text)
								$vt_textFinal:=$vt_textFinal+$vt_text
							End if 
						End for 
						ARRAY TEXT:C222($atACT_CodIVANoRec;0)
						ARRAY TEXT:C222($atACT_MntIVANoRec;0)
						ARRAY TEXT:C222($atACT_CodImp;0)
						ARRAY TEXT:C222($atACT_TasaImp;0)
						ARRAY TEXT:C222($atACT_MntImp;0)
						
					End for 
					  //CLOSE DOCUMENT($ref)
					  //$vt_retorno:=vtACT_document
					  //$vt_retorno:=$vt_textFinal
					  //If ($vt_retorno#"")
					  //$vt_retorno:=ACTdte_GeneraArchivo ("EscribePesoEnNombre";->$vt_retorno)
					  //End if 
					
					  //Else 
					  //CD_Dlog (0;__ ("El archivo no pudo ser creado. Por favor verifique que el archivo no esté abierto y si no lo está, reinicie la aplicación."))
					  //End if 
				End if 
				$vt_retorno:=$vt_textFinal
				IT_UThermometer (-2;$vl_proc)
			End if 
		Else 
			$vt_retorno:=""
		End if 
	: ($vt_accion="LibroGuias")
		
		  //CAR
		C_TEXT:C284($vt_rc1;$vt_re2;$vt_pt3;$vt_fr4;$vt_nr5;$vt_tl6;$vt_te7;$vt_ns8;$vt_fn9)
		$vt_rc1:=""
		$vt_re2:=""
		$vt_pt3:=""
		$vt_fr4:=""
		$vt_nr5:=""
		$vt_tl6:=""
		$vt_te7:=""
		$vt_ns8:=""
		$vt_fn9:=""
		$vt_text:="CAR"+$vt_separador+$vt_rc1+$vt_separador+$vt_re2+$vt_separador+$vt_pt3+$vt_separador+$vt_fr4+$vt_separador+$vt_nr5+$vt_separador
		$vt_text:=$vt_text+$vt_tl6+$vt_separador+$vt_te7+$vt_separador+$vt_ns8+$vt_separador+$vt_fn9+$vt_separador+"\r"
		  //IO_SendPacket ($ref;$vt_text)
		$vt_textFinal:=$vt_textFinal+$vt_text
		
		  //RESSEG
		C_TEXT:C284($vt_tfars1;$vt_tgars2;$vt_tgvrs3;$vt_tmtgvrs4;$vt_tmtmrs5)
		$vt_tfars1:=""
		$vt_tgars2:=""
		$vt_tgvrs3:=""
		$vt_tmtgvrs4:=""
		$vt_tmtmrs5:=""
		$vt_text:="RESSEG"+$vt_separador+$vt_tfars1+$vt_separador+$vt_tgars2+$vt_separador+$vt_tgvrs3+$vt_separador+$vt_tmtgvrs4+$vt_separador+$vt_tmtmrs5+$vt_separador+"\r"
		  //IO_SendPacket ($ref;$vt_text)
		$vt_textFinal:=$vt_textFinal+$vt_text
		
		  //TGNV
		C_TEXT:C284($vt_ctt1;$vt_cg2;$vt_mg3)
		$vt_ctt1:=""
		$vt_cg2:=""
		$vt_mg3:=""
		$vt_text:="TGNV"+$vt_separador+$vt_ctt1+$vt_separador+$vt_cg2+$vt_separador+$vt_mg3+$vt_separador+"\r"
		  //IO_SendPacket ($ref;$vt_text)
		$vt_textFinal:=$vt_textFinal+$vt_text
		
		  //RESPER
		C_TEXT:C284($vt_tfa1;$vt_tga2;$vt_tgv3;$vt_tmtgv4;$vt_tmtm5)
		$vt_tfa1:=""
		$vt_tga2:=""
		$vt_tgv3:=""
		$vt_tmtgv4:=""
		$vt_tmtm5:=""
		$vt_text:="RESPER"+$vt_separador+$vt_tfa1+$vt_separador+$vt_tga2+$vt_separador+$vt_tgv3+$vt_separador+$vt_tmtgv4+$vt_separador+$vt_tmtm5+$vt_separador+"\r"
		  //IO_SendPacket ($ref;$vt_text)
		$vt_textFinal:=$vt_textFinal+$vt_text
		
		  //DET
		C_TEXT:C284($vt_f1;$vt_a2;$vt_to3;$vt_f4;$vt_rr5;$vt_rsr6;$vt_mn7;$vt_ti8;$vt_i9;$vt_mt10;$vt_mtm11;$vt_tdr12;$vt_fdr13;$vt_fdr14)
		$vt_f1:=""
		$vt_a2:=""
		$vt_to3:=""
		$vt_f4:=""
		$vt_rr5:=""
		$vt_rsr6:=""
		$vt_mn7:=""
		$vt_ti8:=""
		$vt_i9:=""
		$vt_mt10:=""
		$vt_mtm11:=""
		$vt_tdr12:=""
		$vt_fdr13:=""
		$vt_fdr14:=""
		$vt_text:="DET"+$vt_separador+$vt_f1+$vt_separador+$vt_a2+$vt_separador+$vt_to3+$vt_separador+$vt_f4+$vt_separador+$vt_rr5+$vt_separador
		$vt_text:=$vt_text+$vt_rsr6+$vt_separador+$vt_mn7+$vt_separador+$vt_ti8+$vt_separador+$vt_i9+$vt_separador+$vt_mt10+$vt_separador
		$vt_text:=$vt_text+$vt_mtm11+$vt_separador+$vt_tdr12+$vt_separador+$vt_fdr13+$vt_separador+$vt_fdr14+$vt_separador+"\r"
		  //IO_SendPacket ($ref;$vt_text)
		$vt_textFinal:=$vt_textFinal+$vt_text
		  //CLOSE DOCUMENT($ref)
		
		
	: ($vt_accion="GeneraDctoBoleta")
		  //TRACE ERROR EN SJCHICUREO
		C_POINTER:C301($ptrRut;$ptrRazonSocial)
		$vt_idTipoSII:=$ptr1->
		$vt_fileName:=ACTdte_GeneraArchivo ("GetNameDTE";->$vt_idTipoSII)
		If ($vt_fileName#"")
			If ([ACT_Boletas:181]ID_Apoderado:14#0)
				$ptrRut:=->[Personas:7]RUT:6
				$ptrRazonSocial:=->[Personas:7]Apellidos_y_nombres:30
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)  //20180108 RCH Ticket 196769
			Else 
				$ptrRut:=->[ACT_Terceros:138]RUT:4
				$ptrRazonSocial:=->[ACT_Terceros:138]Nombre_Completo:9
				KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21)  //20180108 RCH Ticket 196769
			End if 
			
			$vt_fechaValida:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->[ACT_Boletas:181]FechaEmision:3)
			
			$vt_text:=""
			$vt_textFinal:=""
			  //$ref:=ACTabc_CreaArchivo ("documentos";$vt_fileName;"DTE")
			  //If ($ref#?00:00:00?)
			  //$vt_retorno:=vtACT_document
			$vt_separador:=";"
			$vt_text:=ACTdte_GeneraArchivo ("GeneraEncabezado";->$vt_separador;->$vt_idTipoSII)
			  //IO_SendPacket ($ref;$vt_text)
			$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  `ENC
			C_TEXT:C284($vt_td1;$vt_v2;$vt_fd3;$vt_fde4;$vt_idsp5;$vt_idmn6;$vt_pd7;$vt_ph8;$vt_fdv9;$vt_re10;$vt_rse11;$vt_ge12;$vt_cdses13;$vt_do14;$vt_co15;$vt_co16;$vt_rr17;$vt_cir18;$vt_rsr19;$vt_cr20;$vt_dr21;$vt_cr22;$vt_cr23;$vt_dp24;$vt_cp25;$vt_cp26;$vt_mn27;$vt_me28;$vt_i29;$vt_mt30;$vt_mnf31;$vt_mp32;$vt_sa33;$vt_vap34)
			
			$vt_td1:=$vt_idTipoSII
			$vt_v2:="1.0"
			$vt_fd3:=""
			$vt_fde4:=$vt_fechaValida
			  //$vt_idsp5:="03"  //es obligatorio
			$vt_idsp5:=t_indicadorServicioPBol  //20150206 RCH
			$vt_idmn6:=""
			$vt_pd7:=""
			$vt_ph8:=""
			
			If ([ACT_Boletas:181]FechaVencimiento:54>[ACT_Boletas:181]FechaEmision:3)  //20161007 RCH
				$vt_fechaValida:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->[ACT_Boletas:181]FechaVencimiento:54)
			End if 
			$vt_fdv9:=$vt_fechaValida
			
			  //emisor
			$vt_re10:=ACTdte_GeneraArchivo ("GetRutConFormato";->[ACT_RazonesSociales:279]RUT:3)
			$vt_rse11:=ST_GetStringByLen ([ACT_RazonesSociales:279]razon_social:2;100)
			$vt_ge12:=ST_GetStringByLen ([ACT_RazonesSociales:279]giro:18;80)
			$vt_cdses13:=""
			  //$vt_do14:=ST_GetStringByLen ([ACT_RazonesSociales]direccion;70)
			$vt_do14:=ST_GetStringByLen (Replace string:C233([ACT_RazonesSociales:279]direccion:7;";";",");70)
			$vt_co15:=ST_GetStringByLen ([ACT_RazonesSociales:279]comuna:8;20)
			$vt_co16:=ST_GetStringByLen ([ACT_RazonesSociales:279]ciudad:10;20)
			
			  //20161114 RCH - 20170411 RCH Se integra código.
			$vt_do14:=Replace string:C233($vt_do14;"\r";"")
			$vt_co15:=Replace string:C233($vt_co15;"\r";"")
			$vt_co16:=Replace string:C233($vt_co16;"\r";"")
			
			  //receptor
			$vt_rr17:=ACTdte_GeneraArchivo ("GetRutConFormato";$ptrRut)
			If ($vt_rr17="")
				$vt_rr17:="0"
				$vt_cir18:=ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;String:C10([Personas:7]No:1);String:C10([ACT_Terceros:138]Id:1))
			End if 
			  //$vt_rsr19:=Substring(Choose((($vt_idsp5="3") & ($vt_rr17="0"));ST_GetStringByLen ($ptrRazonSocial->;100);"");1;40)
			$vt_rsr19:=Substring:C12(ST_GetStringByLen ($ptrRazonSocial->;100);1;40)
			$vt_cr20:=""
			  //$vt_dr21:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas]ID_Apoderado#0;[Personas]Direccion;[ACT_Terceros]Direccion);70)  //estos datos estan en ACTbol_EMasivaDocTribs
			$vt_dr21:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;Replace string:C233([Personas:7]Direccion:14;";";",");Replace string:C233([ACT_Terceros:138]Direccion:5;";";","));70)  //estos datos estan en ACTbol_EMasivaDocTribs
			$vt_cr22:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Comuna:16;[ACT_Terceros:138]Comuna:6);20)  //estos datos estan en ACTbol_EMasivaDocTribs
			$vt_cr23:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Ciudad:17;[ACT_Terceros:138]Ciudad:7);20)  //estos datos estan en ACTbol_EMasivaDocTribs
			  //$vt_dp24:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas]ID_Apoderado#0;[Personas]ACT_DireccionEC;[ACT_Terceros]Direccion);70)
			$vt_dp24:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;Replace string:C233([Personas:7]ACT_DireccionEC:67;";";",");Replace string:C233([ACT_Terceros:138]Direccion:5;";";","));70)
			$vt_cp25:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]ACT_ComunaEC:68;[ACT_Terceros:138]Comuna:6);20)
			$vt_cp26:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]ACT_CiudadEC:69;[ACT_Terceros:138]Ciudad:7);20)
			
			  //20161114 RCH
			$vt_dr21:=Replace string:C233($vt_dr21;"\r";"")
			$vt_cr22:=Replace string:C233($vt_cr22;"\r";"")
			$vt_cr23:=Replace string:C233($vt_cr23;"\r";"")
			$vt_dp24:=Replace string:C233($vt_dp24;"\r";"")
			$vt_cp25:=Replace string:C233($vt_cp25;"\r";"")
			$vt_cp26:=Replace string:C233($vt_cp26;"\r";"")
			
			  //$vt_mn27:=Choose([ACT_Boletas]AfectaIVA;String([ACT_Boletas]Monto_Afecto);"") //solo aplica para las lineas con indicador de exencion 2
			  //$vt_mn27:=ST_Boolean2Str ([ACT_Boletas]Monto_IVA=0;"";String([ACT_Boletas]Monto_Afecto))  //20130705 RCH. solo aplica para las lineas con indicador de exencion 2
			$vt_me28:=String:C10([ACT_Boletas:181]Monto_Exento:30)
			  //$vt_i29:=Choose([ACT_Boletas]AfectaIVA;String([ACT_Boletas]TasaIVA);"")//solo aplica para las lineas con indicador de exencion 2
			  //$vt_i29:=ST_Boolean2Str ([ACT_Boletas]Monto_IVA#0;String([ACT_Boletas]Monto_IVA);"")  //20130705 RCH. solo aplica para las lineas con indicador de exencion 2
			$vt_mt30:=String:C10([ACT_Boletas:181]Monto_Total:6)
			$vt_mnf31:=""
			$vt_mp32:=""
			$vt_sa33:=""
			$vt_vap34:=""
			
			$vt_text:="ENC"+$vt_separador+$vt_td1+$vt_separador+$vt_v2+$vt_separador+$vt_fd3+$vt_separador+$vt_fde4+$vt_separador+$vt_idsp5+$vt_separador
			$vt_text:=$vt_text+$vt_idmn6+$vt_separador+$vt_pd7+$vt_separador+$vt_ph8+$vt_separador+$vt_fdv9+$vt_separador+$vt_re10+$vt_separador
			$vt_text:=$vt_text+$vt_rse11+$vt_separador+$vt_ge12+$vt_separador+$vt_cdses13+$vt_separador+$vt_do14+$vt_separador+$vt_co15+$vt_separador
			$vt_text:=$vt_text+$vt_co16+$vt_separador+$vt_rr17+$vt_separador+$vt_cir18+$vt_separador+$vt_rsr19+$vt_separador+$vt_cr20+$vt_separador
			$vt_text:=$vt_text+$vt_dr21+$vt_separador+$vt_cr22+$vt_separador+$vt_cr23+$vt_separador+$vt_dp24+$vt_separador+$vt_cp25+$vt_separador
			$vt_text:=$vt_text+$vt_cp26+$vt_separador+$vt_mn27+$vt_separador+$vt_me28+$vt_separador+$vt_i29+$vt_separador+$vt_mt30+$vt_separador
			$vt_text:=$vt_text+$vt_mnf31+$vt_separador+$vt_mp32+$vt_separador+$vt_sa33+$vt_separador+$vt_vap34+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //DET
			C_TEXT:C284($vt_nldd1;$vt_ide2;$vt_ndi3;$vt_da4;$vt_cdi5;$vt_udm6;$vt_pdi7;$vt_mdi8)
			C_LONGINT:C283($vl_lineas)
			C_POINTER:C301($ptr1;$ptr2)
			$vl_lineas:=Num:C11(ACTcfg_OpcionesLineasDT ("ObtieneNumLineas"))
			If ($vl_lineas>60)
				$vl_lineas:=60  //maximo 60 para el sii. En act el maximo es 20
			End if 
			$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
			$l_linea:=1
			For ($i;1;$vl_lineas)
				$ptr1:=Get pointer:C304("vtACT_SRbol_DetalleCargo"+String:C10($i)+"1")
				$ptr2:=Get pointer:C304("vrACT_SRbol_MontoCargo"+String:C10($i)+"1")
				$ptr3:=Get pointer:C304("vrACT_SRbol_CantidadCargo"+String:C10($i)+"1")
				$ptr4:=Get pointer:C304("vrACT_SRbol_UnitarioCargo"+String:C10($i)+"1")
				$ptr5:=Get pointer:C304("vbACT_SRbol_Afecto"+String:C10($i)+"1")
				$ptr6:=Get pointer:C304("vrACT_SRbol_MontoDcto"+String:C10($i)+"1")
				$ptr7:=Get pointer:C304("vlACT_SRbol_IDCargo"+String:C10($i)+"1")  // id cargo
				$ptr8:=Get pointer:C304("vtACT_SRbol_unidadCargo"+String:C10($i)+"1")  // 
				If ($ptr1->#"")
					  //If (($ptr2->>0) | ($i=1))  // cuando es la primera linea siempre tiene que entrar
					
					If ($ptr7->#0)
						KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;$ptr7)
					End if 
					
					  //para manejar descuentos
					  //If ($ptr1->#"")
					If ($ptr1->#"")
						If ($ptr2->>=0)
							
							  //$vt_nldd1:=String($i)
							$vt_nldd1:=String:C10($l_linea)
							
							  //20150912 RCH
							  //If (Records in selection([ACT_Cargos])=1)
							  //$vt_ide2:=Choose([ACT_Cargos]TasaIVA#0;"";"1")  //si el cargo es exento colocar 1. De lo contrario vacio
							  //Else 
							  //$vt_ide2:=ST_Boolean2Str ([ACT_Boletas]codigo_SII="39";"";"1")  //si el cargo es exento colocar 1. De lo contrario vacio
							  //End if 
							$vt_ide2:=Choose:C955($ptr5->;"";"1")
							
							  //$vt_ndi3:=$ptr1->  //glosa
							$vt_ndi3:=Substring:C12(Replace string:C233($ptr1->;";";"");1;80)  //20141007 RCH Si va un ; es considerada otra columna
							
							  //20160429 RCH
							  //If ((r_enviaDesc=1) & (vtACT_TextoDescripcion#""))
							  //C_TEXT($t_apellidos_y_nombres;$t_mes;$t_curso;$t_rut;$t_year;$t_nivel)
							  //If (Position("&al_ape&";vtACT_TextoDescripcion)>0)
							  //vQR_Pointer1:=Get pointer("vtACT_SRbol_CuentaCargo"+String($i)+"1")  //nombre
							  //$t_apellidos_y_nombres:=vQR_Pointer1->
							  //Else 
							  //$t_apellidos_y_nombres:=""
							  //End if 
							  //If (Position("&car_mes&";vtACT_TextoDescripcion)>0)
							  //vQR_Pointer1:=Get pointer("vtACT_SRbol_MesCargo"+String($i)+"1")  //mes
							  //$t_mes:=vQR_Pointer1->
							  //Else 
							  //$t_mes:=""
							  //End if 
							  //If (Position("&al_cur&";vtACT_TextoDescripcion)>0)
							  //vQR_Pointer1:=Get pointer("vtACT_SRbol_CuentaCurCargo"+String($i)+"1")
							  //$t_curso:=vQR_Pointer1->
							  //Else 
							  //$t_curso:=""
							  //End if 
							  //If (Position("&al_rut&";vtACT_TextoDescripcion)>0)
							  //vQR_Pointer1:=Get pointer("vtACT_SRbol_CuentaRUT"+String($i)+"1")
							  //$t_rut:=vQR_Pointer1->
							  //Else 
							  //$t_rut:=""
							  //End if 
							  //If (Position("&car_year&";vtACT_TextoDescripcion)>0)
							  //vQR_Pointer1:=Get pointer("vtACT_SRbol_AñoCargo"+String($i)+"1")
							  //$t_year:=vQR_Pointer1->
							  //Else 
							  //$t_year:=""
							  //End if 
							  //If (Position("&al_nivel&";vtACT_TextoDescripcion)>0)
							  //vQR_Pointer1:=Get pointer("vtACT_SRbol_CuentaNivCargo"+String($i)+"1")
							  //$t_nivel:=vQR_Pointer1->
							  //Else 
							  //$t_nivel:=""
							  //End if 
							
							  //If (($t_apellidos_y_nombres#"") | ($t_mes#"") | ($t_curso#"") | ($t_rut#"") | ($t_year#"") | ($t_nivel#""))
							  //$vt_da4:=vtACT_TextoDescripcion
							  //$vt_da4:=Replace string($vt_da4;"&al_ape&";$t_apellidos_y_nombres)
							  //$vt_da4:=Replace string($vt_da4;"&car_mes&";$t_mes)
							  //$vt_da4:=Replace string($vt_da4;"&al_cur&";$t_curso)
							  //$vt_da4:=Replace string($vt_da4;"&al_rut&";$t_rut)
							  //$vt_da4:=Replace string($vt_da4;"&car_year&";$t_year)
							  //$vt_da4:=Replace string($vt_da4;"&al_nivel&";$t_nivel)
							  //Else 
							  //  //$vt_da4:=""
							  //$vt_da4:=" "  //20160428 RCH Para que el XML genere el tag desc. ticket 160087
							  //End if 
							
							  //Else 
							  //$vt_da4:=""
							  //End if 
							$vt_da4:=ACTdte_LlenaDescripcion (r_enviaDesc;vtACT_TextoDescripcion;$i)
							
							  //If ($ptr7->#0)
							  //$vl_idCta:=KRL_GetNumericFieldData (->[ACT_Cargos]ID;$ptr7;->[ACT_Cargos]ID_CuentaCorriente)
							  //$vl_idAl:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes]ID;->$vl_idCta;->[ACT_CuentasCorrientes]ID_Alumno)
							  //
							  //$vt_da4:=KRL_GetTextFieldData (->[Alumnos]Número;->$vl_idAl;->[Alumnos]Apellidos_y_Nombres)
							  //$vt_da4:=$vt_da4+" "+KRL_GetTextFieldData (->[Alumnos]Número;->$vl_idAl;->[Alumnos]Curso)
							  //$vt_da4:=$vt_da4+" "+SR_FormatoRUT2 (KRL_GetTextFieldData (->[Alumnos]Número;->$vl_idAl;->[Alumnos]RUT))
							  //$vt_da4:=Substring($vt_da4;1;1000)
							  //Else 
							  //$vt_da4:=""
							  //End if 
							
							$vt_cdi5:=String:C10($ptr3->)
							$vt_cdi5:=Replace string:C233($vt_cdi5;<>tXS_RS_DecimalSeparator;".")
							If ($ptr2->=0)
								$vt_cdi5:=""
							Else 
								If (Num:C11($vt_cdi5)=0)
									$vt_cdi5:="1"
								End if 
							End if 
							If ($ptr8->#"")
								  //20150207 RCH El maximo es 4
								  //$vt_udm6:=$ptr8->
								$vt_udm6:=Substring:C12($ptr8->;1;4)
							Else 
								$vt_udm6:=""
							End if 
							  //$vt_pdi7:=String($ptr4->)
							
							  //20151005 RCH Se divide solo si es diferente de 0
							  //$vt_pdi7:=String(Round($ptr2->/$ptr3->;<>vlACT_Decimales))  //20141009 RCH Se calcula el precio unitario
							If ($ptr3->#0)
								  //20160224 RCH SII soporta hasta 6 decimales para dte y 2 para boletas
								  //$vt_pdi7:=String(Round($ptr2->/$ptr3->;<>vlACT_Decimales))  //20141009 RCH Se calcula el precio unitario
								$l_decimales:=Choose:C955(($vt_idTipoSII="39") | ($vt_idTipoSII="41");2;6)
								$vt_pdi7:=String:C10(Round:C94($ptr2->/$ptr3->;$l_decimales))
							Else 
								$vt_pdi7:=""
							End if 
							$r_precio:=Num:C11($vt_pdi7)
							$vt_pdi7:=Replace string:C233($vt_pdi7;<>tXS_RS_DecimalSeparator;".")
							
							  //20151005 Se valida que multiplicacion cuadre. Si no cuadra, se elimina la cantidad y el unitario. Ejemplo, cuando pagan 1 peso menos que el monto de la colegiatura
							  //If ((Num($vt_pdi7)*Num($vt_cdi5))#$ptr2->)
							  //If ((Num($vt_pdi7)*Num($ptr3->))#$ptr2->)  //20151026 RCH. Cuando habia decimal no calculaba correctamente
							If ((Num:C11($r_precio)*Num:C11($ptr3->))#$ptr2->)  //20160224 RCH
								$vt_cdi5:=""
								$vt_pdi7:=""
							End if 
							$vt_mdi8:=String:C10($ptr2->)
							$vt_text:="DET"+$vt_separador+$vt_nldd1+$vt_separador+$vt_ide2+$vt_separador+$vt_ndi3+$vt_separador+$vt_da4+$vt_separador+$vt_cdi5+$vt_separador
							$vt_text:=$vt_text+$vt_udm6+$vt_separador+$vt_pdi7+$vt_separador+$vt_mdi8+$vt_separador+"\r"
							  //IO_SendPacket ($ref;$vt_text)
							$vt_textFinal:=$vt_textFinal+$vt_text
							
							$l_linea:=$l_linea+1
						End if 
					Else 
						$i:=$vl_lineas
					End if 
					  //End if 
				Else 
					$i:=$vl_lineas
				End if 
			End for 
			
			
			
			
			
			  //  //ITCOD
			  //C_TEXT($vt_tdc1;$vt_cdi2)
			  //$vt_tdc1:=""
			  //$vt_cdi2:=""
			  //$vt_text:="ITCOD"+$vt_separador+$vt_tdc1+$vt_separador+$vt_cdi2+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  //SUBT
			  //C_TEXT($vt_nldsi1;$vt_g2;$vt_odi3;$vt_vsn4;$vt_vsi5;$vt_vsia6;$vt_vse7;$vt_vds8)
			  //$vt_nldsi1:=""
			  //$vt_g2:=""
			  //$vt_odi3:=""
			  //$vt_vsn4:=""
			  //$vt_vsi5:=""
			  //$vt_vsia6:=""
			  //$vt_vse7:=""
			  //$vt_vds8:=""
			  //$vt_text:="SUBT"+$vt_separador+$vt_nldsi1+$vt_separador+$vt_g2+$vt_separador+$vt_odi3+$vt_separador+$vt_vsn4+$vt_separador+$vt_vsi5+$vt_separador
			  //$vt_text:=$vt_text+$vt_vsia6+$vt_separador+$vt_vse7+$vt_separador+$vt_vds8+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  //LINSUBT
			  //C_TEXT($vt_ndldda1)
			  //$vt_ndldda1:=""
			  //$vt_text:="LINSUBT"+$vt_separador+$vt_ndldda1+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  //DESCREC
			  //C_TEXT($vt_ndl1;$vt_tdm2;$vt_g3;$vt_tdv4;$vt_v5;$vt_ide6)
			  //$vt_ndl1:=""
			  //$vt_tdm2:=""
			  //$vt_g3:=""
			  //$vt_tdv4:=""
			  //$vt_v5:=""
			  //$vt_ide6:=""
			  //$vt_text:="DESCREC"+$vt_separador+$vt_ndl1+$vt_separador+$vt_tdm2+$vt_separador+$vt_g3+$vt_separador+$vt_tdv4+$vt_separador+$vt_v5+$vt_separador
			  //$vt_text:=$vt_text+$vt_ide6+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			$l_linea:=1
			For ($i;1;$vl_lineas)
				$ptr1:=Get pointer:C304("vtACT_SRbol_DetalleCargo"+String:C10($i)+"1")
				$ptr2:=Get pointer:C304("vrACT_SRbol_MontoCargo"+String:C10($i)+"1")
				$ptr3:=Get pointer:C304("vrACT_SRbol_CantidadCargo"+String:C10($i)+"1")
				$ptr4:=Get pointer:C304("vrACT_SRbol_UnitarioCargo"+String:C10($i)+"1")
				$ptr5:=Get pointer:C304("vbACT_SRbol_Afecto"+String:C10($i)+"1")
				$ptr6:=Get pointer:C304("vrACT_SRbol_MontoDcto"+String:C10($i)+"1")
				$ptr7:=Get pointer:C304("vlACT_SRbol_IDCargo"+String:C10($i)+"1")  // id cargo
				$ptr8:=Get pointer:C304("vtACT_SRbol_unidadCargo"+String:C10($i)+"1")  // 
				If ($ptr1->#"")
					If ($ptr2-><0)
						C_TEXT:C284($vt_ndl1;$vt_tdm2;$vt_g3;$vt_tdv4;$vt_v5;$vt_ide6)
						  //$vt_ndl1:=String($i)
						$vt_ndl1:=String:C10($l_linea)
						$vt_tdm2:="D"
						$vt_g3:=$ptr1->
						$vt_tdv4:="$"
						$vt_v5:=String:C10(Abs:C99($ptr2->))
						  //$vt_ide6:=Choose($ptr5->;"0";"1")
						$vt_ide6:=Choose:C955($ptr5->;"2";"1")  //20161121 RCH No se calculaba correcto el monto del descuento afecto. 20170411 RCH Se integra...
						$vt_text:="DESCREC"+$vt_separador+$vt_ndl1+$vt_separador+$vt_tdm2+$vt_separador+$vt_g3+$vt_separador+$vt_tdv4+$vt_separador+$vt_v5+$vt_separador
						$vt_text:=$vt_text+$vt_ide6+$vt_separador+"\r"
						IO_SendPacket ($ref;$vt_text)
						$vt_textFinal:=$vt_textFinal+$vt_text
						$l_linea:=$l_linea+1
					End if 
				Else 
					$i:=$vl_lineas
				End if 
			End for 
			
			  //  //REF
			  //C_TEXT($vt_ndlr11;$vt_cdr22;$vt_rr33)
			  //$vt_ndlr11:=""
			  //$vt_cdr22:=""
			  //$vt_rr33:=""
			  //$vt_text:="REF"+$vt_separador+$vt_ndlr11+$vt_separador+$vt_cdr22+$vt_separador+$vt_rr33+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			  //CLOSE DOCUMENT($ref)
			$vt_retorno:=$vt_textFinal
			  //End if 
		Else 
			$vt_retorno:=""
		End if 
	: ($vt_accion="GeneraEncabezado")
		C_TEXT:C284(vtACT_TextoAbiertoDT)
		C_TEXT:C284($vtACT_obs1;$vtACT_obs2;$vtACT_obs3;$vtACT_obs4;$vtACT_obs5;$vtACT_obs6;$vtACT_obs7;$vtACT_obs8;$vtACT_obs9;$vtACT_obs10)
		$vt_separador:=$ptr1->
		$vt_idTipoSII:=$ptr2->  //para cuando los textos varien por tipo de documento
		  //$vt_retorno:="OBS"+$vt_separador+USR_GetUserName (USR_GetUserID )+$vt_separador+Current machine+$vt_separador+vtACT_TextoAbiertoDT+$vt_separador+[ACT_RazonesSociales]RUT+$vt_separador+String([ACT_Boletas]ID)+$vt_separador+$vt_separador+$vt_separador+$vt_separador+$vt_separador+$vt_separador+"\r"
		
		If (r_enviaObs=1)
			  //If (($vt_idTipoSII="39") | ($vt_idTipoSII="41"))
			  //ejecuta script de informe...
			If ((vtACTdte_obs1#"") | (vtACTdte_obs2#"") | (vtACTdte_obs3#"") | (vtACTdte_obs4#"") | (vtACTdte_obs5#"") | (vtACTdte_obs6#"") | (vtACTdte_obs7#"") | (vtACTdte_obs8#""))
				
				READ ONLY:C145([xShell_Reports:54])
				ACTcfg_LoadBolModels 
				$l_recNumBol:=Record number:C243([ACT_Boletas:181])
				$index:=Find in array:C230(alACT_IDDT;[ACT_Boletas:181]ID_Documento:13)
				If ($index>0)
					$WhereModelo:=Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})
					$ModID:=alACT_ModelosDocID{$WhereModelo}
					
					QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ID:7=$ModID)
					C_LONGINT:C283($l_areaSRP)
					$l_areaSRP:=SR New Offscreen Area 
					$l_error:=SR Set Area ($l_areaSRP;[xShell_Reports:54]xReportData_:29)
					$l_error:=SR Get Scripts ($l_areaSRP;$t_ScriptInicio;$t_ScriptCuerpo;$t_ScriptFin)
					EXE_Execute ($t_ScriptInicio)
					SR DELETE OFFSCREEN AREA ($areaSRP)
				End if 
				KRL_GotoRecord (->[ACT_Boletas:181];$l_recNumBol)
				
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
				KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21)
				
				  //carga variables
				If (vtACTdte_obs1#"")
					vQR_Pointer1:=Get pointer:C304(vtACTdte_obs1)
					$vtACT_obs1:=Replace string:C233(ST_Coerce_to_Text (vQR_Pointer1;False:C215);";";"")
				End if 
				If (vtACTdte_obs2#"")
					vQR_Pointer1:=Get pointer:C304(vtACTdte_obs2)
					$vtACT_obs2:=Replace string:C233(ST_Coerce_to_Text (vQR_Pointer1;False:C215);";";"")
				End if 
				If (vtACTdte_obs3#"")
					vQR_Pointer1:=Get pointer:C304(vtACTdte_obs3)
					$vtACT_obs3:=Replace string:C233(ST_Coerce_to_Text (vQR_Pointer1;False:C215);";";"")
				End if 
				If (vtACTdte_obs4#"")
					vQR_Pointer1:=Get pointer:C304(vtACTdte_obs4)
					$vtACT_obs4:=Replace string:C233(ST_Coerce_to_Text (vQR_Pointer1;False:C215);";";"")
				End if 
				If (vtACTdte_obs5#"")
					vQR_Pointer1:=Get pointer:C304(vtACTdte_obs5)
					$vtACT_obs5:=Replace string:C233(ST_Coerce_to_Text (vQR_Pointer1;False:C215);";";"")
				End if 
				If (vtACTdte_obs6#"")
					vQR_Pointer1:=Get pointer:C304(vtACTdte_obs6)
					$vtACT_obs6:=Replace string:C233(ST_Coerce_to_Text (vQR_Pointer1;False:C215);";";"")
				End if 
				If (vtACTdte_obs7#"")
					vQR_Pointer1:=Get pointer:C304(vtACTdte_obs7)
					$vtACT_obs7:=Replace string:C233(ST_Coerce_to_Text (vQR_Pointer1;False:C215);";";"")
				End if 
				If (vtACTdte_obs8#"")
					vQR_Pointer1:=Get pointer:C304(vtACTdte_obs8)
					$vtACT_obs8:=Replace string:C233(ST_Coerce_to_Text (vQR_Pointer1;False:C215);";";"")
				End if 
				  //End if 
			End if 
		End if 
		$vtACT_obs9:=""
		  //20151005 RCH Se envia la version
		  //$vtACT_obs10:="Usuario: "+USR_GetUserName (USR_GetUserID )+". Máquina: "+Current machine+". Rut RS: "+[ACT_RazonesSociales]RUT+". Id D.T.: "+String([ACT_Boletas]ID)
		$vtACT_obs10:="Usuario: "+Replace string:C233(USR_GetUserName (USR_GetUserID );";";"")+". Máquina: "+Replace string:C233(Current machine:C483;";";"")+". Rut RS: "+[ACT_RazonesSociales:279]RUT:3+". Id D.T.: "+String:C10([ACT_Boletas:181]ID:1)+". Versión ST APP: "+Replace string:C233(SYS_LeeVersionEstructura ;";";"")+". Versión ST DB: "+Replace string:C233(SYS_LeeVersionBaseDeDatos ;";";"")
		
		$vt_retorno:="OBS"+$vt_separador+$vtACT_obs1+$vt_separador+$vtACT_obs2+$vt_separador+$vtACT_obs3+$vt_separador+$vtACT_obs4+$vt_separador+$vtACT_obs5+$vt_separador+$vtACT_obs6+$vt_separador+$vtACT_obs7+$vt_separador+$vtACT_obs8+$vt_separador+$vtACT_obs9+$vt_separador+$vtACT_obs10+$vt_separador+"\r"
		
	: ($vt_accion="GetNameDTE")
		$vt_tipoSII:=$ptr1->
		C_TEXT:C284($vt_Periodo)
		If (Not:C34(Is nil pointer:C315($ptr2)))
			$vt_Periodo:=$ptr2->
		End if 
		
		  //valida creacion archivo
		$vl_recNum:=Record number:C243([ACT_Boletas:181])
		$vb_readOnlyState:=Read only state:C362([ACT_Boletas:181])
		$vb_continuar:=True:C214
		If ([ACT_Boletas:181]ID_DctoAsociado:19#0)
			$vl_folio:=KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->[ACT_Boletas:181]ID_DctoAsociado:19;->[ACT_Boletas:181]Numero:11)
			KRL_ResetPreviousRWMode (->[ACT_Boletas:181];$vb_readOnlyState)
			GOTO RECORD:C242([ACT_Boletas:181];$vl_recNum)
			If ($vl_folio=0)
				CD_Dlog (0;"El número de documento de referencia asociado al documento número "+String:C10([ACT_Boletas:181]Numero:11)+", id "+String:C10([ACT_Boletas:181]ID:1)+", es 0. El archivo no puede ser generado.")
				$vb_continuar:=False:C215
			End if 
		End if 
		
		If ($vb_continuar)
			If ($vt_Periodo="")
				If ([ACT_Boletas:181]Emitido_desde:27=3)
					$vt_prefijo:="1"
				Else 
					$vt_prefijo:="2"
				End if 
				$vl_id:=[ACT_Boletas:181]ID:1
			Else 
				$vt_prefijo:="2"
				$vl_id:=Num:C11($vt_Periodo)
			End if 
			  //$vt_retorno:=$vt_prefijo+String([ACT_Boletas]ID)+".txt"
			If (Records in selection:C76([ACT_Boletas:181])>0)
				KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25)
			End if 
			If ((<>gCountryCode#"") & ([ACT_RazonesSociales:279]RUT:3#""))
				$vt_retorno:=$vt_prefijo+"_"+<>gCountryCode+"_"+[ACT_RazonesSociales:279]RUT:3+"_"+String:C10($vl_id)+"_"+$vt_tipoSII+".txt"
			Else 
				$vt_retorno:=""
			End if 
		Else 
			$vt_retorno:=""
		End if 
		
	: ($vt_accion="LoadRS")
		  //If ([ACT_Boletas]ID_RazonSocial>0)
		  //ACTcfg_OpcionesRazonesSociales ("CargaByID";->[ACT_Boletas]ID_RazonSocial)
		  //Else 
		  //ACTcfg_OpcionesRazonesSociales ("LoadConfig")
		  //End if 
		  //20151020 RCH Se carga la RS desde lo solicitado
		$vl_idRS:=$ptr1->
		$vl_idRS:=Choose:C955($vl_idRS=0;-1;$vl_idRS)
		  //If ([ACT_Boletas]ID_RazonSocial=0)
		  //$vl_idRS:=-1
		  //Else 
		  //$vl_idRS:=[ACT_Boletas]ID_RazonSocial
		  //End if 
		ACTcfg_OpcionesRazonesSociales ("CargaByID";->$vl_idRS)
		
	: ($vt_accion="GeneraDctoFactura")
		C_POINTER:C301($ptrRut;$ptrRazonSocial)
		C_BOOLEAN:C305(bACT_setDePruebas)  //20140809 RCH DTE
		
		$vt_idTipoSII:=$ptr1->
		$t_tipoRef:=KRL_GetTextFieldData (->[ACT_Boletas:181]ID:1;->[ACT_Boletas:181]ID_DctoAsociado:19;->[ACT_Boletas:181]codigo_SII:33)
		If ($vt_idTipoSII="61") & (($t_tipoRef="41") | ($t_tipoRef="39"))
			$vt_retorno:=ACTdte_GeneraDTE ($vt_idTipoSII)
		Else 
			  //$vt_fileName:=ACTdte_GeneraArchivo ("GetNameDTE";->$vt_idTipoSII)
			  //If ($vt_fileName#"")
			If ([ACT_Boletas:181]ID_Apoderado:14#0)
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
				$ptrRut:=->[Personas:7]RUT:6
				$ptrRazonSocial:=->[Personas:7]Apellidos_y_nombres:30
			Else 
				KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21)
				$ptrRut:=->[ACT_Terceros:138]RUT:4
				$ptrRazonSocial:=->[ACT_Terceros:138]Nombre_Completo:9
			End if 
			
			$vb_esNC:=True:C214
			
			$vt_text:=""
			$vt_textFinal:=""
			  //$ref:=ACTabc_CreaArchivo ("documentos";$vt_fileName;"DTE")
			  //If ($ref#?00:00:00?)
			  //$vt_retorno:=vtACT_document
			
			$vt_separador:=";"
			$vt_fechaValida:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->[ACT_Boletas:181]FechaEmision:3)
			
			$vt_text:=ACTdte_GeneraArchivo ("GeneraEncabezado";->$vt_separador;->$vt_idTipoSII)
			  //IO_SendPacket ($ref;$vt_text)
			$vt_textFinal:=$vt_textFinal+$vt_text
			
			C_TEXT:C284($vt_td1;$vt_v2;$vt_fd3;$vt_fde4;$vt_idnr5;$vt_tdd6;$vt_idttdb7;$vt_tdi8;$vt_idsp9;$vt_idmb10;$vt_fdp11;$vt_fdc12;$vt_mc13;$vt_si14;$vt_pd15;$vt_ph16;$vt_mdp17;$vt_tcp18;$vt_ncdp19;$vt_bp20;$vt_tdpc21;$vt_tdpg22;$vt_tdpd23;$vt_fdv24;$vt_re25;$vt_rse26;$vt_ge27;$vt_ce28;$vt_cte29;$vt_fa30;$vt_fa31;$vt_s32;$vt_cdsds33;$vt_do34;$vt_co35;$vt_co36;$vt_cdv37;$vt_rm38;$vt_rr39;$vt_cir40;$vt_rsr41;$vt_nire42;$vt_nre43)
			C_TEXT:C284($vt_gr44;$vt_cr45;$vt_ccr46;$vt_dr47;$vt_cr48;$vt_cr49;$vt_dp50;$vt_cp51;$vt_cp52;$vt_rs53;$vt_pdvqt54;$vt_rt55;$vt_rc56;$vt_nc57;$vt_dd58;$vt_cd59;$vt_cd60;$vt_mn61;$vt_me62;$vt_mbac63;$vt_mmc64;$vt_ti65;$vt_i66;$vt_ip67;$vt_it68;$vt_inr69;$vt_ceec70;$vt_gde71;$vt_mt72;$vt_mnf73;$vt_mp74;$vt_sa75;$vt_vap76;$vt_com77;$vt_tdc78;$vt_mnom79;$vt_meom80;$vt_mbfcom81;$vt_mbmcom82;$vt_iom83;$vt_inrom84;$vt_mtom85)
			$vt_td1:=$vt_idTipoSII
			$vt_v2:="1.0"
			$vt_fd3:=""
			$vt_fde4:=$vt_fechaValida
			$vt_idnr5:=""
			$vt_tdd6:=""
			$vt_idttdb7:=""
			$vt_tdi8:=""
			$vt_idsp9:=t_indicadorServicioPFac
			$vt_idmb10:=""
			  //$vt_fdp11:=ST_Boolean2Str ([ACT_Boletas]ID_Estado=3;"1";"2")  //si esta pagada 1. sino 2
			  //$vt_fdc12:=$vt_fechaValida
			$vt_fdp11:=""
			$vt_fdc12:=""
			$vt_mc13:=""
			$vt_si14:=""
			$vt_pd15:=""
			$vt_ph16:=""
			$vt_mdp17:=""
			$vt_tcp18:=""
			$vt_ncdp19:=""
			$vt_bp20:=""
			$vt_tdpc21:=""
			$vt_tdpg22:=""
			$vt_tdpd23:=""
			
			  //$vt_fdv24:=""
			If ([ACT_Boletas:181]FechaVencimiento:54>[ACT_Boletas:181]FechaEmision:3)  //20161007 RCH
				$vt_fechaValida:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->[ACT_Boletas:181]FechaVencimiento:54)
				$vt_fdv24:=$vt_fechaValida
			Else 
				$vt_fdv24:=""
			End if 
			
			$vt_re25:=ACTdte_GeneraArchivo ("GetRutConFormato";->[ACT_RazonesSociales:279]RUT:3)
			$vt_rse26:=ST_GetStringByLen ([ACT_RazonesSociales:279]razon_social:2;100)
			$vt_ge27:=ST_GetStringByLen ([ACT_RazonesSociales:279]giro:18;80)
			$vt_ce28:=""
			$vt_cte29:=""
			$vt_fa30:=""
			$vt_fa31:=""
			$vt_s32:=""
			$vt_cdsds33:=""
			  //$vt_do34:=ST_GetStringByLen ([ACT_RazonesSociales]direccion;70)
			$vt_do34:=ST_GetStringByLen (Replace string:C233([ACT_RazonesSociales:279]direccion:7;";";",");70)
			$vt_co35:=ST_GetStringByLen ([ACT_RazonesSociales:279]comuna:8;20)
			$vt_co36:=ST_GetStringByLen ([ACT_RazonesSociales:279]ciudad:10;20)
			
			  //20161114 RCH. 20170411 RCH Integrado en v12...
			$vt_do34:=Replace string:C233($vt_do34;"\r";"")
			$vt_co35:=Replace string:C233($vt_co35;"\r";"")
			$vt_co36:=Replace string:C233($vt_co36;"\r";"")
			
			$vt_cdv37:=""
			$vt_rm38:=""
			$vt_rr39:=ACTdte_GeneraArchivo ("GetRutConFormato";$ptrRut)
			$vt_cir40:=ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;String:C10([Personas:7]No:1);String:C10([ACT_Terceros:138]Id:1))
			$vt_rsr41:=ST_GetStringByLen ($ptrRazonSocial->;100)
			
			  //20170218 RCH
			If ($vt_rr39="")
				$vt_nire42:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Pasaporte:59;[ACT_Terceros:138]Pasaporte:25)
				$vt_nre43:=ACTdte_ObtieneCodigoPaisSII (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Nacionalidad:7;[ACT_Terceros:138]Nacionalidad:27))
			Else 
				$vt_nire42:=""
				$vt_nre43:=""
			End if 
			
			$vt_gr44:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;"Persona natural";[ACT_Terceros:138]Giro:8);40)
			$vt_gr44:=Choose:C955($vt_gr44="";"No informado";$vt_gr44)
			$vt_cr45:=""
			$vt_ccr46:=""
			  //$vt_dr47:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas]ID_Apoderado#0;[Personas]Direccion;[ACT_Terceros]Direccion);70)
			$vt_dr47:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;Replace string:C233([Personas:7]Direccion:14;";";",");Replace string:C233([ACT_Terceros:138]Direccion:5;";";","));70)
			$vt_cr48:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Comuna:16;[ACT_Terceros:138]Comuna:6);20)
			$vt_cr49:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Ciudad:17;[ACT_Terceros:138]Ciudad:7);20)
			
			  //20161114 RCH. 20170411 RCH Integado en v12...
			$vt_dr47:=Replace string:C233($vt_dr47;"\r";"")
			$vt_cr48:=Replace string:C233($vt_cr48;"\r";"")
			$vt_cr49:=Replace string:C233($vt_cr49;"\r";"")
			
			$vt_dp50:=""
			$vt_cp51:=""
			$vt_cp52:=""
			$vt_rs53:=""
			$vt_pdvqt54:=""
			$vt_rt55:=""
			$vt_rc56:=""
			$vt_nc57:=""
			$vt_dd58:=""
			$vt_cd59:=""
			$vt_cd60:=""
			  //$vt_mn61:=ST_Boolean2Str ([ACT_Boletas]Monto_IVA=0;String([ACT_Boletas]Monto_Total);String([ACT_Boletas]Monto_Afecto))
			$vt_mn61:=ST_Boolean2Str ([ACT_Boletas:181]Monto_IVA:5=0;"";String:C10([ACT_Boletas:181]Monto_Afecto:4))
			$vt_me62:=String:C10([ACT_Boletas:181]Monto_Exento:30)  //""  //ST_Boolean2Str ([ACT_Boletas]Monto_IVA=0;String([ACT_Boletas]Monto_Total);"")
			$vt_mbac63:=""
			$vt_mmc64:=""
			  //$vt_ti65:=ST_Boolean2Str ([ACT_Boletas]Monto_IVA#0;String(<>vrACT_TasaIVA);"")
			$vt_ti65:=ST_Boolean2Str ([ACT_Boletas:181]Monto_IVA:5#0;String:C10([ACT_Boletas:181]TasaIVA:16);"")
			$vt_i66:=ST_Boolean2Str ([ACT_Boletas:181]Monto_IVA:5#0;String:C10([ACT_Boletas:181]Monto_IVA:5);"")
			$vt_ip67:=""
			$vt_it68:=""
			$vt_inr69:=""
			$vt_ceec70:=""
			$vt_gde71:=""
			$vt_mt72:=String:C10([ACT_Boletas:181]Monto_Total:6)
			$vt_mnf73:=""
			$vt_mp74:=""
			$vt_sa75:=""
			$vt_vap76:=""
			$vt_com77:=""
			$vt_tdc78:=""
			$vt_mnom79:=""
			$vt_meom80:=""
			$vt_mbfcom81:=""
			$vt_mbmcom82:=""
			$vt_iom83:=""
			$vt_inrom84:=""
			$vt_mtom85:=""
			
			  //$vt_text:=$vt_td1+$vt_separador+$vt_v2+$vt_separador+$vt_fd3+$vt_separador+$vt_fde4+$vt_separador+$vt_idnr5+$vt_separador+$vt_tdd6+$vt_separador+$vt_idttdb7+$vt_separador+$vt_tdi8+$vt_separador+$vt_idsp9+$vt_separador+$vt_idmb10+$vt_separador+$vt_fdp11+$vt_separador+$vt_fdc12+$vt_separador+$vt_mc13+$vt_separador+$vt_si14+$vt_separador+$vt_pd15+$vt_separador+$vt_ph16+$vt_separador+$vt_mdp17+$vt_separador+$vt_tcp18+$vt_separador+$vt_ncdp19+$vt_separador+$vt_bp20+$vt_separador+$vt_tdpc21+$vt_separador+$vt_tdpg22+$vt_separador+$vt_tdpd23+$vt_separador+$vt_fdv24+$vt_separador+$vt_re25+$vt_separador+$vt_rse26+$vt_separador+$vt_ge27+$vt_separador+$vt_ce28+$vt_separador+$vt_cte29+$vt_separador+$vt_fa30+$vt_separador+$vt_fa31+$vt_separador+$vt_s32+$vt_separador+$vt_cdsds33+$vt_separador+$vt_do34+$vt_separador+$vt_co35+$vt_separador+$vt_co36+$vt_separador+$vt_cdv37+$vt_separador+$vt_rm38+$vt_separador+$vt_rr39+$vt_separador+$vt_cir40+$vt_separador+$vt_rsr41+$vt_separador+$vt_nire42+$vt_separador+$vt_nre43+$vt_separador+$vt_gr44+$vt_separador+$vt_cr45+$vt_separador+$vt_ccr46+$vt_separador+$vt_dr47+$vt_separador+$vt_cr48+$vt_separador+$vt_cr49+$vt_separador+$vt_dp50+$vt_separador+$vt_cp51+$vt_separador+$vt_cp52+$vt_separador+$vt_rs53+$vt_separador+$vt_pdvqt54+$vt_separador+$vt_rt55+$vt_separador+$vt_rc56+$vt_separador+$vt_nc57+$vt_separador+$vt_dd58+$vt_separador+$vt_cd59+$vt_separador+$vt_cd60+$vt_separador+$vt_mn61+$vt_separador+$vt_me62+$vt_separador+$vt_mbac63+$vt_separador+$vt_mmc64+$vt_separador+$vt_ti65+$vt_separador+$vt_i66+$vt_separador+$vt_ip67+$vt_separador+$vt_it68+$vt_separador+$vt_inr69+$vt_separador+$vt_ceec70+$vt_separador+$vt_gde71+$vt_separador+$vt_mt72+$vt_separador+$vt_mnf73+$vt_separador+$vt_mp74+$vt_separador+$vt_sa75+$vt_separador+$vt_vap76+$vt_separador+$vt_com77+$vt_separador+$vt_tdc78+$vt_separador+$vt_mnom79+$vt_separador+$vt_meom80+$vt_separador+$vt_mbfcom81+$vt_separador+$vt_mbmcom82+$vt_separador+$vt_iom83+$vt_separador+$vt_inrom84+$vt_separador+$vt_mtom85+$vt_separador+"\r"
			  //ENCABEZADO
			$vt_text:="ENC"+$vt_separador+$vt_td1+$vt_separador+$vt_v2+$vt_separador+$vt_fd3+$vt_separador+$vt_fde4+$vt_separador+$vt_idnr5+$vt_separador
			$vt_text:=$vt_text+$vt_tdd6+$vt_separador+$vt_idttdb7+$vt_separador+$vt_tdi8+$vt_separador+$vt_idsp9+$vt_separador+$vt_idmb10+$vt_separador
			$vt_text:=$vt_text+$vt_fdp11+$vt_separador+$vt_fdc12+$vt_separador+$vt_mc13+$vt_separador+$vt_si14+$vt_separador+$vt_pd15+$vt_separador
			$vt_text:=$vt_text+$vt_ph16+$vt_separador+$vt_mdp17+$vt_separador+$vt_tcp18+$vt_separador+$vt_ncdp19+$vt_separador+$vt_bp20+$vt_separador
			$vt_text:=$vt_text+$vt_tdpc21+$vt_separador+$vt_tdpg22+$vt_separador+$vt_tdpd23+$vt_separador+$vt_fdv24+$vt_separador+$vt_re25+$vt_separador
			$vt_text:=$vt_text+$vt_rse26+$vt_separador+$vt_ge27+$vt_separador+$vt_ce28+$vt_separador+$vt_cte29+$vt_separador+$vt_fa30+$vt_separador
			$vt_text:=$vt_text+$vt_fa31+$vt_separador+$vt_s32+$vt_separador+$vt_cdsds33+$vt_separador+$vt_do34+$vt_separador+$vt_co35+$vt_separador
			$vt_text:=$vt_text+$vt_co36+$vt_separador+$vt_cdv37+$vt_separador+$vt_rm38+$vt_separador+$vt_rr39+$vt_separador+$vt_cir40+$vt_separador
			$vt_text:=$vt_text+$vt_rsr41+$vt_separador+$vt_nire42+$vt_separador+$vt_nre43+$vt_separador+$vt_gr44+$vt_separador+$vt_cr45+$vt_separador
			$vt_text:=$vt_text+$vt_ccr46+$vt_separador+$vt_dr47+$vt_separador+$vt_cr48+$vt_separador+$vt_cr49+$vt_separador+$vt_dp50+$vt_separador
			$vt_text:=$vt_text+$vt_cp51+$vt_separador+$vt_cp52+$vt_separador+$vt_rs53+$vt_separador+$vt_pdvqt54+$vt_separador+$vt_rt55+$vt_separador
			$vt_text:=$vt_text+$vt_rc56+$vt_separador+$vt_nc57+$vt_separador+$vt_dd58+$vt_separador+$vt_cd59+$vt_separador+$vt_cd60+$vt_separador
			$vt_text:=$vt_text+$vt_mn61+$vt_separador+$vt_me62+$vt_separador+$vt_mbac63+$vt_separador+$vt_mmc64+$vt_separador+$vt_ti65+$vt_separador
			$vt_text:=$vt_text+$vt_i66+$vt_separador+$vt_ip67+$vt_separador+$vt_it68+$vt_separador+$vt_inr69+$vt_separador+$vt_ceec70+$vt_separador
			$vt_text:=$vt_text+$vt_gde71+$vt_separador+$vt_mt72+$vt_separador+$vt_mnf73+$vt_separador+$vt_mp74+$vt_separador+$vt_sa75+$vt_separador
			$vt_text:=$vt_text+$vt_vap76+$vt_separador+$vt_com77+$vt_separador+$vt_tdc78+$vt_separador+$vt_mnom79+$vt_separador+$vt_meom80+$vt_separador
			$vt_text:=$vt_text+$vt_mbfcom81+$vt_separador+$vt_mbmcom82+$vt_separador+$vt_iom83+$vt_separador+$vt_inrom84+$vt_separador+$vt_mtom85+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  //tabla de montos de pago
			  //C_TEXT($vt_fp1;$vt_mdp2;$vt_gdp3)
			  //$vt_fp1:=""
			  //$vt_mdp2:=""
			  //$vt_gdp3:=""
			  //$vt_text:="TMP"+$vt_separador+$vt_fp1+$vt_separador+$vt_mdp2+$vt_separador+$vt_gdp3+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //telefono emisor
			C_TEXT:C284($vt_nt1)
			$vt_text:=""  //20160315 RCH
			If ([ACT_RazonesSociales:279]telefono:11#"")  //20151204 RCH. Cuando no habia telefono, el nodo iba vacio y el SII respondia con un error: (ENV-3-0) Error en Schema - [0] LSX-00009: data missing for type "#simple"
				$vt_nt1:=[ACT_RazonesSociales:279]telefono:11
				$vt_text:="TEL"+$vt_separador+$vt_nt1+$vt_separador+"\r"
			End if 
			  //IO_SendPacket ($ref;$vt_text)
			$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //ACT  ` actividades economicas emisor
			ARRAY TEXT:C222($at_acteco;0)
			AT_Text2Array (->$at_acteco;[ACT_Boletas:181]CL_acteco:28)
			If (Size of array:C274($at_acteco)=0)
				APPEND TO ARRAY:C911($at_acteco;"")
			End if 
			C_TEXT:C284($vt_aede1)
			For ($i;1;Size of array:C274($at_acteco))
				$vt_aede1:=$at_acteco{$i}
				$vt_text:="ACT"+$vt_separador+$vt_aede1+$vt_separador+"\r"
				  //IO_SendPacket ($ref;$vt_text)
				$vt_textFinal:=$vt_textFinal+$vt_text
			End for 
			
			  //  //impuesto y retenciones
			  //C_TEXT($vt_tdiora1;$vt_tior2;$vt_mdior3)
			  //$vt_tdiora1:="15"
			  //$vt_tior2:="0"
			  //$vt_mdior3:="0"
			  //$vt_text:="IMP"+$vt_separador+$vt_tdiora1+$vt_separador+$vt_tior2+$vt_separador+$vt_mdior3+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  //IMPOM
			  //C_TEXT($vt_tdioraom1;$vt_tiorom2;$vt_mdiorom3)
			  //$vt_tdioraom1:="15"
			  //$vt_tiorom2:="0"
			  //$vt_mdiorom3:="0"
			  //$vt_text:="IMPOM"+$vt_separador+$vt_tdioraom1+$vt_separador+$vt_tiorom2+$vt_separador+$vt_mdiorom3+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //detalle
			C_TEXT:C284($vt_nldd1;$vt_ide2;$vt_iar3;$vt_mbf4;$vt_mbmc5;$vt_puncf6;$vt_ndi7;$vt_ddi8;$vt_cdr9;$vt_udmdr10;$vt_pdr11;$vt_cdi12;$vt_fde13;$vt_fdv14;$vt_udm15;$vt_pdi16;$vt_pdd17;$vt_dm18;$vt_pd19;$vt_rm20;$vt_mdi21)
			
			  //DESC
			C_TEXT:C284($vt_tds1;$vt_vds2)
			
			
			  //ARRAY REAL($arACT_ValorDcto;0)
			$vr_sumaDetalle:=0
			C_LONGINT:C283($vl_lineas)
			C_POINTER:C301($ptr1;$ptr2)
			C_REAL:C285($vr_montoItem)
			$vl_lineas:=Num:C11(ACTcfg_OpcionesLineasDT ("ObtieneNumLineas"))
			If ($vl_lineas>60)
				$vl_lineas:=60  //maximo 60 para el sii. En act el maximo es 20
			End if 
			$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
			$vl_numLinea:=1
			For ($i;1;$vl_lineas)
				
				$ptr1:=Get pointer:C304("vtACT_SRbol_DetalleCargo"+String:C10($i)+"1")
				$ptr2:=Get pointer:C304("vrACT_SRbol_MontoCargo"+String:C10($i)+"1")
				$ptr3:=Get pointer:C304("vrACT_SRbol_CantidadCargo"+String:C10($i)+"1")
				$ptr4:=Get pointer:C304("vrACT_SRbol_UnitarioCargo"+String:C10($i)+"1")
				$ptr5:=Get pointer:C304("vbACT_SRbol_Afecto"+String:C10($i)+"1")
				$ptr6:=Get pointer:C304("vrACT_SRbol_MontoDcto"+String:C10($i)+"1")
				$ptr7:=Get pointer:C304("vlACT_SRbol_IDCargo"+String:C10($i)+"1")  // id cargo
				$ptr8:=Get pointer:C304("vtACT_SRbol_unidadCargo"+String:C10($i)+"1")  // 
				If ($ptr1->#"")
					  //20120531 RCH Se asigna monto fuera del if...
					$vr_montoItem:=$ptr2->
					  //If (($ptr2->>0) | ($i=1) | ($vt_idTipoSII="61"))  // cuando es la primera linea siempre tiene que entrar
					  //If (($ptr2->>0) | ($i=1) | ($vt_idTipoSII="61") | (($ptr2->=0) | ($ptr1->#"")))  // cuando es la primera linea siempre tiene que entrar
					If (($ptr2->>0) | ($i=1) | ($vt_idTipoSII="61") | ((($ptr2->=0) | ($ptr1->#"")) & ($ptr1->#"Descuento")))  // 20160408 RCH Se agrega validacion porque cuando era descuento que se informa en DESC no estaba entrando al else
						If (($ptr2->>=0))
							  //$vr_montoItem:=$ptr2->
							
							$vt_nldd1:=String:C10($vl_numLinea)
							$vt_ide2:=ST_Boolean2Str (($vt_idTipoSII="33") | ($vt_idTipoSII="61") | ($vt_idTipoSII="56");ST_Boolean2Str ($ptr5->;"";"1");"1")
							  //$vt_ide2:=Choose(((($vt_idTipoSII="61") | ($vt_idTipoSII="56")) & (([ACT_Boletas]codigo_referencia=1) | ([ACT_Boletas]codigo_referencia=2)));"";ST_Boolean2Str (($vt_idTipoSII="33") | ($vt_idTipoSII="61") | ($vt_idTipoSII="56");ST_Boolean2Str ($ptr5->;"";"1");"1"))  //si la NC o ND modifica monto, va vacío
							  //$vt_ide2:=Choose(((($vt_idTipoSII="61") | ($vt_idTipoSII="56")) & (([ACT_Boletas]codigo_referencia=1) | ([ACT_Boletas]codigo_referencia=2)));ST_Boolean2Str (($vt_idTipoSII="33") | ($vt_idTipoSII="61") | ($vt_idTipoSII="56");ST_Boolean2Str ($ptr5->;"";"1");"1");"")  //si la NC o ND modifica monto, va vacío
							$vt_iar3:=""
							$vt_mbf4:=""
							$vt_mbmc5:=""
							$vt_puncf6:=""
							  //$vt_ndi7:=Substring($ptr1->;1;80)  // maximo 80 caracteres
							$vt_ndi7:=Substring:C12(Replace string:C233($ptr1->;";";"");1;80)  //20141007 RCH Si va un ; es considerada otra columna
							
							$vt_ddi8:=""
							If (($vt_idTipoSII="33") | ($vt_idTipoSII="34"))
								If (r_enviaDesc=1)
									If (vtACT_TextoDescripcionFact#"")
										If ($ptr7->>=0)
											KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;$ptr7)
											C_TEXT:C284($t_mes;$t_year)
											If (Position:C15("&car_mes&";vtACT_TextoDescripcionFact)>0)
												$t_mes:=<>atXS_MonthNames{[ACT_Cargos:173]Mes:13}
											Else 
												$t_mes:=""
											End if 
											If (Position:C15("&car_year&";vtACT_TextoDescripcionFact)>0)
												$t_year:=String:C10([ACT_Cargos:173]Año:14)
											Else 
												$t_year:=""
											End if 
											$vt_ddi8:=vtACT_TextoDescripcionFact  //20151231 RCH
											If (($t_mes#"") | ($t_year#""))
												$vt_ddi8:=Replace string:C233($vt_ddi8;"&car_mes&";$t_mes)
												$vt_ddi8:=Replace string:C233($vt_ddi8;"&car_year&";$t_year)
											End if 
										End if 
									End if 
								End if 
								
							End if 
						End if 
						$vt_cdr9:=""
						$vt_udmdr10:=""
						$vt_pdr11:=""
						$vt_cdi12:=ST_Boolean2Str ($vr_montoItem>0;String:C10($ptr3->);"")
						$vt_cdi12:=Replace string:C233($vt_cdi12;<>tXS_RS_DecimalSeparator;".")
						$vt_fde13:=""
						$vt_fdv14:=""
						If ($ptr8->#"")
							$vt_udm15:=$ptr8->
						Else 
							$vt_udm15:=""
						End if 
						  //$vt_pdi16:=String($ptr4->)
						If (bACT_setDePruebas)  //20140809 RCH DTE
							$vt_pdi16:=String:C10($ptr4->)
						Else 
							If (($ptr7->#0) & ($ptr3->=1))
								KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;$ptr7)
								If ([ACT_Cargos:173]TasaIVA:21#0)
									If ($vr_montoItem=[ACT_Cargos:173]Monto_Neto:5)
										$vt_pdi16:=String:C10([ACT_Cargos:173]Monto_Afecto:27)
									Else 
										$vt_pdi16:=String:C10(Round:C94($vr_montoItem/(1+([ACT_Cargos:173]TasaIVA:21/100));<>vlACT_Decimales))
									End if 
								Else 
									$vt_pdi16:=String:C10($ptr4->)
								End if 
							Else 
								If ($ptr4->#0)
									  //20130312 RCH probar por cambio para soportar varias lineas afectas
									KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;$ptr7)
									
									If ([ACT_Cargos:173]TasaIVA:21#0)
										TRACE:C157
									End if 
									
									  //$vt_pdi16:=String(String(Round($ptr4->/(1+([ACT_Cargos]TasaIVA/100));<>vlACT_Decimales)))
									$vt_pdi16:=String:C10(Round:C94(($ptr4->/(1+([ACT_Cargos:173]TasaIVA:21/100)))/[ACT_Cargos:173]cantidad:65;<>vlACT_Decimales))  //20130828 Soporta cantidad
								Else 
									  //20160224 RCH SII soporta hasta 6 decimales para dte y 2 para boletas
									  //$vt_pdi16:=String(Round($vr_montoItem/$ptr3->;<>vlACT_Decimales))
									$l_decimales:=Choose:C955(($vt_idTipoSII="39") | ($vt_idTipoSII="41");2;6)
									$vt_pdi16:=String:C10(Round:C94($vr_montoItem/$ptr3->;$l_decimales))
									$vt_pdi16:=Replace string:C233($vt_pdi16;<>tXS_RS_DecimalSeparator;".")
								End if 
							End if 
						End if 
						$vt_pdd17:=""
						$vt_dm18:=ST_Boolean2Str ($vr_montoItem>0;String:C10($ptr6->);"")
						$vt_pd19:=""
						$vt_rm20:=""
						  //$vt_mdi21:=String($ptr2->)
						  //$vt_mdi21:=String($vr_montoItem)
						
						$vr_montoItem:=$vr_montoItem-$ptr6->
						
						
						If (($ptr7->#0) & ($ptr3->>=1) & ([ACT_Cargos:173]TasaIVA:21#0))
							$vt_mdi21:=String:C10(Round:C94(Num:C11($vt_pdi16)*Num:C11($vt_cdi12);<>vlACT_Decimales))
						Else 
							$vt_mdi21:=String:C10(Round:C94($vr_montoItem;<>vlACT_Decimales))
						End if 
						
						$vl_numLinea:=$vl_numLinea+1
						
						$vt_text:="DET"+$vt_separador+$vt_nldd1+$vt_separador+$vt_ide2+$vt_separador+$vt_iar3+$vt_separador+$vt_mbf4+$vt_separador+$vt_mbmc5+$vt_separador
						$vt_text:=$vt_text+$vt_puncf6+$vt_separador+$vt_ndi7+$vt_separador+$vt_ddi8+$vt_separador+$vt_cdr9+$vt_separador+$vt_udmdr10+$vt_separador
						$vt_text:=$vt_text+$vt_pdr11+$vt_separador+$vt_cdi12+$vt_separador+$vt_fde13+$vt_separador+$vt_fdv14+$vt_separador+$vt_udm15+$vt_separador
						$vt_text:=$vt_text+$vt_pdi16+$vt_separador+$vt_pdd17+$vt_separador+$vt_dm18+$vt_separador+$vt_pd19+$vt_separador+$vt_rm20+$vt_separador
						$vt_text:=$vt_text+$vt_mdi21+$vt_separador+"\r"
						  //IO_SendPacket ($ref;$vt_text)
						$vt_textFinal:=$vt_textFinal+$vt_text
						
						  //VALIDACION SUMA DETALLES
						$vr_sumaDetalle:=$vr_sumaDetalle+$ptr2->
					Else 
						  //DESC
						C_TEXT:C284($vt_tds1;$vt_vds2)
						$vt_tds1:="$"
						$vt_vds2:=""
						If ($ptr4->#0)
							$vt_vds2:=String:C10(Abs:C99($ptr4->))
						Else 
							$vt_vds2:=String:C10(Abs:C99(Round:C94($vr_montoItem/$ptr3->;<>vlACT_Decimales)))
						End if 
						If (Num:C11($vt_vds2)>0)
							$vt_text:="DESC"+$vt_separador+$vt_tds1+$vt_separador+$vt_vds2+$vt_separador+"\r"
							  //IO_SendPacket ($ref;$vt_text)
							$vt_textFinal:=$vt_textFinal+$vt_text
						End if 
						
						$vr_sumaDetalle:=$vr_sumaDetalle-Num:C11($vt_vds2)
						  //Else 
						  //APPEND TO ARRAY($arACT_ValorDcto;$ptr2->)
					End if 
					  //End if 
				Else 
					$i:=$vl_lineas
				End if 
			End for 
			
			  //codigos de items
			  //C_TEXT($vt_tc1;$vt_cd2)
			  //$vt_tc1:=""
			  //$vt_cd2:=""
			  //$vt_text:="ITEM"+$vt_separador+$vt_tc1+$vt_separador+$vt_cd2+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //subcantidades
			  //C_TEXT($vt_cd1;$vt_cddls2)
			  //$vt_cd1:=""
			  //$vt_cddls2:=""
			  //$vt_text:="SUB"+$vt_separador+$vt_cd1+$vt_separador+$vt_cddls2+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //Otra moneda
			  //C_TEXT($vt_pom1;$vt_com2;$vt_fc3;$vt_dom4;$vt_rom5;$vt_miom6)
			  //$vt_pom1:=""
			  //$vt_com2:=""
			  //$vt_fc3:=""
			  //$vt_dom4:=""
			  //$vt_rom5:=""
			  //$vt_miom6:=""
			  //$vt_text:="OMDET"+$vt_separador+$vt_pom1+$vt_separador+$vt_com2+$vt_separador+$vt_fc3+$vt_separador+$vt_dom4+$vt_separador+$vt_rom5+$vt_separador
			  //$vt_text:=$vt_text+$vt_miom6+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  //DESC
			  //C_TEXT($vt_tds1;$vt_vds2)
			  //$vt_tds1:=""
			  //$vt_vds2:=""
			  //$vt_text:="DESC"+$vt_separador+$vt_tds1+$vt_separador+$vt_vds2+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  //Subrecargos
			  //C_TEXT($vt_tr1;$vt_vdr2)
			  //$vt_tr1:=""
			  //$vt_vdr2:=""
			  //$vt_text:="CAR"+$vt_separador+$vt_tr1+$vt_separador+$vt_vdr2+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  //cod impuesto adicional ret
			  //C_TEXT($vt_cior1)
			  //$vt_cior1:=""
			  //$vt_text:="IMPDET"+$vt_separador+$vt_cior1+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  //subtotales informativos
			  //C_TEXT($vt_ns1;$vt_g2;$vt_o3;$vt_sn4;$vt_si5;$vt_siaoe6;$vt_snaoe7;$vt_vs8)
			  //$vt_ns1:=""
			  //$vt_g2:=""
			  //$vt_o3:=""
			  //$vt_sn4:=""
			  //$vt_si5:=""
			  //$vt_siaoe6:=""
			  //$vt_snaoe7:=""
			  //$vt_vs8:=""
			  //$vt_text:="SUBTOT"+$vt_separador+$vt_ns1+$vt_separador+$vt_g2+$vt_separador+$vt_o3+$vt_separador+$vt_sn4+$vt_separador+$vt_si5+$vt_separador
			  //$vt_text:=$vt_text+$vt_siaoe6+$vt_separador+$vt_snaoe7+$vt_separador+$vt_vs8+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //  //LINDETSI
			  //C_TEXT($vt_nlddsi1)
			  //$vt_nlddsi1:=""
			  //$vt_text:="LINDETSI"+$vt_separador+$vt_nlddsi1+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //descuentos y recargos globales
			C_TEXT:C284($vt_nldr1;$vt_tdm2;$vt_dddor3;$vt_ueqseev4;$vt_vddor5;$vt_vddorom6;$vt_ideofdr7)
			C_REAL:C285(vrACTdte_dctoRecargo)
			C_TEXT:C284(vtACTdte_Tipo)  //20161113 RCH
			If (vrACTdte_dctoRecargo=0)
				  //$vt_nldr1:=""  //"1"
				  //$vt_tdm2:=""  //"D"
				  //$vt_dddor3:=""
				  //$vt_ueqseev4:=""  //"$"
				  //$vt_vddor5:=""  //String(AT_GetSumArray (->$arACT_ValorDcto))
				  //$vt_vddorom6:=""
				  //$vt_ideofdr7:=""
			Else 
				  // una linea para el descuento afecto y otra para el descuento exento
				For ($x;1;2)
					If ($x=1)
						$vr_monto:=vrACTdte_DescuentoAfecto
						$vt_indicador:=""
					Else 
						$vr_monto:=vrACTdte_DescuentoExento
						$vt_indicador:="1"
					End if 
					If ($vr_monto#0)
						$vt_nldr1:="1"
						$vt_tdm2:=ST_Boolean2Str ($vr_monto>0;"R";"D")
						$vt_dddor3:=ST_Boolean2Str ($vr_monto>0;"Recargo global";"Descuento global")
						$vt_ueqseev4:="%"
						$vt_ueqseev4:=Choose:C955(vtACTdte_Tipo="";$vt_ueqseev4;vtACTdte_Tipo)  //20170411 RCH. INtegrado v12
						  //$vt_vddor5:=String(Abs(vrACTdte_DescuentoAfecto+vrACTdte_DescuentoExento+vrACTdte_DescuentoGlobal))
						$vt_vddor5:=String:C10(Abs:C99($vr_monto))
						$vt_vddorom6:=""
						$vt_ideofdr7:=$vt_indicador
						
						$vt_text:="DESCG"+$vt_separador+$vt_nldr1+$vt_separador+$vt_tdm2+$vt_separador+$vt_dddor3+$vt_separador+$vt_ueqseev4+$vt_separador+$vt_vddor5+$vt_separador
						$vt_text:=$vt_text+$vt_vddorom6+$vt_separador+$vt_ideofdr7+$vt_separador+"\r"
						  //IO_SendPacket ($ref;$vt_text)
						$vt_textFinal:=$vt_textFinal+$vt_text
						
						  //para validacion
						$vr_sumaDetalle:=$vr_sumaDetalle+$vr_monto
					End if 
				End for 
			End if 
			
			  //referencias globales
			C_LONGINT:C283($vl_recNum;$vl_idDctoRel;$vl_idDcto;$vl_numLinea)
			C_DATE:C307($vd_fechaValida)
			$vl_recNum:=Record number:C243([ACT_Boletas:181])
			$vl_idDctoRel:=[ACT_Boletas:181]ID_DctoAsociado:19
			$vd_fechaValida:=KRL_GetDateFieldData (->[ACT_Boletas:181]ID:1;->$vl_idDctoRel;->[ACT_Boletas:181]FechaEmision:3)
			$vl_idDcto:=KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->$vl_idDctoRel;->[ACT_Boletas:181]ID_Documento:13)
			$vl_numLinea:=1
			
			C_TEXT:C284($vt_ndldr1;$vt_tddr2;$vt_igdr3;$vt_fdr4;$vt_roc5;$vt_fdr6;$vt_cr7;$vt_rdr8)
			If ([ACT_Boletas:181]ID_Estado:20=7)  // 7 set de pruebas
				$vt_ndldr1:=String:C10($vl_numLinea)
				$vt_tddr2:="SET"
				$vt_igdr3:=""
				$vt_fdr4:="1"
				$vt_roc5:=""
				$vd_fecha:=Current date:C33(*)
				$vt_fdr6:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->$vd_fecha)
				$vt_cr7:=""
				$vt_rdr8:="CASO "+vt_variableCaso
				$vl_numLinea:=$vl_numLinea+1
				
				$vt_text:="REF"+$vt_separador+$vt_ndldr1+$vt_separador+$vt_tddr2+$vt_separador+$vt_igdr3+$vt_separador+$vt_fdr4+$vt_separador+$vt_roc5+$vt_separador
				$vt_text:=$vt_text+$vt_fdr6+$vt_separador+$vt_cr7+$vt_separador+$vt_rdr8+$vt_separador+"\r"
				  //IO_SendPacket ($ref;$vt_text)
				$vt_textFinal:=$vt_textFinal+$vt_text
			End if 
			
			If (([ACT_Boletas:181]ID_DctoAsociado:19#0) | ([ACT_Boletas:181]Referencia_TipoDocumento:37#""))
				$vt_ndldr1:=String:C10($vl_numLinea)
				  //$vt_tddr2:=ACTdte_GeneraArchivo ("FolioDesdeIdBolActual";->$vl_idDcto)
				If ([ACT_Boletas:181]ID_DctoAsociado:19#0)
					$vt_tddr2:=KRL_GetTextFieldData (->[ACT_Boletas:181]ID:1;->$vl_idDctoRel;->[ACT_Boletas:181]codigo_SII:33)
					$vt_igdr3:=""
					$vt_fdr4:=String:C10(KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->$vl_idDctoRel;->[ACT_Boletas:181]Numero:11))
					$vt_roc5:=""
					$vt_fdr6:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->$vd_fechaValida)
					GOTO RECORD:C242([ACT_Boletas:181];$vl_recNum)
					$vt_cr7:=String:C10([ACT_Boletas:181]codigo_referencia:31)
					  //$vt_rdr8:=[ACT_Boletas]Observacion
					$vt_rdr8:=[ACT_Boletas:181]Referencia_Razon:40  //20141007 RCH Cuando se emite una NC se escribe este campo y controla el tamaño maximo.
					If ($vt_rdr8="")
						TRACE:C157
					End if 
				Else 
					$vt_tddr2:=[ACT_Boletas:181]Referencia_TipoDocumento:37
					$vt_igdr3:=""
					$vt_fdr4:=[ACT_Boletas:181]Referencia_FolioDocumento:38
					$vt_roc5:=""
					$vt_fdr6:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->[ACT_Boletas:181]Referencia_FechaDocumento:39)
					$vt_cr7:=String:C10([ACT_Boletas:181]codigo_referencia:31)
					$vt_rdr8:=[ACT_Boletas:181]Referencia_Razon:40
				End if 
				
				$vt_text:="REF"+$vt_separador+$vt_ndldr1+$vt_separador+$vt_tddr2+$vt_separador+$vt_igdr3+$vt_separador+$vt_fdr4+$vt_separador+$vt_roc5+$vt_separador
				$vt_text:=$vt_text+$vt_fdr6+$vt_separador+$vt_cr7+$vt_separador+$vt_rdr8+$vt_separador+"\r"
				  //IO_SendPacket ($ref;$vt_text)
				$vt_textFinal:=$vt_textFinal+$vt_text
			Else 
				  //If ($vl_numLinea=1)
				  //$vt_ndldr1:=""
				  //$vt_tddr2:=""
				  //$vt_igdr3:=""
				  //$vt_fdr4:=""
				  //$vt_roc5:=""
				  //$vt_fdr6:=""
				  //$vt_cr7:=""
				  //$vt_rdr8:=""
				  //
				  //$vt_text:="REF"+$vt_separador+$vt_ndldr1+$vt_separador+$vt_tddr2+$vt_separador+$vt_igdr3+$vt_separador+$vt_fdr4+$vt_separador+$vt_roc5+$vt_separador
				  //$vt_text:=$vt_text+$vt_fdr6+$vt_separador+$vt_cr7+$vt_separador+$vt_rdr8+$vt_separador+"\r"
				  //IO_SendPacket ($ref;$vt_text)
				  //$vt_textFinal:=$vt_textFinal+$vt_text
				  //End if 
			End if 
			
			  //  //comisiones y otros cargos
			  //C_TEXT($vt_nl1;$vt_tm2;$vt_g3;$vt_tc4;$vt_vcn5;$vt_vce6;$vt_vicuoc7)
			  //$vt_nl1:=""
			  //$vt_tm2:=""
			  //$vt_g3:=""
			  //$vt_tc4:=""
			  //$vt_vcn5:=""
			  //$vt_vce6:=""
			  //$vt_vicuoc7:=""
			  //$vt_text:="COMOC"+$vt_separador+$vt_nl1+$vt_separador+$vt_tm2+$vt_separador+$vt_g3+$vt_separador+$vt_tc4+$vt_separador+$vt_vcn5+$vt_separador
			  //$vt_text:=$vt_text+$vt_vce6+$vt_separador+$vt_vicuoc7+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			  //$vt_textFinal:=$vt_textFinal+$vt_text
			  //CLOSE DOCUMENT($ref)
			
			If (([ACT_Boletas:181]Monto_Total:6#$vr_sumaDetalle) & (Not:C34(bACT_setDePruebas)))  //20140809 RCH DTE
				TRACE:C157
				  //DELETE DOCUMENT($vt_retorno)
				$vt_retorno:=""
			Else 
				$vt_retorno:=$vt_textFinal
			End if 
			
			  //End if 
			  //Else 
			  //$vt_retorno:=""
			  //End if 
		End if 
	: ($vt_accion="GuardaBlobXMLDocumento")
		C_BLOB:C604($xBlob)
		$vl_idDcto:=Num:C11($ptr1->)
		$xBlob:=$ptr2->
		REDUCE SELECTION:C351([ACT_Boletas:181];0)
		
	: ($vt_accion="LlenaVariablesDetalle")
		  //ACTcfg_InitBolArrays  //20150807 RCH Se limpiaba el arreglo con los ids
		ACTcfg_OpcionesLineasDT ("DeclaraVariables")
		$vl_lineas:=Num:C11(ACTcfg_OpcionesLineasDT ("ObtieneNumLineas"))
		$vb_hayIDCargo:=False:C215
		If (Not:C34(Is nil pointer:C315($ptr7)))
			$vb_hayIDCargo:=True:C214
		End if 
		
		If (Size of array:C274($ptr1->)<=$vl_lineas)
			$NumVars:=Size of array:C274($ptr1->)
		Else 
			$NumVars:=$vl_lineas
		End if 
		
		$pos:=1
		For ($i;1;$vl_lineas)
			$vy_pointer1:=Get pointer:C304("vtACT_SRbol_DetalleCargo"+String:C10($i)+"1")
			$vy_pointer2:=Get pointer:C304("vrACT_SRbol_MontoCargo"+String:C10($i)+"1")
			$vy_pointer3:=Get pointer:C304("vrACT_SRbol_CantidadCargo"+String:C10($i)+"1")
			$vy_pointer4:=Get pointer:C304("vrACT_SRbol_UnitarioCargo"+String:C10($i)+"1")
			$vy_pointer5:=Get pointer:C304("vbACT_SRbol_Afecto"+String:C10($i)+"1")
			$vy_pointer6:=Get pointer:C304("vrACT_SRbol_MontoDcto"+String:C10($i)+"1")
			$vy_pointer7:=Get pointer:C304("vlACT_SRbol_IDCargo"+String:C10($i)+"1")
			$vy_pointer8:=Get pointer:C304("vtACT_SRbol_unidadCargo"+String:C10($i)+"1")  // 
			If ($i<=Size of array:C274($ptr1->))
				$vy_pointer1->:=$ptr1->{$i}
				$vy_pointer2->:=$ptr2->{$i}
				$vy_pointer3->:=$ptr3->{$i}
				$vy_pointer4->:=$ptr4->{$i}
				$vy_pointer5->:=$ptr5->{$i}
				$vy_pointer6->:=$ptr6->{$i}
				If ($vb_hayIDCargo)
					$vy_pointer7->:=$ptr7->{$i}
				Else 
					$vy_pointer7->:=0
				End if 
				If (Not:C34(Is nil pointer:C315($ptr8)))
					If ($ptr8->{$i}#"")
						$vy_pointer8->:=$ptr8->{$i}
					Else 
						$vy_pointer8->:=""
					End if 
				Else 
					$vy_pointer8->:=""
				End if 
			Else 
				$vy_pointer1->:=""
				$vy_pointer2->:=0
				$vy_pointer3->:=0
				$vy_pointer4->:=0
				$vy_pointer5->:=False:C215
				$vy_pointer6->:=0
				$vy_pointer7->:=0
				$vy_pointer8->:=""
			End if 
			$pos:=$pos+1
		End for 
		
		If (Size of array:C274($ptr1->)>$vl_lineas)
			$vy_pointer1:=Get pointer:C304("vtACT_SRbol_DetalleCargo"+String:C10($vl_lineas)+"1")
			$vy_pointer2:=Get pointer:C304("vrACT_SRbol_MontoCargo"+String:C10($vl_lineas)+"1")
			$vy_pointer3:=Get pointer:C304("vrACT_SRbol_CantidadCargo"+String:C10($vl_lineas)+"1")
			$vy_pointer4:=Get pointer:C304("vrACT_SRbol_UnitarioCargo"+String:C10($vl_lineas)+"1")
			$vy_pointer5:=Get pointer:C304("vbACT_SRbol_Afecto"+String:C10($vl_lineas)+"1")
			$vy_pointer6:=Get pointer:C304("vrACT_SRbol_MontoDcto"+String:C10($vl_lineas)+"1")
			$vy_pointer7:=Get pointer:C304("vlACT_SRbol_IDCargo"+String:C10($vl_lineas)+"1")
			$vy_pointer8:=Get pointer:C304("vtACT_SRbol_unidadCargo"+String:C10($vl_lineas)+"1")
			
			  //$vy_pointer1->:="Otros"
			  //$vy_pointer2->:=$ptr2->{$vl_lineas}
			  //$vy_pointer3->:=0
			  //$vy_pointer4->:=0
			  //$vy_pointer5->:=False
			  //$vy_pointer6->:=0
			  //$vy_pointer7->:=0
			  //$vy_pointer8->:=""
			  //
			  //For ($t;$pos;Size of array($ptr1->))
			  //$vy_pointer2->:=$vy_pointer2->+$ptr2->{$t}
			  //End for 
			
			  // 20161123 RCH
			$vy_pointer1->:="Otros"
			$vy_pointer2->:=$ptr2->{$vl_lineas}
			$vy_pointer3->:=1  //cantidad
			$vy_pointer4->:=$ptr4->{$vl_lineas}  //unitario
			$vy_pointer5->:=False:C215
			$vy_pointer6->:=$ptr6->{$vl_lineas}  //descuento
			$vy_pointer7->:=0
			$vy_pointer8->:=""
			For ($t;$pos;Size of array:C274($ptr1->))
				$vy_pointer2->:=$vy_pointer2->+$ptr2->{$t}
				  //$vy_pointer4->:=$vy_pointer4->+$ptr4->{$t}
				$vy_pointer4->:=0  // 20170218 RCH. Ticket 174963. si hay mas líneas que lo configurado, se deja en 0 para calculo de monto unitario
				$vy_pointer6->:=$vy_pointer6->+$ptr6->{$t}
			End for 
			
		End if 
		
	: ($vt_accion="CodigosDeReferencia")
		If (Not:C34(Is nil pointer:C315($ptr1)))
			ARRAY TEXT:C222($atACT_referencias;0)
			APPEND TO ARRAY:C911($atACT_referencias;"Anula Documento de Referencia")
			APPEND TO ARRAY:C911($atACT_referencias;"Corrige Texto Documento de Referencia")
			APPEND TO ARRAY:C911($atACT_referencias;"Corrige montos")
			
			For ($i;1;Size of array:C274($atACT_referencias))
				If (Find in array:C230($ptr1->;$atACT_referencias{$i})=-1)
					APPEND TO ARRAY:C911($ptr1->;$atACT_referencias{$i})
				End if 
			End for 
		End if 
		
End case 

$0:=$vt_retorno