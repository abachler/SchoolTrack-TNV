$PrevDoc:=[Personas:7]ACT_DocumentoTributario:45
WDW_OpenDialogInDrawer (->[Personas:7];"InputFactData_ACT")
If (ok=1)
	BLOB_Variables2Blob (->[Personas:7]ACT_Datos_de_Facturacion:44;0;->vRazonSocial;->vRUT;->vDireccion;->vComuna;->vCiudad;->vTelefono;->vGiro)
Else 
	[Personas:7]ACT_DocumentoTributario:45:=$PrevDoc
End if 