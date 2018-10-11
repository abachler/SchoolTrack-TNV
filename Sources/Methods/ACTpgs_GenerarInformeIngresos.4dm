//%attributes = {}
  //ACTpgs_GenerarInformeIngresos

C_REAL:C285($totalDisp)
C_BOOLEAN:C305($itemsInexistentes)
C_TEXT:C284($text)
READ ONLY:C145([ACT_Pagos:172])
ACTpgs_ArraysInfIngresos 
$totalDisp:=0
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Venta_Rapida:10=False:C215;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215;*)
Case of 
	: (cb_XApdo=1)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=0)
		$tit1:="Ingresos por Apoderado"
		$fileName1:=__ ("IngresosApdo_")
	: (cb_XCta=1)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21#0)
		$tit1:=__ ("Ingresos por Cuenta")
		$fileName1:=__ ("IngresosCta_")
		If (cb_SoloActivas=1)
			ARRAY LONGINT:C221($aRNTodosPagos;0)
			ARRAY LONGINT:C221($aIdsCtas;0)
			ARRAY LONGINT:C221($aRnPagosDefinitiva;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$aRNTodosPagos;"")
			SELECTION TO ARRAY:C260([ACT_Pagos:172]ID_CtaCte:21;$aIdsCtas)
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			For ($u;1;Size of array:C274($aIdsCtas))
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$aIdsCtas{$u})
				If ([ACT_CuentasCorrientes:175]Estado:4)
					INSERT IN ARRAY:C227($aRNPagosDefinitiva;1;1)
					$aRNPagosDefinitiva{1}:=$aRNTodosPagos{$u}
				End if 
			End for 
			CREATE SELECTION FROM ARRAY:C640([ACT_Pagos:172];$aRNPagosDefinitiva)
		End if 
	: (cb_XCruzado=1)
		QUERY:C277([ACT_Pagos:172])
		$tit1:=__ ("Ingresos Cruzados")
		$fileName1:=__ ("IngresosCruzados_")
End case 
Case of 
	: (b1=1)
		$year:=Year of:C25(Current date:C33(*))
		$month:=Month of:C24(Current date:C33(*))
		$day:=Day of:C23(Current date:C33(*))
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2=Current date:C33(*))
		$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
		$titulo:=$tit1+__ (" para el dia  ")+String:C10($day)+__ (" de ")+<>atXS_MonthNames{$month}+__ (" de ")+String:C10($year)+"\r\n"+"\r\n"+"\r\n"
	: (b3=1)
		$year:=viAño
		$dateIni:=DT_GetDateFromDayMonthYear (1;vi_SelectedMonth;$year)
		$lastDay:=DT_GetLastDay (vi_SelectedMonth;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;vi_SelectedMonth;$year)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$DateEnd)
		$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
		$titulo:=$tit1+__ (" para el mes de ")+<>atXS_MonthNames{vi_SelectedMonth}+" "+String:C10($year)+"\r\n"+"\r\n"+"\r\n"
	: (b5=1)
		$year:=viAño2
		$dateIni:=DT_GetDateFromDayMonthYear (1;1;$year)
		$lastDay:=DT_GetLastDay (12;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;12;$year)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$DateEnd)
		$fileName:=String:C10($year)
		$titulo:=$tit1+" para el año "+String:C10($year)+"\r\n"+"\r\n"+"\r\n"
	: (b6=1)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=vd_Fecha1;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=vd_Fecha2)
		$fechaInicial:=Replace string:C233(Replace string:C233(vt_Fecha1;"/";"-");":";"-")  //como va en el nombre del archivo, sacamos los caracteres que delimitan directorios tanto en MAC como en PC
		$fechaFinal:=Replace string:C233(Replace string:C233(vt_Fecha2;"/";"-");":";"-")
		$fileName:=$fechaInicial+__ ("al")+$fechaFinal
		$titulo:=$tit1+__ (" entre el ")+vt_Fecha1+__ (" y el ")+vt_Fecha2+"\r\n"+"\r\n"+"\r\n"
End case 
$fileName:=$fileName1+$fileName
If (SYS_IsWindows )
	$fileName:=$fileName+".txt"
