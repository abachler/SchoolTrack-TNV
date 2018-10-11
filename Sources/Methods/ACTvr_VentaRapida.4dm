//%attributes = {}
  //ACTvr_VentaRapida

C_PICTURE:C286($4)
ACTinit_LoadPrefs 
TipoTarjeta:=$1
Bancos:=$2
Codigos:=$3
vpXS_IconModule:=$4
vsBWR_CurrentModule:=$5

ARRAY TEXT:C222(atACT_TipoTarjeta;0)
AT_Text2Array (->atACT_TipoTarjeta;TipoTarjeta)

ARRAY TEXT:C222(atACT_BankName;0)
AT_Text2Array (->atACT_BankName;Bancos)

ARRAY TEXT:C222(atACT_BankID;0)
AT_Text2Array (->atACT_BankID;Codigos)

$ref:=LOC_LoadList ("ACT_FormasdePago")
HL_ReferencedList2Array ($ref;->atACT_FormasdePago)

WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_VentaRapida";0;4;__ ("Ventas Rápidas"))
DIALOG:C40([xxSTR_Constants:1];"ACT_VentaRapida")
CLOSE WINDOW:C154