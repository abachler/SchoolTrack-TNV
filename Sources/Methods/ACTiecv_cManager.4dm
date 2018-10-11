//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Jorge Valenzuela
  // Fecha y hora: 07/09/16, 15:52:44
  // ----------------------------------------------------
  // Método: ACTiecv_cManager
  // Descripción
  // 
  //
  // Parámetros
  //20170221 RCH Cambios según ticket 174775.
  // ----------------------------------------------------
If (r_win=1)
	USE CHARACTER SET:C205("windows-1252";0)
Else 
	USE CHARACTER SET:C205("MacRoman";0)
End if 

C_TEXT:C284($t_ruta;$delimiter;$text;$t_rut)
C_TIME:C306($ref)
C_LONGINT:C283($l_find)
C_BOOLEAN:C305($b_mostrarMsgError)
C_TEXT:C284($t_fecha)
C_LONGINT:C283($l_linea;$l_lineaError)

ARRAY TEXT:C222(aQR_Text1;0)
ARRAY LONGINT:C221(aQR_Longint1;0)


$t_ruta:=vt_rutaArchivo
ACTdte_OpcionesGeneralesIE ("DeclaraArreglosIEV")

$t_ruta:=vt_rutaArchivo

$delimiter:=ACTabc_DetectDelimiter ($t_ruta)
$ref:=Open document:C264($t_ruta;"*";Read mode:K24:5)
  //encabezado
