//%attributes = {}
  //ACTbol_EMasivaRecibos4Pagos

If (Records in set:C195("Selection")>0)
	ACTcfg_LoadConfigData (8)
	USE SET:C118("Selection")
	KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3;"")
	ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
	ARRAY LONGINT:C221($aRecNumApdos;0)
	LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aRecNumApdos)
	
	$IDCat:=-1
	$ID_ModeloRecibo:=vlACT_ModRecibo
	$Proxima:=vlACT_NextRecibo
	
	ARRAY TEXT:C222($atDocumentos2Print;1)
	ARRAY TEXT:C222($atCategorias;1)
	ARRAY LONGINT:C221($alHowMany;1)
	ARRAY LONGINT:C221($alIDCat;1)
	ARRAY BOOLEAN:C223($abTaxable;1)
	ARRAY LONGINT:C221($alProxima;1)
	ARRAY LONGINT:C221($alIDDT;1)
	ARRAY LONGINT:C221($aDesdeDT;1)
	ARRAY LONGINT:C221($aHastaDT;1)
	ARRAY LONGINT:C221($aCuantas;1)
	ARRAY TEXT:C222($aSetsDT;1)
	ARRAY TEXT:C222(atCategorias;1)
	ARRAY TEXT:C222(atDocumentos2Print;1)
	ARRAY LONGINT:C221(alHowMany;1)
	ARRAY LONGINT:C221(aDesdeDT;1)
	ARRAY LONGINT:C221(aHastaDT;1)
	ARRAY BOOLEAN:C223(abDoPrint;1)
	ARRAY PICTURE:C279(apDoPrint;1)
	ARRAY TEXT:C222(aSetsDT;1)
	ARRAY LONGINT:C221(alIDDT;1)
	$atCategorias{1}:="Recibos"
	$atDocumentos2Print{1}:=vtACT_ModRecibo
	$aSetsDT{1}:="Set/Recibos"
	$alIDDT{1}:=vlACT_ModRecibo
	CREATE EMPTY SET:C140([ACT_Boletas:181];$aSetsDT{1})
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generado recibos para "))
	For ($i;1;Size of array:C274($aRecNumApdos))
		USE SET:C118("Selection")
		GOTO RECORD:C242([Personas:7];$aRecNumApdos{$i})
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNumApdos);__ ("Emitiendo recibos para ")+[Personas:7]Apellidos_y_nombres:30)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
		CREATE SET:C116([ACT_Pagos:172];"PagosApdo")
		Case of 
			: (h1=1)
				Case of 
					: (s1=1)
						ARRAY DATE:C224($aFechasPagos;0)
						ARRAY LONGINT:C221($aAñosPagos;1)
						DISTINCT VALUES:C339([ACT_Pagos:172]Fecha:2;$aFechasPagos)
						$aAñosPagos{1}:=Year of:C25($aFechasPagos{1})
						For ($hh;2;Size of array:C274($aFechasPagos))
							$found:=Find in array:C230($aAñosPagos;Year of:C25($aFechasPagos{$hh}))
							If ($found=-1)
								INSERT IN ARRAY:C227($aAñosPagos;Size of array:C274($aAñosPagos)+1;1)
								$aAñosPagos{Size of array:C274($aAñosPagos)}:=Year of:C25($aFechasPagos{$hh})
							End if 
						End for 
						For ($r;1;Size of array:C274($aFechasPagos))
							USE SET:C118("PagosApdo")
							$date1:=DT_GetDateFromDayMonthYear (1;1;$aAñosPagos{$r})
							$date2:=DT_GetDateFromDayMonthYear (31;12;$aAñosPagos{$r})
							QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$date1;*)
							QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$date2)
							CREATE SET:C116([ACT_Pagos:172];"Año")
							ARRAY INTEGER:C220($aMesesPagos;1)
							DISTINCT VALUES:C339([ACT_Pagos:172]Fecha:2;$aFechasPagos)
							$aMesesPagos{1}:=Month of:C24($aFechasPagos{1})
							For ($hh;1;Size of array:C274($aFechasPagos))
								$found:=Find in array:C230($aMesesPagos;Month of:C24($aFechasPagos{$hh}))
								If ($found=-1)
									INSERT IN ARRAY:C227($aMesesPagos;Size of array:C274($aMesesPagos)+1;1)
									$aMesesPagos{Size of array:C274($aMesesPagos)}:=Month of:C24($aFechasPagos{$hh})
								End if 
							End for 
							For ($y;1;Size of array:C274($aMesesPagos))
								USE SET:C118("Año")
								$last:=DT_GetLastDay ($aMesesPagos{$y};$aAñosPagos{$r})
								$date1:=DT_GetDateFromDayMonthYear (1;$aMesesPagos{$y};$aAñosPagos{$r})
								$date2:=DT_GetDateFromDayMonthYear ($last;$aMesesPagos{$y};$aAñosPagos{$r})
								QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$date1;*)
								QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$date2)
								CREATE SET:C116([ACT_Pagos:172];"Mes "+String:C10($aMesesPagos{$r})+" "+String:C10($aAñosPagos{$r}))
								ACTbol_EmitirRecibos4Pagos ("Mes "+String:C10($aMesesPagos{$r})+" "+String:C10($aAñosPagos{$r});$ID_ModeloRecibo;$aSetsDT{1})
								$alHowMany{1}:=$alHowMany{1}+1
								If ($aDesdeDT{1}=0)
									$aDesdeDT{1}:=$proxima
								End if 
								$proxima:=$proxima+1
								$aHastaDT{1}:=$proxima-1
								$aCuantas{1}:=$aHastaDT{1}-$aDesdeDT{1}+1
								CLEAR SET:C117("Mes "+String:C10($aMesesPagos{$r})+" "+String:C10($aAñosPagos{$r}))
							End for 
						End for 
						CLEAR SET:C117("Año")
					: (s2=1)
						ARRAY DATE:C224($aFechasPagos;0)
						ARRAY LONGINT:C221($aAñosPagos;1)
						DISTINCT VALUES:C339([ACT_Pagos:172]Fecha:2;$aFechasPagos)
						$aAñosPagos{1}:=Year of:C25($aFechasPagos{1})
						For ($hh;2;Size of array:C274($aFechasPagos))
							$found:=Find in array:C230($aAñosPagos;Year of:C25($aFechasPagos{$hh}))
							If ($found=-1)
								INSERT IN ARRAY:C227($aAñosPagos;Size of array:C274($aAñosPagos)+1;1)
								$aAñosPagos{Size of array:C274($aAñosPagos)}:=Year of:C25($aFechasPagos{$hh})
							End if 
						End for 
						For ($r;1;Size of array:C274($aAñosPagos))
							USE SET:C118("PagosApdo")
							$date1:=DT_GetDateFromDayMonthYear (1;1;$aAñosPagos{$r})
							$date2:=DT_GetDateFromDayMonthYear (31;12;$aAñosPagos{$r})
							QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$date1;*)
							QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$date2)
							CREATE SET:C116([ACT_Pagos:172];"Año "+String:C10($aAñosPagos{$r}))
							ACTbol_EmitirRecibos4Pagos ("Año "+String:C10($aAñosPagos{$r});$ID_ModeloRecibo;$aSetsDT{1})
							$alHowMany{1}:=$alHowMany{1}+1
							If ($aDesdeDT{1}=0)
								$aDesdeDT{1}:=$proxima
							End if 
							$proxima:=$proxima+1
							$aHastaDT{1}:=$proxima-1
							$aCuantas{1}:=$aHastaDT{1}-$aDesdeDT{1}+1
							CLEAR SET:C117("Año "+String:C10($aAñosPagos{$r}))
						End for 
				End case 
			: (h2=1)
				CREATE SET:C116([ACT_Pagos:172];"UnDocumento")
				ACTbol_EmitirRecibos4Pagos ("UnDocumento";$ID_ModeloRecibo;$aSetsDT{1})
				$alHowMany{1}:=$alHowMany{1}+1
				If ($aDesdeDT{1}=0)
					$aDesdeDT{1}:=$proxima
				End if 
				$proxima:=$proxima+1
				$aHastaDT{1}:=$proxima-1
				$aCuantas{1}:=$aHastaDT{1}-$aDesdeDT{1}+1
				CLEAR SET:C117("UnDocumento")
			: (h3=1)
				ARRAY LONGINT:C221($aRecNums;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$aRecNums;"")
				For ($u;1;Size of array:C274($aRecNums))
					GOTO RECORD:C242([ACT_Pagos:172];$aRecNums{$u})
					CREATE SET:C116([ACT_Pagos:172];"Pago")
					ACTbol_EmitirRecibos4Pagos ("Pago";$ID_ModeloRecibo;$aSetsDT{1})
					$alHowMany{1}:=$alHowMany{1}+1
					If ($aDesdeDT{1}=0)
						$aDesdeDT{1}:=$proxima
					End if 
					$proxima:=$proxima+1
					$aHastaDT{1}:=$proxima-1
					$aCuantas{1}:=$aHastaDT{1}-$aDesdeDT{1}+1
				End for 
				CLEAR SET:C117("Pago")
		End case 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	COPY ARRAY:C226($atCategorias;atCategorias)
	COPY ARRAY:C226($atDocumentos2Print;atDocumentos2Print)
	COPY ARRAY:C226($alHowMany;alHowMany)
	COPY ARRAY:C226($aDesdeDT;aDesdeDT)
	COPY ARRAY:C226($aHastaDT;aHastaDT)
	COPY ARRAY:C226($aSetsDT;aSetsDT)
	COPY ARRAY:C226($alIDDT;alIDDT)
	$Zero:=Find in array:C230(alHowMany;0)
	While ($Zero#-1)
		CLEAR SET:C117(aSetsDT{$Zero})
		AT_Delete ($Zero;1;->atCategorias;->atDocumentos2Print;->alHowMany;->aDesdeDT;->aHastaDT;->aSetsDT;->alIDDT)
		$Zero:=Find in array:C230(alHowMany;0)
	End while 
	ARRAY BOOLEAN:C223(abDoPrint;Size of array:C274(alHowMany))
	ARRAY PICTURE:C279(apDoPrint;Size of array:C274(alHowMany))
	For ($i;1;Size of array:C274(alHowMany))
		abDoPrint{$i}:=True:C214
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apDoPrint{$i})
	End for 
	xALP_Set_ACT_Docs2Print 
	CLEAR SET:C117("PagosApdo")
End if 