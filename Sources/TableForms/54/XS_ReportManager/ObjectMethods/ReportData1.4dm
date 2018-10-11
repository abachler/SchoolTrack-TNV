C_TEXT:C284($itemText)
C_LONGINT:C283($itemRef)
GET LIST ITEM:C378(hl_AvailableTables;*;$itemRef;$itemText)
If ([xShell_Reports:54]RelatedTable:14>0)
	If ($itemRef#[xShell_Reports:54]RelatedTable:14)
		OK:=CD_Dlog (0;__ ("Es probable que este modelo de informe deje de funcionar si cambia la tabla de origen de los registros a imprimir.\r¿Está usted seguro que quiere cambiar la tabla de origen?");"";__ ("No");__ ("Si"))
		If (OK=2)
			If (KRL_GotoRecord (->[xShell_Reports:54];Record number:C243([xShell_Reports:54]);True:C214))
				If ($itemRef=[xShell_Reports:54]MainTable:3)
					[xShell_Reports:54]RelatedTable:14:=0
				Else 
					[xShell_Reports:54]RelatedTable:14:=$itemRef
				End if 
				SAVE RECORD:C53([xShell_Reports:54])
			Else 
				CD_Dlog (0;__ ("No es posible cambiar la tabla de origen en este momento.\rPor favor intente nuevamente más tarde."))
				SELECT LIST ITEMS BY REFERENCE:C630(hl_AvailableTables;[xShell_Reports:54]RelatedTable:14)
			End if 
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(hl_AvailableTables;[xShell_Reports:54]RelatedTable:14)
		End if 
	End if 
Else 
	If ($itemRef#[xShell_Reports:54]MainTable:3)
		OK:=CD_Dlog (0;__ ("Es probable que este modelo de informe deje de funcionar si cambia la tabla de origen de los registros a imprimir.\r¿Está usted seguro que quiere cambiar la tabla de origen?");"";__ ("No");__ ("Si"))
		If (OK=2)
			If (KRL_GotoRecord (->[xShell_Reports:54];Record number:C243([xShell_Reports:54]);True:C214))
				If ($itemRef=[xShell_Reports:54]MainTable:3)
					[xShell_Reports:54]RelatedTable:14:=0
				Else 
					[xShell_Reports:54]RelatedTable:14:=$itemRef
				End if 
				SAVE RECORD:C53([xShell_Reports:54])
			Else 
				CD_Dlog (0;__ ("No es posible cambiar la tabla de origen en este momento.\rPor favor intente nuevamente más tarde."))
				SELECT LIST ITEMS BY REFERENCE:C630(hl_AvailableTables;[xShell_Reports:54]MainTable:3)
			End if 
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(hl_AvailableTables;[xShell_Reports:54]MainTable:3)
		End if 
	End if 
	
End if 
