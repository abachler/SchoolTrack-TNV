//%attributes = {}
USE CHARACTER SET:C205("latin1";1)

C_TEXT:C284($t_ruta;$delimiter;$text)
C_TIME:C306($ref)
C_LONGINT:C283($l_find)
C_BOOLEAN:C305($b_mostrarMsgError)
C_TEXT:C284($t_fecha)

ARRAY TEXT:C222(aQR_Text1;0)
ARRAY LONGINT:C221(aQR_Longint1;0)


$t_ruta:=vt_rutaArchivo
ACTdte_OpcionesGeneralesIE ("DeclaraArreglosIEV")

$t_ruta:=vt_rutaArchivo

$delimiter:=ACTabc_DetectDelimiter ($t_ruta)
$ref:=Open document:C264($t_ruta;"*";Read mode:K24:5)
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)


  //20150910 RCH Segundo formato que nos enviaron desde el San José de Chicureo. Está en el ticket 160431
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

APPEND TO ARRAY:C911(aQR_Longint1;32)

RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
While ($text#"")
	
	$l_find:=Find in array:C230(aQR_Text1;ST_GetWord ($text;1;"\t"))
	If ($l_find>0)
		APPEND TO ARRAY:C911(atACTie_COLUMNA1;String:C10(aQR_Longint1{$l_find}))  //Tipo Documento
		APPEND TO ARRAY:C911(atACTie_COLUMNA2;"")  //Excepción Emisor
		APPEND TO ARRAY:C911(atACTie_COLUMNA3;ST_GetWord ($text;2;"\t"))  //Folio
		APPEND TO ARRAY:C911(atACTie_COLUMNA4;"")  //Anulado
		APPEND TO ARRAY:C911(atACTie_COLUMNA5;"1")  //operación
		APPEND TO ARRAY:C911(atACTie_COLUMNA6;ST_GetWord ($text;7;"\t"))  //Tipo Impuesto
		APPEND TO ARRAY:C911(atACTie_COLUMNA7;"0"+ST_GetWord ($text;8;"\t")+".00")  //Tasa del Impuesto
		APPEND TO ARRAY:C911(atACTie_COLUMNA8;ST_GetWord ($text;5;"\t"))  //Número Interno
		  //If (Is compiled mode)
		$t_fecha:=ST_GetWord ($text;6;"\t")
		APPEND TO ARRAY:C911(atACTie_COLUMNA9;Substring:C12($t_fecha;7;4)+"-"+String:C10(Num:C11(Substring:C12($t_fecha;4;2));"00")+"-"+String:C10(Num:C11(Substring:C12($t_fecha;1;2));"00"))  //Fecha Documento
		  //Else 
		  //APPEND TO ARRAY(atACTie_COLUMNA9;"2015"+"-"+"02"+"-"+"01")  //Fecha Documento
		  //End if 
		APPEND TO ARRAY:C911(atACTie_COLUMNA10;"")  //Código Sucursal
		  //APPEND TO ARRAY(atACTie_COLUMNA11;Replace string(SR_FormatoRUT2 (ST_GetWord ($text;3;<>tb));".";""))  //RUT Proveedor
		APPEND TO ARRAY:C911(atACTie_COLUMNA11;ST_Uppercase (Replace string:C233(SR_FormatoRUT2 (ST_GetWord ($text;3;"\t"));".";"")))  //20160123 RCH
		APPEND TO ARRAY:C911(atACTie_COLUMNA12;ST_GetWord ($text;4;"\t"))  //Razón Social
		APPEND TO ARRAY:C911(atACTie_COLUMNA13;ST_GetWord ($text;10;"\t"))  //Monto Exento
		APPEND TO ARRAY:C911(atACTie_COLUMNA14;ST_GetWord ($text;9;"\t"))  //Monto Neto
		APPEND TO ARRAY:C911(atACTie_COLUMNA15;"0")  //Monto IVA
		APPEND TO ARRAY:C911(atACTie_COLUMNA16;"")  //Monto Neto Activo Fijo
		APPEND TO ARRAY:C911(atACTie_COLUMNA17;ST_GetWord ($text;12;"\t"))  //IVA Activo Fijo
		APPEND TO ARRAY:C911(atACTie_COLUMNA18;"")  //IVA Uso Común
		APPEND TO ARRAY:C911(atACTie_COLUMNA19;"")  //Impuesto Sin derecho a crédito
		APPEND TO ARRAY:C911(atACTie_COLUMNA20;ST_GetWord ($text;25;"\t"))  //Monto Total
		APPEND TO ARRAY:C911(atACTie_COLUMNA21;"")  //IVA No Retenido
		APPEND TO ARRAY:C911(atACTie_COLUMNA22;"")  //Tabaco Puros
		APPEND TO ARRAY:C911(atACTie_COLUMNA23;"")  //Tabaco Cigarrillos
		APPEND TO ARRAY:C911(atACTie_COLUMNA24;"")  //Tabaco Elaborado
		APPEND TO ARRAY:C911(atACTie_COLUMNA25;"")  //Impuesto Vehículo
		
		  //si hay iva se agerga esta info
		If (Num:C11(atACTie_COLUMNA14{Size of array:C274(atACTie_COLUMNA14)})>0)
			APPEND TO ARRAY:C911(atACTie_COLUMNA26;"1")  //Cod iva no recuperable
			  //APPEND TO ARRAY(atACTie_COLUMNA27;ST_GetWord ($text;16;<>tb))  //monto iva no recuperable
			APPEND TO ARRAY:C911(atACTie_COLUMNA27;ST_GetWord ($text;15;"\t"))  //20170120 RCH El colegio pidio cambiar esto porque esta en la columna 15...
		Else 
			APPEND TO ARRAY:C911(atACTie_COLUMNA26;"")  //Cod iva no recuperable
			APPEND TO ARRAY:C911(atACTie_COLUMNA27;"")  //monto iva no recuperable
		End if 
		RECEIVE PACKET:C104($ref;$text;$delimiter)
		
	Else 
		  //muestro error y salgo
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