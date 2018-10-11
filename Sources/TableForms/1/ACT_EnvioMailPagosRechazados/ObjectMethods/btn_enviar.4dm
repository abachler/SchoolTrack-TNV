C_BOOLEAN:C305($b_continuar)
ARRAY LONGINT:C221(alACTepr_ApoderadoID2Enviar;0)
ARRAY REAL:C219(arACTepr_ApoMontoRechaEnviar;0)
ARRAY TEXT:C222(atACTepr_EmailApoderadoEnviar;0)

For ($l_indice;1;Size of array:C274(abACTepr_Enviar))
	If (abACTepr_Enviar{$l_indice})  // si tiene mail, y esta marcada se agrega al arreglo final
		APPEND TO ARRAY:C911(alACTepr_ApoderadoID2Enviar;alACTepr_ApoderadoID{$l_indice})
		APPEND TO ARRAY:C911(arACTepr_ApoMontoRechaEnviar;arACTepr_ApoderadoMontoRechaza{$l_indice})
		APPEND TO ARRAY:C911(atACTepr_EmailApoderadoEnviar;atACTepr_EmailApoderado{$l_indice})
	End if 
End for 

If (Size of array:C274(alACTepr_ApoderadoID2Enviar)>0)
	If (b_Maileditado)
		$l_resp:=CD_Dlog (0;__ ("Se han modificado los correos electronicos.")+"\r\r"+__ ("¿Desea cambiar ?");"";__ ("Si");__ ("No"))
		If ($l_resp=1)
			For ($l_indice;1;Size of array:C274(alACTepr_ApoderadoID2Enviar))
				READ WRITE:C146([Personas:7])
				QUERY:C277([Personas:7];[Personas:7]No:1=alACTepr_ApoderadoID2Enviar{$l_indice})
				[Personas:7]eMail:34:=atACTepr_EmailApoderadoEnviar{$l_indice}
				SAVE RECORD:C53([Personas:7])
				KRL_UnloadReadOnly (->[Personas:7])
			End for 
		End if 
	End if 
	$l_resp:=CD_Dlog (0;__ ("Se enviará(n) ")+String:C10(Size of array:C274(alACTepr_ApoderadoID2Enviar))+__ (" correo(s) electrónico(s).")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
	If ($l_resp=1)
		ACCEPT:C269
	End if 
	
Else 
	CD_Dlog (0;__ ("No hay destinatarios para el envío de correos electrónicos."))
End if 