//%attributes = {}
  //ACTdc_CambiaUCheques

IDDocC:=0
vtACT_Ubicacion:=""
ST_Deconcatenate (";";$1;->IDDocC;->vtACT_Ubicacion)
$0:=True:C214
READ WRITE:C146([ACT_Documentos_en_Cartera:182])
QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=IDDocC)
If (Not:C34(Locked:C147([ACT_Documentos_en_Cartera:182])))
	[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8:=vtACT_Ubicacion
	SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
Else 
	$0:=False:C215
End if 
UNLOAD RECORD:C212([ACT_Documentos_en_Cartera:182])
READ ONLY:C145([ACT_Documentos_en_Cartera:182])