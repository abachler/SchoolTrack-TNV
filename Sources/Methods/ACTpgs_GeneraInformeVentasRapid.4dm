//%attributes = {}
  //ACTpgs_GeneraInformeVentasRapid

C_BOOLEAN:C305($itemsInexistentes)
READ ONLY:C145([ACT_Pagos:172])
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Venta_Rapida:10=True:C214)
Case of 
	: (b1=1)
		$year:=Year of:C25(Current date:C33(*))
		$month:=Month of:C24(Current date:C33(*))
		$day:=Day of:C23(Current date:C33(*))
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2=Current date:C33(*))
		$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
		$titulo:="Ingresos para el dia  "+String:C10($day)+" de "+<>atXS_MonthNames{$month}+" de "+String:C10($year)+("\r"*3)
	: (b2=1)
		$year:=Year of:C25(Current date:C33(*))
		$month:=Month of:C24(Current date:C33(*))
		$dateIni:=DT_GetDateFromDayMonthYear (1;$month;$year)
		$lastDay:=DT_GetLastDay ($month;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;$month;$year)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$DateEnd)
		$fileName:=String:C10($year)+<>atXS_MonthNames{$month}
		$titulo:="Ingresos para el mes de "+<>atXS_MonthNames{$month}+" "+String:C10($year)+("\r"*3)
	: (b3=1)
		$year:=viAño
		$dateIni:=DT_GetDateFromDayMonthYear (1;vi_SelectedMonth;$year)
		$lastDay:=DT_GetLastDay (vi_SelectedMonth;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;vi_SelectedMonth;$year)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$DateEnd)
		$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
		$titulo:="Ingresos para el mes de "+<>atXS_MonthNames{vi_SelectedMonth}+" "+String:C10($year)+("\r"*3)
	: (b4=1)
		$year:=Year of:C25(Current date:C33(*))
		$dateIni:=DT_GetDateFromDayMonthYear (1;1;$year)
		$lastDay:=DT_GetLastDay (12;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;12;$year)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$DateEnd)
		$fileName:=String:C10($year)
		$titulo:="Ingresos para el año "+String:C10($year)+("\r"*3)
	: (b5=1)
		$year:=viAño2
		$dateIni:=DT_GetDateFromDayMonthYear (1;1;$year)
		$lastDay:=DT_GetLastDay (12;$year)
		$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;12;$year)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$DateIni;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$DateEnd)
		$fileName:=String:C10($year)
		$titulo:="Ingresos para el año "+String:C10($year)+("\r"*3)
	: (b6=1)
		$year:=Year of:C25(vd_fecha)
		$month:=Month of:C24(vd_fecha)
		$day:=Day of:C23(vd_fecha)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2=vd_Fecha)
		$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
		$titulo:="Ingresos para el dia  "+String:C10($day)+" de "+<>atXS_MonthNames{$month}+" de "+String:C10($year)+("\r"*3)
