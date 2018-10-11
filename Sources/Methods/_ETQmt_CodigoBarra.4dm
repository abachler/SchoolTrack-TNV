//%attributes = {}
  //_ETQmt_CodigoBarra

  //`xShell, Alberto Bachler
  //Metodo: _CodigoBarra
  //Por abachler
  //Creada el 25/01/2006, 08:55:11
  //Modificaciones:
If ("DESCRIPCION"="")
	  //_CodigoBarra($codigo;$printCode;$barCodeType;$createchecksum;$showchecksum)
End if 

  //****DECLARACIONES****
C_PICTURE:C286($0;$barCode)
C_TEXT:C284($codigo;$barCodeType)
C_BOOLEAN:C305($createchecksum;$showchecksum;$printCode)
C_LONGINT:C283($1)  //Modificado por JHB 28/03/06
C_POINTER:C301($fieldPointer)

  //****INICIALIZACIONES****
Case of 
	: (Table:C252(vyQR_TablePointer)=Table:C252(->[BBL_Items:61]))
		$codigo:=ST_Uppercase ([BBL_Registros:66]Código_de_barra:20)
		$fieldPointer:=->[BBL_Registros:66]CodigoBarra_Imagen:24
	: (Table:C252(vyQR_TablePointer)=Table:C252(->[BBL_Registros:66]))
		$codigo:=ST_Uppercase ([BBL_Registros:66]Código_de_barra:20)
		$fieldPointer:=->[BBL_Registros:66]CodigoBarra_Imagen:24
	: (Table:C252(vyQR_TablePointer)=Table:C252(->[BBL_Lectores:72]))
		$codigo:=ST_Uppercase ([BBL_Lectores:72]Código_de_barra:10)
		$fieldPointer:=->[BBL_Lectores:72]CodigoBarra_Imagen:36
End case 

$rotate:=0
$barCodeType:="Code39"
$createchecksum:=False:C215
$showchecksum:=False:C215
$printCode:=True:C214
Case of 
	: (Count parameters:C259=1)  //Modificado por JHB 28/03/06
		$rotate:=$1
	: (Count parameters:C259=2)
		$rotate:=$1
		$printCode:=$2
	: (Count parameters:C259=3)
		$rotate:=$1
		$printCode:=$2
		$barCodeType:=$3
	: (Count parameters:C259=4)
		$rotate:=$1
		$printCode:=$2
		$barCodeType:=$3
		$createchecksum:=$4
	: (Count parameters:C259=5)
		$rotate:=$1
		$printCode:=$2
		$barCodeType:=$3
		$createchecksum:=$4
		$showchecksum:=$5
End case 

  //****CUERPO****
$barcode:=Barcode_creaCodigo ($barCodeType;Replace string:C233($codigo;"*";"");$createchecksum;$showchecksum;$printCode)  // 20110913 AS. se agrega el 5to parametro $printCode.
$fieldPointer->:=$barCode


