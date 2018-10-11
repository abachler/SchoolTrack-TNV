//%attributes = {}
  //ACTexe_ImportaCargosEspeciales

If (USR_GetMethodAcces (Current method name:C684))
	C_TEXT:C284($text)
	C_LONGINT:C283(vi_ACT_DiaGeneracion)
	C_LONGINT:C283(bc_executeOnServer)
	C_REAL:C285(vdACT_AñoAviso)
	C_REAL:C285(vr_Hijo2;vr_Hijo3;vr_Hijo4;vr_Hijo5;vr_Hijo6;vr_Hijo7;vr_Hijo8;vr_Hijo9;vr_Hijo10;vr_Hijo11;vr_Hijo12;vr_Hijo13;vr_Hijo14;vr_Hijo15;vr_Hijo16;vr_Hijo17)
	SET BLOB SIZE:C606(xBlob;0)
	C_BOOLEAN:C305($b_continuar;$b_CargoImputacion)
	ARRAY TEXT:C222(aMeses;0)
	ARRAY TEXT:C222(aMeses2;0)
	
	If (Test semaphore:C652("ConfigACT"))
		CD_Dlog (0;__ ("No es posible realizar la importación de cargos en este momento.")+"\r"+__ ("Otro usuario está realizando modificaciones a la configuración de AccountTrack que podrían afectar este proceso.")+"\r\r"+__ ("Por favor intente la importación más tarde."))
	Else 
		$sem:=Semaphore:C143("ProcesoACT")
		ACTinit_LoadPrefs 
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcc_ImportadorCargos";0;4;__ ("Importación de Cargos"))
		DIALOG:C40([xxSTR_Constants:1];"ACTcc_ImportadorCargos")
		CLOSE WINDOW:C154
		If (ok=1)
			ARRAY LONGINT:C221($alACT_CuentasTomadas;0)
			ARRAY LONGINT:C221($alACT_CuentasTomadas2;0)
			ARRAY LONGINT:C221($alACT_CuentasTomadas3;0)
			ARRAY LONGINT:C221(aLong1;0)
			ARRAY TEXT:C222(aMeses;0)
			ARRAY TEXT:C222(aMeses2;0)
			COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
			COPY ARRAY:C226(aMeses;aMeses2)
			$vl_procID:=IT_UThermometer (1;0;__ ("Importando cargos en el servidor..."))
			ACTcc_OpcionesCalculoCtaCte ("InitArrays")
			
			ACTimp_ArrayDeclarations ("OrdenaArreglos")
			
			C_TEXT:C284($vt_linea;$vt_lineaSiguiente)
			ARRAY LONGINT:C221(aLong1;0)
			For ($i;1;Size of array:C274(aPareo))
				If (aAprobado{$i})
					$b_continuar:=True:C214  //MONO: ticket 155769
					APPEND TO ARRAY:C911(aLong1;0)
					$vt_linea:=ACTimp_ArrayDeclarations ("ConcatenaElementos";->$i)
					
					aLong1{Size of array:C274(aLong1)}:=Find in field:C653([ACT_CuentasCorrientes:175]ID:1;aIDCta{$i})
					$vl_idCta:=aIDCta{$i}
					$vl_idPersona:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCta;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->$vl_idPersona)
					READ ONLY:C145([xxACT_Items:179])
					If (aIDItem{$i}#"0")
						QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=Num:C11(aIDItem{$i}))
					Else 
						QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Glosa:2=aGlosa{$i})
					End if 
					If (Records in selection:C76([xxACT_Items:179])=0)
						
						$vt_glosa:=aGlosa{$i}
						$vb_afecto:=(aAfectoIVA{$i}="SI") | (aAfectoIVA{$i}=__ ("SI"))
						$vb_esDescuento:=(aCargodescto{$i}="descuento") | (aCargodescto{$i}=__ ("descuento"))
						$vt_moneda:=aMoneda{$i}
						$vr_monto:=0
						$vt_ctaContable:=aCtaContable{$i}
						$vt_ctaAuxiliar:=aCodAux{$i}
						$vt_centroCosto:=aCentro{$i}
						$vt_cctaContable:=aCCtaContable{$i}
						$vt_cctaAuxiliar:=aCCodAux{$i}
						$vt_ccentroCosto:=aCCentro{$i}
						$vb_noIncluirDT:=(aNoDocTribs{$i}="SI") | (aNoDocTribs{$i}=__ ("SI"))
						$vt_obs:=__ ("Creado por proceso de importación de cargos realizado por ")+<>tUSR_CurrentUser+__ (" el ")+String:C10(Current date:C33(*);7)+__ (" a las ")+String:C10(Current time:C178(*);2)
						$vb_impUnica:=(aImpUnica{$i}="SI") | (aImpUnica{$i}=__ ("SI"))
						$vb_afectoDctoInd:=(aAfectoaDxCta{$i}="SI") | (aAfectoaDxCta{$i}=__ ("SI"))
						$vb_afectoDcto:=(aAfectoaDesctos{$i}="SI") | (aAfectoaDesctos{$i}=__ ("SI"))
						$vb_afectoInteres:=(Num:C11(aPctInteres{$i})>0)
						$vr_tasaInteres:=Num:C11(aPctInteres{$i})
						$vb_tipoInteres:=(aTipoInteres{$i}="Simple") | (aTipoInteres{$i}=__ ("Simple"))
						$vt_nomArrDctoNoHijo:="aDesctoH"
						$vl_indiceArray:=$i
						ACTitem_CreateRecord ($vt_glosa;$vb_afecto;$vb_esDescuento;$vt_moneda;$vr_monto;$vt_ctaContable;$vt_ctaAuxiliar;$vt_centroCosto;$vt_cctaContable;$vt_cctaAuxiliar;$vt_ccentroCosto;$vb_noIncluirDT;$vt_obs;$vb_impUnica;$vb_afectoDctoInd;$vb_afectoDcto;$vb_afectoInteres;$vr_tasaInteres;$vb_tipoInteres;$vt_nomArrDctoNoHijo;$vl_indiceArray)
						$b_CargoImputacion:=$vb_impUnica  //MONO: se debe cargar la imputación unica por cargo, ticket 155769
					Else 
						$b_CargoImputacion:=[xxACT_Items:179]Imputacion_Unica:24  //MONO: se debe cargar la imputación unica por cargo, ticket 155769
					End if 
					b1:=0
					b2:=0
					b3:=1
					vlACT_SelectedMatrixID:=0
					vlACT_SelectedItemID:=[xxACT_Items:179]ID:1
					vsACT_Glosa:=""
					vsACT_Moneda:=aMoneda{$i}
					vrACT_Monto:=Num:C11(aMontotxt{$i})
					cbACT_EsDescuento:=Num:C11((aCargodescto{$i}="descuento") | (aCargodescto{$i}=__ ("descuento")))
					cbACT_Afecto_Iva:=Num:C11((aAfectoIVA{$i}="SI") | (aAfectoIVA{$i}=__ ("SI")))
					bc_ReplaceSameDescription:=0
					viACT_DiaGeneracion:=1
					bc_EliminaDesctos:=0
					vsACT_CtaContable:=aCtaContable{$i}
					vsACT_CentroContable:=aCentro{$i}
					vsACT_CCtaContable:=aCCtaContable{$i}
					vsACT_CCentroContable:=aCCentro{$i}
					vsACT_CodAuxCta:=aCodAux{$i}
					vsACT_CodAuxCCta:=aCCodAux{$i}
					vdACT_AñoAviso:=Num:C11(aAño{$i})
					vdACT_AñoAviso2:=Num:C11(aAño2{$i})
					aMeses:=Num:C11(aMesDesde{$i})
					aMeses2:=Num:C11(aMesHasta{$i})
					vbACT_CargoEspecial:=False:C215
					vbACT_ImputacionUNica:=False:C215
					cbACT_NoDocTrib:=Num:C11((aNoDocTribs{$i}="SI") | (aNoDocTribs{$i}=__ ("SI")))
					  //BLOB_Variables2Blob (->xBlob;0;->aLong1;->b1;->b2;->b3;->vlACT_SelectedMatrixID;->vlACT_selectedItemId;->vsACT_Glosa;->vsACT_Moneda;->vrACT_Monto;->cbACT_EsDescuento;->cbACT_Afecto_IVA;->bc_ReplaceSameDescription;->aMeses;->aMeses2;->viACT_DiaGeneracion;->bc_ExecuteOnServer;->vbACT_CargoEspecial;->vdACT_AñoAviso;->bc_EliminaDesctos;->vsACT_CtaContable;->vsACT_CentroContable;->vsACT_CCtaContable;->vsACT_CCentroContable;->vbACT_ImputacionUNica;->vsACT_CodAuxCta;->vsACT_CodAuxCCta;->cbACT_NoDocTrib;->vdACT_FechaUFSel;->vdACT_AñoAviso2)
					
					If ($i<=(Size of array:C274(aIDItem)-1))  //parael ultimo registro
						$vl_indice:=$i+1
						$vt_lineaSiguiente:=ACTimp_ArrayDeclarations ("ConcatenaElementos";->$vl_indice)
					Else 
						$vt_lineaSiguiente:=""
					End if 
					
					  //20140827 ASM Agrego validación para cargos de imputación unica.
					If ($b_CargoImputacion)
						$b_continuar:=($vt_linea#$vt_lineaSiguiente)
					End if 
					
					  //If ($vt_linea#$vt_lineaSiguiente)
					If ($b_continuar)
						
						ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
						ARRAY DATE:C224(adACT_fechasEm;0)
						ACTcar_OpcionesGenerales ("CargaBlobParaGeneracion";->xBlob)
						
						IT_UThermometer (0;$vl_procID;"Procesando: "+String:C10(Size of array:C274(aLong1))+" registros... Registros totales procesados: "+String:C10($i)+" de un total de: "+String:C10(Size of array:C274(aPareo))+"...")
						
						$processID:=Execute on server:C373("ACTcc_GeneraCargos";Pila_256K;"Generación de deudas";xblob;vpXS_IconModule;vsBWR_CurrentModule;False:C215)
						
						DELAY PROCESS:C323(Current process:C322;60)  //permitir que el proceso se inicie en el server
						$generando:=False:C215
						While (Not:C34($generando))
							IDLE:C311
							GET PROCESS VARIABLE:C371($processID;vbACT_Generando;$generando)
						End while 
						GET PROCESS VARIABLE:C371($processID;alACT_CuentasTomadas;$alACT_CuentasTomadas)
						$generando:=False:C215
						SET PROCESS VARIABLE:C370($processID;vb_calcularCtas;$generando)
						$generando:=True:C214
						SET PROCESS VARIABLE:C370($processID;vbACT_TerminardeGenerar;$generando)
						ARRAY LONGINT:C221(aLong1;0)
						
						COPY ARRAY:C226($alACT_CuentasTomadas3;$alACT_CuentasTomadas2)
						AT_Union (->$alACT_CuentasTomadas;->$alACT_CuentasTomadas2;->$alACT_CuentasTomadas3)
					End if 
				End if 
			End for 
			IT_UThermometer (-2;$vl_procID)
			ACTcc_OpcionesCalculoCtaCte ("RecalcularCtasBash")
			If (Size of array:C274($alACT_CuentasTomadas3)>0)
				ACTcc_MostrarCuentasExcluidas (->$alACT_CuentasTomadas3)
			End if 
			LOG_RegisterEvt ("Proceso de importación de cargos desde archivo "+SYS_Path2FileName (vt_g1)+".")
			
			  //20120528 RCH Al finalizar tambien se buscaran las cuentas que entraron a proceso...
			  //CD_Dlog (0;__ ("El proceso de importación de cargos ha finalizado. El recálculo de saldos de las cuentas afectadas está en proceso y terminará en breves momentos."))
			$vl_resp:=CD_Dlog (0;__ ("El proceso de importación de cargos ha finalizado. El recálculo de saldos de las cuentas afectadas está en proceso y terminará en breves momentos.")+"\r\r"+__ ("A continuación, se listarán las Cuentas Corrientes que entraron al proceso de importación de cargos. Por favor verifique los cargos proyectados de dichas Cuentas Corrientes."))
			  //***** Cambio de pestaña a Ctas Ctes... *****
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;aIDCta)
			$vl_item:=175  //numero de tabla de Ctas ctes
			SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;$vl_item)
			$tab:=Selected list items:C379(vlXS_BrowserTab)
			GET LIST ITEM:C378(vlXS_BrowserTab;$tab;vlBWR_SelectedTableRef;vsBWR_selectedTableName)
			yBWR_currentTable:=->[ACT_CuentasCorrientes:175]  //pointer to the default table displayed in browser    
			CREATE SET:C116(yBWR_CurrentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
			
			BWR_PanelSettings 
			BWR_SelectTableData 
			XS_SetInterface 
			ALP_SetInterface (xALP_Browser)
			  //***** Cambio de pestaña a Ctas Ctes... *****
			
		End if 
		CLEAR SEMAPHORE:C144("ProcesoACT")
		ACTimp_ArrayDeclarations 
	End if 
End if 