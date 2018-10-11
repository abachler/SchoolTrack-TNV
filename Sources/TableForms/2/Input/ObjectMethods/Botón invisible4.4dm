ARRAY TEXT:C222(aNombreContacto;0)
ARRAY TEXT:C222(aTelContacto;0)
ARRAY TEXT:C222(aRelacionContacto;0)
$ref:="contactos.ALU."+String:C10([Alumnos:2]numero:1)
$rn:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$ref)
If ($rn#-1)
	READ WRITE:C146([XShell_FatObjects:86])
	GOTO RECORD:C242([XShell_FatObjects:86];$rn)
	BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
Else 
	CREATE RECORD:C68([XShell_FatObjects:86])
	[XShell_FatObjects:86]FatObjectName:1:=$ref
	BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
	SAVE RECORD:C53([XShell_FatObjects:86])
End if 

ARRAY TEXT:C222($aNombreContacto;0)
ARRAY TEXT:C222($aTelContacto;0)
ARRAY TEXT:C222($aRelacionContacto;0)
COPY ARRAY:C226(aNombreContacto;$aNombreContacto)
COPY ARRAY:C226(aRelacionContacto;$aRelacionContacto)
COPY ARRAY:C226(aTelContacto;$aTelContacto)

WDW_OpenFormWindow (->[Alumnos:2];"contactosUrgencia";0;-Palette form window:K39:9;__ ("Contactos de Urgencia"))
DIALOG:C40([Alumnos:2];"contactosUrgencia")
CLOSE WINDOW:C154
If (OK=1)
	For ($i;Size of array:C274(aNombreContacto);1;-1)
		If ((aNombreContacto{$i}="") | (aNombreContacto{$i}="Nombre"))
			AT_Delete ($i;1;->aNombreContacto;->aRelacionContacto;->aTelContacto)
		End if 
	End for 
	BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
	SAVE RECORD:C53([XShell_FatObjects:86])
	KRL_UnloadReadOnly (->[XShell_FatObjects:86])
	
	If ((AT_IsEqual (->aNombreContacto;->$aNombreContacto)#1) | (AT_IsEqual (->aRelacionContacto;->$aRelacionContacto)#1) | (AT_IsEqual (->aTelContacto;->$aTelContacto)#1))
		SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos:2]numero:1;SNT_Accion_Actualizar)
	End if 
	
End if 