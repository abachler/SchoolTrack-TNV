//%attributes = {}
  //ACTexe_ImportaConfItems
C_BOOLEAN:C305($AfectoDcto;$AfectoInteres;$AfectoIva;$DctoxCta;$EnDocTributarios;$esCargo;$esDcto;$EsRelativo;$ImputacionUnica;$ItemGlobal)
C_BOOLEAN:C305($itemImpUnica;$itemMatrices;$NoRecarAutomaticos;$VentaDirecta)
C_LONGINT:C283($i;$month;$vl_IdCuenta;$vl_idMoneda;$vl_resp;$vl_tipo;$x)
C_TIME:C306($ref)
C_POINTER:C301($pointer;$pointer2)
C_TEXT:C284($monto)
C_TEXT:C284($Cauxiliar;$CCauxiliar;$CCcosto;$Ccosto;$CPcuenta;$Dctoxcargastotales;$Dctoxhijo;$delimiter;$document;$glosa)
C_TEXT:C284($glosaCCta;$glosaCta;$meses;$moneda;$Observación;$Pcuenta;$RazonSocial;$TasaMensual;$text;$TipoInteres)

C_TEXT:C284($t_periodo)
C_TEXT:C284($t_CentroCostoCtaCont1;$t_CentroCostoCtaCont2;$t_CentroCostoCtaCont3;$t_CentroCostoCtaCont4;$t_CentroCostoCtaCont5;$t_CentroCostoCtaCont6;$t_CentroCostoCtaCont7)
C_TEXT:C284($t_CentroCostoCtaCont8;$t_CentroCostoCtaCont9;$t_CentroCostoCtaCont10;$t_CentroCostoCtaCont11;$t_CentroCostoCtaCont12;$t_CentroCostoCtaCont13;$t_CentroCostoCtaCont14;$t_CentroCostoCtaCont15)

C_TEXT:C284($t_CentroCostoCCtaCont1;$t_CentroCostoCCtaCont2;$t_CentroCostoCCtaCont3;$t_CentroCostoCCtaCont4;$t_CentroCostoCCtaCont5;$t_CentroCostoCCtaCont6;$t_CentroCostoCCtaCont7)
C_TEXT:C284($t_CentroCostoCCtaCont8;$t_CentroCostoCCtaCont9;$t_CentroCostoCCtaCont10;$t_CentroCostoCCtaCont11;$t_CentroCostoCCtaCont12;$t_CentroCostoCCtaCont13;$t_CentroCostoCCtaCont14;$t_CentroCostoCCtaCont15)

ARRAY TEXT:C222($at_centroCostoCtaCont;0)
ARRAY TEXT:C222($at_centroCostoCCtaCont;0)

ARRAY TEXT:C222($at_descuentosxcargas;0)
ARRAY TEXT:C222($at_descuentosxhijo;0)
ARRAY TEXT:C222($at_numerodemeses;0)

  //20150624 RCH. Error en compilado
C_REAL:C285(vr_Hijo2;vr_Hijo3;vr_Hijo4;vr_Hijo5;vr_Hijo6;vr_Hijo7;vr_Hijo8;vr_Hijo9;vr_Hijo10;vr_Hijo11;vr_Hijo12;vr_Hijo13;vr_Hijo14;vr_Hijo15;vr_Hijo16;vr_Hijo17)
C_REAL:C285(vr_Familia2;vr_Familia3;vr_Familia4;vr_Familia5;vr_Familia6;vr_Familia7;vr_Familia8;vr_Familia9;vr_Familia10;vr_Familia11;vr_Familia12;vr_Familia13;vr_Familia14;vr_Familia15;vr_Familia16;vr_Familia17)


READ ONLY:C145([xxACT_Monedas:146])
C_BLOB:C604(xBlob)

ACTdesc_OpcionesVariables ("DeclaraVars")

ACTcfgmyt_OpcionesGenerales ("LeeMonedas")

WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcc_ImportadorItems";0;4;__ ("Importación de configuración de Items"))
DIALOG:C40([xxSTR_Constants:1];"ACTcc_ImportadorItems")
CLOSE WINDOW:C154