RECEIVE PACKET:C104($ref;$text;$delimiter)
$l_linea:=$l_linea+1

  //20160907 JVP formato entregado por el esteban diacono
  //se uso como modelo de referencia el ACTiecv_cSoftland29Col
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
$l_linea:=$l_linea+1
While ($text#"")
	
	  //20170116 RCH Se verifica si viene o no primera linea de encabezados
	If (ST_GetWord ($text;1;"\t")="eselectr")
		RECEIVE PACKET:C104($ref;$text;$delimiter)
		$l_linea:=$l_linea+1
	End if 
	
	  //20170325 RCH limpio caracteres , que puedan venir en el nombre de la razon social
	$text:=ST_LimpiaTextoSeparadoXComa ($text)  //20170325 RCH
	
	C_LONGINT:C283($l_cod)
	C_TEXT:C284($t_delimitador)
	$t_delimitador:="\t"
	$l_cod:=Num:C11(ST_GetWord ($text;2;$t_delimitador))
	If ($l_cod=0)
		$t_delimitador:=","
		$l_cod:=Num:C11(ST_GetWord ($text;2;$t_delimitador))
	End if 
	$l_find:=Find in array:C230(aQR_Longint1;$l_cod)
	If ($l_find>0)
		APPEND TO ARRAY:C911(atACTie_COLUMNA1;String:C10(aQR_Longint1{$l_find}))  //Tipo Documento
		APPEND TO ARRAY:C911(atACTie_COLUMNA2;"")  //Excepción Emisor
		APPEND TO ARRAY:C911(atACTie_COLUMNA3;ST_GetWord ($text;6;$t_delimitador))  //Folio
		APPEND TO ARRAY:C911(atACTie_COLUMNA4;"")  //Anulado
		APPEND TO ARRAY:C911(atACTie_COLUMNA5;"1")  //operación
		APPEND TO ARRAY:C911(atACTie_COLUMNA6;ST_GetWord ($text;27;$t_delimitador))  //Tipo Impuesto
		
		  //20170116 RCH Si se lee 0, se cambia por 1
		If (atACTie_COLUMNA6{Size of array:C274(atACTie_COLUMNA6)}="0")
			atACTie_COLUMNA6{Size of array:C274(atACTie_COLUMNA6)}:="1"
		End if 
		
		APPEND TO ARRAY:C911(atACTie_COLUMNA7;"0"+ST_GetWord ($text;31;$t_delimitador)+".00")  //Tasa del Impuesto
		APPEND TO ARRAY:C911(atACTie_COLUMNA8;ST_GetWord ($text;7;$t_delimitador))  //Número Interno
		  //If (Is compiled mode)
		$t_fecha:=ST_GetWord ($text;5;$t_delimitador)
		APPEND TO ARRAY:C911(atACTie_COLUMNA9;Substring:C12($t_fecha;7;4)+"-"+String:C10(Num:C11(Substring:C12($t_fecha;4;2));"00")+"-"+String:C10(Num:C11(Substring:C12($t_fecha;1;2));"00"))  //Fecha Documento
		  //Else 
		  //APPEND TO ARRAY(atACTie_COLUMNA9;"2015"+"-"+"02"+"-"+"01")  //Fecha Documento
		  //End if 
		APPEND TO ARRAY:C911(atACTie_COLUMNA10;ST_GetWord ($text;11;$t_delimitador))  //Código Sucursal
		  //APPEND TO ARRAY(atACTie_COLUMNA11;Replace string(SR_FormatoRUT2 (ST_GetWord ($text;3;<>tb));".";""))  //RUT Proveedor
		$t_rut:=ST_GetWord ($text;10;$t_delimitador)
		$t_rut:=Replace string:C233($t_rut;"-";"")
		$t_rut:=Replace string:C233($t_rut;Char:C90(34);"")
		$t_rut:=SR_FormatoRUT2 ($t_rut)
		$t_rut:=ST_Uppercase (Replace string:C233($t_rut;".";""))
		APPEND TO ARRAY:C911(atACTie_COLUMNA11;$t_rut)  //20160123 RCH
		APPEND TO ARRAY:C911(atACTie_COLUMNA12;Replace string:C233(ST_GetWord ($text;9;$t_delimitador);Char:C90(34);""))  //Razón Social
		  //APPEND TO ARRAY(atACTie_COLUMNA13;ST_GetWord ($text;26;<>tb))  //Monto Exento
		  //por algun motivo no se puede importar el exento en este caso
		  //hay una validacion en el metodo ACTmnu_OpcionesGeneracionIECV ("ValidaDatos")
		  //que suma los montos exentos con los montos netos 
		APPEND TO ARRAY:C911(atACTie_COLUMNA13;String:C10(Abs:C99(Num:C11(ST_GetWord ($text;26;$t_delimitador)))))  //Monto Exento
		APPEND TO ARRAY:C911(atACTie_COLUMNA14;String:C10(Abs:C99(Num:C11(ST_GetWord ($text;25;$t_delimitador)))))  //Monto Neto
		  //APPEND TO ARRAY(atACTie_COLUMNA15;ST_GetWord ($text;21;$t_delimitador))  //Monto IVA
		APPEND TO ARRAY:C911(atACTie_COLUMNA15;"")  //Monto IVA
		APPEND TO ARRAY:C911(atACTie_COLUMNA16;"")  //Monto Neto Activo Fijo
		APPEND TO ARRAY:C911(atACTie_COLUMNA17;String:C10(Abs:C99(Num:C11(ST_GetWord ($text;22;$t_delimitador)))))  //IVA Activo Fijo
		APPEND TO ARRAY:C911(atACTie_COLUMNA18;"")  //IVA Uso Común
		  //APPEND TO ARRAY(atACTie_COLUMNA19;"")  //Impuesto Sin derecho a crédito
		APPEND TO ARRAY:C911(atACTie_COLUMNA19;String:C10(Num:C11(ST_GetWord ($text;27;$t_delimitador))+Num:C11(ST_GetWord ($text;28;$t_delimitador))))  //Impuesto Sin derecho a crédito//20170417 RCH
		APPEND TO ARRAY:C911(atACTie_COLUMNA20;String:C10(Abs:C99(Num:C11(ST_GetWord ($text;29;$t_delimitador)))))  //Monto Total
		APPEND TO ARRAY:C911(atACTie_COLUMNA21;"")  //IVA No Retenido
		APPEND TO ARRAY:C911(atACTie_COLUMNA22;"")  //Tabaco Puros
		APPEND TO ARRAY:C911(atACTie_COLUMNA23;"")  //Tabaco Cigarrillos
		APPEND TO ARRAY:C911(atACTie_COLUMNA24;"")  //Tabaco Elaborado
		APPEND TO ARRAY:C911(atACTie_COLUMNA25;"")  //Impuesto Vehículo
		
		  //si hay iva se agerga esta info
		  //If (Num(atACTie_COLUMNA14{Size of array(atACTie_COLUMNA14)})>0)
		  //APPEND TO ARRAY(atACTie_COLUMNA26;"1")  //Cod iva no recuperable
		  //APPEND TO ARRAY(atACTie_COLUMNA27;ST_GetWord ($text;16;<>tb))  //monto iva no recuperable
		  //Else 
		APPEND TO ARRAY:C911(atACTie_COLUMNA26;"1")  //Cod iva no recuperable
		APPEND TO ARRAY:C911(atACTie_COLUMNA27;String:C10(Abs:C99(Num:C11(ST_GetWord ($text;21;$t_delimitador)))))  //monto iva no recuperable
		  //End if 
		RECEIVE PACKET:C104($ref;$text;$delimiter)
		$l_linea:=$l_linea+1
		
	Else 
		  //muestro error y salgo
		If ($l_lineaError=0)
			$l_lineaError:=$l_linea
		End if 
		$b_mostrarMsgError:=True:C214
		While ($text#"")
			RECEIVE PACKET:C104($ref;$text;$delimiter)
			$l_linea:=$l_linea+1
		End while 
		
	End if 
End while 

If ($b_mostrarMsgError)
	CD_Dlog (0;"Código de tipo de documento no clasificado en la línea "+String:C10($l_lineaError)+" del archivo.\r\rRevise que los tipos de documentos correspondan a lo indicado en el formato de las compras para los libros electrónicos.\r\rEl libro no fue procesado correctamente.")
End if 
CLOSE DOCUMENT:C267($ref)
AT_RedimArrays (Size of array:C274(atACTie_COLUMNA1);->atACTie_COLUMNA26;->atACTie_COLUMNA27;->atACTie_COLUMNA28;->atACTie_COLUMNA29;->atACTie_COLUMNA30;->atACTie_COLUMNA31;->atACTie_COLUMNA32;->atACTie_COLUMNA33;->atACTie_COLUMNA34)

USE CHARACTER SET:C205(*;1)