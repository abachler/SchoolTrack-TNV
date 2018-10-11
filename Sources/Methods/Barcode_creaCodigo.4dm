//%attributes = {}
  // Barcode_CreaCodigo()
  // Por: Alberto Bachler K.: 02-12-13, 18:04:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)
C_BOOLEAN:C305($4)
C_BOOLEAN:C305($5)
C_PICTURE:C286($0)

C_BOOLEAN:C305($b_agregarCheckSum;$b_imprimirBarCode;$b_mostrarCheckSum)
C_TEXT:C284($t_textoCodigo;$t_tipoBarcode)

If (False:C215)
	C_TEXT:C284(Barcode_creaCodigo ;$1)
	C_TEXT:C284(Barcode_creaCodigo ;$2)
	C_BOOLEAN:C305(Barcode_creaCodigo ;$3)
	C_BOOLEAN:C305(Barcode_creaCodigo ;$4)
	C_BOOLEAN:C305(Barcode_creaCodigo ;$5)
End if 
$t_tipoBarcode:=$1
$t_textoCodigo:=$2
$b_agregarCheckSum:=$3
$b_mostrarCheckSum:=$4
$b_imprimirBarCode:=$5



$0:=Barcode_Create ($t_tipoBarcode;$t_textoCodigo;$b_agregarCheckSum;$b_mostrarCheckSum;$b_imprimirBarCode)



