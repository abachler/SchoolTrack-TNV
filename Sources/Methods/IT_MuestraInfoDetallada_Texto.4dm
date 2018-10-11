//%attributes = {}
  // IT_MuestraInfoDetallada_Texto()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 04/01/13, 20:11:38
  // ---------------------------------------------


  // CODIGO
vt_textoPopwindow:=$1
If (Count parameters:C259=2)
	vt_EncabezadoPopWindow:=$2
Else 
	vt_EncabezadoPopWindow:="Detalle..."
End if 

WDW_Open (1;1;7;Pop up form window:K39:11)

DIALOG:C40("DetallesTexto")
CLOSE WINDOW:C154



