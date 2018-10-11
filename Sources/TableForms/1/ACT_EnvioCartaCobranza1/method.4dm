Case of 
	: (Form event:C388=On Load:K2:1)
		ACTecc_OpcionesGenerales ("InicializaVariables")
		ARRAY TEXT:C222($atACTecc_eMail;0)
		C_LONGINT:C283($l_indice)
		ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
		SELECTION TO ARRAY:C260([Personas:7]No:1;alACTecc_ApoderadoID;[Personas:7]Apellidos_y_nombres:30;atACTecc_ApoderadoNombre;[Personas:7]ACT_modo_de_pago_new:95;atACTecc_ApoderadoModoPago;[Personas:7]DeudaVencida_Ejercicio:83;arACTecc_ApoderadoMontoVencido;[Personas:7]eMail:34;$atACTecc_eMail)
		
		For ($l_indice;1;Size of array:C274($atACTecc_eMail))
			If ((SMTP_VerifyEmailAddress ($atACTecc_eMail{$l_indice};False:C215)="") | (arACTecc_ApoderadoMontoVencido{$l_indice}=0))
				APPEND TO ARRAY:C911(alACTecc_Colores;16711680)
				APPEND TO ARRAY:C911(abACTecc_Enviar;False:C215)
			Else 
				APPEND TO ARRAY:C911(alACTecc_Colores;0)
				APPEND TO ARRAY:C911(abACTecc_Enviar;True:C214)
			End if 
		End for 
		
		ACTecc_OpcionesGenerales ("SetEstadoObjetos")
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		ACTecc_OpcionesGenerales ("SetEstadoObjetos")
		
End case 