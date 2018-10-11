//%attributes = {}
  //ACTpgs_GeneraListaDetCargos

  //DLEDEZMA  20-5-2009 Crea un archivo txt con los pagos encontrados dependiendo la selección de fecha, organizados por cargos 
  //y estos detallados por apoderados que pagaron dichos cargos.

C_REAL:C285($totalDisp)
C_BOOLEAN:C305($itemsInexistentes)
C_TEXT:C284($text)
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([xxACT_Items:179])
C_TEXT:C284($titulo)
C_DATE:C307($fini)
C_DATE:C307($fend)

QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Nulo:14=False:C215)

Case of 
	: (b1=1)
		$year:=Year of:C25(Current date:C33(*))
		$month:=Month of:C24(Current date:C33(*))
		$day:=Day of:C23(Current date:C33(*))
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2=Current date:C33(*))
		$fileName:="PagosDetCar_"+String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
		
		$fini:=Current date:C33(*)
		$fend:=Current date:C33(*)
		
	: (b3=1)
		
		$year:=viAño
		$dateIni:=DT_GetDateFromDayMonthYear (1;vi_SelectedMonth;$year)
		$lastDay:=DT_GetLastDay (vi_SelectedMonth;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;vi_SelectedMonth;$year)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$DateEnd)
		$fileName:="PagosDetCar_"+String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
		
		$fini:=$DateIni
		$fend:=$DateEnd
		
		
	: (b5=1)
		$year:=viAño2
		$dateIni:=DT_GetDateFromDayMonthYear (1;1;$year)
		$lastDay:=DT_GetLastDay (12;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;12;$year)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$DateEnd)
		$fileName:="PagosDetCar_"+String:C10($year)
		
		$fini:=$DateIni
		$fend:=$DateEnd
	: (b6=1)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=vd_Fecha1;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=vd_Fecha2)
		$fechaInicial:=Replace string:C233(Replace string:C233(vt_Fecha1;"/";"-");":";"-")  //como va en el nombre del archivo, sacamos los caracteres que delimitan directorios tanto en MAC como en PC
		$fechaFinal:=Replace string:C233(Replace string:C233(vt_Fecha2;"/";"-");":";"-")
		$fileName:="PagosDetCar_"+$fechaInicial+"al"+$fechaFinal
		
		$fini:=vd_Fecha1
		$fend:=vd_Fecha2
		
End case 

  //Creación del Archivo TXT
