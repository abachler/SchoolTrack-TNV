//%attributes = {}
  //ACTiecv_cTranstecnia
  //metodo que maneja el codigo que se utiliza para llenar los arreglos de la IEC para Transtecnia

C_BOOLEAN:C305($b_esActivoFijo;$b_esTotal)
C_BOOLEAN:C305($b_esAfecta100)
C_LONGINT:C283($l_inicio;$l_largo;$l_posicion;$l_posicionParentesis;$vl_sumaAñoFecha)
C_TIME:C306($ref)
C_REAL:C285($r_total;$r_totalAfecto;$r_totalAfectoT;$r_totalExento;$r_totalExentoT;$r_totalIVACD;$r_totalIVACDT;$r_totalIVASD;$r_totalIVASDT;$r_totalOtrosIMP)
C_REAL:C285($r_totalOtrosIMPT;$r_totalT)
C_TEXT:C284($t_activoFijo;$t_año;$t_columna1;$t_dia;$t_mes;$t_tipoDocumento;$t_tipoDocumentoSII;$t_total;$text;$vt_delimiter)
C_TEXT:C284($vt_fecha;$vt_formatoFechasDocs;$vt_monto;$vt_referenciaLineaDetalle;$vt_referenciaTotal;$vt_rutOrg)
C_TEXT:C284($t_afecta100)
C_LONGINT:C283($l_primeraColConDatos)

C_TEXT:C284(vtACT_errorGeneral)

  //INICIO - lectura de libro de compras
ACTdte_OpcionesGeneralesIE ("DeclaraArreglosIEV")

$vt_referenciaLineaDetalle:=" - Código "
$vt_referenciaTotal:="TOTAL"
$vl_sumaAñoFecha:=2000
$vt_formatoFechasDocs:="DD-MM-AA"
$t_activoFijo:="A.FIJO"
$t_total:="TOTAL"
vtACT_errorGeneral:=""
$l_primeraColConDatos:=2
$t_afecta100:="100%"

