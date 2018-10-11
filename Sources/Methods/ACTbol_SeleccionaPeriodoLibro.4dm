//%attributes = {}
  //ACTbol_SeleccionaPeriodoLibro

$0:=True:C214
  //WDW_OpenFormWindow (->[ACT_Boletas];"SeleccionRangoLibroVentas";0;-Palette form window;__ ("Seleccione Tipo de Documento y Período"))
WDW_OpenFormWindow (->[ACT_Boletas:181];"SeleccionRangoLibroVentas";0;Modal dialog box:K34:2;__ ("Seleccione Tipo de Documento y Período"))
DIALOG:C40([ACT_Boletas:181];"SeleccionRangoLibroVentas")
CLOSE WINDOW:C154
If (ok=0)
	$0:=False:C215
End if 