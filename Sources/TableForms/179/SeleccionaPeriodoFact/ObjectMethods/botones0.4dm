If (Self:C308->=1)
	If (Not:C34(vbACT_BuscaEnSel))
		OBJECT SET TITLE:C194(bAccept;__ ("Exportar"))
	End if 
Else 
	OBJECT SET TITLE:C194(bAccept;__ ("Ok"))
End if 