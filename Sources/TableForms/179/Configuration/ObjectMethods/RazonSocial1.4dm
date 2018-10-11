ARRAY TEXT:C222($atACTcfg_Razones;0)
ARRAY LONGINT:C221($alACTcfg_Razones;0)
C_TEXT:C284($vt_razon)
C_LONGINT:C283($vl_razon)

$vt_razon:=[xxACT_Items:179]RazonSocialAsociada:35
$vl_razon:=[xxACT_Items:179]ID_RazonSocial:36

COPY ARRAY:C226(atACTcfg_Razones;$atACTcfg_Razones)
COPY ARRAY:C226(alACTcfg_Razones;$alACTcfg_Razones)
AT_Insert (1;2;->$atACTcfg_Razones;->$alACTcfg_Razones)
$atACTcfg_Razones{1}:="Ninguna"
$atACTcfg_Razones{2}:="-"
$choice:=IT_PopUpMenu (->$atACTcfg_Razones;->[xxACT_Items:179]RazonSocialAsociada:35)
Case of 
	: ($choice>2)
		[xxACT_Items:179]RazonSocialAsociada:35:=$atACTcfg_Razones{$choice}
		[xxACT_Items:179]ID_RazonSocial:36:=$alACTcfg_Razones{$choice}
	: ($choice=1)
		[xxACT_Items:179]RazonSocialAsociada:35:=""
		[xxACT_Items:179]ID_RazonSocial:36:=0
End case 

If (($choice>0) | ($choice=1))
	If (($vt_razon#[xxACT_Items:179]RazonSocialAsociada:35) | ($vl_razon#[xxACT_Items:179]ID_RazonSocial:36))
		vtMsg:="Usted modificó la razón social para este cargo."+"\r"+"Si lo desea puede aplicar el cambio a los cargos ya generados o bien sólo para lo"+"s cargos que se generen de ahora en adelante."
		vtDesc1:="La configuración del cargo es modificada, pero sólo será aplicada a los nuevos "+"cargos que se generen."
		vtDesc2:="Se asigna el cambio a los cargos ya generados."
		vtBtn1:="Sólo para los nuevos cargos"
		vtBtn2:="Aplicar también a los cargos ya generados"
		WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
		If (ok=1)
			If (r2=1)
				$vt_item:=String:C10([xxACT_Items:179]ID:1)
				$vt_nuevaRazon:=[xxACT_Items:179]RazonSocialAsociada:35
				$vt_key:=ST_Concatenate (";";->$vl_razon;->[xxACT_Items:179]ID_RazonSocial:36;->[xxACT_Items:179]ID:1)
				ACTcfg_OpcionesRazonesSociales ("AplicaCambiosEnRazonSocial";->$vt_key)
				LOG_RegisterEvt ("Cambio de razón social al ítem "+$vt_item+". Cambió de "+$vt_razon+" a "+$vt_nuevaRazon+".")
			End if 
		Else 
			[xxACT_Items:179]RazonSocialAsociada:35:=$vt_razon
			[xxACT_Items:179]ID_RazonSocial:36:=$vl_razon
		End if 
	End if 
End if 
