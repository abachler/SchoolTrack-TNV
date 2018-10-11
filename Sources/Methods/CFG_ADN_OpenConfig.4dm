//%attributes = {}

C_BOOLEAN:C305($valor)

$valor:=LICENCIA_esModuloAutorizado (1;AdmissionNet)

If ($valor=True:C214)
	CFG_OpenConfigPanel (->[xxSTR_Constants:1];"ADN_Configuracion")
	PST_SaveParameters 
Else 
	CD_Dlog (1;__ ("Usted debe disponer de una Licencia para acceder a está área de la configuración."))
End if 
