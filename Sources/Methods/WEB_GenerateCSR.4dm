//%attributes = {}
C_TEXT:C284($dominio)

$dominio:=CD_Request (__ ("Por favor ingrese el nombre de dominio o dirección IP para certificar. Si usted desea asegurar https://www.colegio.cl debe ingresar www.colegio.cl");__ ("Aceptar");__ ("Cancelar");"";"127.0.0.1")
If ($dominio#"")
	WEB_GenerateCertificate ($dominio)
Else 
	If (cdB_btn1=1)
		CD_Dlog (0;__ ("Es necesario ingresar el nombre de dominio o dirección IP para poder generar el certificado."))
	End if 
End if 