If (ok=1)
	$el:=Find in array:C230(at_glosa;"")
	If ($el>0)
		$vl_resp:=CD_Dlog (0;__ ("Existen ítems  sin glosa definida.  Estos datos no serán Importados.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Continuar");__ ("Cancelar"))
	Else 
		$vl_resp:=1
	End if 
	
	If ($vl_resp=1)
		If (ok=1)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Importando items...")
			For ($i;1;Size of array:C274(at_glosa))
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(at_glosa))
				If (at_glosa{$i}#"")
					$glosa:=at_glosa{$i}
					$moneda:=at_moneda{$i}
					$monto:=at_monto{$i}
					$EsRelativo:=ST_String2Boolean (at_EsRelativo{$i})
					$AfectoIva:=ST_String2Boolean (at_AfectoIva{$i})
					$EnDocTributarios:=ST_String2Boolean (at_EnDocTributarios{$i})
					$esDcto:=ST_String2Boolean (at_EsDcto{$i})
					$AfectoDcto:=ST_String2Boolean (at_AfectoDcto{$i})
					$DctoxCta:=ST_String2Boolean (at_DctoxCta{$i})
					$ItemGlobal:=ST_String2Boolean (at_ItemGlobal{$i})
					$ImputacionUnica:=ST_String2Boolean (at_ImputacionUnica{$i})
					$Pcuenta:=at_Pcuenta{$i}
					$glosaCta:=at_glosaCta{$i}
					$Cauxiliar:=at_Cauxiliar{$i}
					$Ccosto:=at_Ccosto{$i}
					$CPcuenta:=at_CPcuenta{$i}
					$glosaCCta:=at_glosaCCta{$i}
					$CCauxiliar:=at_CCauxiliar{$i}
					$CCcosto:=at_CCcosto{$i}
					$AfectoInteres:=ST_String2Boolean (at_AfectoInteres{$i})
					$TipoInteres:=at_TipoInteres{$i}
					$TasaMensual:=at_TasaMensual{$i}
					$Observación:=at_Observacion{$i}
					$VentaDirecta:=ST_String2Boolean (at_VentaDirecta{$i})
					$afectoRecargosAut:=ST_String2Boolean (at_afectoRecargosAut{$i})
					$meses:=at_MesesActivos{$i}
					$Dctoxhijo:=at_Dctoxhijo{$i}
					$Dctoxcargastotales:=at_Dctoxcargastotales{$i}
					$RazonSocial:=at_RazonSocial{$i}
					
					$t_periodo:=at_periodoItems{$i}
					
					AT_Initialize (->$at_centroCostoCtaCont)
					
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN1{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN2{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN3{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN4{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN5{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN6{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN7{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN8{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN9{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN10{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN11{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN12{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN13{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN14{$i})
					APPEND TO ARRAY:C911($at_centroCostoCtaCont;at_cccN15{$i})
					
					AT_Initialize (->$at_centroCostoCCtaCont)
					
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN1{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN2{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN3{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN4{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN5{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN6{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN7{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN8{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN9{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN10{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN11{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN12{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN13{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN14{$i})
					APPEND TO ARRAY:C911($at_centroCostoCCtaCont;at_ccccN15{$i})
					
					
					If ($moneda#"")
						QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Nombre_Moneda:2=$moneda)
						If (Records in selection:C76([xxACT_Monedas:146])=0)
							$vl_idMoneda:=Num:C11(ACTcfgmyt_OpcionesGenerales ("AgregaMoneda"))
							ACTcfgmyt_OpcionesGenerales ("ModificaCampoMoneda";->$vl_idMoneda;->[xxACT_Monedas:146]Nombre_Moneda:2;->$moneda)
						End if 
					Else 
						QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Moneda_X_Defecto_Base:11=True:C214)
						$moneda:=[xxACT_Monedas:146]Nombre_Moneda:2
					End if 
					
					If ($meses#"")
						AT_Text2Array (->$at_numerodemeses;$meses;";")
					End if 
					If ($Dctoxhijo#"")
						AT_Text2Array (->$at_descuentosxhijo;$Dctoxhijo;";")
					End if 
					If ($Dctoxcargastotales#"")
						AT_Text2Array (->$at_descuentosxcargas;$Dctoxcargastotales;";")
					End if 
					
					  //Verifico la cuenta contable para crearlas
					ACTcfg_LoadConfigData (10)
					If ($Pcuenta#"")
						$el:=Find in array:C230(<>asACT_CuentaCta;$Pcuenta)
						If ($el=-1)
							$vl_tipo:=1
							$vl_IdCuenta:=Num:C11(ACTcfg_OpcionesContabilidad ("CreaRegistro";->$vl_tipo))
							APPEND TO ARRAY:C911(<>alACT_idCta;$vl_IdCuenta)
							APPEND TO ARRAY:C911(<>asACT_CuentaCta;$Pcuenta)
							APPEND TO ARRAY:C911(<>asACT_GlosaCta;$glosaCta)
							APPEND TO ARRAY:C911(<>asACT_CodAuxCta;$Cauxiliar)
						End if 
					End if 
					  //Verifico la contra cuenta contable para crearlas
					If ($CPcuenta#"")
						$el:=Find in array:C230(<>asACT_CuentaCta;$CPcuenta)
						If ($el=-1)
							$vl_tipo:=1
							$vl_IdCuenta:=Num:C11(ACTcfg_OpcionesContabilidad ("CreaRegistro";->$vl_tipo))
							APPEND TO ARRAY:C911(<>alACT_idCta;$vl_IdCuenta)
							APPEND TO ARRAY:C911(<>asACT_CuentaCta;$CPcuenta)
							APPEND TO ARRAY:C911(<>asACT_GlosaCta;$glosaCCta)
							APPEND TO ARRAY:C911(<>asACT_CodAuxCta;$CCauxiliar)
						End if 
					End if 
					  //verifico centro de costos
					If ($Ccosto#"")
						$el:=Find in array:C230(<>asACT_Centro;$Ccosto)
						If ($el=-1)
							$vl_tipo:=2
							$vl_IdCuenta:=Num:C11(ACTcfg_OpcionesContabilidad ("CreaRegistro";->$vl_tipo))
							APPEND TO ARRAY:C911(<>alACT_idCentro;$vl_IdCuenta)
							APPEND TO ARRAY:C911(<>asACT_Centro;$Ccosto)
							APPEND TO ARRAY:C911(<>atACT_CentroGlosa;"")
						End if 
					End if 
					  //verifico centro de costos de contracuenta
					If ($CCcosto#"")
						$el:=Find in array:C230(<>asACT_Centro;$CCcosto)
						If ($el=-1)
							$vl_tipo:=2
							$vl_IdCuenta:=Num:C11(ACTcfg_OpcionesContabilidad ("CreaRegistro";->$vl_tipo))
							APPEND TO ARRAY:C911(<>alACT_idCentro;$vl_IdCuenta)
							APPEND TO ARRAY:C911(<>asACT_Centro;$CCcosto)
							APPEND TO ARRAY:C911(<>atACT_CentroGlosa;"")
						End if 
					End if 
					ACTcfg_SaveConfig (10)
					
					CREATE RECORD:C68([xxACT_Items:179])
					
					If (USR_GetUserID >0)  //20150609 RCH Permite importar caracteres para boletas electronicas.
						$glosa:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233($glosa;"(";"[");")";"]");"/";"_");"\\";"_")
					End if 
					[xxACT_Items:179]Glosa:2:=$glosa
					[xxACT_Items:179]Afecto_a_descuentos:4:=$AfectoDcto
					[xxACT_Items:179]Afecto_IVA:12:=$AfectoIva
					[xxACT_Items:179]AfectoDsctoIndividual:17:=$DctoxCta
					[xxACT_Items:179]AfectoInteres:26:=$AfectoInteres
					[xxACT_Items:179]CCentro_de_costos:23:=$CCcosto
					[xxACT_Items:179]Centro_de_Costos:21:=$Ccosto
					[xxACT_Items:179]CodAuxCCta:28:=$CCauxiliar
					[xxACT_Items:179]CodAuxCta:27:=$Cauxiliar
					[xxACT_Items:179]EsDescuento:6:=$esDcto
					[xxACT_Items:179]EsRelativo:5:=$EsRelativo
					[xxACT_Items:179]Glosa_de_Impresión:20:=$glosa
					[xxACT_Items:179]ID_RazonSocial:36:=Num:C11($RazonSocial)
					[xxACT_Items:179]Imputacion_Unica:24:=$ImputacionUnica
					[xxACT_Items:179]Item_Global:13:=$ItemGlobal
					[xxACT_Items:179]Moneda:10:=$moneda
					[xxACT_Items:179]Monto:7:=Num:C11($monto)
					[xxACT_Items:179]No_CCta_contable:22:=$CPcuenta
					[xxACT_Items:179]No_de_Cuenta_Contable:15:=$Pcuenta
					[xxACT_Items:179]No_incluir_en_DocTributario:31:=Not:C34($EnDocTributarios)
					[xxACT_Items:179]NoAfecto_a_RecargosAut:37:=$afectoRecargosAut
					[xxACT_Items:179]id_tipoRecargoAut:45:=Choose:C955([xxACT_Items:179]NoAfecto_a_RecargosAut:37;0;1)
					[xxACT_Items:179]Observaciones:11:=$Observación+"\r"+"Item creado por importación"
					[xxACT_Items:179]RazonSocialAsociada:35:=$RazonSocial
					[xxACT_Items:179]TasaInteresMensual:25:=Num:C11($TasaMensual)
					[xxACT_Items:179]VentaRapida:3:=$VentaDirecta
					
					If ($TipoInteres="Simple")
						[xxACT_Items:179]TipoInteres:29:=True:C214
					Else 
						[xxACT_Items:179]TipoInteres:29:=False:C215
					End if 
					
					For ($x;1;Size of array:C274($at_numerodemeses))
						$month:=Num:C11($at_numerodemeses{$x})
						[xxACT_Items:179]Meses_de_cargo:9:=[xxACT_Items:179]Meses_de_cargo:9 ?+ $month
					End for 
					
					For ($x;1;Size of array:C274($at_descuentosxhijo))
						If ($x<17)  //20150627 para evitar error cuando se especifican 17 descuentos...
							$pointer:=Get pointer:C304("vr_Hijo"+String:C10($x+1))
							$pointer2:=Get pointer:C304("vr_Familia"+String:C10($x+1))
							$pointer->:=Num:C11($at_descuentosxhijo{$x})
							$pointer2->:=Num:C11($at_descuentosxcargas{$x})
						End if 
					End for 
					
					BLOB_Variables2Blob (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
					BLOB_Variables2Blob (->[xxACT_Items:179]Descuento_Familia:32;0;->vr_Familia2;->vr_Familia3;->vr_Familia4;->vr_Familia5;->vr_Familia6;->vr_Familia7;->vr_Familia8;->vr_Familia9;->vr_Familia10;->vr_Familia11;->vr_Familia12;->vr_Familia13;->vr_Familia14;->vr_Familia15;->vr_Familia16;->vr_Familia17)
					
					[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1)
					
					[xxACT_Items:179]Periodo:42:=at_periodoItems{$i}
					
					SAVE RECORD:C53([xxACT_Items:179])
					
					  //guarda en configuración de información contable
					  //Verifico la cuenta contable para crearlas
					ACTcfg_LoadConfigData (10)
					
					  // guarda conf centros de costo items
					ACTitems_LeeCentrosCostoXNivel ([xxACT_Items:179]ID:1)
					C_REAL:C285($r_numNivel)
					C_LONGINT:C283($l_pos)
					vbACTcfg_EnItemsEsp:=False:C215
					$r_numNivel:=-3
					For ($l_indice;1;Size of array:C274($at_centroCostoCtaCont))
						If ($r_numNivel=0)
							$r_numNivel:=1
						End if 
						
						If ($at_centroCostoCtaCont{$l_indice}#"")
							$l_pos:=Find in array:C230(alACT_CCXN_NivelID;$r_numNivel)
							If ($l_pos#-1)
								atACT_CCXN_CentroCosto{$l_pos}:=$at_centroCostoCtaCont{$l_indice}
								abACT_CCXN_UsarConfItem{$l_pos}:=False:C215
								  //verifico centro de costos
								$el:=Find in array:C230(<>asACT_Centro;$at_centroCostoCtaCont{$l_indice})
								If ($el=-1)
									$vl_tipo:=2
									$vl_IdCuenta:=Num:C11(ACTcfg_OpcionesContabilidad ("CreaRegistro";->$vl_tipo))
									APPEND TO ARRAY:C911(<>alACT_idCentro;$vl_IdCuenta)
									APPEND TO ARRAY:C911(<>asACT_Centro;$at_centroCostoCtaCont{$l_indice})
									APPEND TO ARRAY:C911(<>atACT_CentroGlosa;"")
								End if 
							End if 
						End if 
						
						If ($at_centroCostoCCtaCont{$l_indice}#"")
							$l_pos:=Find in array:C230(alACT_CCXN_NivelID;$r_numNivel)
							If ($l_pos#-1)
								atACT_CCXN_CentroCostoContra{$l_pos}:=$at_centroCostoCCtaCont{$l_indice}
								abACT_CCXN_UsarConfItem{$l_pos}:=False:C215
							End if 
							  //verifico centro de costos de contracuenta
							$el:=Find in array:C230(<>asACT_Centro;$at_centroCostoCCtaCont{$l_indice})
							If ($el=-1)
								$vl_tipo:=2
								$vl_IdCuenta:=Num:C11(ACTcfg_OpcionesContabilidad ("CreaRegistro";->$vl_tipo))
								APPEND TO ARRAY:C911(<>alACT_idCentro;$vl_IdCuenta)
								APPEND TO ARRAY:C911(<>asACT_Centro;$at_centroCostoCCtaCont{$l_indice})
								APPEND TO ARRAY:C911(<>atACT_CentroGlosa;"")
							End if 
						End if 
						
						$r_numNivel:=$r_numNivel+1
					End for 
					ACTitems_GuardaCCostoXNivel 
					SAVE RECORD:C53([xxACT_Items:179])
					  // guarda conf centros de costo items
					
					  //guardo configuración contable
					ACTcfg_SaveConfig (10)
					
					LOG_RegisterEvt ("Creación de ítem de cargo por importación  "+[xxACT_Items:179]Glosa:2+".")
					AT_Initialize (->$at_descuentosxcargas;->$at_descuentosxhijo;->$at_numerodemeses)
					
					KRL_UnloadReadOnly (->[xxACT_Items:179])
				End if 
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			CD_Dlog (0;__ ("Importación finalizada exitosamente."))
		End if 
	Else 
		
	End if 
	
End if 