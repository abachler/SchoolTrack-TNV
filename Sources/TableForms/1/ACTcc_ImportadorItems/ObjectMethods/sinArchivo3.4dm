  // [xxSTR_Constants].ACTcc_ImportadorItems.sinArchivo3()

C_TEXT:C284($t_fileName;$t_folderPath;$t_rutaDocumento;$t_title)
C_LONGINT:C283($l_col;$l_fila;$l_hoja;$l_refXLS;$l_success)

If (SYS_IsWindows )
	USE CHARACTER SET:C205("windows-1252";0)
Else 
	USE CHARACTER SET:C205("MacRoman";0)
End if 

ARRAY TEXT:C222(aHeaders;0)
ARRAY TEXT:C222(aHeaders;29)
AT_Inc (0)
aHeaders{AT_Inc }:="ID"
aHeaders{AT_Inc }:="Glosa"
aHeaders{AT_Inc }:="Moneda"
aHeaders{AT_Inc }:="Monto"
aHeaders{AT_Inc }:="Es Relativo"
aHeaders{AT_Inc }:="Afecto a IVA"
aHeaders{AT_Inc }:="En Documentos Tributarios"
aHeaders{AT_Inc }:="Es Descuento"
aHeaders{AT_Inc }:="Afecto a Descuentos"
aHeaders{AT_Inc }:="Afecto a Descuento por Cuenta"
aHeaders{AT_Inc }:="Item Global"
aHeaders{AT_Inc }:="Imputacion Unica"
aHeaders{AT_Inc }:="Cuenta Contable"
aHeaders{AT_Inc }:="Glosa Cuenta Contable"
aHeaders{AT_Inc }:="Cod. Auxiliar"
aHeaders{AT_Inc }:="Centro de Costos"
aHeaders{AT_Inc }:="Contra Cuenta Contable"
aHeaders{AT_Inc }:="Glosa Contra Cuenta Contable"
aHeaders{AT_Inc }:="Contra Cod. Auxiliar"
aHeaders{AT_Inc }:="Contra Centro de Costos"
aHeaders{AT_Inc }:="Afecto a Intereses"
aHeaders{AT_Inc }:="Tipo interés"
aHeaders{AT_Inc }:="Tasa de interés (%)"
aHeaders{AT_Inc }:="Observación"
aHeaders{AT_Inc }:="Venta Rapida"
aHeaders{AT_Inc }:="Afecto recargo automatico"
aHeaders{AT_Inc }:="Meses activos"
aHeaders{AT_Inc }:="Descuento por numero de hijos"
aHeaders{AT_Inc }:="Descuento por hijos o cargas totales"
APPEND TO ARRAY:C911(aHeaders;"Razón Social")
APPEND TO ARRAY:C911(aHeaders;"Período")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv -3")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv -2")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv -1")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 1")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 2")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 3")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 4")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 5")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 6")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 7")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 8")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 9")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 10")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 11")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Cuenta Niv 12")

APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv -3")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv -2")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv -1")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 1")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 2")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 3")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 4")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 5")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 6")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 7")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 8")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 9")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 10")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 11")
APPEND TO ARRAY:C911(aHeaders;"Centro de Costos Contra Niv 12")

$t_folderPath:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)
$t_fileName:="DEFItems"+String:C10(Day of:C23(Current date:C33(*)))+String:C10(Month of:C24(Current date:C33(*)))+String:C10(Year of:C25(Current date:C33(*)))
$l_refXLS:=XLS Create (1)
$l_hoja:=1
$l_fila:=1
XLS Set sheet name ($l_refXLS;$l_hoja;"Ítems")
For ($l_col;1;Size of array:C274(aHeaders))
	XLS Set text value ($l_refXLS;$l_hoja;$l_fila;$l_col;aHeaders{$l_col})
End for 
$t_rutaDocumento:=$t_folderPath+$t_fileName+".xls"
$l_success:=XLS Save as ($l_refXLS;$t_rutaDocumento)
XLS CLOSE ($l_refXLS)
USE CHARACTER SET:C205(*;0)
ACTcd_DlogWithShowOnDisk ($t_rutaDocumento;0;"Archivo generado con éxito. Puede encontrarlo en"+"\r\r"+SYS_GetParentNme ($t_rutaDocumento))
AT_Initialize (->aHeaders)

