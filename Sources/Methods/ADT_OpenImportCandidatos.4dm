//%attributes = {}
  //ADT_OpenImportCandidatos
If (IT_AltKeyIsDown )
	WDW_OpenFormWindow (->[ADT_Candidatos:49];"Importador";0;4;__ ("Importación de Candidatos"))
	DIALOG:C40([ADT_Candidatos:49];"Importador")
	CLOSE WINDOW:C154
Else 
	CD_Dlog (0;__ ("Esta función está temporalmente deshabilitada"))
End if 