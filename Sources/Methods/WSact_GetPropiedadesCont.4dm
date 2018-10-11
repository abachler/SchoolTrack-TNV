//%attributes = {}
  //WSact_GetPropiedadesCont

  //****DECLARACIONES****
C_TEXT:C284(vtWS_ResultString;$countryCode;$rolBD)
C_TEXT:C284($vt_propiedades)
C_TEXT:C284($1;$vt_opcion;$2)
C_BLOB:C604($0;$xBlob)
C_BOOLEAN:C305($b_ambienteProd)

  //****INICIALIZACIONES****
vtWS_ResultString:=""
$b_ambienteProd:=(Num:C11(PREF_fGet (0;"ACT_AMBIENTE_CERTIFICACION_SII";"1"))=0)
$vt_opcion:=$1
$vt_rut:=$2

READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
$countryCode:=[Colegio:31]Codigo_Pais:31
$rolBD:=[Colegio:31]Rol Base Datos:9

WEB SERVICE SET PARAMETER:C777("countryCode";$countryCode)
WEB SERVICE SET PARAMETER:C777("rolBD";$rolBD)
WEB SERVICE SET PARAMETER:C777("rut";$vt_rut)
WEB SERVICE SET PARAMETER:C777("datos";$vt_opcion)
WEB SERVICE SET PARAMETER:C777("produccion";$b_ambienteProd)

  //****CUERPO****
WSact_DTECallWebServiceIntranet ("WSsend_ACTdtePropiedades")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vtWS_ResultString;"ERRstring")
	WEB SERVICE GET RESULT:C779($xBlob;"propiedades";*)
End if 

Case of 
	: ((error#0) | (ok=0))
		CD_Dlog (0;__ ("No fue posible conectarse a Colegium."))
	: (vtWS_ResultString#"")
		CD_Dlog (0;vtWS_ResultString)
	: (vtWS_ResultString="")
End case 
$0:=$xBlob
  //****LIMPIEZA****


