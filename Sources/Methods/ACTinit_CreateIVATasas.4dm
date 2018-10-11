//%attributes = {}
  //ACTinit_CreateIVATasas

C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
  //IVA, Tasas

  //20121205 RCH 
  //<>vrACT_TasaIVA:=19
Case of 
	: (<>gCountryCode="mx")
		<>vrACT_TasaIVA:=16
	: (<>gCountryCode="pe")
		<>vrACT_TasaIVA:=18
	: (<>gCountryCode="co")
		<>vrACT_TasaIVA:=16
	: (<>gCountryCode="ar")
		<>vrACT_TasaIVA:=21
	Else 
		<>vrACT_TasaIVA:=19
End case 

<>vrACT_FactorIVA:=1+(<>vrACT_TasaIVA/100)
<>vrACT_TasaInterés:=0
<>vrACT_MultaRetardo:=0
BLOB_Variables2Blob (->xBlob;0;-><>vrACT_TasaIVA;-><>vrACT_FactorIVA;-><>vrACT_TasaInterés;-><>vrACT_MultaRetardo)
PREF_SetBlob (0;"ACT_IVA_tasas";xBlob)
SET BLOB SIZE:C606(xBlob;0)