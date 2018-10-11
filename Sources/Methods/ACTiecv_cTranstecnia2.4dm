//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Saúl Ponce
  // Fecha y hora: 11-11-16, 12:24:17
  // ----------------------------------------------------
  // Método: ACTiecv_cTranstecnia2
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------
C_BOOLEAN:C305($b_mostrarMsgError)
C_DATE:C307($vd_fecha1)
C_LONGINT:C283($l_find;$z)
C_TIME:C306($ref)
C_TEXT:C284($delimiter;$t_fecha;$t_ruta;$text;$vt_fecha;$vt_monto;$vt_monto2;$vt_rutOrg)

C_TEXT:C284(vQR_text1)


ARRAY TEXT:C222(aQR_Text1;0)
ARRAY TEXT:C222(aQR_text2;0)
ARRAY LONGINT:C221(aQR_Longint1;0)


If (r_win=1)
	USE CHARACTER SET:C205("windows-1252";0)
Else 
	USE CHARACTER SET:C205("MacRoman";0)
End if 


$t_ruta:=vt_rutaArchivo
ACTdte_OpcionesGeneralesIE ("DeclaraArreglosIEV")

$t_ruta:=vt_rutaArchivo
$ref:=Open document:C264($t_ruta;"*";Read mode:K24:5)

