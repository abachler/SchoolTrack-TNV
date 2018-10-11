//%attributes = {}
  //WZD_GetGradePlan

ARRAY INTEGER:C220(aOrder;0)
ARRAY TEXT:C222(aSubject;0)
ARRAY TEXT:C222(aSubjectType;0)
ARRAY TEXT:C222(aSex;0)
ARRAY TEXT:C222(aNumber;0)
ARRAY BOOLEAN:C223(aIncide;0)
ARRAY TEXT:C222(aStyle;0)
C_BLOB:C604(xBlob)
ARRAY TEXT:C222(atActas_Subsectores;0)
ARRAY INTEGER:C220(alActas_ColumnNumber;0)

SET BLOB SIZE:C606(xBlob;0)

$Nivel:=$1
xBlob:=PREF_fGetBlob (0;"Plan"+String:C10($nivel);xBlob)
If (BLOB size:C605(xBlob)>0)
	BLOB_Blob2Vars (->xBlob;0;->aOrder;->aSubject;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
End if 
  //If (Size of array(aSubject)=0)
  //Ticket 168331 ASM 20160929
If ((Size of array:C274(aSubject)=0) & ($Nivel>=1))
	WZD_GetStandardGradePlan ($nivel)  //se ejecuta en el servidor
	$proc:=IT_UThermometer (1;0;__ ("Cargando..."))
	DELAY PROCESS:C323(Current process:C322;6)
	While (Test semaphore:C652("WZD_GetStandardGradePlan"))
		DELAY PROCESS:C323(Current process:C322;12)
	End while 
	IT_UThermometer (-2;$proc)
	BLOB_Blob2Vars (->xBlob;0;->aOrder;->aSubject;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
End if 

