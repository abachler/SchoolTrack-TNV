//%attributes = {}
  //ACTbol_EMasivaRecibos

If (Records in set:C195("Selection")>0)
	ACTcfg_LoadConfigData (8)
	USE SET:C118("Selection")
	KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;"")
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
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosApdo")
		Case of 
			: (h1=1)
				Case of 
					: (s1=1)
						ARRAY LONGINT:C221($aAñosAvisos;0)
						DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]Agno:7;$aAñosAvisos)
						For ($r;1;Size of array:C274($aAñosAvisos))
							USE SET:C118("AvisosApdo")
							QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7=$aAñosAvisos{$r})
							CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Año")
							ARRAY INTEGER:C220($aMesesAvisos;0)
							DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]Mes:6;$aMesesAvisos)
							For ($y;1;Size of array:C274($aMesesAvisos))
								USE SET:C118("Año")
								QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$aMesesAvisos{$y})
								CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Mes "+String:C10($aMesesAvisos{$r})+" "+String:C10($aAñosAvisos{$r}))
								$emitidos:=ACTbol_EmitirRecibos ("Mes "+String:C10($aMesesAvisos{$r})+" "+String:C10($aAñosAvisos{$r});$ID_ModeloRecibo;$aSetsDT{1})
								$alHowMany{1}:=$alHowMany{1}+$emitidos
								If ($aDesdeDT{1}=0)
									$aDesdeDT{1}:=$proxima
								End if 
								$proxima:=$proxima+$emitidos
								$aHastaDT{1}:=$proxima-$emitidos
								$aCuantas{1}:=$aHastaDT{1}-$aDesdeDT{1}+$emitidos
								CLEAR SET:C117("Mes "+String:C10($aMesesAvisos{$r})+" "+String:C10($aAñosAvisos{$r}))
							End for 
						End for 
						CLEAR SET:C117("Año")
					: (s2=1)
						ARRAY LONGINT:C221($aAñosAvisos;0)
						DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]Agno:7;$aAñosAvisos)
						For ($r;1;Size of array:C274($aAñosAvisos))
							USE SET:C118("AvisosApdo")
							QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7=$aAñosAvisos{$r})
							CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Año "+String:C10($aAñosAvisos{$r}))
							$emitidos:=ACTbol_EmitirRecibos ("Año "+String:C10($aAñosAvisos{$r});$ID_ModeloRecibo;$aSetsDT{1})
							$alHowMany{1}:=$alHowMany{1}+$emitidos
							If ($aDesdeDT{1}=0)
								$aDesdeDT{1}:=$proxima
							End if 
							$proxima:=$proxima+$emitidos
							$aHastaDT{1}:=$proxima-$emitidos
							$aCuantas{1}:=$aHastaDT{1}-$aDesdeDT{1}+$emitidos
							CLEAR SET:C117("Año "+String:C10($aAñosAvisos{$r}))
						End for 
				End case 
			: (h2=1)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"UnDocumento")
				$emitidos:=ACTbol_EmitirRecibos ("UnDocumento";$ID_ModeloRecibo;$aSetsDT{1})
				$alHowMany{1}:=$alHowMany{1}+$emitidos
				If ($aDesdeDT{1}=0)
					$aDesdeDT{1}:=$proxima
				End if 
				$proxima:=$proxima+$emitidos
				$aHastaDT{1}:=$proxima-$emitidos
				$aCuantas{1}:=$aHastaDT{1}-$aDesdeDT{1}+$emitidos
				CLEAR SET:C117("UnDocumento")
			: (h3=1)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aRecNums)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"todos")
				CREATE EMPTY SET:C140([ACT_Avisos_de_Cobranza:124];"desctos")
				For ($kj;1;Size of array:C274($aRecNums))
					GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aRecNums{$kj})
					If ([ACT_Avisos_de_Cobranza:124]Monto_Neto:11<0)
						ADD TO SET:C119([ACT_Avisos_de_Cobranza:124];"desctos")
					End if 
				End for 
				DIFFERENCE:C122("todos";"desctos";"todos")
				USE SET:C118("todos")
				LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aRecNums)
				CLEAR SET:C117("todos")
				For ($u;1;Size of array:C274($aRecNums))
					GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aRecNums{$u})
					CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Aviso")
					  //UNION("Aviso";"desctos";"Aviso")
					USE SET:C118("Aviso")
					  //CLEAR SET("desctos")
					$emitidos:=ACTbol_EmitirRecibos ("Aviso";$ID_ModeloRecibo;$aSetsDT{1})
					$alHowMany{1}:=$alHowMany{1}+$emitidos
					If ($aDesdeDT{1}=0)
						$aDesdeDT{1}:=$proxima
					End if 
					$proxima:=$proxima+$emitidos
					$aHastaDT{1}:=$proxima-$emitidos
					$aCuantas{1}:=$aHastaDT{1}-$aDesdeDT{1}+$emitidos
				End for 
				CLEAR SET:C117("Aviso")
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
	CLEAR SET:C117("AvisosApdo")
End if 