If (ok=1)
	
	$delimiter:=ACTabc_DetectDelimiter ($t_ruta)
	
	APPEND TO ARRAY:C911(aQR_Text1;"Factura")
	APPEND TO ARRAY:C911(aQR_Text1;"Factura de ventas y servicios no afectos o exentos de IVA")
	APPEND TO ARRAY:C911(aQR_Text1;"Factura Electrónica")
	APPEND TO ARRAY:C911(aQR_Text1;"Factura no Afecta o Exenta Electrónica")
	APPEND TO ARRAY:C911(aQR_Text1;"Liquidación Factura")
	APPEND TO ARRAY:C911(aQR_Text1;"Liquidación Factura Electrónica")
	APPEND TO ARRAY:C911(aQR_Text1;"Factura de Compra")
	APPEND TO ARRAY:C911(aQR_Text1;"Factura de Compra electrónica")
	APPEND TO ARRAY:C911(aQR_Text1;"Nota de Débito")
	APPEND TO ARRAY:C911(aQR_Text1;"Nota de débito electrónica")
	APPEND TO ARRAY:C911(aQR_Text1;"Nota de Crédito")
	APPEND TO ARRAY:C911(aQR_Text1;"Nota de crédito electrónica")
	APPEND TO ARRAY:C911(aQR_Text1;"SRF Solicitud de Registro de Factura")
	APPEND TO ARRAY:C911(aQR_Text1;"Factura de ventas a empresas del territorio preferencial ( Res. Ex. N° 1057, del 25.04.85)")
	APPEND TO ARRAY:C911(aQR_Text1;"Declaración de Ingreso (DIN)")
	APPEND TO ARRAY:C911(aQR_Text1;"Declaración de Ingreso a Zona Franca Primaria.")
	APPEND TO ARRAY:C911(aQR_Text1;"Factura de Venta bienes y servicios no afectos o exentos de IVA")
	
	APPEND TO ARRAY:C911(aQR_Longint1;30)
	APPEND TO ARRAY:C911(aQR_Longint1;32)
	APPEND TO ARRAY:C911(aQR_Longint1;33)
	APPEND TO ARRAY:C911(aQR_Longint1;34)
	APPEND TO ARRAY:C911(aQR_Longint1;40)
	APPEND TO ARRAY:C911(aQR_Longint1;43)
	APPEND TO ARRAY:C911(aQR_Longint1;45)
	APPEND TO ARRAY:C911(aQR_Longint1;46)
	APPEND TO ARRAY:C911(aQR_Longint1;55)
	APPEND TO ARRAY:C911(aQR_Longint1;56)
	APPEND TO ARRAY:C911(aQR_Longint1;60)
	APPEND TO ARRAY:C911(aQR_Longint1;61)
	APPEND TO ARRAY:C911(aQR_Longint1;108)
	APPEND TO ARRAY:C911(aQR_Longint1;901)
	APPEND TO ARRAY:C911(aQR_Longint1;914)
	APPEND TO ARRAY:C911(aQR_Longint1;911)
	
	
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	
	While ($text#"")
		
		$vt_monto:=""
		vQR_text1:=""
		vQR_text1:=ST_GetWord ($text;28;"\t")
		AT_Text2Array (->aQR_text2;vQR_text1;" ")
		vQR_long100:=Find in array:C230(aQR_text2;"Código")
		$l_find:=Find in array:C230(aQR_Longint1;Num:C11(aQR_text2{vQR_long100+1}))
		
		If ($l_find>0)
			
			ACTdte_OpcionesGeneralesIE ("InsertaElemento")
			atACTie_COLUMNA1{Size of array:C274(atACTie_COLUMNA1)}:=aQR_text2{vQR_long100+1}  // tipo de doc
			atACTie_COLUMNA2{Size of array:C274(atACTie_COLUMNA2)}:=""  // exepcion del emisor
			atACTie_COLUMNA3{Size of array:C274(atACTie_COLUMNA3)}:=ST_GetWord ($text;30;"\t")  // folio
			atACTie_COLUMNA4{Size of array:C274(atACTie_COLUMNA4)}:=""  // anulado
			atACTie_COLUMNA5{Size of array:C274(atACTie_COLUMNA5)}:=""  // operacion
			atACTie_COLUMNA6{Size of array:C274(atACTie_COLUMNA6)}:="1"  // tipo de impuesto
			atACTie_COLUMNA7{Size of array:C274(atACTie_COLUMNA7)}:=ST_RigthChars ("000"+String:C10(Int:C8(<>vrACT_TasaIVA));3)+","+ST_LeftChars (String:C10(Dec:C9(<>vrACT_TasaIVA)*100)+"00";2)  // completo lo que en la grilla es el tasa impuesto
			atACTie_COLUMNA8{Size of array:C274(atACTie_COLUMNA8)}:=""  // numero interno
			$vt_fecha:=Replace string:C233(ST_GetWord ($text;31;"\t");" ";"")  // fecha del documento
			If ((Length:C16($vt_fecha)=8) | (Length:C16($vt_fecha)=10))
				$vd_fecha1:=Date:C102($vt_fecha)
				$vt_fecha:=""
				$vt_fecha:=String:C10(Year of:C25($vd_fecha1);"0000")+"-"
				$vt_fecha:=$vt_fecha+String:C10(Month of:C24($vd_fecha1);"00")+"-"
				$vt_fecha:=$vt_fecha+String:C10(Day of:C23($vd_fecha1);"00")
				atACTie_COLUMNA9{Size of array:C274(atACTie_COLUMNA9)}:=$vt_fecha
			Else 
				atACTie_COLUMNA9{Size of array:C274(atACTie_COLUMNA9)}:=""
			End if 
			atACTie_COLUMNA10{Size of array:C274(atACTie_COLUMNA10)}:=""  // codigo sucursal
			$vt_rutOrg:=ST_GetWord ($text;33;"\t")
			$vt_rutOrg:=Replace string:C233($vt_rutOrg;"-";"")
			$vt_rutOrg:=Replace string:C233($vt_rutOrg;".";"")
			$vt_rutOrg:=ST_GetCleanString ($vt_rutOrg)
			$vt_rutOrg:=ST_Uppercase ($vt_rutOrg)
			If (CTRY_CL_VerifRUT ($vt_rutOrg;False:C215)#"")
				atACTie_COLUMNA11{Size of array:C274(atACTie_COLUMNA11)}:=Substring:C12($vt_rutOrg;1;Length:C16($vt_rutOrg)-1)+"-"+Substring:C12($vt_rutOrg;Length:C16($vt_rutOrg);1)  // completo lo que en la grilla es el rut
			Else 
				atACTie_COLUMNA11{Size of array:C274(atACTie_COLUMNA11)}:=""  // rut
			End if 
			
			atACTie_COLUMNA12{Size of array:C274(atACTie_COLUMNA12)}:=ST_GetWord ($text;32;"\t")  // razon social
			
			$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;34;"\t"))))  // columna 34 AH del archivo (exento)
			$vt_monto:=Replace string:C233($vt_monto;".";"")
			$vt_monto:=Replace string:C233($vt_monto;",";"")
			atACTie_COLUMNA13{Size of array:C274(atACTie_COLUMNA13)}:=$vt_monto  // monto exento
			
			$vt_monto2:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;35;"\t"))))  // columna 35 AH del archivo (afecto)
			$vt_monto2:=Replace string:C233($vt_monto2;".";"")
			$vt_monto2:=Replace string:C233($vt_monto2;",";"")
			atACTie_COLUMNA14{Size of array:C274(atACTie_COLUMNA14)}:=$vt_monto2  // monto neto
			
			$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;37;"\t"))))  // columna 37 AK del archivo (iva(SD))
			$vt_monto:=Replace string:C233($vt_monto;".";"")
			$vt_monto:=Replace string:C233($vt_monto;",";"")
			atACTie_COLUMNA15{Size of array:C274(atACTie_COLUMNA15)}:=$vt_monto  // monto iva
			
			atACTie_COLUMNA16{Size of array:C274(atACTie_COLUMNA16)}:="0"  // monto neto activo fijo
			atACTie_COLUMNA17{Size of array:C274(atACTie_COLUMNA17)}:="0"  // iva activo fijo
			atACTie_COLUMNA18{Size of array:C274(atACTie_COLUMNA18)}:="0"  // iva uso comun
			atACTie_COLUMNA19{Size of array:C274(atACTie_COLUMNA19)}:="0"  // impuesto sin derecho a credito
			
			$vt_monto:=String:C10(Abs:C99(Num:C11(ST_GetWord ($text;39;"\t"))))  // columna 39 AM del archivo (total)
			$vt_monto:=Replace string:C233($vt_monto;".";"")
			$vt_monto:=Replace string:C233($vt_monto;",";"")
			atACTie_COLUMNA20{Size of array:C274(atACTie_COLUMNA20)}:=$vt_monto  //  monto total
			
			RECEIVE PACKET:C104($ref;$text;$delimiter)
			
		Else 
			$b_mostrarMsgError:=True:C214
			While ($text#"")
				RECEIVE PACKET:C104($ref;$text;$delimiter)
			End while 
		End if 
		
	End while 
	
	
	If ($b_mostrarMsgError)
		CD_Dlog (0;"Código no clasificado. Revise que los tipos de documentos correspondan a lo indicado en el formato de las compras para los libros electrónicos.")
	End if 
	
	CLOSE DOCUMENT:C267($ref)
	AT_RedimArrays (Size of array:C274(atACTie_COLUMNA1);->atACTie_COLUMNA26;->atACTie_COLUMNA27;->atACTie_COLUMNA28;->atACTie_COLUMNA29;->atACTie_COLUMNA30;->atACTie_COLUMNA31;->atACTie_COLUMNA32;->atACTie_COLUMNA33;->atACTie_COLUMNA34)
	
	USE CHARACTER SET:C205(*;1)
	
End if 

