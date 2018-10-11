//%attributes = {}
  // BBLreg_GeneraCodigoBarra()
  // Por: Alberto Bachler: 17/09/13, 13:29:58
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_agregarCheckSum;$b_incluirIdentificador;$b_mostrarCheckSum)
C_LONGINT:C283($l_elemento;$l_IdMedia;$l_numeroEnBarCode)
C_POINTER:C301($y_campoFuenteBarCode)
C_TEXT:C284($t_tipoBarcode)
C_BOOLEAN:C305($b_agregarCheckSum;$b_incluirIdentificador;$b_mostrarCheckSum)
C_LONGINT:C283($l_elemento)
C_TEXT:C284($t_tipoBarcode)
C_LONGINT:C283(<>lBBL_refCampoBarcodeDocumento)

If (<>lBBL_refCampoBarcodeDocumento=0)
	BBL_LeePrefsCodigosBarra 
End if 

If (([BBL_Registros:66]Código_de_barra:20="") | ([BBL_Registros:66]Código_de_barra:20="**"))  //MONO: En la importación los archivos que vienen sin codigos de barra quedan con ** y no se genera.
	$l_IdMedia:=KRL_GetNumericFieldData (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1;->[BBL_Items:61]ID_Media:48)
	$l_elemento:=Find in array:C230(<>alBBL_IDMedia;$l_IdMedia)
	$y_campoFuenteBarCode:=Field:C253(Table:C252(->[BBL_Registros:66]);<>lBBL_refCampoBarcodeDocumento)
	If (<>bBBL_BarcodeRegistroConPrefijo)
		If ($l_elemento>0)
			[BBL_Registros:66]Código_de_barra:20:=<>asBBL_AbrevMedia{$l_elemento}+String:C10($y_campoFuenteBarCode->;"##########000000")
		Else 
			[BBL_Registros:66]Código_de_barra:20:="REG"+String:C10($y_campoFuenteBarCode->;"##########000000")
		End if 
	Else 
		[BBL_Registros:66]Código_de_barra:20:=String:C10($y_campoFuenteBarCode->;"##########000000")
	End if 
	[BBL_Registros:66]Barcode_SinFormato:26:=[BBL_Registros:66]Código_de_barra:20
End if 


If ([BBL_Registros:66]Barcode_SinFormato:26#Old:C35([BBL_Registros:66]Barcode_SinFormato:26))
	$t_tipoBarcode:="Code39"
	$b_agregarCheckSum:=False:C215
	$b_mostrarCheckSum:=False:C215
	$b_incluirIdentificador:=True:C214
	[BBL_Registros:66]CodigoBarra_Imagen:24:=Barcode_creaCodigo ($t_tipoBarcode;Replace string:C233([BBL_Registros:66]Código_de_barra:20;"*";"");$b_agregarCheckSum;$b_mostrarCheckSum;$b_incluirIdentificador)
	[BBL_Registros:66]CodigoBarra_Imagen:24:=[BBL_Registros:66]CodigoBarra_Imagen:24
	[BBL_Registros:66]Código_de_barra:20:="*"+[BBL_Registros:66]Barcode_SinFormato:26+"*"
End if 


$l_numeroEnBarCode:=Num:C11([BBL_Registros:66]Código_de_barra:20)
Case of 
	: ([BBL_Registros:66]No_Registro:25=$l_numeroEnBarCode)
		[BBL_Registros:66]Barcode_Protegido:28:=False:C215
	: ([BBL_Registros:66]ID:3=$l_numeroEnBarCode)
		[BBL_Registros:66]Barcode_Protegido:28:=False:C215
End case 




