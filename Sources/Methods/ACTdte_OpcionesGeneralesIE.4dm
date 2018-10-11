//%attributes = {}
  //ACTdte_OpcionesGeneralesIE
C_TEXT:C284($vt_accion;$1;$vt_nombrePref;$vt_retorno;$0)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1;$vy_pointer2)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="InsertaElemento")
		AT_Insert (0;1;->atACTie_COLUMNA1;->atACTie_COLUMNA2;->atACTie_COLUMNA3;->atACTie_COLUMNA4;->atACTie_COLUMNA5;->atACTie_COLUMNA6;->atACTie_COLUMNA7;->atACTie_COLUMNA8;->atACTie_COLUMNA9;->atACTie_COLUMNA10;->atACTie_COLUMNA11;->atACTie_COLUMNA12;->atACTie_COLUMNA13;->atACTie_COLUMNA14;->atACTie_COLUMNA15;->atACTie_COLUMNA16;->atACTie_COLUMNA17;->atACTie_COLUMNA18;->atACTie_COLUMNA19;->atACTie_COLUMNA20;->atACTie_COLUMNA21;->atACTie_COLUMNA22;->atACTie_COLUMNA23;->atACTie_COLUMNA24;->atACTie_COLUMNA25;->atACTie_COLUMNA26;->atACTie_COLUMNA27;->atACTie_COLUMNA28;->atACTie_COLUMNA29;->atACTie_COLUMNA30;->atACTie_COLUMNA31;->atACTie_COLUMNA32;->atACTie_COLUMNA33;->atACTie_COLUMNA34;->abACTie_Error;->atACTie_ErrorDetalle)
		
	: ($vt_accion="EliminaElemento")
		$l_pos:=$vy_pointer1->
		AT_Delete ($l_pos;1;->atACTie_COLUMNA1;->atACTie_COLUMNA2;->atACTie_COLUMNA3;->atACTie_COLUMNA4;->atACTie_COLUMNA5;->atACTie_COLUMNA6;->atACTie_COLUMNA7;->atACTie_COLUMNA8;->atACTie_COLUMNA9;->atACTie_COLUMNA10;->atACTie_COLUMNA11;->atACTie_COLUMNA12;->atACTie_COLUMNA13;->atACTie_COLUMNA14;->atACTie_COLUMNA15;->atACTie_COLUMNA16;->atACTie_COLUMNA17;->atACTie_COLUMNA18;->atACTie_COLUMNA19;->atACTie_COLUMNA20;->atACTie_COLUMNA21;->atACTie_COLUMNA22;->atACTie_COLUMNA23;->atACTie_COLUMNA24;->atACTie_COLUMNA25;->atACTie_COLUMNA26;->atACTie_COLUMNA27;->atACTie_COLUMNA28;->atACTie_COLUMNA29;->atACTie_COLUMNA30;->atACTie_COLUMNA31;->atACTie_COLUMNA32;->atACTie_COLUMNA33;->atACTie_COLUMNA34;->abACTie_Error;->atACTie_ErrorDetalle)
		
	: ($vt_accion="DeclaraArreglosIEV")
		ARRAY TEXT:C222(atACTie_COLUMNA1;0)
		ARRAY TEXT:C222(atACTie_COLUMNA2;0)
		ARRAY TEXT:C222(atACTie_COLUMNA3;0)
		ARRAY TEXT:C222(atACTie_COLUMNA4;0)
		ARRAY TEXT:C222(atACTie_COLUMNA5;0)
		ARRAY TEXT:C222(atACTie_COLUMNA6;0)
		ARRAY TEXT:C222(atACTie_COLUMNA7;0)
		ARRAY TEXT:C222(atACTie_COLUMNA8;0)
		ARRAY TEXT:C222(atACTie_COLUMNA9;0)
		ARRAY TEXT:C222(atACTie_COLUMNA10;0)
		ARRAY TEXT:C222(atACTie_COLUMNA11;0)
		ARRAY TEXT:C222(atACTie_COLUMNA12;0)
		ARRAY TEXT:C222(atACTie_COLUMNA13;0)
		ARRAY TEXT:C222(atACTie_COLUMNA14;0)
		ARRAY TEXT:C222(atACTie_COLUMNA15;0)
		ARRAY TEXT:C222(atACTie_COLUMNA16;0)
		ARRAY TEXT:C222(atACTie_COLUMNA17;0)
		ARRAY TEXT:C222(atACTie_COLUMNA18;0)
		ARRAY TEXT:C222(atACTie_COLUMNA19;0)
		ARRAY TEXT:C222(atACTie_COLUMNA20;0)
		ARRAY TEXT:C222(atACTie_COLUMNA21;0)
		ARRAY TEXT:C222(atACTie_COLUMNA22;0)
		ARRAY TEXT:C222(atACTie_COLUMNA23;0)
		ARRAY TEXT:C222(atACTie_COLUMNA24;0)
		ARRAY TEXT:C222(atACTie_COLUMNA25;0)
		ARRAY TEXT:C222(atACTie_COLUMNA26;0)
		ARRAY TEXT:C222(atACTie_COLUMNA27;0)
		ARRAY TEXT:C222(atACTie_COLUMNA28;0)
		ARRAY TEXT:C222(atACTie_COLUMNA29;0)
		ARRAY TEXT:C222(atACTie_COLUMNA30;0)
		ARRAY TEXT:C222(atACTie_COLUMNA31;0)
		ARRAY TEXT:C222(atACTie_COLUMNA32;0)
		ARRAY TEXT:C222(atACTie_COLUMNA33;0)
		ARRAY TEXT:C222(atACTie_COLUMNA34;0)
		
		  //para validacion
		ARRAY BOOLEAN:C223(abACTie_Error;0)
		ARRAY TEXT:C222(atACTie_ErrorDetalle;0)
		
	: ($vt_accion="DeclaraArreglosIEC")
		
	: ($vt_accion="CargaArchivoConfiguracion")
		Case of 
			: ($vy_pointer1->="IEV")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tipo Documento")
				APPEND TO ARRAY:C911($vy_pointer2->;"Excepción Emisor Receptor")
				APPEND TO ARRAY:C911($vy_pointer2->;"Folio")
				APPEND TO ARRAY:C911($vy_pointer2->;"Folio Anulado")
				APPEND TO ARRAY:C911($vy_pointer2->;"Operación")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tasa Impuesto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Número Interno")
				APPEND TO ARRAY:C911($vy_pointer2->;"Indicador Serv. Periódico")
				APPEND TO ARRAY:C911($vy_pointer2->;"Indicador Venta Sin costo")
				APPEND TO ARRAY:C911($vy_pointer2->;"Fecha Documento FORMATO AAAA-MM-DD")
				APPEND TO ARRAY:C911($vy_pointer2->;"Código Sucursal")
				APPEND TO ARRAY:C911($vy_pointer2->;"RUT Cliente")
				APPEND TO ARRAY:C911($vy_pointer2->;"Razón Social")
				APPEND TO ARRAY:C911($vy_pointer2->;"Número Id Receptor Extranjero")
				APPEND TO ARRAY:C911($vy_pointer2->;"Nacionalidad Receptor Extranjero")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tipo Documento Referencia")
				APPEND TO ARRAY:C911($vy_pointer2->;"Folio Documento Referencia")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Exento")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Neto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto IVA")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA fuera de plazo")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Propio")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Terceros")
				APPEND TO ARRAY:C911($vy_pointer2->;"Ley 18211")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Retenido Total")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Retenido Parcial")
				APPEND TO ARRAY:C911($vy_pointer2->;"Crédito Empresas Constructoras")
				APPEND TO ARRAY:C911($vy_pointer2->;"Depósito Envases")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Total")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA No Retenido")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Monto No Facturable")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Monto Periodo")
				APPEND TO ARRAY:C911($vy_pointer2->;"Venta Pasajes Nacional")
				APPEND TO ARRAY:C911($vy_pointer2->;"Venta Pasajes Internacional")
				
			: ($vy_pointer1->="IEC")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tipo Documento")
				APPEND TO ARRAY:C911($vy_pointer2->;"Excepción Emisor")
				APPEND TO ARRAY:C911($vy_pointer2->;"Folio")
				APPEND TO ARRAY:C911($vy_pointer2->;"Anulado")
				APPEND TO ARRAY:C911($vy_pointer2->;"Operación")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tipo Impuesto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tasa del Impuesto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Número Interno")
				APPEND TO ARRAY:C911($vy_pointer2->;"Fecha Documento FORMATO AAAA-MM-DD")
				APPEND TO ARRAY:C911($vy_pointer2->;"Código Sucursal")
				APPEND TO ARRAY:C911($vy_pointer2->;"RUT Proveedor")
				APPEND TO ARRAY:C911($vy_pointer2->;"Razón Social")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Exento")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Neto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto IVA")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Neto Activo Fijo")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Activo Fijo")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Uso Común")
				APPEND TO ARRAY:C911($vy_pointer2->;"Impuesto Sin derecho a crédito")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Total")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA No Retenido")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tabaco Puros")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tabaco Cigarrillos")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tabaco Elaborado")
				APPEND TO ARRAY:C911($vy_pointer2->;"Impuesto Vehículo")
				APPEND TO ARRAY:C911($vy_pointer2->;"CodIVANoRec")
				APPEND TO ARRAY:C911($vy_pointer2->;"MntIVANoRec")
				APPEND TO ARRAY:C911($vy_pointer2->;"CodImp")
				APPEND TO ARRAY:C911($vy_pointer2->;"TasaImp")
				APPEND TO ARRAY:C911($vy_pointer2->;"MntImp")
				
			: ($vy_pointer1->="IEV_Resumen")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tipo Documento")
				APPEND TO ARRAY:C911($vy_pointer2->;"Cantidad Documentos")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Anulados")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Operaciones Exenta")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Exento")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Neto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total IVA")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total IVA Fuera Plazo")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total IVA Propio")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total IVA Terceros")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Ley 18211")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Op. IVA Ret Total")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Retenido Total")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tot. Op. IVA Ret. Parcial")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Retenido Parcial")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Cred. Constructora")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Deposito Envases")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Monto Total")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tot. Op. IVA No retenido")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA No Retenido")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Monto No Facturable")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Monto Periodo")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Pasajes Nacional")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Pasajes Internacional")
				
		End case 
		
	: ($vt_accion="ValidaPeriodoLibroElectronico")
		C_TEXT:C284($t_periodo)
		C_LONGINT:C283($l_idRS;$l_tipo)
		C_BOOLEAN:C305($b_muestraMsj)
		$l_idRS:=alACTcfg_Razones{atACTcfg_Razones}
		$t_periodo:=String:C10(vlACTdte_YearIE;"0000")+"-"+String:C10(vlACTdte_MesIE;"00")
		
		  // Modificado por: Saul Ponce (05/10/2017), Ticket 187901 para que no se generen libros en periodos superiores a 2017-07
		C_REAL:C285($r_periodo)
		$r_periodo:=Num:C11(String:C10(vlACTdte_YearIE;"0000")+String:C10(vlACTdte_MesIE;"00"))
		IT_MODIFIERS 
		  //If (($r_periodo<201707) | (<>Option))  // cuando presione ALT u OPTION podrá continuar igualmente para certificar
		If (($r_periodo<=201707) | (<>Option))  //
			If (l_compra=1)
				$l_tipo:=1
			Else 
				$l_tipo:=2
			End if 
			
			$b_muestraMsj:=True:C214
			If (Not:C34(Is nil pointer:C315($vy_pointer1)))
				$b_muestraMsj:=$vy_pointer1->
			End if 
			
			READ ONLY:C145([ACT_IECV:253])
			QUERY:C277([ACT_IECV:253];[ACT_IECV:253]id_razon_social:15=$l_idRS;*)
			QUERY:C277([ACT_IECV:253]; & ;[ACT_IECV:253]tipo_operacion:5=$l_tipo;*)
			QUERY:C277([ACT_IECV:253]; & ;[ACT_IECV:253]periodo:6=$t_periodo)
			
			QUERY SELECTION BY FORMULA:C207([ACT_IECV:253];[ACT_IECV:253]estado:14 ?? 3)  //dte enviado y validado
			
			If (Records in selection:C76([ACT_IECV:253])#0)
				If ($b_muestraMsj)
					CD_Dlog (0;"Ya existe un libro electrónico procesado para este período. Por favor verifique el estado del libro en el sitio www.sii.cl.")
				End if 
			End if 
			
			$vt_retorno:=String:C10(Records in selection:C76([ACT_IECV:253]))
			
		Else 
			  // Modificado por: Saul Ponce (05/10/2017), Ticket 187901 para que no se generen libros en periodos superiores a 2017-07
			CD_Dlog (0;__ ("A partir de Agosto 2017, los libros fueron reemplazados por el registro de compras y ventas que se efectúa directamente en el sitio www.sii.cl."))
		End if 
		
		
	: ($vt_accion="ValidaPeriodoLibroElectronicoCodReemplazo")
		C_TEXT:C284($t_periodo)
		C_LONGINT:C283($l_idRS;$l_tipo)
		$l_idRS:=alACTcfg_Razones{atACTcfg_Razones}
		$t_periodo:=String:C10(vlACTdte_YearIE;"0000")+"-"+String:C10(vlACTdte_MesIE;"00")
		If (l_compra=1)
			$l_tipo:=1
		Else 
			$l_tipo:=2
		End if 
		  //20151022 RCH
		$t_codigo:=vtACT_CodAut
		
		READ ONLY:C145([ACT_IECV:253])
		QUERY:C277([ACT_IECV:253];[ACT_IECV:253]id_razon_social:15=$l_idRS;*)
		QUERY:C277([ACT_IECV:253]; & ;[ACT_IECV:253]tipo_operacion:5=$l_tipo;*)
		QUERY:C277([ACT_IECV:253]; & ;[ACT_IECV:253]codigo_reemplazo_libro:11=$t_codigo;*)
		QUERY:C277([ACT_IECV:253]; & ;[ACT_IECV:253]periodo:6=$t_periodo)
		
		QUERY SELECTION BY FORMULA:C207([ACT_IECV:253];[ACT_IECV:253]estado:14 ?? 3)  //dte enviado y validado
		
		$vt_retorno:=String:C10(Records in selection:C76([ACT_IECV:253]))
		
	: ($vt_accion="ValidaPeriodoLibroElectronicoFolioNotificacion")
		C_TEXT:C284($t_periodo)
		C_LONGINT:C283($l_idRS;$l_tipo)
		$l_idRS:=alACTcfg_Razones{atACTcfg_Razones}
		$t_periodo:=String:C10(vlACTdte_YearIE;"0000")+"-"+String:C10(vlACTdte_MesIE;"00")
		If (l_compra=1)
			$l_tipo:=1
		Else 
			$l_tipo:=2
		End if 
		  //20151022 RCH
		$r_folioNotif:=vrACT_folioNotif
		
		READ ONLY:C145([ACT_IECV:253])
		QUERY:C277([ACT_IECV:253];[ACT_IECV:253]id_razon_social:15=$l_idRS;*)
		QUERY:C277([ACT_IECV:253]; & ;[ACT_IECV:253]tipo_operacion:5=$l_tipo;*)
		QUERY:C277([ACT_IECV:253]; & ;[ACT_IECV:253]folio_notificacion:10=$r_folioNotif;*)
		QUERY:C277([ACT_IECV:253]; & ;[ACT_IECV:253]periodo:6=$t_periodo)
		
		QUERY SELECTION BY FORMULA:C207([ACT_IECV:253];[ACT_IECV:253]estado:14 ?? 3)  //dte enviado y validado
		
		$vt_retorno:=String:C10(Records in selection:C76([ACT_IECV:253]))
		
		
End case 

$0:=$vt_retorno