//%attributes = {}
  // BBLpat_GeneraCodigoBarra()
  // Por: Alberto Bachler: 17/09/13, 13:29:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_crearCheckSum;$b_imprimirCodigo;$b_mostrarCheckSum)
C_LONGINT:C283($el)
C_POINTER:C301($y_identificador)
C_TEXT:C284($t_tipoCodigoBarra)



If ([BBL_Lectores:72]BarCode_SinFormato:38="")
	$y_identificador:=Field:C253(Table:C252(->[BBL_Lectores:72]);<>lBBL_refCampoBarcodeLector)
	Case of 
		: (<>lBBL_refCampoBarcodeLector#Field:C253(->[BBL_Lectores:72]ID:1))
			[BBL_Lectores:72]BarCode_SinFormato:38:=$y_identificador->
			
		: (<>lBBL_refCampoBarcodeLector=Field:C253(->[BBL_Lectores:72]ID:1))
			[BBL_Lectores:72]BarCode_SinFormato:38:=String:C10([BBL_Lectores:72]ID:1;"#########000000")
	End case 
	
	If ([BBL_Lectores:72]BarCode_SinFormato:38="")
		  // si no hay información para generar el codigo de barra (identificadores nacionales vacíos)
		  // se utiliza el identificador interno
		[BBL_Lectores:72]BarCode_SinFormato:38:=String:C10([BBL_Lectores:72]ID:1;"#########000000")
		  //$b_anteponerPrefijo:=True
	End if 
	
	If (<>bBBL_BarcodeLectorConPrefijo)
		  //si se utiliza el ID interno se antepone el prefijo correspondiente al grupo de lectores o el prefijo por omisión para lectores
		$el:=Find in array:C230(<>alBBL_GruposLectores;[BBL_Lectores:72]ID_GrupoLectores:37)
		If ($el>0)
			[BBL_Lectores:72]BarCode_SinFormato:38:=<>asBBL_AbrevGruposLectores{$el}+[BBL_Lectores:72]BarCode_SinFormato:38
		Else 
			[BBL_Lectores:72]BarCode_SinFormato:38:="LEC"+[BBL_Lectores:72]BarCode_SinFormato:38
		End if 
	End if 
Else 
	[BBL_Lectores:72]BarCode_SinFormato:38:=[BBL_Lectores:72]BarCode_SinFormato:38
End if 


$t_tipoCodigoBarra:="Code39"
$b_crearCheckSum:=False:C215
$b_mostrarCheckSum:=False:C215
$b_imprimirCodigo:=True:C214
If ([BBL_Lectores:72]BarCode_SinFormato:38#Old:C35([BBL_Lectores:72]BarCode_SinFormato:38))
	[BBL_Lectores:72]CodigoBarra_Imagen:36:=Barcode_creaCodigo ($t_tipoCodigoBarra;[BBL_Lectores:72]BarCode_SinFormato:38;$b_crearCheckSum;$b_mostrarCheckSum;$b_imprimirCodigo)
	[BBL_Lectores:72]Código_de_barra:10:="*"+[BBL_Lectores:72]BarCode_SinFormato:38+"*"
End if 