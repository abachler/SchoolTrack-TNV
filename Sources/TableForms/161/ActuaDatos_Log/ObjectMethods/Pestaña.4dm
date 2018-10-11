C_REAL:C285($ref)
C_TEXT:C284($text)
C_BOOLEAN:C305($enable)
GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)

Case of 
	: ($ref=1)
		$enable:=True:C214
		UNLOAD RECORD:C212([xShell_Logs:37])
		REDUCE SELECTION:C351([xShell_Logs:37];0)
	: ($ref=2)
		$enable:=False:C215
		SN3_ActuaDatos_LogConfArrays 
End case 
opc_1:=1
opc_2:=0
opc_3:=0

vb_Hoy:=0
vb_Mes:=0
vb_Año:=0
vb_Rango:=0
vb_todo:=1
vt_apoderado:=""

OBJECT SET ENABLED:C1123(*;"texto_modo";$enable)
OBJECT SET ENABLED:C1123(*;"opc_1";$enable)
OBJECT SET ENABLED:C1123(*;"opc_2";$enable)
OBJECT SET ENABLED:C1123(*;"opc_3";$enable)
OBJECT SET ENABLED:C1123(*;"vt_apoderado";$enable)
OBJECT SET ENABLED:C1123(*;"nombre_apo_txt";$enable)

OBJECT SET ENABLED:C1123(*;"vt_Mes";False:C215)
OBJECT SET ENABLED:C1123(*;"bMes";False:C215)
OBJECT SET ENABLED:C1123(*;"vl_Año2";False:C215)

OBJECT SET ENABLED:C1123(*;"vl_Año";False:C215)

OBJECT SET ENABLED:C1123(*;"vt_Fecha1";False:C215)
OBJECT SET ENABLED:C1123(*;"vt_Fecha2";False:C215)
OBJECT SET ENABLED:C1123(*;"fecha1";False:C215)
OBJECT SET ENABLED:C1123(*;"fecha2";False:C215)

vl_selected_page:=$ref
FORM GOTO PAGE:C247($ref)