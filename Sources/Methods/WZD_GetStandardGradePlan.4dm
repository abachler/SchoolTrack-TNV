//%attributes = {"executedOnServer":true}
  //WZD_GetStandardGradePlan
C_BOOLEAN:C305($b_semaforo)
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

$b_semaforo:=Semaphore:C143("WZD_GetStandardGradePlan")

$nivel:=$1
$file:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"Niveles_"+<>vtXS_CountryCode+".txt"

  // Modificado por: Saúl Ponce (14-11-2016) Ticket N° 168978.
If (SYS_TestPathName ($file)=Is a document:K24:1)
	
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		RECEIVE VARIABLE:C81(nbRecords)
		For ($k;1;nbrecords)
			CREATE RECORD:C68([xxSTR_Niveles:6])
			RECEIVE RECORD:C79([xxSTR_Niveles:6])
			If ($nivel=[xxSTR_Niveles:6]NoNivel:5)
				ACTAS_LeeConfiguracion ([xxSTR_Niveles:6]NoNivel:5)
				$k:=nbRecords+1
			End if 
		End for 
		SET CHANNEL:C77(11)
	End if 
	
	xBlob:=PREF_fGetBlob (0;"Plan"+String:C10($nivel);xBlob)
	BLOB_Blob2Vars (->xBlob;0;->aOrder;->aSubject;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
	
	COPY ARRAY:C226(atActas_Subsectores;aSubject)
	
	  // Modificado por: Saúl Ponce (14-11-2016) - Igualé a lo hecho en v11.12 por ASM en el Ticket N° 168968 con fecha 20161006.
	  //If (Size of array(aSubject)>4)
	If (Size of array:C274(aSubject)>0)
		AT_ResizeArrays (->aSubject;Size of array:C274(aSubject)-4)
	End if 
	For ($i;Size of array:C274(aSubject);1;-1)
		If ((aSubject{$i}="") | (aSubject{$i}=" "))
			DELETE FROM ARRAY:C228(aSubject;$i;1)
		End if 
	End for 
	
	AT_DimArrays (Size of array:C274(aSubject);->aOrder;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
	If (Size of array:C274(aSubject)>0)
		APPEND TO ARRAY:C911(aSubject;"")
		AT_DimArrays (Size of array:C274(aSubject);->aOrder;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
	Else 
		AT_DimArrays (Size of array:C274(aSubject);->aSubject;->aOrder;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
	End if 
	
	aSubject{Size of array:C274(aSubject)}:="Religión"
	For ($i;1;Size of array:C274(aSubject))
		aOrder{$i}:=$i
		
		  //If (aSubject{$i}="@Educación Física@")
		  //aSex{$i}:=aText2{2}
		  //Else 
		  //aSex{$i}:=aText2{1}
		  //End if 
		
		
		If (aSubject{$i}="@Religión@")
			aSubjectType{$i}:="Optativo"
			aIncide{$i}:=False:C215
			aNumber{$i}:="Uno por curso"
			$el:=Find in array:C230(aEvStyleId;-3)
			If ($el>0)
				aStyle{$i}:=aEvStyleName{$el}
			End if 
		Else 
			QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=aSubject{$i})
			If ([xxSTR_Materias:20]Subsector_Oficial:15)
				aSubjectType{$i}:="Plan Común, cursos"
				aIncide{$i}:=True:C214
				aNumber{$i}:="Uno por curso"
			Else 
				aSubjectType{$i}:="Plan Electivo"
				aIncide{$i}:=True:C214
				aNumber{$i}:="Uno"
			End if 
			$el:=Find in array:C230(aEvStyleId;-5)
			If ($el>0)
				aStyle{$i}:=aEvStyleName{$el}
			End if 
		End if 
	End for 
	
	BLOB_Variables2Blob (->xBlob;0;->aOrder;->aSubject;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
	PREF_SetBlob (0;"Plan"+String:C10($nivel);xBlob)
End if 


CLEAR SEMAPHORE:C144("WZD_GetStandardGradePlan")