//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Alexis Bustamante
  // Fecha y hora: 29-07-17, 09:45:40
  // ----------------------------------------------------
  // Método: ACTiecv_cNubox
  // Descripción: ACTiecv_cNubox()
  //
  // 
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($t_ruta;$delimiter;$text)
C_TIME:C306($ref)
C_LONGINT:C283($l_find;$z)
C_BOOLEAN:C305($b_mostrarMsgError)
C_TEXT:C284($t_fecha)

ARRAY TEXT:C222(aQR_Text1;0)
ARRAY LONGINT:C221(aQR_Longint1;0)


If (r_win=1)
	USE CHARACTER SET:C205("windows-1252";0)
Else 
	USE CHARACTER SET:C205("MacRoman";0)
End if 


$t_ruta:=vt_rutaArchivo
ACTdte_OpcionesGeneralesIE ("DeclaraArreglosIEV")

$t_ruta:=vt_rutaArchivo
$delimiter:=ACTabc_DetectDelimiter ($t_ruta)
$ref:=Open document:C264($t_ruta;"*";Read mode:K24:5)
RECEIVE PACKET:C104($ref;$text;$delimiter)

C_OBJECT:C1216($ob_codigos)


  //APPEND TO ARRAY(aQR_Text1;"Factura")
APPEND TO ARRAY:C911(aQR_Text1;"FAC")
APPEND TO ARRAY:C911(aQR_Text1;"Factura de ventas y servicios no afectos o exentos de IVA")
  //APPEND TO ARRAY(aQR_Text1;"Factura Electrónica")
APPEND TO ARRAY:C911(aQR_Text1;"FAC-EL")
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
APPEND TO ARRAY:C911(aQR_Longint1;33)  //factura Electronica
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


$ob_codigos:=OB_Create 
OB_SET ($ob_codigos;->aQR_text1;"Descripcion")
OB_SET ($ob_codigos;->aQR_Longint1;"Codigos")
PREF_fGetObject (0;"ACTiecv_CodNubox";$ob_codigos)
  //Else 
  //el objeto  se crea  en la preferencua cuando es  la primera vez que ejecutan el modelo
  //depsues solo se lee los ob
  //si se desea cambiar descripcion o codigo no será necesario version ya que se peude rwealizar a travez de un script.
OB_GET ($ob_codigos;->aQR_text1;"Descripcion")
OB_GET ($ob_codigos;->aQR_Longint1;"Codigos")
  //End if 


  //encabezados
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)

