//%attributes = {}
  //IN_SaveSubjects

C_TEXT:C284($file)
_O_C_STRING:C293(15;fileHeader)
C_LONGINT:C283(nbRecords)

If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("IN_SaveSubjects";Pila_256K;"Guardando tabla de subsectores oficiales…")
Else 
	$file:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"Materias_"+<>vtXS_CountryCode+".txt"
	If ($file#"")
		SET CHANNEL:C77(12;$file)
		If (ok=1)
			QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Subsector_Oficial:15=True:C214)
			nbRecords:=Records in selection:C76([xxSTR_Materias:20])
			SEND VARIABLE:C80(nbRecords)
			FIRST RECORD:C50([xxSTR_Materias:20])
			While (Not:C34(End selection:C36([xxSTR_Materias:20])))
				sName:=[xxSTR_Materias:20]Materia:2
				SEND VARIABLE:C80(sName)
				SEND RECORD:C78([xxSTR_Materias:20])
				NEXT RECORD:C51([xxSTR_Materias:20])
			End while 
			SET CHANNEL:C77(11)
		End if 
	End if 
End if 
