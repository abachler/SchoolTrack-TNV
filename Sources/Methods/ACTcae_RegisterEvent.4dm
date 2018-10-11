//%attributes = {}
  //ACTcae_RegisterEvent

C_LONGINT:C283($vl_year;$vl_month)
C_TEXT:C284($vt_action;$vt_dtsEvent;$vt_usr;$vt_log)

$vl_year:=$1
$vl_month:=$2
$vt_action:=$3

$vt_dtsEvent:=DTS_MakeFromDateTime 
If (<>lUSR_CurrentUserID#0)
	$vt_usr:=String:C10(<>lUSR_CurrentUserID)+"/"+<>tUSR_CurrentUser
Else 
	$vt_usr:=""
End if 
$vt_log:=$vt_dtsEvent+"\t"+$vt_usr+"\t"+$vt_action+"\r"

READ WRITE:C146([xxACT_Datos_de_Cierre:116])
QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=$vl_year;*)
QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=$vl_month)
If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=0)
	CREATE RECORD:C68([xxACT_Datos_de_Cierre:116])
	[xxACT_Datos_de_Cierre:116]Year:1:=$vl_year
	[xxACT_Datos_de_Cierre:116]Month:3:=$vl_month
End if 
[xxACT_Datos_de_Cierre:116]Log:4:=[xxACT_Datos_de_Cierre:116]Log:4+$vt_log
SAVE RECORD:C53([xxACT_Datos_de_Cierre:116])
KRL_UnloadReadOnly (->[xxACT_Datos_de_Cierre:116])