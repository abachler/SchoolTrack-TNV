  // [xxACT_Items].Configuration.Variable2()

If (Records in table:C83([xxACT_Items:179])>0)
	$currentItem:=Record number:C243([xxACT_Items:179])
	
	C_TEXT:C284($t_fileName;$t_folderPath;$t_rutaDocumento;$t_title)
	C_LONGINT:C283($l_col;$l_fila;$l_hoja;$l_refXLS;$l_success)
	
	If (SYS_IsWindows )
		USE CHARACTER SET:C205("windows-1252";0)
	Else 
		USE CHARACTER SET:C205("MacRoman";0)
	End if 
	
	
	
	$l_refXLS:=XLS Create (1)
	$l_hoja:=1
	$l_fila:=1
	XLS Set sheet name ($l_refXLS;$l_hoja;"Ítems")
	
	C_TEXT:C284($t_glosaCCta)  //20130822 RCH se cambia nombe a variable $glosaCCta
	C_TEXT:C284($t_glosaCta)  //20130822 RCH se cambia nombe a variable $glosaCta
	C_TEXT:C284($t_razonSocial)  //20130822 RCH Se agrega RS del colegio
	C_TEXT:C284($t_periodo)  //20130926 RCH 
	C_LONGINT:C283($l_idRS)
	
	READ ONLY:C145([xxACT_Items:179])
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1>0)
	ORDER BY:C49([xxACT_Items:179];[xxACT_Items:179]Periodo:42;>;[xxACT_Items:179]Glosa:2;>)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo con definiciones de items de cargo...")
	$title:="Definiciones de Items de Cargo al "+String:C10(Current date:C33(*);7)+"\r\r"
	XLS Set text value ($l_refXLS;$l_hoja;$l_fila;1;$title)
	$l_fila:=$l_fila+1
	
	ARRAY TEXT:C222(aHeaders;0)
	  //ARRAY TEXT(aHeaders;30) // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
	ARRAY TEXT:C222(aHeaders;31)
	AT_Inc (0)
	aHeaders{AT_Inc }:="ID"
	aHeaders{AT_Inc }:="Glosa"
	aHeaders{AT_Inc }:="Moneda"
	aHeaders{AT_Inc }:="Monto"
	aHeaders{AT_Inc }:="Es Relativo"
	aHeaders{AT_Inc }:="Afecto a IVA"
	aHeaders{AT_Inc }:="En Documentos Tributarios"
	aHeaders{AT_Inc }:="Es Descuento"
	aHeaders{AT_Inc }:="Afecto a Descuentos"
	aHeaders{AT_Inc }:="Afecto a Descuento por Cuenta"
	aHeaders{AT_Inc }:="Item Global"
	aHeaders{AT_Inc }:="Imputacion Unica"
	aHeaders{AT_Inc }:="Cuenta Contable"
	aHeaders{AT_Inc }:="Glosa Cuenta Contable"
	aHeaders{AT_Inc }:="Cod. Auxiliar"
	aHeaders{AT_Inc }:="Centro de Costos"
	aHeaders{AT_Inc }:="Contra Cuenta Contable"
	aHeaders{AT_Inc }:="Glosa Contra Cuenta Contable"
	aHeaders{AT_Inc }:="Contra Cod. Auxiliar"
	aHeaders{AT_Inc }:="Contra Centro de Costos"
	aHeaders{AT_Inc }:="Afecto a Intereses"
	aHeaders{AT_Inc }:="Tipo interés"
	aHeaders{AT_Inc }:="Tasa de interés (%)"
	aHeaders{AT_Inc }:="Observación"
	aHeaders{AT_Inc }:="Venta Rapida"
	aHeaders{AT_Inc }:="Id utilizado en cargos por tramo"  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
	aHeaders{AT_Inc }:="Afecto recargo automatico"
	aHeaders{AT_Inc }:="Meses activos"
	aHeaders{AT_Inc }:="Descuento por numero de hijos"
	aHeaders{AT_Inc }:="Descuento por hijos o cargas totales"
	aHeaders{AT_Inc }:="Codigo interno"
	APPEND TO ARRAY:C911(aHeaders;"Razón Social")
	APPEND TO ARRAY:C911(aHeaders;"Período")
	
	FIRST RECORD:C50([xxACT_Items:179])
	ACTitems_LeeCentrosCostoXNivel ([xxACT_Items:179]ID:1)
	
	For ($l_niveles;1;Size of array:C274(atACT_CCXN_Nivel))
		APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv "+String:C10(alACT_CCXN_NivelID{$l_niveles}))
	End for 
	
	For ($l_niveles;1;Size of array:C274(atACT_CCXN_Nivel))
		APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv "+String:C10(alACT_CCXN_NivelID{$l_niveles}))
	End for 
	
	For ($l_col;1;Size of array:C274(aHeaders))
		XLS Set text value ($l_refXLS;$l_hoja;$l_fila;$l_col;aHeaders{$l_col})
	End for 
	
	FIRST RECORD:C50([xxACT_Items:179])
	While (Not:C34(End selection:C36([xxACT_Items:179])))
		
		$l_fila:=$l_fila+1
		
		  //20120524 ASM Se realizan modificaciones por integración de funcionalidad (ticket 104968)
		ARRAY TEXT:C222($at_meses;0)
		ARRAY TEXT:C222($at_DctoHijos;0)
		ARRAY TEXT:C222($at_DctoFamilias;0)
		For ($x;1;12)
			If ([xxACT_Items:179]Meses_de_cargo:9 ?? $x)
				APPEND TO ARRAY:C911($at_meses;String:C10($x))
			End if 
		End for 
		
		
		BLOB_Blob2Vars (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
		BLOB_Blob2Vars (->[xxACT_Items:179]Descuento_Familia:32;0;->vr_Familia2;->vr_Familia3;->vr_Familia4;->vr_Familia5;->vr_Familia6;->vr_Familia7;->vr_Familia8;->vr_Familia9;->vr_Familia10;->vr_Familia11;->vr_Familia12;->vr_Familia13;->vr_Familia14;->vr_Familia15;->vr_Familia16;->vr_Familia17)
		
		For ($x;2;17)
			$pointer:=Get pointer:C304("vr_Hijo"+String:C10($x))
			$pointer2:=Get pointer:C304("vr_Familia"+String:C10($x))
			APPEND TO ARRAY:C911($at_DctoHijos;String:C10($pointer->))
			APPEND TO ARRAY:C911($at_DctoFamilias;String:C10($pointer2->))
		End for 
		
		  //busco glosa de Cuenta Contable
		$t_glosaCta:=""  //20130822 RCH
		$el:=Find in array:C230(<>asACT_CuentaCta;[xxACT_Items:179]No_de_Cuenta_Contable:15)
		If ($el#-1)
			$t_glosaCta:=<>asACT_GlosaCta{$el}
		End if 
		
		  //busco glosa de Contra Cuenta Contable
		$t_glosaCCta:=""  //20130822 RCH
		$el:=Find in array:C230(<>asACT_CuentaCta;[xxACT_Items:179]No_CCta_contable:22)
		If ($el#-1)
			$t_glosaCCta:=<>asACT_GlosaCta{$el}
		End if 
		
		  //20130822 RCH se agrega nombre RS
		$l_idRS:=[xxACT_Items:179]ID_RazonSocial:36
		If ($l_idRS=0)
			$l_idRS:=-1
		End if 
		$t_razonSocial:=Choose:C955([xxACT_Items:179]RazonSocialAsociada:35#"";[xxACT_Items:179]RazonSocialAsociada:35;KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$l_idRS;->[ACT_RazonesSociales:279]razon_social:2))
		$t_periodo:=[xxACT_Items:179]Periodo:42  //20130926  RCH
		
		
		ARRAY TEXT:C222(aHeaders;0)
		APPEND TO ARRAY:C911(aHeaders;String:C10([xxACT_Items:179]ID:1))
		APPEND TO ARRAY:C911(aHeaders;ST_CleanString ([xxACT_Items:179]Glosa:2))
		APPEND TO ARRAY:C911(aHeaders;[xxACT_Items:179]Moneda:10)
		APPEND TO ARRAY:C911(aHeaders;String:C10([xxACT_Items:179]Monto:7))
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]EsRelativo:5;"SI";"NO"))
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]Afecto_IVA:12;"SI";"NO"))
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]No_incluir_en_DocTributario:31;"NO";"SI"))
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]EsDescuento:6;"SI";"NO"))
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]Afecto_a_descuentos:4;"SI";"NO"))
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]AfectoDsctoIndividual:17;"SI";"NO"))
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]Item_Global:13;"SI";"NO"))
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]Imputacion_Unica:24;"SI";"NO"))
		APPEND TO ARRAY:C911(aHeaders;[xxACT_Items:179]No_de_Cuenta_Contable:15)
		APPEND TO ARRAY:C911(aHeaders;$t_glosaCta)
		APPEND TO ARRAY:C911(aHeaders;[xxACT_Items:179]CodAuxCta:27)
		APPEND TO ARRAY:C911(aHeaders;[xxACT_Items:179]Centro_de_Costos:21)
		APPEND TO ARRAY:C911(aHeaders;[xxACT_Items:179]No_CCta_contable:22)
		APPEND TO ARRAY:C911(aHeaders;$t_glosaCCta)
		APPEND TO ARRAY:C911(aHeaders;[xxACT_Items:179]CodAuxCCta:28)
		APPEND TO ARRAY:C911(aHeaders;[xxACT_Items:179]CCentro_de_costos:23)
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]AfectoInteres:26;"SI";"NO"))
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]TipoInteres:29;"Simple";"Compuesto"))
		APPEND TO ARRAY:C911(aHeaders;String:C10([xxACT_Items:179]TasaInteresMensual:25))
		APPEND TO ARRAY:C911(aHeaders;Replace string:C233([xxACT_Items:179]Observaciones:11;"\r";"(salto)"))
		APPEND TO ARRAY:C911(aHeaders;ST_Boolean2Str ([xxACT_Items:179]VentaRapida:3;"Si";"No"))
		APPEND TO ARRAY:C911(aHeaders;String:C10(Choose:C955([xxACT_Items:179]tramos_idItem:51=0;[xxACT_Items:179]ID:1;[xxACT_Items:179]tramos_idItem:51)))  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
		APPEND TO ARRAY:C911(aHeaders;Choose:C955([xxACT_Items:179]id_tipoRecargoAut:45;"No afecto";"Al vencimiento";"Según tabla"))
		APPEND TO ARRAY:C911(aHeaders;AT_array2text (->$at_meses;";"))
		APPEND TO ARRAY:C911(aHeaders;AT_array2text (->$at_DctoHijos;";"))
		APPEND TO ARRAY:C911(aHeaders;AT_array2text (->$at_DctoFamilias;";"))
		APPEND TO ARRAY:C911(aHeaders;[xxACT_Items:179]Codigo_interno:48)
		APPEND TO ARRAY:C911(aHeaders;$t_razonSocial)
		APPEND TO ARRAY:C911(aHeaders;$t_periodo)
		
		ACTitems_LeeCentrosCostoXNivel ([xxACT_Items:179]ID:1)
		
		For ($l_niveles;1;Size of array:C274(atACT_CCXN_Nivel))
			APPEND TO ARRAY:C911(aHeaders;atACT_CCXN_CentroCosto{$l_niveles})
		End for 
		
		For ($l_niveles;1;Size of array:C274(atACT_CCXN_Nivel))
			APPEND TO ARRAY:C911(aHeaders;atACT_CCXN_CentroCostoContra{$l_niveles})
		End for 
		
		For ($l_columnas;1;Size of array:C274(aHeaders))
			XLS Set text value ($l_refXLS;$l_hoja;$l_fila;$l_columnas;aHeaders{$l_columnas})
		End for 
		
		NEXT RECORD:C51([xxACT_Items:179])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([xxACT_Items:179])/Records in table:C83([xxACT_Items:179]);"Generando archivo con definiciones de items de cargo...")
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	$t_folderPath:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)
	$t_rutaDocumento:=$t_folderPath+"DefConfItems"+String:C10(Day of:C23(Current date:C33(*)))+String:C10(Month of:C24(Current date:C33(*)))+String:C10(Year of:C25(Current date:C33(*)))+".xls"
	$l_success:=XLS Save as ($l_refXLS;$t_rutaDocumento)
	XLS CLOSE ($l_refXLS)
	USE CHARACTER SET:C205(*;0)
	
	ACTcd_DlogWithShowOnDisk ($t_rutaDocumento;0;"Archivo generado con éxito. Puede encontrarlo en"+"\r\r"+$t_rutaDocumento)
	AT_Initialize (->aHeaders)
	USE CHARACTER SET:C205(*;0)
	
	READ WRITE:C146([xxACT_Items:179])
	GOTO RECORD:C242([xxACT_Items:179];$currentItem)
	
Else 
	CD_Dlog (0;"No existen definiciones de items de cargo.")
End if 

