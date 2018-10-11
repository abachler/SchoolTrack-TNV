If ([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=False:C215)
	$offset:=0
	vtCode:=BLOB to text:C555([xxACT_ArchivosBancarios:118]xData:2;Mac text without length:K22:10;$offset;32000)
	$validFile:=ACTtrf_IsValidTransferFile (vtCode)
	If ($validFile)
		vtCode:=ACTtrf_RemoveCheckCode (vtCode)
		WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"EditArchivoBancario";-1;4;__ ("Edición de código de ")+[xxACT_ArchivosBancarios:118]Nombre:3)
		DIALOG:C40([xxACT_ArchivosBancarios:118];"EditArchivoBancario")
		CLOSE WINDOW:C154
		If (OK=1)
			$valid:=ACTtrf_IsColegiumTransferFile (vtCode)
			If ($valid)
				vtCode:=ACTtrf_AddCheckCode (vtCode)
				SET BLOB SIZE:C606([xxACT_ArchivosBancarios:118]xData:2;0)
				TEXT TO BLOB:C554(vtCode;[xxACT_ArchivosBancarios:118]xData:2;Mac text without length:K22:10)
			Else 
				CD_Dlog (0;__ ("El código no corresponde a código de transferencia bancaria generado por Colegium."))
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("El código almacenado en este registro parece estar corrupto. Póngase en contacto con el personal de Colegium para solucionar este problema."))
	End if 
	vtCode:=""
Else 
	C_BOOLEAN:C305(vb_modificadoTf)
	vb_editarArchivoTf:=True:C214
	vb_modificadoTf:=True:C214
	vI_RecordNumber:=[xxACT_ArchivosBancarios:118]ID:1
	WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"WizardO";-1;4;__ ("Edición de archivo ")+[xxACT_ArchivosBancarios:118]Nombre:3)
	DIALOG:C40([xxACT_ArchivosBancarios:118];"WizardO")
	CLOSE WINDOW:C154
	KRL_FindAndLoadRecordByIndex (->[xxACT_ArchivosBancarios:118]ID:1;->vI_RecordNumber)
	vb_editarArchivoTf:=False:C215
	ACTtf_DeclareArrays 
End if 