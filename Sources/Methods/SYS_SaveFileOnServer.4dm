//%attributes = {}
  // SYS_SaveFileOnServer()
  // Por: Alberto Bachler K.: 10-11-14, 08:00:45
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_nil)
C_TEXT:C284($t_mensaje)

vt_mensaje:=$1
vt_nombreArchivo:=""
vt_rutaArchivo:=""
If (Count parameters:C259=2)
	vt_nombreArchivo:=$2
End if 

WDW_OpenFormWindow ($y_nil;"XS_SelectFileOnServer";-1;8)
DIALOG:C40("XS_SelectFileOnServer")
CLOSE WINDOW:C154

$0:=vt_rutaArchivo