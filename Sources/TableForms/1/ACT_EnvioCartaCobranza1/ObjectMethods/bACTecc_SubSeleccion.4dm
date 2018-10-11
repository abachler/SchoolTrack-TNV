
ARRAY LONGINT:C221($alACT_seleccionados;0)
lb_ACTecc_Apoderados{0}:=True:C214
AT_SearchArray (->lb_ACTecc_Apoderados;"=";->$alACT_seleccionados)
If (Size of array:C274($alACT_seleccionados)>0)
	
	ARRAY TEXT:C222($atACTecc_ApoderadoNombre;0)
	ARRAY TEXT:C222($atACTecc_ApoderadoModoPago;0)
	ARRAY REAL:C219($arACTecc_ApoderadoMontoVencido;0)
	ARRAY LONGINT:C221($alACTecc_ApoderadoID;0)
	ARRAY LONGINT:C221($alACTecc_Colores;0)
	ARRAY BOOLEAN:C223($abACTecc_Enviar;0)
	
	COPY ARRAY:C226(atACTecc_ApoderadoNombre;$atACTecc_ApoderadoNombre)
	COPY ARRAY:C226(atACTecc_ApoderadoModoPago;$atACTecc_ApoderadoModoPago)
	COPY ARRAY:C226(arACTecc_ApoderadoMontoVencido;$arACTecc_ApoderadoMontoVencido)
	COPY ARRAY:C226(alACTecc_ApoderadoID;$alACTecc_ApoderadoID)
	COPY ARRAY:C226(alACTecc_Colores;$alACTecc_Colores)
	COPY ARRAY:C226(abACTecc_Enviar;$abACTecc_Enviar)
	
	AT_Initialize (->atACTecc_ApoderadoNombre;->atACTecc_ApoderadoModoPago;->arACTecc_ApoderadoMontoVencido;->alACTecc_ApoderadoID;->alACTecc_Colores;->abACTecc_Enviar)
	
	For ($l_indice;1;Size of array:C274($alACT_seleccionados))
		APPEND TO ARRAY:C911(atACTecc_ApoderadoNombre;$atACTecc_ApoderadoNombre{$alACT_seleccionados{$l_indice}})
		APPEND TO ARRAY:C911(atACTecc_ApoderadoModoPago;$atACTecc_ApoderadoModoPago{$alACT_seleccionados{$l_indice}})
		APPEND TO ARRAY:C911(arACTecc_ApoderadoMontoVencido;$arACTecc_ApoderadoMontoVencido{$alACT_seleccionados{$l_indice}})
		APPEND TO ARRAY:C911(alACTecc_ApoderadoID;$alACTecc_ApoderadoID{$alACT_seleccionados{$l_indice}})
		APPEND TO ARRAY:C911(alACTecc_Colores;$alACTecc_Colores{$alACT_seleccionados{$l_indice}})
		APPEND TO ARRAY:C911(abACTecc_Enviar;$abACTecc_Enviar{$alACT_seleccionados{$l_indice}})
		
	End for 
End if 