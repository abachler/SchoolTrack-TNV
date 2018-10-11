C_BOOLEAN:C305($b_continuar)
ARRAY LONGINT:C221(alACTdte_ID2Enviar;0)

For ($l_indice;1;Size of array:C274(abACTdte_Enviar))
	If (abACTdte_Enviar{$l_indice})
		APPEND TO ARRAY:C911(alACTdte_ID2Enviar;alACTdte_ID{$l_indice})
	End if 
End for 


If (Size of array:C274(alACTdte_ID2Enviar)>0)
	$l_resp:=CD_Dlog (0;__ ("Se enviará(n) ")+String:C10(Size of array:C274(alACTdte_ID2Enviar))+__ (" correo(s) electrónico(s).")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
	If ($l_resp=1)
		ACCEPT:C269
	End if 
Else 
	CD_Dlog (0;__ ("No hay destinatarios para el envío de correos electrónicos."))
End if 