//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 02-11-16, 12:49:40
  // ----------------------------------------------------
  // Método: ACTiecv_cFlexLine
  // Descripción: Código Base ACTiecv_cSoftland()
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

While ($text#"")
	
	$l_find:=Find in array:C230(aQR_Longint1;Num:C11(ST_GetWord (ST_GetWord ($text;3;"\t");1;" ")))
	
	If ($l_find>0)
		
		APPEND TO ARRAY:C911(atACTie_COLUMNA1;String:C10(aQR_Longint1{$l_find}))  //Tipo Documento
		APPEND TO ARRAY:C911(atACTie_COLUMNA2;"")  //Excepción Emisor
		APPEND TO ARRAY:C911(atACTie_COLUMNA3;ST_GetWord ($text;4;"\t"))  //Folio
		APPEND TO ARRAY:C911(atACTie_COLUMNA4;"")  //Anulado
		APPEND TO ARRAY:C911(atACTie_COLUMNA5;"")  //operación
		APPEND TO ARRAY:C911(atACTie_COLUMNA6;"")  //Tipo Impuesto 
		APPEND TO ARRAY:C911(atACTie_COLUMNA7;"0"+<>tXS_RS_DecimalSeparator+"19")  //Tasa del Impuesto
		APPEND TO ARRAY:C911(atACTie_COLUMNA8;"")  //Número Interno
		$t_fecha:=ST_GetWord ($text;7;"\t")  // fecha entrega
		APPEND TO ARRAY:C911(atACTie_COLUMNA9;Substring:C12($t_fecha;7;4)+"-"+String:C10(Num:C11(Substring:C12($t_fecha;4;2));"00")+"-"+String:C10(Num:C11(Substring:C12($t_fecha;1;2));"00"))  //Fecha Documento
		APPEND TO ARRAY:C911(atACTie_COLUMNA10;"")  //Código Sucursal
		APPEND TO ARRAY:C911(atACTie_COLUMNA11;ST_Uppercase (Replace string:C233(SR_FormatoRUT2 (ST_GetWord ($text;23;"\t"));".";"")))  // rut
		APPEND TO ARRAY:C911(atACTie_COLUMNA12;ST_GetWord ($text;24;"\t"))  //Razón Social
		  // "Factura no Afecta o Exenta Electrónica"
		If (aQR_Longint1{$l_find}=34)
			APPEND TO ARRAY:C911(atACTie_COLUMNA13;ST_GetWord ($text;28;"\t"))  //Monto Exento
			APPEND TO ARRAY:C911(atACTie_COLUMNA14;"")  //Monto Neto
		Else 
			APPEND TO ARRAY:C911(atACTie_COLUMNA13;"")  //Monto Exento
			APPEND TO ARRAY:C911(atACTie_COLUMNA14;ST_GetWord ($text;28;"\t"))  //Monto Neto
		End if 
		APPEND TO ARRAY:C911(atACTie_COLUMNA15;"")  //Monto IVA
		If (ST_GetWord ($text;9;"\t")="Activo Fijo")
			APPEND TO ARRAY:C911(atACTie_COLUMNA16;atACTie_COLUMNA14{Size of array:C274(atACTie_COLUMNA14)})  //Monto Neto Activo Fijo
		Else 
			APPEND TO ARRAY:C911(atACTie_COLUMNA16;"")  //Monto Neto Activo Fijo
		End if 
		APPEND TO ARRAY:C911(atACTie_COLUMNA17;"")  //IVA Activo Fijo
		APPEND TO ARRAY:C911(atACTie_COLUMNA18;"")  //IVA Uso Común
		APPEND TO ARRAY:C911(atACTie_COLUMNA19;"")  //Impuesto Sin derecho a crédito
		APPEND TO ARRAY:C911(atACTie_COLUMNA20;ST_GetWord ($text;30;"\t"))  //Monto Total
		APPEND TO ARRAY:C911(atACTie_COLUMNA21;"")  //IVA No Retenido
		APPEND TO ARRAY:C911(atACTie_COLUMNA22;"")  //Tabaco Puros
		APPEND TO ARRAY:C911(atACTie_COLUMNA23;"")  //Tabaco Cigarrillos
		APPEND TO ARRAY:C911(atACTie_COLUMNA24;"")  //Tabaco Elaborado
		APPEND TO ARRAY:C911(atACTie_COLUMNA25;"")  //Impuesto Vehículo
		If (Abs:C99(Num:C11(atACTie_COLUMNA14{Size of array:C274(atACTie_COLUMNA14)}))>0)
			APPEND TO ARRAY:C911(atACTie_COLUMNA26;"1")  //Cod iva no recuperable
			APPEND TO ARRAY:C911(atACTie_COLUMNA27;ST_GetWord ($text;29;"\t"))  //monto iva no recuperable
		Else 
			APPEND TO ARRAY:C911(atACTie_COLUMNA26;"")  //Cod iva no recuperable
			APPEND TO ARRAY:C911(atACTie_COLUMNA27;"")  //monto iva no recuperable
		End if 
		
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
	For ($z;Size of array:C274(atACTie_COLUMNA3);1;-1)
		
		If ((atACTie_COLUMNA3{$z-1}=atACTie_COLUMNA3{$z}) & ($z>1))
			If ((atACTie_COLUMNA1{$z-1}=atACTie_COLUMNA1{$z}) & ($z>1))
				If ((atACTie_COLUMNA11{$z-1}=atACTie_COLUMNA11{$z}) & ($z>1))
					
					DELETE FROM ARRAY:C228(atACTie_COLUMNA1;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA2;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA3;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA4;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA5;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA6;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA7;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA8;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA9;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA10;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA11;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA12;$z)
					atACTie_COLUMNA13{$z-1}:=String:C10(Num:C11(atACTie_COLUMNA13{$z-1})+Num:C11(atACTie_COLUMNA13{$z}))
					DELETE FROM ARRAY:C228(atACTie_COLUMNA13;$z)
					atACTie_COLUMNA14{$z-1}:=String:C10(Num:C11(atACTie_COLUMNA14{$z-1})+Num:C11(atACTie_COLUMNA14{$z}))
					DELETE FROM ARRAY:C228(atACTie_COLUMNA14;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA15;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA16;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA17;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA18;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA19;$z)
					atACTie_COLUMNA20{$z-1}:=String:C10(Num:C11(atACTie_COLUMNA20{$z-1})+Num:C11(atACTie_COLUMNA20{$z}))
					DELETE FROM ARRAY:C228(atACTie_COLUMNA20;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA21;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA22;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA23;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA24;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA25;$z)
					DELETE FROM ARRAY:C228(atACTie_COLUMNA26;$z)
					atACTie_COLUMNA27{$z-1}:=String:C10(Num:C11(atACTie_COLUMNA27{$z-1})+Num:C11(atACTie_COLUMNA27{$z}))
					DELETE FROM ARRAY:C228(atACTie_COLUMNA27;$z)
				End if 
			End if 
		End if 
		
		If (Num:C11(atACTie_COLUMNA13{$z})<0)
			atACTie_COLUMNA13{$z}:=String:C10(Abs:C99(Num:C11(atACTie_COLUMNA13{$z})))
		End if 
		If (Num:C11(atACTie_COLUMNA14{$z})<0)
			atACTie_COLUMNA14{$z}:=String:C10(Abs:C99(Num:C11(atACTie_COLUMNA14{$z})))
		End if 
		If (Num:C11(atACTie_COLUMNA20{$z})<0)
			atACTie_COLUMNA20{$z}:=String:C10(Abs:C99(Num:C11(atACTie_COLUMNA20{$z})))
		End if 
		If (Num:C11(atACTie_COLUMNA27{$z})<0)
			atACTie_COLUMNA27{$z}:=String:C10(Abs:C99(Num:C11(atACTie_COLUMNA27{$z})))
		End if 
		
	End for 
	
End if 

CLOSE DOCUMENT:C267($ref)
AT_RedimArrays (Size of array:C274(atACTie_COLUMNA1);->atACTie_COLUMNA26;->atACTie_COLUMNA27;->atACTie_COLUMNA28;->atACTie_COLUMNA29;->atACTie_COLUMNA30;->atACTie_COLUMNA31;->atACTie_COLUMNA32;->atACTie_COLUMNA33;->atACTie_COLUMNA34)

USE CHARACTER SET:C205(*;1)