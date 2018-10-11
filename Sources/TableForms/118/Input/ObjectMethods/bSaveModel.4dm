USE CHARACTER SET:C205("MacRoman";0)
If (([xxACT_ArchivosBancarios:118]ID:1#0) & (Records in selection:C76([xxACT_ArchivosBancarios:118])=1))
	If ([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=False:C215)
		$offset:=0
		vtCode:=BLOB to text:C555([xxACT_ArchivosBancarios:118]xData:2;Mac text without length:K22:10;$offset;32000)
		$validFile:=ACTtrf_IsValidTransferFile (vtCode)
		If ($validFile)
			C_TIME:C306($ref)
			C_TEXT:C284($text)
			$text:=vtCode
			$text:=$text+Char:C90(1)+Char:C90(1)+Char:C90(1)
			$ref:=Create document:C266("";"ctf")
			If (ok=1)
				SEND PACKET:C103($ref;$text)
				CLOSE DOCUMENT:C267($ref)
			Else 
				BEEP:C151
				ALERT:C41("No se pudo guardar el documento")
			End if 
		Else 
			CD_Dlog (0;__ ("El código almacenado en este registro parece estar corrupto. Póngase en contacto con el personal de Colegium para solucionar este problema."))
		End if 
		vtCode:=""
	Else 
		C_TEXT:C284($filename;$path;$validate)
		$validate:="Colegium S.A. - Wizard"
		READ ONLY:C145([xxACT_ArchivosBancarios:118])
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=[xxACT_ArchivosBancarios:118]ID:1)
		
		$path:=SYS_SelectFolder ("Seleccione la carpeta para guardar el informe...")
		If ($path#"")
			If (SYS_IsMacintosh )
				$fileName:=$path+Substring:C12([xxACT_ArchivosBancarios:118]Nombre:3;1;27)+".txt"
			Else 
				$fileName:=$path+[xxACT_ArchivosBancarios:118]Nombre:3
			End if 
			SET CHANNEL:C77(12;$fileName)
			SEND VARIABLE:C80($validate)
			SEND RECORD:C78([xxACT_ArchivosBancarios:118])
			SET CHANNEL:C77(11)
		End if 
	End if 
	CANCEL:C270
End if 
USE CHARACTER SET:C205(*;0)