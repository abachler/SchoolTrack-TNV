//%attributes = {}
  //ACTdte_CargaEmisoresElectronico
TRACE:C157
  //antes de importar asegurarse que el archivo a leer contiene las columnas correctas. OJO que hay 3 empresas que tienen en el nombre el caracter ;

C_TEXT:C284($document;$t_contribuyentes)
C_BLOB:C604($xBlob)

If (USR_GetUserID <0)
	USE CHARACTER SET:C205("Latin1";0)
	$document:=xfGetFileName 
	If (ok=1)
		DOCUMENT TO BLOB:C525(document;$xBlob)
		$t_contribuyentes:=Convert to text:C1012($xBlob;"latin1")
		If ($t_contribuyentes#"")
			$l_estado:=WSsii_CargaEmisoresElectronicos ($t_contribuyentes)
		End if 
	End if 
	USE CHARACTER SET:C205(*;0)
End if 