End if 
If (Records in selection:C76([ACT_Pagos:172])>0)
	$r:=CD_Dlog (0;__ ("AccountTrack generará un archivo Excel con los ")+Lowercase:C14($tit1)+__ (" del período seleccionado. Esta operación puede ser larga. ¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
	If ($r=1)
		
		$ref:=ACTabc_CreaDocumento ("Libro de Ingresos"+Folder separator:K24:12+"Ventas Normales";$fileName)
		
		If (ok=1)
			USE CHARACTER SET:C205("windows-1252";0)
			  // Modificado por: Saúl Ponce (23-02-2017) Ticket 175398 - La referencia se obtiene con ACTabc_CreaDocumento
			  // $ref:=Create document($filePath;"TEXT")
			If ($ref#?00:00:00?)
				IO_SendPacket ($ref;$titulo)
				
				ACTinit_LoadFdPago (False:C215;True:C214)  //20140416 RCH Para leer forma de pago Webpay
				
				ARRAY LONGINT:C221(aDistinctItems;0)
				KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				AT_DistinctsFieldValues (->[ACT_Cargos:173]Ref_Item:16;->aDistinctItems)
				
				C_TEXT:C284($vt_prefijoItems;$vt_prefijoCategorias)
				If (cb_AgruparPorCategorias=1)
					$vt_prefijoItems:="Ítem - "
					$vt_prefijoCategorias:="Categoría - "
					READ ONLY:C145([xxACT_Items:179])
					READ ONLY:C145([xxACT_ItemsCategorias:98])
					QUERY WITH ARRAY:C644([xxACT_Items:179]ID:1;aDistinctItems)
					AT_Initialize (->aDistinctItems)
					ARRAY LONGINT:C221($al_recNum;0)
					ARRAY LONGINT:C221($al_posicionesCats;0)
					LONGINT ARRAY FROM SELECTION:C647([xxACT_Items:179];$al_recNum)
					For ($i;1;Size of array:C274($al_recNum))
						REDUCE SELECTION:C351([xxACT_Items:179];0)
						REDUCE SELECTION:C351([xxACT_ItemsCategorias:98];0)
						KRL_GotoRecord (->[xxACT_Items:179];$al_recNum{$i})
						If ([xxACT_Items:179]ID_Categoria:8#0)
							KRL_FindAndLoadRecordByIndex (->[xxACT_ItemsCategorias:98]ID:2;->[xxACT_Items:179]ID_Categoria:8)
						End if 
						If (Records in selection:C76([xxACT_ItemsCategorias:98])=1)
							If (Find in array:C230(aDistinctItems;[xxACT_ItemsCategorias:98]ID:2)=-1)
								APPEND TO ARRAY:C911(aDistinctItems;[xxACT_ItemsCategorias:98]ID:2)
								APPEND TO ARRAY:C911($al_posicionesCats;[xxACT_ItemsCategorias:98]Posicion:3)
							End if 
						Else 
							If (Find in array:C230(aDistinctItems;[xxACT_Items:179]ID:1)=-1)
								APPEND TO ARRAY:C911(aDistinctItems;[xxACT_Items:179]ID:1)
								APPEND TO ARRAY:C911($al_posicionesCats;989898)  //se asigna un número grande para el orden
							End if 
						End if 
					End for 
					  //ordeno según orden de las categorías
					ARRAY LONGINT:C221($al_ordenCats;0)
					COPY ARRAY:C226($al_posicionesCats;$al_ordenCats)
					SORT ARRAY:C229($al_ordenCats;>)
					AT_OrderArraysByArray (-99999;->$al_ordenCats;->$al_posicionesCats;->aDistinctItems)
				End if 
				
				If (Size of array:C274(aDistinctItems)=0)
					AT_Insert (0;1;->aDistinctItems)
				End if 
				ARRAY LONGINT:C221(aIDItemdeCargo;0)
				ARRAY POINTER:C280(aPointerItems;0)
				ARRAY POINTER:C280(aPointerTotales;0)
				ARRAY TEXT:C222(aHeaders;0)
				ARRAY LONGINT:C221(aIDItemdeCargo;Size of array:C274(aDistinctItems))
				ARRAY POINTER:C280(aPointerItems;Size of array:C274(aDistinctItems))
				ARRAY POINTER:C280(aPointerTotales;Size of array:C274(aDistinctItems)+Size of array:C274(atACT_FormasdePago)+1)
				Case of 
					: (cb_XApdo=1)
						$index:=16
					: (cb_XCta=1)
						$index:=18
					: (cb_XCruzado=1)
						$index:=20
				End case 
				ARRAY TEXT:C222(aHeaders;Size of array:C274(aDistinctItems)+$index+Size of array:C274(atACT_FormasdePago))
				
				READ ONLY:C145([ACT_Cargos:173])
				C_BOOLEAN:C305($vb_hayVR)
				For ($x;1;Size of array:C274(aPointerItems))
					QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=aDistinctItems{$x})
					aPointerItems{$x}:=Get pointer:C304("arItems"+String:C10($x))
					aIDItemdeCargo{$x}:=[xxACT_Items:179]ID:1
					If (Records in selection:C76([xxACT_Items:179])=1)
						If ([xxACT_Items:179]Glosa:2#"")
							$glosa:=Replace string:C233([xxACT_Items:179]Glosa:2;"\r\n";"_")
							$glosa:=Replace string:C233($glosa;"\t";" ")
							If ([xxACT_Items:179]VentaRapida:3)
								aHeaders{$index+(($x)+Size of array:C274(atACT_FormasdePago))}:="(1) "+$vt_prefijoItems+$glosa
								$vb_hayVR:=True:C214
							Else 
								aHeaders{$index+(($x)+Size of array:C274(atACT_FormasdePago))}:=$vt_prefijoItems+$glosa
							End if 
						Else 
							aHeaders{$index+(($x)+Size of array:C274(atACT_FormasdePago))}:=$vt_prefijoItems+"Sin Nombre"
						End if 
					Else 
						READ ONLY:C145([xxACT_ItemsCategorias:98])
						QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=aDistinctItems{$x})
						If (Records in selection:C76([xxACT_ItemsCategorias:98])=1) & (cb_AgruparPorCategorias=1)
							aPointerItems{$x}:=Get pointer:C304("arItems"+String:C10($x))
							aIDItemdeCargo{$x}:=[xxACT_ItemsCategorias:98]ID:2
							aHeaders{$index+(($x)+Size of array:C274(atACT_FormasdePago))}:=$vt_prefijoCategorias+[xxACT_ItemsCategorias:98]Nombre:1
						Else 
							aHeaders{$index+(($x)+Size of array:C274(atACT_FormasdePago))}:=$vt_prefijoItems+"Definición Inexistente"
						End if 
					End if 
				End for 
				For ($xx;1;Size of array:C274(aPointerTotales))
					aPointerTotales{$xx}:=Get pointer:C304("vrTotales"+String:C10($xx))
				End for 
				AT_Insert (0;1;->aPointerItems;->aPointerTotales;->aIDItemdeCargo;->aHeaders)
				aPointerItems{Size of array:C274(aPointerItems)}:=Get pointer:C304("arItems"+String:C10($x))
				aPointerTotales{Size of array:C274(aPointerTotales)}:=Get pointer:C304("vrTotales"+String:C10($xx))
				aIDItemdeCargo{Size of array:C274(aIDItemdeCargo)}:=-1
				aHeaders{Size of array:C274(aHeaders)}:="Cargos Especiales"
				
				aHeaders{1}:="Fecha"
				aHeaders{2}:="Nº Pago"
				aHeaders{3}:="Ingresado Por"
				aHeaders{4}:="Doc(s). Trib(s)."
				aHeaders{5}:="Emitido(s) Por"
				Case of 
					: (cb_XApdo=1)
						aHeaders{6}:="Apoderado"
						aHeaders{7}:="Identificador Nacional"
						$nextIndex:=8
					: (cb_XCta=1)
						aHeaders{6}:="Cuenta"
						aHeaders{7}:="Codigo"
						aHeaders{8}:="Nivel"
						aHeaders{9}:="Curso"
						$nextIndex:=10
					: (cb_XCruzado=1)
						aHeaders{6}:="Apoderado"
						aHeaders{7}:="Identificador Nacional"
						$nextIndex:=8
				End case 
				aHeaders{$nextIndex}:="Familia(s)"
				$nextIndex:=$nextIndex+1
				
				  //se quitan las notas de crédito pero se utilizan al final
				CREATE SET:C116([ACT_Pagos:172];"pagosTodos")
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=-12)
				CREATE SET:C116([ACT_Pagos:172];"pagosNC")
				DIFFERENCE:C122("pagosTodos";"pagosNC";"pagosTodos")
				USE SET:C118("pagosTodos")
				
				
				ARRAY LONGINT:C221($aRecNumPagos;0)
				ARRAY TEXT:C222($atACTpgs_Monedas;0)
				ARRAY REAL:C219($arACTpgs_MontosMoneda;0)
				ARRAY REAL:C219($arACTpgs_Paridades;0)
				
				ARRAY LONGINT:C221($alACT_idFormaDePago;0)
				
				SELECTION TO ARRAY:C260([ACT_Pagos:172]Fecha:2;aFechaPago;[ACT_Pagos:172]ID:1;aIDPago;[ACT_Pagos:172]IngresadoPor:25;atIngresoPago;[ACT_Pagos:172]Monto_Pagado:5;aMontoPago;[ACT_Pagos:172]forma_de_pago_new:31;aFormaPago;[ACT_Pagos:172]ID_Apoderado:3;aIDApdo;[ACT_Pagos:172]Saldo:15;aDispPago;[ACT_Pagos:172]ID_CtaCte:21;aIDCta;[ACT_Pagos:172]Lugar_de_Pago:18;aLugarPago)
				SELECTION TO ARRAY:C260([ACT_Pagos:172]Moneda:27;$atACTpgs_Monedas;[ACT_Pagos:172]MontoEnMoneda:28;$arACTpgs_MontosMoneda;[ACT_Pagos:172]ValorParidad:29;$arACTpgs_Paridades;[ACT_Pagos:172]id_forma_de_pago:30;$alACT_idFormaDePago)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$aRecNumPagos)
				
				ARRAY REAL:C219($aDispPago;0)
				
				COPY ARRAY:C226(aDispPago;$aDispPago)
				$aDispPago{0}:=0
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->$aDispPago;">";->$DA_Return)
				If (Size of array:C274($DA_Return)>0)
					aHeaders{$nextIndex}:="Disponible"
					$nextIndex:=$nextIndex+1
					$vb_disponible:=True:C214
				Else 
					AT_Delete ($nextIndex;1;->aHeaders)
					$vb_disponible:=False:C215
				End if 
				
				ARRAY TEXT:C222($aLugarPago;0)
				COPY ARRAY:C226(aLugarPago;$aLugarPago)
				$aLugarPago{0}:=""
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->$aLugarPago;"#";->$DA_Return)
				If (Size of array:C274($DA_Return)>0)
					aHeaders{$nextIndex}:="Lugar de Pago"
					$nextIndex:=$nextIndex+1
					$vb_lugar:=True:C214
				Else 
					AT_Delete ($nextIndex;1;->aHeaders)
					$vb_lugar:=False:C215
				End if 
				
				$vl_index2NoDesglosado:=$nextIndex+6
				
				ARRAY TEXT:C222($aFormaPago;0)
				COPY ARRAY:C226(aFormaPago;$aFormaPago)
				AT_DistinctsArrayValues (->$aFormaPago)
				AT_DistinctsArrayValues (->$alACT_idFormaDePago)
				For ($i;Size of array:C274(atACT_FormasdePago);1;-1)
					$pos:=Find in array:C230($alACT_idFormaDePago;alACT_FormasdePagoID{$i})
					If ($pos=-1)
						DELETE FROM ARRAY:C228(atACT_FormasdePago;$i;1)
						DELETE FROM ARRAY:C228(aHeaders;$nextIndex;1)
						DELETE FROM ARRAY:C228(alACT_FormasdePagoID;$i;1)
					End if 
				End for 
				
				For ($n;1;Size of array:C274(atACT_FormasdePago))
					aHeaders{$nextIndex}:=atACT_FormasdePago{$n}
					$nextIndex:=$nextIndex+1
				End for 
				
				C_LONGINT:C283($vlACT_posicion;$vlACT_cantidad)
				C_BOOLEAN:C305($vb_MultiMoneda)
				ARRAY TEXT:C222($atACTpgs_Monedas2;0)
				
				$atACTpgs_Monedas{0}:=ST_GetWord (ACT_DivisaPais ;1;";")
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->$atACTpgs_Monedas;"#";->$DA_Return)
				If (Size of array:C274($DA_Return)>0)
					COPY ARRAY:C226($atACTpgs_Monedas;$atACTpgs_Monedas2)
					AT_DistinctsArrayValues (->$atACTpgs_Monedas2)
					$vlACT_posicion:=6
					$vlACT_cantidad:=Size of array:C274($atACTpgs_Monedas2)+1
					AT_Insert ($vlACT_posicion;$vlACT_cantidad;->aHeaders)
					For ($v;1;Size of array:C274($atACTpgs_Monedas2))
						aHeaders{$vlACT_posicion}:=$atACTpgs_Monedas2{$v}
						$vlACT_posicion:=$vlACT_posicion+1
						$nextIndex:=$nextIndex+1
					End for 
					aHeaders{$vlACT_posicion}:="Valor Paridad"
					$nextIndex:=$nextIndex+1
					$vb_MultiMoneda:=True:C214
				Else 
					$vb_MultiMoneda:=False:C215
				End if 
				
				
				
				ARRAY POINTER:C280(aPointerFormasdePago;0)
				ARRAY POINTER:C280(aPointerFormasdePago;Size of array:C274(atACT_FormasdePago))
				For ($fdp;1;Size of array:C274(atACT_FormasdePago))
					aPointerFormasdePago{$fdp}:=Get pointer:C304("arFDP"+String:C10($fdp))
				End for 
				
				If (Find in array:C230($alACT_idFormaDePago;-4)#-1)
					aHeaders{$nextIndex}:="Fecha Cheque al Día / Letra"
					$nextIndex:=$nextIndex+1
					aHeaders{$nextIndex}:="Fecha Cheque a Fecha"
					$nextIndex:=$nextIndex+1
					aHeaders{$nextIndex}:="Serie Cheque / Letra"
					$nextIndex:=$nextIndex+1
					aHeaders{$nextIndex}:="Banco Cheque"
					$nextIndex:=$nextIndex+1
					aHeaders{$nextIndex}:="Cod. Banco Cheque"
					$nextIndex:=$nextIndex+1
					aHeaders{$nextIndex}:="Ubicación Cheque"
					$nextIndex:=$nextIndex+1
					$vb_cheque:=True:C214
				Else 
					DELETE FROM ARRAY:C228(aHeaders;$nextIndex;6)
					$vb_cheque:=False:C215
					$vl_index2NoDesglosado:=$vl_index2NoDesglosado-6
				End if 
				If (cb_XCruzado=1)
					aHeaders{$nextIndex}:="Cuenta Corriente"
					$nextIndex:=$nextIndex+1
					aHeaders{$nextIndex}:="Identificador Nacional Cta. Cte."
					$nextIndex:=$nextIndex+1
					aHeaders{$nextIndex}:="Código"
					$nextIndex:=$nextIndex+1
					aHeaders{$nextIndex}:="Curso"
					$nextIndex:=$nextIndex+1
				End if 
				
				
				ARRAY TEXT:C222(aNivelCta;0)
				ARRAY TEXT:C222(aCursoCta;0)
				ARRAY TEXT:C222(aDocumentoTrib;0)
				ARRAY TEXT:C222(aDocumentoTribEmision;0)
				ARRAY DATE:C224(aFechaCheque;0)
				ARRAY DATE:C224(aFechaChequeFecha;0)
				ARRAY TEXT:C222(aSerieCheque;0)
				ARRAY TEXT:C222(aBancoCheque;0)
				ARRAY TEXT:C222(aCodBancoCheque;0)
				ARRAY TEXT:C222(aUbicacionCheque;0)
				ARRAY TEXT:C222(aCtaCruzado;0)
				ARRAY TEXT:C222(aIDNCtaCruzado;0)
				ARRAY TEXT:C222(aCtaCodCruzado;0)
				ARRAY TEXT:C222(aCtaCursoCruzado;0)
				ARRAY TEXT:C222(aApdoCta;0)
				ARRAY TEXT:C222(aIdentifPagador;0)
				ARRAY TEXT:C222(aFamilias;0)
				ARRAY DATE:C224(aFechaCheque;Size of array:C274($aRecNumPagos))
				ARRAY DATE:C224(aFechaChequeFecha;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aSerieCheque;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aBancoCheque;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aCodBancoCheque;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aUbicacionCheque;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aCtaCruzado;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aIDNCtaCruzado;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aCtaCodCruzado;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aCtaCursoCruzado;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aDocumentoTrib;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aDocumentoTribEmision;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aApdoCta;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aIdentifPagador;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aFamilias;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aNivelCta;Size of array:C274($aRecNumPagos))
				ARRAY TEXT:C222(aCursoCta;Size of array:C274($aRecNumPagos))
				
				ARRAY TEXT:C222($atACTpgs_Monedas3;0)
				ARRAY REAL:C219($arACTpgs_MontosMoneda2;0)
				ARRAY REAL:C219($arACTpgs_Paridades2;0)
				
				ARRAY DATE:C224(aFechaPago2;0)
				ARRAY REAL:C219(aMontoPago2;0)
				ARRAY REAL:C219(aDispPago2;0)
				ARRAY TEXT:C222(aFormaPago2;0)
				ARRAY TEXT:C222(aLugarPago2;0)
				ARRAY LONGINT:C221(aIDPago2;0)
				ARRAY TEXT:C222(atIngresoPago2;0)
				ARRAY TEXT:C222(aApdoCta2;0)
				ARRAY TEXT:C222(aIdentifPagador2;0)
				ARRAY TEXT:C222(aFamilias2;0)
				COPY ARRAY:C226(aFechaPago;aFechaPago2)
				COPY ARRAY:C226(aMontoPago;aMontoPago2)
				COPY ARRAY:C226(aFormaPago;aFormaPago2)
				COPY ARRAY:C226(aIDPago;aIDPago2)
				COPY ARRAY:C226(atIngresoPago;atIngresoPago2)
				COPY ARRAY:C226(aApdoCta;aApdoCta2)
				COPY ARRAY:C226(aDispPago;aDispPago2)
				COPY ARRAY:C226(aLugarPago;aLugarPago2)
				COPY ARRAY:C226(aIdentifPagador;aIdentifPagador2)
				COPY ARRAY:C226(aFamilias;aFamilias2)
				
				COPY ARRAY:C226($atACTpgs_Monedas;$atACTpgs_Monedas3)
				COPY ARRAY:C226($arACTpgs_MontosMoneda;$arACTpgs_MontosMoneda2)
				COPY ARRAY:C226($arACTpgs_Paridades;$arACTpgs_Paridades2)
				
				$totalDisp:=AT_GetSumArray (->aDispPago2)
				For ($y;1;Size of array:C274(aPointerItems))
					AT_Insert (0;Size of array:C274(aIDPago);aPointerItems{$y})
				End for 
				For ($fdp;1;Size of array:C274(aPointerFormasdePago))
					AT_Insert (0;Size of array:C274(aIDPago);aPointerFormasdePago{$fdp})
				End for 
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información de pagos..."))
				READ ONLY:C145([ACT_Terceros:138])
				READ ONLY:C145([Personas:7])
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Familia_RelacionesFamiliares:77])
				READ ONLY:C145([Familia:78])
				
				ARRAY LONGINT:C221($al_recNumTransacciones;0)
				For ($i;1;Size of array:C274($aRecNumPagos))
					GOTO RECORD:C242([ACT_Pagos:172];$aRecNumPagos{$i})
					$formadePago:=[ACT_Pagos:172]FormaDePago:7
					$vl_idFormaDePago:=[ACT_Pagos:172]id_forma_de_pago:30
					$montoPago:=[ACT_Pagos:172]Monto_Pagado:5
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=aIDPago{$i})
					ARRAY LONGINT:C221($aRecNumTransacciones;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aRecNumTransacciones)
					$insertAt:=Find in array:C230(aIDPago2;aIDPago{$i})
					For ($j;1;Size of array:C274($aRecNumTransacciones))
						GOTO RECORD:C242([ACT_Transacciones:178];$aRecNumTransacciones{$j})
						$vr_monto:=ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=[ACT_Transacciones:178]ID_Item:3)
						If ([ACT_Cargos:173]Ref_Item:16=-129)
							APPEND TO ARRAY:C911($al_recNumTransacciones;$aRecNumTransacciones{$j})
							$vr_monto:=($vr_monto*-1)
						End if 
						If (cb_AgruparPorCategorias=0)
							$CualItem:=Find in array:C230(aIDItemdeCargo;[ACT_Cargos:173]Ref_Item:16)
						Else 
							READ ONLY:C145([xxACT_Items:179])
							KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16)
							$CualItem:=Find in array:C230(aIDItemdeCargo;[xxACT_Items:179]ID_Categoria:8)
							If ($CualItem=-1)
								$CualItem:=Find in array:C230(aIDItemdeCargo;[ACT_Cargos:173]Ref_Item:16)
							End if 
						End if 
						If ($CualItem#-1)
							If (cb_XCruzado=0)
								aPointerItems{$CualItem}->{$insertAt}:=aPointerItems{$CualItem}->{$insertAt}+$vr_monto
							Else 
								READ ONLY:C145([ACT_CuentasCorrientes:175])
								READ ONLY:C145([Alumnos:2])
								QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Transacciones:178]ID_CuentaCorriente:2)
								QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
								If ($j=1)
									aCtaCruzado{$insertAt}:=[Alumnos:2]apellidos_y_nombres:40
									aIDNCtaCruzado{$insertAt}:=[Alumnos:2]RUT:5
									aCtaCodCruzado{$insertAt}:=[ACT_CuentasCorrientes:175]Codigo:19
									aCtaCursoCruzado{$insertAt}:=[Alumnos:2]curso:20
									aPointerItems{$CualItem}->{$insertAt}:=$vr_monto
								Else 
									AT_Insert ($insertAt+1;1;->aFechaPago2;->aIDPago2;->atIngresoPago2;->aDocumentoTrib;->aDocumentoTribEmision;->aApdoCta2;->aIdentifPagador2;->aFamilias;->aDispPago2;->aLugarPago2)
									AT_Insert ($insertAt+1;1;->aFechaCheque;->aFechaChequeFecha;->aSerieCheque;->aBancoCheque;->aCodBancoCheque;->aUbicacionCheque;->aCtaCruzado;->aIDNCtaCruzado;->aCtaCodCruzado;->aCtaCursoCruzado)
									
									AT_Insert ($insertAt+1;1;->$atACTpgs_Monedas3;->$arACTpgs_MontosMoneda2;->$arACTpgs_Paridades2)
									
									For ($l;1;Size of array:C274(aPointerItems))
										AT_Insert ($insertAt+1;1;aPointerItems{$l})
									End for 
									For ($l;1;Size of array:C274(aPointerFormasdePago))
										AT_Insert ($insertAt+1;1;aPointerFormasdePago{$l})
									End for 
									aCtaCruzado{$insertAt+1}:=[Alumnos:2]apellidos_y_nombres:40
									aIDNCtaCruzado{$insertAt+1}:=[Alumnos:2]RUT:5
									aCtaCodCruzado{$insertAt+1}:=[ACT_CuentasCorrientes:175]Codigo:19
									aCtaCursoCruzado{$insertAt+1}:=[Alumnos:2]curso:20
									aPointerItems{$CualItem}->{$insertAt+1}:=$vr_monto
								End if 
							End if 
						Else 
							$insertPosHeaders:=Size of array:C274(aHeaders)
							$insertPos:=Size of array:C274(aPointerItems)
							AT_Insert ($insertPos;1;->aPointerItems;->aPointerTotales;->aIDItemdeCargo)
							AT_Insert ($insertPosHeaders;1;->aHeaders)
							aPointerItems{$insertPos}:=Get pointer:C304("arItems"+String:C10(Size of array:C274(aPointerItems)))
							aIDItemdeCargo{$insertPos}:=[ACT_Cargos:173]Ref_Item:16
							aHeaders{$insertPosHeaders}:=[ACT_Cargos:173]Glosa:12+" (*)"
							aPointerTotales{$insertPos}:=Get pointer:C304("vrTotales"+String:C10(Size of array:C274(aPointerTotales)))
							AT_Insert (0;Size of array:C274(aPointerItems{$insertPos-1}->);aPointerItems{$insertPos})
							aPointerItems{$insertPos}->{$insertAt}:=aPointerItems{$insertPos}->{$insertAt}+$vr_monto
							$itemsInexistentes:=True:C214
						End if 
					End for 
					Case of 
						: (cb_XApdo=1)
							aApdoCta2{$insertAt}:=[Personas:7]Apellidos_y_nombres:30
							aIdentifPagador2{$insertAt}:=[Personas:7]RUT:6
						: (cb_XCta=1)
							aApdoCta2{$insertAt}:=[Alumnos:2]apellidos_y_nombres:40
							aIdentifPagador2{$insertAt}:=[ACT_CuentasCorrientes:175]Codigo:19
						: (cb_XCruzado=1)
							aApdoCta2{$insertAt}:=[Personas:7]Apellidos_y_nombres:30
							aIdentifPagador2{$insertAt}:=[Personas:7]RUT:6
					End case 
					
					$cualFDP:=Find in array:C230(alACT_FormasdePagoID;$vl_idFormaDePago)
					If ($cualFDP#-1)
						aPointerFormasdePago{$cualFDP}->{$insertAt}:=$montoPago
					End if 
					If (($vl_idFormaDePago=-4) | ($vl_idFormaDePago=-8))
						QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
						If ([ACT_Documentos_de_Pago:176]FechaPago:4>=[ACT_Documentos_de_Pago:176]Fecha:13)
							aFechaCheque{$insertAt}:=[ACT_Documentos_de_Pago:176]Fecha:13
						Else 
							aFechaChequeFecha{$insertAt}:=[ACT_Documentos_de_Pago:176]Fecha:13
						End if 
						aSerieCheque{$insertAt}:=[ACT_Documentos_de_Pago:176]NoSerie:12
						aBancoCheque{$insertAt}:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
						aCodBancoCheque{$insertAt}:=[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8
						If ([ACT_Documentos_de_Pago:176]En_cartera:34)
							READ ONLY:C145([ACT_Documentos_en_Cartera:182])
							QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_DocdePago:3=[ACT_Documentos_de_Pago:176]ID:1)
							aUbicacionCheque{$insertAt}:=[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8
						Else 
							If ([ACT_Documentos_de_Pago:176]Depositado:35)
								aUbicacionCheque{$insertAt}:=[ACT_Documentos_de_Pago:176]Estado:14
							Else 
								If ([ACT_Documentos_de_Pago:176]Protestado:36)
									aUbicacionCheque{$insertAt}:=[ACT_Documentos_de_Pago:176]Estado:14
								End if 
							End if 
						End if 
					End if 
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
					KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
					ARRAY LONGINT:C221(aBoletasXPago;0)
					ARRAY TEXT:C222(aPersonasXBoleta;0)
					DISTINCT VALUES:C339([ACT_Boletas:181]Numero:11;aBoletasXPago)
					DISTINCT VALUES:C339([ACT_Boletas:181]EmitidoPor:17;aPersonasXBoleta)
					$text:=AT_array2text (->aBoletasXPago;" - ")
					aDocumentoTrib{$insertAt}:=$text
					$text:=AT_array2text (->aPersonasXBoleta;" - ")
					aDocumentoTribEmision{$insertAt}:=$text
					AT_Initialize (->aPersonasXBoleta)
					Case of 
						: ((cb_XApdo=1) | (cb_XCruzado=1))
							If ([ACT_Pagos:172]ID_Apoderado:3=0)
								QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Pagos:172]ID_Tercero:26)
								aApdoCta2{$insertAt}:=[ACT_Terceros:138]Nombre_Completo:9
								aIdentifPagador2{$insertAt}:=[ACT_Terceros:138]RUT:4
							Else 
								$vl_idApoderado:=[ACT_Pagos:172]ID_Apoderado:3
								ARRAY LONGINT:C221($aIDFamilia;0)
								QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Pagos:172]ID_Apoderado:3)
								aApdoCta2{$insertAt}:=[Personas:7]Apellidos_y_nombres:30
								aIdentifPagador2{$insertAt}:=[Personas:7]RUT:6
								QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[ACT_Pagos:172]ID_Apoderado:3)
								SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Familia:2;$aIDFamilia)
								For ($q;1;Size of array:C274($aIDFamilia))
									QUERY:C277([Familia:78];[Familia:78]Numero:1=$aIDFamilia{$q})
									aFamilias{$insertAt}:=aFamilias{$insertAt}+[Familia:78]Nombre_de_la_familia:3+"-"
								End for 
								aFamilias{$insertAt}:=Substring:C12(aFamilias{$insertAt};1;Length:C16(aFamilias{$insertAt})-1)
							End if 
						: (cb_XCta=1)
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Pagos:172]ID_CtaCte:21)
							QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
							aApdoCta2{$insertAt}:=[Alumnos:2]apellidos_y_nombres:40
							aIdentifPagador2{$insertAt}:=[ACT_CuentasCorrientes:175]Codigo:19
							aNivelCta{$insertAt}:=[Alumnos:2]Nivel_Nombre:34
							aCursoCta{$insertAt}:=[Alumnos:2]curso:20
							QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
							aFamilias{$insertAt}:=[Familia:78]Nombre_de_la_familia:3
							
					End case 
					
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNumPagos))
				End for 
				aPointerTotales{Size of array:C274(aPointerTotales)}->:=AT_GetSumArray (->aMontoPago2)
				For ($x;1;Size of array:C274(aPointerItems))
					aPointerTotales{$x+Size of array:C274(aPointerFormasdePago)}->:=AT_GetSumArray (aPointerItems{$x})
				End for 
				For ($x;1;Size of array:C274(aPointerFormasdePago))
					aPointerTotales{$x}->:=AT_GetSumArray (aPointerFormasdePago{$x})
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				$text:=""
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo..."))
				If (cb_Desglosar=0)
					AT_RedimArrays ((($vl_index2NoDesglosado+Size of array:C274(atACT_FormasdePago))+$vlACT_cantidad)-1;->aHeaders)
				End if 
				$text:=AT_array2text (->aHeaders;"\t")+"\r\n"
				For ($g;1;Size of array:C274(aIDPago2))
					If (cb_XCta=1)
						$paraCta:="\t"+aNivelCta{$g}+"\t"+aCursoCta{$g}
					Else 
						$paraCta:=""
					End if 
					If (cb_XCruzado=1)
						$paraCruzado:="\t"+aCtaCruzado{$g}+"\t"+aIDNCtaCruzado{$g}+"\t"+aCtaCodCruzado{$g}+"\t"+aCtaCursoCruzado{$g}
					Else 
						$paraCruzado:=""
					End if 
					$text:=$text+ST_Boolean2Str ((aFechaPago2{$g}#!00-00-00!);String:C10(aFechaPago2{$g}))+"\t"+String:C10(aIDPago2{$g};"########")+"\t"+atIngresoPago2{$g}+"\t"+aDocumentoTrib{$g}+"\t"+aDocumentoTribEmision{$g}
					If ($vb_MultiMoneda)
						If ($atACTpgs_Monedas3{$g}#"")
							$pos:=Find in array:C230($atACTpgs_Monedas2;$atACTpgs_Monedas3{$g})
							$pos2:=Size of array:C274($atACTpgs_Monedas2)-$pos
							$text:=$text+("\t"*$pos)+String:C10($arACTpgs_MontosMoneda2{$g})+("\t"*$pos2)+"\t"+String:C10($arACTpgs_Paridades2{$g})+"\t"
						Else 
							$text:=$text+("\t"*(Size of array:C274($atACTpgs_Monedas2)+1))+"\t"
						End if 
					Else 
						$text:=$text+"\t"
					End if 
					$text:=$text+aApdoCta2{$g}+"\t"+aIdentifPagador2{$g}+$paraCta+"\t"+aFamilias{$g}+ST_Boolean2Str ($vb_disponible;"\t"+String:C10(aDispPago2{$g});"")+ST_Boolean2Str ($vb_lugar;"\t"+aLugarPago2{$g};"")
					For ($a;1;Size of array:C274(aPointerFormasdePago))
						$text:=$text+"\t"+String:C10(aPointerFormasdePago{$a}->{$g})
					End for 
					If ($vb_cheque)
						$text:=$text+"\t"+ST_Boolean2Str ((aFechaCheque{$g}#!00-00-00!);String:C10(aFechaCheque{$g}))+"\t"+ST_Boolean2Str ((aFechaChequeFecha{$g}#!00-00-00!);String:C10(aFechaChequeFecha{$g}))+"\t"+aSerieCheque{$g}+"\t"+aBancoCheque{$g}+"\t"+aCodBancoCheque{$g}+"\t"+aUbicacionCheque{$g}
					End if 
					$text:=$text+$paraCruzado
					If (cb_Desglosar=1)
						For ($t;1;Size of array:C274(aPointerItems))
							$text:=$text+"\t"+String:C10(aPointerItems{$t}->{$g})
						End for 
					End if 
					$text:=$text+"\r\n"
					IO_SendPacket ($ref;$text)
					$text:=""
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$g/Size of array:C274(aIDPago2))
				End for 
				
				Case of 
					: (cb_XCta=1)
						$tabsTotales:=("\t"*5)
					: (cb_XApdo=1)
						$tabsTotales:=("\t"*5)
					: (cb_XCruzado=1)
						$tabsTotales:=("\t"*5)
				End case 
				
				If ($vb_MultiMoneda)
					For ($v;1;Size of array:C274($atACTpgs_Monedas2))
						$vt_valor:=$atACTpgs_Monedas2{$v}
						$tabsTotales:=$tabsTotales+String:C10(AT_GetSumArrayByArrayPos (->$vt_valor;"=";->$atACTpgs_Monedas;->$arACTpgs_MontosMoneda))+"\t"
					End for 
					$tabsTotales:=$tabsTotales+"\t"
				End if 
				
				Case of 
					: (cb_XCta=1)
						$tabsTotales:=$tabsTotales+("\t"*4)
					: (cb_XApdo=1)
						$tabsTotales:=$tabsTotales+("\t"*2)
					: (cb_XCruzado=1)
						$tabsTotales:=$tabsTotales+("\t"*2)
				End case 
				
				If ($vb_disponible)
					$text:=$tabsTotales+__ ("Totales")+"\t"+String:C10($totalDisp)+"\t"
				Else 
					$text:=$tabsTotales+__ ("Totales")+"\t"
				End if 
				If ($vb_lugar)
					$text:=$text+"\t"
				End if 
				
				For ($x;1;Size of array:C274(aPointerFormasdePago))
					$text:=$text+String:C10(aPointerTotales{$x}->)+"\t"
				End for 
				
				IO_SendPacket ($ref;$text)
				If (cb_XCruzado=1)
					If ($vb_cheque)
						$text:="\t"*10
					Else 
						$text:="\t"*4
					End if 
				Else 
					If ($vb_cheque)
						$text:="\t"*6
					Else 
						$text:=""
					End if 
				End if 
				If (cb_Desglosar=1)
					For ($x;Size of array:C274(aPointerFormasdePago)+1;Size of array:C274(aPointerFormasdePago)+Size of array:C274(aPointerItems))
						$text:=$text+String:C10(aPointerTotales{$x}->)+"\t"
					End for 
					
				End if 
				$text:=Substring:C12($text;1;Length:C16($text)-1)
				$text:=$text+"\r\n"+"\r\n"
				IO_SendPacket ($ref;$text)
				$text:="Ingresos totales: "+"\t"+String:C10(aPointerTotales{Size of array:C274(aPointerTotales)}->)
				If (cb_Desglosar=1)
					If ($itemsInexistentes)
						$text:=$text+"\r\n"+"\r\n"+"\r\n"+__ ("(*) Estos items ya no existen en la definición de items de cargo.")
					End if 
				End if 
				IO_SendPacket ($ref;$text)
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				If (Records in set:C195("pagosNC")>0)
					ARRAY TEXT:C222($atACT_referencias;0)
					C_TEXT:C284($vt_text2)
					
					C_REAL:C285($vr_montoTotal;$vr_montoPago;$vr_montoTotalPago)
					$text:="\r\n"+"\r\n"
					$text:=$text+__ ("Notas de Crédito")+"\r\n"+__ ("Fecha emisión")+"\t"+__ ("Número documento")+"\t"+__ ("Monto Documento")+"\t"+__ ("Número pago asociado")+"\t"+__ ("Monto Devolución")+"\r\n"
					IO_SendPacket ($ref;$text)
					USE SET:C118("pagosNC")
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Transacciones:178]ID_Item:3;"")
					KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
					QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=-12)
					ARRAY LONGINT:C221($al_recNumsPagos;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$al_recNumsPagos;"")
					For ($i;1;Size of array:C274($al_recNumsPagos))
						REDUCE SELECTION:C351([ACT_Boletas:181];0)
						GOTO RECORD:C242([ACT_Pagos:172];$al_recNumsPagos{$i})
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						$text:=String:C10([ACT_Boletas:181]FechaEmision:3)+"\t"+String:C10([ACT_Boletas:181]Numero:11)+"\t"+String:C10([ACT_Boletas:181]Monto_Total:6)
						$vt_text2:=$text
						If (Records in selection:C76([ACT_Pagos:172])>0)
							ARRAY LONGINT:C221($al_idsPagos;0)
							SELECTION TO ARRAY:C260([ACT_Pagos:172]ID:1;$al_idsPagos)
							$text:=$text+"\t"+AT_array2text (->$al_idsPagos;" - ";"### ### ###")
							$vr_montoPago:=Sum:C1([ACT_Pagos:172]Monto_Pagado:5)
							$vr_montoTotalPago:=$vr_montoTotalPago+$vr_montoPago
							$text:=$text+"\t"+String:C10($vr_montoPago)
						Else 
							$text:=$text+"\t"
						End if 
						$text:=$text+"\r\n"
						If (Records in selection:C76([ACT_Boletas:181])>0)
							If (Find in array:C230($atACT_referencias;$vt_text2)=-1)
								APPEND TO ARRAY:C911($atACT_referencias;$vt_text2)
								$vr_montoTotal:=$vr_montoTotal+[ACT_Boletas:181]Monto_Total:6
							End if 
						End if 
						IO_SendPacket ($ref;$text)
					End for 
					$text:="\r\n"+"\r\n"+__ ("Total Notas de Crédito")+"\t"+String:C10($vr_montoTotal)
					IO_SendPacket ($ref;$text)
					$text:="\r\n"+__ ("Total Devoluciones")+"\t"+String:C10($vr_montoTotalPago)
					IO_SendPacket ($ref;$text)
				End if 
				
				If ($vb_hayVR)
					$text:="\r\n"+"\r\n"
					$text:=$text+"(1): Cargo ítem Venta Directa según configuración actual."
					IO_SendPacket ($ref;$text)
				End if 
				
				CLOSE DOCUMENT:C267($ref)
				  // Modificado por: Saúl Ponce (23-02-2017) Ticket 175398 - Se utiliza vtACT_document asignada en ACTabc_CreaDocumento para describir el PATH del archivo
				  // ACTcd_DlogWithShowOnDisk ($filePath;0;__ ("La exportación de los ingresos de ")+$fileName+__ (" ha concluido.\r\rLa encontrará en: \r")+$folderPath+__ ("\r\rLe recomendamos abrirla con Microsoft Excel."))
				ACTcd_DlogWithShowOnDisk (vtACT_document;0;__ ("La exportación de los ingresos de ")+$fileName+__ (" ha concluido.\r\rLa encontrará en: \r")+SYS_GetParentNme (vtACT_document)+__ ("\r\rLe recomendamos abrirla con Microsoft Excel."))
			Else 
				CD_Dlog (0;__ ("Se produjo un error al intentar crear el archivo. El archivo puede estar abierto por otra aplicación, si es así, ciérrelo e intente nuevamente."))
			End if 
			USE CHARACTER SET:C205(*;0)
		Else 
			CD_Dlog (0;__ ("Se produjo un error al intentar crear el archivo. El archivo puede estar abierto por otra aplicación, si es así, ciérrelo e intente nuevamente."))
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("No existen registros de pagos para ese período."))
End if 
ACTpgs_ArraysInfIngresos 
SET_ClearSets ("pagosTodos";"pagosNC")