//%attributes = {}
  //CFG_BBL_Lugares

C_BLOB:C604($myBlob)

READ WRITE:C146([xxBBL_Preferencias:65])
ALL RECORDS:C47([xxBBL_Preferencias:65])
If (Records in table:C83([xxBBL_Preferencias:65])=0)
	CREATE RECORD:C68([xxBBL_Preferencias:65])
	SAVE RECORD:C53([xxBBL_Preferencias:65])
End if 
FIRST RECORD:C50([xxBBL_Preferencias:65])
ARRAY TEXT:C222(<>aPlaceCode;0)
ARRAY TEXT:C222(<>aPlace;0)
<>aPlaceCode:=0
<>aPlace:=0
OBJECT SET TITLE:C194(bAddPlace;__ ("Agregar"))
sCode:=""
sName:=""
OBJECT SET ENTERABLE:C238(sCode;True:C214)
_O_DISABLE BUTTON:C193(bDelPlace)
_O_ENABLE BUTTON:C192(bAddPlace)
BLOB_Variables2Blob (->$myBlob;0;-><>aPlaceCode;-><>aPlace)
$myBlob:=PREF_fGetBlob (0;"Lugares Biblioteca";$myBlob)
BLOB_Blob2Vars (->$myBlob;0;-><>aPlaceCode;-><>aPlace)
<>aPlaceCode:=0
<>aPlace:=0
theText:=""
If (<>aPlaceCode=0)
	<>aPlaceCode:=0
	<>aPlace:=0
	OBJECT SET TITLE:C194(bAddPlace;"Agregar")
	OBJECT SET ENTERABLE:C238(sCode;True:C214)
	_O_DISABLE BUTTON:C193(bDelPlace)
	_O_ENABLE BUTTON:C192(bAddPlace)
Else 
	If (<>aPlaceCode>0)
		If (<>aPlaceCode{<>aPlaceCode}#"")
			OBJECT SET TITLE:C194(bAddPlace;__ ("Modificar"))
			QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Lugar:13=(<>aPlaceCode{<>aPLaceCode}+"@"))
			If (Records in selection:C76([BBL_Registros:66])>0)
				GOTO OBJECT:C206(sName)
				OBJECT SET ENTERABLE:C238(sCode;False:C215)
				_O_DISABLE BUTTON:C193(bDelPlace)
			Else 
				OBJECT SET ENTERABLE:C238(sCode;True:C214)
				_O_ENABLE BUTTON:C192(bDelPlace)
			End if 
		Else 
			OBJECT SET TITLE:C194(bAddPlace;"Modificar")
			OBJECT SET ENTERABLE:C238(sCode;True:C214)
			_O_ENABLE BUTTON:C192(bDelPlace)
		End if 
	End if 
End if 
CFG_OpenConfigPanel (->[xxBBL_Preferencias:65];"CFG_Lugares")
SET BLOB SIZE:C606($myBlob;0)
BLOB_Variables2Blob (->$myBlob;0;-><>aPlaceCode;-><>aPlace)
PREF_SetBlob (0;"Lugares Biblioteca";$myBlob)
KRL_ExecuteOnConnectedClients ("BBL_LeeConfiguracion")
BBL_LeeConfiguracion 