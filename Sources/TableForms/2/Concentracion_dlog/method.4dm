Case of 
	: (Form event:C388=On Load:K2:1)
		If ((Macintosh option down:C545 | Windows Alt down:C563) & (USR_IsGroupMember_by_GrpID (-15001)))
			OBJECT SET VISIBLE:C603(*;"bModCaracteristicas1";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"bModCaracteristicas1";False:C215)
		End if 
		
		
		STRal_OpcionesConcentracion ("LeeBlobConcentracion")
		STRal_OpcionesConcentracion ("ValidaPlanesConcentracion")
		
		$namePref:="ConcentraciónNotas.cl."+String:C10(al_AgnosConcentracion{1})
		$blob:=PREF_fGetBlob (0;$namePref;$blob)
		
		BLOB_Blob2Vars (->$blob;0;->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)
		  //For ($i;Size of array(aPEAsgName);1;-1)
		  //If (Find in array(aPCAsgName;aPEAsgName{$i})>0)
		  //AT_Delete ($i;1;->aPEAsgName;->aPEAsgPos)
		  //End if 
		  //End for 
		ARRAY INTEGER:C220(aPCAsgPos;Size of array:C274(aPCAsgName))
		For ($i;1;Size of array:C274(aPCAsgName))
			aPCAsgPos{$i}:=$i
		End for 
		
		ARRAY INTEGER:C220(aPEAsgPos;Size of array:C274(aPEAsgName))
		For ($i;1;Size of array:C274(aPEAsgName))
			aPEAsgPos{$i}:=$i
		End for 
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 


