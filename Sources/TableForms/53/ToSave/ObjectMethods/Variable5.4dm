
If (vs_String1#"")
	[xShell_Queries:53]No:1:=[xShell_Queries:53]No:1
	READ WRITE:C146([xShell_Queries:53])
	QUERY:C277([xShell_Queries:53];[xShell_Queries:53]Name:2=vs_String1;*)
	QUERY:C277([xShell_Queries:53]; & ;[xShell_Queries:53]FileNo:5=Table:C252(vyQRY_TablePointer))
	If (Records in selection:C76([xShell_Queries:53])>0)
		If (Record number:C243([xShell_Queries:53])#vl_currentFormula)
			$prompt:="Ya existe una fórmula de búsqueda con ese nombre."+"\r"+"¿Desea usted reemplazarla?"
			$prompt:=$prompt+vs_String1
			$r:=CD_Dlog (2;$prompt;__ ("");__ ("No");__ ("Reemplazar"))
			If ($r=2)
				ACCEPT:C269
			Else 
				ok:=0
			End if 
		Else 
			ACCEPT:C269
		End if 
	Else 
		SAVE RECORD:C53([xShell_Queries:53])
		ACCEPT:C269
	End if 
Else 
	BEEP:C151
End if 