$ref:=Open document:C264(vt_rutaArchivo;"TEXT";Read mode:K24:5)
If (ok=1)
	$vt_delimiter:=ACTabc_DetectDelimiter (document)
	$text:=""
	RECEIVE PACKET:C104($ref;$text;$vt_delimiter)
	
	While ($text#"")
		$t_columna1:=ST_GetWord ($text;1;"\t")
		$l_posicion:=Position:C15($vt_referenciaLineaDetalle;$t_columna1)
		If ($l_posicion#0)
			
			$r_totalExento:=0
			$r_totalAfecto:=0
			$r_totalIVACD:=0
			$r_totalIVASD:=0
			$r_totalOtrosIMP:=0
			$r_totalOtrosIMPT:=0
			$r_total:=0
			
			$l_posicionParentesis:=Position:C15("(";$text)
			$l_inicio:=$l_posicion+Length:C16($vt_referenciaLineaDetalle)
			$l_largo:=$l_posicionParentesis-$l_inicio
			
			$t_tipoDocumento:=Substring:C12($text;1;$l_posicion)
			$t_tipoDocumentoSII:=Substring:C12($text;$l_inicio;$l_largo)
			$t_tipoDocumentoSII:=String:C10(Num:C11($t_tipoDocumentoSII))
			$b_esActivoFijo:=(Position:C15($t_activoFijo;$t_tipoDocumento)#0)
			$b_esAfecta100:=(Position:C15($t_afecta100;$t_tipoDocumento)#0)
			If ($b_esAfecta100)
				$b_esActivoFijo:=False:C215
			End if 
			
			RECEIVE PACKET:C104($ref;$text;$vt_delimiter)
			While ($text#"")
				$t_columna1:=ST_GetWord ($text;1;"\t")
				$b_esTotal:=(Position:C15($t_total;$t_columna1)#0)
				If (Not:C34($b_esTotal))
					ACTdte_OpcionesGeneralesIE ("InsertaElemento")
					atACTie_COLUMNA1{Size of array:C274(atACTie_COLUMNA1)}:=$t_tipoDocumentoSII
					atACTie_COLUMNA3{Size of array:C274(atACTie_COLUMNA3)}:=ST_GetWord ($text;$l_primeraColConDatos;"\t")
					atACTie_COLUMNA5{Size of array:C274(atACTie_COLUMNA5)}:="1"  //
					atACTie_COLUMNA6{Size of array:C274(atACTie_COLUMNA6)}:="1"  // tipo de impuesto
					atACTie_COLUMNA7{Size of array:C274(atACTie_COLUMNA7)}:=ST_RigthChars ("000"+String:C10(Int:C8(<>vrACT_TasaIVA));3)+","+ST_LeftChars (String:C10(Dec:C9(<>vrACT_TasaIVA)*100)+"00";2)  // tasa impuesto
					
					atACTie_COLUMNA8{Size of array:C274(atACTie_COLUMNA8)}:=""  //comprobante contable
					$vt_fecha:=Replace string:C233(ST_GetWord ($text;$l_primeraColConDatos+2;"\t");" ";"")
					If ((Length:C16($vt_fecha)=8) | (Length:C16($vt_fecha)=10))
						Case of 
							: ($vt_formatoFechasDocs="DD-MM-AA")
								$t_dia:=Substring:C12($vt_fecha;1;2)
								$t_mes:=Substring:C12($vt_fecha;4;2)
								$t_año:=String:C10(Num:C11(Substring:C12($vt_fecha;7;2))+$vl_sumaAñoFecha)
							: ($vt_formatoFechasDocs="DD-MM-AAAA")
								$t_dia:=Substring:C12($vt_fecha;1;2)
								$t_mes:=Substring:C12($vt_fecha;4;2)
								$t_año:=Substring:C12($vt_fecha;7;4)
							: ($vt_formatoFechasDocs="AA-MM-DD")
								$t_dia:=Substring:C12($vt_fecha;7;2)
								$t_mes:=Substring:C12($vt_fecha;4;2)
								$t_año:=String:C10(Num:C11(Substring:C12($vt_fecha;1;2))+$vl_sumaAñoFecha)
							: ($vt_formatoFechasDocs="AAAA-MM-DD")
								$t_dia:=Substring:C12($vt_fecha;9;2)
								$t_mes:=Substring:C12($vt_fecha;6;2)
								$t_año:=Substring:C12($vt_fecha;1;4)
						End case 
						atACTie_COLUMNA9{Size of array:C274(atACTie_COLUMNA9)}:=$t_año+"-"+$t_mes+"-"+$t_dia
					Else 
						atACTie_COLUMNA9{Size of array:C274(atACTie_COLUMNA9)}:=""
					End if 
					atACTie_COLUMNA12{Size of array:C274(atACTie_COLUMNA12)}:=ST_GetWord ($text;$l_primeraColConDatos+3;"\t")
					$vt_rutOrg:=ST_GetWord ($text;$l_primeraColConDatos+4;"\t")
					$vt_rutOrg:=Replace string:C233($vt_rutOrg;"-";"")
					$vt_rutOrg:=Replace string:C233($vt_rutOrg;".";"")
					$vt_rutOrg:=ST_GetCleanString ($vt_rutOrg)
					$vt_rutOrg:=ST_Uppercase ($vt_rutOrg)  //20151231 RCH
					If (CTRY_CL_VerifRUT ($vt_rutOrg;False:C215)#"")
						atACTie_COLUMNA11{Size of array:C274(atACTie_COLUMNA11)}:=Substring:C12($vt_rutOrg;1;Length:C16($vt_rutOrg)-1)+"-"+Substring:C12($vt_rutOrg;Length:C16($vt_rutOrg);1)
					Else 
						atACTie_COLUMNA11{Size of array:C274(atACTie_COLUMNA11)}:=""
					End if 
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+5;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					atACTie_COLUMNA13{Size of array:C274(atACTie_COLUMNA13)}:=$vt_monto
					$r_totalExento:=$r_totalExento+Num:C11($vt_monto)
					
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+6;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					atACTie_COLUMNA14{Size of array:C274(atACTie_COLUMNA14)}:=$vt_monto
					If ($b_esActivoFijo)
						atACTie_COLUMNA16{Size of array:C274(atACTie_COLUMNA16)}:=$vt_monto
					End if 
					$r_totalAfecto:=$r_totalAfecto+Num:C11($vt_monto)
					
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+7;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					  //atACTie_COLUMNA15{Size of array(atACTie_COLUMNA15)}:=$vt_monto  // solo se deja como iva uso comun
					  //20140527 RCH si es afecta 100% se deja en IVA
					If ($b_esAfecta100)
						atACTie_COLUMNA15{Size of array:C274(atACTie_COLUMNA15)}:=$vt_monto
					End if 
					
					If ($b_esActivoFijo)
						atACTie_COLUMNA17{Size of array:C274(atACTie_COLUMNA17)}:=$vt_monto
					End if 
					$r_totalIVACD:=$r_totalIVACD+Num:C11($vt_monto)
					
					  //prueba IVA Uso comun
					If (Not:C34($b_esAfecta100))
						atACTie_COLUMNA18{Size of array:C274(atACTie_COLUMNA18)}:=$vt_monto
					Else 
						atACTie_COLUMNA18{Size of array:C274(atACTie_COLUMNA18)}:="0"
					End if 
					
					
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+8;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					atACTie_COLUMNA19{Size of array:C274(atACTie_COLUMNA19)}:=$vt_monto
					$r_totalIVASD:=$r_totalIVASD+Num:C11($vt_monto)
					
					  //$vt_monto:=String(Abs(Num(ST_GetWord ($text;12;<>tb))))
					  //$vt_monto:=Replace string($vt_monto;".";"")
					  //$vt_monto:=Replace string($vt_monto;",";"")
					  //atACTie_COLUMNA18{Size of array(atACTie_COLUMNA18)}:=$vt_monto
					  //$r_totalOtrosIMP:=$r_totalOtrosIMP+Num($vt_monto)
					
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+10;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					atACTie_COLUMNA20{Size of array:C274(atACTie_COLUMNA20)}:=$vt_monto
					RECEIVE PACKET:C104($ref;$text;$vt_delimiter)
					$r_total:=$r_total+Num:C11($vt_monto)
					
				Else 
					  //hacer validacion de montos
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+5;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					$r_totalExentoT:=Num:C11($vt_monto)
					
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+6;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					$r_totalAfectoT:=Num:C11($vt_monto)
					
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+7;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					$r_totalIVACDT:=Num:C11($vt_monto)
					
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+8;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					$r_totalIVASDT:=Num:C11($vt_monto)
					
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+9;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					$r_totalOtrosIMPT:=Num:C11($vt_monto)
					
					$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;$l_primeraColConDatos+10;"\t"))))
					$vt_monto:=Replace string:C233($vt_monto;".";"")
					$vt_monto:=Replace string:C233($vt_monto;",";"")
					$r_totalT:=Num:C11($vt_monto)
					
					If ($r_totalExento#$r_totalExentoT)
						vtACT_errorGeneral:=vtACT_errorGeneral+"El total exento no es igual al detalle importado para el tipo de documento: "+$t_columna1+"."+"\r\n"
						vtACT_errorGeneral:=vtACT_errorGeneral+"Monto en total 1: "+String:C10($r_totalExentoT)+". Monto en detalle: "+String:C10($r_totalExento)+"."+"\r\n"+"\r\n"
					End if 
					
					If ($r_totalAfecto#$r_totalAfectoT)
						vtACT_errorGeneral:=vtACT_errorGeneral+"El total afecto no es igual al detalle importado para el tipo de documento: "+$t_columna1+"."+"\r\n"
						vtACT_errorGeneral:=vtACT_errorGeneral+"Monto en total 2: "+String:C10($r_totalAfectoT)+". Monto en detalle: "+String:C10($r_totalAfecto)+"."+"\r\n"+"\r\n"
					End if 
					
					If ($r_totalIVACD#$r_totalIVACDT)
						vtACT_errorGeneral:=vtACT_errorGeneral+"El total IVA CD no es igual al detalle importado para el tipo de documento: "+$t_columna1+"."+"\r\n"
						vtACT_errorGeneral:=vtACT_errorGeneral+"Monto en total 3: "+String:C10($r_totalIVACDT)+". Monto en detalle: "+String:C10($r_totalIVACD)+"."+"\r\n"+"\r\n"
					End if 
					
					If ($r_totalIVASD#$r_totalIVASDT)
						vtACT_errorGeneral:=vtACT_errorGeneral+"El total IVA SD no es igual al detalle importado para el tipo de documento: "+$t_columna1+"."+"\r\n"
						vtACT_errorGeneral:=vtACT_errorGeneral+"Monto en total 4: "+String:C10($r_totalIVASDT)+". Monto en detalle: "+String:C10($r_totalIVASD)+"."+"\r\n"+"\r\n"
					End if 
					
					If ($r_totalOtrosIMP#$r_totalOtrosIMPT)
						vtACT_errorGeneral:=vtACT_errorGeneral+"El total Otros IMP no es igual al detalle importado para el tipo de documento: "+$t_columna1+"."+"\r\n"
						vtACT_errorGeneral:=vtACT_errorGeneral+"Monto en total 5: "+String:C10($r_totalOtrosIMPT)+". Monto en detalle: "+String:C10($r_totalOtrosIMP)+"."+"\r\n"+"\r\n"
					End if 
					
					If ($r_total#$r_totalT)
						vtACT_errorGeneral:=vtACT_errorGeneral+"El total no es igual al detalle importado para el tipo de documento: "+$t_columna1+"."+"\r\n"
						vtACT_errorGeneral:=vtACT_errorGeneral+"Monto en total 6: "+String:C10($r_totalT)+". Monto en detalle: "+String:C10($r_total)+"."+"\r\n"+"\r\n"
					End if 
					
					$text:=""
				End if 
				
			End while 
		End if 
		RECEIVE PACKET:C104($ref;$text;$vt_delimiter)
	End while 
End if 
CLOSE DOCUMENT:C267($ref)