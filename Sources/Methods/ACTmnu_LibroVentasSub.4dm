//%attributes = {}
  //ACTmnu_LibroVentasSub

If (USR_GetMethodAcces (Current method name:C684))
	WDW_OpenFormWindow (->[ACT_Boletas:181];"OpcionesEspecialesPorColegio";7;4;__ ("Opciones especiales libro de ventas"))
	DIALOG:C40([ACT_Boletas:181];"OpcionesEspecialesPorColegio")
	CLOSE WINDOW:C154
	If (ok=1)
		QR_DeclareGenericArrays 
		C_LONGINT:C283($vl_noAñosIFC;$noArreglosReal;$vl_totalColAnosIFC;$vl_noItemsADesglosar;vl_noArreglosReal;$elIFC;$elIE;$pos;$posPositionPointer;$j)
		C_POINTER:C301($ptrTotalIFC;$ptrTotalIE;$ptrTotalLV;$ptr)
		C_REAL:C285($vr_valorATotal)
		C_BOOLEAN:C305($vb_continuar;$vb_special)
		vl_noArreglosReal:=0
		ARRAY DATE:C224(ad_fechasBoletas;0)
		
		READ ONLY:C145([ACT_Boletas:181])
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_Cargos:173])
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=vd_fecha1;*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=vd_fecha2)
		CREATE SET:C116([ACT_Boletas:181];"seleccion")
		KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		AT_DistinctsFieldValues (->[ACT_Cargos:173]Año:14;->aQR_Longint100)
		$vl_noAñosIFC:=Size of array:C274(aQR_Longint100)
		SORT ARRAY:C229(aQR_Longint100;<)
		If ($vl_noAñosIFC>4)
			$vl_noAñosIFC:=4
		End if 
		$noArreglosReal:=$vl_noAñosIFC
		$ptrTotalIFC:=Get pointer:C304("aQR_Real"+String:C10($noArreglosReal+1))
		$noArreglosReal:=$noArreglosReal+1  //años y total de años
		$vl_totalColAnosIFC:=$noArreglosReal
		If (vl_desglosar=1)
			$vl_noItemsADesglosar:=Size of array:C274(al_idsItemsIE)
		Else 
			$vl_noItemsADesglosar:=0
		End if 
		$noArreglosReal:=$noArreglosReal+$vl_noItemsADesglosar
		$ptrTotalIE:=Get pointer:C304("aQR_Real"+String:C10($noArreglosReal+1))  //total ie
		$noArreglosReal:=$noArreglosReal+1
		$ptrTotalLV:=Get pointer:C304("aQR_Real"+String:C10($noArreglosReal+1))  //total LV
		$noArreglosReal:=$noArreglosReal+1
		vl_noArreglosReal:=$noArreglosReal  //... + Libro ventas
		
		AT_DistinctsFieldValues (->[ACT_Boletas:181]FechaEmision:3;->ad_fechasBoletas)
		SORT ARRAY:C229(ad_fechasBoletas;>)
		For ($i;1;Size of array:C274(ad_fechasBoletas))
			$vr_valorATotal:=0
			For ($j;1;vl_noArreglosReal)
				$ptr:=Get pointer:C304("aQR_Real"+String:C10($j))
				AT_Insert ($i;1;$ptr)
			End for 
			AT_Insert ($i;1;->aQR_Integer1;->aQR_Longint1;->aQR_Longint2)
			aQR_Integer1{$i}:=Day of:C23(ad_fechasBoletas{$i})
			USE SET:C118("seleccion")
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3=ad_fechasBoletas{$i};*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=True:C214)
			AT_DistinctsFieldValues (->[ACT_Boletas:181]Numero:11;->aQR_Longint3)
			CREATE SET:C116([ACT_Boletas:181];"boletasASacar")
			DIFFERENCE:C122("seleccion";"boletasASacar";"seleccion")
			USE SET:C118("seleccion")
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3=ad_fechasBoletas{$i};*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
			CREATE SET:C116([ACT_Boletas:181];"boletasASacar")
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;>)
			aQR_Longint1{$i}:=[ACT_Boletas:181]Numero:11
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;<)
			aQR_Longint2{$i}:=[ACT_Boletas:181]Numero:11
			DIFFERENCE:C122("seleccion";"boletasASacar";"seleccion")
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
			CREATE SET:C116([ACT_Transacciones:178];"transDeBoletas")
			
			KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
			ARRAY LONGINT:C221(aQR_Longint5;0)
			SELECTION TO ARRAY:C260([ACT_Boletas:181];aQR_Longint5)
			  //al ejecutar esta sentencia si no hay seleccion da error
			  //JVP 20160826
			  //LONGINT ARRAY FROM SELECTION([ACT_Boletas];aQR_Longint5;"")
			
			For ($r;1;Size of array:C274(aQR_Longint5))
				GOTO RECORD:C242([ACT_Boletas:181];aQR_Longint5{$r})
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
				CREATE SET:C116([ACT_Transacciones:178];"Transacciones")
				
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				
				ARRAY LONGINT:C221(al_recNum;0)
				SELECTION TO ARRAY:C260([ACT_Cargos:173];al_recNum)
				For ($j;1;Size of array:C274(al_recNum))
					GOTO RECORD:C242([ACT_Cargos:173];al_recNum{$j})
					$vb_continuar:=False:C215
					$elIFC:=Find in array:C230(al_idsItemsIFC;[ACT_Cargos:173]Ref_Item:16)
					$elIE:=Find in array:C230(al_idsItemsIE;[ACT_Cargos:173]Ref_Item:16)
					Case of 
						: ($elIFC#-1)
							$pos:=Find in array:C230(aQR_Longint100;[ACT_Cargos:173]Año:14)
							If ($pos>4)
								$pos:=4
							End if 
							$posPositionPointer:=$pos
							$vb_continuar:=True:C214
							$vb_special:=False:C215
						: ($elIE#-1)
							$posPositionPointer:=$vl_totalColAnosIFC+$elIE
							$vb_continuar:=True:C214
							If (vl_desglosar=0)
								$vb_special:=True:C214
							End if 
					End case 
					If ($vb_continuar)
						If (Not:C34($vb_special))
							$ptr:=Get pointer:C304("aQR_Real"+String:C10($posPositionPointer))
							vQR_Real1:=ACTbol_GetMontoLinea ("Transacciones")
							$ptr->{$i}:=$ptr->{$i}+vQR_Real1
						Else 
							vQR_Real1:=ACTbol_GetMontoLinea ("Transacciones")
							$vr_valorATotal:=$vr_valorATotal+vQR_Real1
						End if 
						vQR_Real2:=vQR_Real2+vQR_Real1
					End if 
				End for 
				
			End for 
			CLEAR SET:C117("Transacciones")
			For ($j;1;$vl_noAñosIFC)  //total ifc
				$ptr:=Get pointer:C304("aQR_Real"+String:C10($j))
				$ptrTotalIFC->{$i}:=$ptrTotalIFC->{$i}+$ptr->{$i}
			End for 
			If (vl_desglosar=1)
				For ($j;$vl_totalColAnosIFC+1;$vl_totalColAnosIFC+$vl_noItemsADesglosar)  //total ie
					$ptr:=Get pointer:C304("aQR_Real"+String:C10($j))
					$ptrTotalIE->{$i}:=$ptrTotalIE->{$i}+$ptr->{$i}
				End for 
			Else 
				$ptrTotalIE->{$i}:=$vr_valorATotal
			End if 
			$ptrTotalLV->{$i}:=$ptrTotalIFC->{$i}+$ptrTotalIE->{$i}
			AT_Insert ($i;1;->aQR_Text1)
			For ($j;2;Size of array:C274(aQR_Longint3))
				aQR_Longint3{$j}:=Num:C11(Substring:C12(String:C10(aQR_Longint3{$j});Length:C16(String:C10(aQR_Longint3{$j}))-2))
			End for 
			aQR_Text1{$i}:=Replace string:C233(Replace string:C233(AT_array2text (->aQR_Longint3;"-";"");".";"");",";"")
		End for 
		
		C_POINTER:C301($ptrMonto;$ptrTemp;$ptr50;$ptr40;$ptr10)
		$noArreglosReal:=$noArreglosReal+1
		For ($i;1;Size of array:C274(aQR_Longint100))
			If ($i<=6)
				For ($j;$noArreglosReal;$noArreglosReal+3)
					$ptr:=Get pointer:C304("aQR_Real"+String:C10($j))
					AT_Insert ($i;1;$ptr)
				End for 
				AT_Insert ($i;1;->aQR_Text2)
			End if 
		End for 
		$ptrMonto:=Get pointer:C304("aQR_Real"+String:C10($noArreglosReal))
		$noArreglosReal:=$noArreglosReal+1
		$ptr50:=Get pointer:C304("aQR_Real"+String:C10($noArreglosReal))
		$noArreglosReal:=$noArreglosReal+1
		$ptr40:=Get pointer:C304("aQR_Real"+String:C10($noArreglosReal))
		$noArreglosReal:=$noArreglosReal+1
		$ptr10:=Get pointer:C304("aQR_Real"+String:C10($noArreglosReal))
		
		For ($i;1;Size of array:C274(aQR_Longint100))
			$ptrTemp:=Get pointer:C304("aQR_Real"+String:C10($i))
			If ($i<=6)
				aQR_Text2{$i}:=String:C10(aQR_Longint100{$i})
				$ptrMonto->{$i}:=AT_GetSumArray ($ptrTemp)
				$ptr50->{$i}:=$ptrMonto->{$i}*0.5
				$ptr40->{$i}:=$ptrMonto->{$i}*0.4
				$ptr10->{$i}:=$ptrMonto->{$i}*0.1
			Else 
				aQR_Text2{6}:=aQR_Text2{6}+"-"+String:C10(aQR_Longint100{$i})
				$ptrMonto->{6}:=$ptrMonto->{6}+AT_GetSumArray ($ptrTemp)
				$ptr50->{6}:=$ptr50->{6}+$ptrMonto->{$i}*0.5
				$ptr40->{6}:=$ptr50->{6}+$ptrMonto->{$i}*0.4
				$ptr10->{6}:=$ptr50->{6}+$ptrMonto->{$i}*0.1
			End if 
		End for 
		
		If (vl_export=1)
			C_TEXT:C284($vt_Foldername;$folder;$title;$text;$file;$totales)
			C_LONGINT:C283($result)
			C_TIME:C306($ref)
			$vt_Foldername:=xfGetDirName (__ ("Seleccione el directorio donde desea guardar el archivo"))
			If ($vt_Foldername#"")
				If ($vt_Foldername[[Length:C16($vt_Foldername)]]=Folder separator:K24:12)
					$vt_Foldername:=Substring:C12($vt_Foldername;1;Length:C16($vt_Foldername)-1)
				End if 
				If (Test path name:C476($vt_Foldername)=0)
					$folder:=$vt_Foldername+Folder separator:K24:12+"Libro de Ventas"+Folder separator:K24:12
					$result:=Test path name:C476($folder)
					If ($result<0)
						CREATE FOLDER:C475($vt_Foldername+Folder separator:K24:12+"Libro de Ventas")
					End if 
					$file:=$folder+"LibroVentas.xls"
					If (SYS_TestPathName ($file)=1)
						EM_ErrorManager ("Install")
						EM_ErrorManager ("SetMode";"")
						DELETE DOCUMENT:C159($file)
						EM_ErrorManager ("Clear")
					End if 
					USE CHARACTER SET:C205("windows-1252";0)
					If (ok=1)
						$ref:=Create document:C266($file;"TEXT")
						$title:=__ ("Para el período entre el ")+String:C10(vd_fecha1;7)+__ (" y el ")+String:C10(vd_fecha2)
						IO_SendPacket ($ref;__ ("Libro de ventas")+"\r\n"+"\r\n"+$title+"\r\n"+"\r\n"+__ ("Exportado el ")+String:C10(Current date:C33(*);7)+" a las "+String:C10(Current time:C178(*);2)+" por "+<>tUSR_CurrentUser+"\r\n"+"\r\n")
						
						$title:=__ ("Día")+"\t"+__ ("Desde")+"\t"+__ ("Hasta")
						For ($i;1;Size of array:C274(aQR_Longint100))
							$title:=$title+"\t"+String:C10(aQR_Longint100{$i})
						End for 
						$title:=$title+"\t"+__ ("Total IFC")
						If (vl_desglosar=1)
							ARRAY TEXT:C222($at_temp;0)
							AT_Text2Array (->$at_temp;vt_ItemsIE;"\r\n")
							For ($i;1;Size of array:C274($at_temp))
								$title:=$title+"\t"+Substring:C12($at_temp{$i};3;Length:C16($at_temp{$i}))
							End for 
						End if 
						$title:=$title+"\t"+__ ("Total ingresos colegio")+"\t"+__ ("Total venta diaria")+"\t"+__ ("Folio boletas nulas")+"\r\n"
						IO_SendPacket ($ref;$title)
						
						For ($i;1;Size of array:C274(aQR_Integer1))
							$text:=String:C10(aQR_Integer1{$i})+"\t"+String:C10(aQR_Longint1{$i})+"\t"+String:C10(aQR_Longint2{$i})
							For ($j;1;vl_noArreglosReal)
								$ptr:=Get pointer:C304("aQR_Real"+String:C10($j))
								$text:=$text+"\t"+String:C10($ptr->{$i})
							End for 
							$text:=$text+"\t"+aQR_Text1{$i}+"\r\n"
							IO_SendPacket ($ref;$text)
						End for 
						$totales:="Totales"+"\t\t"
						For ($j;1;vl_noArreglosReal)
							$ptr:=Get pointer:C304("aQR_Real"+String:C10($j))
							$totales:=$totales+"\t"+String:C10(AT_GetSumArray ($ptr))
						End for 
						IO_SendPacket ($ref;$totales)
						$text:="\r\n"+"\r\n"
						IO_SendPacket ($ref;$text)
						$title:=__ ("Distribución de los IFC")+"\r\n"
						$title:=$title+__ ("Año")+"\t"+__ ("Monto")+"\t"+"50%"+"\t"+"40%"+"\t"+"10%"+"\r\n"
						IO_SendPacket ($ref;$title)
						For ($i;1;Size of array:C274(aQR_Longint100))
							If ($i<=6)
								$text:=aQR_Text2{$i}
								$text:=$text+"\t"+String:C10($ptrMonto->{$i})+"\t"+String:C10($ptr50->{$i})+"\t"+String:C10($ptr40->{$i})+"\t"+String:C10($ptr10->{$i})+"\r\n"
								IO_SendPacket ($ref;$text)
							End if 
						End for 
						$totales:="Totales"+"\t"
						$totales:=$totales+String:C10(AT_GetSumArray ($ptrMonto))+"\t"+String:C10(AT_GetSumArray ($ptr50))+"\t"+String:C10(AT_GetSumArray ($ptr40))+"\t"+String:C10(AT_GetSumArray ($ptr10))+"\r\n"
						IO_SendPacket ($ref;$totales)
						CLOSE DOCUMENT:C267($ref)
					Else 
						CD_Dlog (0;__ ("No es posible crear el archivo de texto mientras el informe anterior esté abierto."))
					End if 
					USE CHARACTER SET:C205(*;0)
				Else 
					CD_Dlog (0;__ ("Archivo no generado."))
				End if 
			End if 
		End if 
		
		SET_ClearSets ("selection";"boletasASacar";"transDeBoletas";"transDelCargo")
		ALL RECORDS:C47([ACT_Boletas:181])
		ONE RECORD SELECT:C189([ACT_Boletas:181])
		FORM SET OUTPUT:C54([ACT_Boletas:181];"LibroVentasEspecial")
		PRINT SELECTION:C60([ACT_Boletas:181])
		FORM SET OUTPUT:C54([ACT_Boletas:181];"Output")
		QR_DeclareGenericArrays 
		ARRAY DATE:C224(ad_fechasBoletas;0)
	End if 
End if 