While ($text#"")
	
	  //$l_find:=Find in array(aQR_Longint1;Num(ST_GetWord (ST_GetWord ($text;3;"\t");1;" ")))
	  //Tipo de documento.
	$l_find:=Find in array:C230(aQR_text1;ST_GetWord ($text;3;"\t"))
	If ($l_find>0)
		
		APPEND TO ARRAY:C911(atACTie_COLUMNA1;String:C10(aQR_Longint1{$l_find}))  //Tipo Documento
		
		APPEND TO ARRAY:C911(atACTie_COLUMNA2;"")  //Excepción Emisor   
		APPEND TO ARRAY:C911(atACTie_COLUMNA3;ST_GetWord ($text;4;"\t"))  //Folio
		APPEND TO ARRAY:C911(atACTie_COLUMNA4;"")  //Anulado
		APPEND TO ARRAY:C911(atACTie_COLUMNA5;"")  //operación
		APPEND TO ARRAY:C911(atACTie_COLUMNA6;"")  //Tipo Impuesto 
		APPEND TO ARRAY:C911(atACTie_COLUMNA7;"0"+<>tXS_RS_DecimalSeparator+"19")  //Tasa del Impuesto
		APPEND TO ARRAY:C911(atACTie_COLUMNA8;"")  //Número Interno
		
		
		$t_fecha:=ST_GetWord ($text;2;"\t")  // fecha entrega
		
		APPEND TO ARRAY:C911(atACTie_COLUMNA9;Substring:C12($t_fecha;7;4)+"-"+String:C10(Num:C11(Substring:C12($t_fecha;4;2));"00")+"-"+String:C10(Num:C11(Substring:C12($t_fecha;1;2));"00"))  //Fecha Documento
		APPEND TO ARRAY:C911(atACTie_COLUMNA10;"")  //Código Sucursal
		APPEND TO ARRAY:C911(atACTie_COLUMNA11;ST_Uppercase (Replace string:C233(SR_FormatoRUT2 (ST_GetWord ($text;6;"\t"));".";"")))  // rut
		APPEND TO ARRAY:C911(atACTie_COLUMNA12;ST_GetWord ($text;5;"\t"))  //Razón Social
		
		  // "Factura no Afecta o Exenta Electrónica"
		
		  //If (aQR_Longint1{$l_find}=34)
		  //APPEND TO ARRAY(atACTie_COLUMNA13;ST_GetWord ($text;28;"\t"))  //Monto Exento
		  //APPEND TO ARRAY(atACTie_COLUMNA14;"")  //Monto Neto
		  //Else 
		  //APPEND TO ARRAY(atACTie_COLUMNA13;"")  //Monto Exento
		  //APPEND TO ARRAY(atACTie_COLUMNA14;ST_GetWord ($text;28;"\t"))  //Monto Neto
		  //End if 
		
		  //Preguntar a roberto si esto es correcto asino ver una solucion o otro ejemplo del colegio para el desarrollo.
		C_TEXT:C284($vt_Exento;$vt_Afecto;$vt_mIva)
		
		$vt_Exento:=ST_GetWord ($text;7;"\t")
		$vt_Afecto:=ST_GetWord ($text;8;"\t")
		$vt_mIva:=ST_GetWord ($text;9;"\t")
		
		
		APPEND TO ARRAY:C911(atACTie_COLUMNA13;String:C10($vt_Exento))  //Monto Exento
		APPEND TO ARRAY:C911(atACTie_COLUMNA14;String:C10($vt_Afecto))  //Monto Neto
		
		APPEND TO ARRAY:C911(atACTie_COLUMNA15;String:C10($vt_mIva))  //Monto IVA
		
		APPEND TO ARRAY:C911(atACTie_COLUMNA16;"")  //Monto Neto Activo Fijo
		APPEND TO ARRAY:C911(atACTie_COLUMNA17;"")  //IVA Activo Fijo
		APPEND TO ARRAY:C911(atACTie_COLUMNA18;"")  //IVA Uso Común
		APPEND TO ARRAY:C911(atACTie_COLUMNA19;"")  //Impuesto Sin derecho a crédito
		APPEND TO ARRAY:C911(atACTie_COLUMNA20;ST_GetWord ($text;10;"\t"))  //Monto Total
		APPEND TO ARRAY:C911(atACTie_COLUMNA21;"")  //IVA No Retenido
		APPEND TO ARRAY:C911(atACTie_COLUMNA22;"")  //Tabaco Puros
		APPEND TO ARRAY:C911(atACTie_COLUMNA23;"")  //Tabaco Cigarrillos
		APPEND TO ARRAY:C911(atACTie_COLUMNA24;"")  //Tabaco Elaborado
		APPEND TO ARRAY:C911(atACTie_COLUMNA25;"")  //Impuesto Vehículo
		
		APPEND TO ARRAY:C911(atACTie_COLUMNA26;"")  //Cod iva no recuperable
		APPEND TO ARRAY:C911(atACTie_COLUMNA27;"")  //monto iva no recuperable
		
		RECEIVE PACKET:C104($ref;$text;$delimiter)
		
	Else 
		
		  // Mostrar error y salir
		$b_mostrarMsgError:=True:C214
		While ($text#"")
			RECEIVE PACKET:C104($ref;$text;$delimiter)
		End while 
		
	End if 
End while 

If ($b_mostrarMsgError)
	CD_Dlog (0;"Código no clasificado. Revise que los tipos de documentos correspondan a lo indicado en el formato de las compras para los libros electrónicos.")
Else 
	  // Ordena los arrays
	MULTI SORT ARRAY:C718(atACTie_COLUMNA3;>;atACTie_COLUMNA1;>;atACTie_COLUMNA11;>;atACTie_COLUMNA2;atACTie_COLUMNA4;atACTie_COLUMNA5;atACTie_COLUMNA6;atACTie_COLUMNA7;atACTie_COLUMNA8;atACTie_COLUMNA9;atACTie_COLUMNA10;atACTie_COLUMNA12;atACTie_COLUMNA13;atACTie_COLUMNA14;atACTie_COLUMNA15;atACTie_COLUMNA16;atACTie_COLUMNA17;atACTie_COLUMNA18;atACTie_COLUMNA19;atACTie_COLUMNA20;atACTie_COLUMNA21;atACTie_COLUMNA22;atACTie_COLUMNA23;atACTie_COLUMNA24;atACTie_COLUMNA25;atACTie_COLUMNA26;atACTie_COLUMNA27)
	  // Recorrer los arrays y quitar los folios iguales, para cada rut y tipo de documento
End if 

CLOSE DOCUMENT:C267($ref)
AT_RedimArrays (Size of array:C274(atACTie_COLUMNA1);->atACTie_COLUMNA26;->atACTie_COLUMNA27;->atACTie_COLUMNA28;->atACTie_COLUMNA29;->atACTie_COLUMNA30;->atACTie_COLUMNA31;->atACTie_COLUMNA32;->atACTie_COLUMNA33;->atACTie_COLUMNA34)
USE CHARACTER SET:C205(*;1)