End case 
$fileName:="VentasRapidas_"+$fileName
If (Records in selection:C76([ACT_Pagos:172])>0)
	$r:=CD_Dlog (0;__ ("AccountTrack generará un archivo Excel con los ingresos del período seleccionado. Esta operación puede ser larga. ¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
	If ($r=1)
		
		$ref:=ACTabc_CreaDocumento ("Libro de ingresos"+Folder separator:K24:12+"Ventas Rápidas"+Folder separator:K24:12;$fileName)
		If ($ref#?00:00:00?)
			IO_SendPacket ($ref;$titulo)
			$listRef:=LOC_LoadList ("ACT_FormasdePago")
			HL_ReferencedList2Array ($listRef;->atACT_FormasdePago)
			ARRAY POINTER:C280(aPointerFormasdePago;0)
			ARRAY POINTER:C280(aPointerFormasdePago;Size of array:C274(atACT_FormasdePago))
			For ($fdp;1;Size of array:C274(atACT_FormasdePago))
				aPointerFormasdePago{$fdp}:=Bash_Get_Array_By_Type (Is real:K8:4)
			End for 
			READ ONLY:C145([xxACT_Items:179])
			ALL RECORDS:C47([xxACT_Items:179])
			CREATE SET:C116([xxACT_Items:179];"Todos")
			CREATE EMPTY SET:C140([xxACT_Items:179];"Normales")
			FIRST RECORD:C50([xxACT_Items:179])
			While (Not:C34(End selection:C36([xxACT_Items:179])))
				If (Not:C34([xxACT_Items:179]VentaRapida:3))
					ADD TO SET:C119([xxACT_Items:179];"Normales")
				End if 
				NEXT RECORD:C51([xxACT_Items:179])
			End while 
			DIFFERENCE:C122("Todos";"Normales";"Todos")
			USE SET:C118("Todos")
			SET_ClearSets ("Todos";"Normales")
			DISTINCT VALUES:C339([xxACT_Items:179]ID:1;aDistinctItems)
			If (Size of array:C274(aDistinctItems)=0)
				AT_Insert (0;1;->aDistinctItems)
			End if 
			ARRAY LONGINT:C221(aIDItemdeCargo;0)
			ARRAY POINTER:C280(aPointerItems;0)
			ARRAY POINTER:C280(aPointerTotales;0)
			ARRAY TEXT:C222(aHeaders;0)
			ARRAY TEXT:C222(aGlosas;0)
			ARRAY TEXT:C222(aGlosas;Size of array:C274(aDistinctItems))
			ARRAY LONGINT:C221(aIDItemdeCargo;Size of array:C274(aDistinctItems))
			ARRAY POINTER:C280(aPointerItems;Size of array:C274(aDistinctItems))
			ARRAY POINTER:C280(aPointerRefPeriodo;Size of array:C274(aDistinctItems))
			ARRAY POINTER:C280(aPointerTotales;Size of array:C274(aDistinctItems)+Size of array:C274(atACT_FormasdePago)+1)
			ARRAY TEXT:C222(aHeaders;(Size of array:C274(aDistinctItems)*2)+4+Size of array:C274(atACT_FormasdePago))
			For ($x;1;Size of array:C274(aPointerItems))
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=aDistinctItems{$x})
				aPointerItems{$x}:=Bash_Get_Array_By_Type (Is real:K8:4)
				aPointerRefPeriodo{$x}:=Bash_Get_Array_By_Type (Is text:K8:3)
				aIDItemdeCargo{$x}:=[xxACT_Items:179]ID:1
				aHeaders{4+((2*$x)-1+Size of array:C274(atACT_FormasdePago))}:=[xxACT_Items:179]Glosa:2
				aGlosas{$x}:=[xxACT_Items:179]Glosa:2
				$posNextItem:=4+((2*$x)-1+Size of array:C274(atACT_FormasdePago))+2
			End for 
			For ($x;1;Size of array:C274(aPointerTotales))
				aPointerTotales{$x}:=Bash_Get_Variable_By_Type (Is real:K8:4)
			End for 
			
			aHeaders{1}:="Fecha"
			aHeaders{2}:="Nº"
			For ($n;1;Size of array:C274(atACT_FormasdePago))
				aHeaders{$n+2}:=atACT_FormasdePago{$n}
			End for 
			aHeaders{2+Size of array:C274(atACT_FormasdePago)+1}:="Fecha Cheque al Día"
			aHeaders{2+Size of array:C274(atACT_FormasdePago)+2}:="Fecha Cheque a Fecha"
			
			ARRAY LONGINT:C221($aRecNumPagos;0)
			SELECTION TO ARRAY:C260([ACT_Pagos:172]Fecha:2;aFechaPago;[ACT_Pagos:172]ID:1;aIDPago;[ACT_Pagos:172]Monto_Pagado:5;aMontoPago;[ACT_Pagos:172]forma_de_pago_new:31;aFormaPago)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$aRecNumPagos)
			ARRAY DATE:C224(aFechaCheque;0)
			ARRAY DATE:C224(aFechaChequeFecha;0)
			ARRAY DATE:C224(aFechaCheque;Size of array:C274($aRecNumPagos))
			ARRAY DATE:C224(aFechaChequeFecha;Size of array:C274($aRecNumPagos))
			ARRAY DATE:C224(aFechaPago2;0)
			ARRAY REAL:C219(aMontoPago2;0)
			ARRAY TEXT:C222(aFormaPago2;0)
			ARRAY LONGINT:C221(aIDPago2;0)
			COPY ARRAY:C226(aFechaPago;aFechaPago2)
			COPY ARRAY:C226(aMontoPago;aMontoPago2)
			COPY ARRAY:C226(aFormaPago;aFormaPago2)
			COPY ARRAY:C226(aIDPago;aIDPago2)
			
			For ($y;1;Size of array:C274(aPointerItems))
				AT_Insert (0;Size of array:C274(aIDPago);aPointerItems{$y};aPointerRefPeriodo{$y})
			End for 
			For ($fdp;1;Size of array:C274(aPointerFormasdePago))
				AT_Insert (0;Size of array:C274(aIDPago);aPointerFormasdePago{$fdp})
			End for 
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información de pagos..."))
			For ($i;1;Size of array:C274($aRecNumPagos))
				GOTO RECORD:C242([ACT_Pagos:172];$aRecNumPagos{$i})
				$formadePago:=[ACT_Pagos:172]forma_de_pago_new:31
				$montoPago:=[ACT_Pagos:172]Monto_Pagado:5
				  //20130626 RCH NF CANTIDAD
				ARRAY REAL:C219(arACT_CantidadVVR;0)
				ARRAY TEXT:C222(atACT_GlosaVVR;0)
				ARRAY REAL:C219(arACT_TotalVVR;0)
				ARRAY BOOLEAN:C223(abACT_AfectoIVAVVR;0)
				BLOB_Blob2Vars (->[ACT_Pagos:172]xItemsVentaRapida:9;0;->arACT_CantidadVVR;->atACT_GlosaVVR;->arACT_TotalVVR;->abACT_AfectoIVAVVR)
				$insertAt:=Find in array:C230(aIDPago2;aIDPago{$i})
				For ($y;1;Size of array:C274(aPointerItems))
					AT_Insert ($insertAt+1;1;aPointerItems{$y};aPointerRefPeriodo{$y})
				End for 
				For ($fdp;1;Size of array:C274(aPointerFormasdePago))
					AT_Insert ($insertAt+1;1;aPointerFormasdePago{$fdp})
				End for 
				For ($j;1;Size of array:C274(arACT_CantidadVVR))
					$CualItem:=Find in array:C230(aGlosas;atACT_GlosaVVR{$j})
					If ($CualItem#-1)
						aPointerItems{$CualItem}->{$insertAt}:=arACT_TotalVVR{$j}
						aPointerRefPeriodo{$CualItem}->{$insertAt}:=""
					Else 
						$insertPosHeaders:=Size of array:C274(aHeaders)-1
						$insertPos:=Size of array:C274(aPointerItems)
						AT_Insert ($insertPos;1;->aPointerItems;->aPointerRefPeriodo;->aPointerTotales;->aIDItemdeCargo;->aGlosas)
						AT_Insert ($insertPosHeaders;2;->aHeaders)
						aPointerItems{$insertPos}:=Bash_Get_Array_By_Type (Is real:K8:4)
						aPointerRefPeriodo{$insertPos}:=Bash_Get_Array_By_Type (Is text:K8:3)
						aHeaders{$insertPosHeaders}:=atACT_GlosaVVR{$j}+" (*)"
						aGlosas{$insertPos}:=atACT_GlosaVVR{$j}
						aPointerTotales{$insertPos}:=Bash_Get_Variable_By_Type (Is real:K8:4)
						If (Size of array:C274(aPointerItems)>1)
							AT_Insert (0;Size of array:C274(aPointerItems{$insertPos-1}->);aPointerItems{$insertPos};aPointerRefPeriodo{$insertPos})
						Else 
							AT_Insert (0;1;aPointerItems{$insertPos};aPointerRefPeriodo{$insertPos})
						End if 
						aPointerItems{$insertPos}->{$insertAt}:=arACT_TotalVVR{$j}
						aPointerRefPeriodo{$insertPos}->{$insertAt}:=""
						$itemsInexistentes:=True:C214
					End if 
				End for 
				$cualFDP:=Find in array:C230(atACT_FormasdePago;$formadePago)
				If ($cualFDP#-1)
					aPointerFormasdePago{$cualFDP}->{$insertAt}:=$montoPago
				End if 
				If ([ACT_Pagos:172]id_forma_de_pago:30=-4)
					QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
					If ([ACT_Documentos_de_Pago:176]FechaPago:4=[ACT_Documentos_de_Pago:176]Fecha:13)
						aFechaCheque{$insertAt}:=[ACT_Documentos_de_Pago:176]FechaPago:4
					Else 
						aFechaChequeFecha{$insertAt}:=[ACT_Documentos_de_Pago:176]Fecha:13
					End if 
				End if 
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
			$text:=AT_array2text (->aHeaders;"\t")+"\r"
			For ($g;1;Size of array:C274(aIDPago2))
				$text:=$text+ST_Boolean2Str ((aFechaPago2{$g}#!00-00-00!);String:C10(aFechaPago2{$g}))+"\t"+String:C10(aIDPago2{$g};"########")+"\t"
				For ($a;1;Size of array:C274(aPointerFormasdePago))
					$text:=$text+String:C10(aPointerFormasdePago{$a}->{$g};"#########")+"\t"
				End for 
				$text:=$text+ST_Boolean2Str ((aFechaCheque{$g}#!00-00-00!);String:C10(aFechaCheque{$g}))+"\t"+ST_Boolean2Str ((aFechaChequeFecha{$g}#!00-00-00!);String:C10(aFechaChequeFecha{$g}))+"\t"
				For ($t;1;Size of array:C274(aPointerItems))
					$text:=$text+String:C10(aPointerItems{$t}->{$g})+"\t"+aPointerRefPeriodo{$t}->{$g}+"\t"
				End for 
				$text:=Substring:C12($text;1;Length:C16($text)-1)
				$text:=$text+"\r"
				IO_SendPacket ($ref;$text)
				$text:=""
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$g/Size of array:C274(aIDPago2))
			End for 
			$text:="\t"+"Totales"+"\t"
			For ($x;1;Size of array:C274(aPointerFormasdePago))
				$text:=$text+String:C10(aPointerTotales{$x}->;"#########")+"\t"
			End for 
			$text:=$text+("\t"*2)
			For ($x;Size of array:C274(aPointerFormasdePago)+1;Size of array:C274(aPointerFormasdePago)+Size of array:C274(aPointerItems))
				$text:=$text+String:C10(aPointerTotales{$x}->;"#########")+("\t"*2)
			End for 
			$text:=Substring:C12($text;1;Length:C16($text)-2)
			$text:=$text+"\r\r"
			$text:=$text+"Ingresos totales: "+"\t"+String:C10(aPointerTotales{Size of array:C274(aPointerTotales)}->;"#########")
			If ($itemsInexistentes)
				$text:=$text+("\r"*3)+"(*) Estos items ya no existen en la definición de items de cargo."
			End if 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			IO_SendPacket ($ref;$text)
			For ($x;1;Size of array:C274(aPointerItems))
				Bash_Return_Variable (aPointerItems{$x})
				Bash_Return_Variable (aPointerRefPeriodo{$x})
			End for 
			For ($x;1;Size of array:C274(aPointerTotales))
				Bash_Return_Variable (aPointerTotales{$x})
			End for 
			For ($fdp;1;Size of array:C274(aPointerFormasdePago))
				Bash_Return_Variable (aPointerFormasdePago{$fdp})
			End for 
			CLOSE DOCUMENT:C267($ref)
			CD_Dlog (0;__ ("La exportación de los ingresos de ")+$fileName+__ (" ha concluido.\r\rLa encontrará en: \r")+$folderPath+__ ("\r\rLe recomendamos abrirla con Microsoft Excel."))
		Else 
			CD_Dlog (0;__ ("Se produjo un error al intentar crear el archivo. El archivo puede estar abierto por otra aplicación. Ciérrelo e intente otra vez."))
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("No existen registros de pagos para ese período."))
End if 