If ((Records in selection:C76([ACT_Pagos:172]))>0)
	
	If (SYS_IsWindows )
		$fileName:=$fileName+".txt"
	End if 
	
	$ref:=ACTabc_CreaDocumento ("Informe de Cargos Pagados";$fileName)
	
	If (ok=1)
		ARRAY REAL:C219($aAcumParaTotalF;0)
		ARRAY REAL:C219($aAcumParaSubtotal;0)
		ARRAY LONGINT:C221($ItemsPagados;0)
		ARRAY TEXT:C222($glosasCargos;0)
		ARRAY TEXT:C222($glosasCargos2;0)
		ARRAY LONGINT:C221($ameses;0)
		C_REAL:C285($disponible)
		
		$disponible:=Sum:C1([ACT_Pagos:172]Saldo:15)
		
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		
		  // SOLO PARA PAGOS ANTICIPADOS
		If (tipoL_2=1)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7>$fend)
		End if 
		
		If ((Records in selection:C76([ACT_Cargos:173]))>0)
			USE CHARACTER SET:C205("windows-1252";0)
			CREATE SET:C116([ACT_Transacciones:178];"Tran1")
			CREATE SET:C116([ACT_Cargos:173];"cargos A")
			
			  // Modificado por: Saúl Ponce (28-02-2017) Ticket Nº 175716, El nombre del archivo se creó en ACTabc_CreaDocumento()
			  // $ref:=Create document($filePath;"TEXT")
			
			ARRAY LONGINT:C221($aRefsitems;0)
			ARRAY LONGINT:C221($aRefsitems2;0)
			
			ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]Glosa:12;>)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]Glosa:12;$glosasCargos;[ACT_Cargos:173]Ref_Item:16;$aRefsitems)
			AT_DistinctsFieldValues (->[ACT_Cargos:173]Ref_Item:16;->$ItemsPagados)
			
			_O_C_INTEGER:C282($x;$i;$q;$salto)
			$salto:=0
			C_LONGINT:C283($findo)
			
			For ($q;1;Size of array:C274($glosasCargos))
				
				$findo:=Find in array:C230($aRefsitems2;$aRefsitems{$q})
				If ($findo<0)
					APPEND TO ARRAY:C911($glosasCargos2;$glosasCargos{$q})
					APPEND TO ARRAY:C911($aRefsitems2;$aRefsitems{$q})
				End if 
				  //$glosasCargos{0}:=$glosasCargos{$q}
				  //AT_SearchArray (->$glosasCargos;">>")
				  //$q:=DA_Return{Size of array(DA_Return)}
				
			End for 
			$titulo:=__ ("DETALLE DE INGRESOS")+"\t"+__ ("FECHA: ")+String:C10(Current date:C33(*))+"\r\n"+"\r\n"
			IO_SendPacket ($ref;$titulo)
			C_TEXT:C284($texto)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando Archivo con la Información de los Pagos..."))
			For ($i;1;Size of array:C274($ItemsPagados))
				
				
				
				ARRAY REAL:C219($aAcumParaSubtotal;0)
				
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$ItemsPagados{$i})
				
				If ((Records in selection:C76([xxACT_Items:179]))>0)
					$texto:=[xxACT_Items:179]Glosa:2
				Else 
					$findo:=Find in array:C230($aRefsitems2;$ItemsPagados{$i})
					If ($findo>0)
						$texto:=$glosasCargos2{$findo}
					Else 
						$texto:=""
					End if 
					
				End if 
				
				IO_SendPacket ($ref;$texto+"\r\n")
				
				  //sub-enc Meses por Cargos distintos 
				
				USE SET:C118("cargos A")
				
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$ItemsPagados{$i})
				ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
				CREATE SET:C116([ACT_Cargos:173];"Cargos B")
				DIFFERENCE:C122("Cargos A";"Cargos B";"Cargos A")
				
				ARRAY LONGINT:C221($aTmeses;0)
				ARRAY LONGINT:C221($aTaños;0)
				
				SELECTION TO ARRAY:C260([ACT_Cargos:173]Mes:13;$aTmeses;[ACT_Cargos:173]Año:14;$aTaños)
				
				C_LONGINT:C283($vlmes)
				C_LONGINT:C283($vlaño)
				
				$vlmes:=0
				$vlaño:=0
				
				  //Arreglos para meses y años
				
				ARRAY LONGINT:C221($aMeses;0)
				ARRAY LONGINT:C221($aAños;0)
				
				For ($x;1;Size of array:C274($aTmeses))
					
					If (($vlmes#$aTmeses{$x}) | ($vlaño#$aTaños{$x}))
						
						$vlmes:=$aTmeses{$x}
						$vlaño:=$aTaños{$x}
						
						APPEND TO ARRAY:C911($aMeses;$vlmes)
						APPEND TO ARRAY:C911($aAños;$vlaño)
						
					End if 
					
				End for 
				
				  //Arreglo con nombre de mes y año
				ARRAY TEXT:C222($alSubMeses;0)
				APPEND TO ARRAY:C911($alSubMeses;"A P O D E R A D O S")
				APPEND TO ARRAY:C911($alSubMeses;"R U T")
				For ($x;1;Size of array:C274($aMeses))
					APPEND TO ARRAY:C911($alSubMeses;<>atxs_monthnames{$aMeses{$x}}+" "+String:C10($aAños{$x}))
				End for 
				APPEND TO ARRAY:C911($alSubMeses;" T O T A L ")
				
				$texto:=AT_array2text (->$alSubMeses;"\t")
				
				IO_SendPacket ($ref;$texto+"\r\n")
				
				  //CALCULOS de Cada Apoderado
				
				USE SET:C118("cargos B")
				ARRAY LONGINT:C221($alApoderados;0)
				
				AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_Apoderado:18;->$alApoderados)
				
				C_REAL:C285($pagado)
				
				For ($x;1;Size of array:C274($alApoderados))
					QUERY:C277([Personas:7];[Personas:7]No:1=$alApoderados{$x})
					$pagado:=0
					
					ARRAY REAL:C219($aDetalleMontosPagados;0)
					IO_SendPacket ($ref;[Personas:7]Apellidos_y_nombres:30+"\t"+SR_FormatoRUT2 ([Personas:7]RUT:6)+"\t")
					
					For ($n;1;Size of array:C274($aMeses))
						
						USE SET:C118("cargos B")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$aMeses{$n};*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$aAños{$n})
						
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						CREATE SET:C116([ACT_Transacciones:178];"Tran2")
						INTERSECTION:C121("Tran1";"Tran2";"Tran2")
						USE SET:C118("Tran2")
						ARRAY LONGINT:C221($aTrans;0)
						
						SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aTrans)
						
						$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aTrans;->[ACT_Transacciones:178]Debito:6)
						
						APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
						APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
						
					End for 
					
					$pagado:=AT_GetSumArray (->$aDetalleMontosPagados)
					APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
					APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
					
					$texto:=AT_array2text (->$aDetalleMontosPagados;"\t";"|Despliegue_ACT_Pagos")
					
					IO_SendPacket ($ref;$texto+"\r\n")
					
				End for 
				
				  //S U B T O T A L - D E L - C A R G O
				
				ARRAY REAL:C219($aSubtotal;0)
				C_LONGINT:C283($cant;$cant2;$posicion)
				
				$cant:=Size of array:C274($aMeses)+1
				$cant2:=Size of array:C274($alApoderados)
				
				C_REAL:C285($monto_sumado_col)
				
				For ($x;1;$cant)  //tamaño de las columnas
					$monto_sumado_col:=0
					
					For ($z;1;$cant2)  //cantidad de apoderados
						$posicion:=0
						
						If ($z=1)
							$posicion:=$z*$x
						Else 
							$posicion:=(($z-1)*($cant))+$x
						End if 
						$monto_sumado_col:=$monto_sumado_col+$aAcumParaSubtotal{$posicion}
						
					End for 
					
					APPEND TO ARRAY:C911($aSubtotal;$monto_sumado_col)
					
				End for 
				
				ARRAY REAL:C219($aAcumParaSubtotal;0)
				  //SE SUMA LA ÚLTIMA POSICIÓN DEL ARREGLO DEL SUBTOTAL AL ACUMULADOR DE TOTALES
				APPEND TO ARRAY:C911($aAcumParaTotalF;$aSubtotal{Size of array:C274($aSubtotal)})
				
				IO_SendPacket ($ref;__ ("SubTotal")+"\t")
				$texto:=AT_array2text (->$aSubtotal;"\t";"|Despliegue_ACT_Pagos")
				IO_SendPacket ($ref;"\t"+$texto+"\r\n")
				
				IO_SendPacket ($ref;" "+"\r\n"+"\r\n")
				
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/(Size of array:C274($ItemsPagados)))
				
			End for 
			
			C_REAL:C285($total)
			
			If ($disponible>0)
				IO_SendPacket ($ref;"Saldo Disponible de los Pagos:"+"\t"+String:C10($disponible;"|Despliegue_ACT_Pagos")+"\r\n"+"\r\n")
			End if 
			
			
			$total:=(AT_GetSumArray (->$aAcumParaTotalF))+$disponible
			
			IO_SendPacket ($ref;__ ("T O T A L - G E N E R A L :")+"\t"+String:C10($total;"|Despliegue_ACT_Pagos"))
			
			
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			SET_ClearSets ("cargos A";"cargos B";"Tran1";"Tran2")
			
			CLOSE DOCUMENT:C267($ref)
			USE CHARACTER SET:C205(*;0)
			  // Modificado por: Saúl Ponce (28-02-2017) Ticket Nº 175716, se utiliza vtACT_document declarada y asignada en ACTabc_CreaDocumento()
			  // ACTcd_DlogWithShowOnDisk ($filePath;0;__ ("El Detalle de los Pagos ")+$fileName+__ (" ha concluido.")+"\r\r"+__ ("Lo encontrará en: ")+"\r"+$folderPath+"\r\r"+__ ("Le recomendamos abrirla con Microsoft Excel."))
			ACTcd_DlogWithShowOnDisk (vtACT_document;0;__ ("El Detalle de los Pagos ")+$fileName+__ (" ha concluido.")+"\r\r"+__ ("Lo encontrará en: ")+"\r"+SYS_GetParentNme (vtACT_document)+"\r\r"+__ ("Le recomendamos abrirla con Microsoft Excel."))
		Else 
			
			CD_Dlog (0;__ ("No se encontraron cargos pagados a detallar dentro del periodo seleccionado"))
			
		End if 
	Else 
		CD_Dlog (0;__ ("Se produjo un error al intentar crear el archivo. El archivo puede estar abierto por otra aplicación, si es así, ciérrelo e intente nuevamente."))
	End if 
	
	
Else 
	CD_Dlog (0;__ ("No se encontraron pagos dentro del periodo seleccionado"))
End if 