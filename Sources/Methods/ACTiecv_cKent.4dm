//%attributes = {}
  //ACTiecv_cKent

  //metodo que maneja el codigo que se utiliza para llenar los arreglos de la IEC para modelo estandar
C_TEXT:C284(vt_rutaArchivo)

ACTdte_OpcionesGeneralesIE ("DeclaraArreglosIEV")

C_TEXT:C284($t_delimitador)
C_TIME:C306($ref)
C_TEXT:C284($t_linea)

$t_delimitador:=ACTabc_DetectDelimiter (vt_rutaArchivo)
$ref:=Open document:C264(vt_rutaArchivo;"*";Read mode:K24:5)

RECEIVE PACKET:C104($ref;$t_linea;$t_delimitador)

C_TEXT:C284($t_noInterno;$t_tipoDcto;$t_folio;$t_fecha;$t_rutProveedor;$t_razonSocial;$t_exento;$t_afecto;$t_iva;$t_total)

While ($t_linea#"")
	$t_noInterno:=Substring:C12($t_linea;16;10)
	$t_tipoDcto:=Substring:C12($t_linea;28;2)
	$t_folio:=Substring:C12($t_linea;30;10)
	$t_fecha:=Substring:C12($t_linea;40;8)
	$t_rutProveedor:=Substring:C12($t_linea;48;9)
	$t_razonSocial:=Substring:C12($t_linea;57;50)
	$t_exento:=Substring:C12($t_linea;107;13)
	$t_afecto:=Substring:C12($t_linea;120;13)
	$t_iva:=Substring:C12($t_linea;133;13)
	$t_total:=Substring:C12($t_linea;146;13)
	
	$t_noInterno:=String:C10(Num:C11($t_noInterno))
	$t_tipoDcto:=String:C10(Num:C11($t_tipoDcto))
	$t_folio:=String:C10(Num:C11($t_folio))
	$t_fecha:=Substring:C12($t_fecha;5;4)+"-"+Substring:C12($t_fecha;3;2)+"-"+Substring:C12($t_fecha;1;2)
	$t_rutProveedor:=ST_DeleteCharsLeft (Replace string:C233(SR_FormatoRUT2 ($t_rutProveedor);".";"");" ")
	$t_rutProveedor:=ST_Uppercase ($t_rutProveedor)  //20160123 RCH
	$t_razonSocial:=ST_DeleteCharsLeft ($t_razonSocial;" ")
	$t_exento:=String:C10(Num:C11($t_exento))
	$t_afecto:=String:C10(Num:C11($t_afecto))
	$t_iva:=String:C10(Num:C11($t_iva))
	$t_total:=String:C10(Num:C11($t_total))
	
	APPEND TO ARRAY:C911(atACTie_COLUMNA1;$t_tipoDcto)  //Tipo Documento
	APPEND TO ARRAY:C911(atACTie_COLUMNA3;$t_folio)  //Folio
	APPEND TO ARRAY:C911(atACTie_COLUMNA5;"1")  //Operación
	APPEND TO ARRAY:C911(atACTie_COLUMNA6;"1")  //Tipo Impuesto
	APPEND TO ARRAY:C911(atACTie_COLUMNA7;"019.00")  //Tasa del Impuesto
	APPEND TO ARRAY:C911(atACTie_COLUMNA8;$t_noInterno)  //Número Interno
	APPEND TO ARRAY:C911(atACTie_COLUMNA9;$t_fecha)  //Fecha Documento FORMATO AAAA-MM-DD
	APPEND TO ARRAY:C911(atACTie_COLUMNA11;$t_rutProveedor)  //RUT Proveedor
	APPEND TO ARRAY:C911(atACTie_COLUMNA12;$t_razonSocial)  //Razón Social
	APPEND TO ARRAY:C911(atACTie_COLUMNA13;$t_exento)  //Monto Exento
	APPEND TO ARRAY:C911(atACTie_COLUMNA14;$t_afecto)  //Monto Neto
	APPEND TO ARRAY:C911(atACTie_COLUMNA15;$t_iva)  //Monto IVA
	
	APPEND TO ARRAY:C911(atACTie_COLUMNA20;$t_total)  //Monto Total
	RECEIVE PACKET:C104($ref;$t_linea;$t_delimitador)
End while 
AT_RedimArrays (Size of array:C274(atACTie_COLUMNA1);->atACTie_COLUMNA2;->atACTie_COLUMNA3;->atACTie_COLUMNA4;->atACTie_COLUMNA5;->atACTie_COLUMNA6;->atACTie_COLUMNA7;->atACTie_COLUMNA8;->atACTie_COLUMNA9;->atACTie_COLUMNA10;->atACTie_COLUMNA11;->atACTie_COLUMNA12;->atACTie_COLUMNA13;->atACTie_COLUMNA14;->atACTie_COLUMNA15;->atACTie_COLUMNA16;->atACTie_COLUMNA17;->atACTie_COLUMNA18;->atACTie_COLUMNA19;->atACTie_COLUMNA20;->atACTie_COLUMNA21;->atACTie_COLUMNA22;->atACTie_COLUMNA23;->atACTie_COLUMNA24;->atACTie_COLUMNA25;->atACTie_COLUMNA26;->atACTie_COLUMNA27;->atACTie_COLUMNA28;->atACTie_COLUMNA29;->atACTie_COLUMNA30;->atACTie_COLUMNA31;->atACTie_COLUMNA32;->atACTie_COLUMNA33;->atACTie_COLUMNA34)

CLOSE DOCUMENT:C267($ref)
